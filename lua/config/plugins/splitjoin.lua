return {
	"Wansmer/treesj",
	keys = {
		{ "<leader>jm", "<cmd>TSJToggle<cr>", desc = "Toggle Split/Join" },
		{ "<leader>jj", "<cmd>TSJJoin<cr>", desc = "Join" },
		{ "<leader>js", "<cmd>TSJSplit<cr>", desc = "Split" },
	},
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("treesj").setup({})
	end,
}
