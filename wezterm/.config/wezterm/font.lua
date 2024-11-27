---@type Wezterm
local wezterm = require("wezterm")

local module = {}

local font = "JetBrains Mono Medium"
local size = 14.0

--- @param config Config
function module.apply_font(config)
	config.font = wezterm.font_with_fallback({
		font,
		"Flog Symbols",
	})
	config.font_size = size
end

return module
