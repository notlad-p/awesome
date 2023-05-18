local wibox = require "wibox"
local beautiful = require "beautiful"
local gears = require "gears"

local M = {}

M.setup = function()
  local calendar_icon = gears.color.recolor_image(beautiful.calendar, beautiful.bg_0)
  local date = wibox.widget {
    {
      {
        {
          {
            image = calendar_icon,
            widget = wibox.widget.imagebox,
          },
          widget = wibox.container.margin,
          left = 5,
          right = 5,
          top = 5,
          bottom = 5,
        },
        bg = beautiful.purple,
        widget = wibox.container.background,
        shape = function(cr, width, height)
          gears.shape.partially_rounded_rect(cr, width, height, true, false, false, true, 7)
        end,
      },
      {
        -- date
        {
          wibox.widget.textclock "%A, %b %d",
          fg = beautiful.purple,
          widget = wibox.container.background,
        },
        widget = wibox.container.margin,
        top = 5,
        bottom = 5,
        right = 10,
        left = 10,
      },
      layout = wibox.layout.fixed.horizontal,
    },
    bg = beautiful.bg_3,
    widget = wibox.container.background,
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 7)
    end,
  }

  return date
end

return M
