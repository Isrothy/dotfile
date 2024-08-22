return {
    {
        "folke/lazydev.nvim",
        enabled = true,
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                "luvit-meta/library",
                "LazyVim",
            },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
}
