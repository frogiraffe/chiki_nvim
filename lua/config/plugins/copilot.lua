return {
	{
		"zbirenbaum/copilot.lua",
		requires = {
			"copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
		},
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		event = "VeryLazy",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		config = function()
			-- Quick chat keybinding
			vim.keymap.set("n", "<leader>ccq", function()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					require("CopilotChat").ask(input, {
						selection = require("CopilotChat.select").buffer,
					})
				end
			end, { desc = "CopilotChat - Quick chat" })
		end,
		opts = {
			model = "gemini-3.0-pro",
		},
	},
}
