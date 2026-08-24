local uv = vim.uv or vim.loop

local hostname = (uv.os_gethostname and uv.os_gethostname()) or "unknown-host"
local machine = hostname:lower():gsub("[^%w_-]", "_")
local machine_file = vim.fn.stdpath("config") .. "/lua/config/machines/" .. machine .. ".lua"

vim.g.chiki_machine = machine

if vim.fn.filereadable(machine_file) == 1 then
	local ok, err = pcall(dofile, machine_file)
	if not ok then
		vim.schedule(function()
			vim.notify(
				string.format("Failed to load machine config %s: %s", machine, err),
				vim.log.levels.ERROR,
				{ title = "Machine config" }
			)
		end)
	end
end

return machine
