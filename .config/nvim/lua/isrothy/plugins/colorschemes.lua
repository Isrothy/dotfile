return {
  {
    "aileot/ex-colors.nvim",
    lazy = true,
    priority = 1000,
    cmd = "ExColors",
    opts = {},
  },
  {
    "Isrothy/nordify.nvim",
    lazy = false,
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
          all = true,
        },
      }
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("nordify_color_scheme", { clear = true }),
        pattern = "nordify*",
        callback = function()
          local palette = require("nordify.palette")["dark"]
          local highlights = { ---@type table<string, vim.api.keyset.highlight>
            CursorLineNr = { bold = true },
            DapStoppedLine = { bg = palette.polar_night.brightest },
            DebugPC = { bg = palette.polar_night.brightest },
            ErrorMsg = { link = "Normal" },
            Folded = { fg = palette.frost.artic_water, bg = palette.polar_night.brighter },
            LspCodeAction = { fg = palette.aurora.yellow },
            LspInlayHint = { fg = palette.polar_night.light },
            LspLens = { fg = palette.polar_night.light },
            MarkSignHL = { fg = palette.aurora.green },
            NeominimapMarkIcon = { fg = palette.aurora.green },
            NoiceLspProgressClient = { fg = palette.frost.ice, italic = true },
            NoiceLspProgressTitle = { fg = palette.snow_storm.origin },
            NoiceMini = { bg = palette.polar_night.bright },
            PmenuSel = { bg = palette.polar_night.brighter },
            QuickFixLine = { bg = "NONE" },
            SatelliteMark = { fg = palette.aurora.green },
            SnacksDashboardIcon = { fg = palette.frost.ice },
            SnacksIndentScope = { fg = palette.frost.ice },
            SnacksStatusColumnMark = { fg = palette.aurora.green },
            TSDefinitionUsage = { bg = palette.polar_night.brightest },
            VertSplit = { fg = palette.polar_night.brighter },
            VirtColumn = { fg = palette.polar_night.brightest },
            VisualNonText = { fg = palette.polar_night.light, bg = palette.polar_night.brighter },
            WarningMsg = { link = "Normal" },
            WinSeparator = { fg = palette.polar_night.brighter },
            ["@error"] = {},
          }
          for k, v in pairs(highlights) do
            vim.api.nvim_set_hl(0, k, v)
          end
        end,
      })
    end,
  },
}
