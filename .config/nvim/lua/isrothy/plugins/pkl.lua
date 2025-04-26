return {
  "https://github.com/apple/pkl-neovim",
  ft = { "pkl" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  build = function()
    require("pkl-neovim").init()
    vim.cmd("TSInstall pkl")
  end,
  init = function()
    vim.g.pkl_neovim = {
      start_command = { "pkl-lsp" },
      pkl_cli_path = "pkl",
    }
  end,
}
