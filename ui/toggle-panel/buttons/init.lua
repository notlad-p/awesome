local wibox = require("wibox")

return function(s)
  local container = require("ui.toggle-panel.container")

  -- commands
  -- screenshots: awful.prompt to get image name and file type
  --

  local airplane_mode = require("ui.toggle-panel.buttons.airplane-mode")
  local bluetooth_toggle = require("ui.toggle-panel.buttons.bluetooth")
  local wifi_toggle = require("ui.toggle-panel.buttons.wifi")
  local crop_screenshot = require("ui.toggle-panel.buttons.screenshot.init")(s)
  local notifications_toggle = require("ui.toggle-panel.buttons.notifications")
  local float_toggle = require("ui.toggle-panel.buttons.float-toggle")

  local buttons = wibox.widget({
    airplane_mode,
    bluetooth_toggle,
    wifi_toggle,
    crop_screenshot,
    notifications_toggle,
    float_toggle,
    spacing = 16,
    forced_num_cols = 3,
    forced_num_rows = 2,
    homogeneous = true,
    layout = wibox.layout.grid,
  })

  return container(buttons, 310)
end
