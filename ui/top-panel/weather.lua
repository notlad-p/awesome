local wibox = require("wibox")
local filesystem = require("gears.filesystem")
local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")
local gears = require("gears")

local json = require("module.json")

-- API key: e56460e598b2a4cec56992ee67c171f6
-- API key (old): 42ebabdd4868e27ab24302546199950b
-- https://api.openweathermap.org/data/2.5/weather?q=apex&appid=e56460e598b2a4cec56992ee67c171f6&units=imperial
local icon_dir = filesystem.get_configuration_dir() .. "theme/icons/weather/"
local config = require("configuration.config").widget.weather

local M = {}

M.setup = function()
	-- Possible icon values returned from OWM
	local icons = {
		["01d"] = "clear-sky",
		["02d"] = "few-clouds",
		["03d"] = "scattered-clouds",
		["04d"] = "scattered-clouds", -- indicator is for 'broken-clouds' but I reused scattered-clouds because it's the same
		["09d"] = "shower-rain",
		["10d"] = "rain",
		["11d"] = "thunderstorm",
		["13d"] = "snow",
		["50d"] = "mist",
		["01n"] = "clear-sky-night",
		["02n"] = "few-clouds-night",
		["03n"] = "scattered-clouds",
		["04n"] = "scattered-clouds",
		["09n"] = "shower-rain",
		["10n"] = "rain-night",
		["11n"] = "thunderstorm",
		["13n"] = "snow",
		["50n"] = "mist",
	}

	local icon_widget = wibox.widget({
		id = "icon",
		widget = wibox.widget.imagebox,
	})

	local temp_widget = wibox.widget({
		id = "temp",
		widget = wibox.widget.textbox,
	})

	local weather_widget = wibox.widget({
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
				bg = beautiful.bg_blue,
				widget = wibox.container.background,
				shape = function(cr, width, height)
					gears.shape.partially_rounded_rect(cr, width, height, true, false, false, true, 7)
				end,
			},
			{
				{
					temp_widget,
					fg = beautiful.bg_blue,
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
	})

	local function show_warning(message)
		naughty.notify({
			preset = naughty.config.presets.critical,
			-- title = LCLE.warning_title,
			text = message,
		})
	end

	-- local GET_FORECAST_CMD = [[bash -c "curl -s --show-error -X GET '%s'"]]
	local GET_FORECAST_CMD = "curl -X GET '%s'"
	-- Open Weather Map API URL
	local url = "https://api.openweathermap.org/data/2.5/weather?q="
		.. config.city
		.. "&units="
		.. config.units
		.. "&appid="
		.. config.key

	-- callback after the command output is received
	local callback = function(widget, stdout, stderr)
		-- show_warning(stderr)
		-- show_warning(stdout)

		-- decoded json from GET request
		local result = json.decode(stdout)

		-- set icon
		local icon_code = result.weather[1].icon
		icon_widget.image = icon_dir .. icons[icon_code] .. ".svg"

		-- set temperature
		local temp_num = math.floor(result.main.temp)
		temp_widget.markup = tostring(temp_num) .. "°<sup>F</sup>"
	end

	-- awful.widget.watch(string.format(GET_FORECAST_CMD, url), config.update_interval, callback)

	return weather_widget
end

return M
