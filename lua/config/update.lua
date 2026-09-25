local M = {}

local config_dir = vim.fn.stdpath("config")
local uv = vim.uv or vim.loop
local running = false

local function trim(value)
	return vim.trim(value or "")
end

local function notify(message, level)
	vim.notify(message, level or vim.log.levels.INFO, { title = "NvimUpdate" })
end

local function git(args, callback)
	local command = { "git", "-C", config_dir }
	vim.list_extend(command, args)

	vim.system(command, { text = true }, function(result)
		vim.schedule(function()
			callback(result)
		end)
	end)
end

local function result_detail(result)
	local detail = trim(result.stderr)
	if detail == "" then
		detail = trim(result.stdout)
	end
	if detail == "" then
		detail = "git command failed"
	end
	return detail
end

local function failed(result, prefix)
	notify(prefix .. ": " .. result_detail(result), vim.log.levels.ERROR)
	running = false
end

local function parse_nul_list(output)
	local values = {}
	for _, value in ipairs(vim.split(output or "", "\0", { plain = true, trimempty = true })) do
		values[value] = true
	end
	return values
end

local function sorted_keys(values)
	local keys = {}
	for key in pairs(values) do
		table.insert(keys, key)
	end
	table.sort(keys)
	return keys
end

local function intersection(left, right)
	local values = {}
	for key in pairs(left) do
		if right[key] then
			values[key] = true
		end
	end
	return values
end

local function collect_dirty_paths(callback)
	git({ "diff", "--name-only", "-z", "HEAD" }, function(tracked_result)
		if tracked_result.code ~= 0 then
			failed(tracked_result, "Could not inspect tracked config changes")
			return
		end

		git({ "ls-files", "--others", "--exclude-standard", "-z" }, function(untracked_result)
			if untracked_result.code ~= 0 then
				failed(untracked_result, "Could not inspect untracked config files")
				return
			end

			local paths = parse_nul_list(tracked_result.stdout)
			for path in pairs(parse_nul_list(untracked_result.stdout)) do
				paths[path] = true
			end
			callback(paths)
		end)
	end)
end

local function stash_local_changes(paths, callback)
	if next(paths) == nil then
		callback(nil)
		return
	end

	local hostname = (uv.os_gethostname and uv.os_gethostname()) or "unknown-host"
	local label = string.format("NvimUpdate safety stash from %s at %s", hostname, os.date("%Y-%m-%d %H:%M:%S"))

	git({ "stash", "push", "--include-untracked", "-m", label }, function(stash_result)
		if stash_result.code ~= 0 then
			failed(stash_result, "Could not create safety stash")
			return
		end

		git({ "rev-parse", "refs/stash" }, function(ref_result)
			if ref_result.code ~= 0 then
				notify(
					"Safety stash was created but its SHA could not be read. Your changes remain in git stash; inspect `git stash list` before continuing.",
					vim.log.levels.ERROR
				)
				running = false
				return
			end

			callback({
				ref = "stash@{0}",
				sha = trim(ref_result.stdout),
				label = label,
			})
		end)
	end)
end

local function drop_stash(stash, callback)
	if not stash then
		callback()
		return
	end

	git({ "stash", "drop", stash.ref }, function(drop_result)
		if drop_result.code ~= 0 then
			notify(
				"Config was restored, but the safety stash could not be dropped automatically: " .. result_detail(drop_result),
				vim.log.levels.WARN
			)
		end
		callback()
	end)
end

local function restore_stash(stash, callback)
	if not stash then
		callback(true)
		return
	end

	git({ "stash", "apply", "--index", stash.sha }, function(apply_result)
		if apply_result.code ~= 0 then
			notify(
				"Could not reapply the safety stash cleanly. Nothing in the stash was deleted. Resolve the working-tree conflict manually; stash copy: "
					.. stash.ref,
				vim.log.levels.ERROR
			)
			running = false
			callback(false)
			return
		end

		drop_stash(stash, function()
			callback(true)
		end)
	end)
end

local function fail_and_restore(stash, result, prefix)
	restore_stash(stash, function(restored)
		if restored then
			failed(result, prefix .. "; pre-update local changes were restored")
		end
	end)
end

local function commit_worktree(callback)
	git({ "status", "--porcelain" }, function(status_result)
		if status_result.code ~= 0 then
			failed(status_result, "Could not inspect config changes")
			return
		end

		if trim(status_result.stdout) == "" then
			callback()
			return
		end

		git({ "add", "-A" }, function(add_result)
			if add_result.code ~= 0 then
				failed(add_result, "Could not stage local config changes")
				return
			end

			local hostname = (uv.os_gethostname and uv.os_gethostname()) or "unknown-host"
			local message = string.format("chore(nvim): sync from %s at %s", hostname, os.date("%Y-%m-%d %H:%M:%S"))

			git({ "commit", "-m", message }, function(commit_result)
				if commit_result.code ~= 0 then
					failed(commit_result, "Could not commit local config changes")
					return
				end
				callback()
			end)
		end)
	end)
end

local function push_branch(branch, callback)
	git({ "push", "-u", "origin", branch }, function(push_result)
		if push_result.code ~= 0 then
			failed(push_result, "Could not push config; rerun :NvimUpdate after checking Git status")
			return
		end
		callback()
	end)
end

