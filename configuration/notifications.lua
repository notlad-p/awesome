-- TODO: set up a ui for basic notifications:
-- Widget content: icon, title, content
-- Buttons: open, delete, X icon in top right to delete (with animated radial graph like yoru)

local naughty = require "naughty"
-- local playerctl_daemon = require "signal.playerctl"
local wibox = require "wibox"

-- playerctl_daemon:connect_signal("metadata", function(_, title, artist, album_path, album, new, player_name)
--   if new == true then
--     naughty.notify {
--       app_name = "Music",
--       title = title,
--       text = artist,
--       image = album_path,
--     }
--   end
-- end)

-- TODO: setup notification template here
-- EXAMPLE: https://github.com/rxyhn/yoru/blob/main/config/awesome/ui/notifications/init.lua
naughty.connect_signal("request::display", function(n)
  naughty.layout.box {
    notification = n,
    widget_template = {
      {
        widget = naughty.widget.icon,
      },
      {
        widget = naughty.widget.title,
      },
      {
        widget = naughty.widget.message,
      },
      {
        widget = naughty.list.actions,
      },
      layout = wibox.layout.fixed.vertical,
    },
  }
end)

-- naughty.notification {
--   title = "A notification",
--   message = "This is very informative",
--   -- icon = beautiful.awesome_icon,
--   actions = {
--     naughty.action { name = "Existing 1" },
--     naughty.action { name = "Existing 2" },
--   },
-- }

-- -- Create a normal notification.
-- naughty.notification {
--   title = "A notification 1",
--   message = "This is very informative",
--   -- icon = beautiful.awesome_icon,
--   urgency = "normal",
-- }
--
-- -- Create a normal notification.
-- naughty.notification {
--   title = "A notification 2",
--   message = "This is very informative",
--   -- icon = beautiful.awesome_icon,
--   urgency = "critical",
-- }
