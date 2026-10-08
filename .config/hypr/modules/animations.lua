--- Animation module
-- (https://wiki.hypr.land/configuring/core/animations/)

hl.config({ animations = { enabled = true } }) -- yes, please :)

local function bezier(name, x0, y0, x1, y1)
    hl.curve(name, { type = "bezier", points = { { x0, y0 }, { x1, y1 } } })
end

local function anim(leaf, speed, curve, style)
    hl.animation({ leaf = leaf, enabled = true, speed = speed, bezier = curve, style = style })
end

bezier("wind",        0.05, 0.85, 0.03, 0.97)
bezier("winIn",       0.1,  1,    0.1,  1)
bezier("winOut",      0.3,  -0.3, 0,    1)
bezier("linear",      1,    1,    1,    1)
bezier("md3_decel",   0.05, 0.80, 0.10, 0.97)
bezier("menu_decel",  0.05, 0.82, 0.43, 1)
bezier("menu_accel",  0.20, 0,    0.82, 0.10)
bezier("easeOutCirc", 0,    0.48, 0.38, 1)


anim("border",           2,  "linear")  
anim("borderangle",      30, "linear")

anim("windowsIn",        4,  "winIn",      "slide")
anim("windowsOut",       4,  "winOut",     "slide")
anim("windowsMove",      3,  "wind",       "slide")

anim("fade",             4,  "md3_decel")

anim("layersIn",         2.5,"menu_decel", "popin 80%")
anim("layersOut",        2,  "menu_accel", "popin 80%")
anim("fadeLayersIn",     2.5,"menu_decel")
anim("fadeLayersOut",    2,  "menu_accel")

anim("workspaces",       4,  "menu_decel", "slide")
anim("specialWorkspace", 2.3,"md3_decel",  "slidefadevert 15%")