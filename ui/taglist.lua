local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local M = {}

M.setup = function(s)
	-- Each screen has its own tag table.
	awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])

	-- button mouse events / key binds
	local taglist_buttons = gears.table.join(
		awful.button({}, 1, function(t)
			t:view_only()
		end),
		awful.button({ modkey }, 1, function(t)
			if client.focus then
				client.focus:move_to_tag(t)
			end
		end),
		awful.button({}, 3, awful.tag.viewtoggle),
		awful.button({ modkey }, 3, function(t)
			if client.focus then
				client.focus:toggle_tag(t)
			end
		end),
		awful.button({}, 4, function(t)
			awful.tag.viewnext(t.screen)
		end),
		awful.button({}, 5, function(t)
			awful.tag.viewprev(t.screen)
		end)
	)

	local update_icon = function(item, tag, index)
		local checkbox = item:get_children_by_id("tag_checkbox_role")[1]

		-- if selected tag
		if tag.selected then
			checkbox.color = beautiful.fg

			-- if selected and contains no clients, don't check
			if #tag:clients() == 0 then
				checkbox.checked = false
			else
				checkbox.checked = true
			end
		-- if contains clients and not selected, check & grey
		elseif #tag:clients() > 0 then
			checkbox.checked = true
			checkbox.color = beautiful.grey
		-- if no clients and not selected, unchecked & grey
		else
			checkbox.color = beautiful.grey
			checkbox.checked = false
		end
	end

	local taglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		widget_template = {
			{
				{
					widget = wibox.widget.checkbox,
					checked = false,
					-- inside (checked) shape
					check_shape = gears.shape.circle,
					-- border shape
					shape = gears.shape.circle,
					-- padding between border & inner checked area
					paddings = 4,
					border_width = 2,
					id = "tag_checkbox_role",
				},
				left = 8,
				right = 8,
				top = 4,
				bottom = 4,
				widget = wibox.container.margin,
			},
			widget = wibox.container.background,
			bg = beautiful.bg_0,
			-- Add support for hover colors and an index label
			create_callback = function(item, tag, index, objects) --luacheck: no unused args
				update_icon(item, tag, index)
			end,
			--
			-- updates widget
			update_callback = function(item, tag, index, objects) --luacheck: no unused args
				update_icon(item, tag, index)
			end,
		},
		buttons = taglist_buttons,
	})

	return taglist
end

return M
