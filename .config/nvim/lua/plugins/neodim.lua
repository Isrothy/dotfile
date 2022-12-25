return {
    "zbirenbaum/neodim",
    event = "BufRead",
    config = function()
        require("neodim").setup({
            alpha = 0.5,
            blend_color = "#2E3440",
            update_in_insert = {
                enable = true,
                delay = 100,
            },
            hide = {
                virtual_text = false,
                signs = false,
                underline = false,
            },
        })
    end,
}
