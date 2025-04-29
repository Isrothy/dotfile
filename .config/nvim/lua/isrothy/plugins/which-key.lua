return {
  {
    "folke/which-key.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "echasnovski/mini.ai",
    },
    event = "VeryLazy",
    keys = {
      {
        "<LEADER>?",
        function() require("which-key").show({ global = false }) end,
        desc = "Buffer local keymaps (Which-Key)",
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
          operators = true, -- Adds help for operators like d, y, ...
          motions = true, -- adds help for motions
          text_objects = true, -- Help for text objects triggered after entering an operator
          windows = true, -- default bindings on <c-w>
          nav = true, -- Misc bindings to work with windows
          z = true, -- Bindings for folds, spelling, and others prefixed with z
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
          winblend = 10, -- Value between 0-100 0 for fully opaque and 100 for fully transparent
        },
      },
      -- keys = {
      --   scroll_down = "<c-n>", -- binding to scroll down inside the popup
      --   scroll_up = "<c-p>", -- binding to scroll up inside the popup
      -- },
      spec = {
        { "<LEADER>a", group = "AI", mode = { "n", "x" } },
        {
          "<LEADER>b",
          group = "Buffer",
          expand = function() return require("which-key.extras").expand.buf() end,
        },
        { "<LEADER>bx", group = "Exchange" },
        { "<LEADER>c", group = "Colorize" },
        { "<LEADER>d", group = "Dap", mode = { "n", "x" } },
        { "<LEADER>e", group = "Explore" },
        { "<LEADER>f", group = "Find" },
        { "<LEADER>g", group = "Git", mode = { "n", "x" } },
        { "<LEADER>G", group = "Github" },
        { "<LEADER>h", group = "Harpoon" },

        { "<LEADER>j", group = "Split/Join" },

        { "<LEADER>l", group = "LSP", mode = { "n", "x" } },
        { "<LEADER>m", group = "Minimap" },
        { "<LEADER>mr", group = "Refresh" },
        { "<LEADER>n", group = "Noice" },
        { "<LEADER>o", group = "Options" },

        { "<LEADER>q", group = "Session" },
        { "<LEADER>r", group = "Refactors", mode = { "n", "x" } },

        { "<LEADER>t", group = "Test" },

        {
          "<LEADER>w",
          proxy = "<C-W>",
          group = "windows",
          expand = function() return require("which-key.extras").expand.win() end,
        },
        { "<LEADER>W", group = "Wrokspace" },
        { "<LEADER>x", group = "Diagnostics" },

        { "<LEADER>z", group = "Zen mode" },

        { "<LEADER>/", group = "Grep", mode = { "n", "x" } },
        { "<LEADER>!", group = "Tasks" },
        { "<LEADER>$", group = "Terminal" },

        { "<LEADER><TAB>", group = "Tabpage" },
        { "<LEADER><SPACE>", group = "Whitespaces", mode = { "n", "x" } },
        { "<LEADER><SPACE>b", group = "Buffer" },

        { "[", group = "Prev" },
        { "]", group = "Next" },

        {
          "<LOCALLEADER>p",
          group = "Python",
          cond = function() return vim.bo.filetype == "python" end,
        },
      },
    },
  },
}
