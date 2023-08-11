local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"
local gears = require "gears"

return function(s)
  local profile = require "ui.toggle-panel.profile" (s)
  local buttons = require "ui.toggle-panel.buttons" (s)
  s.sliders = require "ui.toggle-panel.sliders" (s)
  local music = require "ui.toggle-panel.music"

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
        -- quick settings
        {
          {
            profile,
            buttons,
            s.sliders,
            music,
            layout = wibox.layout.fixed.vertical,
            spacing = 12,
          },
          widget = wibox.container.margin,
          top = beautiful.margin_outside,
          right = beautiful.margin_outside,
          bottom = beautiful.margin_outside,
          left = beautiful.margin_outside,
        },
        -- info widgets
        {
          {
            {
              markup = "1s",
              widget = wibox.widget.textbox,
            },
            {
              markup = "2s",
              widget = wibox.widget.textbox,
            },
            layout = wibox.layout.fixed.vertical,
          },
          widget = wibox.container.margin,
          top = beautiful.margin_outside,
          right = beautiful.margin_outside,
          bottom = beautiful.margin_outside,
          left = 0,
        },
        layout = wibox.layout.fixed.horizontal,
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
