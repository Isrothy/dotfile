local M = {
    "CRAG666/code_runner.nvim",
    cmd = "RunCode",
    keys = {
        { "<leader>cr", ":RunCode<cr>" },
    },
    dependencies = "nvim-lua/plenary.nvim",
}


M.config = function()
    require("code_runner").setup({
        -- put here the commands by filetype
        mode = "toggleterm",
        startinsert = true,
        filetype = {
            c = "cd $dir && clang $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
            cpp = "cd $dir && clang++ $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
            dart = "dart",
            go = "go run",
            haskell = "runhaskell",
            lua = "luajit",
            java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
            javascript = "node",
            ["objective-c"] = "cd $dir && gcc -framework Cocoa $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
            python = "python3 -u",
            r = "Rscript",
            rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
            swift = "swift",
            typescript = "ts-node",

            zsh = "$dir/$fileName",
            bash = "$dir/$fileName",
            shell = "$dir/$fileName",
        },
    })

     --vim.keymap.set("n", "<leader>cr", ":RunCode<CR>", { noremap = true, silent = false })
end

return M
