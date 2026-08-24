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

local function failed(result, prefix)
	local detail = trim(result.stderr)
	if detail == "" then
		detail = trim(result.stdout)
	end
	if detail == "" then
		detail = "git command failed"
	end
	notify(prefix .. ": " .. detail, vim.log.levels.ERROR)
	running = false
end

local function sync_branch(branch)
	local remote_ref = "origin/" .. branch

	git({ "rev-parse", "--verify", remote_ref }, function(remote_check)
		if remote_check.code ~= 0 then
			git({ "push", "-u", "origin", branch }, function(push_result)
				if push_result.code ~= 0 then
					failed(push_result, "Could not publish branch")
					return
				end

				notify("Config published to GitHub. Restart Neovim to load config changes.")
				running = false
			end)
			return
		end

		git({ "rev-parse", "HEAD" }, function(local_result)
			if local_result.code ~= 0 then
				failed(local_result, "Could not read local revision")
				return
			end

			git({ "rev-parse", remote_ref }, function(remote_result)
				if remote_result.code ~= 0 then
					failed(remote_result, "Could not read remote revision")
					return
				end

				local local_sha = trim(local_result.stdout)
				local remote_sha = trim(remote_result.stdout)

				local function push_current()
					git({ "push", "-u", "origin", branch }, function(push_result)
						if push_result.code ~= 0 then
							failed(push_result, "Could not push config")
							return
						end

						git({ "rev-parse", "--short", "HEAD" }, function(short_result)
							local revision = short_result.code == 0 and trim(short_result.stdout) or "updated"
							notify("Config synced at " .. revision .. ". Restart Neovim to load config changes.")
							running = false
						end)
					end)
				end

				if local_sha == remote_sha then
					push_current()
					return
				end

				git({ "merge-base", "HEAD", remote_ref }, function(base_result)
					if base_result.code ~= 0 then
						failed(base_result, "Could not compare local and remote history")
						return
					end

					local base_sha = trim(base_result.stdout)

					if base_sha == local_sha then
						-- Remote is strictly newer. Fast-forward without creating a merge commit.
						git({ "merge", "--ff-only", remote_ref }, function(merge_result)
							if merge_result.code ~= 0 then
								failed(merge_result, "Could not fast-forward config")
								return
							end
							push_current()
						end)
					elseif base_sha == remote_sha then
						-- Local is strictly newer; publish it.
						push_current()
					else
						-- Both machines have commits. Rebase preserves both histories when they
						-- touch different areas instead of trusting unreliable wall-clock mtimes.
						git({ "rebase", remote_ref }, function(rebase_result)
							if rebase_result.code == 0 then
								push_current()
								return
							end

							git({ "rebase", "--abort" }, function()
								notify(
									"Desktop/laptop changes conflict on the same lines. Nothing was discarded; resolve the Git conflict manually and run :NvimUpdate again.",
									vim.log.levels.ERROR
								)
								running = false
							end)
						end)
					end
				end)
			end)
		end)
	end)
end

local function commit_local_changes(callback)
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

			commit_local_changes(function()
				git({ "fetch", "--prune", "origin" }, function(fetch_result)
					if fetch_result.code ~= 0 then
						failed(fetch_result, "Could not fetch GitHub")
						return
					end
					sync_branch(branch)
				end)
			end)
		end)
	end)
end

vim.api.nvim_create_user_command("NvimUpdate", M.update, {
	desc = "Bidirectionally sync this Neovim config with GitHub",
})

return M
