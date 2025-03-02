--!strict
--!optimize 2

local jecs = require("./roblox_packages/jecs")
type entity<T = nil> = jecs.Entity<T>
type id<T = nil> = entity<T> | jecs.Pair<any, any>

type interface = {
	__index: interface,

	new: (world: jecs.World, entity: entity) -> handle,

	--- Checks if the entity has all of the given components
	has: (self: handle, ...id) -> boolean,
	--- Retrieves the value of up to 4 components. These values may be nil.
	get: (self: handle, id: id, id2: id?, id3: id?, id4: id?) -> any,
	--- Adds a component to the entity with no value
	add: <T>(self: handle, id: id<T>) -> handle,
	--- Assigns a value to a component on the given entity
	set: <T>(self: handle, id: id<T>, data: T) -> handle,
	--- Removes a component from the given entity
	remove: (self: handle, id: id) -> handle,
	--- Deletes the entity and all its related components and relationships. **Does not** refer to deleting the handle
	delete: (self: handle) -> (),
	clear: (self: handle) -> handle,
	--- Gets the entitys id
	id: (self: handle) -> entity,
}

export type handle = typeof(setmetatable({} :: { entity: entity }, {} :: interface))

local world = require("./roblox_packages/world")
local handle = {} :: interface
handle.__index = handle

function handle.new(entity: entity)
	local self = {
		entity = entity,
	}

	return setmetatable(self, handle)
end

function handle:has(...: id): boolean
	return world:has(self.entity, ...) :: boolean
end

function handle:get<V...>(...: V...)
	return world:get(self.entity, ...)
end

function handle:add<T>(id: id<T>): handle
    world:add(self.entity, id)
	return self
end

function handle:set<T>(id: id<T>, value: T): handle
    world:set(self.entity, id, value)
	return self
end

function handle:clear()
    world:clear(self.entity)
	return self
end

function handle:remove(id: id): handle
    world:remove(self.entity, id)
	return self
end

function handle:delete()
    world:delete(self.entity)
end

function handle:id(): entity
	return self.entity
end

return handle.new