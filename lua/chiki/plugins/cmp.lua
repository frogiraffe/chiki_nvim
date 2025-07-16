return {
	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		branch = "v0.6",
		opts = {},
		config = function()
			require("ultimate-autopair").setup({
				tabout = {
					enable = true,
				},
				cmap = true,
				space2 = { enable = true },
				fastwarp = { multi = true, {}, { faster = true, map = '<C-A-e>', cmap = '<C-A-e>' } }
			})
		end,
	},
	{
		'abecodes/tabout.nvim',
		config = function()
			require('tabout').setup {
				tabkey = '<Tab>',
				backwards_tabkey = '<S-Tab>',
				act_as_tab = true,
				act_as_shift_tab = false,
				default_tab = '<C-t>',
				enable_backwards = true,
				completion = false,
				tabouts = {
					{ open = "'", close = "'" },
					{ open = '"', close = '"' },
					{ open = '`', close = '`' },
					{ open = '(', close = ')' },
					{ open = '[', close = ']' },
					{ open = '{', close = '}' }
				},
				ignore_beginning = true,
				exclude = {}
			}
		end,
	},
}
