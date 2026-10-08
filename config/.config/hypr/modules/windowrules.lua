-- Window rules module

local rule = hl.window_rule

rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize"
})

rule({
    name = "fix-xwayland-drags",
    match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
    no_focus = true
})

rule({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move = "20 monitor_h-120",
    float = true
})

rule({
    name = "picture-in-picture",
    match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" },
    tag = "+picture-in-picture",
    float = true,
    keep_aspect_ratio = true,
    move = { "monitor_w*0.01", "monitor_h*0.63" },
    size = { "monitor_w*0.35", "monitor_h*0.35" },
    pin = true,
    no_blur = true,
    opaque = true
})

local dialogs = { "^(Open File)", "^(Select a File)", "^(Open Folder)", "^(Save As)", "^(Library)", "^(File Upload)", "^(wants to save)$" }
for _, title in ipairs(dialogs) do
    rule({ match = { title = title }, float = true, center = true })
end

local floaters = { "pavucontrol", "org.pulseaudio.pavucontrol", "blueman-manager", "yazi" }
for _, class in ipairs(floaters) do
    rule({
        match = { class = "^(" .. class .. ")$" },
        float = true,
        center = true,
        size = { "monitor_w*.45", "monitor_h*.45" }
    })
end

rule({
    match = { class = "^jetbrains-.*$", float = true, title = "^$|^\\s$|^win\\d+$" },
    no_initial_focus = true
})
rule({
    match = { class = "^jetbrains-.*$" },
    no_blur = true,
    opaque = true
})

for _, class in ipairs({ "codium", "zoom", "vesktop" }) do
    rule({ match = { class = class }, no_blur = true, opaque = true })
end

-- Layer rules
hl.layer_rule({ match = { namespace = "rofi" }, blur = true, ignore_alpha = 0.1 })
hl.layer_rule({ match = { namespace = "waybar" }, blur = true, ignore_alpha = 0.3 })

-- Workspace rules
for i = 1, 8 do
    hl.workspace_rule({
        workspace = tostring(i),
        monitor = i <= 5 and "DP-2" or "HDMI-A-1",
        persistent = true
    })
end