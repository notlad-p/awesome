local wibox = require "wibox"
local gears = require "gears"
local beautiful = require "beautiful"
local filesystem = require "gears.filesystem"

local container = require "ui.toggle-panel.container"
local weather_config = require("configuration.config").widget.weather
local title_case = require "module.title-case"
local icon_dir = filesystem.get_configuration_dir() .. "images/icons/weather/"
local icons = require "module.weather-icons"

local location_icon = gears.color.recolor_image(beautiful.location, beautiful.fg)

local location_string = "N/A"

if weather_config then
  location_string = title_case(weather_config.city)
end

local location_text = wibox.widget {
  markup = location_string,
  widget = wibox.widget.textbox,
  font = beautiful.font_name_bold .. " 11",
}

local temp_text = wibox.widget {
  markup = "N/A°",
  widget = wibox.widget.textbox,
  font = beautiful.font_name_bold .. " 48",
}

local sky_text = wibox.widget {
  markup = "N/A",
  widget = wibox.widget.textbox,
  font = beautiful.font_name_base .. " 11",
}

local feels_like_text = wibox.widget {
  markup = "<b>Feels like:</b> N/A",
  widget = wibox.widget.textbox,
  font = beautiful.font_name_base .. " 11",
}

local wind_text = wibox.widget {
  markup = "<b>Wind:</b> N/A",
  widget = wibox.widget.textbox,
  font = beautiful.font_name_base .. " 11",
}

local humidity_text = wibox.widget {
  markup = "<b>Humidity:</b> N/A",
  widget = wibox.widget.textbox,
  font = beautiful.font_name_base .. " 11",
}

local create_forecast_widget = function()
  local time_text_widget = wibox.widget {
    markup = "N/A",
    widget = wibox.widget.textbox,
  }

  local weather_icon_widget = wibox.widget {

    image = location_icon,
    forced_height = 24,
    forced_width = 24,
    widget = wibox.widget.imagebox,
  }

  local temp_text_widget = wibox.widget {

    markup = "N/A",
    widget = wibox.widget.textbox,
  }

  local forecast_widget = wibox.widget {
    {
      time_text_widget,
      halign = "center",
      widget = wibox.container.place,
    },
    {
      weather_icon_widget,
      halign = "center",
      widget = wibox.container.place,
    },
    {
      temp_text_widget,
      halign = "center",
      widget = wibox.container.place,
    },
    spacing = 4,
    layout = wibox.layout.fixed.vertical,
  }

  return {
    main = forecast_widget,
    time_text = time_text_widget,
    weather_icon = weather_icon_widget,
    temp_text = temp_text_widget,
  }
end

local forecast_widgets = {}
for i = 1, 5, 1 do
  forecast_widgets[i] = create_forecast_widget()
end

local location_header = wibox.widget {
  {
    {
      forced_height = 28,
      forced_width = 28,
      image = location_icon,
      widget = wibox.widget.imagebox,
    },
    {
      location_text,
      left = 8,
      widget = wibox.container.margin,
    },
    layout = wibox.layout.fixed.horizontal,
  },
  -- bottom = 10,
  widget = wibox.container.margin,
}

local weather = wibox.widget {
  location_header,
  {
    {
      temp_text,
      sky_text,
      spacing = 4,
      layout = wibox.layout.fixed.vertical,
    },
    {
      {
        {
          feels_like_text,
          halign = "right",
          widget = wibox.container.place,
        },
        {
          wind_text,
          halign = "right",
          widget = wibox.container.place,
        },
        {
          humidity_text,
          halign = "right",
          widget = wibox.container.place,
        },
        spacing = 16,
        layout = wibox.layout.fixed.vertical,
      },
      top = 10,
      widget = wibox.container.margin,
    },
    layout = wibox.layout.align.horizontal,
  },
  {
    {
      {
        forecast_widgets[1].main,
        forecast_widgets[2].main,
        forecast_widgets[3].main,
        forecast_widgets[4].main,
        layout = wibox.layout.flex.horizontal,
      },
      margins = 16,
      widget = wibox.container.margin,
    },
    bg = beautiful.bg_3,
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 7)
    end,
    widget = wibox.container.background,
  },
  spacing = 20,
  layout = wibox.layout.fixed.vertical,
}

-- callback after the command output is received
local current_weather_callback = function(result)
  local temp_num = math.floor(result.main.temp)
  temp_text.markup = tostring(temp_num) .. "°"

  local sky = result.weather[1].description
  sky_text.markup = title_case(sky)

  local feels_like_num = math.floor(result.main.feels_like)
  feels_like_text.markup = "<b>Feels like:</b> " .. tostring(feels_like_num) .. "°"

  local wind = math.floor(result.wind.speed)
  wind_text.markup = "<b>Wind:</b> " .. tostring(wind) .. " mph"

  local humidity = result.main.humidity
  humidity_text.markup = "<b>Humidity:</b> " .. humidity .. "%"
end

awesome.connect_signal("current_weather::updated", current_weather_callback)

local forecast_callback = function(result)
  for i = 1, 5, 1 do
    forecast_widgets[i].time_text:set_markup_silently(os.date("%I%p", result.list[i].dt))

    local temp = math.floor(result.list[i].main.temp)
    forecast_widgets[i].temp_text:set_markup_silently(tostring(temp) .. "°")

    local icon_code = result.list[i].weather[1].icon
    local icon_image = gears.color.recolor_image(icon_dir .. icons[icon_code] .. ".svg", beautiful.fg)
    forecast_widgets[i].weather_icon.image = icon_image
  end
end

awesome.connect_signal("forecast_weather::updated", forecast_callback)

return container(weather, 334)
