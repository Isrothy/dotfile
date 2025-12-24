local tab_size = function() return (vim.bo.expandtab and "␠" or "␉") .. vim.bo.tabstop end

local bufnr = function() return "B:" .. vim.api.nvim_get_current_buf() end
local winnr = function() return "W:" .. vim.api.nvim_get_current_win() end

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

local session = {
  function()
    local ok, session = pcall(require, "isrothy.utils.session")
    if not ok then
      return ""
    end

    if session.auto_save_enabled then
      return " Auto"
    else
      return "󰆔 Man"
    end
  end,

  color = function()
    local ok, session = pcall(require, "isrothy.utils.session")
    if ok and session.auto_save_enabled then
      return { fg = "#2E3440", gui = "bold" }
    else
      return { fg = "#4C566A" }
    end
  end,
  separator = { left = "", right = "" },
}

local ts_status = {
  function()
    local buf = vim.api.nvim_get_current_buf()
    local ok, parser = pcall(vim.treesitter.get_parser, buf)

    if ok and parser then
      return " ON"
    end
    return " Off"
  end,

  color = function()
    local buf = vim.api.nvim_get_current_buf()
    local ok, parser = pcall(vim.treesitter.get_parser, buf)

    if ok and parser then
      return { fg = "#A3BE8C", gui = "bold" }
    else
      return { fg = "#616E88" }
    end
  end,

  separator = { left = "", right = "" },
}

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "Isrothy/lualine-diagnostic-message",
    "nvim-tree/nvim-web-devicons",
    -- "stevearc/aerial.nvim",
  },
  opts = function()
    -- local minimap_extension = require("neominimap.statusline").lualine_default
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
            -- "snacks_dashboard",
          },
          winbar = {
            "",
            "Avante",
            "AvanteInput",
            "AvanteSelectedFiles",
            "aerial",
            "alpha",
            "dap-repl",
            "dap-view",
            "dapui_breakpoints",
            "dapui_console",
            "dapui_scopes",
            "dapui_stacks",
            "dapui_watches",
            "dbout",
            "dbui",
            "grug-far",
            "kitty-scrollback",
            "man",
            "neo-tree",
            "noice",
            "packer",
            "qf",
            "snacks_dashboard",
            "toggleterm",
            "trouble",
            "undotree",
          },
        },
        always_divide_middle = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          session,
          {
            "mode",
            fmt = trunc(80, 4, nil, true),
          },
        },
        lualine_b = {
          { "b:gitsigns_head", icon = "" },
          {
            "diff",
            source = diff_source,
            colored = true,
            symbols = {
              added = " ",
              modified = " ",
              removed = " ",
            },
          },
        },
        lualine_c = {
          {
            "filename",
            file_status = true,
            newfile_status = true,
            symbols = {
              modified = "●",
              readonly = "",
              unnamed = "[No Name]",
              newfile = "✚",
            },
            fmt = trunc(90, 30, 50),
            path = 0,
          },
          {
            "diagnostic-message",
            icons = {
              error = " ",
              warn = " ",
              hint = " ",
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
              unix = "LF",
              dos = "CRLF",
              mac = "CR",
            },
          },
        },
        lualine_y = {
          -- "codeium_spinner",
          "filetype",
          ts_status,
          "lsp_status",
          -- "codecompanion_spinner",
          -- neocodeium_component,
        },
        lualine_z = {
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
        lualine_a = {
          winnr,
        },
        lualine_b = {
          { "filename", fmt = trunc(90, 30, 50), path = 1 },
        },
        lualine_c = {
          {
            "diagnostics",
            update_in_insert = true,
            symbols = {
              error = " ",
              warn = " ",
              hint = " ",
              info = " ",
            },
          },
        },
        lualine_x = {},
        lualine_y = {
          -- { "filetype", icon_only = false },
          -- bufnr,
        },
        lualine_z = {},
      },

      inactive_winbar = {
        lualine_a = {
          winnr,
        },
        lualine_b = {
          { "filename", fmt = trunc(90, 30, 50), path = 1 },
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {
          -- { "filetype", icon_only = false },
          -- bufnr,
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
        -- minimap_extension,
      },
    }
  end,
}
