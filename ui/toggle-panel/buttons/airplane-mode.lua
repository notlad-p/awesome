local beautiful = require "beautiful"
local awful = require "awful"
local gears = require "gears"

local airplane_mode_on = false

local button = require "ui.toggle-panel.buttons.button"

local widget = button(beautiful.plane)

local update_widget = function()
  if airplane_mode_on then
    widget:turn_on()
  else
    widget:turn_off()
  end
end

local check_airplane_mode_state = function()
  awful.spawn.easy_async_with_shell("nmcli radio all | awk 'FNR == 2 {print $2}'", function(stdout)
    if stdout:match "enabled" then
      airplane_mode_on = false
    else
      airplane_mode_on = true
    end

    update_widget()
  end)
end

check_airplane_mode_state()

local off_command = ""
local on_command = ""
-- local off_command = "nmcli radio all off"
-- local on_command = "nmcli radio all on"

local toggle_action = function()
  if airplane_mode_on then
    awful.spawn.easy_async_with_shell(off_command, function(stdout)
      airplane_mode_on = false
      update_widget()
    end)
  else
    awful.spawn.easy_async_with_shell(on_command, function(stdout)
      airplane_mode_on = true
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
