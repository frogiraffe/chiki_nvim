-- Loaded by LazyVim on VeryLazy, after lazyvim.config.autocmds. LazyVim already
-- provides checktime, yank highlight, last location, close-with-q (incl. dbout),
-- JSON conceal, auto-create-dir and wrap/spell for markdown/text/gitcommit.
-- Defaults: https://www.lazyvim.org/configuration/general#auto-commands
local function augroup(name)
	return vim.api.nvim_create_augroup("chiki_" .. name, { clear = true })
end

-- LaTeX/BibTeX are prose too.
vim.api.nvim_create_autocmd("FileType", {
	desc = "Wrap and spell-check LaTeX/BibTeX",
	group = augroup("prose"),
	pattern = { "tex", "latex", "bib" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- No format-on-save for C/C++ (LazyVim's autoformat is otherwise global).
vim.api.nvim_create_autocmd("FileType", {
	desc = "Disable autoformat for C/C++",
	group = augroup("no_autoformat"),
	pattern = { "c", "cpp" },
	callback = function(event)
		vim.b[event.buf].autoformat = false
	end,
})
