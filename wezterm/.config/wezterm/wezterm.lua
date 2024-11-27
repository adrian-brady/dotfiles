---@type Wezterm
local wezterm = require("wezterm")

---@type Config
local config = wezterm.config_builder()
local act = wezterm.action
local mux = wezterm.mux

require("nvim-zenmode")
require("nvim-cmd")

local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
local domains = wezterm.plugin.require("https://github.com/DavidRR-F/quick_domains.wezterm")
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

---@class Palette
local ret = {
	bg = "#24283b",
	bg_dark = "#1f2335",
	bg_highlight = "#292e42",
	blue = "#7aa2f7",
	blue0 = "#3d59a1",
	blue1 = "#2ac3de",
	blue2 = "#0db9d7",
	blue5 = "#89ddff",
	blue6 = "#b4f9f8",
	blue7 = "#394b70",
	comment = "#565f89",
	cyan = "#7dcfff",
	dark3 = "#545c7e",
	dark5 = "#737aa2",
	fg = "#c0caf5",
	fg_dark = "#a9b1d6",
	fg_gutter = "#3b4261",
	green = "#9ece6a",
	green1 = "#73daca",
	green2 = "#41a6b5",
	magenta = "#bb9af7",
	magenta2 = "#ff007c",
	orange = "#ff9e64",
	purple = "#9d7cd8",
	red = "#f7768e",
	red1 = "#db4b4b",
	teal = "#1abc9c",
	terminal_black = "#414868",
	yellow = "#e0af68",
	git = {
		add = "#449dab",
		change = "#6183bb",
		delete = "#914c54",
	},
}

tabline.setup({
	options = {
		icons_enabled = true,
		theme = "Tokyo Night Storm",
		color_overrides = {
			window_mode = {
				a = { bg = "#9ece6a", fg = "#1f2335" },
				b = { bg = "#24283b", fg = "#9ece6a" },
				c = { bg = "#24283b", fg = "#9ece6a" },
			},
			search_mode = {
				a = { bg = "#e0af68", fg = "#1f2335" },
				b = { bg = "#24283b", fg = "#e0af68" },
				c = { bg = "#24283b", fg = "#e0af68" },
			},
			copy_mode = {
				a = { bg = "#bb9af7", fg = "#1f2335" },
				b = { bg = "#24283b", fg = "#bb9af7" },
				c = { bg = "#24283b", fg = "#bb9af7" },
			},
			normal_mode = {
				a = { bg = "#7aa2f7", fg = "#24283b" },
				b = { bg = "#3b4261", fg = "#7aa2f7" },
				c = { bg = "#1f2335", fg = "#7aa2f7" },
			},
			tab = {
				active = { fg = "#c0caf5", bg = "#292e42" },
				inactive = { fg = "#c0caf5", bg = "#3b4261" },
				inactive_hover = { fg = "#c0caf5", bg = "#3b4261" },
			},
		},
		section_separators = {
			left = "",
			right = "",
		},
		component_separators = {
			left = "",
			right = "",
		},
		tab_separators = {
			left = "",
			right = "",
		},
	},
	sections = {
		tabline_a = { "workspace" },
		tabline_b = { "window" },
		tabline_c = { "" },
		tab_active = {
			"index",
			{ "parent", padding = 0 },
			"/",
			{ "cwd", padding = { left = 0, right = 1 } },
			{ "zoomed", padding = 0 },
		},
		tab_inactive = { "index", { padding = { left = 0, right = 1 } } },
		tabline_x = { "ram", "cpu" },
		tabline_y = { "datetime", "battery" },
		tabline_z = {},
	},
	extensions = {},
})

domains.apply_to_config(config, {
	attach = {
		key = "d",
		mods = "CMD",
		tbl = "",
	},
})
-- local repo = "https://github.com/adrian-brady/wezterm-sessionizer.wezterm"
local path = "/Users/adrianbrady/Workspace/Projects/workspace_manager.wezterm/plugin/init.lua"
-- local switcher = wezterm.plugin.require(repo)
local switcher = dofile(path)
wezterm.log_info(switcher)

