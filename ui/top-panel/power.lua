local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")

local M = {}

M.setup = function(s)
	local buttons = gears.table.join(awful.button({}, 1, function()
		awesome.emit_signal("toggle_panel::toggle", s)
	end))

  local power_image = gears.color.recolor_image(beautiful.diamond, beautiful.bg_0)
	local power = wibox.widget({
		{
			{
				{
					image = power_image,
					widget = wibox.widget.imagebox,
				},
				widget = wibox.container.margin,
				left = 3,
				right = 3,
				top = 3,
				bottom = 3,
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
