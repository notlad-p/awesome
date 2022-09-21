local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

---container for toggle_panel widgets
---@param widget table
---@param container_width number
---@return table
return function(widget, container_width)
	local container = wibox.widget({
		{
			{
				widget,
				top = beautiful.margin_inside,
				right = beautiful.margin_inside,
				bottom = beautiful.margin_inside,
				left = beautiful.margin_inside,
				widget = wibox.container.margin,
			},
			shape = function(cr, width, height)
				gears.shape.rounded_rect(cr, width, height, 10)
			end,
			shape_border_width = 1,
			shape_border_color = beautiful.bg_3,
			bg = beautiful.bg_0,
			fg = beautiful.fg,
			forced_width = container_width,
			widget = wibox.container.background,
		},
		layout = wibox.layout.align.vertical,
	})

	return container
end
