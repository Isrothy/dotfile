vim.filetype.add({
  filename = {
    [".git/config"] = "gitconfig",
    [".swift-format"] = "json",
    [".clang-format"] = "yaml",
    [".yamlfmt"] = "yaml",
    ["vifmrc"] = "vim",
  },
  extension = {
    ["log"] = { "log" },
    ["LOG"] = { "log" },
  },
  pattern = {
    [".*/kitty/.+%.conf"] = "kitty",
    ["%.env%.[%w_.-]+"] = "sh",
  },
})
