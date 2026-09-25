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

-- Leaders and core options must exist before lazy.nvim evaluates plugin specs.
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.have_nerd_font = true

-- Configure Neovim itself before eager plugins initialise. This keeps plugin
-- setup deterministic (PATH, UI options, clipboard behaviour, etc.).
require("config.options")
require("config.machine")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")

-- :NvimUpdate is rarely used, so its implementation is only required on first
-- invocation instead of being parsed on every startup.
vim.api.nvim_create_user_command("NvimUpdate", function()
	require("config.update").update()
end, {
	desc = "Safely sync this Neovim config with GitHub without reviving stale machine edits",
})
