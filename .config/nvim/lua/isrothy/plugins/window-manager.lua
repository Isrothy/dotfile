return {
  {
    "s1n7ax/nvim-window-picker",
    version = "2.*",
    keys = {
      {
        "<LEADER>wp",
        function()
          local picked_window_id = require("window-picker").pick_window({
            filter_rules = {
              autoselect_one = false,
              include_current_win = true,
              bo = {
                filetype = {
                  "satellite",
                },
                buftype = {},
              },
            },
          })
          if picked_window_id then
            vim.api.nvim_set_current_win(picked_window_id)
          end
        end,
        desc = "Pick a window",
        mode = "n",
      },
      {
        "<LEADER>wc",
        function()
          local picked_window_id = require("window-picker").pick_window({
            filter_rules = {
              autoselect_one = false,
              include_current_win = true,
              bo = {
                filetype = {
                  "satellite",
                },
                buftype = {},
              },
            },
          })
          if picked_window_id then
            vim.api.nvim_win_close(picked_window_id, true)
          end
        end,
        desc = "Choose a window to close",
        mode = "n",
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
          selection_display = function(char, _)
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
    build = "./kitty/install-kittens.bash",
    keys = {
      {
        "<C-H>",
        "<CMD>lua require('smart-splits').move_cursor_left()<CR>",
        mode = { "n", "t" },
        desc = "Move cursor left",
      },
      {
        "<C-J>",
        "<CMD>lua require('smart-splits').move_cursor_down()<CR>",
        mode = { "n", "t" },
        desc = "Move cursor down",
      },
      {
        "<C-K>",
        "<CMD>lua require('smart-splits').move_cursor_up()<CR>",
        mode = { "n", "t" },
        desc = "Move cursor up",
      },
      {
        "<C-L>",
        "<CMD>lua require('smart-splits').move_cursor_right()<CR>",
        mode = { "n", "t" },
        desc = "Move cursor right",
      },

      {
        "<LEADER>bsh",
        "<CMD>lua require('smart-splits').swap_buf_left()<CR>",
        desc = "Swap buffers left",
      },
      {
        "<LEADER>bsj",
        "<CMD>lua require('smart-splits').swap_buf_down()<CR>",
        desc = "Swap buffers down",
      },
      {
        "<LEADER>bsk",
        "<CMD>lua require('smart-splits').swap_buf_up()<CR>",
        desc = "Swap buffers up",
      },
      {
        "<LEADER>bsl",
        "<CMD>lua require('smart-splits').swap_buf_right()<CR>",
        desc = "Swap buffers right",
      },

      { "<M-h>", "<CMD>lua require('smart-splits').resize_left()<CR>", desc = "Resize left" },
      { "<M-j>", "<CMD>lua require('smart-splits').resize_down()<CR>", desc = "Resize down" },
      { "<M-k>", "<CMD>lua require('smart-splits').resize_up()<CR>", desc = "Resize up" },
      { "<M-l>", "<CMD>lua require('smart-splits').resize_right()<CR>", desc = "Resize right" },
    },
    opts = {
      ignored_buftypes = {
        "nofile",
        "quickfix",
        "prompt",
      },
      default_amount = 1,
      at_edge = "stop",
    },
  },
}
