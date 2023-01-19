local beautiful = require "beautiful"
local awful = require "awful"
local gears = require "gears"

local wifi_on = false

local button = require "ui.toggle-panel.buttons.button"

local widget = button(beautiful.wifi)

local update_widget = function()
  if wifi_on then
    widget:turn_on()
  else
    widget:turn_off()
  end
end

local check_wifi_state = function()
  awful.spawn.easy_async_with_shell("nmcli r wifi", function(stdout)
    if stdout:match "enabled" then
      wifi_on = true
    else
      wifi_on = false
    end

    update_widget()
  end)
end

check_wifi_state()

local off_command = ""
local on_command = ""
-- local off_command = "nmcli r wifi off"
-- local on_command = "nmcli r wifi on"

local toggle_action = function()
  if wifi_on then
    awful.spawn.easy_async_with_shell(off_command, function(stdout)
      wifi_on = false
      update_widget()
    end)
  else
    awful.spawn.easy_async_with_shell(on_command, function(stdout)
      wifi_on = true
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
