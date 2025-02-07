return {
  {
    "tris203/precognition.nvim",
    keys = {
      { "\\", function() require("precognition").peek() end, desc = "Precognition" },
    },
    {
      "icholy/lsplinks.nvim",
      event = "LspAttach",
      keys = {
        {
          "<LEADER><LEADER>l",
          function() require("lsplinks").gx() end,
          mode = { "n" },
          desc = "Open link",
        },
      },
      opts = {
        highlight = true,
        hl_group = "Underlined",
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<LEADER>v",
        function() require("flash").jump() end,
        desc = "Flash",
        mode = { "n", "x", "o" },
      },
      {
        "<LEADER>V",
        function() require("flash").treesitter() end,
        desc = "Flash Treesitter",
        mode = { "n", "o", "x" },
      },
      {
        "r",
        function() require("flash").remote() end,
        desc = "Remote Flash",
        mode = { "o" },
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
