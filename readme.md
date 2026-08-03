# Hyprland Lua Configuration Architecture & Guide

Complete reference guide for the Hyprland v0.55+ native Lua configuration system.

---

## 1. Executive Summary

Hyprland v0.55+ introduces an integrated **Lua configuration engine** (`hl`).

### Key Benefits

- **Native C++ Performance**: High-performance native C++ bindings for internal IPC dispatchers.
- **Dedicated Lua Helpers**: Top-level API methods (`hl.monitor`, `hl.env`, `hl.device`, `hl.window_rule`, `hl.layer_rule`, `hl.bind`, `hl.config`, `hl.on`, `hl.gesture`).
- **Modularity**: Clean `dofile()` imports across separate configuration files.

---

## 2. Global `hl` API Sitemap

### Top-Level API Functions

- **`hl.monitor(opts)`**:
  Configures display monitors, resolution, refresh rate, position, scale, and transform.
- **`hl.env(key, value)`**:
  Sets environment variables.
- **`hl.device(opts)`**:
  Configures per-device input settings (e.g. mouse sensitivity, touchpad options).
- **`hl.bind(keys, dispatcher, opts)`**:
  Registers keybindings and mouse shortcuts.
- **`hl.unbind(keys)`**:
  Unbinds a key combination.
- **`hl.window_rule(opts)`**:
  Registers window rules (opacity, floating state, sizing, etc.).
- **`hl.layer_rule(opts)`**:
  Registers layer rules (blur, ignore_alpha, etc.).
- **`hl.gesture(opts)`**:
  Registers touchpad gesture handlers.
- **`hl.config(table)`**:
  Configures general settings (`input`, `general`, `decoration`, `dwindle`, `master`, `misc`, `xwayland`).
- **`hl.on(event, function)`**:
  Registers compositor event listeners (e.g. `hyprland.start`).
- **`hl.dsp` (Dispatchers Table)**:
  Contains structured dispatcher methods like `hl.dsp.focus()`, `hl.dsp.window.move()`, `hl.dsp.window.swap()`, and `hl.dsp.window.resize()`.

---

## 3. Monitor & Environment Setup (`hl.monitor` & `hl.env`)

### Monitor Configuration

```lua
hl.monitor({ output = "eDP-1", mode = "2880x1800@60", position = "0x0", scale = "auto" })
```

### Environment Variables

```lua
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
```

---

## 4. General Settings (`hl.config`)

```lua
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
            clickfinger_behavior = true
        }
    },
    general = {
        gaps_in = 0,
        gaps_out = 0,
        border_size = 0,
        layout = "dwindle"
    }
})
```

---

## 5. Keybinding System (`hl.bind`)

### Workspace Navigation & Application Movement

```lua
-- Focus workspace 1..10
hl.bind("SUPER + 1", hl.dsp.focus({ workspace = "1" }), { description = "Workspace 1" })

-- Move active window to workspace 1..10
hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = "1" }), { description = "Move to Workspace 1" })

-- Move active window silently to workspace 1..10
hl.bind("SUPER + ALT + 1", hl.dsp.window.move({ workspace = "1", follow = false }), { description = "Move to Workspace 1 (Silent)" })
```

### Window Focus, Swapping, and Resizing

```lua
-- Window focus navigation (Meta + Arrow Keys)
hl.bind("SUPER + LEFT", hl.dsp.focus({ direction = "l" }), { description = "focus left" })
hl.bind("SUPER + RIGHT", hl.dsp.focus({ direction = "r" }), { description = "focus right" })

-- Window position swapping (Meta + Shift + Arrow Keys)
hl.bind("SUPER + SHIFT + LEFT", hl.dsp.window.swap({ direction = "l" }), { description = "swap left" })
hl.bind("SUPER + SHIFT + RIGHT", hl.dsp.window.swap({ direction = "r" }), { description = "swap right" })

-- Window resizing (Meta + Shift + Ctrl + Arrow Keys)
hl.bind("SUPER + SHIFT + CTRL + RIGHT", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeat_press = true, description = "resize right" })
```

---

## 6. Window Rules & Layer Rules (`hl.window_rule` & `hl.layer_rule`)

### Window Rules

```lua
hl.window_rule({ opacity = "0.90 0.90", match = "class:^(firefox)$" })
hl.window_rule({ float = true, match = "class:^(vlc)$" })
```

### Layer Rules

```lua
hl.layer_rule({ blur = true, ignore_alpha = 0, match = "namespace:rofi" })
hl.layer_rule({ blur = true, match = "namespace:logout_dialog" })
```

---

## 7. Event Handlers (`hl.on`)

### Autostart Handler

```lua
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("dunst")
end)
```

---

## 8. Verification Commands

### Verification & Reload

```bash
hyprland --config ~/.config/hypr/hyprland.lua --verify-config
```

```bash
hyprctl reload
```

```bash
hyprctl monitors
```

```bash
hyprctl binds -j | jq 'length'
```
