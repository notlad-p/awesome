local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = gears.table.join(
		awful.button({}, 1, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

  awful.titlebar.enable_tooltip = false

	awful.titlebar(c):setup({
		{
			{ -- Left
				-- awful.titlebar.widget.iconwidget(c),
				{
					awful.titlebar.widget.floatingbutton(c),
					widget = wibox.container.margin,
					top = 5,
					bottom = 5,
				},
				layout = wibox.layout.fixed.horizontal,
			},
			{ -- Middle
				-- { -- Title
				-- 	align = "center",
				-- 	widget = awful.titlebar.widget.titlewidget(c),
				-- },
				buttons = buttons,
				layout = wibox.layout.flex.horizontal,
			},
			{ -- Right
				{
					awful.titlebar.widget.minimizebutton(c),
					widget = wibox.container.margin,
					top = 5,
					bottom = 5,
				},
				{
					awful.titlebar.widget.maximizedbutton(c),
					widget = wibox.container.margin,
					top = 5,
					bottom = 5,
				},
				{
					awful.titlebar.widget.closebutton(c),
					widget = wibox.container.margin,
					top = 5,
					bottom = 5,
				},
				layout = wibox.layout.fixed.horizontal(),
				spacing = 10,
			},
			layout = wibox.layout.align.horizontal,
		},
		widget = wibox.container.margin,
		left = 10,
		right = 10,
	})
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)
