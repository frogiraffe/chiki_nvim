return {
	{
		"hrsh7th/nvim-cmp",
		version = false, -- last release is way too old
		event = { "InsertEnter" },
		dependencies = {
			-- {
			--     "hrsh7th/cmp-omni",
			--     event = { "BufReadPre", "BufNewFile" },
			-- },
			{
				"hrsh7th/cmp-nvim-lsp",
			},
			{
				"hrsh7th/cmp-buffer",
			},
			{
				"hrsh7th/cmp-path",
			},
			{
				"saadparwaiz1/cmp_luasnip",
			},
			{
				"L3MON4D3/LuaSnip",
				dependencies = { "rafamadriz/friendly-snippets" },
				event = "InsertEnter",
				-- install jsregexp (optional!).
				build = "make install_jsregexp",
				config = function()
					require("luasnip").setup({ enable_autosnippets = true })
				end,
			},
			{
				"hrsh7th/cmp-nvim-lsp-signature-help",
			},
			{
				"zbirenbaum/copilot.lua",
				cmd = "Copilot",
				event = "InsertEnter",
				config = function()
					require("copilot").setup({
						suggestion = { enabled = false },
						panel = { enabled = false },
					})
				end,
			},
			{
				"zbirenbaum/copilot-cmp",
				event = { "InsertEnter", "LspAttach" },
				config = function()
					require("copilot_cmp").setup({
						fix_pairs = true,
					})
				end,
			},
		},
		opts = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			local handlers = require("nvim-autopairs.completion.handlers")

			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			cmp.event:on(
				"confirm_done",
				cmp_autopairs.on_confirm_done({
					filetypes = {
						-- "*" is a alias to all filetypes
						["*"] = {
							["("] = {
								kind = {
									cmp.lsp.CompletionItemKind.Function,
									cmp.lsp.CompletionItemKind.Method,
								},
								handler = handlers["*"],
							},
						},
						lua = {
							["("] = {
								kind = {
									cmp.lsp.CompletionItemKind.Function,
									cmp.lsp.CompletionItemKind.Method,
								},
								---@param char string
								---@param item table item completion
								---@param bufnr number buffer number
								---@param rules table
								---@param commit_character table<string>
								handler = function(char, item, bufnr, rules, commit_character)
									-- Your handler function. Inpect with print(vim.inspect{char, item, bufnr, rules, commit_character})
								end,
							},
						},
						-- Disable for tex
						tex = false,
					},
				})
			)

			return {
				formatting = {
					format = require("lspkind").cmp_format({
						mode = "symbol", -- show only symbol annotations
						maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

						-- The function below will be called befjjore any actual modifications from lspkind
						-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
						before = function(entry, vim_item)
							vim_item.menu = ({
								-- omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
								-- buffer = "[Buffer]",
								-- -- formatting for other sources
							})[entry.source.name]
							return vim_item
						end,
					}),
				},
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = {
						border = "rounded",
						winhighlight = "Normal:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
					},
					documentation = {
						border = "rounded",
						winhighlight = "NormalFloat:Pmenu",
					},
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-k>"] = cmp.mapping.complete(),
					["<C-a>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
							-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
							-- they way you will only jump inside the snippet region
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				require("luasnip.loaders.from_vscode").lazy_load(),
				sources = cmp.config.sources({
					{ name = "nvim_lsp",               priority = 1000 },
					{ name = "luasnip",                priority = 750 },
					-- { name = 'omni', priority = 750 },
					{ name = "copilot",                group_index = 2 },
					{ name = "nvim_lsp_signature_help" },
					{ name = "path" },
					{ name = "buffer",                 keyword_length = 5 },
				}),
			}
		end,
	},
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
}
