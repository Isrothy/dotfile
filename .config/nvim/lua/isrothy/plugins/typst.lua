return {
  { "kaarmu/typst.vim", ft = { "typst" } },
  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    version = "1.*",
    keys = {
      { "<LOCALLEADER>t", "", desc = "+TypstPreview", ft = "typst" },
      { "<LOCALLEADER>tu", ":TypstPreviewUpdate<CR>", desc = "Typst: Update binaries", ft = "typst" },

      { "<LOCALLEADER>tP", ":TypstPreview<CR>", desc = "Start preview", ft = "typst" },
      { "<LOCALLEADER>t<C-P>", ":TypstPreviewStop<CR>", desc = "Stop preview", ft = "typst" },
      { "<LOCALLEADER>tp", ":TypstPreviewToggle<CR>", desc = "Toggle preview", ft = "typst" },

      { "<LOCALLEADER>tC", ":TypstPreviewFollowCursor<CR>", desc = "Enable follow cursor", ft = "typst" },
      { "<LOCALLEADER>t<C-C>", ":TypstPreviewNoFollowCursor<CR>", desc = "Disable follow cursor", ft = "typst" },
      { "<LOCALLEADER>tc", ":TypstPreviewFollowCursorToggle<CR>", desc = "Toggle follow cursor", ft = "typst" },
      { "<LOCALLEADER>ts", ":TypstPreviewSyncCursor<CR>", desc = "Sync preview with cursor", ft = "typst" },
    },
    build = function() require("typst-preview").update() end,
    opts = {
      debug = false,
      get_root = function(path_of_main_file) return vim.fn.fnamemodify(path_of_main_file, ":p:h") end,
    },
  },
}
