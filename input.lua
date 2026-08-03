-- Learn how to configure input: https://wiki.hypr.land/Configuring/Basics/Variables/#input
-- Touchpad gestures: https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/

-- Input & Keyboard Configuration
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

-- Per-device input overrides
hl.device({
	name = "epic mouse V1",
	sensitivity = -0.5,
})

-- Touchpad gestures handler
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
