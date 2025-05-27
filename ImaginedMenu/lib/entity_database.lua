--
-- made by FoxxDash/aka Ðr ÐºήgΣr & SATTY
--
-- Copyright © 2022 Imagined Menu
--

-- Global to local
local require = require
local ipairs = ipairs
local pairs = pairs
local utils = utils
local ENTITY = ENTITY
local ui = ui
local insert = table.insert

local vehicles = require "vehicle"
local peds = require "peds"
local objects = require "props"
local features = require "features"
local switch = require "switch"
local Global = require "global"
local EntityDb = {}

EntityDb.entity_data = {}
EntityDb.spawned_options = {}

local f = switch()
	:case(1, function(hash)
		local name = cache:get("Name: "..hash)
		if name then return name end
		for _, v in ipairs(peds.models)
		do
			if hash == utils.joaat(v) then
				local name = peds.GetPedName(v) or v
				cache:set("Name: "..hash, name, 100000)
				return name
			end
		end
	end)
	:case(2, function(hash)
		local name = cache:get("Name: "..hash)
		if name then return name end
		local name = vehicles.get_label_name(hash)
		cache:set("Name: "..hash, name, 100000)
		return name
	end)
	:case(3, function(hash)
		local name = cache:get("Name: "..hash)
		if name then return name end
		for _, v in ipairs(objects)
		do
			if hash == utils.joaat(v) then
				local name = v
				cache:set("Name: "..hash, name, 100000)
				return name
			end
		end
	end)

--- @param entity Entity
function EntityDb.AddEntityToDatabase(entity)
	if not entity then return end
	if not EntityDb.entity_data[entity] then
		EntityDb.entity_data[entity] = {
			type = ENTITY.GET_ENTITY_TYPE(entity),
			valid = ENTITY.DOES_ENTITY_EXIST(entity),
		}
		local hash = ENTITY.GET_ENTITY_MODEL(entity)
		EntityDb.entity_data[entity].name = f(EntityDb.entity_data[entity].type, hash) or "UNK"
	end
end

--- @param entity Entity
--- @param hard_remove? bool
function EntityDb.RemoveFromDatabase(entity, hard_remove)
	if EntityDb.spawned_options[entity] then
		for _, v in pairs(EntityDb.spawned_options[entity])
		do
			Global.subs[v] = nil
		end
		if hard_remove then
			for _, v in pairs(EntityDb.spawned_options[entity])
			do
				ui.remove(v)
			end
		else
			ui.hide(EntityDb.spawned_options[entity].sub_option, true)
		end
	end
	EntityDb.spawned_options[entity] = nil
	EntityDb.entity_data[entity] = nil
end

--- @param no_attachment? bool
--- @return table
function EntityDb.GetEntitiesInDb(no_attachment)
	local entities = {}
	for k, v in pairs(EntityDb.entity_data)
	do
		if EntityDb.IsValid(k) and not (no_attachment and ENTITY.IS_ENTITY_ATTACHED(k) == 1) then
			insert(entities, k)
		end
	end
	return entities
end

--- @param entity Entity
--- @return bool
function EntityDb.RemoveInvalidEntities()
	for k, v in pairs(EntityDb.entity_data)
	do
		if ENTITY.DOES_ENTITY_EXIST(k) == 0 then
			EntityDb.RemoveFromDatabase(k)
		end
	end
end

--- @param entity Entity
--- @return bool
function EntityDb.IsEntityInDatabase(entity)
	return EntityDb.entity_data[entity] ~= nil
end

--- @param entity Entity
--- @return bool
function EntityDb.IsValid(entity)
	return EntityDb.entity_data[entity] ~= nil and ENTITY.DOES_ENTITY_EXIST(entity) == 1
end

--- @param ped Ped
function EntityDb.TaskAnim(ped)
	system.thread(true, "task_anim_"..ped, function(tick)
		if not EntityDb.IsValid(ped) then return 0 end
		local data = EntityDb.entity_data[ped] and EntityDb.entity_data[ped].task_anim or nil
		if not data or type(data) ~= "table" or STREAMING.DOES_ANIM_DICT_EXIST(data.dict) == 0 then return 0 end
		if STREAMING.HAS_ANIM_DICT_LOADED(data.dict) == 0 then
			STREAMING.REQUEST_ANIM_DICT(data.dict)
			system.reset_thread_tick()
			return
		end
		if ENTITY.IS_ENTITY_PLAYING_ANIM(ped, data.dict, data.name, 3) == 0 and features.request_control_once(ped) then
			peds.play_anim(ped, data.dict, data.name, data.blend_in, data.blend_out, data.duration, data.flags, data.playback, false)
		end
	end)
end

--- @param invalid? bool
--- @return bool
function EntityDb.IsEmpty(invalid)
	for k in pairs(EntityDb.entity_data)
	do
		if not invalid then
			return false
		elseif invalid and not EntityDb.IsValid(k) then
			return false
		end
	end
	return true
end

return EntityDb