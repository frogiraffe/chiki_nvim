return {
	"lervag/vimtex",
	lazy = false,
	ft = { "tex", "latex", "bib" },
	keys = {
		{ "<leader>K", "<plug>(vimtex-doc-package)", desc = "VimTeX Package Docs", ft = { "tex", "latex" } },
	},
	init = function()
		-- VimTeX global options must be set before the plugin loads.
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_compiler_method = "latexmk"

		-- Keep K available for Texlab/LSP hover. Package documentation remains
		-- available explicitly on <leader>K.
		vim.g.vimtex_mappings_disable = { n = { "K" } }

		vim.g.vimtex_quickfix_mode = 2
		vim.g.vimtex_quickfix_open_on_warning = 0

		vim.g.vimtex_delim_toggle_mod_list = {
			{ "\\left", "\\right" },
			{ "\\big", "\\big" },
			{ "\\Big", "\\Big" },
			{ "\\bigg", "\\bigg" },
			{ "\\Bigg", "\\Bigg" },
		}

		-- LuaSnip owns insert-mode snippets/mappings.
		vim.g.vimtex_imaps_enabled = 0
		vim.g.vimtex_syntax_conceal_disable = 1
		vim.g.tex_flavor = "latex"
	end,
}
