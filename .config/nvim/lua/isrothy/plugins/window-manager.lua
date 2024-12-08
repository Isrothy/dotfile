return {
  {
    "s1n7ax/nvim-window-picker",
    version = "2.*",
    keys = {
      {
        "<leader>wp",
        function()
          local picked_window_id = require("window-picker").pick_window()
            or vim.api.nvim_get_current_win()
          vim.api.nvim_set_current_win(picked_window_id)
        end,
        desc = "Pick a window",
        mode = "n",
      },
    },
    opts = {
      hint = "statusline-winbar",
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
            "aerial",
            "edgy",
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
          selection_display = function(char, windowid)
            return "%=" .. char .. "%="
          end,
          use_winbar = "never", -- "always" | "never" | "smart"
        },
      },
      show_prompt = false,
    },
  },
  {
    "mrjones2014/smart-splits.nvim",
    enabled = true,
    keys = {
      {
        "<C-h>",
        "<cmd>lua require('smart-splits').move_cursor_left()<cr>",
        mode = { "n", "t" },
        desc = "Move cursor left",
      },
      {
        "<C-j>",
        "<cmd>lua require('smart-splits').move_cursor_down()<cr>",
        mode = { "n", "t" },
        desc = "Move cursor down",
      },
      {
        "<C-k>",
        "<cmd>lua require('smart-splits').move_cursor_up()<cr>",
        mode = { "n", "t" },
        desc = "Move cursor up",
      },
      {
        "<C-l>",
        "<cmd>lua require('smart-splits').move_cursor_right()<cr>",
        mode = { "n", "t" },
        desc = "Move cursor right",
      },

      {
        "<leader>bsh",
        "<cmd>lua require('smart-splits').swap_buf_left()<cr>",
        desc = "Swap buffers left",
      },
      {
        "<leader>bsj",
        "<cmd>lua require('smart-splits').swap_buf_down()<cr>",
        desc = "Swap buffers down",
      },
      {
        "<leader>bsk",
        "<cmd>lua require('smart-splits').swap_buf_up()<cr>",
        desc = "Swap buffers up",
      },
      {
        "<leader>bsl",
        "<cmd>lua require('smart-splits').swap_buf_right()<cr>",
        desc = "Swap buffers right",
      },

      { "<M-h>", "<cmd>lua require('smart-splits').resize_left()<cr>", desc = "Resize left" },
      { "<M-j>", "<cmd>lua require('smart-splits').resize_down()<cr>", desc = "Resize down" },
      { "<M-k>", "<cmd>lua require('smart-splits').resize_up()<cr>", desc = "Resize up" },
      { "<M-l>", "<cmd>lua require('smart-splits').resize_right()<cr>", desc = "Resize right" },
    },
    opts = {
      ignored_filetypes = {
        "nofile",
        "quickfix",
        "prompt",
      },
      default_amount = 1,
      at_edge = "stop",
    },
  },
}
