return {
	"lervag/vimtex",
	lazy = false,
	ft = { "tex", "latex", "bib" },
	init = function()
		-- VimTeX global options must be set BEFORE the plugin loads (in init, not config)

		-- Use Zathura as the PDF viewer (SyncTeX forward/inverse search)
		vim.g.vimtex_view_method = "zathura"

		-- Use latexmk as the compiler backend (default, but explicit is better)
		vim.g.vimtex_compiler_method = "latexmk"

		-- -- latexmk compiler options
		-- vim.g.vimtex_compiler_latexmk = {
		-- 	options = {
		-- 		"-pdf",
		-- 		"-shell-escape",
		-- 		"-verbose",
		-- 		"-file-line-error",
		-- 		"-synctex=1",
		-- 		"-interaction=nonstopmode",
		-- 	},
		-- }

		-- Don't open QuickFix on warnings, only on errors
		vim.g.vimtex_quickfix_mode = 2
		vim.g.vimtex_quickfix_open_on_warning = 0

		-- Delimiter toggle list — adds \big variants alongside \left/\right
		vim.g.vimtex_delim_toggle_mod_list = {
			{ "\\left", "\\right" },
			{ "\\big", "\\big" },
			{ "\\Big", "\\Big" },
			{ "\\bigg", "\\bigg" },
			{ "\\Bigg", "\\Bigg" },
		}

		-- Disable VimTeX's insert mode mappings (we use LuaSnip instead)
		vim.g.vimtex_imaps_enabled = 0

		-- Ensure VimTeX doesn't conceal LaTeX symbols in editor
		vim.g.vimtex_syntax_conceal_disable = 1

		-- Set tex flavor for .tex files
		vim.g.tex_flavor = "latex"
	end,
}
