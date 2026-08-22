---@diagnostic disable: undefined-global
--  Matte Aged Parchment & Dusty Vellum for Hyprland

-- Interface & GTK settings
hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme 'Tela-circle-purple'")
hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Tokyo-Night'")
hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")

-- Layer rules for Waybar blur
hl.exec_cmd("hyprctl keyword layerrule 'blur, waybar'")
hl.exec_cmd("hyprctl keyword layerrule 'ignorezero, waybar'")
hl.exec_cmd("hyprctl keyword layerrule 'ignorealpha 0.5, waybar'")

hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 8,
		border_size = 1,
		layout = "dwindle",
		resize_on_border = true,
		col = {
			-- Active: Matte unbleached paper (#dcd3be) to dusty weathered vellum (#a89984)
			active_border = { colors = { "rgba(dcd3beff)", "rgba(a89984ff)" }, angle = 45 },
			-- Inactive: Subdued gunmetal (#1a1e23) to faded slate (#38414e)
			inactive_border = { colors = { "rgba(1a1e23cc)", "rgba(38414e66)" }, angle = 45 },
		},
	},
	group = {
		col = {
			border_active = { colors = { "rgba(dcd3beff)", "rgba(a89984ff)" }, angle = 45 },
			border_inactive = { colors = { "rgba(1a1e23cc)", "rgba(38414e66)" }, angle = 45 },
			-- Locked: Muted terracotta (#c8824a) to dusty parchment (#a89984)
			border_locked_active = { colors = { "rgba(c8824acc)", "rgba(a89984cc)" }, angle = 45 },
			border_locked_inactive = { colors = { "rgba(1a1e23cc)", "rgba(38414e66)" }, angle = 45 },
		},
	},
	decoration = {
		rounding = 0,
		shadow = {
			enabled = false,
		},
		blur = {
			enabled = true,
			size = 6,
			passes = 3,
			new_optimizations = true,
			ignore_opacity = true,
			xray = false,
		},
	},
})
