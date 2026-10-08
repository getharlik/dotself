-- Color module

local colors = {}
local f = io.open(os.getenv("HOME") .. "/.cache/wal/colors-hyprland.conf", "r")
if f then
    for line in f:lines() do
        local name, value = line:match("^%$(%w+)%s*=%s*(.-)%s*$")
        if name then colors[name] = value end
    end
    f:close()
end

colors.color8 = colors.color8 or "rgba(58,58,58,1.0)"
return colors