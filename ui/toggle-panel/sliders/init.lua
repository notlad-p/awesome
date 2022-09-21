local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local container = require("ui.toggle-panel.container")

local slider = wibox.widget({
	bar_shape = gears.shape.rounded_rect,
	bar_height = 3,
	bar_color = beautiful.grey,
	bar_active_color = beautiful.fg,
	--
	handle_border_width = 1,
	handle_width = 20,
	handle_height = 20,
	handle_shape = gears.shape.circle,
	handle_color = beautiful.green,
	handle_border_color = beautiful.blue,
	--
	maximum = 100,
	value = 25,
	forced_height = 25,
	widget = wibox.widget.slider,
})

local test = wibox.widget({
	slider,
	-- expand = "none",
	layout = wibox.layout.align.vertical,
})

local test_container = container(test, 310)

return test_container
