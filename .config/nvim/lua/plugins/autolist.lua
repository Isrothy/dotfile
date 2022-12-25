local M = {
    "gaoDean/autolist.nvim",
    event = "BufReadPost",
    ft = { "markdown" },
}

M.config = function()
    require("autolist").setup({
        enabled = true,
        list_cap = 50,
        colon = {
            indent_raw = true,
            indent = true,
            preferred = "-",
        },
        invert = {
            indent = false,
            toggles_checkbox = true,
            ul_marker = "-",
            ol_incrementable = "1",
            ol_delim = ".",
        },
        lists = {
            preloaded = {
                generic = {
                    "unordered",
                    "digit",
                    "ascii",
                },
                latex = {
                    "latex_item",
                },
            },
            filetypes = {
                generic = {
                    "markdown",
                    "text",
                },
                latex = {
                    "tex",
                    "plaintex",
                },
            },
        },
        recal_function_hooks = {
            "invert",
            "new",
        },
        checkbox = {
            left = "%[",
            right = "%]",
            fill = "x",
        },
        insert_mappings = {
            invert = { "<c-q>+[catch]" },
            new = { "<CR>" },
            tab = { "<c-t>" },
            detab = { "<c-d>" },
            recal = { "<c-k>" },
            indent = {
                "<tab>+[catch]('>>')",
                "<s-tab>+[catch]('<<')",
            },
        },
        normal_mappings = {
            invert = { "<c-q>+[catch]" },
            new = {
                "o",
                "O+(true)",
            },
            tab = { ">>" },
            detab = { "<<" },
            recal = { "<c-k>" },
        },
    })
end

return M
