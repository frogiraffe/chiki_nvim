return {
	{
		"mrcjkb/rustaceanvim",
		version = "^6", -- Recommended
		lazy = false,
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		event = "BufReadPre",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			{
				"neovim/nvim-lspconfig",
				event = { "BufReadPre", "BufNewFile" },

				opts = function()
					---@class PluginLspOpts
					local ret = {
						-- options for vim.diagnostic.config()
						---@type vim.diagnostic.Opts
						diagnostics = {
							underline = true,
							update_in_insert = false,
							virtual_text = {
								spacing = 4,
								source = "if_many",
								prefix = "●",
								-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
								-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
								-- prefix = "icons",
							},
							severity_sort = true,
						},
						-- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
						-- Be aware that you also will need to properly configure your LSP server to
						-- provide the inlay hints.
						inlay_hints = {
							enabled = true,
							exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
						},
						-- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
						-- Be aware that you also will need to properly configure your LSP server to
						-- provide the code lenses.
						codelens = {
							enabled = false,
						},
						-- add any global capabilities here
						capabilities = {
							workspace = {
								fileOperations = {
									didRename = true,
									willRename = true,
								},
							},
						},
						-- options for vim.lsp.buf.format
						-- `bufnr` and `filter` is handled by the LazyVim formatter,
						-- but can be also overridden when specified
						format = {
							formatting_options = nil,
							timeout_ms = nil,
						},
						-- LSP Server Settings
						---@type lspconfig.options
						servers = {
							lua_ls = {
								-- mason = false, -- set to false if you don't want this server to be installed with mason
								-- Use this to add any additional keymaps
								-- for specific lsp servers
								-- ---@type LazyKeysSpec[]
								-- keys = {},
								settings = {
									Lua = {
										workspace = {
											checkThirdParty = false,
										},
										codeLens = {
											enable = true,
										},
										completion = {
											callSnippet = "Replace",
										},
										doc = {
											privateName = { "^_" },
										},
										hint = {
											enable = true,
											setType = false,
											paramType = true,
											paramName = "Disable",
											semicolon = "Disable",
											arrayIndex = "Disable",
										},
									},
								},
							},
						},
						-- you can do any additional lsp server setup here
						-- return true if you don't want this server to be setup with lspconfig
						---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
						setup = {
							-- example to setup with typescript.nvim
							-- tsserver = function(_, opts)
							--   require("typescript").setup({ server = opts })
							--   return true
							-- end,
							-- Specify * to use this function as a fallback for any server
							-- ["*"] = function(server, opts) end,
						},
					}
					return ret
				end,
				config = function(_, opts)
				end,
			},
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"html",
					"cssls",
				},
			})

			local lspconfig = require("lspconfig")
			local html_capabilities = vim.lsp.protocol.make_client_capabilities()
			html_capabilities.textDocument.completion.completionItem.snippetSupport = true

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,
				["texlab"] = function()
					require("lspconfig").texlab.setup({
						filetypes = { "tex", "bib", "markdown" },
					})
				end,
				["basedpyright"] = function()
					require("lspconfig").basedpyright.setup({
						settings = {
							basedpyright = {
								analysis = {
									-- useLibraryCodeForTypes = true,
									-- diagnosticSeverityOverrides = {
									-- 	reportUnknownParameterType = "none",
									-- 	reportMissingParameterType = "none",
									-- 	reportUnknownMemberType = "none",
									-- 	reportUnknownArgumentType = "none",
									-- 	reportMissingTypeStubs = "none",
								},
								-- typeCheckingMode = "basic",
							},
						},
					})
				end,
				["lua_ls"] = function()
					require("lspconfig").lua_ls.setup({
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
									undefined_global = true, -- remove this from diag!
									missing_parameters = false, -- missing fields :)
								},
							},
						},
					})
				end,
				["r_language_server"] = function()
					require("lspconfig").r_language_server.setup({
						flags = { debounce_text_changes = 300 },
					})
				end,
			})
			lspconfig.marksman.setup({})
			require("lspconfig").html.setup({
				capabilities = html_capabilities,
			})
		end,
	},
	{
		"folke/neodev.nvim",
		event = "BufReadPre",
		opts = {},
		config = function()
			require("neodev").setup({
				library = { plugins = { "neotest" }, types = true },
			})
		end,
	},
}
