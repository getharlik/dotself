-- Shared variables module
-- 'local vars = require("modules/vars")'

return {
    mainMod     = "SUPER",
    terminal    = "kitty",
    fileManager = "kitty --class yazi -e yazi",
    editor      = "codium",
    menu        = "rofi -show drun",
    cursor      = { theme = "Qogir-white-cursors", size = 18 },
    home        = os.getenv("HOME")
}