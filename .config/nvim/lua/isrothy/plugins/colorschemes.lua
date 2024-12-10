return {
  {
    "Isrothy/nord.nvim",
    priority = 1000,
    lazy = false,
    enabled = true,
    opts = {
      transparent = false,
      terminal_colors = true,
      diff = { mode = "bg" },
      borders = false,
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
        -- highlights.FloatBorder = { fg = colors.polar_night.brighter }

        highlights.EmissionAdded = { bg = colors.polar_night.brighter }
        highlights.EmissionRemoved = { bg = colors.polar_night.brighter }

        highlights.WinBar = { bg = colors.polar_night.brighter }
        highlights.WinBarNC = { bg = colors.polar_night.brighter }

        highlights.PmenuSel = { bg = colors.polar_night.brighter }

        highlights.SnacksDashboardIcon = { fg = colors.frost.ice }

        -- highlights.NormalFloat = { fg = colors.snow_storm.origin, bg = colors.polar_night.bright }
        -- highlights.WhichKeyFloat = { bg = colors.polar_night.origin }

        highlights.MatchParen = { bg = colors.polar_night.origin, reverse = true }

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
        -- highlights.QuickFixLine = { bg = colors.polar_night.brighter }

        highlights["@error"] = {}

        highlights.DapStoppedLine = { bg = colors.polar_night.brightest }
        highlights.DebugPC = { bg = colors.polar_night.brightest }

        highlights.VirtColumn = { fg = colors.polar_night.brightest }

        -- highlights.ScrollViewSearch = { fg = colors.frost.artic_water }

        -- highlights.FlashLabel = { fg = colors.aurora.orange, bg = colors.polar_night.brightest, bold = true }

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
  },
}
