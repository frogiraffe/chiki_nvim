local M = {}

local dialect_by_scheme = {
	sqlite = "sqlite",
	sqlite3 = "sqlite",
	postgres = "postgres",
	postgresql = "postgres",
	mysql = "mysql",
	mariadb = "mariadb",
	duckdb = "duckdb",
	snowflake = "snowflake",
	bigquery = "bigquery",
	redshift = "redshift",
	clickhouse = "clickhouse",
	oracle = "oracle",
	mssql = "tsql",
	sqlserver = "tsql",
}

local function dirname(bufnr)
	local name = vim.api.nvim_buf_get_name(bufnr)
	if name == "" then
		return vim.uv.cwd()
	end
	return vim.fs.dirname(name)
end

local function config_has_dialect(path)
	local ok, lines = pcall(vim.fn.readfile, path, "", 500)
	if not ok then
		return false
	end

	local is_pyproject = vim.fs.basename(path) == "pyproject.toml"
	local in_sqlfluff_section = false
	for _, line in ipairs(lines) do
		local section = line:match("^%s*%[([^%]]+)%]%s*$")
		if section then
			if is_pyproject then
				in_sqlfluff_section = section:match("^tool%.sqlfluff") ~= nil
			else
				in_sqlfluff_section = section:match("^sqlfluff") ~= nil
			end
		elseif in_sqlfluff_section and line:match("^%s*dialect%s*=") then
			return true
		end
	end
	return false
end

-- If a project explicitly configures a SQLFluff dialect, do not pass a CLI
-- dialect at all: command-line flags have higher precedence than .sqlfluff,
-- setup.cfg, tox.ini and pyproject.toml.
function M.has_project_dialect(bufnr)
	bufnr = bufnr or 0
	local start = dirname(bufnr)
	local candidates = vim.fs.find({ ".sqlfluff", "pyproject.toml", "setup.cfg", "tox.ini" }, {
		path = start,
		upward = true,
		stop = vim.uv.os_homedir(),
		limit = 20,
	})
	for _, path in ipairs(candidates) do
		if config_has_dialect(path) then
			return true
		end
	end
	return false
end

local function dadbod_scheme(bufnr)
	local url = vim.b[bufnr].db
	if type(url) ~= "string" or url == "" then
		url = vim.g.db
	end
	if type(url) ~= "string" then
		return nil
	end
	local scheme = url:match("^([%w_+%-]+):")
	return scheme and scheme:lower() or nil
end

function M.dialect(bufnr)
	bufnr = bufnr or 0
	if M.has_project_dialect(bufnr) then
		return nil
	end

	local scheme = dadbod_scheme(bufnr)
	if scheme and dialect_by_scheme[scheme] then
		return dialect_by_scheme[scheme]
	end

	local ft = vim.bo[bufnr].filetype
	if ft == "mysql" then
		return "mysql"
	elseif ft == "plsql" then
		return "oracle"
	end

	-- Generic .sql files need a dialect when no project/Dadbod context exists.
	return "ansi"
end

function M.sqlfluff_args(bufnr, command)
	local args = { command }
	local dialect = M.dialect(bufnr)
	if dialect then
		vim.list_extend(args, { "--dialect=" .. dialect })
	end
	return args
end

return M
