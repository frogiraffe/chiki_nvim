return {
	{
		"nvim-neotest/neotest",
		cmd = { "NeoTest" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"rouge8/neotest-rust",
		},
		config = function()
			require("neotest").setup({
				adapters = {
				},
			})
		end,
	},
}
