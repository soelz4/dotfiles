-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- Configures the Window Size
config.initial_cols = 114
config.initial_rows = 28

-- For example, changing the Color Scheme:
config.color_scheme = "Wez"

-- Font
config.font = wezterm.font("Lilex Nerd Font")
config.font_size = 14.0

-- Padding
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- Scroll Bar
config.enable_scroll_bar = false

-- Frame - Tab Bar
-- Disable or Enable Tab Bar
config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
-- Fancy Tab Bar Colors
config.window_frame = {
  inactive_titlebar_bg = "#353535",
  active_titlebar_bg = "#2b2042",
  inactive_titlebar_fg = "#cccccc",
  active_titlebar_fg = "#ffffff",
  inactive_titlebar_border_bottom = "#2b2042",
  active_titlebar_border_bottom = "#2b2042",
  button_fg = "#cccccc",
  button_bg = "#2b2042",
  button_hover_fg = "#ffffff",
  button_hover_bg = "#3b3052",
}

-- and finally, return the configuration to wezterm
return config
