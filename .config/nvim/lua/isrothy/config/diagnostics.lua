vim.diagnostic.config({
  virtual_text = false,
  signs = {
    text = { " ", " ", " ", " " },
  },
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  float = {
    source = true,
  },
})
