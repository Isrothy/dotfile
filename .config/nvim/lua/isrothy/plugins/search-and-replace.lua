return {
    {
        "roobert/search-replace.nvim",
        cmd = {
            "SearchReplaceSingleBufferOpen",
            "SearchReplaceMultiBufferOpen",

            "SearchReplaceSingleBufferCWord",
            "SearchReplaceSingleBufferCWORD",
            "SearchReplaceSingleBufferCExpr",
            "SearchReplaceSingleBufferCFile",

            "SearchReplaceMultiBufferCWord",
            "SearchReplaceMultiBufferCWORD",
            "SearchReplaceMultiBufferCExpr",
            "SearchReplaceMultiBufferCFile",

            "SearchReplaceSingleBufferSelections",
            "SearchReplaceMultiBufferSelections",

            "SearchReplaceSingleBufferWithinBlock",

            "SearchReplaceVisualSelection",
            "SearchReplaceVisualSelectionCWord",
            "SearchReplaceVisualSelectionCWORD",
            "SearchReplaceVisualSelectionCExpr",
            "SearchReplaceVisualSelectionCFile",
        },
        keys = {
            {
                "<leader>ss",
                "<CMD>SearchReplaceSingleBufferSelections<CR>",
                desc = "[s]elction list",
            },
            { "<leader>so", "<CMD>SearchReplaceSingleBufferOpen<CR>", desc = "[o]pen" },
            { "<leader>sw", "<CMD>SearchReplaceSingleBufferCWord<CR>", desc = "[w]ord" },
            { "<leader>sW", "<CMD>SearchReplaceSingleBufferCWORD<CR>", desc = "[W]ORD" },
            { "<leader>se", "<CMD>SearchReplaceSingleBufferCExpr<CR>", desc = "[e]xpr" },
            { "<leader>sf", "<CMD>SearchReplaceSingleBufferCFile<CR>", desc = "[f]ile" },

            {
                "<leader>sms",
                "<CMD>SearchReplaceMultiBufferSelections<CR>",
                desc = "SearchReplaceMultiBuffer [s]elction list",
            },
            { "<leader>smo", "<CMD>SearchReplaceMultiBufferOpen<CR>", desc = "[o]pen" },
            { "<leader>smw", "<CMD>SearchReplaceMultiBufferCWord<CR>", desc = "[w]ord" },
            { "<leader>smW", "<CMD>SearchReplaceMultiBufferCWORD<CR>", desc = "[W]ORD" },
            { "<leader>sme", "<CMD>SearchReplaceMultiBufferCExpr<CR>", desc = "[e]xpr" },
            { "<leader>smf", "<CMD>SearchReplaceMultiBufferCFile<CR>", desc = "[f]ile" },

            { "<C-r>", [[<CMD>SearchReplaceSingleBufferVisualSelection<CR>]], mode = "v" },
            { "<C-b>", [[<CMD>SearchReplaceWithinVisualSelectionCWord<CR>]], mode = "v" },
        },
        opts = {
            default_replace_single_buffer_options = "gcI",
            default_replace_multi_buffer_options = "egcI",
        },
        init = function()
            vim.o.inccommand = "split"
        end,
    },

    {
        "MagicDuck/grug-far.nvim",
        cmd = {
            "GrugFar",
        },
        opts = { headerMaxWidth = 80 },
    },

    {
        "chrisgrieser/nvim-rip-substitute",
        init = function()
            vim.api.nvim_create_user_command("RipSub", function()
                require("rip-substitute").sub()
            end, {
                desc = " rip substitute",
            })
        end,
    },
}
