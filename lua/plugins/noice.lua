return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		-- Neovide renders messages itself via ext_messages; noice can't attach there
		cond = not vim.g.neovide,
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				},
				signature = {
					enabled = false, -- blink.cmp handles signature help
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = true,
			},
		},
	},
}
