-- See https://wiki.hypr.land/Configuring/Basics/Variables/#animations
-- This file can be edited manually or use animation selector to select animations

-- Disable animations while in hyprpicker and selection screenshot
hl.dsp.exec_raw("layerrule = no_anim on, match:namespace hyprpicker")
hl.dsp.exec_raw("layerrule = no_anim on, match:namespace selection")

require("animations.animations-optimized")
