local awful = require "awful"

local top_panel = require "ui.top-panel"
local toggle_panel = require "ui.toggle-panel"
local power_panel = require "ui.power-panel"

local M = {}

-- TODO: upgrade to new api's, use github rc.lua as refrence:
-- https://github.com/awesomeWM/awesome/blob/master/awesomerc.lua
M.setup = function()
  screen.connect_signal("request::desktop_decoration", function(s)
    top_panel(s)
    toggle_panel(s)
    power_panel(s)
  end)
end

return M
