return {
  {
    "aileot/ex-colors.nvim",
    lazy = true,
    cmd = "ExColors",
    ---@type ExColors.Config
    opts = {},
    init = function() vim.cmd.colorscheme("ex-nordify-dark") end,
  },
  {
    -- dir = "~/nordify.nvim",
    "Isrothy/nordify.nvim",
    -- priority = 1000,
    lazy = true,
    enabled = true,
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
    end,
    config = function()
      -- vim.cmd.colorscheme("nordify-dark")

      local palette = require("nordify.palette")["dark"]
      ---@type table<string, vim.api.keyset.highlight>
      local highlights = {
        CursorLineNr = { bold = true },
        MarkSignHL = { fg = palette.aurora.green },
        NeominimapMarkIcon = { fg = palette.aurora.green },
        SatelliteMark = { fg = palette.aurora.green },
        VertSplit = { fg = palette.polar_night.brighter },
        WinSeparator = { fg = palette.polar_night.brighter },
        LspCodeAction = { fg = palette.aurora.yellow },

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
        LualineNeoCodeiumConnecting = { fg = palette.aurora.yellow, bg = palette.polar_night.bright },
        LualineNeoCodeiumDisconnected = { fg = palette.aurora.red, bg = palette.polar_night.bright },
      }
      for k, v in pairs(highlights) do
        vim.api.nvim_set_hl(0, k, v)
      end
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
  {
    "saghen/blink.compat",
    dependencies = { "micangl/cmp-vimtex" },
    version = "*",
    optional = true,
  },
}
