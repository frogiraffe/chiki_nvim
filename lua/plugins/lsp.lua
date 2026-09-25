-- LazyVim owns the LSP plumbing (mason auto-install, capabilities, inlay hints,
-- folds, keymaps). Python/JSON/YAML/TOML/TeX servers come from extras
-- (see config/lazy.lua); only servers without a matching extra, or with
-- personal settings, are listed here.
return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			diagnostics = {
				underline = { severity = vim.diagnostic.severity.ERROR },
				float = { border = "rounded", source = "if_many" },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				},
				virtual_text = {
					spacing = 2,
					-- Only show virtual text for the line under the cursor.
					format = function(diagnostic)
						if diagnostic.lnum ~= vim.api.nvim_win_get_cursor(0)[1] - 1 then
							return ""
						end
						return diagnostic.message
					end,
				},
			},
			servers = {
				["*"] = {
					keys = {
						-- <leader>cl stays on Trouble (see trouble.lua).
						{ "<leader>cl", false },
						-- Same pickers as before the LazyVim migration (unfiltered symbols).
						{
							"gD",
							function()
								Snacks.picker.lsp_declarations()
							end,
							desc = "Goto Declaration",
						},
						{
							"<leader>ss",
							function()
								Snacks.picker.lsp_symbols()
							end,
							desc = "LSP Symbols",
						},
						{
							"<leader>sS",
							function()
								Snacks.picker.lsp_workspace_symbols()
							end,
							desc = "LSP Workspace Symbols",
						},
						{
							"gra",
							vim.lsp.buf.code_action,
							desc = "[G]oto Code [A]ction",
							mode = { "n", "x" },
							has = "codeAction",
						},
					},
				},
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = { disable = { "missing-fields" } },
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
				rust_analyzer = { enabled = false },
				ts_ls = {
					filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
				},
				eslint = {},
				html = {},
				cssls = {},
				emmet_language_server = {},
				bashls = {},
				clangd = {},
				gopls = {},
				dockerls = {},
				docker_compose_language_service = {},
				marksman = {},
			},
		},
	},
	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = { "bacon" },
		},
	},
}
