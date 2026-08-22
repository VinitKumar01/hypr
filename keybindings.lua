-- See https://wiki.hypr.land/Configuring/Basics/Binds/

local mainMod = "SUPER"
local scrPath = os.getenv("HOME") .. "/.local/share/bin"

local term = "kitty"
local file = "dolphin"
local browser = 'brave --ozone-platform=wayland --password-store=kwallet --profile-directory="Default"'
local burp = "/home/vinit/BurpSuiteCommunity/BurpSuiteCommunity"

-- Window/Session actions
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hyprpicker -a"), { description = "Color Picker" })
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(scrPath .. "/dontkillsteam.sh"), { description = "close focused window" })
hl.bind("ALT + F4", hl.dsp.exec_cmd(scrPath .. "/dontkillsteam.sh"), { description = "close focused window" })
hl.bind(mainMod .. " + DELETE", hl.dsp.exit(), { description = "kill hyprland session" })
hl.bind(mainMod .. " + Q", hl.dsp.window.float({ action = "toggle" }), { description = "toggle floating" })
hl.bind(mainMod .. " + G", hl.dsp.group.toggle(), { description = "toggle group" })
hl.bind("ALT + RETURN", hl.dsp.window.fullscreen(), { description = "toggle fullscreen" })
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("swaylock"), { description = "launch lock screen" })
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd(scrPath .. "/windowpin.sh"), { description = "toggle pin" })
hl.bind(
	mainMod .. " + BACKSPACE",
	hl.dsp.exec_cmd(scrPath .. "/logoutlaunch.sh"),
	{ description = "launch logout menu" }
)
hl.bind(
	"CTRL + ALT + W",
	hl.dsp.exec_cmd("killall waybar || (env reload_flag=1 " .. scrPath .. "/wbarconfgen.sh)"),
	{ description = "toggle waybar" }
)

-- Application shortcuts
hl.bind("ALT + T", hl.dsp.exec_cmd(term), { description = "launch terminal" })
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(file), { description = "launch file manager" })
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser), { description = "launch web browser" })
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd(burp), { description = "launch burp suite" })
hl.bind(
	"CTRL + SHIFT + ESCAPE",
	hl.dsp.exec_cmd(scrPath .. "/sysmonlaunch.sh"),
	{ description = "launch system monitor" }
)

-- Rofi menus
hl.bind(
	"ALT + SPACE",
	hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/rofilaunch.sh d"),
	{ description = "launch app launcher" }
)
hl.bind(
	mainMod .. " + TAB",
	hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/rofilaunch.sh w"),
	{ description = "launch window switcher" }
)
hl.bind(
	mainMod .. " + SHIFT + E",
	hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/rofilaunch.sh f"),
	{ description = "launch file explorer" }
)

-- Audio control
hl.bind("F10", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o m"), { lock = true, description = "toggle audio mute" })
hl.bind(
	"F11",
	hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o d"),
	{ repeat_press = true, lock = true, description = "decrease volume" }
)
hl.bind(
	"F12",
	hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o i"),
	{ repeat_press = true, lock = true, description = "increase volume" }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o m"),
	{ lock = true, description = "toggle audio mute" }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -i m"),
	{ lock = true, description = "toggle mic mute" }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o d"),
	{ repeat_press = true, lock = true, description = "decrease volume" }
)
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o i"),
	{ repeat_press = true, lock = true, description = "increase volume" }
)

-- Media control
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { lock = true, description = "play/pause" })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { lock = true, description = "play/pause" })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { lock = true, description = "next track" })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { lock = true, description = "prev track" })

-- Brightness control
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd(scrPath .. "/brightnesscontrol.sh i"),
	{ repeat_press = true, lock = true, description = "increase brightness" }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd(scrPath .. "/brightnesscontrol.sh d"),
	{ repeat_press = true, lock = true, description = "decrease brightness" }
)

-- Move between grouped windows
hl.bind(mainMod .. " + CTRL + H", hl.dsp.group.prev(), { description = "group prev" })
hl.bind(mainMod .. " + CTRL + L", hl.dsp.group.next(), { description = "group next" })

-- Screenshot / Screencapture
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(scrPath .. "/screenshot.sh s"), { description = "partial screenshot" })
hl.bind(
	mainMod .. " + CTRL + P",
	hl.dsp.exec_cmd(scrPath .. "/screenshot.sh sf"),
	{ description = "partial screenshot (frozen)" }
)
hl.bind(mainMod .. " + ALT + P", hl.dsp.exec_cmd(scrPath .. "/screenshot.sh m"), { description = "monitor screenshot" })
hl.bind("PRINT", hl.dsp.exec_cmd(scrPath .. "/screenshot.sh p"), { description = "all monitors screenshot" })

