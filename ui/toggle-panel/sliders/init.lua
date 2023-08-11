local wibox = require "wibox"

local container = require "ui.toggle-panel.container"
local volume = require "ui.toggle-panel.sliders.volume"

return function(s)
  local brightness = require "ui.toggle-panel.sliders.brightness" (s)
  s.slider_container = wibox.widget {
    volume,
    brightness,
    layout = wibox.layout.flex.vertical,
    spacing = 16,
  }

  return container(s.slider_container, 310)
end
