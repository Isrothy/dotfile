return {
  { "kaarmu/typst.vim", ft = { "typst" } },
  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    version = "1.*",
    keys = {
      { "<localleader>t", "", desc = "+TypstPreview", ft = "typst" },
      { "<localleader>tu", ":TypstPreviewUpdate<cr>", desc = "Typst: Update binaries", ft = "typst" },

      { "<localleader>tP", ":TypstPreview<cr>", desc = "Start preview", ft = "typst" },
      { "<localleader>t<c-p>", ":TypstPreviewStop<cr>", desc = "Stop preview", ft = "typst" },
      { "<localleader>tp", ":TypstPreviewToggle<cr>", desc = "Toggle preview", ft = "typst" },

      { "<localleader>tC", ":TypstPreviewFollowCursor<cr>", desc = "Enable follow cursor", ft = "typst" },
      { "<localleader>t<c-c>", ":TypstPreviewNoFollowCursor<cr>", desc = "Disable follow cursor", ft = "typst" },
      { "<localleader>tc", ":TypstPreviewFollowCursorToggle<cr>", desc = "Toggle follow cursor", ft = "typst" },
      { "<localleader>ts", ":TypstPreviewSyncCursor<cr>", desc = "Sync preview with cursor", ft = "typst" },
    },
    build = function() require("typst-preview").update() end,
    opts = {
      debug = false,
      get_root = function(path_of_main_file) return vim.fn.fnamemodify(path_of_main_file, ":p:h") end,
    },
  },
}
