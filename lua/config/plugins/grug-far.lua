return {
	{
		"MagicDuck/grug-far.nvim",
		cmd = { "GrugFar", "GrugFarWithin" },
		keys = {
			{
				"<leader>sr",
				function()
					local ext = vim.bo.buftype == "" and vim.fn.expand("%:e") or nil
					require("grug-far").open({
						transient = true,
						prefills = {
							filesFilter = ext and ext ~= "" and "*." .. ext or nil,
						},
					})
				end,
				mode = { "n", "x" },
				desc = "Search and Replace",
			},
		},
		opts = { headerMaxWidth = 80 },
	},
}
