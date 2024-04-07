-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local gears = require "gears"
local awful = require "awful"
require "awful.autofocus"
local beautiful = require "beautiful"
local menubar = require("menubar")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
-- TODO: add more tmux keys in help popup
-- https://awesomewm.org/apidoc/libraries/awful.hotkeys_popup.html
-- https://awesomewm.org/apidoc/popups_and_bars/awful.hotkeys_popup.widget.html
require "awful.hotkeys_popup.keys"

-- error handling
require "error"

-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/theme.lua")

-- setup layouts (needs to come before 'ui')
require "configuration.layouts"

-- setup wallpaper
require "theme.wallpaper"

-- set up ui
require("ui").setup()

-- weather signal (API request on a timer)
require("signal.weather")

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
require "configuration.client"

-- MODULES
require "module.auto-start"

-- rules (with ruled api)
require "configuration.notifications"

-- Set gtk icons
-- NOTE: this is a workaround for some icons not showing in the tasklist (obsidian specifically)
-- https://github.com/awesomeWM/awesome/issues/3587
client.connect_signal("manage", function(c)
  awful.spawn.easy_async_with_shell("sleep 0.1", function()
    if c.valid then
      if c.instance ~= nil then
        local icon = menubar.utils.lookup_icon(c.instance)
        local lower_icon = menubar.utils.lookup_icon(c.instance:lower())
        if icon ~= nil then
          local new_icon = gears.surface(icon)
          c.icon = new_icon._native
        elseif lower_icon ~= nil then
          local new_icon = gears.surface(lower_icon)
          c.icon = new_icon._native
        elseif c.icon == nil then
          local new_icon = gears.surface(menubar.utils.lookup_icon("application-default-icon"))
          c.icon = new_icon._native
        end
      else
        local new_icon = gears.surface(menubar.utils.lookup_icon("application-default-icon"))
        c.icon = new_icon._native
      end
    end
  end)
end)
