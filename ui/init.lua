local awful = require("awful")

local top_panel = require("ui.top-panel")
local set_wallpaper = require("ui.wallpaper").set_wallpaper
local toggle_panel = require("ui.toggle-panel")
local power_panel = require("ui.power-panel")

local M = {}

M.setup = function()
	-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
	screen.connect_signal("property::geometry", set_wallpaper)

	awful.screen.connect_for_each_screen(function(s)
		-- Wallpaper
		set_wallpaper(s)
		top_panel(s)
		toggle_panel(s)
		power_panel(s)
	end)
end

return M
