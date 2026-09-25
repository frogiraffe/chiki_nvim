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

require("lazy").setup({
	spec = {
		-- LazyVim provides the base: core plugins, options, autocmds, keymaps,
		-- LSP/format/lint plumbing and lazy-loading defaults. Everything in
		-- lua/plugins/ only overrides or extends it.
		{
			"LazyVim/LazyVim",
			import = "lazyvim.plugins",
			opts = {
				colorscheme = "minisummer",
				news = { lazyvim = false, neovim = false },
			},
		},

		-- Extras are imported here (instead of via :LazyExtras / lazyvim.json)
		-- so the whole setup is reproducible from git on every machine.
		{ import = "lazyvim.plugins.extras.coding.luasnip" },
		{ import = "lazyvim.plugins.extras.editor.mini-diff" },
		{ import = "lazyvim.plugins.extras.lang.json" },
		{ import = "lazyvim.plugins.extras.lang.python" },
		{ import = "lazyvim.plugins.extras.lang.sql" },
		{ import = "lazyvim.plugins.extras.lang.tex" },
		{ import = "lazyvim.plugins.extras.lang.toml" },
		{ import = "lazyvim.plugins.extras.lang.yaml" },

		-- Personal plugins and overrides.
		{ import = "plugins" },
	},
	defaults = {
		-- Custom plugins are lazy by default: every spec must say when it loads.
		lazy = true,
		version = false,
	},
	-- None of the current plugins require LuaRocks. Disabling this prevents Lazy
	-- from provisioning/checking hererocks and keeps :checkhealth clean.
	rocks = { enabled = false },
	install = { colorscheme = { "minisummer", "habamax" } },
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
