return {
	{ -- Autocompletion
		"saghen/blink.cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		version = "1.*",
		dependencies = {
			-- Snippet Engine
			{
				"L3MON4D3/LuaSnip",
				version = "2.*",
				build = (function()
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					{
						"rafamadriz/friendly-snippets",
						config = function()
							require("luasnip").config.setup({
								enable_autosnippets = true,
								update_events = "TextChanged,TextChangedI",
							})
							require("luasnip.loaders.from_vscode").lazy_load()
							require("luasnip.loaders.from_lua").load({
								paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
							})
						end,
					},
				},
			},
			"folke/lazydev.nvim",
		},
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "default" },
			appearance = { nerd_font_variant = "mono" },
			completion = {
				ghost_text = { enabled = true },
				documentation = { auto_show = false, auto_show_delay_ms = 500 },
			},
			sources = {
				default = {
					"lsp",
					"path",
					"snippets",
					"buffer",
				},
				per_filetype = {
					-- LazyDev is useful only for Lua/Neovim APIs. Keeping it out of the
					-- global provider set avoids needless provider work in every language.
					lua = { inherit_defaults = true, "lazydev" },
					codecompanion = { "codecompanion" },
					-- Dadbod owns schema-aware SQL completion. sqls was intentionally
					-- removed from the LSP stack to avoid duplicate completion engines.
					sql = { "snippets", "dadbod", "buffer" },
					mysql = { "snippets", "dadbod", "buffer" },
					plsql = { "snippets", "dadbod", "buffer" },
				},
				providers = {
					dadbod = {
						name = "Dadbod",
						module = "vim_dadbod_completion.blink",
					},
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
			snippets = { preset = "luasnip" },
			fuzzy = { implementation = "prefer_rust_with_warning" },
			signature = { enabled = true },
		},
	},
}
