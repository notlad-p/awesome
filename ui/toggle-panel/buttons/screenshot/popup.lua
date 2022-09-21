local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")

return function(s)
	local popup_textbox = wibox.widget({
		widget = wibox.widget.textbox,
	})

	-- TODO: create popup module?
	local screenshot_popup = awful.popup({
		widget = {
			{
				{
					{
						{
							markup = "<b>Screenshot path and name:</b>",
							widget = wibox.widget.textbox,
						},
						bottom = 8,
						widget = wibox.container.margin,
					},
					{
						{
							popup_textbox,
							top = 8,
							right = 12,
							bottom = 8,
							left = 12,
							widget = wibox.container.margin,
						},
						bg = beautiful.bg_3,
						shape = function(cr, width, height)
							gears.shape.rounded_rect(cr, width, height, 7)
						end,
						widget = wibox.container.background,
					},
					{
						{
							{
								markup = "<span size='7pt'>ESC or CTRL + c to cancel</span>",
								widget = wibox.widget.textbox,
							},
							widget = wibox.container.background,
							fg = beautiful.red,
						},
						top = 8,
						widget = wibox.container.margin,
					},
					layout = wibox.layout.fixed.vertical,
				},
				top = 8,
				right = 12,
				bottom = 8,
				left = 12,
				widget = wibox.container.margin,
			},
			bg = beautiful.bg_0,
			fg = beautiful.fg,
			shape_border_width = 1,
			shape_border_color = beautiful.bg_3,
			shape = function(cr, width, height)
				gears.shape.rounded_rect(cr, width, height, 7)
			end,
			widget = wibox.container.background,
		},
		screen = s,
		placement = awful.placement.centered,
		ontop = true,
		visible = false,
	})

	screenshot_popup:connect_signal("screenshot_popup::toggle", function()
		screenshot_popup.visible = not screenshot_popup.visible
	end)

	local run_prompt = function()
		local screenshot_directory = require("configuration.apps").util.screenshot_directory

		-- run prompt with popup textbox
		awful.prompt.run({
			prompt = "",
			textbox = popup_textbox,
			text = screenshot_directory,
			exe_callback = function(input)
				-- TODO: close toggle-panel before screenshot
				-- take screenshot
				local command = "scrot -s " .. input
				awful.spawn.easy_async_with_shell(command, function()
					-- show notification that screenshot has been taken
					-- TODO: change notification style
					naughty.notify({
						title = "Screenshot taken.",
						text = input,
						timeout = 3,
					})
				end)

				-- toggle prompt popup
				screenshot_popup:emit_signal("screenshot_popup::toggle")
			end,
			hooks = {
				-- on cancel (ESC or CTRL+C) cancel prompt and popup
				{
					{},
					"Escape",
					function()
						screenshot_popup:emit_signal("screenshot_popup::toggle")
					end,
				},
				{
					{ "Control" },
					"c",
					function()
						screenshot_popup:emit_signal("screenshot_popup::toggle")
					end,
				},
			},
		})
	end

	return screenshot_popup, run_prompt
end
