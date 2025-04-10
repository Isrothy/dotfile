return {
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
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  single_file_support = true,
  root_markers = {
    "compile_commands.json",
    "compile_flags.txt",
    "meson.build",
    "meson_options.txt",
    "build.ninja",
  },
  capabilities = {
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
    offsetEncoding = { "utf-8", "utf-16" },
  },
}
