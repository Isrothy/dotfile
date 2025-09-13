local c = require("nordify.palette")["dark"]
return {
  "p00f/godbolt.nvim",
  cmd = {
    "Godbolt",
    "GodboltCompiler",
  },
  opts = {
    languages = {
      cpp = { compiler = "g122", options = {} },
      c = { compiler = "cg122", options = {} },
      rust = { compiler = "r1650", options = {} },
    },
    auto_cleanup = true,
    highlight = {
      cursor = "Visual", -- `cursor = false` to disable
      -- values in this table can be:
      -- 1. existing highlight group
      -- 2. hex color string starting with #
      static = { "#3A514D", "#5D5646", "#4C5F6B", "#5E4048" },
      -- `static = false` to disable
    },
    quickfix = {
      enable = false,
      auto_open = false,
    },
    url = "https://godbolt.org", -- can be changed to a different godbolt instance
  },
}
