return {
	"ggandor/leap.nvim",
	dependencies = {
		{
			"ggandor/flit.nvim",
		},
	},
	lazy = true,
	keys = {
		{
			"ga",
			function()
				require("leap.remote").action()
			end,
			mode = { "n", "x", "o" },
			desc = "Leap remote action",
		},
		{
			"<C-Space>",
			function()
				require("leap.treesitter").select()
			end,
		},
	},
	config = function()
		require("leap").set_default_mappings() -- Exclude whitespace and the middle of alphabetic words from preview:
		--   foobar[baaz] = quux
		--   ^----^^^--^^-^-^--^
		require("leap").opts.preview_filter = function(ch0, ch1, ch2)
			return not (ch1:match("%s") or ch0:match("%a") and ch1:match("%a") and ch2:match("%a"))
		end
		require("leap").opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }
		require("leap.user").set_repeat_keys("<enter>", "<backspace>")
	end,
}
