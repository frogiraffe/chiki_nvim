-- Autocommands and user commands for Neovim

-- === User Commands ===

vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
        -- FormatDisable! disables formatting for this buffer
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

-- === Colorscheme ===

vim.cmd("colorscheme kanso")

-- === Autocommands ===

vim.api.nvim_create_autocmd("VimResized", {
    pattern = '*',
    command = 'lua require("fzf-lua").redraw()'
})

--[[
-- === Session Management Example (Resession) ===

-- local resession = require("resession")
-- resession.setup()
-- vim.keymap.set("n", "<leader>ss", resession.save)
-- vim.keymap.set("n", "<leader>sl", resession.load)
-- vim.keymap.set("n", "<leader>sd", resession.delete)
-- vim.api.nvim_create_autocmd("VimLeavePre", {
--     callback = function()
--         resession.save("last")
--     end,
-- })

-- === Bigfile Detection Example ===

-- vim.filetype.add({
--     pattern = {
--         [".*"] = {
--             function(path, buf)
--                 return vim.bo[buf].filetype ~= "bigfile"
--                     and path
--                     and vim.fn.getfsize(path) > vim.g.bigfile_size
--                     and "bigfile"
--                     or nil
--             end,
--         },
--     },
-- })
-- local bigfile_augroup = vim.api.nvim_create_augroup("bigfile", { clear = true })
-- vim.api.nvim_create_autocmd("FileType", {
--     group = bigfile_augroup,
--     pattern = "bigfile",
--     callback = function(ev)
--         vim.b.minianimate_disable = true
--         vim.schedule(function()
--             vim.bo[ev.buf].syntax = vim.filetype.match({ buf = ev.buf }) or ""
--         end)
--     end,
-- })
--]]
