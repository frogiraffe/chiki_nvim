return {
	-- Lua
	{
		"olimorris/persisted.nvim",
		event = "BufReadPre", -- Ensure the plugin loads only when a buffer has been loaded
		opts = {
			-- Your config goes here ...
		},
		init = function()
			-- tmux-resurrect restarts a pane's Neovim as plain `nvim`; started within two minutes
			-- of a restore (@restored-at, set by ~/.config/tmux/tmux.conf), it opens the folder's
			-- session instead of an empty editor.
			vim.api.nvim_create_autocmd("VimEnter", {
				once = true,
				callback = function()
					if vim.fn.argc() ~= 0 or not vim.env.TMUX then
						return
					end
					local out = vim.system({ "tmux", "show", "-gqv", "@restored-at" }, { text = true }):wait()
					local at = tonumber(vim.trim(out.stdout or ""))
					if at and os.time() - at < 120 then
						require("persisted").load()
					end
				end,
			})
			-- persisted saves on exit only; a crash or a reboot that kills Neovim skips that, so
			-- also save while working, at most every 30 seconds.
			local last = 0
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
				callback = function()
					if not vim.g.persisting or vim.g.SessionLoad then
						return
					end
					local now = vim.uv.now()
					if now - last < 30000 then
						return
					end
					last = now
					require("persisted").save({ auto = true })
				end,
			})
		end,
	},
}
