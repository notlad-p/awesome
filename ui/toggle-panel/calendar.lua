local wibox = require "wibox"
local gears = require "gears"
local beautiful = require "beautiful"

local container = require "ui.toggle-panel.container"

local styles = {}
local function rounded_shape(size, width, height)
  return function(cr, w, h)
    gears.shape.rounded_rect(cr, width or w, height or h, size)
  end
end

-- container for calendar
styles.month = {
  padding = 5,
  bg_color = beautiful.bg_3,
  fg_color = beautiful.fg,
  shape = rounded_shape(10),
  top = 18,
  bottom = 24,
}

-- month name header
styles.header = {
  bg_color = beautiful.bg_3,
  fg_color = beautiful.blue,
  markup = function(t)
    return "<b>" .. t .. "</b>"
  end,
  shape = rounded_shape(10),
  -- bottom = 20,
}

-- weekdays heading
styles.weekday = {
  fg_color = beautiful.fg,
  bg_color = beautiful.bg_3,
  markup = function(t)
    return "<b>" .. t .. "</b>"
  end,
  shape = rounded_shape(5),
}
-- normal day of month
styles.normal = {
  fg_color = beautiful.fg,
  bg_color = beautiful.bg_3,
  shape = rounded_shape(5),
  top = 3,
  right = 3,
  bottom = 3,
  left = 3,
}
-- day of month with focus (current day)
styles.focus = {
  fg_color = beautiful.bg_3,
  bg_color = beautiful.blue,
  markup = function(t)
    return "<b>" .. t .. "</b>"
  end,
  shape = rounded_shape(5),
}

local function decorate_cell(widget, flag, date)
  if flag == "monthheader" and not styles.monthheader then
    flag = "header"
  end
  local props = styles[flag] or {}
  if props.markup and widget.get_text and widget.set_markup then
    widget:set_markup(props.markup(widget:get_text()))
  end

  if flag == "header" then
    widget.font = beautiful.font_name .. " 13"
  end

  -- Change bg color for weekends
  -- local d = { year = date.year, month = (date.month or 1), day = (date.day or 1) }
  -- local weekday = tonumber(os.date("%w", os.time(d)))
  -- local default_bg = (weekday == 0 or weekday == 6) and "#232323" or "#383838"

  return wibox.widget {
    {
      {
        widget,
        halign = "center",
        valign = "center",
        widget = wibox.container.place,
      },
      top = props.top or 0,
      bottom = props.bottom or 0,
      left = props.left or 0,
      right = props.right or 0,
      widget = wibox.container.margin,
    },
    shape = props.shape,
    font = props.font or nil,
    border_color = props.border_color or "#b9214f",
    border_width = props.border_width or 0,
    fg = props.fg_color or "#999999",
    bg = props.bg_color or "#000000",
    widget = wibox.container.background,
  }
end

local clock = wibox.widget {
  {
    {
      format = "%I:%M %P",
      font = beautiful.font_name .. " 28",
      widget = wibox.widget.textclock,
    },
    halign = "center",
    valign = "center",
    widget = wibox.container.place,
  },
  bottom = 6,
  widget = wibox.container.margin,
}

local date = wibox.widget {
  {
    {
      format = "%A, %b %d",
      widget = wibox.widget.textclock,
    },
    halign = "center",
    valign = "center",
    widget = wibox.container.place,
  },
  bottom = 24,
  widget = wibox.container.margin,
}

local cal = wibox.widget {
  date = os.date "*t",
  font = beautiful.font,
  spacing = 12,
  start_sunday = true,
  fn_embed = decorate_cell,
  widget = wibox.widget.calendar.month,
}

local calendar_section = wibox.widget {
  clock,
  date,
  cal,
  layout = wibox.layout.fixed.vertical,
}

return container(calendar_section, 334)
