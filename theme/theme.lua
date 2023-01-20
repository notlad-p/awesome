local theme_assets = require "beautiful.theme_assets"
local xresources = require "beautiful.xresources"
local dpi = xresources.apply_dpi

local gears = require "gears"
local gfs = require "gears.filesystem"
local themes_path = gfs.get_themes_dir()
local user_config_path = gfs.get_configuration_dir()

local theme = {}

---------------------------------
-- Stuff that might be customized
---------------------------------
-- colorscheme
local colorscheme = "gruvbox"
-- wallpaper
theme.wallpaper = user_config_path .. "images/wallpapers/2.jpg"
-- font
theme.font = "FiraCode NF 8.5"

----------------------
-- COLORS & WIDGETS
----------------------
-- get colorscheme values & set them in theme table
local schemes = require "theme.colorschemes"
local selected_scheme = schemes[colorscheme]
for key, value in pairs(selected_scheme) do
  theme[key] = value
end

theme.bg_normal = theme.bg_0
theme.bg_focus = theme.bg_3
theme.bg_urgent = theme.red
theme.bg_minimize = theme.light_grey
theme.bg_systray = theme.bg_normal

theme.fg_normal = theme.grey
theme.fg_focus = theme.fg
theme.fg_urgent = theme.fg
theme.fg_minimize = theme.fg

-- client styles
theme.useless_gap = 8
theme.border_width = dpi(1)
theme.border_normal = theme.bg_d
theme.border_focus = theme.light_grey
theme.border_marked = theme.red

-- wibar theme
theme.wibar_bg = "#00000000" -- transparent for separated look
theme.wibar_fg = theme.fg

-- titlebar styles
theme.titlebar_bg_normal = theme.bg_d
theme.titlebar_bg_focus = theme.bg_0

theme.titlebar_fg_normal = theme.grey
theme.titlebar_fg_focus = theme.fg

-- tasklist style
theme.tasklist_bg_normal = "#00000000"
theme.tasklist_bg_focus = "#00000000"
theme.tasklist_bg_minimize = "#00000000"
theme.tasklist_disable_task_name = true
theme.tasklist_plain_task_name = true

-- taglist style
theme.taglist_bg_focus = "#00000000"
theme.taglist_icon_occupied = "#93a4c3"

-- right click menu
theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

-- custom margin rules
theme.margin_outside = 24
theme.margin_inside = 16

----------------------
-- IMAGES
----------------------

-- profile picture
theme.pfp = user_config_path .. "images/pfp.png"

----------------------
-- ICONS
----------------------
local icons_path = user_config_path .. "images/icons/"
local recolor_image = gears.color.recolor_image

-- built-in icons
-- these are built-in icons that need to be set and recolored here
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- titlebar
local circle = icons_path .. "circle.svg"
local circle_filled = icons_path .. "circle-filled.svg"
local circle_grey = recolor_image(circle, theme.grey)

theme.titlebar_close_button_normal = circle_grey
theme.titlebar_close_button_focus = recolor_image(circle, theme.red)

theme.titlebar_minimize_button_normal = circle_grey
theme.titlebar_minimize_button_focus = recolor_image(circle, theme.yellow)

theme.titlebar_floating_button_normal_inactive = circle_grey
theme.titlebar_floating_button_focus_inactive = recolor_image(circle, theme.purple)
theme.titlebar_floating_button_normal_active = recolor_image(circle_filled, theme.purple)
theme.titlebar_floating_button_focus_active = recolor_image(circle_filled, theme.purple)

theme.titlebar_maximized_button_normal_inactive = circle_grey
theme.titlebar_maximized_button_focus_inactive = recolor_image(circle, theme.blue)
theme.titlebar_maximized_button_normal_active = recolor_image(circle_filled, theme.blue)
theme.titlebar_maximized_button_focus_active = recolor_image(circle_filled, theme.blue)

-- layouts
local layouts_path = icons_path .. "layouts/"
theme.layout_fairv = recolor_image(layouts_path .. "fair.svg", theme.bg_0)
theme.layout_max = recolor_image(layouts_path .. "maximize.svg", theme.bg_0)
theme.layout_fullscreen = recolor_image(layouts_path .. "fullscreen.svg", theme.bg_0)
theme.layout_tile = recolor_image(layouts_path .. "tile.svg", theme.bg_0)
theme.layout_tileleft = recolor_image(layouts_path .. "tile-left.svg", theme.bg_0)
theme.layout_tilebottom = recolor_image(layouts_path .. "tile-bottom.svg", theme.bg_0)
theme.layout_tiletop = recolor_image(layouts_path .. "tile-top.svg", theme.bg_0)
theme.layout_floating = recolor_image(layouts_path .. "float.svg", theme.bg_0)
-- Unused layouts:
-- theme.layout_fairh = themes_path .. "default/layouts/fairhw.png"
-- theme.layout_magnifier = themes_path .. "default/layouts/magnifierw.png"
-- theme.layout_spiral = themes_path .. "default/layouts/spiralw.png"
-- theme.layout_dwindle = themes_path .. "default/layouts/dwindlew.png"
-- theme.layout_cornernw = themes_path .. "default/layouts/cornernww.png"
-- theme.layout_cornerne = themes_path .. "default/layouts/cornernew.png"
-- theme.layout_cornersw = themes_path .. "default/layouts/cornersww.png"
-- theme.layout_cornerse = themes_path .. "default/layouts/cornersew.png"

-- Custom icons table representing their location in the `images/icons/` directory
--
-- To add an icon, copy the svg icon somewhere in `images/icons/`,
-- then put the file name in this table (minus the .svg extension)
--
-- You can even add a key to the icon that will then be used as the key for that icon
-- in the `theme` table. There's an example in the table.
--
-- THIS METHOD DOES NOT WORK 2 SUBDIRECTORIES DOWN, ONLY ONE
local custom_icons = {
  power = {
    "lock",
    "logout",
    "power",
    "restart",
    "sleep",
  },
  "backward",
  "bluetooth",
  "brightness",
  "calendar",
  "clock",
  -- time = "clock", -- The clock icon will need to be referenced as `time` now
  "crop",
  "float",
  "forward",
  "music",
  "notifications",
  "pause",
  "plane",
  "play",
  "volume",
  "wifi",
}

-- loop icons table & add key & path to `theme` table
for key, value in pairs(custom_icons) do
  -- if value is a table (sub-directory), loop it
  if type(value) == "table" then
    for key_2, value_2 in pairs(value) do
      if type(key_2) == "number" then
        theme[value_2] = icons_path .. key .. "/" .. value_2 .. ".svg"
      else
        theme[key_2] = icons_path .. key .. "/" .. value_2 .. ".svg"
      end
    end
  else
    theme[value] = icons_path .. value .. ".svg"
  end
end

theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
