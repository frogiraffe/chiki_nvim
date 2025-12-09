return {
{
    "3rd/image.nvim",
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
        version = "1.1.0"
    opts = {
        processor = "magick_cli",
    }
}

}
