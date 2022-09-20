local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local button = { mt = {} }

function button:turn_on()
	self.icon_widget:set_image(self.toggled_image)
end

function button:turn_off()
	self.icon_widget:set_image(self.default_image)
end

function button.mt:__call(args)
	self.default_image = args.default_image
	self.toggled_image = args.toggled_image

	self.icon_widget = wibox.widget({
		forced_width = 32,
		forced_height = 32,
		resize = true,
		image = self.default_image,
		widget = wibox.widget.imagebox,
	})

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
		forced_width = 82,
		forced_height = 82,
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
