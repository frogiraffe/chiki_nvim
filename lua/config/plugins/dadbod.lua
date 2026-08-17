return {
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{
				"kristijanhusak/vim-dadbod-completion",
				ft = { "sql", "mysql", "plsql" },
				lazy = true,
			},
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		keys = {
			{ "<leader>db", "<cmd>DBUIToggle<cr>", desc = "[D]atabase UI" },
			{ "<leader>da", "<cmd>DBUIAddConnection<cr>", desc = "[D]atabase [A]dd connection" },
			{ "<leader>df", "<cmd>DBUIFindBuffer<cr>", desc = "[D]atabase [F]ind buffer" },
		},
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},
}
