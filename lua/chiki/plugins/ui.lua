return {
	{
		"stevearc/dressing.nvim",
		lazy = true,
		opts = {},
	},
	{
		"nvim-tree/nvim-tree.lua",
		event = "VeryLazy",
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<leader>e", "<cmd>:NvimTreeToggle<CR>", { desc = "tree toggle" } },
			{ "<leader>fe", "<cmd>:NvimTreeFindFileToggle<CR>", { desc = "tree toggle" } },
		},
		config = function()
			local function open_tab_silent(node)
				local api = require("nvim-tree.api")

				api.node.open.tab(node)
				vim.cmd.tabprev()
			end
			require("nvim-tree").setup({
				sync_root_with_cwd = true,
				respect_buf_cwd = true,
				renderer = {},
				view = {
					adaptive_size = false,
					side = "left",
					width = 30,
					preserve_window_proportions = true,
				},

				update_focused_file = { enable = true, update_root = true },
			})
			vim.keymap.set("n", "T", open_tab_silent, { desc = "Open Tab Silent" })
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		keys = {
			{ "<S-L>", "<cmd>BufferLineCycleNext<CR>" },
			{ "<S-H>", "<cmd>BufferLineCyclePrev<CR>" },
		},
		config = function()
			require("bufferline").setup({})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
				},
			})
		end,
	},
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			dashboard.section.header.val = {
				"                                        ▟▙            ",
				"                                        ▝▘            ",
				"██▃▅▇█▆▖  ▗▟████▙▖   ▄████▄   ██▄  ▄██  ██  ▗▟█▆▄▄▆█▙▖",
				"██▛▔ ▝██  ██▄▄▄▄██  ██▛▔▔▜██  ▝██  ██▘  ██  ██▛▜██▛▜██",
				"██    ██  ██▀▀▀▀▀▘  ██▖  ▗██   ▜█▙▟█▛   ██  ██  ██  ██",
				"██    ██  ▜█▙▄▄▄▟▊  ▀██▙▟██▀   ▝████▘   ██  ██  ██  ██",
				"▀▀    ▀▀   ▝▀▀▀▀▀     ▀▀▀▀       ▀▀     ▀▀  ▀▀  ▀▀  ▀▀",
			}

			dashboard.section.buttons.val = {
				dashboard.button("f", "󰍉  Find file", ":Telescope find_files <CR>"),
				dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
				dashboard.button(
					"l",
					" > Last Session",
					'<cmd>:lua require("persistence").load({ last = true })<CR>'
				),
				dashboard.button("t", "󰱼  Find text", ":Telescope live_grep <CR>"),
				dashboard.button("c", "  Configuration", ":e ~/.config/nvim/lua/chiki/<CR>"),
				dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
			}
			dashboard.section.footer.opts.hl = "Type"
			dashboard.section.header.opts.hl = "Include"
			dashboard.section.buttons.opts.hl = "Keyword"

			dashboard.opts.opts.noautocmd = true
			return dashboard
		end,
		config = function(_, opts)
			-- Footer
			require("alpha").setup(opts.config)
			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				desc = "Add Alpha dashboard footer",
				once = true,
				callback = function()
					local stats = require("lazy").stats()
					local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
					opts.section.footer.val = {
						" ",
						" ",
						" ",
						"Loaded " .. stats.count .. " plugins  in " .. ms .. "ms",
						"------cats are awesome------",
					}
					opts.section.footer.opts.hl = "DashboardFooter"
					vim.cmd("highlight DashboardFooter guifg=#D29B68")
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},
	{
		{
			"akinsho/toggleterm.nvim",
			-- cmd = { "ToggleTerm", "TermExec" },
			version = "*",
			opts = { --[[ things you want to change go here]]
			},
			config = function()
				function _G.set_terminal_keymaps()
					local opts = { buffer = 0 }
					vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
					vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
					vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
					vim.keymap.set({ "n", "t" }, "<C-c>", '<Cmd>TermExec cmd="<C-c>"<CR>')
				end

				-- if you only want these mappings for toggle term use term://*toggleterm#* instead
				vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
				require("toggleterm").setup({
					hide_numbers = true,
					shade_terminals = true,
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
	},
	-- Lua
	{
		"folke/zen-mode.nvim",
		-- cmd = { "ZenMode" },
		dependencies = "folke/twilight.nvim",
		opts = {},
		keys = {
			{
				"<leader>zZ",
				'<cmd>:lua require("zen-mode").toggle({plugins = {twilight = {enabled = false}}})<CR>',
				{ desc = "zen mode" },
			},
			{
				"<leader>zz",
				"<cmd>ZenMode<CR>",
				{ desc = "zen mode /twilight" },
			},
		},
	},
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		opts = {},
		config = function()
			require("fidget").setup({
				window = { blend = 0 },
			})
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			{
				"rcarriga/nvim-notify",
				event = "BufRead", --[[ opts = { background_colour = "#000000" } ]]
			},
		},
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				}, -- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
				cmdline = {
					-- view = "cmdline",
				},
				views = {
					mini = {
						win_options = {
							winblend = 1,
						},
					},
				},
			})
		end,
	},
}
