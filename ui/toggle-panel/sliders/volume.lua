-- TODO: add 'start_volume' to config & use it here
local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"

local slider = require "ui.toggle-panel.sliders.slider" ()
local icon = require "ui.toggle-panel.sliders.slider-icon" (beautiful.volume)

-- slider event listener
slider:connect_signal("property::value", function()
  local value = slider:get_value()

  -- set master volume
  awful.spawn("amixer set Master " .. value .. "%", false)
end)

-- check master volume & set slider to match
local check_volume = function()
  awful.spawn.easy_async_with_shell("amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }'", function(stdout)
    if stdout == nil then
      return
    end

    local parsed_output
    if string.len(stdout) == 4 then
      parsed_output = string.sub(stdout, 1, 2)
    else
      parsed_output = string.sub(stdout, 1, 3)
    end

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
local volume = wibox.widget {
  icon,
  slider,
  layout = wibox.layout.align.horizontal,
}

return volume
