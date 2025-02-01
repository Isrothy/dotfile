return {
  {
    dir = "~/nordify.nvim",
    -- "Isrothy/nordify.nvim",
    priority = 1000,
    lazy = false,
    enabled = false,
    init = function()
      vim.g.nordify = {
        transparent = false,
        terminal_colors = true,
        diff = { mode = "fg" },
        borders = true,
        search = { theme = "vscode" },
        errors = { mode = "none" },
        cache = false,
        styles = {
          comments = { italic = true },
          keywords = { bold = true },
          functions = { italic = true },
          variables = {},
          bufferline = {
            current = { bold = true },
            modified = { italic = true },
          },
        },
        plugins = {
          -- all = true,
        },
      }
    end,
    config = function()
      vim.cmd.colorscheme("nordify-dark")
      local palette = require("nordify.palette")["dark"]
      ---@type table<string, vim.api.keyset.highlight>
      local highlights = {
        CursorLineNr = { bold = true },
        MarkSignHL = { fg = palette.aurora.green },
        NeominimapMarkIcon = { fg = palette.aurora.green },
        SatelliteMark = { fg = palette.aurora.green },
        VertSplit = { fg = palette.polar_night.brighter },
        WinSeparator = { fg = palette.polar_night.brighter },
        LightBulbSign = { fg = palette.aurora.yellow },

        SnacksStatusColumnMark = { fg = palette.aurora.green },

        WinBar = { bg = palette.polar_night.brighter },
        WinBarNC = { bg = palette.polar_night.brighter },

        PmenuSel = { bg = palette.polar_night.brighter },

        SnacksDashboardIcon = { fg = palette.frost.ice },
        SnacksIndentScope = { fg = palette.frost.ice },

        -- MatchParen = { bg = palette.polar_night.origin, reverse = true },

        NoiceLspProgressClient = { fg = palette.frost.ice, italic = true },
        NoiceLspProgressTitle = { fg = palette.snow_storm.origin },
        NoiceMini = { bg = palette.polar_night.bright },

        ErrorMsg = { link = "Normal" },
        WarningMsg = { link = "Normal" },

        TermCursor = { fg = palette.aurora.green, bg = palette.none, reverse = true },

        Folded = { fg = palette.frost.artic_water, bg = palette.polar_night.brighter },

        TSDefinitionUsage = { bg = palette.polar_night.brightest },

        LspLens = { fg = palette.polar_night.light },
        LspInlayHint = { fg = palette.polar_night.light },

        QuickFixLine = { bg = "NONE" },
        -- QuickFixLine = { bg = colors.polar_night.brighter },

        ["@error"] = {},

        DapStoppedLine = { bg = palette.polar_night.brightest },
        DebugPC = { bg = palette.polar_night.brightest },

        VirtColumn = { fg = palette.polar_night.brightest },

        LualineNeoCodeiumEnabled = { fg = palette.aurora.green, bg = palette.polar_night.bright },
        LualineNeoCodeiumDisabled = { fg = palette.aurora.red, bg = palette.polar_night.bright },
        LualineNeoCodeiumBuffer = { fg = palette.aurora.red, bg = palette.polar_night.bright },
        LualineNeoCodeiumFiletype = { fg = palette.aurora.red, bg = palette.polar_night.bright },
        LualineNeoCodeiumEncoding = { fg = palette.aurora.red, bg = palette.polar_night.bright },

        LualineNeoCodeiumConnected = { fg = palette.aurora.green, bg = palette.polar_night.bright },
        LualineNeoCodeiumConnecting = {
          fg = palette.aurora.yellow,
          bg = palette.polar_night.bright,
        },
        LualineNeoCodeiumDisconnected = { fg = palette.aurora.red, bg = palette.polar_night.bright },
      }
      for k, v in pairs(highlights) do
        vim.api.nvim_set_hl(0, k, v)
      end
    end,
  },
  {
    "Isrothy/nord.nvim",
    priority = 1000,
    lazy = false,
    enabled = true,
    opts = {
      transparent = false,
      terminal_colors = true,
      diff = { mode = "fg" },
      borders = true,
      errors = { mode = "none" },
      styles = {
        comments = { italic = true },
        keywords = { bold = true },
        functions = { italic = true },
        variables = {},
        bufferline = {
          current = { bold = true },
          modified = { italic = true },
        },
      },
      colorblind = {
        enable = false,
        preserve_background = true,
        severity = {
          protan = 0.7,
          deutan = 1.0,
          tritan = 0.4,
        },
      },
      ---@param colors Nord.Palette
      on_highlights = function(highlights, colors)
        highlights.CursorLineNr = { bold = true }
        highlights.MarkSignHL = { fg = colors.aurora.green }
        highlights.NeominimapMarkIcon = { fg = colors.aurora.green }
        highlights.SatelliteMark = { fg = colors.aurora.green }
        highlights.VertSplit = { fg = colors.polar_night.brighter }
        highlights.WinSeparator = { fg = colors.polar_night.brighter }
        highlights.LightBulbSign = { fg = colors.aurora.yellow }

        highlights.EmissionRemoved = { bg = colors.polar_night.brighter }

        highlights.WinBar = { bg = colors.polar_night.brighter }
        highlights.WinBarNC = { bg = colors.polar_night.brighter }

        highlights.PmenuSel = { bg = colors.polar_night.brighter }

        -- highlights.NormalFloat = { fg = colors.snow_storm.origin, bg = colors.polar_night.bright }
        -- highlights.WhichKeyFloat = { bg = colors.polar_night.origin }

        highlights.SnacksIndentScope = { fg = colors.frost.ice }

        -- highlights.MatchParen = { bg = colors.polar_night.origin, reverse = true }

        highlights.NoiceLspProgressClient = { fg = colors.frost.ice, italic = true }
        highlights.NoiceLspProgressTitle = { fg = colors.snow_storm.origin }
        highlights.NoiceMini = { bg = colors.polar_night.bright }

        highlights.ErrorMsg = { link = "Normal" }
        highlights.WarningMsg = { link = "Normal" }

        highlights.TermCursor = { fg = colors.aurora.green, bg = colors.none, reverse = true }

        highlights.Folded = { fg = colors.frost.artic_water, bg = colors.polar_night.brighter }

        highlights.TSDefinitionUsage = { bg = colors.polar_night.brightest }

        highlights.DiagnosticLineNrError = { fg = colors.aurora.red, bold = true }
        highlights.DiagnosticLineNrWarn = { fg = colors.aurora.yellow, bold = true }
        highlights.DiagnosticLineNrInfo = { fg = colors.frost.ice, bold = true }
        highlights.DiagnosticLineNrHint = { fg = colors.frost.artic_water, bold = true }

        highlights.LspLens = { fg = colors.polar_night.light }
        highlights.LspInlayHint = { fg = colors.polar_night.light }

        highlights.QuickFixLine = { bg = "NONE" }

        highlights["@error"] = {}

        highlights.DapStoppedLine = { bg = colors.polar_night.brightest }
        highlights.DebugPC = { bg = colors.polar_night.brightest }

        highlights.VirtColumn = { fg = colors.polar_night.brightest }

        highlights.LualineNeoCodeiumEnabled =
          { fg = colors.aurora.green, bg = colors.polar_night.bright }
        highlights.LualineNeoCodeiumDisabled =
          { fg = colors.aurora.red, bg = colors.polar_night.bright }
        highlights.LualineNeoCodeiumBuffer =
          { fg = colors.aurora.red, bg = colors.polar_night.bright }
        highlights.LualineNeoCodeiumFiletype =
          { fg = colors.aurora.red, bg = colors.polar_night.bright }
        highlights.LualineNeoCodeiumEncoding =
          { fg = colors.aurora.red, bg = colors.polar_night.bright }

        highlights.LualineNeoCodeiumConnected =
          { fg = colors.aurora.green, bg = colors.polar_night.bright }
        highlights.LualineNeoCodeiumConnecting =
          { fg = colors.aurora.yellow, bg = colors.polar_night.bright }
        highlights.LualineNeoCodeiumDisconnected =
          { fg = colors.aurora.red, bg = colors.polar_night.bright }
      end,
    },
    config = function(_, opts)
      require("nord").setup(opts)
      vim.cmd.colorscheme("nord")
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    enabled = false,
    opts = {},
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
