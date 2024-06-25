local wezterm = require 'wezterm'
local config = wezterm.config_builder()
config.window_background_opacity = 0.95
config.hide_tab_bar_if_only_one_tab = true
config.color_scheme = 'Catppuccin Mocha'
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.keys = {
  {key="LeftArrow", mods="OPT", action=wezterm.action{SendString="\x1bb"}},
  {key="RightArrow", mods="OPT", action=wezterm.action{SendString="\x1bf"}},
}
config.window_frame = {
  active_titlebar_bg = '#333333',
  inactive_titlebar_bg = '#333333',
}
config.colors = {
  tab_bar = {
    inactive_tab_edge = '#575757',
  }
}
return config

