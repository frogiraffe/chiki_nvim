vim.api.nvim_create_autocmd(
	{ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged", "TextChangedI" },
	{
		callback = function()
			require('lint').try_lint()
		end,
	}
)
