-- LazyVim already maps <leader>xx/xX/cs/xL/xQ to Trouble.
return {
	{
		"folke/trouble.nvim",
		keys = {
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
		},
	},
}
