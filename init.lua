if vim.env.PROF then
	-- Add Snacks to the runtime path early so startup profiling can begin
	-- before lazy.nvim has loaded the rest of the plugin graph.
	local snacks = vim.fn.stdpath("data") .. "/lazy/snacks.nvim"
	vim.opt.rtp:append(snacks)
	require("snacks.profiler").startup({
		startup = {
			event = "VimEnter",
		},
	})
end

-- Leaders must exist before lazy.nvim evaluates plugin specs (LazyVim resets
-- maplocalleader to "\" in its own options, config/options.lua restores ",").
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Bootstrap lazy.nvim + LazyVim. LazyVim loads config/options.lua before any
-- plugin, then config/autocmds.lua and config/keymaps.lua on VeryLazy.
require("config.lazy")

-- :NvimUpdate is rarely used, so its 400-line implementation is only required
-- on first invocation instead of on every startup.
vim.api.nvim_create_user_command("NvimUpdate", function()
	require("config.update").update()
end, {
	desc = "Safely sync this Neovim config with GitHub without reviving stale machine edits",
})
