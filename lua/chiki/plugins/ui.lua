return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			explorer = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			picker = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = false },
			statuscolumn = { enabled = true },
			words = { enabled = true },
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			--- @param trunc_width number trunctates component when screen width is less then trunc_width
			--- @param trunc_len number truncates component to trunc_len number of chars
			--- @param hide_width number hides component when window width is smaller then hide_width
			--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
			--- return function that can format the component accordingly
			local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
				return function(str)
					local win_width = vim.fn.winwidth(0)
					if hide_width and win_width < hide_width then
						return ''
					elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
						return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
					end
					return str
				end
			end

			require 'lualine'.setup {
				lualine_a = {
					{ 'mode',                                              fmt = trunc(80, 4, nil, true) },
					{ 'filename',                                          fmt = trunc(90, 30, 50) },
					{ function() return require 'lsp-status'.status() end, fmt = trunc(120, 20, 60) }
				}
			}
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
				[[———————————No bitches?————————]],
				[[⠀⣞⢽⢪⢣⢣⢣⢫⡺⡵⣝⡮⣗⢷⢽⢽⢽⣮⡷⡽⣜⣜⢮⢺⣜⢷⢽⢝⡽⣝]],
				[[⠸⡸⠜⠕⠕⠁⢁⢇⢏⢽⢺⣪⡳⡝⣎⣏⢯⢞⡿⣟⣷⣳⢯⡷⣽⢽⢯⣳⣫⠇]],
				[[⠀⠀⢀⢀⢄⢬⢪⡪⡎⣆⡈⠚⠜⠕⠇⠗⠝⢕⢯⢫⣞⣯⣿⣻⡽⣏⢗⣗⠏⠀]],
				[[⠀⠪⡪⡪⣪⢪⢺⢸⢢⢓⢆⢤⢀⠀⠀⠀⠀⠈⢊⢞⡾⣿⡯⣏⢮⠷⠁⠀⠀⠀]],
				[[⠀⠀⠀⠈⠊⠆⡃⠕⢕⢇⢇⢇⢇⢇⢏⢎⢎⢆⢄⠀⢑⣽⣿⢝⠲⠉⠀⠀⠀⠀]],
				[[⠀⠀⠀⠀⠀⡿⠂⠠⠀⡇⢇⠕⢈⣀⠀⠁⠡⠣⡣⡫⣂⣿⠯⢪⠰⠂⠀⠀⠀⠀]],
				[[⠀⠀⠀⠀⡦⡙⡂⢀⢤⢣⠣⡈⣾⡃⠠⠄⠀⡄⢱⣌⣶⢏⢊⠂⠀⠀⠀⠀⠀⠀]],
				[[⠀⠀⠀⠀⢝⡲⣜⡮⡏⢎⢌⢂⠙⠢⠐⢀⢘⢵⣽⣿⡿⠁⠁⠀⠀⠀⠀⠀⠀⠀]],
				[[⠀⠀⠀⠀⠨⣺⡺⡕⡕⡱⡑⡆⡕⡅⡕⡜⡼⢽⡻⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
				[[⠀⠀⠀⠀⣼⣳⣫⣾⣵⣗⡵⡱⡡⢣⢑⢕⢜⢕⡝⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
				[[⠀⠀⠀⣴⣿⣾⣿⣿⣿⡿⡽⡑⢌⠪⡢⡣⣣⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
				[[⠀⠀⠀⡟⡾⣿⢿⢿⢵⣽⣾⣼⣘⢸⢸⣞⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
				[[⠀⠀⠀⠀⠁⠇⠡⠩⡫⢿⣝⡻⡮⣒⢽⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
				[[——————————————————————————————]],

			}

			dashboard.section.buttons.val = {
				dashboard.button("f", "󰍉  Find file", ":Telescope find_files <CR>"),
				dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
				dashboard.button("t", "  Settings", ":e ~/.config/nvim/init.lua<CR>"),
				dashboard.button("l", "  Load Last Session",
					":lua require('resession').load()<CR>"),
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
			event = "VeryLazy",
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
					autochdir = true,
					-- shade_terminals = true,
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
		cmd = { "ZenMode" },
		dependencies = "folke/twilight.nvim",
		opts = {
			window = {
				width = 120,
			},
		},
		keys = {
			{
				"<leader>zZ",
				'<cmd>:lua require("zen-mode").toggle({plugins = {twilight = {enabled = false}}})<CR>',
				{ desc = "Zen Mode" },
			},
			{
				"<leader>zz",
				"<cmd>ZenMode<CR>",
				{ desc = "Zen Mode /twilight" },
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
		},
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					signature = {
						enabled = false
					},
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},                 -- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim lsp_doc_border = true, -- add a border to hover docs and signature help
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
							find = "nil",
						},
						opts = { skip = true },
					},
					-- {
					-- filter = {
					-- 	event = "msg_show",
					-- 	kind = "",
					-- 	find = "written",
					-- },
					-- opts = { skip = true },
					-- },
				},
			})
		end,
	},
	{
		"stevearc/aerial.nvim",
		event = "BufRead",
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("aerial").setup({
				-- optionally use on_attach to set keymaps when aerial has attached to a buffer
				on_attach = function(bufnr)
					-- Jump forwards/backwards with '{' and '}'
					vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
					vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
				end,
			})
			-- You probably also want to set a keymap to toggle aerial
			vim.keymap.set("n", "<leader><leader>a", "<cmd>AerialToggle!<CR>")
		end,
	},
	{
		'romgrk/barbar.nvim',
		event = "VeryLazy",
		dependencies = {
			'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
			'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
		},
		opts = {
		},
		init = function() vim.g.barbar_auto_setup = false end,
		version = '^1.0.0', -- optional: only update when a new 1.x version is released
	},
}
