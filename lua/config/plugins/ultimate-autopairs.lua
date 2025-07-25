return {
	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		branch = "v0.6", --recommended as each new version will have breaking changes
		opts = {
			taobut = { enable = true },
			cmap = true,
			space2 = { enable = true },
			fastwarp = { multi = true, {}, { faster = true, map = "<A-e>", cmap = "<A-e>" } },
		},
	},
}
