return {
	default = {
		terminal = "wezterm",
		editor = os.getenv("EDITOR") or "editor",
		web_browser = "firefox",
	},
	run_on_start_up = {
		-- https://askubuntu.com/questions/1170247/how-do-i-solve-screen-tearing-on-ubuntu-18-04-with-nvidia
		-- TODO: Add tutorial above to solve nvidia screen tearing
		-- TODO: USE ASYNC SHELL? (won't work with normal shell)
		-- "\"$(xrandr | sed -nr '/(S+) connected (primary )?([0-9]+x[0-9]+)(+S+).*/{ s//\1: \3 \4 { ForceFullCompositionPipeline = On }, /; H}; ${ g; s/\n//g; s/, $//; p }')\"",
		"picom --experimental-backends -b",
		-- setup my monitor positions
		"xrandr --output DP-2 --auto --output DP-4 --auto --right-of DP-2 --output HDMI-0 --auto --right-of DP-4",
	},
	util = {
		screenshot_directory = "~/Pictures/",
	},
}
