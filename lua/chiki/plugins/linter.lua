return {
	{
		"mfussenegger/nvim-lint",
		event = "BufEnter",
		config = function()
			require("lint").linters_by_ft = {
				lua = { "luacheck" },
			}
		end,
	},
}
