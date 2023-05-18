local wibox = require "wibox"
local beautiful = require "beautiful"
local gears = require "gears"

local M = {}

M.setup = function()
  local music_icon = gears.color.recolor_image(beautiful.music, beautiful.bg_0)
  local backward_icon = gears.color.recolor_image(beautiful.backward, beautiful.green)
  local play_icon = gears.color.recolor_image(beautiful.play, beautiful.green)
  local forward_icon = gears.color.recolor_image(beautiful.forward, beautiful.green)

  local music = wibox.widget {
    {
      {
        {
          {
            image = music_icon,
            widget = wibox.widget.imagebox,
          },
          widget = wibox.container.margin,
          left = 5,
          right = 5,
          top = 5,
          bottom = 5,
        },
        bg = beautiful.green,
        widget = wibox.container.background,
        shape = function(cr, width, height)
          gears.shape.partially_rounded_rect(cr, width, height, true, false, false, true, 7)
        end,
      },
      {
        {
          {
            -- go back
            image = backward_icon,
            widget = wibox.widget.imagebox,
          },
          {
            -- play
            image = play_icon,
            widget = wibox.widget.imagebox,
          },
          {
            -- go forward
            image = forward_icon,
            widget = wibox.widget.imagebox,
          },
          spacing = 14,
          layout = wibox.layout.fixed.horizontal,
        },
        widget = wibox.container.margin,
        top = 7,
        bottom = 7,
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

  return music
end

return M
