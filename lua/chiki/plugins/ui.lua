return {
	{
		"stevearc/dressing.nvim",
		lazy = true,
		opts = {},
		config = function()
			-- vim.ui.select = function(...)
			-- 	require("lazy").load({ plugins = { "dressing.nvim" } })
			-- 	return vim.ui.select(...)
			-- end
			-- ---@diagnostic disable-next-line: duplicate-set-field
			-- vim.ui.input = function(...)
			-- 	require("lazy").load({ plugins = { "dressing.nvim" } })
			-- 	return vim.ui.input(...)
			-- end
			require("dressing").setup({
				input = {
					-- Set to false to disable the vim.ui.input implementation
					enabled = true,

					-- Default prompt string
					default_prompt = "Input:",

					-- Can be 'left', 'right', or 'center'
					title_pos = "left",

					-- When true, <Esc> will close the modal
					insert_only = true,

					-- When true, input will start in insert mode.
					start_in_insert = true,

					-- These are passed to nvim_open_win
					border = "rounded",
					-- 'editor' and 'win' will default to being centered
					relative = "cursor",

					-- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
					prefer_width = 40,
					width = nil,
					-- min_width and max_width can be a list of mixed types.
					-- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
					max_width = { 140, 0.9 },
					min_width = { 20, 0.2 },

					buf_options = {},
					win_options = {
						-- Disable line wrapping
						wrap = false,
						-- Indicator for when text exceeds window
						list = true,
						listchars = "precedes:…,extends:…",
						-- Increase this for more context when text scrolls off the window
						sidescrolloff = 0,
					},

					-- Set to `false` to disable
					mappings = {
						n = {
							["<Esc>"] = "Close",
							["<CR>"] = "Confirm",
						},
						i = {
							["<C-c>"] = "Close",
							["<CR>"] = "Confirm",
							["<Up>"] = "HistoryPrev",
							["<Down>"] = "HistoryNext",
						},
					},

					override = function(conf)
						-- This is the config that will be passed to nvim_open_win.
						-- Change values here to customize the layout
						return conf
					end,

					-- see :help dressing_get_config
					get_config = nil,
				},
				select = {
					-- Set to false to disable the vim.ui.select implementation
					enabled = true,

					-- Priority list of preferred vim.select implementations
					backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },

					-- Trim trailing `:` from prompt
					trim_prompt = true,

					-- Options for telescope selector
					-- These are passed into the telescope picker directly. Can be used like:
					-- telescope = require('telescope.themes').get_ivy({...})
					telescope = nil,

					-- Options for fzf selector
					fzf = {
						window = {
							width = 0.5,
							height = 0.4,
						},
					},

					-- Options for fzf-lua
					fzf_lua = {
						-- winopts = {
						--   height = 0.5,
						--   width = 0.5,
						-- },
					},

					-- Options for nui Menu
					nui = {
						position = "50%",
						size = nil,
						relative = "editor",
						border = {
							style = "rounded",
						},
						buf_options = {
							swapfile = false,
							filetype = "DressingSelect",
						},
						win_options = {
							winblend = 0,
						},
						max_width = 80,
						max_height = 40,
						min_width = 40,
						min_height = 10,
					},

					-- Options for built-in selector
					builtin = {
						-- Display numbers for options and set up keymaps
						show_numbers = true,
						-- These are passed to nvim_open_win
						border = "rounded",
						-- 'editor' and 'win' will default to being centered
						relative = "editor",

						buf_options = {},
						win_options = {
							cursorline = true,
							cursorlineopt = "both",
						},

						-- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
						-- the min_ and max_ options can be a list of mixed types.
						-- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
						width = nil,
						max_width = { 140, 0.8 },
						min_width = { 40, 0.2 },
						height = nil,
						max_height = 0.9,
						min_height = { 10, 0.2 },

						-- Set to `false` to disable
						mappings = {
							["<Esc>"] = "Close",
							["<C-c>"] = "Close",
							["<CR>"] = "Confirm",
						},

						override = function(conf)
							-- This is the config that will be passed to nvim_open_win.
							-- Change values here to customize the layout
							return conf
						end,
					},

					-- Used to override format_item. See :help dressing-format
					format_item_override = {},

					-- see :help dressing_get_config
					-- get_config = function(opts)
					-- 	if opts.kind == "codeaction" then
					-- 		return {
					-- 			backend = "nui",
					-- 			nui = {
					-- 				relative = "editor",
					-- 				max_width = 40,
					-- 			},
					-- 		}
					-- 	end
					-- end,
				},
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		event = "BufEnter",
		keys = {
			{ "<S-L>", "<cmd>BufferLineCycleNext<CR>" },
			{ "<S-H>", "<cmd>BufferLineCyclePrev<CR>" },
			{ "<leader>bp", "<cmd>BufferLinePick<CR>" },
		},
		config = function()
			require("bufferline").setup({
				options = {},
			})
		end,
	},
	{ "arkav/lualine-lsp-progress", event = "VeryLazy" },
	{
		"nvim-lualine/lualine.nvim",
		event = "BufEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "gruvbox-material",
					icons_enabled = true,
				},
				sections = {
					lualine_c = {
						"lsp_progress",
					},
					lualine_x = {
						{
							require("noice").api.statusline.mode.get,
							cond = require("noice").api.statusline.mode.has,
							color = { fg = "#ff9e64" },
						},
					},
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
				dashboard.button("s", "󰱼  Find text", ":Telescope live_grep <CR>"),
				dashboard.button("p", "  Project list", ":Telescope projects<CR>"),
				dashboard.button("l", "  Load Last Session", ":lua require('persistence').load()<CR>"),
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
			version = "*",
			-- cmd = "ToggleTerm",
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
		opts = { window = {
			width = 120,
		} },
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
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			--   If not available, we use `mini` as the fallback
			{
				"rcarriga/nvim-notify",
				event = "BufRead",
				opts = { background_colour = "#000000", render = "compact", top_down = true, timeout = 1500 },
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
					lsp_doc_border = true, -- add a border to hover docs and signature help
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
				routes = {
					{
						filter = {
							event = "msg_show",
							kind = "",
							find = "written",
						},
						opts = { skip = true },
					},
				},
			})
		end,
	},
	{
		"kosayoda/nvim-lightbulb",
		event = "BufEnter",
		config = function()
			require("nvim-lightbulb").setup({
				autocmd = { enabled = true },
			})
		end,
	},
	{
		"aznhe21/actions-preview.nvim",
		event = "BufEnter",
		config = function()
			vim.keymap.set({ "v", "n" }, "ca", require("actions-preview").code_actions)
		end,
	},
}
