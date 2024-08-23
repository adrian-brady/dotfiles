-- Pull in the wezterm API

local wezterm = require("wezterm")
require("nvim-zenmode")

-- This will hold the configuration.

local config = wezterm.config_builder()
-- config.font = wezterm.font("Input Mono Narrow")
config.font = wezterm.font("IBM Plex Mono")
-- config.font = wezterm.font("Hack Nerd Font Mono")
config.font_size = 14.0

config.enable_tab_bar = false
config.use_fancy_tab_bar = false

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- This is where you actually apply your config choices

-- For example, changing the color scheme:

-- config.color_scheme = "Tokyo Night Storm"
-- config.color_scheme = "Gruvbox dark, pale (base16)"
config.color_scheme = "Gruvbox Material (Gogh)"
-- config.color_scheme = "Gruvbox dark, medium (base16)"
-- config.color_scheme = "Kanagawa (Gogh)"
-- config.color_scheme = "rose-pine-moon"
-- config.color_scheme = "Catppuccin Mocha"

-- and finally, return the configuration to wezterm

return config
