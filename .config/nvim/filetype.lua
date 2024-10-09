vim.filetype.add({
    filename = {
        [".git/config"] = "gitconfig",
        [".swift-format"] = "json",
        [".clang-format"] = "yaml",
        ["*_log"] = "log",
        ["*_LOG"] = "log",
        [".yamlfmt"] = "yaml",
    },
    extension = {
        ["log"] = "log",
        ["LOG"] = "log",
    },
})
