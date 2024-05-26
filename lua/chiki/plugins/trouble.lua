return {
	"folke/trouble.nvim",
	cmd = { "TroubleToggle", "Trouble" },
	branch = "dev",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	keys = {
		{
			"<leader>xx",
			"<cmd>TroubleToggle<cr>",
			{ desc = "Trouble Toggle" },
			{ silent = true, noremap = true },
		},
		{
			"<leader>xw",
			"<cmd>TroubleToggle workspace_diagnostics<cr>",
			{ desc = "Trouble Workspace" },
			{ silent = true, noremap = true },
		},
		{
			"<leader>xd",
			"<cmd>TroubleToggle document_diagnostics<cr>",
			{ desc = "Trouble Document" },
			{ silent = true, noremap = true },
		},
	},
}
