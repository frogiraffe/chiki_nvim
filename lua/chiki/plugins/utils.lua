return {
	{
		"folke/flash.nvim",
		event = "BufReadPost",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					-- default options: exact mode, multi window, all directions, with a backdrop
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"m",
				mode = { "n", "o", "x" },
				function()
					-- show labeled treesitter nodes around the cursor
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					-- jump to a remote location to execute the operator
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "n", "o", "x" },
				function()
					-- show labeled treesitter nodes around the search matches
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
						enabled = false,
					},
				},
			})
			local Config = require("flash.config")
			local Char = require("flash.plugins.char")
			for _, motion in ipairs({ "f", "t", "F", "T" }) do
				vim.keymap.set({ "n", "x", "o" }, motion, function()
					require("flash").jump(Config.get({
						mode = "char",
						search = {
							mode = Char.mode(motion),
							max_length = 1,
						},
						label = { after = { 0, 0 }, style = "overlay", rainbow = { enabled = false } },
					}, Char.motions[motion]))
				end)
			end
		end,
	},
	{
		"echasnovski/mini.nvim",
		-- event = "BufReadPost",
		-- version = false,
		config = function()
			-- require("mini.ai").setup()
			require("mini.move").setup({
				mappings = {
					up = "<S-k>",
					left = "<S-h>",
					right = "<S-l>",
					down = "<S-j>",
				},
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPost", "BufNewFile" },
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
			{ "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
			{ "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
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
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"nacro90/numb.nvim",
		event = "BufReadPost",
		opts = {},
		-- config = function()
		--     require('numb').setup()
		-- end,
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
			-- may set any options here
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
	{
		"numToStr/Comment.nvim",
		event = "BufReadPost",
		opts = {},
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
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
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir = {
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 1000,
					ignore_whitespace = false,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil, -- Use default
				max_file_length = 40000, -- Disable if file is longer than this (in lines)
				preview_config = {
					-- Options passed to nvim_open_win
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
				yadm = {
					enable = false,
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
						-- str width returned from truncate() may less than 2nd argument, need padding
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
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end,
				fold_virt_text_handler = handler,
			})
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = "BufEnter",
		opts = {},
		-- config = function()
		--     require('colorizer').setup()
		-- end,
	},
	-- 	{
	-- 		"folke/persistence.nvim",
	-- 		event = "BufReadPre",
	-- 		opts = { options = { "buffers", "curdir", "tabpages", "winsize" } },
	-- 		-- stylua: ignore
	-- 		keys = {
	-- 			{ "<leader>qs", function() require("persistence").load() end,                desc = "Restore Session" },
	-- 			{ "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
	-- 			{
	-- 				"<leader>qd",
	-- 				function() require("persistence").stop() end,
	-- 				desc =
	-- 				"Don't Save Current Session"
	-- 			},
	-- 		}
	-- ,
	-- 	},
	{ "tpope/vim-repeat", event = "VeryLazy" },
	{
		"AckslD/nvim-neoclip.lua",
		event = "VeryLazy",
		config = function()
			require("neoclip").setup()
		end,
	},
	{
		"andweeb/presence.nvim",
		lazy = true,
		priority = 900,
		config = function()
			require("presence").setup({
				neovim_image_text = "This is just perfect",
				line_number_text = "Line %s/%s",
				editing_text = "Editing %s", -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
				file_explorer_text = "Browsing %s", -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
				git_commit_text = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
				plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
				reading_text = "Reading %s", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
				workspace_text = "Working on %s", -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
			})
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
		"ahmedkhalf/project.nvim",
		event = "VeryLazy",
		config = function()
			require("project_nvim").setup({})
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
	-- Lua
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		opts = { options = { "buffers" } },
		keys = {
			{
				"<leader>qs",
				function()
					require("persistence").load()
				end,
				desc = "Restore Session",
			},
			{
				"<leader>ql",
				function()
					require("persistence").load({ last = true })
				end,
				desc = "Restore Last Session",
			},
			{
				"<leader>qd",
				function()
					require("persistence").stop()
				end,
				desc = "Don't Save Current Session",
			},
		},
	},
	{ -- This plugin
		"Zeioth/compiler.nvim",
		cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
		dependencies = { "stevearc/overseer.nvim" },
		opts = {},
	},
	{ -- The task runner we use
		"stevearc/overseer.nvim",
		commit = "400e762648b70397d0d315e5acaf0ff3597f2d8b",
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
		"nvim-pack/nvim-spectre",
		event = "VeryLazy",
		config = function()
			vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', {
				desc = "Toggle Spectre",
			})
			vim.keymap.set("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
				desc = "Search current word",
			})
			vim.keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
				desc = "Search current word",
			})
			vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
				desc = "Search on current file",
			})
		end,
	},
}
