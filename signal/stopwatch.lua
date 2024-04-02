local gears = require "gears"

local instance = nil

-- https://awesomewm.org/apidoc/core_components/gears.timer.html
local function new()
  return gears.timer {
    timeout = 1,
  }
end

if not instance then
  instance = new()
end

return instance
