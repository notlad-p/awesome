local beautiful = require "beautiful"
local awful = require "awful"
local gears = require "gears"
local naughty = require "naughty"

local notifications_on = true

local button = require "ui.toggle-panel.buttons.button"

local widget = button(beautiful.notifications)

local update_widget = function()
  if notifications_on then
    widget:turn_on()
  else
    widget:turn_off()
  end
end

local check_airplane_mode_state = function()
  update_widget()
end

check_airplane_mode_state()

local toggle_action = function()
  if notifications_on then
    notifications_on = false
    naughty.suspend()

    update_widget()
  else
    notifications_on = true
    naughty.resume()

    update_widget()
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
