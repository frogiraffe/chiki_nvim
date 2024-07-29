return {
	--
	{
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		ft = { "rust" },
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		event = "BufReadPre",
		dependencies = {
			{
				"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
				config = function()
					require("lsp_lines").setup()
				end
			},
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
					"tsserver",
					"html",
					"cssls",
					"basedpyright",
				},
			})
			--
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
						-- disable these check
						-- reportUnknownParameterType = false
						-- reportMissingParameterType = false
						-- reportUnknownMemberType = false
						-- reportUnknownArgumentType = false
						-- reportMissingTypeStubs = false
						settings = {
							basedpyright = {
								analysis = {
									useLibraryCodeForTypes = true,
									diagnosticSeverityOverrides = {
										reportUnknownParameterType = "none",
										reportMissingParameterType = "none",
										reportUnknownMemberType = "none",
										reportUnknownArgumentType = "none",
										reportMissingTypeStubs = "none",
									},
									typeCheckingMode = "basic",
								},
							},
						}

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
				-- ["rust_analyzer"] = function() end,

			})
			lspconfig.marksman.setup({})



			require("lspconfig").html.setup({
				capabilities = html_capabilities,
			})

			-- local on_attach = function(client, bufnr)
			-- 	if client.name == "ruff_lsp" then
			-- 		client.server_capabilities.hoverProvider = false
			-- 	end
			-- end
			-- require("lspconfig").ruff_lsp.setup({
			-- 	on_attach = on_attach,
			-- })
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
