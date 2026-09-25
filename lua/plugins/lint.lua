-- Single linting engine for every filetype (LazyVim-style): linters are listed
-- per filetype, skipped quietly when their executable is missing, and run
-- debounced on read/write/insert-leave.
local function executable(cmd)
	return function()
		return vim.fn.executable(cmd) == 1
	end
end

local linters_by_ft = {
	sql = { "sqlfluff" },
	mysql = { "sqlfluff" },
	plsql = { "sqlfluff" },
	-- Prose and Ruby linting (formerly via ALE).
	markdown = { "proselint" },
	text = { "proselint" },
	ruby = { "rubocop", "ruby" },
}

---@type table<string, fun(buf: integer): boolean>
local conditions = {
	proselint = executable("proselint"),
	rubocop = executable("rubocop"),
	ruby = executable("ruby"),
	-- Mason may still be installing SQLFluff when the first SQL buffer is
	-- opened. The dialect is resolved per buffer right before linting so linting
	-- and formatting share config/sql.lua's policy.
	sqlfluff = function(buf)
		if vim.fn.executable("sqlfluff") ~= 1 then
			return false
		end
		local args = require("config.sql").sqlfluff_args(buf, "lint")
		vim.list_extend(args, { "--format=json", "-" })
		require("lint").linters.sqlfluff.args = args
		return true
	end,
}

return {
	{
		"mfussenegger/nvim-lint",
		event = "LazyFile",
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = linters_by_ft

			local function run()
				local buf = vim.api.nvim_get_current_buf()
				local names = vim.tbl_filter(function(name)
					local condition = conditions[name]
					return not condition or condition(buf)
				end, lint._resolve_linter_by_ft(vim.bo[buf].filetype))
				if #names > 0 then
					lint.try_lint(names)
				end
			end

			local timer = assert(vim.uv.new_timer())
			vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
				group = vim.api.nvim_create_augroup("chiki_lint", { clear = true }),
				callback = function()
					timer:start(100, 0, vim.schedule_wrap(run))
				end,
			})

			vim.schedule(run)
		end,
	},
}