local function finish(branch, message)
	push_branch(branch, function()
		git({ "rev-parse", "--short", "HEAD" }, function(short_result)
			local revision = short_result.code == 0 and trim(short_result.stdout) or "updated"
			notify((message or "Config synced") .. " at " .. revision .. ". Restart Neovim to load config changes.")
			running = false
		end)
	end)
end

local function finish_with_local_changes(branch, stash, message)
	restore_stash(stash, function(restored)
		if not restored then
			return
		end

		commit_worktree(function()
			finish(branch, message)
		end)
	end)
end

local function recover_after_failed_rebase(stash)
	git({ "rebase", "--abort" }, function(abort_result)
		if abort_result.code ~= 0 then
			failed(abort_result, "Rebase failed and could not be aborted automatically")
			return
		end

		restore_stash(stash, function(restored)
			if restored then
				notify(
					"Remote and committed local history conflict. Rebase was aborted and your pre-update working-tree changes were restored. Resolve the Git history conflict manually, then rerun :NvimUpdate.",
					vim.log.levels.ERROR
				)
				running = false
			end
		end)
	end)
end

local function remote_changed_paths(base_sha, remote_ref, stash, callback)
	git({ "diff", "--name-only", "-z", base_sha .. "..." .. remote_ref }, function(diff_result)
		if diff_result.code ~= 0 then
			fail_and_restore(stash, diff_result, "Could not compare remote changes with the local base")
			return
		end
		callback(parse_nul_list(diff_result.stdout))
	end)
end

local function sync_clean_history(branch, local_sha, remote_ref, stash, dirty_paths, remote_paths)
	git({ "rev-parse", remote_ref }, function(remote_result)
		if remote_result.code ~= 0 then
			fail_and_restore(stash, remote_result, "Could not read remote revision")
			return
		end

		local remote_sha = trim(remote_result.stdout)
		local overlap = intersection(dirty_paths, remote_paths)

		local function after_history_sync()
			if next(overlap) ~= nil and stash then
				local paths = sorted_keys(overlap)
				local preview = table.concat(vim.list_slice(paths, 1, math.min(#paths, 6)), ", ")
				if #paths > 6 then
					preview = preview .. string.format(" (+%d more)", #paths - 6)
				end

				finish(branch, "Git history synced; overlapping local edits kept in " .. stash.ref)
				notify(
					"Remote changed the same path(s) as your uncommitted edits, so the remote versions were kept and the local copies were not reapplied: "
						.. preview
						.. ". Inspect/recover them from "
						.. stash.ref
						.. ".",
					vim.log.levels.WARN
				)
				return
			end

			finish_with_local_changes(branch, stash, "Config synced")
		end

		if local_sha == remote_sha then
			after_history_sync()
			return
		end

		git({ "merge-base", local_sha, remote_ref }, function(base_result)
			if base_result.code ~= 0 then
				fail_and_restore(stash, base_result, "Could not compare local and remote history")
				return
			end

			local merge_base = trim(base_result.stdout)

			if merge_base == local_sha then
				git({ "merge", "--ff-only", remote_ref }, function(merge_result)
					if merge_result.code ~= 0 then
						fail_and_restore(stash, merge_result, "Could not fast-forward config")
						return
					end
					after_history_sync()
				end)
			elseif merge_base == remote_sha then
				-- Local committed history is strictly newer than the remote.
				after_history_sync()
			else
				git({ "rebase", remote_ref }, function(rebase_result)
					if rebase_result.code ~= 0 then
						recover_after_failed_rebase(stash)
						return
					end
					after_history_sync()
				end)
			end
		end)
	end)
end

local function sync_branch(branch, local_sha, stash, dirty_paths)
	local remote_ref = "origin/" .. branch

	git({ "rev-parse", "--verify", remote_ref }, function(remote_check)
		if remote_check.code ~= 0 then
			finish_with_local_changes(branch, stash, "Config published")
			return
		end

		remote_changed_paths(local_sha, remote_ref, stash, function(remote_paths)
			sync_clean_history(branch, local_sha, remote_ref, stash, dirty_paths, remote_paths)
		end)
	end)
end

function M.update()
	if running then
		notify("A config sync is already running.", vim.log.levels.WARN)
		return
	end

	running = true
	notify("Syncing Neovim config with GitHub…")

	git({ "rev-parse", "--is-inside-work-tree" }, function(repo_result)
		if repo_result.code ~= 0 or trim(repo_result.stdout) ~= "true" then
			failed(repo_result, config_dir .. " is not a Git worktree")
			return
		end

		git({ "branch", "--show-current" }, function(branch_result)
			local branch = trim(branch_result.stdout)
			if branch_result.code ~= 0 or branch == "" then
				failed(branch_result, "Detached HEAD is not supported")
				return
			end

			git({ "rev-parse", "HEAD" }, function(head_result)
				if head_result.code ~= 0 then
					failed(head_result, "Could not read local revision")
					return
				end

				local local_sha = trim(head_result.stdout)

				collect_dirty_paths(function(dirty_paths)
					stash_local_changes(dirty_paths, function(stash)
						git({ "fetch", "--prune", "origin" }, function(fetch_result)
							if fetch_result.code ~= 0 then
								fail_and_restore(stash, fetch_result, "Could not fetch GitHub")
								return
							end

							sync_branch(branch, local_sha, stash, dirty_paths)
						end)
					end)
				end)
			end)
		end)
	end)
end

return M
