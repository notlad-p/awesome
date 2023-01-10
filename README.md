# Work in progress AwesomeWM config

This config is a work in progress and will look like the below images when finished.

![home](https://user-images.githubusercontent.com/54220748/211547530-f673afa3-c5f9-4b48-9618-039b75a0f787.jpg)

![toggle panel](https://user-images.githubusercontent.com/54220748/211547601-cb37cdd5-0f78-4aae-8660-49010c870e00.jpg)

### Details:

- AwesomeWM API docs - [AwesomeWM](https://awesomewm.org/apidoc/)
- **Application Launcher** - [Rofi](https://github.com/davatorium/rofi)

### Install

- You will need to install the latest [awesomewm-git](https://github.com/awesomeWM/awesome) version
- Make sure the following packages are installed
  - scrot - for screenshots
  - nmcli - for toggling airplane mode, Bluetooth and Wi-Fi
  - playerctl - for music player

### Configure

- Rename `configuration/sample-config.lua` to `configuration/config.lua` and fill out fields like API keys
- Customize profile picture by replacing `/theme/images/pfp.jpeg` and changing `theme.pfp` in `/theme/theme.lua`
  - Make sure the image is 70px by 70px for it to fit right
- The default apps like terminal and browser are located in the `configuration/apps.lua` file. Startup apps / commands are also in this file.
- You can change the color scheme using the `colorscheme` variable in `theme/theme.lua`

### Usage

- Screenshot buttons and key binds will have a pop-up to name the image
  - You can include the file type like `.jpeg` but if it's not provided `scrot` will default to `.PNG`
  - Use `Escape` or `Control c` to cancel the screenshot when the pop-up is visible

### Todo

- Add logic for `weather_widget` to be optional if config is missing
- Fix uptime in `profile.lua` (use [rofi](https://github.com/adi1090x/rofi) lib for logic)
- Add config for lock screen command in `power-panel`
- Add 'run' widget for running quick commmands
  - https://github.com/streetturtle/awesome-wm-widgets/tree/master/run-shell-3
- Add 'to do' widget / panel - [todo-widget](https://github.com/streetturtle/awesome-wm-widgets/tree/master/todo-widget)
- Finish toggle panel:
  - Music widget
  - Sliders - fix volume being displayed at 0 on startup
- Add theme switcher / ability to change theme from .Xresources
- Add animations with [rubato](https://github.com/andOrlando/rubato)

### Inspiration:

- [stardust-kyun/dotfiles](https://github.com/Stardust-kyun/dotfiles)
- [rxyhn/yoru](https://github.com/rxyhn/yoru)
