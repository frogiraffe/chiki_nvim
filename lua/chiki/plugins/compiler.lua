return {
	{ -- This plugin
		"Zeioth/compiler.nvim",
		cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
		dependencies = { "stevearc/overseer.nvim" },
		keys = {
			{ "<F6>", "<cmd>CompilerOpen<cr>", { noremap = true, silent = true } },

			{
				"<S-F6>",
				function()
					vim.cmd("CompilerStop") -- (Optional, to dispose all tasks before redo)
					vim.cmd("CompilerRedo")
				end,
				{ noremap = true, silent = true },
			},

			-- Toggle compiler results
			{ "<S-F7>", "<cmd>CompilerToggleResults<cr>", { noremap = true, silent = true } },
		},
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
				bindings = {
					["q"] = function()
						vim.cmd("OverseerClose")
					end,
				},
			},
		},
	},
}
