local sql_ft = { "sql", "mysql", "plsql" }

-- Avoid Neovim's legacy SQL omni-completion fighting Blink/Dadbod while still
-- keeping syntax keyword completion available to the Dadbod source.
vim.g.omni_sql_default_compl_type = "syntax"
vim.g.loaded_sql_completion = true

return {
	{
		"tpope/vim-dadbod",
		cmd = "DB",
	},
	{
		"kristijanhusak/vim-dadbod-completion",
		dependencies = { "tpope/vim-dadbod" },
		ft = sql_ft,
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			"tpope/vim-dadbod",
			"kristijanhusak/vim-dadbod-completion",
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
			local data_path = vim.fn.stdpath("data")
			vim.g.db_ui_auto_execute_table_helpers = 1
			vim.g.db_ui_save_location = data_path .. "/dadbod_ui"
			vim.g.db_ui_tmp_query_location = data_path .. "/dadbod_ui/tmp"
			vim.g.db_ui_show_database_icon = true
			vim.g.db_ui_use_nerd_fonts = 1

			-- Saving a query buffer should never execute it implicitly. Dadbod UI's
			-- buffer-local <leader>S remains the explicit execution path.
			vim.g.db_ui_execute_on_save = false
		end,
	},
}
