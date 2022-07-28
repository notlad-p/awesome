local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
-- local menubar = require("menubar")

-- import widgets used in ui from ./widgets directory

-- import taglist & task list
local taglist = require("ui.taglist")
local localinfo = require("ui.localinfo")
local tasklist = require("ui.tasklist")

-- wibar, title bar (window bar), & other main widgets setup
local M = {}

M.setup = function()
	-- mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })

	-- Menubar configuration
	-- menubar.utils.terminal = terminal -- Set the terminal for applications that require it
	-- }}}

	-- Keyboard map indicator and switcher
	-- mykeyboardlayout = awful.widget.keyboardlayout()

	-- {{{ Wibar
	-- Create a textclock widget
	-- mytextclock = wibox.widget.textclock("%A %b %e, %l:%M %P")

	-- {{{ Wibar
	-- Create a wibox for each screen and add it

	local function set_wallpaper(s)
		-- Wallpaper
		if beautiful.wallpaper then
			local wallpaper = beautiful.wallpaper
			-- If wallpaper is a function, call it with the screen
			if type(wallpaper) == "function" then
				wallpaper = wallpaper(s)
			end
			gears.wallpaper.maximized(wallpaper, s, true)
		end
	end

	-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
	screen.connect_signal("property::geometry", set_wallpaper)

	awful.screen.connect_for_each_screen(function(s)
		-- Wallpaper
		set_wallpaper(s)

		-- Create a promptbox for each screen
		-- s.mypromptbox = awful.widget.prompt()
		-- Create an imagebox widget which will contain an icon indicating which layout we're using.
		-- We need one layoutbox per screen.
		s.mylayoutbox = awful.widget.layoutbox(s)
		s.mylayoutbox:buttons(gears.table.join(
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
		-- create a taglist widget
		s.mytaglist = taglist.setup(s)

		-- create localinfo widget (day, date, time, weather)
		s.localinfo = localinfo.setup()

		-- create tasklist widget
		s.tasklist = tasklist.setup(s)

		-- Create the wibox
		s.mywibox = awful.wibar({ position = "top", screen = s })

		-- Add widgets to the wibox
		s.mywibox:setup({
			expand = "none",
			layout = wibox.layout.align.horizontal,
			{ -- Left widgets
				{
					{
						{
							layout = wibox.layout.fixed.horizontal,
							s.mytaglist,
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
							-- wibox.widget.systray(),
							s.tasklist,
							s.mylayoutbox,
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
	end)
	-- }}}
end

return M
