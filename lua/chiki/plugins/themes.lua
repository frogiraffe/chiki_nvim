return {
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            require("gruvbox").setup({
                transparent_mode = true,
                terminal_colors= true,
                underline = false,
            })
            vim.cmd("colorscheme gruvbox")
            vim.cmd "colorscheme gruvbox"
        end
    }
}
