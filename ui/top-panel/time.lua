local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local M = {}

M.setup = function()
	local time = wibox.widget({
		{
			{
				{
					{
						image = beautiful.clock,
						widget = wibox.widget.imagebox,
					},
					widget = wibox.container.margin,
					left = 5,
					right = 5,
					top = 5,
					bottom = 5,
				},
				bg = beautiful.yellow,
				widget = wibox.container.background,
				shape = function(cr, width, height)
					gears.shape.partially_rounded_rect(cr, width, height, true, false, false, true, 7)
				end,
			},
			{
				-- time
				{
					wibox.widget.textclock("%I:%M %P"),
					fg = beautiful.yellow,
					widget = wibox.container.background,
				},
				widget = wibox.container.margin,
				top = 5,
				bottom = 5,
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
	})

	return time
end

return M
