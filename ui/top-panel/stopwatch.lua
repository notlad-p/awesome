local wibox = require "wibox"
local beautiful = require "beautiful"
local gears = require "gears"
local awful = require "awful"

local stopwatch_signal = require "signal.stopwatch"

local M = {}

M.setup = function()
  local time_elapsed = 0

  local play_icon = gears.color.recolor_image(beautiful.play, beautiful.red)
  local pause_icon = gears.color.recolor_image(beautiful.pause, beautiful.red)
  local restart_icon = gears.color.recolor_image(beautiful.refresh_clock, beautiful.red)
  local stopwatch_icon = gears.color.recolor_image(beautiful.stopwatch, beautiful.bg_0)

  local play_icon_widget = wibox.widget {
    image = play_icon,
    widget = wibox.widget.imagebox,
  }

  local timer_text = wibox.widget {
    markup = "00:00:00",
    forced_width = 66,
    widget = wibox.widget.textbox,
  }

  local play_buttons = gears.table.join(awful.button({}, 1, function()
    if stopwatch_signal.started then
      stopwatch_signal:stop()
    else
      stopwatch_signal:start()
    end
  end))

  local restart_buttons = gears.table.join(awful.button({}, 1, function()
    stopwatch_signal:emit_signal "restart_stopwatch"
  end))

  stopwatch_signal:connect_signal("restart_stopwatch", function()
    -- NOTE: restart button will continue a new timer if it's pressed while the timer is still active
    -- to remove this feature uncomment line below
    -- stopwatch_signal:stop()
    time_elapsed = 0
    timer_text:set_markup "00:00:00"
  end)

  local play_widget = wibox.widget {
    play_icon_widget,
    widget = wibox.container.margin,
    top = 7,
    bottom = 7,
    buttons = play_buttons,
  }

  local restart_widget = wibox.widget {
    {
      image = restart_icon,
      widget = wibox.widget.imagebox,
    },
    widget = wibox.container.margin,
    top = 3,
    bottom = 3,
    buttons = restart_buttons,
  }

  stopwatch_signal:connect_signal("start", function()
    play_icon_widget:set_image(pause_icon)
  end)

  stopwatch_signal:connect_signal("stop", function()
    play_icon_widget:set_image(play_icon)
  end)

  stopwatch_signal:connect_signal("timeout", function()
    time_elapsed = time_elapsed + 1

    local hours = math.floor(time_elapsed / 60 / 60)
    local minutes = math.floor(time_elapsed / 60 % 60)
    local seconds = time_elapsed % 60

    timer_text:set_markup(string.format("%02d:%02d:%02d", hours, minutes, seconds))
  end)

  local stopwatch = wibox.widget {
    {
      {
        {
          {
            image = stopwatch_icon,
            widget = wibox.widget.imagebox,
          },
          widget = wibox.container.margin,
          left = 3,
          right = 3,
          top = 3,
          bottom = 3,
        },
        bg = beautiful.red,
        widget = wibox.container.background,
        shape = function(cr, width, height)
          gears.shape.partially_rounded_rect(cr, width, height, true, false, false, true, 7)
        end,
      },

      {

        {
          {
            play_widget,
            widget = wibox.container.margin,
            right = 3,
          },

          -- time
          {
            timer_text,
            fg = beautiful.red,
            widget = wibox.container.background,
          },
          restart_widget,

          spacing = 7,
          layout = wibox.layout.fixed.horizontal,
        },
        widget = wibox.container.margin,
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

  return stopwatch
end

return M
