return {
  "akinsho/bufferline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = "nvim-tree/nvim-web-devicons",

  keys = {
    { "<LEADER>bc", "<CMD>BufferLinePickClose<CR>", desc = "Choose a buffer on bufferline to close" },
    { "<LEADER>bp", "<CMD>BufferLinePick<CR>", desc = "Pick buffer on bufferline" },
    { "<LEADER>bh", "<CMD>BufferLineCloseLeft<CR>", desc = "Close left buffers" },
    { "<LEADER>bl", "<CMD>BufferLineCloseRight<CR>", desc = "Close right buffers" },
    { "<LEADER>bo", "<CMD>BufferLineCloseOthers<CR>", desc = "Close other buffers" },

    { "<LEADER>bs", "", desc = "+Sort" },
    { "<LEADER>bsd", "<CMD>BufferLineSortByDirectory<CR>", desc = "By directory" },
    { "<LEADER>bse", "<CMD>BufferLineSortByExtension<CR>", desc = "By extension" },
    { "<LEADER>bsr", "<CMD>BufferLineSortByRelativeDirectory<CR>", desc = "By relative directory" },
    { "<LEADER>bss", "<CMD>BufferLineSortByTabs<CR>", desc = "By tabs" },

    { "<LEADER>bt", "<CMD>BufferLineTogglePin<CR>", desc = "Toggle pin" },

    { "]b", "<CMD>BufferLineCycleNext<CR>", desc = "Next buffer" },
    { "[b", "<CMD>BufferLineCyclePrev<CR>", desc = "Previois buffer" },
    { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
    { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
  },
  opts = function()
    local ignored_filetypes = {
      "qf",
      "quickfix",
      "terminal",
      "NvimTree",
      "help",
      "fugitive",
      "grug-far",
    }
    local ignored_buftypes = { "terminal" }
    return {
      options = {
        mode = "buffers",
        indicator = { icon = "▎", style = "icon" },
        modified_icon = "●",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        truncate_names = true,
        tab_size = 18,
        custom_filter = function(buf_number, _)
          local ft = vim.bo[buf_number].filetype
          local bt = vim.bo[buf_number].buftype
          if vim.tbl_contains(ignored_filetypes, ft) then
            return false
          end
          if vim.tbl_contains(ignored_buftypes, bt) then
            return false
          end
          if vim.fn.bufname(buf_number) == "quickfix" then
            return false
          end
          return true
        end,

        diagnostics = nil,
        diagnostics_update_in_insert = true,

        diagnostics_indicator = function(_, _, diagnostics_dict, _)
          local s = ""
          for e, n in pairs(diagnostics_dict) do
            local sym = e == "error" and " " or (e == "warning" and " " or (e == "hint" and "󰌶 " or " "))
            s = s .. sym .. n
          end
          return s
        end,

        color_icons = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = true,
        show_duplicate_prefix = true,
        separator_style = "thin",
        enforce_regular_tabs = false,
        always_show_bufferline = true,
      },
      -- highlights = require("nord").plugins.bufferline.akinsho,
      -- highlights = require("nord.plugins.bufferline").akinsho(),
      highlights = require("nordify.plugins.bufferline").get("dark"),
    }
  end,
}
