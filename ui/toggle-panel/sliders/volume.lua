local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local widgets = require("ui.toggle-panel.sliders.slider")
local icon = widgets.icon(beautiful.volume)
local slider = widgets.slider

-- slider event listener
slider:connect_signal("property::value", function()
	-- get value
	local value = slider:get_value()

	-- set master volume
	awful.spawn("amixer set Master " .. value .. "%", false)
end)

-- check master volume & set slider to match
local check_volume = function()
	awful.spawn.easy_async_with_shell("amixer sget Master | awk -F ' ' 'NR > 4 {print $4}'", function(stdout)
		local parsed_output = string.sub(stdout, 2, -4)

		-- text.text = parsed_output

		slider:set_value(tonumber(parsed_output))
	end)
end

check_volume()

-- button action
local function volume_button_action()
	local value = slider:get_value()
	local new_val

	-- if value is 0 set it to 100, else set it to 0
	if value <= 0 then
		new_val = 100
	else
		new_val = 0
	end

	slider:set_value(new_val)
end

icon:buttons(gears.table.join(awful.button({}, 1, nil, function()
	volume_button_action()
end)))

-- container widget
local volume = wibox.widget({
	icon,
	slider,
	layout = wibox.layout.align.horizontal,
})

return volume
