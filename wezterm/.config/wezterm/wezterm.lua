-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.
config.font = wezterm.font_with_fallback({ "Hack Nerd Font", "Vazir-Code", "Peyda", "Aria", "Vazirmatn" })

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 12.5
config.color_scheme = "Tokyo Night (Gogh)"
config.bidi_enabled = true
config.bidi_direction = "LeftToRight"
config.enable_tab_bar = false
-- config.hide_tab_bar_if_only_one_tab = true

-- Finally, return the configuration to wezterm:
return config
