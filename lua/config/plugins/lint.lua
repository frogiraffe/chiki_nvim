local sql_ft = { "sql", "mysql", "plsql" }

return {
	{
		"mfussenegger/nvim-lint",
		ft = sql_ft,
		config = function()
			local lint = require("lint")
			lint.linters_by_ft.sql = { "sqlfluff" }
			lint.linters_by_ft.mysql = { "sqlfluff" }
			lint.linters_by_ft.plsql = { "sqlfluff" }

			-- Use a portable default; projects can override the dialect in their
			-- own .sqlfluff configuration when vendor-specific SQL is required.
			lint.linters.sqlfluff.args = {
				"lint",
				"--dialect=ansi",
				"--format=json",
				"-",
			}

			local group = vim.api.nvim_create_augroup("chiki_sql_lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
				group = group,
				callback = function(event)
					if vim.tbl_contains(sql_ft, vim.bo[event.buf].filetype) then
						lint.try_lint()
					end
				end,
			})
		end,
	},
}
