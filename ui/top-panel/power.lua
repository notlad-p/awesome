local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")

local M = {}

M.setup = function(s)
	local buttons = gears.table.join(awful.button({}, 1, function()
		awesome.emit_signal("toggle_panel::toggle", s)
	end))

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
		buttons = buttons,
	})

	return power
end

return M
