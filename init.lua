vim.loader.enable()
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.g.maplocalleader = " "
vim.g.python3_host_prog = vim.fn.expand("~/.config/nvim/.venv/bin/python3")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath, })
end

if vim.g.neovide then
	vim.o.guifont = "Iosevka:h14"
	vim.g.neovide_cursor_animate_in_insert_mode = true
	vim.g.neovide_opacity = 0.8
	vim.keymap.set('v', '<D-c>', '"+y')      -- Copy
	vim.keymap.set('n', '<C-S-v>', '"+P')    -- Paste normal mode
	vim.keymap.set('v', '<C-S-v>', '"+P')    -- Paste visual mode
	vim.keymap.set('c', '<D-v>', '<C-R>+')   -- Paste command mode
	vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
	-- vim.opt.clipboard = "unnamedplus"
end






vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	{ import = "chiki.plugins" },
}, {
	experimental = {
		check_rtp_message = false
	}
})
require("chiki.autocommand")
require("chiki.set")
