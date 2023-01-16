local awful = require "awful"
local beautiful = require "beautiful"
local ruled = require "ruled"

local clientkeys = require "configuration.client.keys"
local clientbuttons = require "configuration.client.buttons"

ruled.client.connect_signal("request::rules", function()
  -- @DOC_GLOBAL_RULE@
  -- All clients will match this rule.
  ruled.client.append_rule {
    id = "global",
    rule = {},
    properties = {
      -- defaults
      focus = awful.client.focus.filter,
      raise = true,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
      -- keys & buttons
      keys = clientkeys,
      buttons = clientbuttons,
    },
  }

  -- @DOC_FLOATING_RULE@
  -- Floating clients.
  ruled.client.append_rule {
    id = "floating",
    rule_any = {
      instance = { "copyq", "pinentry" },
      class = {
        "Arandr",
        "Blueman-manager",
        "Gpick",
        "Kruler",
        "Sxiv",
        "Tor Browser",
        "Wpa_gui",
        "veromix",
        "xtightvncviewer",
      },
      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        "Event Tester", -- xev.
      },
      role = {
        "AlarmWindow", -- Thunderbird's calendar.
        "ConfigManager", -- Thunderbird's about:config.
        "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
      },
    },
    properties = { floating = true },
  }

  -- @DOC_DIALOG_RULE@
  -- Add titlebars to normal clients and dialogs
  ruled.client.append_rule {
    -- @DOC_CSD_TITLEBARS@
    id = "titlebars",
    rule_any = { type = { "normal", "dialog" } },
    properties = { titlebars_enabled = true },
  }

  -- scratch pad rules

  ruled.client.append_rule {
    rule_any = {
      class = {
        "spad",
      },
    },
    properties = { floating = true, placement = awful.placement.centered },
  }
end)
