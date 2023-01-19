-- toggles floating layout on all screens and on all tags

local beautiful = require "beautiful"
local awful = require "awful"
local gears = require "gears"

local float_on = false

local button = require "ui.toggle-panel.buttons.button"

local widget = button(beautiful.float)

local update_widget = function()
  if float_on then
    widget:turn_on()
  else
    widget:turn_off()
  end
end

local toggle_action = function()
  if float_on then
    for s in screen do
      local tags = s.tags
      for _, tag in ipairs(tags) do
        awful.layout.set(awful.layout.suit.tile, tag)
      end
    end

    float_on = false

    update_widget()
  else
    for s in screen do
      local tags = s.tags
      for _, tag in ipairs(tags) do
        awful.layout.set(awful.layout.suit.floating, tag)
      end
    end

    float_on = true

    update_widget()
  end
end

widget:buttons(gears.table.join(awful.button({}, 1, nil, function()
  toggle_action()
end)))

return widget
