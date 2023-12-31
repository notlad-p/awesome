local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- TODO: add battery indicator somewhere

-- import widgets used in top panel
local taglist = require("ui.top-panel.taglist")
local tasklist = require("ui.top-panel.tasklist")
local layoutbox = require("ui.top-panel.layoutbox")
local music = require("ui.top-panel.music")
local weather = require("ui.top-panel.weather")
local time = require("ui.top-panel.time")
local date = require("ui.top-panel.date")
local power = require("ui.top-panel.power")

return function(s)
	-- create widgets
	s.layoutbox = layoutbox.setup(s)
	s.taglist = taglist.setup(s)
	s.tasklist = tasklist.setup(s)
	s.music = music.setup()
	s.weather = weather.setup()
	s.time = time.setup()
	s.date = date.setup()
	s.power = power.setup(s)

	s.mywibox = awful.wibar({
		position = "top",
		type = "dock",
		screen = s,
		height = 42,
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
						spacing = 10,
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
			left = 2,
			top = 6,
		},
		-- Middle widgets
		{
			{
				{
					{
						{
							{
								layout = wibox.layout.fixed.horizontal,
								s.taglist,
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
			top = 6,
		},
		-- Right info widgets
		{
			{
				{
					{
						s.music,
						s.weather,
						s.date,
						s.time,
						s.power,
						layout = wibox.layout.fixed.horizontal,
						spacing = 10,
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
			top = 6,
			right = 2,
		},
	})
end
