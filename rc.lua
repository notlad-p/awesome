-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local beautiful = require("beautiful")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- error handling
require("error")

-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/theme.lua")

-- setup layouts (needs to come before 'ui')
require("configuration.layouts")

-- set up ui
require("ui").setup()

-- mouse bindings
root.buttons(gears.table.join(
	-- awful.button({}, 3, function()
	-- 	mymainmenu:toggle()
	-- end),
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
))

-- set keys
root.keys(require("configuration.keys").setup())
-- setup client
require("configuration.client")

-- MODULES
require("module.auto-start")
