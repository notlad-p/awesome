local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local widgets = require("ui.toggle-panel.sliders.slider")
local icon = widgets.icon(beautiful.brightness)
local slider = widgets.slider

local displays = {}
local get_displays = function()
	awful.spawn.easy_async_with_shell("xrandr -q | grep ' connected' | awk '{print $1}'", function(stdout)
		-- split output and insert into displays table
		for i in string.gmatch(stdout, "%S+") do
			table.insert(displays, i)

			-- set brightness to 1 by default
			awful.spawn("xrandr --output " .. i .. " --brightness 1")
		end
	end)
end

get_displays()

slider:connect_signal("property::value", function()
	-- get value
	local value = slider:get_value()

	-- TODO: check if this for loop works, should change brightness of all screens
	-- set brightness
	local percent = value / 100
	for i, v in ipairs(displays) do
		-- revDays[v] = i
		awful.spawn("xrandr --output " .. v .. " --brightness " .. percent)
	end
end)

-- container widget
local brightness = wibox.widget({
	icon,
	slider,
	layout = wibox.layout.align.horizontal,
})

return brightness
