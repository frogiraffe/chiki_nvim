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

			local function lint_sql(buf)
				if not vim.api.nvim_buf_is_valid(buf) or not vim.tbl_contains(sql_ft, vim.bo[buf].filetype) then
					return
				end
				-- Mason may still be installing SQLFluff when the first SQL buffer is
				-- opened. Missing tooling should degrade quietly instead of producing
				-- an ENOENT notification every time the query buffer is entered.
				if vim.fn.executable("sqlfluff") ~= 1 then
					return
				end

				local args = require("config.sql").sqlfluff_args(buf, "lint")
				vim.list_extend(args, { "--format=json", "-" })
				lint.linters.sqlfluff.args = args

				vim.api.nvim_buf_call(buf, function()
					lint.try_lint()
				end)
			end

			local group = vim.api.nvim_create_augroup("chiki_sql_lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
				group = group,
				callback = function(event)
					lint_sql(event.buf)
				end,
			})

			vim.schedule(function()
				lint_sql(vim.api.nvim_get_current_buf())
			end)
		end,
	},
}
