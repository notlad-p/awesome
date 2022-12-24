---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gears = require("gears")
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local user_config_path = gfs.get_configuration_dir()

local theme = {}

-- ONEDARK THEME
theme.bg_0 = "#1a212e"
-- theme.test = "#19212f"
-- theme.bg1 = "#21283b"
-- theme.bg2 = "#283347"
theme.bg_3 = "#2a324a"
theme.bg_d = "#141b24"
-- theme.test = "#121b25"
-- theme.bg_yellow = "#f2cc81"
theme.bg_blue = "#54b0fd"

theme.fg = "#93a4c3"
theme.test = "#90a4c6"

theme.black = "#0c0e15"
theme.grey = "#455574"
theme.light_grey = "#6c7d9c"
theme.purple = "#c75ae8"
-- theme.test = "#d64cef"
theme.green = "#8bcd5b" -- 95°, 53%, 58%
-- theme.test = "#74d046" -- 100°, 59%, 55%
-- theme.test = "#6ee830"
-- theme.orange = "#dd9046"
-- theme.test = "#e98c31"
theme.blue = "#41a7fc"
-- theme.test = "#00a8ff"
theme.yellow = "#efbd5d"
-- theme.test = "#ffc14d"
-- theme.test = "#f7bc47"
theme.cyan = "#34bfd0"
theme.test = "#00bfcf"
theme.red = "#f65866"
-- theme.test = "#ff4761"
theme.dark_cyan = "#1F737D"
-- theme.dark_red = "#992525"
-- theme.dark_yellow = "#8f610d"
-- theme.dark_purple = "#862aa1"
-- theme.diff_add = "#27341c"
-- theme.diff_delete = "#331c1e"
-- theme.diff_change = "#102b40"
-- theme.diff_text = "#1c4a6e"

theme.font = "FiraCode NF 8.5"

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
-- theme.wibar_bg = theme.bg_0
theme.wibar_bg = "#00000000"
theme.wibar_fg = theme.fg
-- theme.wibar_opacity = 0.5

-- toggle panel
theme.margin_outside = 24
theme.margin_inside = 16
-- profile picture
theme.pfp = user_config_path .. "theme/images/pfp.png"
-- icons
theme.plane = user_config_path .. "theme/icons/toggle-panel/plane.svg"
theme.plane_toggled = user_config_path .. "theme/icons/toggle-panel/plane-toggled.svg"
theme.bluetooth = user_config_path .. "theme/icons/toggle-panel/bluetooth.svg"
theme.bluetooth_toggled = user_config_path .. "theme/icons/toggle-panel/bluetooth-toggled.svg"
theme.wifi = user_config_path .. "theme/icons/toggle-panel/wifi.svg"
theme.wifi_toggled = user_config_path .. "theme/icons/toggle-panel/wifi-toggled.svg"
theme.crop = user_config_path .. "theme/icons/toggle-panel/crop.svg"
theme.float = user_config_path .. "theme/icons/toggle-panel/float.svg"
theme.float_toggled = user_config_path .. "theme/icons/toggle-panel/float-toggled.svg"
theme.notifications = user_config_path .. "theme/icons/toggle-panel/notifications.svg"
theme.notifications_toggled = user_config_path .. "theme/icons/toggle-panel/notifications-toggled.svg"
-- silders
theme.volume = user_config_path .. "theme/icons/toggle-panel/volume.svg"
theme.brightness = user_config_path .. "theme/icons/toggle-panel/brightness.svg"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:

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

-- prompt cursor styles
theme.prompt_bg_cursor = theme.grey
theme.prompt_fg_cursor = theme.cyan

-- Generate taglist squares: (little squares that indicate if a client is
-- present in a tag)
-- local taglist_square_size = dpi(4)
-- theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
-- theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

-- Variables set for theming notifications:
theme.notification_bg = theme.bg_d
theme.notification_fg = theme.fg
theme.notification_shape = function(cr, width, height)
	gears.shape.rounded_rect(cr, width, height, 10)
end
-- notification_font
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
-- theme.titlebar_close_button_normal = themes_path .. "default/titlebar/close_normal.png"
-- theme.titlebar_close_button_focus = themes_path .. "default/titlebar/close_focus.png"
theme.titlebar_close_button_normal = user_config_path .. "theme/icons/titlebar/normal.svg"
theme.titlebar_close_button_focus = user_config_path .. "theme/icons/titlebar/close.svg"

-- theme.titlebar_minimize_button_normal = user_config_path .. "icons/minimize.svg"
-- theme.titlebar_minimize_button_focus = user_config_path .. "icons/minimize.svg"
theme.titlebar_minimize_button_normal = user_config_path .. "theme/icons/titlebar/normal.svg"
theme.titlebar_minimize_button_focus = user_config_path .. "theme/icons/titlebar/minimize.svg"

