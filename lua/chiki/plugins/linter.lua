vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})

return {
	{
		"mfussenegger/nvim-lint",
		event = "BufEnter",
		config = function()
			require("lint").linters_by_ft = {
				lua = { "luacheck" },
				go = { "golangcilint" },
				python = { "ruff" },
				-- markdown = { "markdownlint" --[[ "write-good" ]] },
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },


			}
		end,
	},
}
