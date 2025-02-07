return {
  "lervag/vimtex",
  ft = "tex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = "skim"
    vim.g.vimtex_mappings_enabled = 0
    vim.g.vimtex_imaps_enabled = 0
    vim.g.vimtex_indent_enabled = 1
    vim.g.vimtex_format_enabled = 1
    vim.g.vimtex_completion = 0
  end,
}
