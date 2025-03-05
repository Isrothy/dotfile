return {
  {
    "s1n7ax/nvim-window-picker",
    version = "2.*",
    keys = {
      {
        "<LEADER>wp",
        function()
          local picked_window_id = require("window-picker").pick_window()
          if picked_window_id then
            vim.api.nvim_set_current_win(picked_window_id)
          end
        end,
        desc = "Pick a window",
      },
      {
        "<LEADER>wc",
        function()
          local picked_window_id = require("window-picker").pick_window({
            filter_rules = {
              include_current_win = true,
            },
          })
          if picked_window_id then
            vim.api.nvim_win_close(picked_window_id, true)
          end
        end,
        desc = "Choose a window to close",
      },
    },
    opts = {
      hint = "statusline-winbar",
      selection_chars = "FJDKSLA;CMRUEIWOQP",
      -- hint = "floating-big-letter",
      filter_rules = {
        autoselect_one = false,
        include_current_win = false,
        bo = {
          filetype = {
            "neo-tree",
            "neo-tree-popup",
            "notify",
            "neominimap",
            "quickfix",
            "qf",
            "aerial",
            "edgy",
            "satellite",
          },
          buftype = {
            "terminal",
            "aerial",
            "nofile",
          },
        },
      },
      picker_config = {
        statusline_winbar_picker = {
          selection_display = function(char, _) return "%=" .. char .. "%=" end,
          use_winbar = "never", -- "always" | "never" | "smart"
        },
      },
      show_prompt = false,
    },
  },
  {
    "mrjones2014/smart-splits.nvim",
    keys = {
      {
        "<C-H>",
        function() require("smart-splits").move_cursor_left() end,
        mode = { "n", "t" },
        desc = "Move cursor left",
      },
      {
        "<C-J>",
        function() require("smart-splits").move_cursor_down() end,
        mode = { "n", "t" },
        desc = "Move cursor down",
      },
      {
        "<C-K>",
        function() require("smart-splits").move_cursor_up() end,
        mode = { "n", "t" },
        desc = "Move cursor up",
      },
      {
        "<C-L>",
        function() require("smart-splits").move_cursor_right() end,
        mode = { "n", "t" },
        desc = "Move cursor right",
      },

      { "<LEADER>bxh", function() require("smart-splits").swap_buf_left() end, desc = "Exchange buffers left" },
      { "<LEADER>bxj", function() require("smart-splits").swap_buf_down() end, desc = "Exchange buffers down" },
      { "<LEADER>bxk", function() require("smart-splits").swap_buf_up() end, desc = "Exchange buffers up" },
      { "<LEADER>bxl", function() require("smart-splits").swap_buf_right() end, desc = "Exchange buffers right" },

      { "<M-h>", function() require("smart-splits").resize_left() end, desc = "Resize left" },
      { "<M-j>", function() require("smart-splits").resize_down() end, desc = "Resize down" },
      { "<M-k>", function() require("smart-splits").resize_up() end, desc = "Resize up" },
      { "<M-l>", function() require("smart-splits").resize_right() end, desc = "Resize right" },

      { "<LEADER>wr", function() require("smart-splits").start_resize_mode() end, desc = "Start resize mode" },
    },
    opts = {
      ignored_buftypes = {
        "nofile",
        "quickfix",
        "prompt",
      },
      default_amount = 1,
      at_edge = "stop",
      multiplexer_integration = false,
    },
  },
}
