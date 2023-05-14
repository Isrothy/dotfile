local M = {
	"gbprod/nord.nvim",
	priority = 100,
	enabled = true,
	lazy = false,
}
M.config = function()
	local utils = require("nord.utils")

	require("nord").setup({
		-- your configuration comes here
		-- or leave it empty to use the default settings
		transparent = false, -- Enable this to disable setting the background color
		terminal_colors = true, -- Configure the colors used khen opening a `:terminal` in Neovim
		diff = { mode = "bg" }, -- enables/disables colorful backgrounds khen used in diff mode. values : [bg|fg]
		borders = true, -- Enable the border between verticaly split windows visible
		errors = { mode = "none" }, -- Display mode for errors and diagnostics
		-- values : [bg|fg|none]
		styles = {
			-- Style to be applied to different syntax groups
			-- Value is any valid attr-list value for `:help nvim_set_hl`
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
			enable = true,
			preserve_background = false,
			severity = {
				protan = 0.7,
				deutan = 1.0,
				tritan = 0.4,
			},
		},
		on_highlights = function(highlights, colors)
			highlights.CursorLineNr = { fg = colors.frost.artic_water, bold = true }

			highlights.CmpDocumentation = { bg = colors.polar_night.brighter }

			highlights.MarkSignHL = { fg = colors.aurora.green }
			highlights.MarkSignNumHL = { fg = colors.aurora.green, bold = true }

			highlights.WhichKeyFloat = { bg = colors.polar_night.origin }

			highlights.MatchParen = { bg = colors.polar_night.origin, standout = true }

			highlights.NoiceLspProgressClient = { fg = colors.frost.ice, italic = true }
			highlights.NoiceLspProgressTitle = { fg = colors.snow_storm.origin }
			highlights.NoiceMini = { bg = colors.polar_night.bright }

			highlights.ErrorMsg = { link = "Normal" }
			highlights.WarningMsg = { link = "Normal" }

			highlights.ColorColumn = { bg = colors.polar_night.brighter }

			highlights.FloatBorder = { fg = colors.snow_storm.origin }

			highlights.Folded = { fg = colors.frost.artic_water, bg = colors.polar_night.brighter }

			highlights.TSRainbowRed = { fg = colors.aurora.red }
			highlights.TSRainbowYellow = { fg = colors.aurora.yellow }
			highlights.TSRainbowBlue = { fg = colors.frost.artic_ocean }
			highlights.TSRainbowGreen = { fg = colors.aurora.green }
			highlights.TSRainbowOrange = { fg = colors.aurora.orange }
			highlights.TSRainbowCyan = { fg = colors.frost.ice }
			highlights.TSRainbowViolet = { fg = colors.aurora.purple }
			highlights.TSRainbowWhite = { fg = colors.snow_storm.origin }

			highlights.TSDefinitionUsage = { bg = colors.polar_night.brightest }

			highlights.EyelinerPrimary = { fg = colors.aurora.orange, bold = true }
			highlights.EyelinerSecondary = { fg = colors.frost.ice, bold = true }

			highlights.DiagnosticLineNrError = { fg = colors.aurora.red, bold = true }
			highlights.DiagnosticLineNrWarn = { fg = colors.aurora.yellow, bold = true }
			highlights.DiagnosticLineNrInfo = { fg = colors.frost.ice, bold = true }
			highlights.DiagnosticLineNrHint = { fg = colors.frost.artic_water, bold = true }

			highlights.LspLens = { fg = colors.polar_night.light }

			highlights.QuickFixLine = { bg = "NONE" }
			-- highlights.QuickFixLine = { bg = colors.polar_night.brighter }

			highlights.DiffAdd = { bg = utils.darken(colors.aurora.green, 0.15) }
			highlights.DiffChange = { bg = utils.darken(colors.aurora.purple, 0.2) }
			highlights.DiffDelete = { bg = utils.darken(colors.aurora.red, 0.3) }
			highlights.DiffText = { fg = colors.frost.artic_water, bg = "NONE", reverse = true }

			highlights["@error"] = {}

			-- highlights.InclineNormal = { bg = colors.polar_night.brighter, bold = true }
			-- highlights.InclineNormalNC = { bg = colors.polar_night.brighter }
			-- highlights.Headline1 = { bg = utils.darken(colors.aurora.green, 0.2), bold = true }
			-- highlights.Headline2 = { bg = utils.darken(colors.aurora.red, 0.2), bold = true }
			-- highlights.Headline3 = { bg = utils.darken(colors.frost.ice, 0.2), bold = true }
			-- highlights.Headline4 = { bg = utils.darken(colors.aurora.yellow, 0.2), bold = true }
			-- highlights.Headline5 = { bg = utils.darken(colors.frost.artic_water, 0.2), bold = true }
			-- highlights.Headline6 = { bg = utils.darken(colors.aurora.purple, 0.2), bold = true }
			-- highlights.Dash = { fg = colors.polar_night.brightest }

			highlights.rainbowcol7 = { fg = colors.aurora.orange }

			highlights.DapStoppedLine = { bg = colors.polar_night.brightest }
			highlights.DebugPC = { bg = colors.polar_night.brightest }
		end,
	})

	vim.cmd([[colorscheme nord]])
end

return M
