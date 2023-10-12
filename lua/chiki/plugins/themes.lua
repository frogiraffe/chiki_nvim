return {
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            require("gruvbox").setup({
                transparent_mode = false,
                terminal_colors= true,
                underline = true,
            })
            vim.cmd("colorscheme gruvbox")
            vim.cmd "colorscheme gruvbox"
        end
    }
}
