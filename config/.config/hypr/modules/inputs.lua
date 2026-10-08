-- Input module

hl.config({
    input = {
        kb_layout = "us,ru,ua",
        kb_options = "caps:none,grp:win_space_toggle",
        repeat_delay = 400,
        repeat_rate = 55,
        follow_mouse = 1,
        force_no_accel = false,
        accel_profile = "flat",

        touchpad = {
            natural_scroll = true,
            disable_while_typing = true,
            tap_to_click = true,
            clickfinger_behavior = true,
            scroll_factor = 0.4
        }
    }
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

local mice = {
    "logitech-pro-x-1",
    "logitech-pro-x-wireless-1"
}

for _, name in ipairs(mice) do
    hl.device({ name = name, sensitivity = -0.6, accel_profile = "flat" })
end