return {
  {
    "norcalli/nvim-colorizer.lua",
    event = {
      "BufReadPost",
      "BufNewFile",
    },
    init = function()
      vim.opt.termguicolors = true
    end,
    opts = {
      "*",
      "css",
      "scss",
      "javascript",
      "html",
      "!lazy",
      "!nofile",
      "!prompt",
      "!popup",
      "!terminal",
    },
  },
}
