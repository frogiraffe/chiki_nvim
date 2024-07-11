vim.loader.enable()
vim.g.mapleader = " "
vim.g.maplocalleader = " "
require("chiki.set")
require("chiki.remap")
-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
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
	vim.o.guifont = "FiraCode Nerd Font:h14"
	vim.g.neovide_cursor_animate_in_insert_mode = true
	vim.g.neovide_transparency = 0.8
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	{ import = "chiki.plugins" },
})
