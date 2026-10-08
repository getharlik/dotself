-- Keybind module
local vars = require("modules/vars")

local mod = vars.mainMod
local function key(k) return mod .. " + " .. k end
local exec = hl.dsp.exec_cmd

-- Main binds
hl.bind(key("Q"),         exec(vars.terminal))
hl.bind(key("C"),         hl.dsp.window.close())
hl.bind(key("E"),         exec(vars.fileManager))
hl.bind(key("T"),         exec(vars.editor))
hl.bind(key("V"),         hl.dsp.window.float({ action = "toggle" }))
hl.bind(key("R"),         exec(vars.menu))
hl.bind(key("L"),         exec("hyprlock"))
hl.bind(key("F"),         exec(vars.home .. "/Scripts/wall-select.sh"))
hl.bind(key("P"),         exec("hyprpicker -a -n"))
hl.bind(key("F11"),       hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(key("Backspace"), exec("hyprshot -m region -o ".. vars.home .. "/Assets/Screenshots/ -z"))


-- Move/resize windows
hl.bind(key("mouse:272"), hl.dsp.window.drag(),   { mouse = true })
hl.bind(key("mouse:273"), hl.dsp.window.resize(), { mouse = true })


-- Media keys
local media = { locked = true, repeating = true }
hl.bind("XF86AudioRaiseVolume", exec("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), media)
hl.bind("XF86AudioLowerVolume", exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), media)
hl.bind("XF86AudioMute",        exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })

hl.bind("XF86KbdBrightnessUp",  exec("brightnessctl -d '*::kbd_backlight' set +25%"), media)
hl.bind("XF86KbdBrightnessDown",exec("brightnessctl -d '*::kbd_backlight' set 25%-"), media)
hl.bind("XF86MonBrightnessUp",  exec("brightnessctl s +5%"), media)
hl.bind("XF86MonBrightnessDown",exec("brightnessctl s 5%-"), media)

hl.bind("XF86AudioNext",        exec("playerctl next"), { locked = true })
hl.bind("XF86AudioPause",       exec("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",        exec("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",        exec("playerctl previous"), { locked = true })


-- Move focus & Switch/move to workspace
for _, dir in ipairs({ "left", "right", "up", "down" }) do
    hl.bind(key(dir), hl.dsp.focus({ direction = dir }))
end

for i = 1, 6 do
    hl.bind(key(i), hl.dsp.focus({ workspace = i }))
    hl.bind(key("SHIFT + " .. i), hl.dsp.window.move({ workspace = i }))
end