-- Custom scripts
hl.bind(mainMod .. " + ALT + G", hl.dsp.exec_cmd(scrPath .. "/gamemode.sh"), { description = "toggle gamemode" })
hl.bind(
	mainMod .. " + ALT + RIGHT",
	hl.dsp.exec_cmd(scrPath .. "/swwwallpaper.sh -n"),
	{ description = "next wallpaper" }
)
hl.bind(
	mainMod .. " + ALT + LEFT",
	hl.dsp.exec_cmd(scrPath .. "/swwwallpaper.sh -p"),
	{ description = "previous wallpaper" }
)
hl.bind(mainMod .. " + ALT + UP", hl.dsp.exec_cmd(scrPath .. "/wbarconfgen.sh n"), { description = "next waybar mode" })
hl.bind(
	mainMod .. " + ALT + DOWN",
	hl.dsp.exec_cmd(scrPath .. "/wbarconfgen.sh p"),
	{ description = "previous waybar mode" }
)
hl.bind(
	mainMod .. " + SHIFT + R",
	hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/wallbashtoggle.sh -m"),
	{ description = "wallbash mode menu" }
)
hl.bind(
	mainMod .. " + SHIFT + T",
	hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/themeselect.sh"),
	{ description = "theme select menu" }
)
hl.bind(
	mainMod .. " + SHIFT + A",
	hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/rofiselect.sh"),
	{ description = "rofi select menu" }
)
hl.bind(
	mainMod .. " + SHIFT + X",
	hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/themestyle.sh"),
	{ description = "theme style menu" }
)
hl.bind(
	mainMod .. " + SHIFT + W",
	hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/swwwallselect.sh"),
	{ description = "wallpaper select menu" }
)
hl.bind(
	mainMod .. " + V",
	hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/cliphist.sh c"),
	{ description = "launch clipboard" }
)
hl.bind(
	mainMod .. " + SHIFT + V",
	hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/cliphist.sh"),
	{ description = "launch clipboard manager" }
)
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd(scrPath .. "/keyboardswitch.sh"), { description = "switch keyboard layout" })
hl.bind(
	mainMod .. " + SLASH",
	hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/keybinds_hint.sh c"),
	{ description = "launch keybinds hint" }
)
hl.bind(
	mainMod .. " + ALT + A",
	hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/animations.sh"),
	{ description = "launch animations manager" }
)

-- Move/Change window focus
hl.bind(mainMod .. " + LEFT", hl.dsp.focus({ direction = "l" }), { description = "focus left" })
hl.bind(mainMod .. " + RIGHT", hl.dsp.focus({ direction = "r" }), { description = "focus right" })
hl.bind(mainMod .. " + UP", hl.dsp.focus({ direction = "u" }), { description = "focus up" })
hl.bind(mainMod .. " + DOWN", hl.dsp.focus({ direction = "d" }), { description = "focus down" })
hl.bind("ALT + TAB", hl.dsp.window.cycle_next(), { description = "focus next window" })

-- Swap window position within workspace
hl.bind(mainMod .. " + SHIFT + LEFT", hl.dsp.window.swap({ direction = "l" }), { description = "swap window left" })
hl.bind(mainMod .. " + SHIFT + RIGHT", hl.dsp.window.swap({ direction = "r" }), { description = "swap window right" })
hl.bind(mainMod .. " + SHIFT + UP", hl.dsp.window.swap({ direction = "u" }), { description = "swap window up" })
hl.bind(mainMod .. " + SHIFT + DOWN", hl.dsp.window.swap({ direction = "d" }), { description = "swap window down" })

-- Workspaces
for i = 1, 10 do
	local key = tostring(i % 10)

	-- Switch workspace: SUPER + [1-0]
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = tostring(i) }), { description = "Workspace " .. i })

	-- Move window to workspace: SUPER + SHIFT + [1-0]
	hl.bind(
		mainMod .. " + SHIFT + " .. key,
		hl.dsp.window.move({ workspace = tostring(i) }),
		{ description = "Move to Workspace " .. i }
	)

	-- Move window to workspace silent: SUPER + ALT + [1-0]
	hl.bind(
		mainMod .. " + ALT + " .. key,
		hl.dsp.window.move({ workspace = tostring(i), follow = false }),
		{ description = "Move to Workspace " .. i .. " (Silent)" }
	)
end

-- Relative workspace switching
hl.bind(mainMod .. " + CTRL + RIGHT", hl.dsp.focus({ workspace = "r+1" }), { description = "Workspace r+1" })
hl.bind(mainMod .. " + CTRL + LEFT", hl.dsp.focus({ workspace = "r-1" }), { description = "Workspace r-1" })
hl.bind(mainMod .. " + CTRL + DOWN", hl.dsp.focus({ workspace = "empty" }), { description = "Workspace empty" })

-- Resize active window
hl.bind(
	mainMod .. " + SHIFT + CTRL + RIGHT",
	hl.dsp.window.resize({ x = 30, y = 0, relative = true }),
	{ repeat_press = true, description = "resize right" }
)
hl.bind(
	mainMod .. " + SHIFT + CTRL + LEFT",
	hl.dsp.window.resize({ x = -30, y = 0, relative = true }),
	{ repeat_press = true, description = "resize left" }
)
hl.bind(
	mainMod .. " + SHIFT + CTRL + UP",
	hl.dsp.window.resize({ x = 0, y = -30, relative = true }),
	{ repeat_press = true, description = "resize up" }
)
hl.bind(
	mainMod .. " + SHIFT + CTRL + DOWN",
	hl.dsp.window.resize({ x = 0, y = 30, relative = true }),
	{ repeat_press = true, description = "resize down" }
)

-- Move focused window to a relative workspace
hl.bind(
	mainMod .. " + CTRL + ALT + RIGHT",
	hl.dsp.window.move({ workspace = "r+1" }),
	{ description = "move workspace r+1" }
)
hl.bind(
	mainMod .. " + CTRL + ALT + LEFT",
	hl.dsp.window.move({ workspace = "r-1" }),
	{ description = "move workspace r-1" }
)

-- Scroll through existing workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Workspace e+1" })
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }), { description = "Workspace e-1" })

-- Move/Resize focused window with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move window" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window" })
hl.bind(mainMod .. " + Z", hl.dsp.window.drag(), { mouse = true, description = "Move window mode" })
hl.bind(mainMod .. " + X", hl.dsp.window.resize(), { mouse = true, description = "Resize window mode" })

-- Move/Switch to special workspace (scratchpad)
hl.bind(
	mainMod .. " + ALT + S",
	hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }),
	{ description = "move special" }
)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("scratchpad"), { description = "toggle special" })

-- Toggle focused window split
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"), { description = "toggle split" })