local function load_files_from_dir(dir)
	local pfile = io.popen("ls " .. dir)
	if not pfile then
		return
	end
	for file in pfile:lines() do
		if file:match("%.lua$") then
			local name = file:sub(1, -5)
			local fpath = dir .. "." .. name
			wezterm.log_info(fpath)
			require(fpath)
		end
	end
	pfile:close()
end

load_files_from_dir("types")

local function renameSession()
	return act.PromptInputLine({
		description = "Enter new name for session",
		---@diagnostic disable-next-line: unused-local, missing-parameter, param-type-mismatch
		action = wezterm.action_callback(function(window, pane, line)
			if line then
				mux.rename_workspace(window:mux_window():get_workspace(), line)
			end
		end),
	})
end

local function renameTab()
	return act.PromptInputLine({
		description = "Enter new name for tab",
		---@diagnostic disable-next-line: unused-local, missing-parameter, param-type-mismatch
		action = wezterm.action_callback(function(window, pane, line)
			if line then
				window:active_tab():set_title(line)
			end
		end),
	})
end

config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = act.OpenLinkAtMouseCursor,
	},
}

config.pane_focus_follows_mouse = true

config.leader = {
	key = "b",
	mods = "CTRL",
	timeout_milliseconds = 2000,
}

config.keys = {
	{ key = "L", mods = "CTRL", action = act.ShowDebugOverlay }, -- Open Debug Overlay
	{ key = "s", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "WORKSPACES" }) }, -- Show list of workspaces
	{ key = "a", mods = "LEADER", action = act.AttachDomain("unix") }, -- Attach mux
	{ key = "d", mods = "LEADER", action = act.DetachDomain({ DomainName = "unix" }) }, -- Detach mux
	{ key = "$", mods = "LEADER", action = renameSession() }, -- Rename session
	{ key = "f", mods = "CTRL", action = workspace_switcher.switch_workspace() }, -- Sessionizer
	{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") }, -- Open Debug Overlay
	{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) }, -- Prev tab
	{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) }, -- Next tab
	{ key = ",", mods = "LEADER", action = renameTab() }, -- Next tab
	{ key = "w", mods = "LEADER", action = act.ShowTabNavigator }, -- Next tab
	{ key = "x", mods = "LEADER", action = act.CloseCurrentTab({ confirm = true }) }, -- Next tab
	{ key = ";", mods = "LEADER", action = act.ActivatePaneDirection("Prev") }, -- Prev pane
	{ key = "o", mods = "LEADER", action = act.ActivatePaneDirection("Next") }, -- Next pane
	{ key = "|", mods = "LEADER|SHIFT", action = act.SplitPane({ direction = "Right", size = { Percent = 50 } }) }, -- Next pane
	{ key = "-", mods = "LEADER", action = act.SplitPane({ direction = "Down", size = { Percent = 50 } }) }, -- Next pane
	{ key = "{", mods = "LEADER|SHIFT", action = act.PaneSelect({ mode = "SwapWithActiveKeepFocus" }) },
	{ key = "[", mods = "LEADER", action = act.ActivateCopyMode },
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
	{ key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize" }) },
	{ key = "m", mods = "LEADER", action = act.ActivateKeyTable({ name = "move_tab" }) },
}

config.key_tables = {
	resize_pane = {
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
	move_tab = {
		{ key = "h", action = act.MoveTabRelative(-1) },
		{ key = "j", action = act.MoveTabRelative(-1) },
		{ key = "k", action = act.MoveTabRelative(1) },
		{ key = "l", action = act.MoveTabRelative(1) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
}

config.unix_domains = {
	---@diagnostic disable-next-line: missing-fields
	{
		name = "unix",
	},
}

config.pane_focus_follows_mouse = true
config.scrollback_lines = 5000

config.set_environment_variables = {
	THEME = "test",
}
config.default_workspace = "~"

local theme = require("theme")
theme.apply_theme(config)

local font = require("font")
font.apply_font(config)

config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.window_decorations = "TITLE | RESIZE"
config.hide_tab_bar_if_only_one_tab = false
---@diagnostic disable-next-line: assign-type-mismatch
config.default_cursor_style = "SteadyBar"
config.tab_max_width = 32
config.tab_bar_at_bottom = true

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

return config
