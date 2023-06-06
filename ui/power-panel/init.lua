-- TODO: fix panel showing up on another screen when awesomewm is first initialized
local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"
local gears = require "gears"

return function(s)
  local button = require "ui.power-panel.button"

  local lock_icon = gears.color.recolor_image(beautiful.lock, beautiful.fg)
  local sleep_icon = gears.color.recolor_image(beautiful.sleep, beautiful.fg)
  local logout_icon = gears.color.recolor_image(beautiful.logout, beautiful.fg)
  local restart_icon = gears.color.recolor_image(beautiful.restart, beautiful.fg)
  local power_icon = gears.color.recolor_image(beautiful.power, beautiful.fg)

  local lock = button { image = lock_icon, command = "" }
  local sleep = button { image = sleep_icon, command = "systemctl suspend" }
  local logout = button { image = logout_icon, command = "logout" }
  local restart = button { image = restart_icon, command = "systemctl reboot" }
  local power = button { image = power_icon, command = "systemctl poweroff" }

  s.power_panel = awful.popup {
    type = "popup_menu",
    screen = s,
    ontop = true,
    visible = false,
    placement = awful.placement.centered,
    widget = {
      {
        {
          {
            lock,
            sleep,
            logout,
            restart,
            power,
            spacing = 16,
            layout = wibox.layout.fixed.horizontal,
          },
          top = beautiful.margin_inside,
          right = beautiful.margin_inside,
          bottom = beautiful.margin_inside,
          left = beautiful.margin_inside,
          widget = wibox.container.margin,
        },
        shape = function(cr, width, height)
          gears.shape.rounded_rect(cr, width, height, 10)
        end,
        shape_border_width = 1,
        shape_border_color = beautiful.bg_3,
        bg = beautiful.bg_0,
        fg = beautiful.fg,
        -- forced_width = 500,
        widget = wibox.container.background,
      },
      layout = wibox.layout.align.vertical,
    },
  }

  -- toggle visibility
  awesome.connect_signal("power_panel::toggle", function(scr)
    if scr == s then
      s.power_panel.visible = not s.power_panel.visible
    end
  end)
end