-- theme.titlebar_ontop_button_normal_inactive = themes_path .. "default/titlebar/ontop_normal_inactive.png"
-- theme.titlebar_ontop_button_focus_inactive = themes_path .. "default/titlebar/ontop_focus_inactive.png"
-- theme.titlebar_ontop_button_normal_active = themes_path .. "default/titlebar/ontop_normal_active.png"
-- theme.titlebar_ontop_button_focus_active = themes_path .. "default/titlebar/ontop_focus_active.png"
--
-- theme.titlebar_sticky_button_normal_inactive = themes_path .. "default/titlebar/sticky_normal_inactive.png"
-- theme.titlebar_sticky_button_focus_inactive = themes_path .. "default/titlebar/sticky_focus_inactive.png"
-- theme.titlebar_sticky_button_normal_active = themes_path .. "default/titlebar/sticky_normal_active.png"
-- theme.titlebar_sticky_button_focus_active = themes_path .. "default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = user_config_path .. "theme/icons/titlebar/normal.svg"
theme.titlebar_floating_button_focus_inactive = user_config_path .. "theme/icons/titlebar/grid-normal.svg"
theme.titlebar_floating_button_normal_active = user_config_path .. "theme/icons/titlebar/normal-active.svg"
theme.titlebar_floating_button_focus_active = user_config_path .. "theme/icons/titlebar/grid-active.svg"

theme.titlebar_maximized_button_normal_inactive = user_config_path .. "theme/icons/titlebar/normal.svg"
theme.titlebar_maximized_button_focus_inactive = user_config_path .. "theme/icons/titlebar/maximize-normal.svg"
theme.titlebar_maximized_button_normal_active = user_config_path .. "theme/icons/titlebar/normal-active.svg"
theme.titlebar_maximized_button_focus_active = user_config_path .. "theme/icons/titlebar/maximize-active.svg"

-- set wallpaper
theme.wallpaper = user_config_path .. "theme/wallpapers/1.jpg"

-- add other images
theme.logout_image = user_config_path .. "theme/wallpapers/girl-with-umbrella.jpg"

-- You can use your own layout icons like this:
theme.layout_fairv = user_config_path .. "theme/icons/layouts/fair.svg"
theme.layout_max = user_config_path .. "theme/icons/layouts/maximize.svg"
theme.layout_fullscreen = user_config_path .. "theme/icons/layouts/fullscreen.svg"
theme.layout_tile = user_config_path .. "theme/icons/layouts/tile.svg"
theme.layout_tileleft = user_config_path .. "theme/icons/layouts/tile-left.svg"
theme.layout_tilebottom = user_config_path .. "theme/icons/layouts/tile-bottom.svg"
theme.layout_tiletop = user_config_path .. "theme/icons/layouts/tile-top.svg"
theme.layout_floating = user_config_path .. "theme/icons/layouts/float.svg"

-- wibar icons
theme.music = user_config_path .. "theme/icons/misc/music.svg"
theme.calendar = user_config_path .. "theme/icons/misc/calendar.svg"
theme.clock = user_config_path .. "theme/icons/misc/clock.svg"
theme.power = user_config_path .. "theme/icons/misc/power.svg"
theme.backward = user_config_path .. "theme/icons/misc/backward.svg"
theme.play = user_config_path .. "theme/icons/misc/play.svg"
theme.forward = user_config_path .. "theme/icons/misc/forward.svg"

-- power panel icons
theme.power_light = user_config_path .. "theme/icons/misc/power-light.svg"
theme.lock = user_config_path .. "theme/icons/power-panel/lock.svg"
theme.logout = user_config_path .. "theme/icons/power-panel/logout.svg"
theme.restart = user_config_path .. "theme/icons/power-panel/restart.svg"
theme.sleep = user_config_path .. "theme/icons/power-panel/sleep.svg"

-- theme.layout_fairh = themes_path .. "default/layouts/fairhw.png"
-- theme.layout_magnifier = themes_path .. "default/layouts/magnifierw.png"
-- theme.layout_spiral = themes_path .. "default/layouts/spiralw.png"
-- theme.layout_dwindle = themes_path .. "default/layouts/dwindlew.png"
-- theme.layout_cornernw = themes_path .. "default/layouts/cornernww.png"
-- theme.layout_cornerne = themes_path .. "default/layouts/cornernew.png"
-- theme.layout_cornersw = themes_path .. "default/layouts/cornersww.png"
-- theme.layout_cornerse = themes_path .. "default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
