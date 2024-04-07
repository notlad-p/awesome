local gears = require "gears"
local config = require("configuration.config").widget.weather
local awful = require "awful"

local json = require "module.json"

local instance = nil

-- TODO:
-- - weather gears timer that fetches `current` and `forecast` apis from openweathermap every 10 mins
-- - returns whole json object from each api request
-- - Add 'N/A' as default data for widgets

-- TODO: implement new features:
-- - auto detect geo-location & get weather
local function new()
  -- return weather objects here?

  return gears.timer {
    timeout = config.update_interval,
    call_now = true,
    autostart = true,
    callback = function()
      -- TODO: get weather data here

      -- local GET_FORECAST_CMD = [[bash -c "curl -s --show-error -X GET '%s'"]]
      local GET_FORECAST_CMD = "curl -X GET '%s'"
      -- Open Weather Map API URLs
      local weather_url = "https://api.openweathermap.org/data/2.5/weather?q="
          .. config.city
          .. "&units="
          .. config.units
          .. "&appid="
          .. config.key
      local forecast_url = "https://api.openweathermap.org/data/2.5/forecast/hourly?q="
          .. config.city
          .. "&units="
          .. config.units
          .. "&appid="
          .. config.key

      local current_weather = nil
      local forecast = nil

      -- current weather api call
      awful.spawn.easy_async(string.format(GET_FORECAST_CMD, weather_url), function(stdout, stderr, reason, exit_code)
        -- decoded json from GET request
        current_weather = json.decode(stdout)
        awesome.emit_signal("current_weather::updated", current_weather)
      end)

      -- forecast api call
      awful.spawn.easy_async(string.format(GET_FORECAST_CMD, forecast_url), function(stdout, stderr, reason, exit_code)
        -- decoded json from GET request
        forecast = json.decode(stdout)
        print("forecast:")
        print(forecast)
        awesome.emit_signal("forecast_weather::updated", current_weather)
      end)


      -- NOTE: where does this return??
      -- IDEA: emit a signal and return the weather data from that signal
      -- return current_weather

    end,
  }
end

if not instance then
  instance = new()
end

return instance
