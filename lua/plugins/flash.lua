-- LazyVim already maps s / S / r / R / <c-s> to Flash.
return {
	{
		"folke/flash.nvim",
		keys = {
			-- Visual S stays with nvim-surround.
			{ "S", mode = "x", false },
		},
		---@type Flash.Config
		opts = {
			modes = {
				char = {
					jump_labels = true,
				},
				search = {
					enabled = true,
				},
			},
		},
	},
}
