# Hyprland Lua Configuration Architecture & Guide

Complete reference guide for the Hyprland v0.55+ native Lua configuration system, migrated following **Omarchy** architecture best practices and official Hyprland documentation recommendations.

---

## 1. Executive Summary

Hyprland v0.55+ introduces an integrated **Lua configuration engine** (`hl`). Hyprlang syntax is deprecated in favor of native, high-performance C++ Lua bindings.

### Key Omarchy Migration Enhancements

- **Modular `require()` System**: Replaced hardcoded `dofile()` paths with standard Lua module resolution via `package.path`.
- **Separation of Concerns**: Extracted input, devices, touchpad gestures, and autostart handlers into dedicated Omarchy-style configuration files (`input.lua`, `autostart.lua`).
- **Lua Language Server (`.luarc.json`)**: Configured library stubs (`/usr/share/hypr/stubs`) and diagnostic globals (`hl`, `o`) for IDE autocomplete without needing per-file diagnostic suppressions.
- **Native Dispatchers**: High-performance internal IPC bindings (`hl.dsp.*`) for window management, focus, workspace switching, and keybindings.

---

## 2. Documentation & Reference Links

Official Hyprland wiki resources and Omarchy configuration guides:

- **Start Here & Overview**: [https://wiki.hypr.land/Configuring/Start/](https://wiki.hypr.land/Configuring/Start/)
- **Input & Devices**: [https://wiki.hypr.land/Configuring/Basics/Variables/#input](https://wiki.hypr.land/Configuring/Basics/Variables/#input)
- **Touchpad Gestures**: [https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/](https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/)
- **Monitors Setup**: [https://wiki.hypr.land/Configuring/Basics/Monitors/](https://wiki.hypr.land/Configuring/Basics/Monitors/)
- **General Compositor Settings**: [https://wiki.hypr.land/Configuring/Basics/Variables/#general](https://wiki.hypr.land/Configuring/Basics/Variables/#general)
- **Window Decorations & Blur**: [https://wiki.hypr.land/Configuring/Basics/Variables/#decoration](https://wiki.hypr.land/Configuring/Basics/Variables/#decoration)
- **Animations Configuration**: [https://wiki.hypr.land/Configuring/Basics/Variables/#animations](https://wiki.hypr.land/Configuring/Basics/Variables/#animations)
- **Layouts & Aspect Ratios**: [https://wiki.hypr.land/Configuring/Basics/Variables/#layout](https://wiki.hypr.land/Configuring/Basics/Variables/#layout)
- **Scrolling Layout Guide**: [https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/](https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/)
- **Keybindings System (`hl.bind`)**: [https://wiki.hypr.land/Configuring/Basics/Binds/](https://wiki.hypr.land/Configuring/Basics/Binds/)
- **Window & Layer Rules**: [https://wiki.hypr.land/Configuring/Basics/Window-Rules/](https://wiki.hypr.land/Configuring/Basics/Window-Rules/)
- **Autostart Handlers**: [https://wiki.hypr.land/Configuring/Basics/Autostart/](https://wiki.hypr.land/Configuring/Basics/Autostart/)

---

## 3. Omarchy Modular Architecture & Directory Layout

`~/.config/hypr/` is structured as decoupled Lua modules loaded inside `hyprland.lua`:

```
~/.config/hypr/
├── hyprland.lua       # Main entry point; sets package.path & loads modules
├── monitors.lua       # Monitor output resolutions, position, scale, & GDK_SCALE
├── input.lua          # Keyboard layout, mouse accel, touchpad, & gestures
├── autostart.lua      # Startup processes via hl.on("hyprland.start")
├── keybindings.lua    # Shortcuts using hl.bind & hl.dsp dispatchers
├── windowrules.lua    # Window & layer rules (opacity, floating, blur)
├── animations.lua     # Animation curves & layer rule overrides
├── userprefs.lua      # User overrides (loaded last for update compatibility)
├── themes/            # Appearance themes (common, colors, theme)
└── .luarc.json        # Lua LS configuration with /usr/share/hypr/stubs
```

### Module Loading Pattern in `hyprland.lua`

```lua
-- Add ~/.config/hypr to Lua package path
package.path = os.getenv("HOME") .. "/.config/hypr/?.lua;" .. os.getenv("HOME") .. "/.config/hypr/?/init.lua;" .. package.path

-- Load modular configuration components
require("monitors")
require("input")
require("autostart")
require("animations")
require("keybindings")
require("windowrules")
require("themes.common")
require("userprefs")
```

---

## 4. Global `hl` API Sitemap

### Top-Level API Functions

- **`hl.monitor(opts)`**: Configures display monitors, resolution, refresh rate, position, scale, and transform.
- **`hl.env(key, value)`**: Sets environment variables (`GDK_SCALE`, `QT_QPA_PLATFORM`, etc.).
- **`hl.device(opts)`**: Configures per-device input settings (e.g. mouse sensitivity, flat accel profile).
- **`hl.gesture(opts)`**: Registers touchpad gesture handlers (e.g. 3-finger swipe for workspace).
- **`hl.bind(keys, dispatcher, opts)`**: Registers keybindings and mouse shortcuts.
- **`hl.unbind(keys)`**: Unbinds a key combination.
- **`hl.window_rule(opts)`**: Registers window rules (opacity, floating state, sizing, matching).
- **`hl.layer_rule(opts)`**: Registers layer rules (blur, ignore_alpha, etc.).
- **`hl.config(table)`**: Configures general settings (`input`, `general`, `decoration`, `dwindle`, `master`, `misc`, `xwayland`).
- **`hl.on(event, function)`**: Registers compositor event listeners (e.g. `hyprland.start`).
- **`hl.dsp` (Dispatchers Table)**:
  - `hl.dsp.focus({ direction / workspace })`
  - `hl.dsp.window.move({ workspace / direction, follow })`
  - `hl.dsp.window.swap({ direction })`
  - `hl.dsp.window.resize({ x, y, relative })`
  - `hl.dsp.window.float({ action })`
  - `hl.dsp.group.toggle() / prev() / next()`
  - `hl.dsp.workspace.toggle_special(name)`
  - `hl.dsp.exec_cmd(cmd)`

---

## 5. Module Configurations

### Monitor & Environment Setup (`monitors.lua`)

```lua
-- List monitors with: hyprctl monitors all
hl.monitor({ output = "eDP-1", mode = "2880x1800@60", position = "0x0", scale = "auto" })
```

### Input & Gestures (`input.lua`)

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
			clickfinger_behavior = true,
		},
	},
})

hl.device({ name = "epic mouse V1", sensitivity = -0.5 })
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
```

### Autostart Handler (`autostart.lua`)

```lua
hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
	hl.exec_cmd("dunst")
end)
```

---

## 6. Verification & Management Commands

### Verify Configuration Syntax

```bash
hyprland --config ~/.config/hypr/hyprland.lua --verify-config
```

### Reload Compositor Configuration

```bash
hyprctl reload
```

### Inspect Active Monitors & Keybindings

```bash
hyprctl monitors all
hyprctl binds -j | jq 'length'
```
