return {
  "mistricky/codesnap.nvim",
  build = "make",
  cmd = {
    "CodeSnap",
    "CodeSnapSave",
    "CodeSnapASCII",
    "CodeSnapHighlight",
    "CodeSnapSaveHighlight",
  },
  opts = {
    mac_window_bar = true,
    watermark = "",
    watermark_font_family = "",
    bg_theme = "summer",
  },
}
