local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local M = {}

M.setup = function()
	local power = wibox.widget({
		{
			{
				{
					image = beautiful.power,
					widget = wibox.widget.imagebox,
				},
				widget = wibox.container.margin,
				left = 5,
				right = 5,
				top = 5,
				bottom = 5,
			},
			bg = beautiful.red,
			widget = wibox.container.background,
			shape = function(cr, width, height)
				gears.shape.rounded_rect(cr, width, height, 7)
			end,
		},
		bg = beautiful.bg_3,
		widget = wibox.container.background,
		shape = function(cr, width, height)
			gears.shape.rounded_rect(cr, width, height, 7)
		end,
	})

	return power
end

return M
