return {
	default = {
		terminal = "alacritty",
		editor = os.getenv("EDITOR") or "editor",
		web_browser = "firefox",
	},
	run_on_start_up = {
		"picom --experimental-backends -b",
		-- setup my monitor positions
		"xrandr --output DP-2 --auto --output DP-4 --auto --right-of DP-2 --output HDMI-0 --auto --right-of DP-4",
	},
}
