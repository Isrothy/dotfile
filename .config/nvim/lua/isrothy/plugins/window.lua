return {
  {
    "mrjones2014/smart-splits.nvim",
    -- lazy = false,
    enabled = false,
    event = "VeryLazy",
    keys = {
      {
        "<c-h>",
        function() require("smart-splits").move_cursor_left() end,
        desc = "Move to window left",
        mode = { "n", "t" },
      },
      {
        "<c-j>",
        function() require("smart-splits").move_cursor_down() end,
        desc = "Move to window below",
        mode = { "n", "t" },
      },
      {
        "<c-k>",
        function() require("smart-splits").move_cursor_up() end,
        desc = "Move to window above",
        mode = { "n", "t" },
      },
      {
        "<c-l>",
        function() require("smart-splits").move_cursor_right() end,
        desc = "Move to window right",
        mode = { "n", "t" },
      },
      {
        "<c-\\>",
        function() require("smart-splits").move_cursor_previous() end,
        desc = "Move to previous window",
      },

      {
        "<leader>bh",
        function() require("smart-splits").swap_buf_left() end,
        desc = "Swap buffer right",
      },
      {
        "<leader>bl",
        function() require("smart-splits").swap_buf_right() end,
        desc = "Swap buffer left",
      },
      {
        "<leader>bj",
        function() require("smart-splits").swap_buf_down() end,
        desc = "Swap buffer down",
      },
      {
        "<leader>bk",
        function() require("smart-splits").swap_buf_up() end,
        desc = "Swap buffer up",
      },

      {
        "<m-h>",
        function() require("smart-splits").resize_left() end,
        desc = "Resize window left",
        mode = { "n", "t" },
      },
      {
        "<m-j>",
        function() require("smart-splits").resize_down() end,
        desc = "Resize window down",
        mode = { "n", "t" },
      },
      {
        "<m-k>",
        function() require("smart-splits").resize_up() end,
        desc = "Resize window up",
        mode = { "n", "t" },
      },
      {
        "<m-l>",
        function() require("smart-splits").resize_right() end,
        desc = "Resize window right",
        mode = { "n", "t" },
      },
    },
    opts = {
      ignored_buftypes = {
        "nofile",
        "quickfix",
        "prompt",
      },
      at_edge = "stop",
    },
  },
  {
    "s1n7ax/nvim-window-picker",
    version = "2.*",
    enabled = false,
    keys = {
      {
        "<leader>wp",
        function()
          local picked_window_id = require("window-picker").pick_window()
          if picked_window_id then
            vim.api.nvim_set_current_win(picked_window_id)
          end
        end,
        desc = "Pick a window",
      },
      {
        "<leader>wc",
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
        include_current_win = true,
        bo = {
          filetype = {
            "neo-tree-popup",
            "notify",
            "satellite",
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
}
