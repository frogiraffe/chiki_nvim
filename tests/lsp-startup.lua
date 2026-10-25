-- Run with the real config and installed plugins:
-- nvim --headless -i NONE -n '+lua dofile("tests/lsp-startup.lua")'
local dir = vim.fn.tempname()
vim.fn.mkdir(dir, "p")
vim.fn.writefile({ "import os", "print(os.name)" }, dir .. "/probe.py")
vim.fn.writefile({}, dir .. "/requirements.txt")

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.schedule(function()
			local ok, err = pcall(function()
				vim.cmd.edit(dir .. "/probe.py")
				assert(vim.bo.filetype == "python", "expected python filetype, got " .. vim.inspect(vim.bo.filetype))
				assert(
					vim.wait(10000, function()
						local clients = {}
						for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
							clients[client.name] = client.initialized
						end
						return clients.basedpyright
							and clients.ruff
							and vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] ~= nil
					end),
					"expected initialized Python LSP clients and Treesitter"
				)
				print("PASS: first file opened after startup has Python filetype, Treesitter and both LSP clients")
			end)
			vim.fn.delete(dir, "rf")
			if not ok then
				print(err)
			end
			vim.cmd(ok and "qa!" or "cquit 1")
		end)
	end,
})
