local wibox = require "wibox"
local filesystem = require "gears.filesystem"
local awful = require "awful"
local naughty = require "naughty"
local beautiful = require "beautiful"
local gears = require "gears"

local json = require "module.json"

local icon_dir = filesystem.get_configuration_dir() .. "images/icons/weather/"
local icons = require "module.weather-icons"
local config = require("configuration.config").widget.weather

local M = {}

M.setup = function()
  local icon_widget = wibox.widget {
    id = "icon",
    widget = wibox.widget.imagebox,
    image = icon_dir .. icons["02d"] .. ".svg",
  }

  local temp_widget = wibox.widget {
    markup = "N/A",
    id = "temp",
    widget = wibox.widget.textbox,
  }

  local weather_widget = wibox.widget {
    {
      {
        {
          icon_widget,
          widget = wibox.container.margin,
          left = 5,
          right = 5,
          top = 5,
          bottom = 5,
        },
        bg = beautiful.blue,
        widget = wibox.container.background,
        shape = function(cr, width, height)
          gears.shape.partially_rounded_rect(cr, width, height, true, false, false, true, 7)
        end,
      },
      {
        {
          temp_widget,
          fg = beautiful.blue,
          widget = wibox.container.background,
        },
        widget = wibox.container.margin,
        top = 5,
        bottom = 5,
        right = 10,
        left = 10,
      },
      widget = wibox.layout.align.horizontal,
    },
    bg = beautiful.bg_3,
    widget = wibox.container.background,
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 7)
    end,
  }

  local function show_warning(message)
    naughty.notify {
      preset = naughty.config.presets.critical,
      -- title = LCLE.warning_title,
      text = message,
    }
  end

  -- callback after the command output is received
  local callback = function(result)
    -- set icon
    local icon_code = result.weather[1].icon
    icon_widget.image = icon_dir .. icons[icon_code] .. ".svg"

    -- set temperature
    local temp_num = math.floor(result.main.temp)
    temp_widget.markup = tostring(temp_num) .. "°<sup>F</sup>"
  end

  awesome.connect_signal("current_weather::updated", callback)

  return weather_widget
end

return M
