return {
	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				local ft = vim.bo[bufnr].filetype
				local disable_filetypes = { c = true, cpp = true }
				if disable_filetypes[ft] then
					return nil
				end
				local sql_filetypes = { sql = true, mysql = true, plsql = true }
				return {
					-- SQLFluff is a Python CLI and can take noticeably longer to start than
					-- Stylua/Ruff/Rustfmt, especially on its first invocation.
					timeout_ms = sql_filetypes[ft] and 3000 or 500,
					lsp_format = "fallback",
				}
			end,
			formatters = {
				sqlfluff = {
					-- Conform's built-in SQLFluff formatter requires a discovered config
					-- directory. This custom definition also supports ad-hoc SQL buffers
					-- by supplying a dialect inferred from Dadbod/filetype when needed.
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
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format" },
				rust = { "rustfmt" },
				sql = { "sqlfluff" },
				mysql = { "sqlfluff" },
				plsql = { "sqlfluff" },
			},
		},
	},
}
