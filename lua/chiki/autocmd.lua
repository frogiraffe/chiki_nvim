vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "r,rmd,quarto",
	command = "setlocal shiftwidth=2 tabstop=2 expandtab",
})
