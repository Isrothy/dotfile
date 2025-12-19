local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Nord (Gogh)"

config.front_end = "WebGpu"

config.default_cursor_style = "SteadyBlock"
config.cursor_thickness = "3px"
config.force_reverse_video_cursor = false

config.font = wezterm.font({
	family = "JetBrains Mono",
	weight = "DemiBold",
	harfbuzz_features = {
		"cv06=1",
		"cv07=1",
		"cv08=1",
		"calt=0",
		"clig=0",
		"liga=0",
	},
})
config.font_size = 16.0
config.underline_thickness = "400%"
config.cell_width = 1.0
config.enable_tab_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.window_background_opacity = 1.0
config.enable_kitty_graphics = true

config.scrollback_lines = 0

config.send_composed_key_when_left_alt_is_pressed = true
config.use_dead_keys = false

local act = wezterm.action

config.default_prog = { "/opt/homebrew/bin/tmux", "new", "-A", "-s", "main" }

config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

config.keys = {
	{
		key = "-",
		mods = "CTRL",
		action = act.DisableDefaultAssignment,
	},
	{
		key = "=",
		mods = "CTRL",
		action = act.DisableDefaultAssignment,
	},
}

return config
