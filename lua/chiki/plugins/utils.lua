return {
	{
		'brenoprata10/nvim-highlight-colors',
		config = function()
			require('nvim-highlight-colors').setup({})
		end
	},
	{
		"RRethy/vim-illuminate",
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"M",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
		},
		config = function()
			require("flash").setup({
				label = {
					rainbow = {
						enabled = false,
					},
				},
				modes = {
					char = {
						enabled = true,
						jump_labels = true,
					},
				},
			})
		end,
	},
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.ai").setup()
			require("mini.move").setup({
				mappings = {
					up = "<S-k>",
					left = "<S-h>",
					right = "<S-l>",
					down = "<S-j>",
				},
			})
			require("mini.icons").setup({
				require("mini.icons").mock_nvim_web_devicons()
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		lazy = true,
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next todo comment",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Previous todo comment",
			},
			{ "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
			{ "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME,NOTE<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
		},
		opts = {},
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "BufReadPost",
		opts = {},
	},
	{
		"nacro90/numb.nvim",
		event = "BufReadPost",
		opts = {},
	},
	{
		"max397574/better-escape.nvim",
		event = "InsertCharPre",
		config = function()
			require("better_escape").setup({
				timeout = 100,
			})
		end,
	},
	{
		"andymass/vim-matchup",
		event = { "BufRead" },
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
	{
		"numToStr/Comment.nvim",
		event = "BufReadPost",
		opts = {},
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signcolumn = true,
				numhl = true,
				linehl = false,
				word_diff = false,
				watch_gitdir = {
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame = false,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol",
					delay = 1000,
					ignore_whitespace = false,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil,
				max_file_length = 40000,
				preview_config = {
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
			})
		end,
	},
	{
		"tpope/vim-fugitive",
		event = "VeryLazy",
	},
	{
		"kevinhwang91/nvim-ufo",
		event = "BufRead",
		dependencies = "kevinhwang91/promise-async",
		config = function()
			vim.keymap.set("n", "zO", require("ufo").openAllFolds, { desc = "Open all folds" })
			vim.keymap.set("n", "zC", require("ufo").closeAllFolds, { desc = "Close all folds" })
			vim.keymap.set("n", "K", function()
				local winid = require("ufo").peekFoldedLinesUnderCursor()
				if not winid then
					vim.lsp.buf.hover()
				end
			end)
			local handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = ("  %d "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end
			require("ufo").setup({
				provider_selector = function()
					return { "treesitter", "indent" }
				end,
				fold_virt_text_handler = handler,
			})
		end,
	},
	{ "tpope/vim-repeat",             event = "VeryLazy" },
	{
		"AckslD/nvim-neoclip.lua",
		event = "VeryLazy",
		config = function()
			require("neoclip").setup()
		end,
	},
	{
		"nmac427/guess-indent.nvim",
		event = "BufRead",
		config = function()
			require("guess-indent").setup({
				ignored_filetypes = { "markdown", "text", "txt" },
			})
		end,
	},
	{
		"cappyzawa/trim.nvim",
		event = "BufRead",
		config = function()
			require("trim").setup({
				ft_blocklist = { "markdown" },
			})
		end,
	},
	{
		"Zeioth/compiler.nvim",
		cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
		dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
		opts = {},
	},
	{
		"stevearc/overseer.nvim",
		commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
		cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
		opts = {
			task_list = {
				direction = "bottom",
				min_height = 25,
				max_height = 25,
				default_detail = 1,
			},
		},
	},
	{
		'MagicDuck/grug-far.nvim',
		config = function()
			vim.keymap.set("n", "<leader>G", "<cmd>GrugFar<CR>", { desc = "Grug" })
			require('grug-far').setup({})
		end,
	},
	{ "cpea2506/relative-toggle.nvim" },
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {},
	},
	{ "nvzone/volt", lazy = true },
	{ "nvzone/menu", lazy = true },
	{
		"OXY2DEV/markview.nvim",
		lazy = true,
		-- dependencies = {
		--     "saghen/blink.cmp"
		-- },
	},
	{
		"amitds1997/remote-nvim.nvim",
		version = "*",              -- Pin to GitHub releases
		dependencies = {
			"nvim-lua/plenary.nvim", -- For standard functions
			"MunifTanjim/nui.nvim", -- To build the plugin UI
			"nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
		},
		config = true,
	},
}
