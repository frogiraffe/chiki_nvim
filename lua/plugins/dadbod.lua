-- The lang.sql extra sets up vim-dadbod, -ui and -completion (blink source,
-- no execute-on-save, legacy SQL omni-completion disabled). Personal keys and
-- dashboard handling live here.
local sql_ft = { "sql", "mysql", "plsql" }

return {
	{
		"kristijanhusak/vim-dadbod-ui",
		keys = {
			{ "<leader>db", "<cmd>DBUIToggle<cr>", desc = "[D]atabase UI" },
			{ "<leader>da", "<cmd>DBUIAddConnection<cr>", desc = "[D]atabase [A]dd connection" },
			{ "<leader>df", "<cmd>DBUIFindBuffer<cr>", desc = "[D]atabase [F]ind buffer" },
		},
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1

			-- Dadbod UI intentionally avoids `nofile` windows when looking for an
			-- editor target. Snacks' startup dashboard is a `nofile` buffer, so with
			-- only DBUI + dashboard visible Dadbod creates a third split and leaves
			-- the dashboard in the middle. Once a real DBUI query opens, close that
			-- startup-only dashboard so the query naturally occupies the work area.
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("chiki_dadbod_dashboard", { clear = true }),
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
