return {
  {
    "s1n7ax/nvim-window-picker",
    version = "2.*",
    keys = {
      {
        "<LEADER>wp",
        function()
          local picked_window_id = require("window-picker").pick_window()
            or vim.api.nvim_get_current_win()
          vim.api.nvim_set_current_win(picked_window_id)
        end,
        desc = "Pick a Window",
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
    build = "./kitty/install-kittens.bash",
    keys = {
      {
        "<C-H>",
        "<CMD>lua require('smart-splits').move_cursor_left()<CR>",
        mode = { "n", "t" },
        desc = "Move Cursor Left",
      },
      {
        "<C-J>",
        "<CMD>lua require('smart-splits').move_cursor_down()<CR>",
        mode = { "n", "t" },
        desc = "Move Cursor Down",
      },
      {
        "<C-K>",
        "<CMD>lua require('smart-splits').move_cursor_up()<CR>",
        mode = { "n", "t" },
        desc = "Move Cursor Up",
      },
      {
        "<C-L>",
        "<CMD>lua require('smart-splits').move_cursor_right()<CR>",
        mode = { "n", "t" },
        desc = "Move Cursor Right",
      },

      {
        "<LEADER>bsh",
        "<CMD>lua require('smart-splits').swap_buf_left()<CR>",
        desc = "Swap Buffers Left",
      },
      {
        "<LEADER>bsj",
        "<CMD>lua require('smart-splits').swap_buf_down()<CR>",
        desc = "Swap Buffers Down",
      },
      {
        "<LEADER>bsk",
        "<CMD>lua require('smart-splits').swap_buf_up()<CR>",
        desc = "Swap Buffers Up",
      },
      {
        "<LEADER>bsl",
        "<CMD>lua require('smart-splits').swap_buf_right()<CR>",
        desc = "Swap Buffers Right",
      },

      { "<M-h>", "<CMD>lua require('smart-splits').resize_left()<CR>", desc = "Resize Left" },
      { "<M-j>", "<CMD>lua require('smart-splits').resize_down()<CR>", desc = "Resize Down" },
      { "<M-k>", "<CMD>lua require('smart-splits').resize_up()<CR>", desc = "Resize Up" },
      { "<M-l>", "<CMD>lua require('smart-splits').resize_right()<CR>", desc = "Resize Right" },
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
