local M = {
    "kevinhwang91/nvim-hlslens",
    event = "BufReadPre",
}

M.config = function()
    require("hlslens").setup({
        virt_priority = 1,
    })

    vim.api.nvim_set_keymap(
        "n",
        "n",
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
        "n",
        "N",
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        { noremap = true, silent = true }
    )
    vim.keymap.set("n", "*", [[*<cmd>lua require('hlslens').start()<cr>]], { noremap = true, silent = true })
    vim.keymap.set("n", "#", [[#<cmd>lua require('hlslens').start()<cr>]], { noremap = true, silent = true })
    vim.keymap.set("n", "g*", [[g*<cmd>lua require('hlslens').start()<cr>]], { noremap = true, silent = true })
    vim.keymap.set("n", "g#", [[g#<cmd>lua require('hlslens').start()<cr>]], { noremap = true, silent = true })
end

return M
