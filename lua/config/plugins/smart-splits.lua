return {
	{
		"mrjones2014/smart-splits.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<A-C-h>",
				function()
					require("smart-splits").resize_left()
				end,
				mode = "n",
				desc = "Resize left",
			},
			{
				"<A-C-j>",
				function()
					require("smart-splits").resize_down()
				end,
				mode = "n",
				desc = "Resize down",
			},
			{
				"<A-C-k>",
				function()
					require("smart-splits").resize_up()
				end,
				mode = "n",
				desc = "Resize up",
			},
			{
				"<A-C-l>",
				function()
					require("smart-splits").resize_right()
				end,
				mode = "n",
				desc = "Resize right",
			},
			-- moving between splits
			{
				"<C-h>",
				function()
					require("smart-splits").move_cursor_left()
				end,
				mode = "n",
				desc = "Move left",
			},
			{
				"<C-j>",
				function()
					require("smart-splits").move_cursor_down()
				end,
				mode = "n",
				desc = "Move down",
			},
			{
				"<C-k>",
				function()
					require("smart-splits").move_cursor_up()
				end,
				mode = "n",
				desc = "Move up",
			},
			{
				"<C-l>",
				function()
					require("smart-splits").move_cursor_right()
				end,
				mode = "n",
				desc = "Move right",
			},
			{
				"<leader>bh",
				function()
					require("smart-splits").swap_buf_left()
				end,
				mode = "n",
				desc = "Swap left",
			},
			{
				"<leader>bj",
				function()
					require("smart-splits").swap_buf_down()
				end,
				mode = "n",
				desc = "Swap down",
			},
			{
				"<leader>bk",
				function()
					require("smart-splits").swap_buf_up()
				end,
				mode = "n",
				desc = "Swap up",
			},
			{
				"<leader>bl",
				function()
					require("smart-splits").swap_buf_right()
				end,
				mode = "n",
				desc = "Swap right",
			},
		},
		config = function()
			require("smart-splits").setup({
				resize_mode = {
					quit_key = "<ESC>",
					hooks = {
						on_leave = require("bufresize").register,
					},
				},
			})
		end,
	},
	{
		"kwkarlwang/bufresize.nvim",
		config = function()
			require("bufresize").setup({
				resize = {
					keys = {},
					trigger_events = { "VimResized" },
				},
			})
		end,
	},
}
