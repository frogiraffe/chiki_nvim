return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			keys =
			{
				"<leader>gf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "n",
				desc = "Format buffer",
			},
			{
				"<leader>gF",
				function() require("conform").format({ async = true, lsp_fallback = true, range = true }) end,
				mode = "v",
				desc = "Format selection",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { { "prettierd", "prettier" } },
				go = { "gofumpt", "gofmt" },
				rust = { "rustfmt" },
				c = { "clang_format" },
				html = { "prettierd" },
				css = { "prettierd" },
				r = {},
				fish = { "fish_indent" },
				sh = { "shfmt" },
				sql = { "sqlformat" },
			},
		},
		config = function()
			local slow_format_filetypes = {}
			local conform = require("conform")
			conform.setup({
				format_on_save = function(bufnr)
					local ft = vim.bo[bufnr].filetype
					if slow_format_filetypes[ft] then
						return
					end
					local function on_format(err)
						if err and err:match("timeout$") then
							slow_format_filetypes[ft] = true
						end
					end
					return { timeout_ms = 200, lsp_fallback = true }, on_format
				end,
				format_after_save = function(bufnr)
					local ft = vim.bo[bufnr].filetype
					if not slow_format_filetypes[ft] then
						return
					end
					return { lsp_fallback = true }
				end,
			})
		end,
	},
}
