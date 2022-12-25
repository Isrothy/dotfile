local M = {
    "zbirenbaum/copilot.lua",
    event = "VeryLazy",
}

M.config = function()
    local default = require("plugins.lsp.default")
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
                    open = "<M-CR>",
                },
            },
            suggestion = {
                enabled = true,
                auto_trigger = true,
                debounce = 75,
                keymap = {
                    accept = "<M-j>",
                    next = "<M-]>",
                    prev = "<M-[>",
                    dismiss = "<C-]>",
                },
            },
            filetypes = {
                yaml = false,
                markdown = false,
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
                offset_encoding = default.offset_encoding,
                settings = {
                    advanced = {
                        listCount = 10, -- #completions for panel
                        inlineSuggestCount = 3, -- #completions for getCompletions
                    },
                },
            },
        })
    end, 100)
end

return M
