local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local M = {}

M.setup = function()
	local music = wibox.widget({
		{
			{
				{
					{
						image = beautiful.music,
						widget = wibox.widget.imagebox,
					},
					widget = wibox.container.margin,
					left = 5,
					right = 5,
					top = 5,
					bottom = 5,
				},
				bg = beautiful.green,
				widget = wibox.container.background,
				shape = function(cr, width, height)
					gears.shape.partially_rounded_rect(cr, width, height, true, false, false, true, 7)
				end,
			},
			{
				{
					{
						-- go back
						image = beautiful.backward,
						widget = wibox.widget.imagebox,
					},
					{
						-- play
						image = beautiful.play,
						widget = wibox.widget.imagebox,
					},
					{
						-- go forward
						image = beautiful.forward,
						widget = wibox.widget.imagebox,
					},
					spacing = 14,
					layout = wibox.layout.fixed.horizontal,
				},
				widget = wibox.container.margin,
				top = 7,
				bottom = 7,
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

	return music
end

return M
