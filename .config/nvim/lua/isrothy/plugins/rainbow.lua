return {
  "HiPhish/rainbow-delimiters.nvim",
  enabled = true,
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local rainbow_delimiters = require("rainbow-delimiters")
    vim.g.rainbow_delimiters = {
      strategy = {
        [""] = rainbow_delimiters.strategy["global"],
        vim = rainbow_delimiters.strategy["local"],
        html = rainbow_delimiters.strategy["local"],
        commonlisp = rainbow_delimiters.strategy["local"],
        fennel = rainbow_delimiters.strategy["local"],
      },
      query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks",
        javascript = "rainbow-parens",
        typescript = "rainbow-parens",
        tsx = "rainbow-parens",
        verilog = "rainbow-blocks",
      },
    }
  end,
}
