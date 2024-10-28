return {
    {
        "kndndrj/nvim-dbee",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        build = function()
            require("dbee").install("curl")
        end,
        event = { "VeryLazy" },
        opts = {},
    },
}
