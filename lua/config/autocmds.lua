local function augroup(name)
	return vim.api.nvim_create_augroup("chiki_" .. name, { clear = true })
end

-- Reload files changed by another process after returning to Neovim.
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	desc = "Check for externally changed files",
	group = augroup("checktime"),
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight yanked text",
	group = augroup("highlight_yank"),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Reopen files where they were last edited.
vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Restore last cursor position",
	group = augroup("last_location"),
	callback = function(event)
		local buf = event.buf
		if vim.bo[buf].filetype == "gitcommit" or vim.b[buf].chiki_last_location then
			return
		end
		vim.b[buf].chiki_last_location = true

		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local line_count = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= line_count then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Temporary/result windows should behave like transient UI, not real files.
vim.api.nvim_create_autocmd("FileType", {
	desc = "Close transient buffers with q",
	group = augroup("close_with_q"),
	pattern = {
		"checkhealth",
		"dbout",
		"help",
		"lspinfo",
		"notify",
		"qf",
		"startuptime",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			if not vim.api.nvim_buf_is_valid(event.buf) then
				return
			end
			vim.keymap.set("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, { buffer = event.buf, silent = true, desc = "Quit buffer" })
		end)
	end,
})

-- Code stays unwrapped globally; prose gets comfortable reading defaults.
vim.api.nvim_create_autocmd("FileType", {
	desc = "Wrap and spell-check prose",
	group = augroup("prose"),
	pattern = { "markdown", "text", "gitcommit", "tex", "latex", "bib" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.spell = true
	end,
})

-- JSON should show literal quote characters even though conceal is useful for
-- Markdown/LaTeX and rendered documentation.
vim.api.nvim_create_autocmd("FileType", {
	desc = "Disable conceal in JSON",
	group = augroup("json_conceal"),
	pattern = { "json", "jsonc", "json5" },
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})

-- Saving nested/path/to/file.lua should work even when the parent folders do
-- not exist yet.
vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Create parent directories before saving",
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})
