vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        -- Always save a special session named "last"
        resession.save("last")
    end,
})
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
-- Resession does NOTHING automagically, so we have to set up some keymaps
vim.keymap.set("n", "<leader>ss", resession.save)
vim.keymap.set("n", "<leader>sl", resession.load)
vim.keymap.set("n", "<leader>sd", resession.delete)

vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        -- Always save a special session named "last"
        resession.save("last")
    end,
})
