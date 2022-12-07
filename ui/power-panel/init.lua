local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

return function(s)
	local buttons = gears.table.join(awful.button({}, 1, function()
		-- awful.mouse.client.move(c)
		awful.spawn("systemctl poweroff")
	end))
	local power_button = wibox.widget({
		{
			{
				{
					text = "Power",
					widget = wibox.widget.textbox,
				},
				layout = wibox.layout.align.horizontal,
			},
			halign = "center",
			valign = "center",
			widget = wibox.container.place,
		},
		buttons = buttons,
		forced_width = 82,
		forced_height = 82,
		bg = beautiful.bg_3,
		widget = wibox.container.background,
		shape = function(cr, width, height)
			gears.shape.rounded_rect(cr, width, height, 7)
		end,
	})

	s.power_panel = awful.popup({
		type = "popup_menu",
		screen = s,
		ontop = true,
		visible = false,
		placement = awful.placement.centered,
		widget = {
			{
				power_button,
				layout = wibox.layout.align.horizontal,
			},
			bg = beautiful.bg_d,
			shape_border_width = 1,
			shape_border_color = beautiful.bg_3,
			shape = function(cr, width, height)
				gears.shape.rounded_rect(cr, width, height, 10)
			end,
			widget = wibox.container.background,
		},
	})

	-- toggle visibility
	awesome.connect_signal("power_panel::toggle", function(scr)
		if scr == s then
			s.power_panel.visible = not s.power_panel.visible
		end
	end)
end
