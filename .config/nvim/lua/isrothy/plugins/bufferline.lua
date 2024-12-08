local M = {
  "akinsho/bufferline.nvim",
  enabled = true,
  event = { "BufReadPost", "BufNewFile" },
  dependencies = "nvim-tree/nvim-web-devicons",
}

M.keys = {
  {
    "<s-tab>",
    "<cmd>BufferLineCyclePrev<cr>",
    noremap = true,
    silent = true,
    desc = "Previous tab",
  },
  { "<tab>", "<cmd>BufferLineCycleNext<cr>", noremap = true, silent = true, desc = "Next tab" },
  { "<M-,>", "<cmd>BufferLineMovePrev<cr>", noremap = true, silent = true, desc = "Move tab left" },
  {
    "<M-.>",
    "<cmd>BufferLineMoveNext<cr>",
    noremap = true,
    silent = true,
    desc = "Move tab right",
  },
  {
    "<leader>bc",
    "<cmd>BufferLinePickClose<cr>",
    noremap = true,
    silent = true,
    desc = "Close buffer",
  },
  { "<leader>bp", "<cmd>BufferLinePick<cr>", noremap = true, silent = true, desc = "Pick buffer" },
  {
    "<leader>bl",
    "<cmd>BufferLineCloseLeft<cr>",
    noremap = true,
    silent = true,
    desc = "Close left buffer",
  },
  {
    "<leader>br",
    "<cmd>BufferLineCloseRight<cr>",
    noremap = true,
    silent = true,
    desc = "Close right buffer",
  },
  {
    "<leader>bo",
    "<cmd>BufferLineCloseOthers<cr>",
    noremap = true,
    silent = true,
    desc = "Close other buffer",
  },
  { "]b", "<cmd>BufferLineCycleNext<cr>", noremap = true, silent = true, desc = "Buffer forward" },
  { "[b", "<cmd>BufferLineCyclePrev<cr>", noremap = true, silent = true, desc = "Buffer backward" },
  {
    "]B",
    "<cmd>lua require('bufferline').go_to_buffer(-1, false<cr>)",
    noremap = true,
    silent = true,
    desc = "Buffer last",
  },
  {
    "[B",
    "<cmd>lua require('bufferline').go_to_buffer(1, false<cr>)",
    noremap = true,
    silent = true,
    desc = "Buffer first",
  },
}

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

M.config = function()
  require("bufferline").setup({
    options = {
      mode = "buffers", -- set to "tabs" to only show tabpages instead
      -- numbers = "id",
      -- numbers = function(opts)
      -- 	return string.format("%s|%s", opts.ordinal, opts.raise(opts.id))
      -- end,
      indicator = {
        icon = "▎", -- this should be omitted if indicator style is not 'icon'
        -- style = "underline"
        style = "icon",
      },
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
      -- diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = true,

      diagnostics_indicator = function(_, _, diagnostics_dict, _)
        local s = ""
        for e, n in pairs(diagnostics_dict) do
          local sym = e == "error" and " "
            or (e == "warning" and " " or (e == "hint" and "󰌶 " or " "))
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
      -- separator_style = "slant",
      enforce_regular_tabs = false,
      always_show_bufferline = true,
    },
    highlights = require("nord.plugins.bufferline").akinsho(),
  })
end

return M
