local markdown_filetypes = { "markdown", "markdown.mdx", "rmd", "quarto", "codecompanion" }

return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = markdown_filetypes,
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			-- In-process LSP is the recommended source (works with blink.cmp).
			completions = { lsp = { enabled = true } },
		},
	},
}
