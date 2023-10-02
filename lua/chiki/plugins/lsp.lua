return {
    --
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        event = "BufReadPre",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            {
                "neovim/nvim-lspconfig",
                event = { "BufReadPre", "BufNewFile" },
                config = function() end,
            },
            "simrat39/rust-tools.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                    "tsserver",
                    "jedi_language_server",
                },
            })
            --
            local lspconfig = require("lspconfig")
            local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = lsp_capabilities,
                    })
                end,
                ["rust_analyzer"] = function()
                    require("rust-tools").setup({
                        tools = {
                            inlay_hints = {
                                auto = true,
                            },
                        },
                        server = {
                            on_attach = function(_, bufnr)
                            end,
                        },
                    })
                end,
                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup({
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" },
                                },
                            },
                        },
                    })
                end,
            })
            -- require('lspconfig').rust_analyzer.setup({
            --     checkOnSave = {
            --         command = 'clippy'
            --     }
            -- }
            -- )
        end,
    },
    {
        "folke/neodev.nvim",
        opts = {},
        config = function()
            require("neodev").setup({})
        end,
    },

    {
        "SmiteshP/nvim-navbuddy",
        lazy = false,
        dependencies = {
            "SmiteshP/nvim-navic",
            "neovim/nvim-lspconfig",
            "MunifTanjim/nui.nvim",
        },
        opts = { lsp = { auto_attach = true } },
        config = function()
            local navbuddy = require("nvim-navbuddy")
            navbuddy.setup({
                lsp = { auto_attach = true, preference = { "nvim_lsp", "nvim-cmp", "nvim-lspconfig", "texlab", "lua_ls" } },
            })
            vim.keymap.set("n", "<leader>be", "<cmd>:Navbuddy<CR>", { desc = "Navbuddy" })
        end,
    },
    {
        "simrat39/rust-tools.nvim",
        config = function()
            local rt = require("rust-tools")

            rt.setup({})
        end,
    },
}
