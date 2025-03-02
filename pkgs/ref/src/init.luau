--!strict
--!optimize 2

local handle = require("./roblox_packages/handle")
local world = require("./roblox_packages/world")
local refs = require("./roblox_packages/refs")

local function ref(key)
    if not key then
        return handle(world:entity())
    end
    local e = refs[key]
    if not e then
        e = world:entity()
        refs[key] = e
    end
    -- Cannot cache handles because they will get invalidated
    return handle(e)
end

return ref