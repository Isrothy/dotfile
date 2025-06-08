return {
  {
    "linux-cultist/venv-selector.nvim",
    cmd = {
      "VenvSelect",
      "VenvSelectCached",
    },
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python",
    },
    branch = "regexp",
    keys = {
      { "<localleader>p", "", desc = "+Python", ft = "python" },
      { "<localleader>pv", "", desc = "+Venv", ft = "python" },
      { "<localleader>pvs", "<cmd>VenvSelect<cr>", desc = "Select venv", ft = "python" },
      { "<localleader>pvc", "<cmd>VenvSelectCached<cr>", desc = "Select cached venv", ft = "python" },
    },
    opts = {
      options = {
        name = { "venv", ".venv" },
        pyenv_path = vim.fn.expand("~") .. ".pyenv/versions",
        picker = "native",
      },
    },
  },
}
