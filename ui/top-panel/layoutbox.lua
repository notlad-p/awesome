local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")
local wibox = require("wibox")

local M = {}

M.setup = function(s)
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	local layoutbox = awful.widget.layoutbox(s)

	local layoutbox_container = wibox.widget({
		{
			layoutbox,
			widget = wibox.container.margin,
			top = 5,
			bottom = 5,
			left = 5,
			right = 5,
		},
		widget = wibox.container.background,
		bg = beautiful.blue,
		shape = function(cr, width, height)
			gears.shape.rounded_rect(cr, width, height, 7)
		end,
	})

	layoutbox_container:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))

	return layoutbox_container
end

return M
