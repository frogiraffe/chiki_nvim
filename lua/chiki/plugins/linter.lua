return {
    {
        "mfussenegger/nvim-lint",
        opts = {
            -- Events to trigger linters
            events = { "BufWritePost", "BufReadPost", "InsertLeave" },
            linters_by_ft = {
                fish = { "fish" },
                lua = { "luacheck" },
                go = { "golangcilint" },
                javascript = { "eslint_d" },
                typescript = { "eslint_d" },
                -- Add more filetypes and linters as needed
                -- ["*"] = { "typos" }, -- Example: global linter for all filetypes
                -- ["_"] = { "fallback linter" }, -- Fallback for unconfigured filetypes
            },
        },
        config = function(_, opts)
            local lint = require("lint")
            lint.linters_by_ft = opts.linters_by_ft

            -- Automatically trigger linting on the specified events
            for _, event in ipairs(opts.events) do
                vim.api.nvim_create_autocmd(event, {
                    callback = function()
                        lint.try_lint()
                    end,
                })
            end
        end,
    },
}
