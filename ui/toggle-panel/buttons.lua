local wibox = require("wibox")
local beautiful = require("beautiful")

return function()
	local container = require("ui.toggle-panel.container")

	local button = wibox.widget({
		{
			text = "test",
			widget = wibox.widget.textbox,
		},
		forced_width = 82,
		forced_height = 82,
		bg = beautiful.bg_3,
		widget = wibox.container.background,
	})

	local buttons = wibox.widget({
		button,
		button,
		button,
		button,
		button,
		button,
		spacing = 16,
		forced_num_cols = 3,
		forced_num_rows = 2,
		homogeneous = true,
		layout = wibox.layout.grid,
	})

	return container(buttons, 310)
end
