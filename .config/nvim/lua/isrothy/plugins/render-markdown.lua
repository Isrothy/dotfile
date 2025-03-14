local ft = {
  "markdown",
  "norg",
  "rmd",
  "org",
  "codecompanion",
  "Avante",
}
return {
  "MeanderingProgrammer/render-markdown.nvim",
  cmd = { "RenderMarkdown" },
  keys = {
    { "<LOCALLEADER>r", "", desc = "+Render markdown", ft = ft },
    { "<LOCALLEADER>rr", function() require("render-markdown").toggle() end, desc = "Toggle", ft = ft },
    { "<LOCALLEADER>rR", function() require("render-markdown").enable() end, desc = "Enable", ft = ft },
    { "<LOCALLEADER>r<c-r>", function() require("render-markdown").disable() end, desc = "Disable", ft = ft },

    { "<LOCALLEADER>rb", "", desc = "+Buffer", ft = ft },
    { "<LOCALLEADER>rbr", function() require("render-markdown").buf_toggle() end, desc = "Toggle", ft = ft },
    { "<LOCALLEADER>rbR", function() require("render-markdown").buf_enable() end, desc = "Enable", ft = ft },
    { "<LOCALLEADER>rb<c-r>", function() require("render-markdown").buf_disable() end, desc = "Disable", ft = ft },

    { "<LOCALLEADER>rl", function() require("render-markdown").expand() end, desc = "Expand", ft = ft },
    { "<LOCALLEADER>rh", function() require("render-markdown").contract() end, desc = "Contract", ft = ft },
  },
  ft = ft,
  opts = {
    code = {
      sign = false,
      width = "block",
      border = "none",
      below = "▔",
      above = "▁",
      right_pad = 1,
    },
    heading = {
      sign = false,
      icons = {},
    },
    completions = {
      lsp = { enabled = true },
    },
    checkbox = {
      enabled = false,
    },
    file_types = ft,
  },
}
