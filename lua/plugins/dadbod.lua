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

			-- Dadbod UI intentionally avoids `nofile` windows when looking for an
			-- editor target. Snacks' startup dashboard is a `nofile` buffer, so with
			-- only DBUI + dashboard visible Dadbod creates a third split and leaves
			-- the dashboard in the middle. Once a real DBUI query opens, close that
			-- startup-only dashboard so the query naturally occupies the work area.
			local group = vim.api.nvim_create_augroup("chiki_dadbod_dashboard", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				group = group,
				pattern = sql_ft,
				callback = function(event)
					if not vim.b[event.buf].dbui_db_key_name then
						return
					end
					vim.schedule(function()
						for _, win in ipairs(vim.api.nvim_list_wins()) do
							if vim.api.nvim_win_is_valid(win) then
								local buf = vim.api.nvim_win_get_buf(win)
								if vim.bo[buf].filetype == "snacks_dashboard" then
									pcall(vim.api.nvim_win_close, win, true)
								end
							end
						end
					end)
				end,
			})
		end,
	},
}
