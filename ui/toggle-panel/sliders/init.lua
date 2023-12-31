local wibox = require "wibox"

local container = require "ui.toggle-panel.container"
local volume = require "ui.toggle-panel.sliders.volume"
local microphone = require "ui.toggle-panel.sliders.microphone"

return function(s)
  local brightness = require "ui.toggle-panel.sliders.brightness" (s)
  s.slider_container = wibox.widget {
    volume,
    brightness,
    microphone,
    layout = wibox.layout.flex.vertical,
    spacing = 16,
  }

  return container(s.slider_container, 310)
end
