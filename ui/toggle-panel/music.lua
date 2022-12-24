local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local xresources = require("beautiful.xresources")

local bling = require("module.bling")
local container = require("ui.toggle-panel.container")

-- TODO: fix all this shit
local cover = wibox.widget({
	image = beautiful.power_light,
	widget = wibox.widget.imagebox,
	forced_width = 50,
	forced_height = 50,
})

local text = wibox.widget({
	text = "Not playing..",
	widget = wibox.widget.textbox,
	fg = beautiful.fg,
})
-- Create a music widget
local music_widget = wibox.widget({
	{
		{
			cover,
			text,

			awful.widget.watch("playerctl metadata | awk 'END {print $3}'", 5, function(widget, stdout)
				widget:set_text(stdout)
			end),
			layout = wibox.layout.fixed.horizontal,
		},
		widget = wibox.container.margin,
		top = 11,
		bottom = 11,
	},
	layout = wibox.layout.fixed.horizontal,
})

-- Create a music player
local music_player = awful.spawn.with_shell("playerctl")

-- Create a music widget update function
local update_music_widget = function()
	-- awful.spawn.easy_async_with_shell("playerctl metadata --format '{{ title }} - {{ artist }}'", function(stdout)
	-- 	text:set_text(stdout)
	-- end)

	awful.spawn.easy_async_with_shell("playerctl metadata | awk 'END {print $3}'", function(stdout)
		local album_path = gears.string.xml_escape(stdout)

		text:set_text(album_path)
		-- cover:set_image(gears.surface.load_uncached(album_path))
	end)
end

-- Update the music widget every 5 seconds
-- awful.widget.watch("playerctl metadata | awk 'END {print $3}'", 5, function (widget, stdout)
--   widget:set_text(stdout)
-- end)

-- gears.timer({
-- 	timeout = 1,
-- 	autostart = true,
-- 	call_now = true,
-- 	callback = function()
-- 		update_music_widget()
-- 	end,
-- })

local playerctl = bling.signal.playerctl.cli({
	update_on_activity = true,
	-- player = { "spotify", "mpd", "%any" },
	debounce_delay = 1,
})

playerctl:connect_signal("metadata", function(_, title, artist, album_path, album, new, player_name)
	cover:set_image(gears.surface.load_uncached(album_path))
end)

-- return music_widget
return container(music_widget, 310)
