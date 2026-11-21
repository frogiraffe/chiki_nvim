return {
	{
		"mrjones2014/smart-splits.nvim",
		event = "VeryLazy",
		dependencies = {
			"kwkarlwang/bufresize.nvim",
			{ "smart-splits-nvim/backend-tmux", main = "smart-splits-backend-tmux" },
		},
		opts = {
			mux = {
				backend = "smart-splits-backend-tmux",
				warn_if_unusable = false,
			},
		},
		config = function(_, opts)
			require("smart-splits").setup(opts)
			-- tmux never moves out of a floating pane by direction (every pane_at_* reads 0 there),
			-- so at Neovim's edge in a floating pane go back to the tiled pane you came from, as
			-- Ctrl+h/j/k/l do outside Neovim (~/.config/tmux/scripts/float-focus.sh).
			local backend = require("smart-splits-backend-tmux")
			local move = backend.move
			backend.move = function(direction, move_opts)
				local pane = vim.env.TMUX_PANE
				local script = vim.fn.expand("~/.config/tmux/scripts/float-focus.sh")
				if pane and vim.fn.executable(script) == 1 then
					local out = vim.system({ "tmux", "display", "-p", "-t", pane, "#{pane_floating_flag}" }, { text = true }):wait()
					if vim.trim(out.stdout or "") == "1" then
						vim.system({ script, "back", pane }):wait()
						return true
					end
				end
				return move(direction, move_opts)
			end
		end,
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
				"<C-\\>",
				-- smart-splits v3 removed move_cursor_previous(); use the native equivalent.
				"<cmd>wincmd p<cr>",
				mode = "n",
				desc = "Move to previous split",
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
	},
	{
		"kwkarlwang/bufresize.nvim",
		lazy = true,
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
