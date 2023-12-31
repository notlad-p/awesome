local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"

-- TODO: setup OSD for microphone value (percentage)
local microphone_icon = require "ui.toggle-panel.sliders.slider-icon" (beautiful.microphone, 18, 18)
local microphone_slider = require "ui.toggle-panel.sliders.slider" (100)

microphone_slider:connect_signal("property::value", function()
  local value = microphone_slider:get_value()

  -- set master volume
  awful.spawn("amixer set Capture " .. value .. "%", false)
end)

-- set microphone_slider to match current microphone volume
-- command taken from rxyhn/yoru
-- https://github.com/rxyhn/yoru/blob/e840befcc90e3d9ad504295fb99edbdc5102ea41/config/awesome/ui/panels/central-panel/slider/mic.lua
awful.spawn.easy_async_with_shell(
-- amixer sget Capture | awk -F'[][]' '/Right:|Mono:/ && NF > 1 {sub(/%/, ""); print $2 }
  "amixer sget Capture | awk -F'[][]' '/Right:|Mono:/ && NF > 1 {sub(/%/, \"\"); printf \"%0.0f\", $2}'",
  function(stdout)
    if stdout == nil then
      return
    end

    microphone_slider:set_value(tonumber(stdout))
  end
)

return wibox.widget {
  microphone_icon,
  microphone_slider,
  layout = wibox.layout.align.horizontal,
}
