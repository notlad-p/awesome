local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local filesystem = require("gears.filesystem")

local M = {}

M.setup = function(s)
	local tasklist_buttons = gears.table.join(
		awful.button({}, 1, function(c)
			if c == client.focus then
				c.minimized = true
			else
				c:emit_signal("request::activate", "tasklist", { raise = true })
			end
		end),
		awful.button({}, 3, function()
			awful.menu.client_list({ theme = { width = 250 } })
		end),
		awful.button({}, 4, function()
			awful.client.focus.byidx(1)
		end),
		awful.button({}, 5, function()
			awful.client.focus.byidx(-1)
		end)
	)

	-- icon widget
	local icon_widget = wibox.widget({
		id = "icon_role",
		widget = wibox.widget.imagebox,
	})

	local icon_container = wibox.widget({
		icon_widget,
		widget = wibox.container.margin,
		top = 5,
		bottom = 5,
		left = 5,
		right = 5,
	})

	-- Create a tasklist widget
	local tasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
		-- style = {
		-- 	icon_size = 5,
		-- },
		layout = {
			spacing = 10,
			layout = wibox.layout.fixed.horizontal,
		},
		widget_template = {
			{
				-- icon_widget,
				{
					id = "icon_role",
					widget = wibox.widget.imagebox,
					image = nil,
				},
				widget = wibox.container.margin,
				top = 5,
				bottom = 5,
				left = 5,
				right = 5,
				id = "task_margin",
			},
			-- icon_container,
			widget = wibox.container.background,
			bg = beautiful.bg_3,
			shape = function(cr, width, height)
				gears.shape.rounded_rect(cr, width, height, 7)
			end,
		},
	})

	return tasklist
end

return M
