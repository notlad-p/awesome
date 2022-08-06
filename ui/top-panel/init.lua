local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- import widgets used in top panel
local taglist = require("ui.top-panel.taglist")
local localinfo = require("ui.top-panel.localinfo")
local tasklist = require("ui.top-panel.tasklist")
local layoutbox = require("ui.top-panel.layoutbox")
local weather_widget = require("ui.top-panel.weather").setup()

-- local left_widgets = wibox.widget({
-- 	{
-- 		{
-- 			-- layout box widget
-- 			{
-- 				s.layoutbox,
-- 				widget = wibox.container.background,
-- 				bg = beautiful.blue,
-- 			},
-- 			s.tasklist,
-- 			-- margin between widgets & background
-- 			widget = wibox.container.margin,
-- 			left = 12,
-- 			right = 12,
-- 			top = 5,
-- 			bottom = 5,
-- 		},
-- 		-- dark background
-- 		widget = wibox.container.background,
-- 		bg = beautiful.bg_d,
-- 		shape = function(cr, width, height)
-- 			gears.shape.rounded_rect(cr, width, height, 8)
-- 		end,
-- 		shape_border_width = 1,
-- 		shape_border_color = beautiful.bg_3,
-- 	},
-- 	-- margin to add gaps on left and top
-- 	widget = wibox.container.margin,
-- 	left = 15,
-- 	top = 10,
-- })

return function(s)
	-- create layout box
	s.layoutbox = layoutbox.setup(s)

	-- create a taglist widget
	s.taglist = taglist.setup(s)

	-- create localinfo widget (day, date, time, weather)
	s.localinfo = localinfo.setup()

	-- create tasklist widget
	s.tasklist = tasklist.setup(s)

	s.mywibox = awful.wibar({
		position = "top",
		type = "dock",
		screen = s,
		height = 46,
	})
	-- Add widgets to the wibox
	s.mywibox:setup({
		expand = "none",
		layout = wibox.layout.align.horizontal,
		-- Left widgets
		{
			{
				{
					{
						-- layout box widget
						s.layoutbox,
						-- task list widget
						s.tasklist,
						layout = wibox.layout.fixed.horizontal,
					},
					-- margin between widgets & background
					widget = wibox.container.margin,
					left = 12,
					right = 12,
					top = 5,
					bottom = 5,
				},
				-- dark background
				widget = wibox.container.background,
				bg = beautiful.bg_d,
				shape = function(cr, width, height)
					gears.shape.rounded_rect(cr, width, height, 8)
				end,
				shape_border_width = 1,
				shape_border_color = beautiful.bg_3,
			},
			-- margin to add gaps on left and top
			widget = wibox.container.margin,
			left = 15,
			top = 10,
		},
		-- Middle widgets
		{
			{
				{
					{
						{
							{
								layout = wibox.layout.fixed.horizontal,
								-- spacing = 15,
								s.taglist,
								-- {
								-- 	-- weather
								-- 	weather_widget,
								-- 	fg = beautiful.yellow,
								-- 	widget = wibox.container.background,
								-- },
							},
							widget = wibox.container.margin,
							left = 10,
							right = 10,
							top = 4,
							bottom = 4,
						},
						widget = wibox.container.background,
						bg = beautiful.bg_3,
						shape = function(cr, width, height)
							gears.shape.rounded_rect(cr, width, height, 7)
						end,
					},
					widget = wibox.container.margin,
					left = 12,
					right = 12,
					top = 5,
					bottom = 5,
				},
				widget = wibox.container.background,
				bg = beautiful.bg_d,
				shape = function(cr, width, height)
					gears.shape.rounded_rect(cr, width, height, 8)
				end,
				shape_border_width = 1,
				shape_border_color = beautiful.bg_3,
			},
			widget = wibox.container.margin,
			top = 10,
		},
		-- Right info widgets
		{
			s.localinfo,
			widget = wibox.container.margin,
			top = 10,
			right = 15,
		},
	})
end
