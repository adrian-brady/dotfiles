local wezterm = require("wezterm")

local function is_vim(pane)
	local is_vim_env = pane:get_user_vars().IS_NVIM == "true"
	if is_vim_env == true then
		return true
	end
	-- This gsub is equivalent to POSIX basename(3)
	-- Given "/foo/bar" returns "bar"
	-- Given "c:\\foo\\bar" returns "bar"
	local process_name = string.gsub(pane:get_foreground_process_name(), "(.*[/\\])(.*)", "%2")
	return process_name == "nvim" or process_name == "vim"
end

--- cmd+keys that we want to send to neovim.
local super_vim_keys_map = {
	s = utf8.char(0xAA),
	x = utf8.char(0xAB),
	b = utf8.char(0xAC),
	["."] = utf8.char(0xAD),
	o = utf8.char(0xAF),
}

local function bind_super_key_to_vim(key)
	return {
		key = key,
		mods = "CMD",
		action = wezterm.action_callback(function(win, pane)
			local char = super_vim_keys_map[key]
			if char and is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = char, mods = nil },
				}, pane)
			else
				win:perform_action({
					SendKey = {
						key = key,
						mods = "CMD",
					},
				}, pane)
			end
		end),
	}
end

--- in your wezterm keys config, use it like:
keys = {
	bind_super_key_to_vim("s"),
}
