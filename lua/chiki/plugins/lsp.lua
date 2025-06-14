return {
	{
		"mrcjkb/rustaceanvim",
		version = "^6", -- Recommended
		lazy = false,
	},
	{
		"williamboman/mason.nvim",
		-- No 'build' or 'event' here directly for mason.nvim itself
		-- The 'config' function below will ensure it's set up
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		-- This plugin depends on mason.nvim, which is now configured separately
		dependencies = {
			"williamboman/mason.nvim", -- Explicitly list mason as a dependency if not already handled by your plugin manager
			{
				"neovim/nvim-lspconfig",
				event = { "BufReadPre", "BufNewFile" },
				opts = function()
					local ret = {
						diagnostics = {
							underline = true,
							update_in_insert = false,
							virtual_text = {
								spacing = 4,
								source = "if_many",
								prefix = "●",
							},
							severity_sort = true,
						},
						inlay_hints = {
							enabled = true,
							exclude = { "vue" },
						},
						codelens = {
							enabled = false,
						},
						capabilities = {
							workspace = {
								fileOperations = {
									didRename = true,
									willRename = true,
								},
							},
						},
						format = {
							formatting_options = nil,
							timeout_ms = nil,
						},
						servers = {
							lua_ls = {
								settings = {
									Lua = {
										workspace = { checkThirdParty = false },
										codeLens = { enable = true },
										completion = { callSnippet = "Replace" },
										doc = { privateName = { "^_" } },
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
							html = {}, -- Add any specific settings if needed
							cssls = {},
							basedpyright = {
								settings = {
									["basedpyright"] = {
										analysis = {

											typeCheckingMode = "basic"
										}

									},
								},
							},
						},
						setup = {},
					}
					return ret
				end,
				config = function(_, opts)
					local lspconfig = require("lspconfig")
					local mason_lspconfig = require("mason-lspconfig")

					vim.lsp.config["basedpyright"] = {
							settings = {
								basedpyright = {
									analysis = {
										typeCheckingMode = "basic"
									}
								}

							},
						},
						-- Ensure mason.nvim is set up before mason-lspconfig.setup()
						-- Although we moved the setup, it's good practice to ensure.
						-- However, with the structural change above, this line isn't strictly necessary here.
						-- require("mason").setup() -- This should be handled by the mason.nvim plugin definition

						mason_lspconfig.setup({
							ensure_installed = vim.tbl_keys(opts.servers),
							automatic_installation = false,
						})

					for server, config in pairs(opts.servers) do
						-- Assuming 'blink.cmp' exists and provides get_lsp_capabilities
						config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities or {})
						lspconfig[server].setup(config)
					end
				end,
			},
		},
	},
	config = function()
		require("mason-lspconfig").setup({
			automatic_enable = true
		})
	end,
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
