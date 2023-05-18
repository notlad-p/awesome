local bling = require "module.bling"
local apps_config = require "configuration.apps"
local awful = require "awful"

-- TODO: file explorer bind to "SUPER + e"
-- TODO: change keybind to "SUPER + \"

-- width & height of scratchpad client
local width = 900
local height = 500
-- calculate center of screen for client
local x = awful.screen.focused().geometry.width / 2 - width / 2
local y = awful.screen.focused().geometry.height / 2 - height / 2

local term_scratch = bling.module.scratchpad {
  command = apps_config.default.scratchpad_terminal, -- How to spawn the scratchpad
  rule = { instance = "spad" }, -- The rule that the scratchpad will be searched by
  sticky = true, -- Whether the scratchpad should be sticky
  autoclose = true, -- Whether it should hide itself when losing focus
  floating = true, -- Whether it should be floating (MUST BE TRUE FOR ANIMATIONS)
  -- geometry = { x = 360, y = 90, height = 900, width = 1200 }, -- The geometry in a floating state
  geometry = { height = height, width = width },
  -- geometry = { x = x, y = y, height = height, width = width },
  reapply = true, -- Whether all those properties should be reapplied on every new opening of the scratchpad (MUST BE TRUE FOR ANIMATIONS)
  dont_focus_before_close = false, -- When set to true, the scratchpad will be closed by the toggle function regardless of whether its focused or not. When set to false, the toggle function will first bring the scratchpad into focus and only close it on a second call
  placement = 'center'
  -- rubato = { x = anim_x, y = anim_y }, -- Optional. This is how you can pass in the rubato tables for animations. If you don't want animations, you can ignore this option.
}

return term_scratch
