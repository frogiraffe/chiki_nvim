return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		event = "VeryLazy",
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
		config = function()
			-- require("render-markdown").setup({
			-- 	completions = { lsp = { enabled = true } },
			-- })
			require("render-markdown").setup({
				completions = { blink = { enabled = true } },
			})
		end,
	},
}
