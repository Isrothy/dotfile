return {
    {
        "folke/which-key.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "echasnovski/mini.ai",
        },
        event = "VeryLazy",
        enable = true,
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
        opts = {
            preset = "classic",
            sort = { "local", "order", "group", "alphanum", "mod", "lower", "icase" },
            win = {
                row = -1,
                border = "rounded",
                padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
                title = true,
                title_pos = "center",
                zindex = 1000,
                -- Additional vim.wo and vim.bo options
                bo = {},
                wo = {
                    -- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
                },
            },
            spec = {
                { "<leader>b", group = "Buffer" },
                { "<leader>bs", group = "Swap" },
                { "<leader>c", group = "Code" },
                { "<leader>d", group = "Dap" },
                { "<leader>e", group = "TreeSJ" },
                { "<leader>f", group = "Find" },
                { "<leader>h", group = "Harpoon" },
                { "<leader>i", group = "ISwap" },
                { "<leader>k", group = "Git conflict" },
                { "<leader>m", group = "Molten" },
                { "<leader>n", group = "Neominimap" },
                { "<leader>nb", group = "[b]uffer" },
                { "<leader>nw", group = "[w]indow" },
                { "<leader>nt", group = "[t]ab" },

                { "<leader>s", group = "SearchReplaceSingleBuffer" },
                { "<leader>sm", group = "[M]ultiBuffer" },

                { "<leader>t", group = "Neotest" },
                { "<leader>x", group = "Trouble" },

                { "ga", group = "TextCase" },
                { "gao", group = "Pending mode operator" },

                { "[", group = "prev" },
                { "]", group = "next" },
            },
        },
    },
}
