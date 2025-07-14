return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		keys = {
			{
				"<leader>zz",
				"<cmd>:lua Snacks.zen()<CR>",
			},
		},
		opts = {
			animate = { enabled = true },
			bufdelete = { enabled = true },
			bigfile = { enabled = true },
			dashboard = {
				enabled = true,
				sections = {
					{ section = "header" },
					{ section = "keys",   gap = 1, padding = 1 },
					{ section = "startup" },
					-- {
					-- 	section = "terminal",
					-- 	cmd = "pokemon-colorscripts -r --no-title; sleep .1",
					-- 	random = 10,
					-- 	pane = 2,
					-- 	indent = 4,
					-- 	height = 30,
					-- },
				},
			},
			explorer = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			picker = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = false },
			statuscolumn = { enabled = true, folds = { open = true, git_hl = true } },
			zen = { enabled = true },
			words = { enabled = true },
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require('lualine').setup({
				options = {
					theme = 'pywal',
				},
				sections = {
					lualine_a = {
						function()
							local reg = vim.fn.reg_recording()
							if reg ~= "" then
								return "Recording @" .. reg
							else
								local mode = vim.api.nvim_get_mode().mode
								local mode_map = {
									n = 'NORMAL',
									i = 'INSERT',
									v = 'VISUAL',
									V = 'V-LINE',
									['^V'] = 'V-BLOCK',
									c = 'COMMAND',
									R = 'REPLACE',
									s = 'SELECT',
									S = 'S-LINE',
									['^S'] = 'S-BLOCK',
									t = 'TERMINAL',
								}
								return mode_map[mode] or mode:upper()
							end
						end,
					},
				},
			})
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		event = "VeryLazy",
		opts = {},
		config = function()
			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }
				vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
			end

			vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
			require("toggleterm").setup({
				hide_numbers = true,
				autochdir = true,
				persistent_size = true,
				open_mapping = [[<C-Bslash>]],
			})
			vim.keymap.set(
				{ "n", "t" },
				"<leader>tv",
				"<cmd>ToggleTerm direction=vertical size=80<CR>",
				{ desc = "toggle vertical terminal" }
			)
			vim.keymap.set(
				{ "n", "t" },
				"<leader>tf",
				"<cmd>ToggleTerm direction=float<CR>",
				{ desc = "toggle floating terminal" }
			)
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					-- signature = {
					-- 	enabled = false
					-- },
					-- override = {
					-- 	["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					-- 	["vim.lsp.util.stylize_markdown"] = true,
					-- 	["cmp.entry.get_documentation"] = true,
					-- },
				},
				-- presets = {
				-- 	bottom_search = true,
				-- 	command_palette = true,
				-- 	long_message_to_split = true,
				-- 	inc_rename = false,
				-- },
			})
		end,
	},
	{
		"stevearc/aerial.nvim",
		event = "BufRead",
		opts = {},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("aerial").setup({
				on_attach = function(bufnr)
					vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
					vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
				end,
			})
			vim.keymap.set("n", "<leader><leader>a", "<cmd>AerialToggle!<CR>")
		end,
	},
}
