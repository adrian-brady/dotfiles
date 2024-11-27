local module = {}

local function readFile(filename)
	local file = io.open(filename, "r")
	if not file then
		return nil, "could not open file: " .. filename
	end

	local content = file:read("*all")
	content = content:match("^%s*(.-)%s*$")
	file:close()

	return content
end

local function getTheme()
	local theme_val, err = readFile("/Users/adrianbrady/.config/theme.txt")
	local theme = nil
	print(theme_val)

	if theme_val == "tokyonight_storm" then
		theme = "Tokyo Night Storm"
	end

	return theme
end

function module.apply_theme(config)
	local theme = getTheme()
	config.color_scheme = theme
end

return module
