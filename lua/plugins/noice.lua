return {
	{
		"folke/noice.nvim",
		keys = {
			-- <leader>sn is "Notification History"; LazyVim's <leader>sn* Noice
			-- keys would turn it into a prefix and delay it.
			{ "<leader>sn", false },
			{ "<leader>snl", false },
			{ "<leader>snh", false },
			{ "<leader>sna", false },
			{ "<leader>snd", false },
			{ "<leader>snt", false },
		},
		opts = {
			lsp = {
				signature = {
					enabled = false, -- blink.cmp handles signature help
				},
			},
			presets = {
				lsp_doc_border = true,
			},
		},
	},
}
