return {
    "lukas-reineke/indent-blankline.nvim",

	event = { "BufReadPre", "BufNewFile" },
    config = function()
        vim.opt.list = true
        -- vim.opt.listchars:append("space:⋅")
        -- vim.opt.listchars:append("eol:↴")

        require("indent_blankline").setup({
            use_treesitter_scope = true,
            char = "▎",
            char_blankline = "▎",
            context_char = "▎",
            space_char_blankline = " ",
            show_current_context = true,
            -- show_current_context_start = true,
        })

        -- vim.cmd[[
        -- 	 let g:indent_blankline_char = '▎'
        -- ]]
    end,
}
