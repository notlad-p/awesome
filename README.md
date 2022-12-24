# Awesome WM custom config

### Details:

- **Application Launcher** - [Rofi](https://github.com/davatorium/rofi)

### Install

- Make sure the following packages are installed
  - scrot - for screenshots
  - nmcli - for toggling airplane mode, Bluetooth and Wi-Fi
  - playerctl - for music player

### Configure

- Rename `configuration/sample-config.lua` to `configuration/config.lua` and fill out fields like API keys
- Customize profile picture by replacing `/theme/images/pfp.jpeg` and changing `theme.pfp` in `/theme/theme.lua`
  - Make sure the image is 70px by 70px for it to fit right
- The default apps like terminal and browser are located in the `configuration/apps.lua` file. Startup apps / commands are also in this file.

### Usage

- Screenshot buttons and key binds will have a pop-up to name the image
  - You can include the file type like `.jpeg` but if it's not provided `scrot` will default to `.PNG`
  - Use `Escape` or `Control c` to cancel the screenshot when the pop-up is visible

### Todo

- Finish `power_panel`: Lock, Logout, Suspend, Reboot, Shutdown buttons (use rofi lib for inspo / logic)
- Add logic for `weather_widget` to be optional if config is missing
- Fix uptime in `profile.lua` (use [rofi](https://github.com/adi1090x/rofi) lib for logic)
- Add config for lock screen command in `power-panel`

#### Docs todo

- How to change wallpaper / logout image
