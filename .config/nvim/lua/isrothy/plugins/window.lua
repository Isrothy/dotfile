return {
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    init = function()
      vim.opt.laststatus = 3
      vim.opt.splitkeep = "screen"
    end,
    keys = {
      {
        "<leader>wE",
        function() require("edgy").toggle() end,
        desc = "Edgy Toggle",
      },
      {
        "<leader>we",
        function() require("edgy").select() end,
        desc = "Edgy Select Window",
      },
    },

    opts = function()
      local opts = {
        options = {
          left = { size = 30 },
          bottom = { size = 10 },
          right = { size = 20 },
          top = { size = 10 },
        },
        exit_when_last = true,
        animate = { enabled = false },
        keys = {
          ---@param win Edgy.Window
          ["<m-h>"] = function(win)
            local view = win.view
            local edgebar = view.edgebar
            local pos = edgebar.pos
            if pos == "left" then
              win:resize("width", -1)
            elseif pos == "right" then
              win:resize("width", 1)
            end
          end,
          ---@param win Edgy.Window
          ["<m-l>"] = function(win)
            local view = win.view
            local edgebar = view.edgebar
            local pos = edgebar.pos
            if pos == "left" then
              win:resize("width", 1)
            elseif pos == "right" then
              win:resize("width", -1)
            end
          end,
          ["<m-k>"] = function(win) win:resize("height", 1) end,
          ["<m-j>"] = function(win) win:resize("height", -1) end,
        },
        wo = {
          winbar = false,
          winfixwidth = true,
          winfixheight = false,
          winhighlight = "WinBar:EdgyWinBar,Normal:EdgyNormal",
          spell = false,
          signcolumn = "no",
        },
        bottom = {
          {
            ft = "toggleterm",
            size = { height = 0.3 },
            filter = function(_, win) return vim.api.nvim_win_get_config(win).relative == "" end,
          },
          "Trouble",
          { ft = "qf", title = "QuickFix" },
          {
            ft = "help",
            size = { height = 0.5 },
            filter = function(buf) return vim.bo[buf].buftype == "help" end,
          },
          { title = "Neotest Output", ft = "neotest-output-panel", size = { height = 15 } },
          {
            ft = "dbout",
          },
        },
        left = {
          { title = "Neotest Summary", ft = "neotest-summary" },
          {
            ft = "codecompanion",
            size = {
              width = 50,
            },
          },
          { title = "Grug Far", ft = "grug-far", size = { width = 0.4 } },
          {
            ft = "undotree",
            size = { width = 40 },
          },
          { ft = "dbui" },
          {
            title = "Luapad",
            ft = "lua",
            filter = function(buf) return vim.b[buf].is_luapad end,
            size = {
              width = 50,
            },
          },
        },

        right = {
          {
            title = "Neominimap",
            ft = "neominimap",
            size = { width = 20 },
          },
          {
            ft = "aerial",
            size = { width = 30 },
          },
        },
      }

      for i, v in ipairs({ "filesystem", "buffers", "git_status" }) do
        table.insert(opts.left, i, {
          title = "Neo-Tree " .. v:gsub("_", " "):gsub("^%l", string.upper),
          ft = "neo-tree",
          filter = function(buf) return vim.b[buf].neo_tree_source == v end,
          pinned = false,
        })
      end
      for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
        opts[pos] = opts[pos] or {}
        ---@diagnostic disable-next-line: param-type-mismatch
        table.insert(opts[pos], {
          ft = "trouble",
          filter = function(_, win)
            return vim.w[win].trouble
              and vim.w[win].trouble.position == pos
              and vim.w[win].trouble.type == "split"
              and vim.w[win].trouble.relative == "editor"
              and not vim.w[win].trouble_preview
          end,
        })
      end

      return opts
    end,
  },
  {
    "s1n7ax/nvim-window-picker",
    version = "2.*",
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
    enabled = true,
    keys = {
      {
        "<c-h>",
        function() require("smart-splits").move_cursor_left() end,
        desc = "Move cursor to the window to the left",
      },
      {
        "<c-j>",
        function() require("smart-splits").move_cursor_down() end,
        desc = "Move cursor to the window below",
      },
      {
        "<c-k>",
        function() require("smart-splits").move_cursor_up() end,
        desc = "Move cursor to the window above",
      },
      {
        "<c-l>",
        function() require("smart-splits").move_cursor_right() end,
        desc = "Move cursor to the window to the right",
      },

      {
        "<leader>bxh",
        function() require("smart-splits").swap_buf_left() end,
        desc = "Exchange with the buffer to the left",
      },
      {
        "<leader>bxj",
        function() require("smart-splits").swap_buf_down() end,
        desc = "Exchange with the buffer below",
      },
      {
        "<leader>bxk",
        function() require("smart-splits").swap_buf_up() end,
        desc = "Exchange with the buffer above",
      },
      {
        "<leader>bxl",
        function() require("smart-splits").swap_buf_right() end,
        desc = "Exchange with the buffer to the right",
      },

      { "<m-h>", function() require("smart-splits").resize_left() end, desc = "Resize left" },
      { "<m-j>", function() require("smart-splits").resize_down() end, desc = "Resize down" },
      { "<m-k>", function() require("smart-splits").resize_up() end, desc = "Resize up" },
      { "<m-l>", function() require("smart-splits").resize_right() end, desc = "Resize right" },
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
