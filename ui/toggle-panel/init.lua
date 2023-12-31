local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"
local gears = require "gears"

return function(s)
  local profile = require "ui.toggle-panel.profile" (s)
  local buttons = require "ui.toggle-panel.buttons" (s)
  local sliders = require "ui.toggle-panel.sliders" (s)
  local music = require "ui.toggle-panel.music"
  local calendar = require "ui.toggle-panel.calendar"
  local weather = require "ui.toggle-panel.weather"

  local widget_spacing = 18

  s.toggle_panel = awful.popup {
    -- TODO: change type?
    type = "dock",
    screen = s,
    ontop = true,
    visible = false,
    -- visible = true,
    placement = function(w)
      awful.placement.top_right(w, {
        margins = { top = 46 + 16, right = 15 },
      })
    end,
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 10)
    end,
    widget = {
      {
        {
          -- info widgets
          {
            calendar,
            weather,
            spacing = widget_spacing,
            layout = wibox.layout.fixed.vertical,
          },
          -- quick settings
          {
            profile,
            buttons,
            sliders,
            music,
            layout = wibox.layout.fixed.vertical,
            spacing = widget_spacing,
          },
          spacing = widget_spacing,
          layout = wibox.layout.fixed.horizontal,
        },

        top = beautiful.margin_outside,
        right = beautiful.margin_outside,
        bottom = beautiful.margin_outside,
        left = beautiful.margin_outside,
        widget = wibox.container.margin,
      },
      bg = beautiful.bg_d,
      shape_border_width = 1,
      shape_border_color = beautiful.bg_3,
      shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 10)
      end,
      widget = wibox.container.background,
    },
  }

  -- toggle visibility
  awesome.connect_signal("toggle_panel::toggle", function(scr)
    if scr == s then
      -- if power panel is open, close it
      if s.power_panel.visible then
        s.power_panel.visible = not s.power_panel.visible
      end

      s.toggle_panel.visible = not s.toggle_panel.visible
    end
  end)
end
