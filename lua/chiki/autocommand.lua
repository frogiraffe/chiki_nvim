require("colorizer").setup()
vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
    else
        vim.g.disable_autoformat = true
    end
end, {
    desc = "Disable autoformat-on-save",
    bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
end, {
    desc = "Re-enable autoformat-on-save",
})

local resession = require("resession")
resession.setup()

vim.keymap.set("n", "<leader>ss", resession.save)
vim.keymap.set("n", "<leader>sl", resession.load)
vim.keymap.set("n", "<leader>sd", resession.delete)

-- Now resession is in scope here
vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        resession.save("last")
    end,
})
vim.cmd("colorscheme kanagawa")

vim.filetype.add({
    pattern = {
        [".*"] = {
            function(path, buf)
                return vim.bo[buf].filetype ~= "bigfile"
                    and path
                    and vim.fn.getfsize(path) > vim.g.bigfile_size
                    and "bigfile"
                    or nil
            end,
        },
    },
})

-- Correct augroup creation
local bigfile_augroup = vim.api.nvim_create_augroup("bigfile", { clear = true })

-- Autocmd for bigfile
vim.api.nvim_create_autocmd("FileType", {
    group = bigfile_augroup,
    pattern = "bigfile",
    callback = function(ev)
        vim.b.minianimate_disable = true

        vim.schedule(function()
            vim.bo[ev.buf].syntax = vim.filetype.match({ buf = ev.buf }) or ""
        end)
    end,
})
