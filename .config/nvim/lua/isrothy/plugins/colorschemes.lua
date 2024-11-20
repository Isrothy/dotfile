return {
    {
        "gbprod/nord.nvim",
        priority = 100,
        lazy = false,
        enabled = true,

        config = function()
            require("nord").setup({
                transparent = false,
                terminal_colors = true,
                diff = { mode = "bg" },
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
                on_highlights = function(highlights, colors)
                    highlights.CmpDocumentation = { bg = colors.polar_night.brighter }

                    highlights.CursorLineNr = { bold = true }
                    highlights.MarkSignHL = { fg = colors.aurora.green }

                    highlights.NeominimapMarkIcon = { fg = colors.aurora.green }

                    highlights.SatelliteMark = { fg = colors.aurora.green }

                    highlights.WinBar = { bg = colors.polar_night.brighter }
                    highlights.WinBarNC = { bg = colors.polar_night.brighter }

                    highlights.SnacksDashboardIcon = { fg = colors.frost.ice }

                    -- highlights.NormalFloat = { fg = colors.snow_storm.origin, bg = colors.polar_night.bright }
                    -- highlights.FloatBorder = { fg = colors.snow_storm.origin }
                    -- highlights.WhichKeyFloat = { bg = colors.polar_night.origin }

                    highlights.MatchParen = { bg = colors.polar_night.origin, reverse = true }

                    highlights.NoiceLspProgressClient = { fg = colors.frost.ice, italic = true }
                    highlights.NoiceLspProgressTitle = { fg = colors.snow_storm.origin }
                    highlights.NoiceMini = { bg = colors.polar_night.bright }

                    highlights.ErrorMsg = { link = "Normal" }
                    highlights.WarningMsg = { link = "Normal" }

                    highlights.TermCursor = { fg = colors.aurora.green, bg = colors.none, reverse = true }

                    -- highlights.ColorColumn = { bg = colors.polar_night.brighter }

                    -- highlights.FloatBorder = { fg = colors.snow_storm.origin }

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

                    -- highlights.StartLogo1 = { fg = "#5E81AC" }
                    -- highlights.StartLogo2 = { fg = "#6688A8" }
                    -- highlights.StartLogo3 = { fg = "#6D8FA5" }
                    -- highlights.StartLogo4 = { fg = "#7595A1" }
                    -- highlights.StartLogo5 = { fg = "#7D9C9E" }
                    -- highlights.StartLogo6 = { fg = "#84A39A" }
                    -- highlights.StartLogo7 = { fg = "#8CAA97" }
                    -- highlights.StartLogo8 = { fg = "#94B093" }

                    -- highlights.InclineNormal = { bg = colors.polar_night.brighter, bold = true }
                    -- highlights.InclineNormalNC = { bg = colors.polar_night.brighter }
                    -- highlights.Headline1 = { bg = utils.darken(colors.aurora.green, 0.2), bold = true }
                    -- highlights.Headline2 = { bg = utils.darken(colors.aurora.red, 0.2), bold = true }
                    -- highlights.Headline3 = { bg = utils.darken(colors.frost.ice, 0.2), bold = true }
                    -- highlights.Headline4 = { bg = utils.darken(colors.aurora.yellow, 0.2), bold = true }
                    -- highlights.Headline5 = { bg = utils.darken(colors.frost.artic_water, 0.2), bold = true }
                    -- highlights.Headline6 = { bg = utils.darken(colors.aurora.purple, 0.2), bold = true }
                    -- highlights.Dash = { fg = colors.polar_night.brightest }

                    highlights.DapStoppedLine = { bg = colors.polar_night.brightest }
                    highlights.DebugPC = { bg = colors.polar_night.brightest }

                    highlights.HighlightUndo = { bg = colors.polar_night.brightest }

                    highlights.VirtColumn = { fg = colors.polar_night.brightest }

                    -- highlights.ScrollViewSearch = { fg = colors.frost.artic_water }

                    -- highlights.FlashLabel = { fg = colors.aurora.orange, bg = colors.polar_night.brightest, bold = true }
                end,
            })
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
