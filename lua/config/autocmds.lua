vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Enable spell checking only for prose filetypes (not source code).
vim.api.nvim_create_autocmd("FileType", {
	desc = "Enable spell checking for prose filetypes",
	group = vim.api.nvim_create_augroup("prose-spell", { clear = true }),
	pattern = { "markdown", "text", "gitcommit", "tex", "latex", "bib" },
	callback = function()
		vim.opt_local.spell = true
	end,
})
