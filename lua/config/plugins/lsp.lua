return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			{
				"mason-org/mason-lspconfig.nvim",
				opts = { automatic_enable = false },
			},
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				opts = {
					ensure_installed = {
						-- LSP servers
						"lua_ls",
						"basedpyright",
						"bacon_ls",
						"bacon",
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
						-- Formatters & linters
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
			capabilities.workspace = capabilities.workspace or {}
			capabilities.workspace.fileOperations = {
				didRename = true,
				willRename = true,
			}

			vim.lsp.config("*", { capabilities = capabilities })

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						completion = { callSnippet = "Replace" },
						diagnostics = { disable = { "missing-fields" } },
						workspace = { checkThirdParty = false },
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
						analysis = { typeCheckingMode = "standard" },
					},
				},
			})

			vim.lsp.config("ts_ls", {
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
			})
			vim.lsp.config("eslint", {})
			vim.lsp.config("html", {})
			vim.lsp.config("cssls", {})
			vim.lsp.config("jsonls", {})
			vim.lsp.config("emmet_language_server", {})
			vim.lsp.config("bashls", {})
			vim.lsp.config("yamlls", {})
			vim.lsp.config("clangd", {})
			vim.lsp.config("gopls", {})
			vim.lsp.config("sqls", {})
			vim.lsp.config("dockerls", {})
			vim.lsp.config("docker_compose_language_service", {})

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
					format = function(diagnostic)
						if diagnostic.lnum ~= vim.api.nvim_win_get_cursor(0)[1] - 1 then
							return ""
						end
						return diagnostic.message
					end,
				},
			})

			local attach_group = vim.api.nvim_create_augroup("chiki_lsp_attach", { clear = true })
			local highlight_group = vim.api.nvim_create_augroup("chiki_lsp_highlight", { clear = true })
			local detach_group = vim.api.nvim_create_augroup("chiki_lsp_detach", { clear = true })

			vim.api.nvim_create_autocmd("LspAttach", {
				group = attach_group,
				callback = function(event)
					local map = function(keys, func, desc, mode)
						vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
					map("]d", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, "Next Diagnostic")
					map("[d", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end, "Prev Diagnostic")
					map("<leader>cd", vim.diagnostic.open_float, "Line Diagnostics")

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if not client then
						return
					end

					if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_group,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_group,
							callback = vim.lsp.buf.clear_references,
						})
						vim.api.nvim_create_autocmd("LspDetach", {
							buffer = event.buf,
							group = detach_group,
							once = true,
							callback = function(detach_event)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = highlight_group, buffer = detach_event.buf })
							end,
						})
					end

					if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
						vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
					end
				end,
			})
		end,
	},
}
