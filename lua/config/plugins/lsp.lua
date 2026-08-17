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
						"ruff",
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
						"dockerls",
						"docker_compose_language_service",
						"marksman",
						"texlab",
						"taplo",
						-- Formatters & linters
						"stylua",
						"sqlfluff",
					},
				},
			},
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

			-- Ruff handles lint/code actions while basedpyright remains the source
			-- of Python type information and hover documentation.
			vim.lsp.config("ruff", {
				init_options = {
					settings = { logLevel = "error" },
				},
				on_attach = function(client)
					client.server_capabilities.hoverProvider = false
				end,
			})

			vim.lsp.config("ts_ls", {
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
			})
			vim.lsp.config("eslint", {})
			vim.lsp.config("html", {})
			vim.lsp.config("cssls", {})

			vim.lsp.config("jsonls", {
				before_init = function(_, new_config)
					local ok, schemastore = pcall(require, "schemastore")
					if not ok then
						return
					end
					new_config.settings = new_config.settings or {}
					new_config.settings.json = new_config.settings.json or {}
					new_config.settings.json.schemas = new_config.settings.json.schemas or {}
					vim.list_extend(new_config.settings.json.schemas, schemastore.json.schemas())
				end,
				settings = {
					json = {
						format = { enable = true },
						validate = { enable = true },
					},
				},
			})

			vim.lsp.config("yamlls", {
				before_init = function(_, new_config)
					local ok, schemastore = pcall(require, "schemastore")
					if not ok then
						return
					end
					new_config.settings = new_config.settings or {}
					new_config.settings.yaml = new_config.settings.yaml or {}
					new_config.settings.yaml.schemas = vim.tbl_deep_extend(
						"force",
						new_config.settings.yaml.schemas or {},
						schemastore.yaml.schemas()
					)
				end,
				settings = {
					redhat = { telemetry = { enabled = false } },
					yaml = {
						keyOrdering = false,
						format = { enable = true },
						validate = true,
						schemaStore = {
							enable = false,
							url = "",
						},
					},
				},
			})

			vim.lsp.config("emmet_language_server", {})
			vim.lsp.config("bashls", {})
			vim.lsp.config("clangd", {})
			vim.lsp.config("gopls", {})
			vim.lsp.config("dockerls", {})
			vim.lsp.config("docker_compose_language_service", {})
			vim.lsp.config("marksman", {})
			vim.lsp.config("texlab", {})
			vim.lsp.config("taplo", {})

			vim.lsp.enable({
				"lua_ls",
				"basedpyright",
				"ruff",
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
				"dockerls",
				"docker_compose_language_service",
				"marksman",
				"texlab",
				"taplo",
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

			-- Snacks.words already owns document-reference highlighting/navigation,
			-- so LspAttach only configures actions that are not duplicated elsewhere.
			local attach_group = vim.api.nvim_create_augroup("chiki_lsp_attach", { clear = true })
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
					if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
						vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
					end
				end,
			})
		end,
	},
}
