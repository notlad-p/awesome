local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local weather_widget = require("ui.top-panel.weather").setup()

local M = {}

M.setup = function()
	local separator = {
		widget = wibox.widget.separator,
		orientation = "vertical",
		color = beautiful.fg,
		span_ratio = 0.7,
	}

	local date_time = wibox.widget({
		{
			{
				{

					-- day of week
					wibox.widget.textclock("%A"),
					fg = beautiful.yellow,
					widget = wibox.container.background,
				},
				-- separator,
				{
					-- date
					wibox.widget.textclock("%b %e"),
					fg = beautiful.yellow,
					widget = wibox.container.background,
				},
				-- separator,
				{
					-- time
					wibox.widget.textclock("%l:%M %P"),
					fg = beautiful.yellow,
					widget = wibox.container.background,
				},

				{
					-- weather
					weather_widget,
					fg = beautiful.blue,
					widget = wibox.container.background,
				},
				spacing_widget = separator,
				spacing = 20,
				layout = wibox.layout.fixed.horizontal,
			},
			widget = wibox.container.margin,
			left = 15,
			right = 15,
		},
		widget = wibox.container.background,
		bg = beautiful.bg_0,
		shape = function(cr, width, height)
			gears.shape.rounded_rect(cr, width, height, 8)
		end,
	})

	return date_time
end

return M
