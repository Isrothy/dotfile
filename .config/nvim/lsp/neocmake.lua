return {
  cmd = { "neocmakelsp", "--stdio" },
  filetypes = { "cmake" },
  root_markers = {
    ".git",
    "build",
    "cmake",
  },
  single_file_support = true,
}
