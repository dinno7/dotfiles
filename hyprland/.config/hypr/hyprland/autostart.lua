-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
hl.on("hyprland.start", function()
	hl.exec_cmd("noctalia")

	-- Core components (authentication, lock screen, notification daemon)
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("dbus-update-activation-environment --all")
	hl.exec_cmd("sleep 1 && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP") -- Some fix idk

	-- Audio
	hl.exec_cmd("playerctld daemon")

	-- Clipboard: history
	-- NOTE: only started when cliphist is installed (otherwise every copy would spawn a failing
	-- shell), and without the old `qs ... $qsConfig` call: `qs` is not used with noctalia and
	-- `$qsConfig` was never defined.
	hl.exec_cmd("command -v cliphist >/dev/null 2>&1 && wl-paste --type text --watch cliphist store")
	hl.exec_cmd("command -v cliphist >/dev/null 2>&1 && wl-paste --type image --watch cliphist store")

	-- Cursor
	hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 16")
end)
