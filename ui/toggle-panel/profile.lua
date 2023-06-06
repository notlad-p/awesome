local wibox = require "wibox"
local beautiful = require "beautiful"
local gears = require "gears"
local awful = require "awful"

return function(s)
  local profile_picture = wibox.widget {
    {
      image = beautiful.pfp,
      resize = false,
      clip_shape = gears.shape.circle,
      widget = wibox.widget.imagebox,
    },
    shape = gears.shape.circle,
    shape_border_width = 1,
    shape_border_color = beautiful.fg,
    widget = wibox.container.background,
    forced_width = 70,
    forced_height = 70,
  }

  local profile_name = wibox.widget {
    markup = "<b>Dalton</b>",
    widget = wibox.widget.textbox,
  }

  -- set profile name with shell command 'whoami'
  awful.spawn.easy_async_with_shell("whoami", function(stdout)
    profile_name:set_markup("<b>" .. stdout .. "</b>")
  end)

  local uptime = wibox.widget {
    markup = '<span size="10pt">up 1d, 14h, 49m</span>',
    widget = wibox.widget.textbox,
  }

  -- set uptime markdown in days:hours:minutes
  local uptime_command = [[bash -c '
    boot=$(date -d"$(uptime -s)" +%s)
    now=$(date +%s)
    s=$((now - boot))

    d=''
    days=$((s / 60 / 60 / 24))
    if [ $days -gt 0 ]; then
      d="${days}d "
    fi

    h=''
    hours=$((s / 60 / 60 % 24))
    if [ $hours -gt 0 ]; then
      h="${hours}h "
    fi

    m="$((s / 60 % 60))m"

    printf "$d$h$m"
  ']]

  local update_uptime = function()
    awful.spawn.easy_async_with_shell(uptime_command, function(stdout)
      uptime:set_markup('<span size="8pt">Uptime: ' .. stdout .. "</span>")
    end)
  end

  -- update uptime every 60 seconds
  gears.timer {
    timeout = 60,
    autostart = true,
    call_now = true,
    callback = function()
      update_uptime()
    end,
  }

  local profile_info = wibox.widget {
    {
      {
        profile_name,
        uptime,
        layout = wibox.layout.flex.vertical,
      },
      valign = "bottom",
      halign = "left",
      widget = wibox.container.place,
    },
    left = 16,
    widget = wibox.container.margin,
  }

  local power_icon = gears.color.recolor_image(beautiful.power, beautiful.fg)
  local power = wibox.widget {
    {
      {
        {
          image = power_icon,
          widget = wibox.widget.imagebox,
          forced_width = 24,
          forced_height = 24,
        },
        top = 12,
        right = 12,
        bottom = 12,
        left = 12,
        widget = wibox.container.margin,
      },
      widget = wibox.container.background,
      bg = beautiful.bg_3,
      shape = function(cr)
        gears.shape.rounded_rect(cr, 48, 48, 7)
      end,
    },
    widget = wibox.container.margin,
    top = 11,
    bottom = 11,
  }

  power:buttons(gears.table.join(awful.button({}, 1, nil, function()
    awesome.emit_signal("power_panel::toggle", s)
  end)))

  local container = require "ui.toggle-panel.container"
  local profile = wibox.widget {
    -- profile image
    profile_picture,
    -- text info
    profile_info,
    -- power button
    power,
    layout = wibox.layout.align.horizontal,
  }

  return container(profile, 310)
end
