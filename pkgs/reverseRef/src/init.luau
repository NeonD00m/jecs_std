--!strict
--!optimize 2

local refs = require("./roblox_packages/refs")

local function reverseRef(entity: number): number?
	if not entity then
		return nil
	end
	for key, value in refs :: { number } do
		if value == entity then
			return key
		end
	end

	return entity
end

return reverseRef