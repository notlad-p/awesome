local awful = require "awful"
local naughty = require "naughty"
local gears = require "gears"
local hotkeys_popup = require "awful.hotkeys_popup"
local filesystem = require "gears.filesystem"
local config_dir = filesystem.get_configuration_dir()

local modkey = require("configuration.keys.mod").modkey
local apps = require "configuration.apps"
-- Helper for multiple monitors
local xrandr = require "xrandr"
local term_scratch = require "ui.term-scratchpad"

local M = {}

M.setup = function()
  -- {{{ Key bindings
  local globalkeys = gears.table.join(
    awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),

    awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
    awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
    awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

    awful.key({ modkey }, "j", function()
      awful.client.focus.byidx(1)
    end, { description = "focus next by index", group = "client" }),
    awful.key({ modkey }, "k", function()
      awful.client.focus.byidx(-1)
    end, { description = "focus previous by index", group = "client" }),
    -- awful.key({ modkey }, "w", function()
    -- 	mymainmenu:show()
    -- end, { description = "show main menu", group = "awesome" }),

    -- Layout manipulation
    awful.key({ modkey, "Shift" }, "j", function()
      awful.client.swap.byidx(1)
    end, { description = "swap with next client by index", group = "client" }),
    awful.key({ modkey, "Shift" }, "k", function()
      awful.client.swap.byidx(-1)
    end, { description = "swap with previous client by index", group = "client" }),

    awful.key({ modkey, "Control" }, "h", function()
      awful.screen.focus_relative(1)
    end, { description = "focus the next screen", group = "screen" }),
    awful.key({ modkey, "Control" }, "l", function()
      awful.screen.focus_relative(-1)
    end, { description = "focus the previous screen", group = "screen" }),

    awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
    awful.key({ modkey }, "Tab", function()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end, { description = "go back", group = "client" }),

    -- toggle title bar - NOT WORKING - 'c' is nil
    -- awful.key({ modkey, "Control" }, "t", function(c)
    -- 	awful.titlebar.toggle(c)
    -- end, { description = "toggle title bar", group = "client" }),

    -- run terminal
    awful.key({ modkey }, "Return", function()
      awful.spawn(apps.default.terminal)
    end, { description = "open a terminal", group = "launcher" }),
    awful.key({ modkey }, "f", function()
      awful.spawn(apps.default.web_browser)
    end, { description = "open default web browser", group = "launcher" }),
    awful.key({ modkey }, "v", function()
      awful.spawn "vivaldi"
    end, { description = "open vivaldi web browser", group = "launcher" }),
    awful.key({ modkey }, "z", function()
      awful.spawn "zen-browser"
    end, { description = "open Zen web browser", group = "launcher" }),
    -- open obsidian
    awful.key({ modkey, "Shift" }, "o", function()
      awful.spawn "obsidian"
    end, { description = "open Obsidian notes", group = "launcher" }),

    awful.key({ modkey }, "u", function()
      awful.spawn.with_shell "scrot -M 1 ~/Pictures/dots/$a.png"
    end, { description = "screenshot screen 1", group = "launcher" }),

    awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
    awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

    -- increase / decrease gap
    awful.key({ modkey }, "g", function()
      awful.tag.incgap(1)
    end, { description = "increase gap", group = "layout" }),
    awful.key({ modkey, "Shift" }, "g", function()
      awful.tag.incgap(-1)
    end, { description = "decrease gap", group = "layout" }),

    awful.key({ modkey }, "l", function()
      awful.tag.incmwfact(0.05)
    end, { description = "increase master width factor", group = "layout" }),
    awful.key({ modkey }, "h", function()
      awful.tag.incmwfact(-0.05)
    end, { description = "decrease master width factor", group = "layout" }),

    awful.key({ modkey, "Shift" }, "h", function()
      awful.tag.incnmaster(1, nil, true)
    end, { description = "increase the number of master clients", group = "layout" }),
    awful.key({ modkey, "Shift" }, "l", function()
      awful.tag.incnmaster(-1, nil, true)
    end, { description = "decrease the number of master clients", group = "layout" }),
    awful.key({ modkey, "Control" }, "=", function()
      awful.tag.incncol(1, nil, true)
    end, { description = "increase the number of columns", group = "layout" }),
    awful.key({ modkey, "Control" }, "-", function()
      awful.tag.incncol(-1, nil, true)
    end, { description = "decrease the number of columns", group = "layout" }),

    awful.key({ modkey }, "space", function()
      awful.layout.inc(1)
    end, { description = "select next", group = "layout" }),
    awful.key({ modkey, "Shift" }, "space", function()
      awful.layout.inc(-1)
    end, { description = "select previous", group = "layout" }),

    awful.key({ modkey, "Control" }, "n", function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        c:emit_signal("request::activate", "key.unminimize", { raise = true })
      end
    end, { description = "restore minimized", group = "client" }),

    -- toggle terminal scratch pad
    awful.key({ modkey }, "\\", function()
      term_scratch:toggle()
    end, { description = "toggle terminal scratchpad", group = "client" }),
    -- toggle floating file explorer
    awful.key({ modkey }, "e", function()
      local focused_client = client.focus
      if focused_client then
        if focused_client.class == "floating_file_explorer" then
          focused_client:kill()
        else
          awful.spawn(apps.default.floating_file_explorer)
        end
      end
    end, {
      description = "toggle floating file explorer",
      group = "client",
    }),

    -- awful.key({ modkey, "Shift" }, "e", function()
    --   awful.spawn(apps.default.file_explorer)
    -- end, { description = "open file explorer", group = "client" }),

    -- Prompt
    -- awful.key({ modkey }, "r", function()
    --   awful.screen.focused().mypromptbox:run()
    -- end, { description = "run prompt", group = "launcher" }),

    -- awful.key({ modkey }, "x", function()
    -- 	awful.prompt.run({
    -- 		prompt = "Run Lua code: ",
    -- 		textbox = awful.screen.focused().mypromptbox.widget,
    -- 		exe_callback = awful.util.eval,
    -- 		history_path = awful.util.get_cache_dir() .. "/history_eval",
    -- 	})
    -- end, { description = "lua execute prompt", group = "awesome" }),
    -- Menubar
    -- awful.key({ modkey }, "p", function()
    -- 	menubar.show()
    -- end, { description = "show the menubar", group = "launcher" }),
    -- display settings
    awful.key({ modkey }, "/", function()
      xrandr.xrandr()
    end),
    -- rofi launcher
    awful.key({ modkey }, "d", function()
      awful.spawn "rofi -show drun -theme ~/.config/awesome/configuration/rofi/appmenu.rasi"
    end, { description = "rofi run launcher", group = "awesome" })
  )

  -- Bind all key numbers to tags.
  -- Be careful: we use keycodes to make it work on any keyboard layout.
  -- This should map on the top row of your keyboard, usually 1 to 9.
  for i = 1, 5 do
    globalkeys = gears.table.join(
      globalkeys,
      -- View tag only.
      awful.key({ modkey }, "#" .. i + 9, function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end, { description = "view tag #" .. i, group = "tag" }),
      -- Toggle tag display.
      awful.key({ modkey, "Control" }, "#" .. i + 9, function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end, { description = "toggle tag #" .. i, group = "tag" }),
      -- Move client to tag.
      awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end, { description = "move focused client to tag #" .. i, group = "tag" }),
      -- Toggle tag on focused client.
      awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end, { description = "toggle focused client on tag #" .. i, group = "tag" })
    )
  end

  return globalkeys
end

return M
