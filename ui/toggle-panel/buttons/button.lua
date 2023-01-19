local wibox = require "wibox"
local beautiful = require "beautiful"
local gears = require "gears"

local button = { mt = {} }

function button:turn_on()
  -- recolor icon
  self.icon = gears.color.recolor_image(self.icon, beautiful.green)
  -- set widget icon to new recolored icon
  self.icon_widget:set_image(self.icon)
end

function button:turn_off()
  -- recolor icon
  self.icon = gears.color.recolor_image(self.icon, beautiful.fg)
  -- set widget icon to new recolored icon
  self.icon_widget:set_image(self.icon)
end

function button.mt:__call(icon)
  self.icon = gears.color.recolor_image(icon, beautiful.fg)

  self.icon_widget = wibox.widget {
    forced_width = 32,
    forced_height = 32,
    resize = true,
    image = self.icon,
    widget = wibox.widget.imagebox,
  }

  local widget = wibox.widget {
    {
      {
        self.icon_widget,
        layout = wibox.layout.align.horizontal,
      },
      halign = "center",
      valign = "center",
      widget = wibox.container.place,
    },
    forced_width = 82,
    forced_height = 82,
    bg = beautiful.bg_3,
    widget = wibox.container.background,
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 7)
    end,
  }

  gears.table.crush(widget, button, true)

  return widget
end

return setmetatable(button, button.mt)
