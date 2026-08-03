---@diagnostic disable: undefined-global
-- Hyprland Main Lua Config
local confDir = os.getenv("HOME") .. "/.config/hypr"
local scrPath = os.getenv("HOME") .. "/.local/share/bin"

-- Environment variables
hl.env("PATH", (os.getenv("PATH") or "") .. ":" .. scrPath)
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("GDK_SCALE", "1")

-- General compositor configuration
hl.config({
	input = {
		kb_layout = "us",
		follow_mouse = 1,
		sensitivity = 0,
		repeat_rate = 40,
		repeat_delay = 250,
		numlock_by_default = true,
		touchpad = {
			natural_scroll = true,
			scroll_factor = 1.0,
			clickfinger_behavior = true,
		},
	},
	dwindle = {
		preserve_split = true,
	},
	master = {
		new_status = "master",
	},
	misc = {
		vrr = 0,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		force_default_wallpaper = 0,
	},
	xwayland = {
		force_zero_scaling = true,
	},
})

-- Device overrides
hl.device({
	name = "epic mouse V1",
	sensitivity = -0.5,
})

-- Autostart (runs once on compositor startup)
hl.on("hyprland.start", function()
	hl.exec_cmd("rclone mount gdrive-main: ~/gdrive-main --daemon --vfs-cache-mode full")
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

-- Touchpad gesture
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Source modular lua files
dofile(confDir .. "/animations.lua")
dofile(confDir .. "/keybindings.lua")
dofile(confDir .. "/windowrules.lua")
dofile(confDir .. "/themes/common.lua")
dofile(confDir .. "/themes/theme.lua")
dofile(confDir .. "/themes/colors.lua")
dofile(confDir .. "/monitors.lua")
dofile(confDir .. "/userprefs.lua")
