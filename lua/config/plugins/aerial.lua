return {
	{
		"stevearc/aerial.nvim",
		cmd = { "AerialToggle", "AerialOpen", "AerialClose", "AerialNavToggle" },
		keys = {
			{ "<leader>oa", "<cmd>AerialToggle!<cr>", desc = "Toggle Aerial (Outline)" },
			{
				"<leader>os",
				function()
					require("aerial").snacks_picker()
				end,
				desc = "Search Symbols (Aerial)",
			},
		},
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			attach_mode = "global",
			backends = { "lsp", "treesitter", "markdown", "man" },
			show_guides = true,
			layout = {
				resize_to_content = false,
			},
		},
	},
}
