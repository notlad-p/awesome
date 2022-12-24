local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local button = { mt = {} }

function button.mt:__call(args)
	self.image = args.image
	self.command = args.command

	self.icon_widget = wibox.widget({
		forced_width = 42,
		forced_height = 42,
		resize = true,
		image = args.image,
		widget = wibox.widget.imagebox,
	})

	local buttons = gears.table.join(awful.button({}, 1, function()
		if args.command == "logout" then
			awesome.quit()
		end

		awful.spawn(args.command)
	end))

	local widget = wibox.widget({
		{
			{
				self.icon_widget,
				layout = wibox.layout.align.horizontal,
			},
			halign = "center",
			valign = "center",
			widget = wibox.container.place,
		},
		buttons = buttons,
		forced_width = 124,
		forced_height = 124,
		bg = beautiful.bg_3,
		widget = wibox.container.background,
		shape = function(cr, width, height)
			gears.shape.rounded_rect(cr, width, height, 7)
		end,
	})

	gears.table.crush(widget, button, true)

	return widget
end

return setmetatable(button, button.mt)
