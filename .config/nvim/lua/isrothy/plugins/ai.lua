return {
    {
        "monkoose/neocodeium",
        event = "VeryLazy",
        enabled = true,
        config = function()
            local neocodeium = require("neocodeium")
            neocodeium.setup({
                enabled = true,
                show_label = true,
                manual = false,
                debounce = true,
                silent = true,
                filetypes = {
                    help = false,
                    gitcommit = false,
                    gitrebase = false,
                    ["."] = false,
                },
            })
            vim.keymap.set("i", "<c-;>", neocodeium.accept)
            -- vim.keymap.set("i", "<c-'>", neocodeium.cleareium").accept_word()
            -- end)
            vim.keymap.set("i", "<c-l>", neocodeium.accept_line)
            vim.keymap.set("i", "<c-.>", neocodeium.cycle_or_complete)
            vim.keymap.set("i", "<c-,>", function()
                neocodeium.cycle_or_complete(-1)
            end)
            vim.keymap.set("i", "<c-'>", neocodeium.clear)
        end,
    },
}
