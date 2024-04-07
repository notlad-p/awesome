-- NOTE: this signal is called in rc.lua, starting the timer for api calls
local gears = require "gears"
local config = require("configuration.config").widget.weather
local awful = require "awful"

local json = require "module.json"

local instance = nil

-- TODO: implement new features:
-- - auto detect geo-location & get weather
local function new()
  -- return weather objects here?

  return gears.timer {
    timeout = config.update_interval,
    call_now = true,
    autostart = true,
    callback = function()
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

      -- current weather api call
      awful.spawn.easy_async(string.format(GET_FORECAST_CMD, weather_url), function(stdout)
        -- decoded json from GET request
        local current_weather = json.decode(stdout)
        awesome.emit_signal("current_weather::updated", current_weather)
      end)

      -- forecast api call
      awful.spawn.easy_async(string.format(GET_FORECAST_CMD, forecast_url), function(stdout)
        -- decoded json from GET request
        local forecast = json.decode(stdout)
        awesome.emit_signal("forecast_weather::updated", forecast)
      end)
    end,
  }
end

if not instance then
  instance = new()
end

return instance
