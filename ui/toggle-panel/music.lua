local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local xresources = require("beautiful.xresources")
local naughty = require("naughty")

local bling = require("module.bling")
local container = require("ui.toggle-panel.container")
local playerctl = require("signal.playerctl")

-- local playerctl = bling.signal.playerctl.lib({
-- 	update_on_activity = true,
-- 	debounce_delay = 1,
-- })

-- TODO: remove container margin so cover image alignes with border
-- TODO: add buttons
-- TODO: space out info & buttons correctly

-- album cover image
local cover_image = wibox.widget({
	widget = wibox.widget.imagebox,
	forced_width = 190,
	forced_height = 190,
	valign = "center",
	halign = "center",
	-- resize = true,
	horizontal_fit_policy = "fit",
	vertical_fit_policy = "fit",
})

local bg_gradient = {
	type = "linear",
	from = { 0, 0 },
	to = { 190, 0 },
	stops = { { 0.05, beautiful.bg_0 }, { 0.25, beautiful.bg_0 .. "ee" }, { 0.95, beautiful.bg_0 .. "00" } },
}

local cover_gradient = wibox.widget({
	widget = wibox.container.background,
	bg = bg_gradient,
})

local cover_widget = wibox.widget({
	cover_image,
	cover_gradient,
	layout = wibox.layout.stack,
})

-- song title
local title_widget = wibox.widget({
	markup = "<b>Nothing Playing</b>",
	wrap = "word",
	fg = beautiful.fg,
	widget = wibox.widget.textbox,
})

-- song artist
local artist_widget = wibox.widget({
	markup = "N/A",
	fg = beautiful.fg,
	widget = wibox.widget.textbox,
})

local position_widget = wibox.widget({
	markup = "0:00 / 0:00",
	fg = beautiful.fg,
	widget = wibox.widget.textbox,
})

local backward_buttons = gears.table.join(awful.button({}, 1, function()
	playerctl:previous()
end))

local backward_widget = wibox.widget({
	{
		image = beautiful.backward_fg,
		forced_width = 24,
		forced_height = 24,
		widget = wibox.widget.imagebox,
	},
	valign = "center",
	widget = wibox.container.place,
	buttons = backward_buttons,
})

local play_buttons = gears.table.join(awful.button({}, 1, function()
	playerctl:play_pause()
end))

local play_icon = wibox.widget({
	image = beautiful.play_fg,
	widget = wibox.widget.imagebox,
	forced_height = 22,
	forced_width = 17,
})

local play_widget = wibox.widget({
	{
		play_icon,
		widget = wibox.container.place,
	},
	widget = wibox.container.background,
	bg = beautiful.bg_3,
	shape = gears.shape.circle,
	forced_height = 42,
	forced_width = 42,
	buttons = play_buttons,
})

local forward_buttons = gears.table.join(awful.button({}, 1, function()
	playerctl:next()
end))

local forward_widget = wibox.widget({
	{
		image = beautiful.forward_fg,
		forced_width = 24,
		forced_height = 24,
		widget = wibox.widget.imagebox,
	},
	valign = "center",
	widget = wibox.container.place,
	buttons = forward_buttons,
})

local buttons_widget = wibox.widget({
	backward_widget,
	play_widget,
	forward_widget,
	spacing = 18,
	layout = wibox.layout.fixed.horizontal,
})

-- Create a music widget
local music_widget = wibox.widget({
	{
		{
			cover_widget,
			valign = "top",
			halign = "right",
			widget = wibox.container.place,
		},
		widget = wibox.container.background,
	},
	{
		{
			{
				{
					{
						{

							title_widget,
							max_size = 100,
							step_fuction = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
							speed = 25,
							fps = 30,
							extra_space = 10,
							layout = wibox.container.scroll.horizontal,
						},
						top = -10,
						bottom = 14,
						widget = wibox.container.margin,
					},
					{
						{
							artist_widget,
							max_size = 100,
							step_fuction = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
							speed = 25,
							fps = 30,
							extra_space = 10,
							layout = wibox.container.scroll.horizontal,
						},
						bottom = 22,
						widget = wibox.container.margin,
					},
					{
						position_widget,
						bottom = 24,
						widget = wibox.container.margin,
					},
					buttons_widget,
					layout = wibox.layout.fixed.vertical,
				},
				top = 16,
				left = 16,
				right = 80,
				widget = wibox.container.margin,
			},
			widget = wibox.container.margin,
			top = 11,
			bottom = 11,
		},
		widget = wibox.container.background,
		-- bg = bg_gradient,
	},
	layout = wibox.layout.stack,
	fill_space = true,
})

playerctl:connect_signal("metadata", function(_, title, artist, album_path, album, new, player_name)
	-- if new == true then
	-- 	naughty.notify({ title = title, text = artist, image = album_path })
	-- end
	cover_image:set_image(gears.surface.load_uncached(album_path))
	title_widget:set_markup_silently("<b>" .. title .. "</b>")
	artist_widget:set_markup_silently(artist)
end)

-- update position in song (minutes & seconds)
playerctl:connect_signal("position", function(_, interval_sec, length_sec)
	local current_min = math.floor(interval_sec / 60)
	local current_sec = math.floor(interval_sec % 60)
	local current = current_min .. ":" .. current_sec

	local total_min = math.floor(length_sec / 60)
	local total_sec = math.floor(length_sec % 60)
	local total = total_min .. ":" .. total_sec

	-- add 0 to seconds if less than 10
	-- otherwise it would look something like 2:8 and not 2:08
	if current_sec < 10 then
		current = current_min .. ":0" .. current_sec
	end

	if total_sec < 10 then
		total = total_min .. ":0" .. total_sec
	end

	position_widget:set_markup_silently(current .. " / " .. total)
end)

-- update play / pause button icon (pause icon when playing & play icon when paused)
playerctl:connect_signal("playback_status", function(_, playing)
	if playing then
		play_icon:set_image(beautiful.pause_fg)
	else
		play_icon:set_image(beautiful.play_fg)
	end
end)

-- return music_widget
return container(music_widget, 310, true)
