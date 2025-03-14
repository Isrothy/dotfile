local ft = { "markdown", "quarto", "rmd", "tex", "typst", "html", "yaml", "Avante" }
return {
  "OXY2DEV/markview.nvim",
  ft = ft,
  enabled = false,
  cmd = { "Markview" },
  keys = {
    { "<localleader>v", "", desc = "+Markview", ft = ft },
    { "<localleader>vv", ":Markview Start<CR>", desc = "Start preview", ft = ft },
    { "<localleader>vx", ":Markview Stop<CR>", desc = "Stop preview", ft = ft },
    { "<localleader>vr", ":Markview Render<CR>", desc = "Render rreview", ft = ft },
    { "<localleader>vc", ":Markview Clear<CR>", desc = "Clear preview", ft = ft },

    { "<localleader>vb", "", desc = "+Buffer", ft = ft },
    { "<localleader>vbE", ":Markview enable<CR>", desc = "Enable preview", ft = ft },
    { "<localleader>vb<c-e>", ":Markview disable<CR>", desc = "Disable preview", ft = ft },
    { "<localleader>vbe", ":Markview toggle<CR>", desc = "Toggle preview", ft = ft },
    { "<localleader>vbr", ":Markview render<CR>", desc = "Render preview", ft = ft },
    { "<localleader>vbc", ":Markview clear<CR>", desc = "Clear preview", ft = ft },
    { "<localleader>vba", ":Markview attach<CR>", desc = "Attach preview", ft = ft },
    { "<localleader>vbd", ":Markview detach<CR>", desc = "Detach preview", ft = ft },

    { "<localleader>vs", "", desc = "+Split", ft = ft },
    { "<localleader>vsS", ":Markview splitOpen<CR>", desc = "Open splitview for buffer", ft = ft },
    { "<localleader>vs<c-s>", ":Markview splitClose<CR>", desc = "Close splitview", ft = ft },
    { "<localleader>vss", ":Markview splitToggle<CR>", desc = "Toggle splitview", ft = ft },
    { "<localleader>vsr", ":Markview splitRedraw<CR>", desc = "Redraw splitview", ft = ft },

    { "<localleader>vt", "", desc = "+Trace", ft = ft },
    { "<localleader>vtx", ":Markview traceExport<CR>", desc = "Export trace logs", ft = ft },
    { "<localleader>vts", ":Markview traceShow<CR>", desc = "Show trace logs", ft = ft },
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    latex = {
      enable = false,
    },
    preview = {
      enable = false,
      filetypes = ft,
      ignore_buftypes = { "nofile" },
      ignore_previews = {},

      modes = { "n", "no", "c" },
      hybrid_modes = {},
      debounce = 50,
      draw_range = { vim.o.lines, vim.o.lines },
      edit_range = { 1, 0 },

      callbacks = {},

      splitview_winopts = { split = "right" },
    },
  },
}
