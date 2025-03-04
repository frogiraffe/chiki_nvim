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
				config = function() end,
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
			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities()
			)
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
