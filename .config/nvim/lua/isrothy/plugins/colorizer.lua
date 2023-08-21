return {
	"NvChad/nvim-colorizer.lua",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		filetypes = {
			"*",
			"!qf",
			"!noice",
			css = {
				names = true,
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
				tailwind = true,
			},
		},
		user_default_options = {
			RGB = false, -- #RGB hex codes
			RRGGBB = true, -- #RRGGBB hex codes
			names = false, -- "Name" codes like Blue or blue
			RRGGBBAA = true, -- #RRGGBBAA hex codes
			AARRGGBB = false, -- 0xAARRGGBB hex codes
			rgb_fn = false, -- CSS rgb() and rgba() functions
			hsl_fn = false, -- CSS hsl() and hsla() functions
			css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
			css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
			-- Available modes for `mode`: foreground, background,  virtualtext
			mode = "background", -- Set the display mode.
			-- Available methods are false / true / "normal" / "lsp" / "both"
			-- True is same as normal
			tailwind = false, -- Enable tailwind colors
			-- parsers can contain values used in |user_default_options|
			virtualtext = "■",
		},
		-- all the sub-options of filetypes apply to buftypes
		buftypes = {
			"*",
			"!prompt",
			"!popup",
		},
	},
}

