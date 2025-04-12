return {
  capabilities = {
    offsetEncoding = { "utf-16" },
  },
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--clang-tidy-checks=performance-*,bugprone-*",
    "--all-scopes-completion",
    "--completion-style=bundled",
    "--header-insertion=iwyu",
    "-j=8",
    "--pch-storage=memory",
  },
}
