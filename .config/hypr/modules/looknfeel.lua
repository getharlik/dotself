-- Look & feel module
local colors = require("modules/colors")

hl.config({
    general = {
        gaps_in     = 3,
        gaps_out    = 6,
        border_size = 1,

        col = {
            active_border = colors.color8,
            inactive_border = colors.color8,
        },
        resize_on_border = true
    },
    decoration = {
        rounding         = 18,
        rounding_power   = 4,
        inactive_opacity = 0.8,

        shadow = { enabled = false },

        blur = {
            size              = 3,
            passes            = 3,
            vibrancy          = 0.25,
            new_optimizations = true,
            xray              = false
        }
    },
    misc = {
        force_default_wallpaper    = 0,
        disable_hyprland_logo      = true,
        initial_workspace_tracking = 2
    },
    dwindle = { preserve_split = true },
    master = { new_status = "master" }
})