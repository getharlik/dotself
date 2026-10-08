--      _______  ________  ________  ________  ________ 
--    ╱╱       ╲╱    ╱   ╲╱        ╲╱        ╲╱        ╲
--   ╱╱        ╱         ╱    ╱    ╱    ╱    ╱         ╱
--  ╱       --╱         ╱         ╱        _╱   ╱  ╱  ╱ 
--  ╲________╱╲___╱____╱╲___╱____╱╲____╱___╱╲__╱__╱__╱  

-- One of the lucky charm.

require("modules/keybinds") -- Keybinds module
require("modules/inputs") -- Inputs module
require("modules/looknfeel") -- Look & feel module
require("modules/animations") -- Animations module
require("modules/monitors") -- Monitors module
require("modules/windowrules") -- Window rules module

local vars = require("modules/vars")

-- Autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("hyprlock")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("wal -R && wpg -s $(wpg -c)")
    hl.exec_cmd(vars.home .. "/Scripts/restore-wall.sh")
    hl.exec_cmd("mako")
    hl.exec_cmd("sleep 2 && waybar")
    hl.exec_cmd(string.format('hyprctl setcursor "%s" %d', vars.cursor.theme, vars.cursor.size))
    hl.exec_cmd("hypridle")
end)


-- Env vars
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")