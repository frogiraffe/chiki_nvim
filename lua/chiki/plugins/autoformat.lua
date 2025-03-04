return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<leader>gf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
			{
				"<leader>gF",
				function()
					require("conform").format({ async = true, lsp_fallback = true, range = true })
				end,
				mode = "v",
				desc = "Format selection",
			}
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				-- Use a sub-list to run only the first available formatter
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
			require("conform").setup({
				format_on_save = function(bufnr)
					if slow_format_filetypes[vim.bo[bufnr].filetype] then
						return
					end
					local function on_format(err)
						if err and err:match("timeout$") then
							slow_format_filetypes[vim.bo[bufnr].filetype] = true
						end
					end

					return { timeout_ms = 200, lsp_fallback = true }, on_format
				end,

				format_after_save = function(bufnr)
					if not slow_format_filetypes[vim.bo[bufnr].filetype] then
						return
					end
					return { lsp_fallback = true }
				end,
			})
		end,
	},
}
