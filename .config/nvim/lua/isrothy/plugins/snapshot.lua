return {
  "mistricky/codesnap.nvim",
  build = "make",
  enabled = false,
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
