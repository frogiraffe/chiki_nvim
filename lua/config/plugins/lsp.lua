return {
	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			{
				"mason-org/mason-lspconfig.nvim",
				opts = {
					automatic_enable = false,
				},
			},
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				opts = {
					ensure_installed = {
						-- LSP servers
						"lua_ls",
						"basedpyright",
						"bacon_ls",
						"ts_ls",
						"eslint",
						"html",
						"cssls",
						"jsonls",
						"emmet_language_server",
						"bashls",
						"yamlls",
						"clangd",
						"gopls",
						"sqls",
						"dockerls",
						"docker_compose_language_service",
						-- Formatters & Linters
						"stylua",
						"ruff",
					},
				},
			},
			{ "j-hui/fidget.nvim", opts = {} },
			"saghen/blink.cmp",
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Default capabilities across all LSP servers
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			-- Server configurations using modern vim.lsp.config
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						diagnostics = { disable = { "missing-fields" } },
					},
				},
			})

			vim.lsp.config("bacon_ls", {
				settings = {
					bacon_ls = {
						backend = "cargo",
						cargo = {
							command = "check",
							checkOnSave = true,
						},
					},
				},
			})

			vim.lsp.config("basedpyright", {
				settings = {
					basedpyright = {
						analysis = {
							typeCheckingMode = "standard",
						},
					},
				},
			})

			-- Web / JS ecosystem
			vim.lsp.config("ts_ls", {
				filetypes = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
				},
			})
			vim.lsp.config("eslint", {})
			vim.lsp.config("html", {})
			vim.lsp.config("cssls", {})
			vim.lsp.config("jsonls", {})
			vim.lsp.config("emmet_language_server", {})

			-- General
			vim.lsp.config("bashls", {})
			vim.lsp.config("yamlls", {})
			vim.lsp.config("clangd", {})
			vim.lsp.config("gopls", {})

			-- Data / config
			vim.lsp.config("sqls", {})
			vim.lsp.config("dockerls", {})
			vim.lsp.config("docker_compose_language_service", {})

			-- Deterministically enable the servers we want
			vim.lsp.enable({
				"lua_ls",
				"basedpyright",
				"bacon_ls",
				"ts_ls",
				"eslint",
				"html",
				"cssls",
				"jsonls",
				"emmet_language_server",
				"bashls",
				"yamlls",
				"clangd",
				"gopls",
				"sqls",
				"dockerls",
				"docker_compose_language_service",
			})

			vim.diagnostic.config({
				severity_sort = true,
				update_in_insert = false,
				float = { border = "rounded", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = vim.g.have_nerd_font and {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				} or {},
				virtual_text = {
					source = "if_many",
					spacing = 2,
					prefix = "●",
					-- AstroNvim style: only show virtual text for the current line
					format = function(diagnostic)
						if diagnostic.lnum ~= vim.api.nvim_win_get_cursor(0)[1] - 1 then
							return ""
						end
						return diagnostic.message
					end,
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
					-- Modern diagnostic navigation (Neovim 0.12+ style)
					map("]d", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, "Next Diagnostic")
					map("[d", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end, "Prev Diagnostic")
					map("<leader>cd", vim.diagnostic.open_float, "Line Diagnostics")

					local client = vim.lsp.get_client_by_id(event.data.client_id)

					if
						client
						and client:supports_method(
							vim.lsp.protocol.Methods.textDocument_documentHighlight,
							event.buf
						)
					then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })

						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					if
						client
						and client:supports_method(
							vim.lsp.protocol.Methods.textDocument_inlayHint,
							event.buf
						)
					then
						vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
						-- Inlay-hint toggle lives under <leader>uh (snacks UI toggles, see snacks.lua)
					end
				end,
			})
		end,
	},
}
