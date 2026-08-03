-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Add ~/.config/hypr to Lua package path for modular require loading
package.path = os.getenv("HOME") .. "/.config/hypr/?.lua;" .. os.getenv("HOME") .. "/.config/hypr/?/init.lua;" .. package.path

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

-- Load modular configuration components via require
require("monitors")
require("input")
require("autostart")
require("animations")
require("keybindings")
require("windowrules")
require("themes.common")
require("themes.theme")
require("themes.colors")
require("userprefs")
