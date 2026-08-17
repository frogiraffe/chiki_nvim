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

			local function lint_sql(buf)
				if vim.api.nvim_buf_is_valid(buf) and vim.tbl_contains(sql_ft, vim.bo[buf].filetype) then
					lint.try_lint()
				end
			end

			local group = vim.api.nvim_create_augroup("chiki_sql_lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
				group = group,
				callback = function(event)
					lint_sql(event.buf)
				end,
			})

			-- Depending on event ordering, the FileType trigger may load nvim-lint
			-- after BufReadPost. Cover that first buffer explicitly.
			vim.schedule(function()
				lint_sql(vim.api.nvim_get_current_buf())
			end)
		end,
	},
}
