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
        "<LEADER>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (Which-Key)",
      },
    },
    opts = {
      preset = "modern",
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = true, -- adds help for operators like d, y, ...
          motions = true, -- adds help for motions
          text_objects = true, -- help for text objects triggered after entering an operator
          windows = true, -- default bindings on <c-w>
          nav = true, -- misc bindings to work with windows
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = true, -- bindings for prefixed with g
        },
      },
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
        { "<LEADER>b", group = "Buffer" },
        { "<LEADER>bs", group = "Swap" },
        { "<LEADER>c", group = "Code" },
        { "<LEADER>d", group = "Dap" },
        { "<LEADER>e", group = "TreeSJ" },
        { "<LEADER>f", group = "Find" },
        { "<LEADER>g", group = "Git" },
        { "<LEADER>h", group = "Harpoon" },
        -- { "<LEADER>i", group = "ISwap" },
        { "<LEADER>k", group = "Git Conflict" },
        { "<LEADER>l", group = "Neotree" },
        { "<LEADER>m", group = "Minimap" },
        { "<LEADER>mb", group = "[b]uffer" },
        { "<LEADER>mw", group = "[w]indow" },
        { "<LEADER>mt", group = "[t]ab" },
        { "<LEADER>n", group = "Noice" },

        { "<LEADER>o", group = "Overseer" },

        { "<LEADER>q", group = "Profiler" },
        { "<LEADER>r", group = "Refactors" },

        { "<LEADER>t", group = "Neotest" },
        { "<LEADER>u", group = "Toggle" },

        { "<LEADER>w", proxy = "<C-W>", group = "windows" },
        { "<LEADER>W", group = "Wrokspace" },
        { "<LEADER>x", group = "Diagnostics" },

        { "<LEADER>/", group = "Grep" },

        { "ga", group = "TextCase" },
        { "gao", group = "Pending Mode Operator" },
        -- { "z", group = "Fold" },

        { "[", group = "Prev" },
        { "]", group = "Next" },

        { "<LEADER><TAB>", group = "Tab" },
      },
    },
  },
}
