return {
	{
		"folke/tokyonight.nvim",
		lazy = true,
		-- Renkleri artik Noctalia dinamik paleti suruyor (lua/plugins/base16.lua -> matugen).
		-- Sabit tokyonight'a donmek istersen asagiyi geri ac ve lazy.lua'daki "plugins" import'unu kaldir:
		-- config = function() vim.cmd.colorscheme("tokyonight-night") end,
	},
}
