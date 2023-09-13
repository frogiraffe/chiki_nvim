return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            {
                "RRethy/nvim-treesitter-textsubjects",
                config = function()
                    require('nvim-treesitter.configs').setup {
                        textsubjects = {
                            enable = true,
                            prev_selection = '<BS>', -- (Optional) keymap to select the previous selection
                            keymaps = {
                                ['<CR>'] = 'textsubjects-smart',
                                [';'] = 'textsubjects-container-outer',
                                ['.'] = 'textsubjects-container-inner',
                            },
                        },
                    }
                end,
            },
            { 'windwp/nvim-ts-autotag' },
            {
                "HiPhish/nvim-ts-rainbow2",
                config = function()
                    require('nvim-treesitter.configs').setup {
                        rainbow = {
                            enable = true,
                            -- list of languages you want to disable the plugin for
                            disable = { 'jsx', 'cpp' },
                            {
                                opts = {}
                            },
                            -- Which query to use for finding delimiters query = 'rainbow-parens', Highlight the entire buffer all at once strategy = require('ts-rainbow').strategy.global,
                        }
                    }
                end,
            },
            {
                'JoosepAlviste/nvim-ts-context-commentstring',
            },
            {
                'Wansmer/treesj',
                keys = { '<space>m', '<space>j', '<space>s' },
                dependencies = { 'nvim-treesitter/nvim-treesitter' },
                config = function()
                    require('treesj').setup({ max_join_length = 240 })
                end,
            },
        },
        config = function()
            require("nvim-treesitter.install").update({ with_sync = true })
            require('nvim-treesitter.configs').setup {
                matchup = { enable = true, disable_virtual_text = false, },
                ensure_installed = { 'css', 'html', 'javascript', 'lua', 'nix', 'python', 'tsx', 'typescript', 'vim',
                    'rust', 'bash', },
                context_commentstring = { enable = true, },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { "markdown" },
                },
                incremental_selection = {
                    enable = false,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = ";",
                        scope_incremental = "false",
                        node_decremental = ".",
                    },
                },
                autotag = { enable = true, },
            }
        end,
    },
}
