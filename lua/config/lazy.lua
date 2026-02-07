local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{ import = "config.plugins.blink" },
		{ import = "config.plugins.colorizer" },
		{ import = "config.plugins.aerial" },
		{ import = "config.plugins.comment" },
		{ import = "config.plugins.conform" },
		{ import = "config.plugins.flash" },
		{ import = "config.plugins.lsp" },
		{ import = "config.plugins.lualine" },
		{ import = "config.plugins.mini" },
		{ import = "config.plugins.neodev" },
		{ import = "config.plugins.nvim-surround" },
		-- { import = "config.plugins.orgmode" },
		{ import = "config.plugins.persisted" },
		{ import = "config.plugins.render-markdown" },
		{ import = "config.plugins.smart-splits" },
		{ import = "config.plugins.snacks" },
		-- { import = "config.plugins.noice" },
		{ import = "config.plugins.splitjoin" },
		{ import = "config.plugins.tabout" },
		{ import = "config.plugins.theme" },
		{ import = "config.plugins.toggleterm" },
		{ import = "config.plugins.treesitter" },
		{ import = "config.plugins.ultimate-autopairs" },
		{ import = "config.plugins.vim-repeat" },
		{ import = "config.plugins.whichkey" },
		{ import = "config.plugins.rustacean" },
		{ import = "config.plugins.todo-comments" },
		{ import = "config.plugins.trouble" },
	},
	install = { colorscheme = { "habamax" } },
	checker = { enabled = true },
})
