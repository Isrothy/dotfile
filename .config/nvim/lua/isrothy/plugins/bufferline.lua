return {
  "akinsho/bufferline.nvim",
  enabled = false,
  event = { "BufReadPost", "BufNewFile" },
  dependencies = "nvim-tree/nvim-web-devicons",

  keys = {
    { "<leader>bc", "<cmd>BufferLinePickClose<cr>", desc = "Choose a buffer on bufferline to close" },
    { "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Pick buffer on bufferline" },
    { "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", desc = "Close left buffers" },
    { "<leader>bl", "<cmd>BufferLineCloseRight<cr>", desc = "Close right buffers" },
    { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close other buffers" },

    { "<leader>bs", "", desc = "+Sort" },
    { "<leader>bsd", "<cmd>BufferLineSortByDirectory<cr>", desc = "By directory" },
    { "<leader>bse", "<cmd>BufferLineSortByExtension<cr>", desc = "By extension" },
    { "<leader>bsr", "<cmd>BufferLineSortByRelativeDirectory<cr>", desc = "By relative directory" },
    { "<leader>bss", "<cmd>BufferLineSortByTabs<cr>", desc = "By tabs" },

    { "<leader>bt", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle pin" },

    { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Previois buffer" },
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
        numbers = "buffer_id",
        modified_icon = "●",
        left_trunc_marker = "«",
        right_trunc_marker = "»",
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
            local sym = e == "error" and "E" or (e == "warning" and "W" or (e == "hint" and "H" or "I"))
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
