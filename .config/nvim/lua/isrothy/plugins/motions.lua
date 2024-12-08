return {
  {
    "tris203/precognition.nvim",
    keys = {
      {
        "~",
        function()
          require("precognition").peek()
        end,
        desc = "Precognition",
      },
    },
  },
  {
    "folke/flash.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
    },
    opts = {
      modes = {
        search = {
          enabled = false,
        },
      },
    },
  },
}
