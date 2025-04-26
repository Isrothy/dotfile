return {
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "folke/snacks.nvim" },
    },
    keys = {
      { "<LEADER>la", function() require("tiny-code-action").code_action({}) end, desc = "Code action" },
    },
    opts = {
      backend = "delta",
      picker = {
        "snacks",
        opts = {
          layout = "vertical",
        },
      },
      backend_opts = {
        delta = {
          args = {
            "--line-numbers",
          },
        },
      },
    },
  },
}
