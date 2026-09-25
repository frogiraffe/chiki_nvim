-- LazyVim runs nvim-lint on BufReadPost/BufWritePost/InsertLeave (debounced).
-- The sql extra registers sqlfluff for sql/mysql/plsql.
return {
	{
		"mfussenegger/nvim-lint",
		opts = function(_, opts)
			local function executable(cmd)
				return function()
					return vim.fn.executable(cmd) == 1
				end
			end

			-- Prose and Ruby linting (formerly via ALE).
			opts.linters_by_ft.markdown = { "proselint" }
			opts.linters_by_ft.text = { "proselint" }
			opts.linters_by_ft.ruby = { "rubocop", "ruby" }
			opts.linters.proselint = { condition = executable("proselint") }
			opts.linters.rubocop = { condition = executable("rubocop") }
			opts.linters.ruby = { condition = executable("ruby") }

			opts.linters.sqlfluff = {
				-- Missing tooling (e.g. Mason still installing SQLFluff) degrades
				-- quietly. The dialect is resolved per buffer right before linting,
				-- sharing config/sql.lua's policy with the formatter.
				condition = function()
					if vim.fn.executable("sqlfluff") ~= 1 then
						return false
					end
					local args = require("config.sql").sqlfluff_args(0, "lint")
					vim.list_extend(args, { "--format=json", "-" })
					require("lint").linters.sqlfluff.args = args
					return true
				end,
			}
		end,
	},
}
