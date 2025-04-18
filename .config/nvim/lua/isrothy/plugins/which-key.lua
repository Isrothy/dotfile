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
        { "<LEADER>a", group = "AI" },
        { "<LEADER>a?", desc = "Select model" },
        { "<LEADER>aA", desc = "Add current file" },
        { "<LEADER>aa", desc = "Add all buffers" },
        { "<LEADER>ad", desc = "Toggle debug" },
        { "<LEADER>aee", desc = "Edit", mode = { "x" } },
        { "<LEADER>af", desc = "Focus" },
        { "<LEADER>ah", desc = "Toggle hint" },
        { "<LEADER>am", desc = "Repomap" },
        { "<LEADER>aqq", desc = "Ask", mode = { "n", "x" } },
        { "<LEADER>ar", desc = "Refresh" },
        { "<LEADER>as", desc = "Toggle suggestion" },
        { "<LEADER>at", desc = "Toggle" },
        { "<LEADER>ax", desc = "Stop" },
        { "<LEADER>ay", desc = "Select history" },
        {
          "<LEADER>b",
          group = "Buffer",
          expand = function() return require("which-key.extras").expand.buf() end,
        },
        { "<LEADER>bx", group = "Exchange" },
        { "<LEADER>c", group = "Colorize" },
        { "<LEADER>d", group = "Dap" },
        { "<LEADER>e", group = "Explore" },
        { "<LEADER>f", group = "Find" },
        { "<LEADER>g", group = "Git" },
        { "<LEADER>G", group = "Github" },
        { "<LEADER>h", group = "Harpoon" },
        { "<LEADER>j", group = "Split/Join" },

        { "<LEADER>l", group = "LSP" },
        { "<LEADER>m", group = "Minimap" },
        { "<LEADER>mr", group = "Refresh" },
        { "<LEADER>n", group = "Noice" },
        { "<LEADER>o", group = "Options" },
        -- { "<LEADER>q", group = "Profiler" },
        { "<LEADER>r", group = "Refactors" },

        { "<LEADER>t", group = "Test" },

        {
          "<LEADER>w",
          proxy = "<C-W>",
          group = "windows",
          expand = function() return require("which-key.extras").expand.win() end,
        },
        { "<LEADER>W", group = "Wrokspace" },
        { "<LEADER>x", group = "Diagnostics" },
        { "<LEADER>y", group = "Zen mode" },

        { "<LEADER>/", group = "Grep" },
        { "<LEADER>!", group = "Tasks" },

        { "<LEADER><TAB>", group = "Tabpage" },
        { "<LEADER><SPACE>", group = "Whitespaces" },
        { "<LEADER><SPACE>b", group = "Buffer" },

        { "[", group = "Prev" },
        { "]", group = "Next" },
      },
    },
  },
}
