local tab_size = function() return (vim.bo.expandtab and "␠" or "␉") .. vim.bo.tabstop end

-- Truncating components in smaller window
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

-- Using external source for diff
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

local function neocodeium_component()
  local neocodeium = require("neocodeium")
  if not neocodeium then
    return ""
  end

  local symbols = {
    status = {
      [0] = "󰚩 ", -- Enabled
      [1] = "󱚧 ", -- Disabled Globally
      [2] = "󱙻 ", -- Disabled for Buffer
      [3] = "󱙺 ", -- Disabled for Buffer filetype
      [4] = "󱙺 ", -- Disabled for Buffer with enabled function
      [5] = "󱚠 ", -- Disabled for Buffer encoding
    },
    server_status = {
      [0] = "󰣺 ", -- Connected
      [1] = "󰣻 ", -- Connecting
      [2] = "󰣽 ", -- Disconnected
    },
  }
  local highlights = {
    status = {
      [0] = "%#LualineNeoCodeiumEnabled#",
      [1] = "%#LualineNeoCodeiumDisabled#",
      [2] = "%#LualineNeoCodeiumBuffer#",
      [3] = "%#LualineNeoCodeiumFiletype#",
      [4] = "%#LualineNeoCodeiumFiletype#",
      [5] = "%#LualineNeoCodeiumEncoding#",
    },
    server_status = {
      [0] = "%#LualineNeoCodeiumConnected#",
      [1] = "%#LualineNeoCodeiumConnecting#",
      [2] = "%#LualineNeoCodeiumDisconnected#",
    },
  }
  local plugin_status, server_status = require("neocodeium").get_status()
  return highlights.status[plugin_status]
    .. symbols.status[plugin_status]
    .. highlights.server_status[server_status]
    .. symbols.server_status[server_status]
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "Isrothy/lualine-diagnostic-message",
    "Isrothy/nordify.nvim",
    "meuter/lualine-so-fancy.nvim",
    "folke/noice.nvim",
    "folke/trouble.nvim",
  },
  opts = function()
    local c = require("nordify.palette")["dark"]
    -- local c = require("nord.colors").palette ---@type Nord.Palette
    local minimap_extension = require("neominimap.statusline").lualine_default
    local trouble = require("trouble")
    local symbols = trouble.statusline({
      mode = "lsp_document_symbols",
      groups = {},
      title = false,
      filter = { range = true },
      format = "{kind_icon}{symbol.name:Normal} ⟩",
      hl_group = "lualine_c_normal",
    })

    return {
      options = {
        theme = "nordify-dark",
        icons_enabled = true,
        component_separators = "",
        section_separators = "",
        disabled_filetypes = {
          statusline = {
            "dashboard",
            "alpha",
          },
          winbar = {
            "Avante",
            "AvanteSelectedFiles",
            "AvanteInput",
            "neo-tree",
            "aerial",
            "packer",
            "alpha",
            "dap-repl",
            "dapui_watches",
            "dapui_stacks",
            "dapui_breakpoints",
            "dapui_scopes",
            "dapui_colsoles",
            "trouble",
            "snacks_dashboard",
            "qf",
            "grug-far",
            "dbout",
            "noice",
            "",
          },
        },
        always_divide_middle = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          { "mode", fmt = trunc(80, 4, nil, true) },
          {
            require("noice").api.status.command.get,
            cond = require("noice").api.status.command.has,
          },
          Snacks.profiler.status(),
          {
            "fancy_macro",
            icon = { "⏺", color = { fg = c.polar_night.origin } },
          },
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
          "encoding",
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
          "fancy_filetype",
          "fancy_lsp_servers",
          neocodeium_component,
        },
        lualine_z = {
          "searchcount",
          "selectioncount",
          "location",
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
            symbols.get,
            cond = symbols.has,
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

  config = function(_, opts)
    local group = vim.api.nvim_create_augroup("Lualine.NeoCodeium", { clear = true })
    vim.api.nvim_create_autocmd({ "User" }, {
      pattern = { "NeoCodeiumServer*", "NeoCodeium*{En,Dis}abled" },
      group = group,
      callback = function()
        require("lualine").refresh({
          scope = "tabpage",
          place = { "statusline" },
        })
      end,
    })

    require("lualine").setup(opts)
    local palette = require("nordify.palette")["dark"]
    vim.api.nvim_set_hl(0, "WinBar", { bg = palette.polar_night.brighter })
    vim.api.nvim_set_hl(0, "WinBarNC", { bg = palette.polar_night.brighter })
  end,
}
