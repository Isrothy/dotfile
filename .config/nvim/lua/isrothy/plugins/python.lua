return {
  {
    "linux-cultist/venv-selector.nvim",
    cmd = {
      "VenvSelect",
      "VenvSelectCached",
    },
    ft = { "python" },
    keys = {
      { "<localleader>p", "", desc = "+Python", ft = "python" },
      { "<localleader>pv", "", desc = "+Venv", ft = "python" },
      { "<localleader>pvs", "<cmd>VenvSelect<cr>", desc = "Select venv", ft = "python" },
      { "<localleader>pvc", "<cmd>VenvSelectCached<cr>", desc = "Select cached venv", ft = "python" },
      {
        "<localleader>pvw",
        function() print(require("venv-selector").venv()) end,
        desc = "Which venv?",
        ft = "python",
      },
    },
    opts = {
      options = {
        name = { "venv", ".venv" },
        pyenv_path = vim.fn.expand("~") .. ".pyenv/versions",
        picker = "snacks",
      },
    },
  },
}
