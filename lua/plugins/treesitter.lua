-- LazyVim handles parser installation, highlighting, indents and folds.
-- LaTeX highlighting stays with VimTeX (lang.tex extra disables it).
return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"bibtex",
				"c",
				"cpp",
				"css",
				"csv",
				"dockerfile",
				"go",
				"latex",
				"r",
				"rnoweb",
				"ron",
				"rust",
				"sql",
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		opts = {
			-- mini.bracketed owns ]f ]c ]a ... (file, comment, argument, etc.).
			-- Textobjects are still used by mini.ai (af/if, ac/ic, ao/io).
			move = { enable = false },
		},
	},
}
