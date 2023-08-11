local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"

-- TODO: setup OSD for brightness value (percentage)

return function(s)
  local icon = require "ui.toggle-panel.sliders.slider-icon" (beautiful.brightness)
  local slider = require "ui.toggle-panel.sliders.slider" (100)

  local current_display = nil
  for i in pairs(s.outputs) do
    current_display = i
  end

  -- set brightness to 1 (100%) by default
  if current_display then
    awful.spawn("xrandr --output " .. current_display .. " --brightness 1")
  end

  slider:connect_signal("property::value", function()
    if not current_display then
      return
    end

    local value = slider:get_value()
    local percent = value / 100

    awful.spawn("xrandr --output " .. current_display .. " --brightness " .. percent)
  end)

  return wibox.widget {
    icon,
    slider,
    layout = wibox.layout.align.horizontal,
  }
end
