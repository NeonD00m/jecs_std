--!strict
--!optimize 2

local world = require("./roblox_packages/world")
local refs = require("./roblox_packages/refs")

local function ref(key)
	if not key then
		return world:entity()
	end

	local entity = refs[key]
	if not entity then
		entity = world:entity()
		refs[key] = entity
	end
	
	return entity
end

return ref