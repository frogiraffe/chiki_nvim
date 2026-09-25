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

-- LazyVim's "LazyFile" event: fires for real files (read, new or about to be
-- written) but never for the empty dashboard, so file-only plugins (LSP,
-- Treesitter, linting, ...) stay off the startup path.
require("lazy.core.handler.event").mappings.LazyFile = {
	id = "LazyFile",
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
}

require("lazy").setup({
	-- Every plugin spec in lua/plugins is imported automatically.
	spec = {
		{ import = "plugins" },
	},
	defaults = {
		-- Plugins are lazy unless a spec says otherwise: every spec declares
		-- the event, filetype, command or key that loads it.
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
