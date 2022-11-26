local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

return function(s)
	local profile = require("ui.toggle-panel.profile")()
	local buttons = require("ui.toggle-panel.buttons")(s)
	local sliders = require("ui.toggle-panel.sliders")

	local settings = wibox.widget({
		{
			profile,
			buttons,
			sliders,
			-- test_container,
			expand = false,
			layout = wibox.layout.align.vertical,
		},
		widget = wibox.container.margin,
		top = beautiful.margin_outside,
		right = beautiful.margin_outside,
		bottom = beautiful.margin_outside,
		left = beautiful.margin_outside,
	})

	local info = wibox.widget({
		{
			{
				markup = "1s",
				widget = wibox.widget.textbox,
			},
			{
				markup = "2s",
				widget = wibox.widget.textbox,
			},
			layout = wibox.layout.fixed.vertical,
		},
		widget = wibox.container.margin,
		top = beautiful.margin_outside,
		right = beautiful.margin_outside,
		bottom = beautiful.margin_outside,
		left = 0,
	})

	s.toggle_panel = awful.popup({
		type = "dock",
		screen = s,
		ontop = true,
		-- visible = false,
		visible = true,
		-- maximum_width = dpi(30),
		-- maximum_height = dpi(30),
		placement = function(w)
			awful.placement.top_right(w, {
				margins = { top = 46 + 16, right = 15 },
			})
		end,
		widget = {
			{
				settings,
				info,
				layout = wibox.layout.fixed.horizontal,
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
	awesome.connect_signal("toggle_panel::toggle", function(scr)
		if scr == s then
			s.toggle_panel.visible = not s.toggle_panel.visible
		end
	end)
end
