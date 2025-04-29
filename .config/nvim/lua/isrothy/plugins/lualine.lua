local tab_size = function() return (vim.bo.expandtab and "␠" or "␉") .. vim.bo.tabstop end

local trunc = function(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then
      return ""
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
      return str:sub(1, trunc_len) .. (no_ellipsis and "" or "...")
    end
    return str
  end
end

local diff_source = function()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local function persisted_status()
  if vim.fn.exists("g:persisting") == 1 and vim.g.persisting then
    return "󰆓"
  else
    return "󱙃"
  end
end

return {
  "nvim-lualine/lualine.nvim",
  enabled = true,
  event = "VeryLazy",
  dependencies = {
    "Isrothy/lualine-diagnostic-message",
    "folke/trouble.nvim",
    "nvim-tree/nvim-web-devicons",
    "stevearc/aerial.nvim",
  },
  opts = function()
    local minimap_extension = require("neominimap.statusline").lualine_default
    return {
      options = {
        theme = "nordify-dark",
        icons_enabled = true,
        component_separators = "",
        section_separators = "",
        disabled_filetypes = {
          statusline = {
            "alpha",
            "dashboard",
            "snacks_dashboard",
          },
          winbar = {
            "",
            "Avante",
            "AvanteInput",
            "AvanteSelectedFiles",
            "aerial",
            "undotree",
            "alpha",
            "dap-repl",
            "dapui_breakpoints",
            "dapui_console",
            "dapui_scopes",
            "dapui_stacks",
            "dapui_watches",
            "dbout",
            "dbui",
            "grug-far",
            "man",
            "toggleterm",
            "neo-tree",
            "noice",
            "packer",
            "qf",
            "snacks_dashboard",
            "trouble",
          },
        },
        always_divide_middle = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = trunc(80, 4, nil, true),
          },
          -- macro_recorder,
        },
        lualine_b = {
          { "b:gitsigns_head", icon = "" },
          {
            "diff",
            source = diff_source,
            colored = true,
            symbols = {
              added = " ",
              modified = " ",
              removed = " ",
            },
          },
        },
        lualine_c = {
          {
            "filename",
            file_status = true,
            newfile_status = true,
            symbols = {
              modified = "[+]", -- Text to show when the file is modified.
              readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
              unnamed = "[UNNAMED]", -- Text to show for unnamed buffers.
              newfile = "[New]",
            },
            fmt = trunc(90, 30, 50),
            path = 0,
          },
          {
            "diagnostic-message",
            icons = {
              error = " ",
              warn = " ",
              hint = " ",
              info = " ",
            },
            first_line_only = true,
          },
        },
        lualine_x = {
          tab_size,
          {
            "encoding",
            show_bomb = true,
          },
          {
            "fileformat",
            icons_enabled = true,
            symbols = {
              unix = " ",
              dos = " ",
              mac = " ",
            },
          },
        },
        lualine_y = {
          persisted_status,
          "filetype",
          "lsp_status",
          "codeium_spinner",
          "codecompanion_spinner",
          -- neocodeium_component,
        },
        lualine_z = {
          -- "searchcount",
          -- "selectioncount",
          "location",
          "progress",
          "filesize",
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            "aerial",
            sep = " ⟩ ",
            depth = nil,
            dense = false,
            dense_sep = ".",
            sep_highlight = "@text",
            colored = true,
          },
        },
        lualine_x = {
          {
            "diagnostics",
            update_in_insert = true,
            symbols = {
              error = " ",
              warn = " ",
              hint = " ",
              info = " ",
            },
          },
        },
        lualine_y = {
          { "filetype", icon_only = true },
          { "filename", fmt = trunc(90, 30, 50), path = 1 },
        },
        lualine_z = {},
      },

      inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {
          { "filetype", icon_only = true },
          { "filename", fmt = trunc(90, 30, 50), path = 1 },
        },
        lualine_z = {},
      },
      tabline = {},
      extensions = {
        "aerial",
        "lazy",
        "man",
        "mason",
        "neo-tree",
        "nvim-dap-ui",
        "oil",
        "overseer",
        "quickfix",
        "toggleterm",
        "trouble",
        minimap_extension,
      },
    }
  end,
}
