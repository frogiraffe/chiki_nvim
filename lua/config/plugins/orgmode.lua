return {
	{
		"nvim-orgmode/orgmode",
		event = "VeryLazy",
		ft = { "org" },
		dependencies = {
			{ "akinsho/org-bullets.nvim", ft = { "org" } },
			{
				"chipsenkbeil/org-roam.nvim",
				event = "VeryLazy",
				ft = { "org" },
				config = function()
					require("org-roam").setup({
						directory = "~/sync/orgfiles/",
						-- org_files = {
						-- 	"~/sync/orgfiles/roam/",
						-- },
					})
				end,
			},
		},
		config = function()
			-- Setup orgmode
			require("orgmode").setup({
				org_agenda_files = "~/sync/orgfiles/**/*",
				org_default_notes_file = "~/sync/orgfiles/refile.org",
				org_capture_templates = {
					T = {
						description = "Todo",
						template = "* TODO %?\n %u",
						target = "~/sync/orgfiles/todo.org",
					},
					J = {
						description = "Journal",
						template = "\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?",
						target = "~/sync/orgfiles/journal/%<%Y-%m>.org",
					},
					e = {
						description = "Event",
						subtemplates = {
							r = {
								description = "recurring",
								template = "** %?\n %T",
								target = "~/sync/orgfiles/calendar.org",
								headline = "recurring",
							},
							o = {
								description = "one-time",
								template = "** %?\n %T",
								target = "~/sync/orgfiles/calendar.org",
								headline = "one-time",
							},
						},
					},
				},
			})
			require("org-bullets").setup()

			-- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
			-- add ~org~ to ignore_install
			-- require('nvim-treesitter.configs').setup({
			--   ensure_installed = 'all',
			--   ignore_install = { 'org' },
			-- })
		end,
	},
}
