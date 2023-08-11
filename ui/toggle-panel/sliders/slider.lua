local wibox = require "wibox"
local gears = require "gears"
local beautiful = require "beautiful"

return function(value, min, max)
  value = value or 0
  min = min or 0
  max = max or 100

  return wibox.widget {
    bar_shape = gears.shape.rounded_rect,
    bar_height = 4,
    bar_color = beautiful.grey,
    bar_active_color = beautiful.fg,
    --
    handle_border_width = 2,
    handle_width = 16,
    handle_height = 16,
    handle_shape = gears.shape.circle,
    handle_color = beautiful.fg,
    handle_border_color = beautiful.bg_d,
    --
    value = value,
    minimum = min,
    maximum = max,
    forced_height = 17,
    -- TODO: remove this
    forced_width = 300,
    widget = wibox.widget.slider,
  }
end
