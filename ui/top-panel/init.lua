local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- import widgets used in top panel
local taglist = require("ui.top-panel.taglist")
local localinfo = require("ui.top-panel.localinfo")
local tasklist = require("ui.top-panel.tasklist")
local layoutbox = require("ui.top-panel.layoutbox")

return function(s)
	-- create layout box
	s.layoutbox = layoutbox.setup(s)

	-- create a taglist widget
	s.taglist = taglist.setup(s)

	-- create localinfo widget (day, date, time, weather)
	s.localinfo = localinfo.setup()

	-- create tasklist widget
	s.tasklist = tasklist.setup(s)

	s.mywibox = awful.wibar({ position = "top", screen = s })
	-- Add widgets to the wibox
	s.mywibox:setup({
		expand = "none",
		layout = wibox.layout.align.horizontal,
		-- Left widgets
		{
			{
				{
					{
						layout = wibox.layout.fixed.horizontal,
						s.taglist,
					},

					widget = wibox.container.margin,
					left = 15,
					right = 15,
					top = 5,
					bottom = 5,
				},
				widget = wibox.container.background,
				bg = beautiful.bg_0,
				shape = function(cr, width, height)
					gears.shape.rounded_rect(cr, width, height, 8)
				end,
			},
			widget = wibox.container.margin,
			left = 15,
		},
		-- middle time widget
		s.localinfo,
		-- Right widgets
		{
			{
				{
					{
						layout = wibox.layout.fixed.horizontal,
						s.tasklist,
						{
							s.layoutbox,
							widget = wibox.container.margin,
							top = 1,
							bottom = 1,
							left = 5,
						},
					},
					widget = wibox.container.margin,
					left = 15,
					right = 15,
					top = 3,
					bottom = 3,
				},
				widget = wibox.container.background,
				bg = beautiful.bg_0,
				shape = function(cr, width, height)
					gears.shape.rounded_rect(cr, width, height, 8)
				end,
			},
			widget = wibox.container.margin,
			right = 15,
		},
	})
end
