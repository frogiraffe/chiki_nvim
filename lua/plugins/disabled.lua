-- LazyVim core plugins replaced by this config's own choices.
return {
	-- No buffer tabline: buffers are navigated with pickers/<leader>bb.
	{ "akinsho/bufferline.nvim", enabled = false },
	-- persisted.nvim owns sessions (see persisted.lua).
	{ "folke/persistence.nvim", enabled = false },
	-- The colorscheme is minisummer (mini.hues); skip installing the defaults.
	{ "folke/tokyonight.nvim", enabled = false },
	{ "catppuccin/nvim", enabled = false },
}
