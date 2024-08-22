local copilot = {
    "zbirenbaum/copilot.lua",
    event = "VeryLazy",
    enabled = false,
    config = function()
        vim.defer_fn(function()
            require("copilot").setup({
                panel = {
                    enabled = false,
                    auto_refresh = true,
                    keymap = {
                        jump_prev = "[[",
                        jump_next = "]]",
                        accept = "<CR>",
                        refresh = "gr",
                        open = "<c-CR>",
                    },
                },
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    debounce = 75,
                    keymap = {
                        accept = "<c-;>",
                        next = "<c-,>",
                        prev = "<c-.>",
                        dismiss = "<c-'>",
                    },
                },
                filetypes = {
                    yaml = false,
                    help = false,
                    gitcommit = false,
                    gitrebase = false,
                    hgcommit = false,
                    svn = false,
                    cvs = false,
                    ["."] = false,
                },
                copilot_node_command = "node", -- Node version must be < 18
                server_opts_overrides = {
                    trace = "verbose",
                    settings = {
                        advanced = {
                            listCount = 10, -- #completions for panel
                            inlineSuggestCount = 3, -- #completions for getCompletions
                        },
                    },
                },
            })
        end, 100)
    end,
}

local codeium = {
    "Exafunction/codeium.vim",
    event = "VeryLazy",
    enabled = false,
    config = function()
        vim.keymap.set("i", "<C-;>", function()
            return vim.fn["codeium#Accept"]()
        end, { expr = true, silent = true, noremap = true })
        vim.keymap.set("i", "<c-,>", function()
            return vim.fn["codeium#CycleCompletions"](1)
        end, { expr = true, silent = true, noremap = true })
        vim.keymap.set("i", "<c-.>", function()
            return vim.fn["codeium#CycleCompletions"](-1)
        end, { expr = true, silent = true, noremap = true })
        vim.keymap.set("i", "<c-'>", function()
            return vim.fn["codeium#Clear"]()
        end, { expr = true, silent = true, noremap = true })
        vim.api.nvim_create_user_command("CodeiumChat", function(opts)
            vim.fn["codeium#Chat"]()
        end, { nargs = "*", desc = "Codeium Chat" })
    end,
}

local neoCodeium = {
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
}

return {
    codeium,
    copilot,
    neoCodeium,
}
