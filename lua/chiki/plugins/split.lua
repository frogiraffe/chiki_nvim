return {
    {
        'mrjones2014/smart-splits.nvim',
        config = function()
            require('smart-splits').setup({
                resize_mode = {
                    hooks = {
                        on_leave = require('bufresize').register,
                    },
                },
            })
            -- recommended mappings
            -- resizing splits
            -- these keymaps will also accept a range,
            -- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
            vim.keymap.set({ 'n', 'v', 't' }, '<C-r>', require('smart-splits').start_resize_mode,
                { desc = "resize mode" })
            -- moving between splits
            vim.keymap.set({ 'n', 't' }, '<C-h>', require('smart-splits').move_cursor_left)
            vim.keymap.set({ 'n', 't' }, '<C-j>', require('smart-splits').move_cursor_down)
            vim.keymap.set({ 'n', 't' }, '<C-k>', require('smart-splits').move_cursor_up)
            vim.keymap.set({ 'n', 't' }, '<C-l>', require('smart-splits').move_cursor_right)
            vim.keymap.set({ 'n', 't' }, '<C-M-h>', require('smart-splits').resize_left)
            vim.keymap.set({ 'n', 't' }, '<C-M-j>', require('smart-splits').resize_down)
            vim.keymap.set({ 'n', 't' }, '<C-M-k>', require('smart-splits').resize_up)
            vim.keymap.set({ 'n', 't' }, '<C-M-l>', require('smart-splits').resize_right)

            -- swapping buffers between windows
            vim.keymap.set('n', '<leader><leader>h',
                require('smart-splits').swap_buf_left, { desc = "swap buffer w left" })
            vim.keymap.set('n', '<leader><leader>j',
                require('smart-splits').swap_buf_down, { desc = "swap buffer w down" })
            vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up, { desc = "swap buffer w up" })
            vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right,
                { desc = "swap buffer w up" })
        end,
    },
    {
        "kwkarlwang/bufresize.nvim",
        config = function()
            require('bufresize').setup({
                resize = {
                    keys = {},
                    trigger_events = { "VimResized" },
                }
            })
        end
    }
}
