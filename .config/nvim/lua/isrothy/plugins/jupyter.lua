return {
    {
        "benlubas/molten-nvim",
        version = "^1.0.0",
        dependencies = { "3rd/image.nvim" },
        ft = { "markdown" },
        keys = {
            {
                "<leader>mi",
                "<cmd>MoltenInit<CR>",
                noremap = true,
                silent = true,
                desc = "Molten init",
            },
            {
                "<leader>me",
                "<cmd>MoltenEvaluateOperator<CR>",
                noremap = true,
                silent = true,
                desc = "Molten evaluate operator",
            },
            {
                "<leader>mr",
                "<cmd>MoltenReevaluateCell<CR>",
                noremap = true,
                silent = true,
                desc = "Molten reevaluate cell",
            },
            {
                "<leader>mr",
                ":<C-u>MoltenEvaluateVisual<CR>gv",
                noremap = true,
                mode = { "v" },
                desc = "Molten evaluate visual",
            },
            {
                "<leader>mo",
                ":noautocmd MoltenEnterOutput<CR>",
                noremap = true,
                silent = true,
                desc = "Molten enter output",
            },
            {
                "<leader>mh",
                "<cmd>MoltenHideOutput<CR>",
                noremap = true,
                silent = true,
                desc = "Molten hide output",
            },
            {
                "<leader>md",
                "<cmd>MoltenDelete<CR>",
                noremap = true,
                silent = true,
                desc = "Molten delete",
            },
        },
        build = ":UpdateRemotePlugins",
        init = function()
            vim.g.molten_output_win_max_height = 12
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_use_border_highlights = true
        end,
    },
}
