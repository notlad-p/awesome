-- TODO: setup this widget to be connected to a signal & manipulated
-- separate parts out into their own modules? (weather/ directory?)

-- TODO: create weather signal like playerctl
-- then update both weather widgets every 5-20 minutes

-- TODO: move weather icons to `theme.lua` file
-- so that both weather widgets can use the same icons
local wibox = require "wibox"
local gears = require "gears"
local beautiful = require "beautiful"

local container = require "ui.toggle-panel.container"

local location_icon = gears.color.recolor_image(beautiful.location, beautiful.fg)
local location_text = wibox.widget {
  markup = "Apex",
  widget = wibox.widget.textbox,
  font = beautiful.font_name_bold .. " 11",
}

local temp_text = wibox.widget {
  markup = "75°",
  widget = wibox.widget.textbox,
  font = beautiful.font_name_bold .. " 48",
}

local sky_text = wibox.widget {
  markup = "Clear Sky",
  widget = wibox.widget.textbox,
  font = beautiful.font_name_base .. " 11",
}

local feels_like_text = wibox.widget {
  markup = "<b>Feels like:</b> 69°",
  widget = wibox.widget.textbox,
  font = beautiful.font_name_base .. " 11",
}

local wind_text = wibox.widget {
  markup = "<b>Wind:</b> 5 mph",
  widget = wibox.widget.textbox,
  font = beautiful.font_name_base .. " 11",
}

local humidity_text = wibox.widget {
  markup = "<b>Humidity:</b> 69%",
  widget = wibox.widget.textbox,
  font = beautiful.font_name_base .. " 11",
}

local time_weather_widget = wibox.widget {
  {
    {
      markup = "6am",
      widget = wibox.widget.textbox,
    },
    halign = "center",
    widget = wibox.container.place,
  },
  {
    {
      image = location_icon,
      forced_height = 24,
      forced_width = 24,
      widget = wibox.widget.imagebox,
    },
    halign = "center",
    widget = wibox.container.place,
  },
  {
    {
      markup = "75°",
      widget = wibox.widget.textbox,
    },
    halign = "center",
    widget = wibox.container.place,
  },
  spacing = 4,
  layout = wibox.layout.fixed.vertical,
}

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
        time_weather_widget,
        time_weather_widget,
        time_weather_widget,
        time_weather_widget,
        -- layout = wibox.layout.align.horizontal,
        -- layout = wibox.layout.fixed.horizontal,
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

return container(weather, 334)
