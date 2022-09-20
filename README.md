# Awesome WM config

### Details:

- **Application Launcher** - [Rofi](https://github.com/davatorium/rofi)

### Install

- Make sure the following packages are installed
  - scrot - for screenshots
  - nmcli - for toggling airplane mode, Bluetooth and Wi-Fi

### Configure

- Rename `configuration/sample-config.lua` to `configuration/config.lua` and fill out fields like API keys
- Customize profile picture by replacing `/theme/images/pfp.jpeg` and changing `theme.pfp` in `/theme/theme.lua`
  - Make sure the image is 70px by 70px for it to fit right
- The default apps like terminal and browser are located in the `configuration/apps.lua` file. Startup apps / commands are also in this file.

### Usage

- Screenshot buttons and key binds will have a pop-up to name the image
  - You can include the file type like `.jpeg` but if it's not provided `scrot` will default to `.PNG`
  - Use `Escape` or `Control c` to cancel the screenshot when the pop-up is visible
