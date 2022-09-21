local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")

local bluetooth_on = false

local button = require("ui.toggle-panel.buttons.button")

local widget = button({
	default_image = beautiful.bluetooth,
	toggled_image = beautiful.bluetooth_toggled,
})

local update_widget = function()
	if bluetooth_on then
		widget:turn_on()
	else
		widget:turn_off()
	end
end

local check_bluetooth_state = function()
	awful.spawn.easy_async_with_shell("rfkill list bluetooth", function(stdout)
		if stdout:match("Soft blocked: yes") then
			bluetooth_on = false
		else
			bluetooth_on = true
		end

		update_widget()
	end)
end

check_bluetooth_state()

local off_command = ""
local on_command = ""
-- local off_command = "rfkill block bluetooth"
-- local on_command = "rfkill unblock bluetooth"

local toggle_action = function()
	if bluetooth_on then
		awful.spawn.easy_async_with_shell(off_command, function(stdout)
			bluetooth_on = false
			update_widget()
		end)
	else
		awful.spawn.easy_async_with_shell(on_command, function(stdout)
			bluetooth_on = true
			update_widget()
		end)
	end
end

widget:buttons(gears.table.join(awful.button({}, 1, nil, function()
	toggle_action()
end)))

-- TODO: add watch command like this:
-- watch("rfkill list bluetooth", 5, function(_, stdout)
-- 	check_bluetooth_state()
-- 	collectgarbage("collect")
-- end)

return widget
