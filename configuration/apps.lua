return {
  default = {
    terminal = "wezterm",
    scratchpad_terminal = "wezterm start --class spad",
    editor = os.getenv "EDITOR" or "editor",
    web_browser = "firefox",
    -- floating_file_explorer = "nautilus --class floating_file_explorer",
    floating_file_explorer = '',
    -- file_explorer = "nautilus",
  },
  run_on_start_up = {
    -- run compositor
    -- "picom --experimental-backends -b",

    -- setup my monitor positions
    -- "xrandr --output DP-2 --auto --output DP-4 --auto --right-of DP-2 --output HDMI-0 --auto --right-of DP-4",
  },
  util = {
    screenshot_directory = "~/Pictures/",
  },
}
