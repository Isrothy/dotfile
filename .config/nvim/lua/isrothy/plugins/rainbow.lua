return {
  "HiPhish/rainbow-delimiters.nvim",
  event = "VeryLazy",
  config = function()
    local rainbow_delimiters = require("rainbow-delimiters")
    vim.g.rainbow_delimiters = {
      strategy = {
        [""] = rainbow_delimiters.strategy["global"],
        vim = rainbow_delimiters.strategy["local"],
        -- html = rainbow_delimiters.strategy["local"],
        commonlisp = rainbow_delimiters.strategy["local"],
        fennel = rainbow_delimiters.strategy["local"],
      },
      query = {
        [""] = "rainbow-delimiters",
        cpp = "rainbow-delimiters",
        lua = "rainbow-blocks",
        javascript = "rainbow-parens",
        typescript = "rainbow-parens",
        tsx = "rainbow-parens",
        verilog = "rainbow-blocks",
      },
      highlight = {
        "RainbowDelimiterCyan",
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterViolet",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
      },
    }
  end,
}
