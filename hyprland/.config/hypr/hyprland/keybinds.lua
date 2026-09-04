local terminal = "alacritty"
local telegram = "telegram-desktop"
local fileManager = "alacritty msg create-window --command='yazi'"
local fileManagerUI = "nautilus"
local monitor = "alacritty msg create-window --command='btop'"
local note = "obsidian"
local browser = "google-chrome-stable"
local spotify = browser .. " --app=https://open.spotify.com"
local ai = browser .. " --app=https://chat.qwen.ai"

local launcher = "noctalia msg panel-open launcher"
local calculator = "noctalia msg panel-toggle launcher /calc"
local emojiToggle = "noctalia msg panel-toggle launcher /emo"
local windows = "noctalia msg panel-toggle launcher /win"
local session = "noctalia msg panel-toggle launcher /session"
local controlCenter = "noctalia msg panel-toggle control-center"
local settings = "noctalia msg settings-toggle"
local lock = "noctalia msg session lock"
local windowSwitcher = "noctalia msg window-switcher"
local clipboardHistory = "noctalia msg panel-open clipboard"
local vpn = "throne"
local volumeUp = "noctalia msg volume-up 10"
local volumeDown = "noctalia msg volume-down 10"
local brightnessUp = "noctalia msg brightness-up 1"
local brightnessDown = "noctalia msg brightness-down 1"

local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local secondMod = "SUPER + SHIFT" -- Sets "Windows" + "SHIFT" key as second modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(launcher))
hl.bind(secondMod .. " + Space", hl.dsp.exec_cmd(controlCenter))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(vpn))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(clipboardHistory))
hl.bind(secondMod .. " + C", hl.dsp.exec_cmd(calculator))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(session))
hl.bind(mainMod .. " + Comma", hl.dsp.exec_cmd(monitor))
hl.bind(mainMod .. " + Period", hl.dsp.exec_cmd(emojiToggle))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(settings))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(windows))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd(lock))

hl.bind(mainMod .. " + KP_Add", hl.dsp.exec_cmd(volumeUp))
hl.bind(mainMod .. " + KP_Subtract", hl.dsp.exec_cmd(volumeDown))
hl.bind(secondMod .. " + KP_Add", hl.dsp.exec_cmd(brightnessUp))
hl.bind(secondMod .. " + KP_Subtract", hl.dsp.exec_cmd(brightnessDown))

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(secondMod .. " + T", hl.dsp.exec_cmd(telegram))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(secondMod .. " + E", hl.dsp.exec_cmd(fileManagerUI))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(note))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(ai))
hl.bind(secondMod .. " + M", hl.dsp.exec_cmd(spotify))
hl.bind("ALT + TAB", hl.dsp.exec_cmd(windowSwitcher))

-- hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(secondMod .. " + V", hl.dsp.layout("togglesplit")) -- dwindle only

local function workspaceIsScrolling()
	return hl.get_active_workspace().tiled_layout == "scrolling"
end

hl.bind(mainMod .. " + l", function()
	if workspaceIsScrolling() then
		hl.dispatch(hl.dsp.layout("focus r"))
	else
		hl.dispatch(hl.dsp.focus({ direction = "right" }))
	end
end)

hl.bind(mainMod .. " + h", function()
	if workspaceIsScrolling() then
		hl.dispatch(hl.dsp.layout("focus l"))
	else
		hl.dispatch(hl.dsp.focus({ direction = "left" }))
	end
end)

local function workspaceIsMonocle()
	return hl.get_active_workspace().tiled_layout == "monocle"
end

hl.bind(mainMod .. " + j", function()
	if workspaceIsMonocle() then
		hl.dispatch(hl.dsp.layout("cyclenext"))
	else
		hl.dispatch(hl.dsp.focus({ direction = "down" }))
	end
end)

hl.bind(mainMod .. " + k", function()
	if workspaceIsMonocle() then
		hl.dispatch(hl.dsp.layout("cycleprev"))
	else
		hl.dispatch(hl.dsp.focus({ direction = "up" }))
	end
end)

-- Move window  with secondMod + arrow keys
hl.bind(secondMod .. " + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(secondMod .. " + j", hl.dsp.window.move({ direction = "down" }))

hl.bind(secondMod .. " + l", function()
	if workspaceIsScrolling() then
		hl.dispatch(hl.dsp.layout("swapcol r"))
	else
		hl.dispatch(hl.dsp.window.move({ direction = "right" }))
	end
end)

hl.bind(secondMod .. " + h", function()
	if workspaceIsScrolling() then
		hl.dispatch(hl.dsp.layout("swapcol l"))
	else
		hl.dispatch(hl.dsp.window.move({ direction = "left" }))
	end
end)

-- Toggle window maximization
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = "maximized" }))
-- toggle floating
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(secondMod .. " + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + D", hl.dsp.workspace.toggle_special("magic"))
hl.bind(secondMod .. " + D", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + bracketright", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + bracketleft", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(secondMod .. " + bracketright", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(secondMod .. " + bracketleft", hl.dsp.window.move({ workspace = "e-1" }))

hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'))
hl.bind("SUPER + Print", hl.dsp.exec_cmd('grim -g "$(slurp -d)" - | wl-copy'))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.dsp.window.resize()
-- Resize right (increase width)
hl.bind(mainMod .. " + Right", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 10 0"))

-- Resize left (decrease width)
hl.bind(mainMod .. " + Left", hl.dsp.exec_cmd("hyprctl dispatch resizeactive -10 0"))

-- Resize up (decrease height)
hl.bind(mainMod .. " + Up", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 -10"))

-- Resize down (increase height)
hl.bind(mainMod .. " + Down", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 10"))
-- Submaps

-- power binds
hl.bind(secondMod .. " + P", hl.dsp.submap("⏻"))

hl.define_submap("⏻", function()
	-- sleep
	hl.bind("s", function()
		hl.dispatch(hl.dsp.exec_cmd("systemctl suspend"))
		hl.dispatch(hl.dsp.submap("reset"))
	end)

	-- shutdown
	hl.bind("p", hl.dsp.exec_cmd("hyprshutdown --post-cmd 'systemctl poweroff'"))

	-- reboot
	hl.bind("r", hl.dsp.exec_cmd("hyprshutdown --post-cmd 'systemctl reboot'"))

	-- logout
	hl.bind("SHIFT + l", hl.dsp.exec_cmd("hyprshutdown --post-cmd 'loginctl terminate-user $USER'"))

	-- Use `reset` to go back to the global submap
	hl.bind("escape", hl.dsp.submap("reset"))
end)

-- wallpaper binds
hl.bind(secondMod .. " + W", hl.dsp.submap(""))

hl.define_submap("", function()
	-- next wallpaper
	hl.bind("l", hl.dsp.exec_cmd("wpaperctl next"))

	-- previous wallpaper
	hl.bind("h", hl.dsp.exec_cmd("wpaperctl previous"))

	-- Use `reset` to go back to the global submap
	hl.bind("escape", hl.dsp.submap("reset"))
end)

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @default_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
