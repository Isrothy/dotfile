vim.diagnostic.config({
  virtual_text = false,
  signs = {
    text = { "E", "W", "I", "H" },
  },
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  float = {
    source = true,
  },
})
