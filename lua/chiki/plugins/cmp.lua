return {
	-- {
	-- 	"hrsh7th/nvim-cmp",
	-- 	version = false,
	-- 	event = { "InsertEnter" },
	-- 	dependencies = {
	-- 		{ "hrsh7th/cmp-nvim-lsp" },
	-- 		{ "hrsh7th/cmp-buffer" },
	-- 		{ "hrsh7th/cmp-path" },
	-- 		{ "saadparwaiz1/cmp_luasnip" },
	-- 		{
	-- 			"L3MON4D3/LuaSnip",
	-- 			dependencies = { "rafamadriz/friendly-snippets" },
	-- 			event = "InsertEnter",
	-- 			build = "make install_jsregexp",
	-- 			keys = function()
	-- 				return {}
	-- 			end,
	-- 			config = function()
	-- 				require("luasnip").setup({ enable_autosnippets = true })
	-- 			end,
	-- 		},
	-- 		{
	-- 			"jalvesaq/cmp-nvim-r",
	-- 			config = function()
	-- 				require("cmp_nvim_r").setup({
	-- 					filetypes = { "r", "rmd", "quarto" },
	-- 					doc_width = 58,
	-- 				})
	-- 			end,
	-- 		},
	-- 		{
	-- 			"zbirenbaum/copilot.lua",
	-- 			cmd = "Copilot",
	-- 			event = "InsertEnter",
	-- 			config = function()
	-- 				require("copilot").setup({})
	-- 			end,
	-- 		},
	-- 	},
	-- 	opts = function()
	-- 		local cmp = require("cmp")
	-- 		local luasnip = require("luasnip")
	-- 		cmp.setup.cmdline("/", {
	-- 			mapping = cmp.mapping.preset.cmdline(),
	-- 			sources = {
	-- 				{ name = "buffer" },
	-- 			},
	-- 		})
	-- 		return {
	-- 			formatting = {
	-- 				format = require("lspkind").cmp_format({
	-- 					mode = "symbol_text",
	-- 					maxwidth = 50,
	-- 					ellipsis_char = "...",
	--
	-- 				}),
	-- 			},
	-- 			mapping = cmp.mapping.preset.insert({
	-- 				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
	-- 				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
	-- 				["<C-b>"] = cmp.mapping.scroll_docs(4),
	-- 				["<C-f>"] = cmp.mapping.scroll_docs(-4),
	-- 				["<C-a>"] = cmp.mapping.abort(),
	-- 				['<C-Space>'] = cmp.mapping(function(fallback)
	-- 					if cmp.visible() then
	-- 						if luasnip.expandable() then
	-- 							luasnip.expand()
	-- 						else
	-- 							cmp.confirm({
	-- 								select = true,
	-- 							})
	-- 						end
	-- 					else
	-- 						fallback()
	-- 					end
	-- 				end),
	-- 				["<Tab>"] = cmp.mapping(function(fallback)
	-- 					if luasnip.expand_or_jumpable() then
	-- 						luasnip.expand_or_jump()
	-- 					else
	-- 						fallback()
	-- 					end
	-- 				end, { "i", "s" }),
	-- 				["<S-Tab>"] = cmp.mapping(function(fallback)
	-- 					if luasnip.jumpable(-1) then
	-- 						luasnip.jump(-1)
	-- 					else
	-- 						fallback()
	-- 					end
	-- 				end, { "i", "s" }),
	-- 			}),
	-- 			require("luasnip.loaders.from_vscode").lazy_load(),
	-- 			sources = cmp.config.sources({
	-- 				{ name = "nvim_lsp" },
	-- 				{ name = "luasnip" },
	-- 				{ name = "path" },
	-- 				{ name = "cmp_nvim_r" },
	-- 				{ name = "buffer",    keyword_length = 5 },
	-- 			}),
	-- 		}
	-- 	end,
	-- },
	{
		"onsails/lspkind.nvim",
		event = "VeryLazy",
		config = function()
			require("lspkind").init({
				mode = "symbol_text",
				symbol_map = {
					Text = "󰉿",
					Method = "󰆧",
					Function = "󰊕",
					Constructor = "",
					Field = "󰜢",
					Copilot = "",
					Variable = "󰀫",
					Class = "󰠱",
					Interface = "",
					Module = "",
					Property = "󰜢",
					Unit = "󰑭",
					Value = "󰎠",
					Enum = "",
					Keyword = "󰌋",
					Snippet = "",
					Color = "󰏘",
					File = "󰈙",
					Reference = "󰈇",
					Folder = "󰉋",
					EnumMember = "",
					Constant = "󰏿",
					Struct = "󰙅",
					Event = "",
					Operator = "󰆕",
					TypeParameter = "",
				},
			})
			vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
		end,
	},
	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		branch = "v0.6",
		opts = {
		},
		config = function()
			require("ultimate-autopair").setup({
				tabout = {
					enable = true,
				},
				cmap = true,
				space2 = { enable = true },
				fastwarp = { multi = true, {}, { faster = true, map = '<C-A-e>', cmap = '<C-A-e>' } }
			})
		end,
	},
	{
		'abecodes/tabout.nvim',
		config = function()
			require('tabout').setup {
				tabkey = '<Tab>',
				backwards_tabkey = '<S-Tab>',
				act_as_tab = true,
				act_as_shift_tab = false,
				default_tab = '<C-t>',
				enable_backwards = true,
				completion = false,
				tabouts = {
					{ open = "'", close = "'" },
					{ open = '"', close = '"' },
					{ open = '`', close = '`' },
					{ open = '(', close = ')' },
					{ open = '[', close = ']' },
					{ open = '{', close = '}' }
				},
				ignore_beginning = true,
				exclude = {}
			}
		end,
	},
}
