-- LazyVim owns format-on-save (toggle with <leader>uf / <leader>uF, disabled
-- for C/C++ in config/autocmds.lua; <leader>cf is in config/keymaps.lua so it
-- replaces LazyVim's default). Only formatters are configured here.
return {
	{
		"stevearc/conform.nvim",
		opts = function(_, opts)
			opts.notify_on_error = false
			opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
				python = { "ruff_format" },
				rust = { "rustfmt" },
			})
			-- Conform's built-in SQLFluff formatter requires a discovered config
			-- directory. This definition also supports ad-hoc SQL buffers by
			-- supplying a dialect inferred from Dadbod/filetype when needed.
			opts.formatters.sqlfluff = {
				inherit = false,
				command = "sqlfluff",
				stdin = true,
				cwd = function(_, ctx)
					return ctx.dirname
				end,
				args = function(_, ctx)
					local args = require("config.sql").sqlfluff_args(ctx.buf, "format")
					table.insert(args, "-")
					return args
				end,
			}
		end,
	},
}
