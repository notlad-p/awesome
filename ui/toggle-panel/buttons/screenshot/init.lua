local beautiful = require "beautiful"
local gears = require "gears"
local awful = require "awful"

return function(s)
  local button = require "ui.toggle-panel.buttons.button"

  local widget = button(beautiful.crop)

  local screenshot_popup, run_prompt = require "ui.toggle-panel.buttons.screenshot.popup"(s)

  local action = function()
    screenshot_popup:emit_signal "screenshot_popup::toggle"

    if screenshot_popup.visible then
      run_prompt()
    end
  end

  widget:buttons(gears.table.join(awful.button({}, 1, nil, function()
    action()
  end)))

  return widget
end
