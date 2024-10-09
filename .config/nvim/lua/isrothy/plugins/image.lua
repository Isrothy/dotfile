return {
    {
        "adelarsq/image_preview.nvim",
        event = "VeryLazy",
        config = function()
            require("image_preview").setup()
        end,
    },
    {
        "3rd/image.nvim",
        dependencies = {
            "leafo/magick",
        },
        ft = { "markdown" },
        opts = {
            backend = "kitty",
            integrations = {},
            max_width = 100,
            max_height = 12,
            max_height_window_percentage = math.huge,
            max_width_window_percentage = math.huge,
            window_overlap_clear_enabled = true,
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        },
        version = "1.1.0", -- or comment out for latest
    },
}
