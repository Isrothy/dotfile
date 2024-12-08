vim.filetype.add({
  filename = {
    [".git/config"] = "gitconfig",
    [".swift-format"] = "json",
    [".clang-format"] = "yaml",
    [".yamlfmt"] = "yaml",
  },
  extension = {
    ["log"] = { "log" },
    ["LOG"] = { "log" },
  },
})
