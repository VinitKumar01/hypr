---@diagnostic disable: undefined-global
--  P̳r̳a̳s̳a̳n̳t̳h̳ R̳a̳n̳g̳a̳n̳

hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme 'Tela-circle-purple'")
hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Tokyo-Night'")
hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")

hl.config({
    general = {
        gaps_in = 0,
        gaps_out = 0,
        border_size = 0,
        layout = "dwindle",
        resize_on_border = true,
        col = {
            active_border = { colors = { "rgba(90ceaaff)", "rgba(ecd3a0ff)" }, angle = 45 },
            inactive_border = { colors = { "rgba(86aaeccc)", "rgba(93cee9cc)" }, angle = 45 }
        }
    },
    group = {
        col = {
            border_active = { colors = { "rgba(90ceaaff)", "rgba(ecd3a0ff)" }, angle = 45 },
            border_inactive = { colors = { "rgba(86aaeccc)", "rgba(93cee9cc)" }, angle = 45 },
            border_locked_active = { colors = { "rgba(90ceaaff)", "rgba(ecd3a0ff)" }, angle = 45 },
            border_locked_inactive = { colors = { "rgba(86aaeccc)", "rgba(93cee9cc)" }, angle = 45 }
        }
    },
    decoration = {
        rounding = 8,
        shadow = {
            enabled = false
        },
        blur = {
            enabled = true,
            size = 5,
            passes = 4,
            new_optimizations = true,
            ignore_opacity = true,
            xray = false
        }
    }
})
