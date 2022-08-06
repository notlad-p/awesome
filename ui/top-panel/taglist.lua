local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local modkey = require("configuration.keys.mod").modkey

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
			checkbox.color = beautiful.cyan

			-- if selected and contains no clients, don't check
			if #tag:clients() == 0 then
				checkbox.checked = false
			else
				checkbox.checked = true
			end
		-- if contains clients and not selected, check & grey
		elseif #tag:clients() > 0 then
			checkbox.checked = true
			checkbox.color = beautiful.dark_cyan
		-- if no clients and not selected, unchecked & grey
		else
			checkbox.color = beautiful.dark_cyan
			checkbox.checked = false
		end
	end

	local taglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		layout = {
			spacing = 12,
			layout = wibox.layout.fixed.horizontal,
		},
		widget_template = {
			{
				widget = wibox.widget.checkbox,
				checked = false,
				-- inside (checked) shape
				check_shape = gears.shape.losange,
				-- border shape
				shape = gears.shape.losange,
				-- padding between border & inner checked area
				paddings = 5,
				border_width = 2,
				id = "tag_checkbox_role",
			},
			widget = wibox.container.background,
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
