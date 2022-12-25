return {
    "smjonas/inc-rename.nvim",
    event = "VeryLazy",
    keys = {
        { "<leader>rn", function()
            return ":IncRename " .. vim.fn.expand("<cword>")
        end, expr = true },
    },
    config = function()
        require("inc_rename").setup()
    end,
}
