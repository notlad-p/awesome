local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")

local container = require("ui.toggle-panel.container")
local volume = require("ui.toggle-panel.sliders.volume")

local slider_container = wibox.widget({
  volume,
  layout = wibox.layout.align.vertical,
})

return container(slider_container, 310)
