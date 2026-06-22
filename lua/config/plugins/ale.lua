return {
	{
		"dense-analysis/ale",
		-- Only load for the filetypes we actually lint (keeps startup fast).
		ft = { "ruby", "text", "markdown" },
		-- ALE globals must be set before the plugin loads, so use `init`.
		init = function()
			local g = vim.g
			g.ale_disable_lsp = 1
			g.ale_lsp_show_message_severity = "disabled"
			g.ale_echo_cursor = 0

			g.ale_ruby_rubocop_auto_correct_all = 1

			g.ale_linters = {
				ruby = { "rubocop", "ruby" },
				text = { "proselint" },
				markdown = { "proselint" },
				-- rust = { "clippy" },
			}
			g.ale_sign_column_always = 1
		end,
	},
}
