return {
	{
		"mrcjkb/rustaceanvim",
		version = "^6", -- Recommended
		lazy = false,
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			{
				"neovim/nvim-lspconfig",
				event = { "BufReadPre", "BufNewFile" },
				opts = function()
					return {
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
							html = {},
							cssls = {},
							basedpyright = {
								settings = {
									["basedpyright"] = {
										analysis = {
											typeCheckingMode = "basic",
										},
									},
								},
							},
						},
						setup = {},
					}
				end,
				config = function(_, opts)
					local lspconfig = require("lspconfig")
					local mason_lspconfig = require("mason-lspconfig")

					-- Ensure mason.nvim is set up before mason-lspconfig.setup()
					mason_lspconfig.setup({
						ensure_installed = vim.tbl_keys(opts.servers),
						automatic_installation = false,
					})

					for server, config in pairs(opts.servers) do
						config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities or {})
						lspconfig[server].setup(config)
					end
				end,
			},
		},
	},
	config = function()
		require("mason-lspconfig").setup({
			automatic_enable = true,
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
