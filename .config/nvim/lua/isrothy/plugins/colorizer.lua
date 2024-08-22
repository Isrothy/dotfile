return {
    {
        "norcalli/nvim-colorizer.lua",
        event = {
            "BufReadPost",
            "BufNewFile",
        },
        enabled = true,
        init = function()
            vim.opt.termguicolors = true
        end,
        opts = {
            "css",
            "scss",
            "javascript",
            "html",
        },
    },
    {
        "brenoprata10/nvim-highlight-colors",
        enabled = true,
        event = {
            "BufReadPost",
            "BufNewFile",
        },
        init = function()
            vim.opt.termguicolors = true
        end,
        opts = {
            exclude_buftypes = {
                "nofile",
                "prompt",
                "popup",
                "terminal",
            },
        },
    },
}
