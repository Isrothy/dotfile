return {
  {
    "folke/which-key.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "echasnovski/mini.ai",
    },
    event = "VeryLazy",
    enable = true,
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    opts = {
      preset = "modern",
      sort = { "local", "order", "group", "alphanum", "mod", "lower", "icase" },
      win = {
        border = "rounded",
        padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
        title = true,
        title_pos = "center",
        zindex = 1000,
        -- Additional vim.wo and vim.bo options
        bo = {},
        wo = {
          winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
        },
      },
      -- keys = {
      --   scroll_down = "<c-n>", -- binding to scroll down inside the popup
      --   scroll_up = "<c-p>", -- binding to scroll up inside the popup
      -- },
      spec = {
        { "<leader>b", group = "Buffer" },
        { "<leader>bs", group = "Swap" },
        { "<leader>c", group = "Code" },
        { "<leader>d", group = "Dap" },
        { "<leader>e", group = "TreeSJ" },
        { "<leader>f", group = "Find" },
        -- { "<leader>g", group = "Git" },
        { "<leader>h", group = "Harpoon" },
        { "<leader>i", group = "ISwap" },
        { "<leader>k", group = "Git conflict" },
        { "<leader>m", group = "Molten" },
        { "<leader>n", group = "Neominimap" },
        { "<leader>nb", group = "[b]uffer" },
        { "<leader>nw", group = "[w]indow" },
        { "<leader>nt", group = "[t]ab" },

        { "<leader>o", group = "Overseer" },
        -- { "<leader>p", group = "Profiler" },

        { "<leader>s", group = "Noice" },
        { "<leader>t", group = "Neotest" },
        { "<leader>w", group = "Window" },
        { "<leader>x", group = "Diagnostics" },
        -- { "<leader>y", group = "Yank" },

        { "<leader>W", group = "Wrokspace" },

        { "ga", group = "TextCase" },
        { "gao", group = "Pending mode operator" },
        -- { "z", group = "Fold" },

        { "[", group = "prev" },
        { "]", group = "next" },
      },
    },
  },
}
