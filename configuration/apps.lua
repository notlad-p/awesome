return {
	default = {
		terminal = "alacritty",
		editor = os.getenv("EDITOR") or "editor",
		web_browser = "firefox",
	},
	run_on_start_up = {
		"picom --experimental-backends -b",
	},
}
