-- Single source of truth for language servers (LazyVim-style): every entry is
-- configured with vim.lsp.config(), enabled, and installed through Mason.
-- An empty table means "defaults from nvim-lspconfig".
local servers = {
	lua_ls = {
		settings = {
			Lua = {
				completion = { callSnippet = "Replace" },
				diagnostics = { disable = { "missing-fields" } },
				workspace = { checkThirdParty = false },
			},
		},
	},
	basedpyright = {
		settings = {
			basedpyright = {
				analysis = { typeCheckingMode = "standard" },
			},
		},
	},
	-- Ruff handles lint/code actions while basedpyright remains the source of
	-- Python type information and hover documentation.
	ruff = {
		init_options = {
			settings = { logLevel = "error" },
		},
		on_attach = function(client)
			client.server_capabilities.hoverProvider = false
		end,
	},
	-- bacon-ls owns Cargo diagnostics; rust-analyzer runs via rustaceanvim.
	bacon_ls = {
		settings = {
			bacon_ls = {
				backend = "cargo",
				cargo = {
					command = "check",
					checkOnSave = true,
				},
			},
		},
	},
	ts_ls = {
		filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	},
	eslint = {},
	html = {},
	cssls = {},
	-- SchemaStore is only required when a JSON/YAML server actually starts.
	jsonls = {
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
	},
	yamlls = {
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
	},
	emmet_language_server = {},
	bashls = {},
	clangd = {},
	gopls = {},
	dockerls = {},
	docker_compose_language_service = {},
	marksman = {},
	texlab = {},
	taplo = {},
}

return {
	{
		"neovim/nvim-lspconfig",
		event = "LazyFile",
		dependencies = {
			{
				"mason-org/mason.nvim",
				-- Mason's bin dir is put on PATH at startup (cheap, no plugin load)
				-- so Mason-installed tools such as sqlfluff, stylua or
				-- yaml-language-server are found by nvim-lint, conform and R.nvim
				-- even before lspconfig has loaded Mason.
				init = function()
					local bin = vim.fn.stdpath("data") .. "/mason/bin"
					if not vim.tbl_contains(vim.split(vim.env.PATH or "", ":", { plain = true }), bin) then
						vim.env.PATH = bin .. ":" .. (vim.env.PATH or "")
					end
				end,
				opts = { PATH = "skip" },
			},
			{
				"mason-org/mason-lspconfig.nvim",
				opts = { automatic_enable = false },
			},
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				opts = function()
					-- Every configured server plus standalone formatters/linters.
					local tools = vim.tbl_keys(servers)
					vim.list_extend(tools, { "bacon", "stylua", "sqlfluff" })
					table.sort(tools)
					return { ensure_installed = tools }
				end,
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

			for name, config in pairs(servers) do
				if next(config) ~= nil then
					vim.lsp.config(name, config)
				end
			end
			vim.lsp.enable(vim.tbl_keys(servers))

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
