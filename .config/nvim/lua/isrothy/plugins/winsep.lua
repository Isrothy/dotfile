return {
    "nvim-zh/colorful-winsep.nvim",
    event = { "WinNew" },
    -- commit = "1b9c9e5",
    enabled = true,
    opts = {
        no_exec_files = {
            "packer",
            "TelescopePrompt",
            "mason",
            "CompetiTest",
            "NvimTree",
        },
        hi = {
            bg = "#2E3440",
            fg = "#5E81AC",
        },
        smooth = false,
    },
}
