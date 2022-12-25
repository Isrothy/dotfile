return {
    "L3MON4D3/LuaSnip",
    dependencies = {
        "rafamadriz/friendly-snippets",
    },
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load({
            include = {
                "bash",
                "c",
                "cpp",
                "css",
                "html",
                "java",
                "javascript",
                "javascriptreact",
                "json",
                "kotlin",
                "lua",
                "objective-c",
                "python",
                "rust",
                "swift",
                "typescript",
                "typescriptreact",
            },
        })
    end,
}
