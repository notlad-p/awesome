local wibox = require "wibox"
local gears = require "gears"
local beautiful = require "beautiful"

return function(image, w, h)
  local recolored_image = gears.color.recolor_image(image, beautiful.fg)
  return wibox.widget {
    {
      {
        {
          forced_height = h or 16,
          forced_width = w or 16,
          resize = true,
          image = recolored_image,
          widget = wibox.widget.imagebox,
        },
        halign = "center",
        valign = "center",
        widget = wibox.container.place,
      },
      forced_height = 32,
      forced_width = 32,
      bg = beautiful.bg_3,
      shape = gears.shape.circle,
      widget = wibox.container.background,
    },
    right = 16,
    widget = wibox.container.margin,
  }
end
