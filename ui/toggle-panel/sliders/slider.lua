local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

-- slider widget
local slider = wibox.widget({
	bar_shape = gears.shape.rounded_rect,
	bar_height = 4,
	bar_color = beautiful.grey,
	bar_active_color = beautiful.fg,
	--
	handle_border_width = 2,
	handle_width = 16,
	handle_height = 16,
	handle_shape = gears.shape.circle,
	handle_color = beautiful.fg,
	handle_border_color = beautiful.bg_d,
	--
	maximum = 100,
	-- value = 100,
	forced_height = 17,
	widget = wibox.widget.slider,
})

-- icon widget

local icon = function(image)
	return wibox.widget({
		{
			{
				{
					forced_height = 16,
					forced_width = 16,
					resize = true,
					image = image,
					widget = wibox.widget.imagebox,
				},
				halign = "center",
				valign = "center",
				widget = wibox.container.place,
			},
			forced_height = 32,
			forced_width = 32,
			bg = beautiful.bg_3,
			shape = gears.shape.circle,
			widget = wibox.container.background,
		},
		right = 16,
		widget = wibox.container.margin,
	})
end

return {
	icon = icon,
	slider = slider,
}
