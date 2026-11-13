-- Autostart processes (runs once on compositor startup)
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

local scrPath = os.getenv("HOME") .. "/.local/share/bin"

hl.on("hyprland.start", function()
	hl.exec_cmd(
		"rclone mount gdrive-main: ~/gdrive-main --daemon --vfs-cache-mode full --vfs-cache-max-size 20G --vfs-cache-max-age 48h --vfs-read-chunk-size 128M --vfs-read-chunk-size-limit 2G --vfs-read-ahead 256M --buffer-size 64M --dir-cache-time 1000h --tpslimit 10 --tpslimit-burst 10 --no-modtime --timeout 1m --contimeout 15s --low-level-retries 3 --retries 3 --log-file=/tmp/rclone.log --log-level ERROR"
	)
	hl.exec_cmd(scrPath .. "/resetxdgportal.sh")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("dbus-update-activation-environment --systemd --all")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd(scrPath .. "/polkitkdeauth.sh")
	hl.exec_cmd("waybar")
	hl.exec_cmd("blueman-applet")
	hl.exec_cmd("udiskie --no-automount --smart-tray")
	hl.exec_cmd("nm-applet --indicator")
	hl.exec_cmd("dunst")
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	hl.exec_cmd(scrPath .. "/swwwallpaper.sh")
	hl.exec_cmd(scrPath .. "/batterynotify.sh")
	hl.exec_cmd("gammastep -O 4500")
end)
