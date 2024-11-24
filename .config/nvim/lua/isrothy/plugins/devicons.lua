return {
    "rachartier/tiny-devicons-auto-colors.nvim",
    enabled = true,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    config = function()
        require("tiny-devicons-auto-colors").setup()
    end,
}
