--
-- made by FoxxDash/aka Ðr ÐºήgΣr & SATTY
--
-- Copyright © 2022 Imagined Menu
--

-- Global to local
local time = os.time
local format = string.format
local insert = table.insert
local abs = math.abs
local random = math.random
local cos = math.cos
local sin = math.sin
local ceil = math.ceil
local floor = math.floor
local rad = math.rad
local type = type
local select = select
local unpack = unpack
local tonumber = tonumber
local tostring = tostring
local ipairs = ipairs
local pairs = pairs
local memory = memory
local system = system
local PED = PED
local CAM = CAM
local PLAYER = PLAYER
local VEHICLE = VEHICLE
local NETWORK = NETWORK
local STREAMING = STREAMING
local utils = utils
local entities = entities
local globals = globals
local online = online
local WEAPON = WEAPON
local TASK = TASK
local MISC = MISC
local GRAPHICS = GRAPHICS
local SHAPETEST = SHAPETEST
local ENTITY = ENTITY
local HUD = HUD
local WATER = WATER
local cache = cache
local GET_ENTITY_COORDS = ENTITY.GET_ENTITY_COORDS

local vector3 = require 'vector3'
local switch = require 'switch'
local enum = require 'enums'
local ranks = require 'ranks'
local s_memory = require 'script_memory'
local weapons = require 'weapons'
local TRANSLATION = require('default').translation
local settings = require('default').settings
local gtamap = require 'gtamap'
local Global = require "global"
local features = {}
features.player_excludes = {}

math.randomseed(time())

--- @param count int
--- @return ... int args 
local function get_random_args(count)
	local args = {}
	for i = 1, count do
		insert(args, random(-2147483647, 2147483647))
	end
	return unpack(args)
end

--- @param values int
--- @return string
function features.to_hex(value)
	return "0x"..bit.tohex(value)
end

--- @param any string|int|float
--- @return bool
function features.to_bool(any)
	if type(any) == 'string' then
		return (any ~= 'false' or any ~= '')
	elseif type(any) == 'number' then
		return (any ~= 0)
	end
end

local interiors = {
	[0] = true,
	[7170] = true,
	[197121] = true,
	[200705] = true,
	[177153] = true,
	[178945] = true,
	[184065] = true,
	[196865] = true,
	[203265] = true,
	[175105] = true,
	[154113] = true,
	[168449] = true,
	[183809] = true,
	[167937] = true,
	[198401] = true,
	[175873] = true,
	[200961] = true,
	[168193] = true,
	[175617] = true,
	[176385] = true,
	[153857] = true,
	[137729] = true,
	[248065] = true,
	[179457] = true,
	[171009] = true,
	[198657] = true,
	[165377] = true,
	[180225] = true,
	[155905] = true,
	[140545] = true,
	[199937] = true,
	[164353] = true,
	[153601] = true,
	[234753] = true,
	[201729] = true,
	[198145] = true,
	[183553] = true,
	[175361] = true,
	[202497] = true,
	[179713] = true,
	[137217] = true,
	[171265] = true,
	[201473] = true,
	[169217] = true,
	[176129] = true,
	[165633] = true,
	[235265] = true,
	[166145] = true,
	[201217] = true,
	[163585] = true,
	[163841] = true,
	[92674] = true,
	[140033] = true,
	[199425] = true,
	[251137] = true,
	[171521] = true,
	[180737] = true,
	[176897] = true,
	[32770] = true,
}

--- @param player Player
--- @return bool
function features.is_player_in_interior(player)
	return not interiors[globals.get_int(2689235 + 1 + (player * 453) + 243)]
end

--- @param player Player
--- @return bool
function features.is_player_in_interior2(player)
	return globals.get_int(2689235 + 1 + (player * 453) + 243) ~= 0
end

--- @param player Player
--- @return bool
function features.is_player_in_veh(player)
	return globals.get_int(2689235 + 1 + (player * 453) + 71 + 1) ~= 0
end

--- @param toggle bool
function features.patch_blame(toggle)
	memory.write_short(s_memory.BlameExp, toggle and 0xE990 or 0x850F)
end

--- @param toggle bool
function features.patch_rqctrl(toggle)
	memory.write_short(s_memory.RQControl, toggle and 0x9090 or 0x6A75)
end

--- @param text string
--- @param notify? bool
--- @return bool
function features.to_clipboard(text, notify)
	if system.is_safe_mode_enabled() then return end
	if notify then system.notify(TRANSLATION["Info"], TRANSLATION["Copied to clipboard"], settings.General["HudColorNotifySuccess"]) end
	system.to_clipboard(text)
	return true
end

--- @return vector3
function features.get_screen_resolution()
	local px, py = s_memory.alloc_get(2)
	GRAPHICS._GET_ACTIVE_SCREEN_RESOLUTION(px, py)
	return vector3(memory.read_int(px), memory.read_int(py))
end

--- @return vector3
function features.get_screen_center()
	return features.get_screen_resolution() / 2
end

--- @param pos vector3
--- @return vector3
function features.world_to_screen(pos)
	local screenX, screenY = s_memory.alloc(8), s_memory.alloc(8)
	GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(pos.x, pos.y, pos.z, screenX, screenY)
	return vector3(memory.read_float(screenX), memory.read_float(screenY))
end

--- @param datatable table
--- @return table
function features.copy_table(datatable)
	local result = {}
	if type(datatable) == "table" then
		for k, v in pairs(datatable)
		do 
			result[k] = features.copy_table(v) 
		end
	else
		result = datatable
	end
	return result
end

--- @param name string
--- @return int? Player
function features.player_from_name(name)
	if tonumber(name) and NETWORK.NETWORK_IS_PLAYER_CONNECTED(tonumber(name)) == 1 then
		return tonumber(name)
	end
	name = name:lower()
	for i = 0, 31 do
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and name == online.get_name(i):lower() then 
			return i
		end
	end
	if #name > 2 then
		for i = 0, 31 do
			if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and online.get_name(i):lower():find(name:escpattern()) then 
				return i
			end
		end
	end
end

--- @param number number
--- @return string 
function features.format_int(number)
  local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
  int = int:reverse():gsub("(%d%d%d)", "%1,")
  return minus .. int:reverse():gsub("^,", "") .. fraction
end

--- @param player? Player
--- @return Ped 
function features.player_ped(player)
	player = player or PLAYER.PLAYER_ID()
	return PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player)
end

--- @param player Player 
function features.remove_god(player)
	online.send_script_event(player, -1388926377, PLAYER.PLAYER_ID(), -1762807505)
end

--- @param ent Entity
--- @return bool
function features.request_control_once(ent)
	if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) == 1 then return true end
	NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
	if NETWORK.NETWORK_IS_SESSION_STARTED() == 1 and NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) == 1 then
		local netId = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(ent)
		NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netId)
		NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netId, true)
	end
	return (NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) == 1)
end

--- @param entities table
function features.request_control_of_entities(entities) -- not used
	for _, v in ipairs(entities) do
		features.request_control_once(v)
	end
end

--- @param no_friend? bool
--- @return Player
function features.get_random_player(no_friend)
	local players = {}
	for i = 0, 31 do
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and i ~= PLAYER.PLAYER_ID() and not (no_friend and features.is_friend(i)) and not features.is_excluded(i) then
			insert(players, i)
		end
	end
	if #players ~= 0 then return players[random(1, #players)] end
	return PLAYER.PLAYER_ID()
end

--- @param entity Entity
--- @param r int
--- @param g int
--- @param b int
--- @param a int
function features.draw_box_on_entity(entity, r, g, b, a)
	if ENTITY.IS_ENTITY_ON_SCREEN(entity) == 0 then return end
	r, g, b, a = r or 255, g or 255, b or 255, a or 255
	local vec_min, vec_max = features.get_model_dimentions(ENTITY.GET_ENTITY_MODEL(entity))
	local off_1 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, vec_min.x, vec_min.y, vec_min.z)
	local off_2 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, vec_min.x, vec_min.y, vec_max.z)
	local off_3 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, vec_max.x, vec_min.y, vec_min.z)
	local off_4 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, vec_min.x, vec_max.y, vec_min.z)
	local off_5 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, vec_max.x, vec_min.y, vec_max.z)
	local off_6 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, vec_min.x, vec_max.y, vec_max.z)
	local off_7 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, vec_max.x, vec_max.y, vec_min.z)
	local off_8 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, vec_max.x, vec_max.y, vec_max.z)
	GRAPHICS.DRAW_LINE(off_1.x, off_1.y, off_1.z, off_2.x, off_2.y, off_2.z, r, g, b, a)
	GRAPHICS.DRAW_LINE(off_1.x, off_1.y, off_1.z, off_3.x, off_3.y, off_3.z, r, g, b, a)
	GRAPHICS.DRAW_LINE(off_1.x, off_1.y, off_1.z, off_4.x, off_4.y, off_4.z, r, g, b, a)
	GRAPHICS.DRAW_LINE(off_2.x, off_2.y, off_2.z, off_5.x, off_5.y, off_5.z, r, g, b, a)
	GRAPHICS.DRAW_LINE(off_2.x, off_2.y, off_2.z, off_6.x, off_6.y, off_6.z, r, g, b, a)
	GRAPHICS.DRAW_LINE(off_4.x, off_4.y, off_4.z, off_6.x, off_6.y, off_6.z, r, g, b, a)
	GRAPHICS.DRAW_LINE(off_4.x, off_4.y, off_4.z, off_7.x, off_7.y, off_7.z, r, g, b, a)
	GRAPHICS.DRAW_LINE(off_7.x, off_7.y, off_7.z, off_3.x, off_3.y, off_3.z, r, g, b, a)
	GRAPHICS.DRAW_LINE(off_3.x, off_3.y, off_3.z, off_5.x, off_5.y, off_5.z, r, g, b, a)
	GRAPHICS.DRAW_LINE(off_5.x, off_5.y, off_5.z, off_8.x, off_8.y, off_8.z, r, g, b, a)
	GRAPHICS.DRAW_LINE(off_8.x, off_8.y, off_8.z, off_6.x, off_6.y, off_6.z, r, g, b, a)
	GRAPHICS.DRAW_LINE(off_8.x, off_8.y, off_8.z, off_7.x, off_7.y, off_7.z, r, g, b, a)
end

--- @param entity Entity
--- @param pos vector3
--- @param r int
--- @param g int
--- @param b int
--- @param a int
function features.draw_box_on_entity2(entity, pos, r, g, b, a) -- slower but not delayed by frame
	if ENTITY.IS_ENTITY_ON_SCREEN(entity) == 0 then return end
	r, g, b, a = r or 255, g or 255, b or 255, a or 255
	local vec_min, vec_max = features.get_model_dimentions(ENTITY.GET_ENTITY_MODEL(entity))
	local rot = features.get_entity_rot(entity)
	local off_1 = features.get_offset_entity_with_given_coords(entity, pos, vector3(vec_min.x, vec_min.y, vec_min.z), rot)
    local off_2 = features.get_offset_entity_with_given_coords(entity, pos, vector3(vec_min.x, vec_min.y, vec_max.z), rot)
    local off_3 = features.get_offset_entity_with_given_coords(entity, pos, vector3(vec_max.x, vec_min.y, vec_min.z), rot)
    local off_4 = features.get_offset_entity_with_given_coords(entity, pos, vector3(vec_min.x, vec_max.y, vec_min.z), rot)
    local off_5 = features.get_offset_entity_with_given_coords(entity, pos, vector3(vec_max.x, vec_min.y, vec_max.z), rot)
    local off_6 = features.get_offset_entity_with_given_coords(entity, pos, vector3(vec_min.x, vec_max.y, vec_max.z), rot)
    local off_7 = features.get_offset_entity_with_given_coords(entity, pos, vector3(vec_max.x, vec_max.y, vec_min.z), rot)
    local off_8 = features.get_offset_entity_with_given_coords(entity, pos, vector3(vec_max.x, vec_max.y, vec_max.z), rot)
    GRAPHICS.DRAW_LINE(off_1.x, off_1.y, off_1.z, off_2.x, off_2.y, off_2.z, r, g, b, a)
    GRAPHICS.DRAW_LINE(off_1.x, off_1.y, off_1.z, off_3.x, off_3.y, off_3.z, r, g, b, a)
    GRAPHICS.DRAW_LINE(off_1.x, off_1.y, off_1.z, off_4.x, off_4.y, off_4.z, r, g, b, a)
    GRAPHICS.DRAW_LINE(off_2.x, off_2.y, off_2.z, off_5.x, off_5.y, off_5.z, r, g, b, a)
    GRAPHICS.DRAW_LINE(off_2.x, off_2.y, off_2.z, off_6.x, off_6.y, off_6.z, r, g, b, a)
    GRAPHICS.DRAW_LINE(off_4.x, off_4.y, off_4.z, off_6.x, off_6.y, off_6.z, r, g, b, a)
    GRAPHICS.DRAW_LINE(off_4.x, off_4.y, off_4.z, off_7.x, off_7.y, off_7.z, r, g, b, a)
    GRAPHICS.DRAW_LINE(off_7.x, off_7.y, off_7.z, off_3.x, off_3.y, off_3.z, r, g, b, a)
    GRAPHICS.DRAW_LINE(off_3.x, off_3.y, off_3.z, off_5.x, off_5.y, off_5.z, r, g, b, a)
    GRAPHICS.DRAW_LINE(off_5.x, off_5.y, off_5.z, off_8.x, off_8.y, off_8.z, r, g, b, a)
    GRAPHICS.DRAW_LINE(off_8.x, off_8.y, off_8.z, off_6.x, off_6.y, off_6.z, r, g, b, a)
    GRAPHICS.DRAW_LINE(off_8.x, off_8.y, off_8.z, off_7.x, off_7.y, off_7.z, r, g, b, a)
end

--- @param entity Entity
--- @param pos vector3
--- @param offset vector3
--- @param rot? vector3
--- @return vector3
function features.get_offset_entity_with_given_coords(entity, pos, offset, rot)
	local rotation = rot or features.get_entity_rot(entity)
	local forward = rotation:rot_to_direction()
	rotation = rotation:rad()
	local num = cos(rotation.y)
	local x = num * cos(-rotation.z)
	local y = num * sin(rotation.z)
	local z = sin(-rotation.y)
	local right = vector3(x, y, z)
	local up = right:cross(forward)
	return vector3(pos + (right * offset.x) + (forward * offset.y) + (up * offset.z))
end

--- @param cam Cam
--- @param offset vector3
--- @return vector3
function features.get_offset_cam_coords(cam, offset)
	local rotation = vector3(CAM.GET_CAM_ROT(cam, 2))
	local forward = rotation:rot_to_direction()
	rotation = rotation:rad()
	local num = cos(rotation.y)
	local x = num * cos(-rotation.z)
	local y = num * sin(rotation.z)
	local z = sin(-rotation.y)
	local right = vector3(x, y, z)
	local up = right:cross(forward)
	return vector3(CAM.GET_CAM_COORD(cam)) + (right * offset.x) + (forward * offset.y) + (up * offset.z)
end

--- @param dist float
--- @return vector3
function features.get_ar_speedo_scale(dist)
	return vector3(-sin(rad(10)) * dist, cos(rad(10)) * dist, 0):len(vector3(-sin(rad(20)) * dist, cos(rad(20)) * dist, 0))
end

--- @param entity Entity
--- @param dist float
--- @param offheading float
--- @return vector3
function features.get_ar_speedo_pos(entity, dist, offheading)
    local pos = features.get_entity_coords(entity)
    local rot = features.get_entity_rot(entity)
    return vector3(
        pos.x - sin(rad(rot.z + offheading)) * dist,
        pos.y + cos(rad(rot.z + offheading)) * dist,
        pos.z + sin(rad(rot.x)) * dist
    )
end

--- @param pos vector3
--- @param offset float
--- @return vector3
function features.get_next_speedo_num(pos, offset)
	 return vector3(
        pos.x + sin(rad(features.get_final_cam_rot().z + 90)) * offset,
        pos.y - cos(rad(features.get_final_cam_rot().z + 90)) * offset,
        pos.z
    )
end

--- @param entity Entity
--- @param dist? float
--- @param offheading? float
--- @param ignore_z? bool
--- @return vector3
function features.get_offset_coords_from_entity_rot(entity, dist, offheading, ignore_z)
    local pos = features.get_entity_coords(entity)
    local rot = features.get_entity_rot(entity)
    dist = dist or 5
    offheading = offheading or 0
    local offz = 0
    local vector = vector3(
        -sin(rad(rot.z + offheading)) * dist, 
        cos(rad(rot.z + offheading)) * dist,
        sin(rad(rot.x)) * dist
    )
    if not ignore_z then
        offz = vector.z
        local absx = abs(cos(rad(rot.x)))
        vector.x = vector.x * absx
        vector.y = vector.y * absx
    end
    return vector3(
        pos.x + vector.x,
        pos.y + vector.y,
        pos.z + offz
    )
end

--- @param ent1 Entity
--- @param ent2 Entity
--- @param use_pitch? bool
function features.set_entity_face_entity(ent1, ent2, use_pitch)
    local rot = features.get_entity_coords(ent1):direction_to(features.get_entity_coords(ent2)):direction_to_rot()
    if not use_pitch then
        ENTITY.SET_ENTITY_HEADING(ent1, rot.z)
    else
        ENTITY.SET_ENTITY_ROTATION(ent1, rot.x, rot.y, rot.z, 2, true)
    end
end

--- @param ent Entity
--- @param pos vector3
--- @param force float
function features.oscillate_to_coord(ent, pos, force)
	local force = force or 1
	local pos = vector3(pos)
	local pos2 = features.get_entity_coords(ent)
	local to = (pos - pos2) * force
	ENTITY.SET_ENTITY_VELOCITY(ent, to.x, to.y, to.z)
end

--- @param ent Entity
--- @param ent2 Entity
--- @param force float
function features.oscillate_to_entity(ent, ent2, force)
	features.oscillate_to_coord(ent, features.get_entity_coords(ent2), force)
end

--- @param ped Ped
--- @return Player?
function features.get_player_from_ped(ped)
	if PED.IS_PED_A_PLAYER(ped) == 0 then return -1 end
	return NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ped)
end

--- @param ped? Ped
--- @return int
function features.get_ped_weapon(ped)
	ped = ped or features.player_ped()
	local ptr = s_memory.alloc(8)
	WEAPON.GET_CURRENT_PED_WEAPON(ped, ptr, true)
	return memory.read_int(ptr)
end

--- @param entity Entity
--- @param toggle bool
function features.set_godmode(entity, toggle)
	ENTITY.SET_ENTITY_CAN_BE_DAMAGED(entity, not toggle)
    ENTITY.SET_ENTITY_PROOFS(entity, toggle, toggle, toggle, toggle, toggle, toggle, toggle, toggle)
    ENTITY.SET_ENTITY_INVINCIBLE(entity, toggle)
end

--- @param x int
--- @param y int
--- @param spacing int
--- @param thickness int
--- @param r int
--- @param g int
--- @param b int
--- @param a int
--- @param b_left bool
--- @param b_right bool
--- @param b_up bool
--- @param b_down bool
--- @param borders int
--- @param border_r int
--- @param border_g int
--- @param border_b int
--- @param border_a int
--- @param dot? bool
--- @param pos? vector3
function features.draw_crosshair(x, y, spacing, thickness, r, g, b, a, b_left, b_right, b_up, b_down, borders, border_r, border_g, border_b, border_a, dot, pos)
	x, y, spacing, thickness, r, g, b, a = floor(x), floor(y), floor(spacing), floor(thickness), floor(r), floor(g), floor(b), floor(a)
	borders, border_r, border_g, border_b, border_a = floor(borders), floor(border_r), floor(border_g), floor(border_b), floor(border_a)
	pos = pos and vector3(pos.x and pos.x or .5, pos.y and pos.y or .5) or vector3(.5)
	local res = features.get_screen_resolution():inverse()
	local border_thic = thickness + borders
	local spacing = vector3(res.x * spacing, res.y * spacing)

	if border_thic%2 ~= 0 then border_thic = border_thic + 1 end
	if thickness%2 ~= 0 then thickness = thickness + 1 end
	if borders ~= 0 then
		local x = x + borders
		local y = y + borders
		if b_left then GRAPHICS.DRAW_RECT(pos.x - spacing.x - (res.x * x)/2, pos.y, res.x * x, res.y * border_thic, border_r, border_g, border_b, border_a, false) end
		if b_right then GRAPHICS.DRAW_RECT(pos.x + spacing.x + (res.x * x)/2, pos.y, res.x * x, res.y * border_thic, border_r, border_g, border_b, border_a, false) end
		if b_up then GRAPHICS.DRAW_RECT(pos.x, pos.y - spacing.y - (res.y * y)/2, res.x * border_thic, res.y * y, border_r, border_g, border_b, border_a, false) end
		if b_down then GRAPHICS.DRAW_RECT(pos.x, pos.y + spacing.y + (res.y * y)/2, res.x * border_thic, res.y * y, border_r, border_g, border_b, border_a, false) end
	end
	if b_left then GRAPHICS.DRAW_RECT(pos.x - spacing.x - (res.x * x)/2, pos.y, res.x * x, res.y * thickness, r, g, b, a, false) end
	if b_right then GRAPHICS.DRAW_RECT(pos.x + spacing.x + (res.x * x)/2, pos.y, res.x * x, res.y * thickness, r, g, b, a, false) end
	if b_up then GRAPHICS.DRAW_RECT(pos.x, pos.y - spacing.y - (res.y * y)/2, res.x * thickness, res.y * y, r, g, b, a, false) end
	if b_down then GRAPHICS.DRAW_RECT(pos.x, pos.y + spacing.y + (res.y * y)/2, res.x * thickness, res.y * y, r, g, b, a, false) end
	if dot then GRAPHICS.DRAW_RECT(pos.x, pos.y, res.x * thickness, res.y * thickness, r, g, b, a, false) end
end

--- @param hash int
--- @param pos vector3
--- @return Object
function features.create_object(hash, pos)
	local obj = entities.create_object(hash, pos)
    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(obj), true)
    NETWORK._NETWORK_SET_ENTITY_INVISIBLE_TO_NETWORK(obj, false)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(obj, false, true)
    return obj
end

--- @param no_objects bool
--- @return table
function features.get_entities(no_objects)
	local ent = {}
	for _,v in ipairs(entities.get_vehs()) do
		insert(ent, v)
	end
	for _,v in ipairs(entities.get_peds()) do
		insert(ent, v)
	end
	if no_objects then return ent end
	for _,v in ipairs(entities.get_objects()) do
		insert(ent, v)
	end
	return ent
end

--- @param pos vector3
--- @return bool
--- @return float
function features.get_water_z(pos)
	local ptr = s_memory.alloc()
	local result = WATER.GET_WATER_HEIGHT_NO_WAVES(pos.x, pos.y, pos.z, ptr)
	return result == 1, memory.read_float(ptr)
end

local GroundZRequests = {}

--- @param pos vector3
--- @return int
local function get_num_request_for(pos)
	pos.z = 0
	local key = tostring(pos)
	if not GroundZRequests[key] then GroundZRequests[key] = 0 end
	GroundZRequests[key] = GroundZRequests[key] + 1
	return GroundZRequests[key]
end

--- @param pos vector3
local function reset_requests(pos)
	pos.z = 0
	local key = tostring(pos)
	GroundZRequests[key] = nil
end

--- @param pos vector3
--- @return vector3
local function get_approximate_z(pos)
	local p = {}
	p[1] = pos.x - pos.x%50
	p[2] = pos.y - pos.y%50
	p[3] = p[1] + 50
	p[4] = p[2] + 50
	return math.max(
		gtamap[tostring(vector3(p[1], p[2]))] or 0,
		gtamap[tostring(vector3(p[1], p[4]))] or 0,
		gtamap[tostring(vector3(p[3], p[2]))] or 0,
		gtamap[tostring(vector3(p[3], p[4]))] or 0) + 10
end

--- @param pos vector3
--- @return bool
--- @return float
function features.get_ground_z(pos)
	local ptr = s_memory.alloc()
	local result = MISC.GET_GROUND_Z_FOR_3D_COORD(pos.x, pos.y, pos.z, ptr, false, false)
	local success, z = result == 1, memory.read_float(ptr)
	if not success and get_num_request_for(pos) > 100 then
		z = get_approximate_z(pos)
		success = true
	end
	if success then
		reset_requests(pos)
	end
	return success, z
end

--- @param pos vector3
--- @return string
function features.get_zone_for_coords(pos)
	local label = HUD._GET_LABEL_TEXT(ZONE.GET_NAME_OF_ZONE(pos.x, pos.y, pos.z))
	return label == "NULL" and TRANSLATION["Unknown"] or label
end

--- @param x float
--- @param y float
--- @param z float
function features.fake_tp(x, y, z)
	local px, py, pz = 0, 0, 0
	local addr = s_memory.get_memory_address(s_memory.WorldPtr, s_memory.offsets.is_in_veh)
	if addr ~= 0 and memory.read_int(addr) == 0x10 then
		px = s_memory.get_memory_address(s_memory.WorldPtr, s_memory.offsets.player_vis_x)
		py = s_memory.get_memory_address(s_memory.WorldPtr, s_memory.offsets.player_vis_y)
		pz = s_memory.get_memory_address(s_memory.WorldPtr, s_memory.offsets.player_vis_z)
	else
		px = s_memory.get_memory_address(s_memory.WorldPtr, s_memory.offsets.veh_vis_x)
		py = s_memory.get_memory_address(s_memory.WorldPtr, s_memory.offsets.veh_vis_y)
		pz = s_memory.get_memory_address(s_memory.WorldPtr, s_memory.offsets.veh_vis_z)
	end
	if px ~= 0 and py ~= 0 and pz ~= 0 then
		memory.write_float(px, x)
		memory.write_float(py, y)
		memory.write_float(pz, z)
	end
end

--- @param entity Entity
--- @param x float
--- @param y float
--- @param z float
--- @param heading? float
function features.teleport_entity(entity, x, y, z, heading)
	entities.request_control(entity, function()
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(entity, x, y, z, false, false, false)
		if heading then
			ENTITY.SET_ENTITY_HEADING(entity, heading)
		end
	end)
end

--- @param entity Entity
--- @param x float
--- @param y float
--- @param z float
--- @param heading? float
--- @param velocity? bool
function features.teleport(entity, x, y, z, heading, velocity)
	if ENTITY.IS_ENTITY_A_PED(entity) == 1 and PED.IS_PED_IN_ANY_VEHICLE(entity, true) == 1 then
		entity = PED.GET_VEHICLE_PED_IS_IN(entity, false)
	end
	if velocity then
		velocity = ENTITY.GET_ENTITY_VELOCITY(entity)
	end
	entities.request_control(entity, function()
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(entity, x, y, z, false, false, false)
		if heading then
			ENTITY.SET_ENTITY_HEADING(entity, heading)
		end
		if velocity then
			ENTITY.SET_ENTITY_VELOCITY(entity, velocity.x, velocity.y, velocity.z)
		end
	end)
end

--- @param entity Entity
--- @param x float
--- @param y float
--- @param z float
--- @param heading? float
function features.teleport2(entity, x, y, z, heading)
	if ENTITY.IS_ENTITY_A_PED(entity) == 1 and PED.IS_PED_IN_ANY_VEHICLE(entity, true) == 1 then
		entity = PED.GET_VEHICLE_PED_IS_IN(entity, false)
	end
	entities.request_control(entity, function()
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(entity, x, y, z, true, true, true)
		if heading then
			ENTITY.SET_ENTITY_HEADING(entity, heading)
		end
	end)
end

--- @param entity Entity
--- @param vec1 vector3
--- @param vec2 vector3
--- @return bool
function features.is_in_area(entity, vec1, vec2)
	local min = vector3.min(vec1, vec2)
	local max = vector3.max(vec1, vec2)
	local pos = features.get_entity_coords(entity)
	return min <= pos and max >= pos
end

--- @param pos vector3
--- @param min_distance? float
--- @return Entity
--- @return float
function features.get_closest_entity_to_coord(pos, min_distance)
	min_distance = min_distance and min_distance ^ 2 or 1000000
	local entity = 0
	for _, v in ipairs(features.get_entities())
	do
		local e_pos = features.get_entity_coords(v)
		local distance = pos:sqrlen(e_pos)
		if v ~= features.player_ped() and min_distance > distance then
			entity = v
			min_distance = distance
		end
	end
	return entity, min_distance
end

--- @param pos vector3
--- @return int
function features.get_closest_apartment_to_coord(pos)
	local distance
	local aparent
	for i, v in ipairs(enum.apartment_coords)
	do
		local dist = pos:sqrlen(v)
		if not distance or (distance and distance > dist) then
			distance = dist
			aparent = i
		end
	end
	return aparent
end

--- @param blip Blip
function features.remove_blip(blip)
	if HUD.DOES_BLIP_EXIST(blip) == 0 then return end
	local ptr = s_memory.alloc()
	memory.write_int(ptr, blip)
	HUD.REMOVE_BLIP(ptr)
end

--- @return vector3
function features.get_final_cam_rot()
	return vector3(CAM.GET_FINAL_RENDERED_CAM_ROT(2))
end

--- @return vector3
function features.get_final_cam_pos()
	return vector3(CAM.GET_FINAL_RENDERED_CAM_COORD())
end

--- @return vector3
function features.gameplay_cam_rot()
	return vector3(CAM.GET_GAMEPLAY_CAM_ROT(2))
end

--- @return vector3
function features.gameplay_cam_pos()
	return vector3(CAM.GET_GAMEPLAY_CAM_COORD())
end

--- @return vector3
function features.get_waypoint_coord()
	return vector3(HUD.GET_BLIP_COORDS(HUD.GET_FIRST_BLIP_INFO_ID(8)))
end

--- @param pos vector3
--- @param blip_sprite? int
--- @return Blip?
function features.get_blip_from_coord(pos, blip_sprite)
	if blip_sprite then
		local blip = HUD.GET_FIRST_BLIP_INFO_ID(blip_sprite)
		while HUD.DOES_BLIP_EXIST(blip) == 1 do
			local bpos = vector3(HUD.GET_BLIP_COORDS(blip))
			if bpos.z ~= 0 and pos.x == bpos.x and pos.y == bpos.y then
				return blip
			end
			blip = HUD.GET_NEXT_BLIP_INFO_ID(blip_sprite)
		end		
		return
	end
	for v = 0, 1000
	do
		local blip = HUD.GET_FIRST_BLIP_INFO_ID(v)
		while HUD.DOES_BLIP_EXIST(blip) == 1 do
			local bpos = vector3(HUD.GET_BLIP_COORDS(blip))
			if bpos.z ~= 0 and pos.x == bpos.x and pos.y == bpos.y then
				return blip
			end
			blip = HUD.GET_NEXT_BLIP_INFO_ID(v)
		end
	end
end

--- @param pos vector3
--- @return vector3?
function features.get_blip_for_coord(pos)
	for v = 0, 1000
	do
		if v ~= 8 then
			local blip = HUD.GET_FIRST_BLIP_INFO_ID(v)
			while HUD.DOES_BLIP_EXIST(blip) == 1 do
				local bpos = vector3(HUD.GET_BLIP_COORDS(blip))
				if bpos.z ~= 0 and pos.x == bpos.x and pos.y == bpos.y then
					return bpos
				end
				blip = HUD.GET_NEXT_BLIP_INFO_ID(v)
			end
		end
	end
end

--- @return vector3?
function features.get_blip_objective()
	for _, i in ipairs({enum.blip_sprite.level, enum.blip_sprite.contraband, enum.blip_sprite.supplies, enum.blip_sprite.nhp_bag, enum.blip_sprite.sports_car, enum.blip_sprite.cratedrop, enum.blip_sprite.package, enum.blip_sprite.raceflag})
	do
		local blip = HUD.GET_FIRST_BLIP_INFO_ID(i)
		while HUD.DOES_BLIP_EXIST(blip) == 1
		do
			local color = HUD.GET_BLIP_COLOUR(blip)
			local icon = HUD.GET_BLIP_SPRITE(blip)
			if (color == enum.blip_color.YellowMission and icon == enum.blip_sprite.level) or 
				(color == enum.blip_color.YellowMission2 and icon == enum.blip_sprite.level) or 
				(color == enum.blip_color.Yellow and icon == enum.blip_sprite.level) or
				(color == enum.blip_color.Green and icon == enum.blip_sprite.contraband) or
				(color == enum.blip_color.Green and icon == enum.blip_sprite.supplies) or
				(color == enum.blip_color.Blue and icon == enum.blip_sprite.supplies) or
				(color == enum.blip_color.Green and icon == enum.blip_sprite.nhp_bag) or
				(color == enum.blip_color.Green and icon == enum.blip_sprite.package) or
				(color == enum.blip_color.Blue and icon == enum.blip_sprite.package) or
				(color == enum.blip_color.Blue and icon == enum.blip_sprite.sports_car) or
				(color == enum.blip_color.White and icon == enum.blip_sprite.raceflag) or
				(color == enum.blip_color.YellowMission and icon == enum.blip_sprite.raceflag) or
				(color == enum.blip_color.YellowMission2 and icon == enum.blip_sprite.raceflag) or
				(color == enum.blip_color.Yellow and icon == enum.blip_sprite.raceflag) or
				(color == enum.blip_color.Blue and icon == enum.blip_sprite.level) or
				(color == enum.blip_color.Green and icon == enum.blip_sprite.level) or
				(color == enum.blip_color.Green and icon == enum.blip_sprite.cratedrop)
			then
				return vector3(HUD.GET_BLIP_INFO_ID_COORD(blip))
			end
			blip = HUD.GET_NEXT_BLIP_INFO_ID(i)
		end
	end
end

--- @param toggle bool
function features.disable_phone(toggle)
	globals.set_int(20266 + 1, toggle and 1 or 0)
end

--- @param player? Player
--- @return Ped
function features.get_aimed_ped(player)
	local ptr = s_memory.alloc()
	if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(player or PLAYER.PLAYER_ID(), ptr) == 0 then return 0 end
	local result = memory.read_int(ptr)
	if ENTITY.IS_ENTITY_A_PED(result) == 1 then
		return result
	end
	return 0
	-- for _, ent in ipairs(entities.get_peds())
	-- do
	-- 	if PLAYER.IS_PLAYER_FREE_AIMING_AT_ENTITY(PLAYER.PLAYER_ID(), ent) == 1 then
	-- 		return ent
	-- 	end
	-- end
	-- return 0
end

--- @param player? Player
--- @return Entity
function features.get_aimed_entity(player)
	local ptr = s_memory.alloc()
	if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(player or PLAYER.PLAYER_ID(), ptr) == 0 then return 0 end
	return memory.read_int(ptr)
	-- for _, ent in ipairs(features.get_entities())
	-- do
	-- 	if PLAYER.IS_PLAYER_FREE_AIMING_AT_ENTITY(PLAYER.PLAYER_ID(), ent) == 1 then
	-- 		return ent
	-- 	end
	-- end
	-- return 0
end

--- @param entity Entity
--- @param order? int
--- @return vector3
function features.get_entity_rot(entity, order)
	return vector3(ENTITY.GET_ENTITY_ROTATION(entity, order or 2))
end

--- @param entity Entity
--- @return vector3
function features.get_entity_coords(entity)
	return vector3(GET_ENTITY_COORDS(entity, false))
end

--- @param entity Entity
--- @return vector3
function features.get_entity_top_pos(entity)
	local vec_min, vec_max = features.get_model_dimentions(ENTITY.GET_ENTITY_MODEL(entity))
	local pos = features.get_entity_coords(entity)
	return vector3.max(
		features.get_offset_entity_with_given_coords(entity, pos, vector3(vec_min.x, vec_min.y, vec_min.z)),
    	features.get_offset_entity_with_given_coords(entity, pos, vector3(vec_min.x, vec_min.y, vec_max.z)),
    	features.get_offset_entity_with_given_coords(entity, pos, vector3(vec_max.x, vec_min.y, vec_min.z)),
    	features.get_offset_entity_with_given_coords(entity, pos, vector3(vec_min.x, vec_max.y, vec_min.z)),
    	features.get_offset_entity_with_given_coords(entity, pos, vector3(vec_max.x, vec_min.y, vec_max.z)),
    	features.get_offset_entity_with_given_coords(entity, pos, vector3(vec_min.x, vec_max.y, vec_max.z)),
    	features.get_offset_entity_with_given_coords(entity, pos, vector3(vec_max.x, vec_max.y, vec_min.z)),
    	features.get_offset_entity_with_given_coords(entity, pos, vector3(vec_max.x, vec_max.y, vec_max.z))
	).z
end

--- @param player? Player
--- @return float
function features.get_player_heading(player)
	return ENTITY.GET_ENTITY_HEADING(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player or PLAYER.PLAYER_ID()))
end

--- @param entity Entity
--- @param off vector3
--- @return vector3
function features.get_offset_from_entity_in_world_coords(entity, off)
	return vector3(ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, off.x, off.y, off.z))
end

--- @param offvector vector3
--- @param player? Player
--- @return vector3
function features.get_offset_from_player_coords(offvector, player)
	local offx, offy, offz = offvector:get()
	return vector3(ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player or PLAYER.PLAYER_ID()), offx, offy, offz))
end

--- @param player? Player
--- @return vector3
function features.get_player_coords(player)
	return features.get_entity_coords(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player or PLAYER.PLAYER_ID()))
end

--- @param player? Player
--- @return vector3
function features.get_player_coords2(player)
	player = player or PLAYER.PLAYER_ID()
	local pos = features.get_player_coords(player)
	if ENTITY.IS_ENTITY_VISIBLE(features.player_ped(player)) == 1 and pos.z ~= -50 then return pos end
	pos = player ~= PLAYER.PLAYER_ID() and vector3(NETWORK._NETWORK_GET_PLAYER_COORDS(player)) or pos
	local interior = globals.get_int(2689235 + 1 + (player * 453) + 243)
	if interior ~= 0 then
		local position, name = s_memory.allocv3(), s_memory.alloc()
		INTERIOR._GET_INTERIOR_INFO(interior, position, name)
		pos.z = s_memory.readv3(position).z
	end
	return pos
end

local session_time = 0
local session_started
function features.start_session_time()
	if not session_started and NETWORK.NETWORK_IS_SESSION_STARTED() == 1 then
		session_started = true
		session_time = os.clock()
	elseif session_started and NETWORK.NETWORK_IS_SESSION_STARTED() == 0 then
		session_started = false
		session_time = 0
	end
end

--- @return float
function features.get_session_time()
	return session_time ~= 0 and os.clock() - session_time or 0
end

--- @param player Player
--- @return bool
function features.is_typing(player)
	return ENTITY.IS_ENTITY_DEAD(features.player_ped(player), false) == 0 and bit.band(globals.get_int(1648034 + 241 + 136 + 2 + player * 1), bit.lshift(1, 16)) ~= 0 --[[ & 1 << 16 ~= 0 ]] 
end

--- @param player Player
--- @return bool
function features.is_otr(player)
	return NETWORK.NETWORK_IS_PLAYER_CONNECTED(player) == 1 and globals.get_int(2689235 + 1 + (player * 453) + 208) == 1
end

-- 1892703[bParam0 /*599*/].f_8

--- @param player Player
--- @return bool
function features.is_player_passive(player)
	return globals.get_int(1892703 + 1 + (player * 599) + 8) == 1 and globals.get_int(1892703 + 1 + (player * 599) + 9) == 0
end

--- @param player Player
--- @return bool
function features.is_game_paused(player)
	return globals.get_int(1924338 + 1 + (player * 199) + 194) == 1
end

features.is_player_in_rc = {}
for i = 0, 31
do
	features.is_player_in_rc[i] = false
end

--- @param player Player
--- @return bool
function features.is_rc_veh(player)
	if not features.is_player_in_rc[player] then
		local is_in = features.is_player_in_veh(player) -- still need to check if is in vehicle, otherwise it will not be accurate
			and not features.is_player_in_interior2(player)
			and globals.get_int(1892703 + 1 + (player * 599) + 9) == 1 -- this will turn to 0 after few seconds
		if is_in then
			features.is_player_in_rc[player] = true
		end
		return is_in
	elseif features.is_player_in_rc[player] and (NETWORK.NETWORK_IS_PLAYER_CONNECTED(player) == 0 or (not features.is_player_in_veh(player) and globals.get_int(1892703 + 1 + (player * 599) + 9) == 0)) then
		features.is_player_in_rc[player] = false
		return false
	else
		return features.is_player_in_rc[player]
	end
end

--- @param player Player
--- @return float
function features.get_kd(player)
	return globals.get_float(1853348 + 1 + (player * 834) + 205 + 26)
end

--- @param player Player
--- @return int
function features.get_kills(player)
	return globals.get_int(1853348 + 1 + (player * 834) + 205 + 28)
end

--- @param player Player
--- @return int
function features.get_deaths(player)
	return globals.get_int(1853348 + 1 + (player * 834) + 205 + 29)
end

--- @param player Player
--- @return int
function features.get_races_won(player)
	return globals.get_int(1853348 + 1 + (player * 834) + 205 + 15)
end

--- @param player Player
--- @return int
function features.get_races_lost(player)
	return globals.get_int(1853348 + 1 + (player * 834) + 205 + 16)
end

--- @param player Player
--- @return int
function features.get_deathmatch_won(player)
	return globals.get_int(1853348 + 1 + (player * 834) + 205 + 20)
end

--- @param player Player
--- @return int
function features.get_deathmatch_lost(player)
	return globals.get_int(1853348 + 1 + (player * 834) + 205 + 21)
end

--- @param player Player
--- @return int
function features.get_sex_acts(player)
	return globals.get_int(1853348 + 1 + (player * 834) + 205 + 54)
end

--- @param player Player
--- @return int
function features.get_private_dances(player)
	return globals.get_int(1853348 + 1 + (player * 834) + 205 + 55)
end

--- @param player Player
--- @return float
function features.get_weapon_acc(player)
	return globals.get_float(1853348 + 1 + (player * 834) + 205 + 57)
end

--- @param player Player
--- @return int
function features.get_wallet(player)
	return globals.get_int(1853348 + 1 + (player * 834) + 205 + 3)
end

--- @param player Player
--- @return int
function features.get_total(player)
	return globals.get_int(1853348 + 1 + (player * 834) + 205 + 56)
end

--- @param player Player
--- @return int
function features.get_rank(player)
	return globals.get_int(1853348 + 1 + (player * 834) + 205 + 6)
end

--- @param player Player
--- @return int
function features.get_xp(player)
	return globals.get_int(1853348 + 1 + (player * 834) + 205 + 1)
end

--- @param player Player
--- @return float
function features.get_mental_state(player)
	return globals.get_float(2689235 + 1 + (player * 453) + 265)
end

--- @param player Player
--- @return string
function features.get_fav_vehicle(player)
	local label = HUD._GET_LABEL_TEXT(VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(globals.get_int(1853348 + 1 + (player * 834) + 205 + 58)))
	return label == "NULL" and TRANSLATION["Unknown"] or label
end

--- @param player Player
--- @return string
function features.get_fav_weapon(player)
	local label = weapons.get_label(globals.get_int(1853348 + 1 + (player * 834) + 205 + 59))
	return label == "NULL" and TRANSLATION["Unknown"] or label
end

--- @param player Player
--- @return string
function features.get_fav_radio(player)
	local radio = globals.get_int(1853348 + 1 + (player * 834) + 205 + 53)
	local label = HUD._GET_LABEL_TEXT(AUDIO.GET_RADIO_STATION_NAME(AUDIO.FIND_RADIO_STATION_INDEX(radio)))
	return label == "NULL" and TRANSLATION["Unknown"] or label
end

--- @param player Player
--- @return bool
function features.has_noragdoll(player)
	return PED.CAN_PED_RAGDOLL(features.player_ped(player)) == 0 and not features.is_player_in_veh(player) and features.get_player_coords(player):sqrlen(features.get_final_cam_pos()) < 22500
end

--- @param rank int
--- @return int
function features.get_xp_for_rank(rank)
	return ranks[rank] or 0
end

--- @param pid Player
--- @return string
function features.get_ply_rank_as_str(pid)
	local rank = features.get_rank(pid)
	local xp_for_rank = features.get_xp_for_rank(rank)
	local xp_for_next = features.get_xp_for_rank(rank + 1)
	local diff = features.get_xp_for_rank(rank + 1) - features.get_xp_for_rank(rank)
	local current = features.get_xp(pid) - features.get_xp_for_rank(rank)
	return (xp_for_rank ~= 0 and xp_for_next ~= 0 and current >= 0) and ("%i + %.1f%%"):format(rank, current * 100 / diff) or tostring(rank)
end

--- @param player Player
--- @return bool
function features.is_player_godmode(player)
	return features.get_godmode(features.player_ped(player))
end

--- @param pid Player
--- @return bool
function features.is_excluded(pid)
	local rid = tostring(online.get_rockstar_id(pid))
	return features.player_excludes[rid] ~= nil
end

--- @param pid Player
--- @return bool
function features.is_friend(pid)
	local is_friend = cache:get("Friend_"..tostring(pid))
	local ptr = s_memory.alloc(104)
	NETWORK.NETWORK_HANDLE_FROM_PLAYER(pid, ptr, 13)
	if NETWORK.NETWORK_IS_HANDLE_VALID(ptr, 13) == 0 then return false end
	if is_friend and not (NETWORK.NETWORK_IS_FRIEND(ptr) == 1) then
		is_friend = true
		cache:set("Friend_"..tostring(pid), false, 1)
	else
		is_friend = (NETWORK.NETWORK_IS_FRIEND(ptr) == 1)
		cache:set("Friend_"..tostring(pid), is_friend, 1)
	end
	return is_friend
end

function features.request_rc_tank()
	globals.set_int(2815059 + 6752, 1)
end

function features.request_rc_car()
	globals.set_int(2815059 + 6751, 1)
end

function features.request_moc()
    globals.set_int(2815059 + 913, 1)
end

function features.request_avenger()
    globals.set_int(2815059 + 921, 1)
end

function features.request_terrorbyte()
    globals.set_int(2815059 + 925, 1)
end

function features.request_kosatka()
    globals.set_int(2815059 + 933, 1)
end

function features.request_dinghy()
    globals.set_int(2815059 + 945, 1)
end

function features.request_ballistic_armor()
    globals.set_int(2815059 + 884, 1)
end

function features.request_airstrike()
    globals.set_int(2815059 + 4455, 1)
end

function features.request_support_heli()
	globals.set_int(2815059 + 4454, 1)
end
local IsFree = switch()
	:case(1, function(dim_max, pos, veh)
    	local poslx = features.get_offset_from_entity_in_world_coords(veh, vector3.left(dim_max.x + .5)) -- left mid
    	local success, groundZ = features.get_ground_z(poslx)
    	if not features.get_raycast_result(pos, poslx, veh).didHit and success and abs(groundZ - pos.z) < 3 then
    		return poslx
    	end
	end)
	:case(2, function(dim_max, pos, veh)
    	local poslx = features.get_offset_from_entity_in_world_coords(veh, vector3(- dim_max.x - .5, 2, 0)) -- left fornt
    	local success, groundZ = features.get_ground_z(poslx)
    	if not features.get_raycast_result(pos, poslx, veh).didHit and success and abs(groundZ - pos.z) < 3 then
    		return poslx
    	end
	end)
	:case(3, function(dim_max, pos, veh)
    	local poslx = features.get_offset_from_entity_in_world_coords(veh, vector3(- dim_max.x - .5, -2, 0)) -- left back
    	local success, groundZ = features.get_ground_z(poslx)
    	if not features.get_raycast_result(pos, poslx, veh).didHit and success and abs(groundZ - pos.z) < 3 then
    		return poslx
    	end
	end)
	:case(4, function(dim_max, pos, veh)
		local posrx = features.get_offset_from_entity_in_world_coords(veh, vector3.right(dim_max.x + .5)) -- right mid
		local success, groundZ = features.get_ground_z(posrx)
    	if not features.get_raycast_result(pos, posrx, veh).didHit and success and abs(groundZ - pos.z) < 3 then
    		return posrx
    	end
	end)
	:case(5, function(dim_max, pos, veh)
    	local posrx = features.get_offset_from_entity_in_world_coords(veh, vector3(dim_max.x + .5, 2, 0)) -- right front
    	local success, groundZ = features.get_ground_z(posrx)
    	if not features.get_raycast_result(pos, posrx, veh).didHit and success and abs(groundZ - pos.z) < 3 then
    		return posrx
    	end
	end)
	:case(6, function(dim_max, pos, veh)
    	local posrx = features.get_offset_from_entity_in_world_coords(veh, vector3(dim_max.x + .5, -2, 0)) -- right back
    	local success, groundZ = features.get_ground_z(posrx)
    	if not features.get_raycast_result(pos, posrx, veh).didHit and success and abs(groundZ - pos.z) < 3 then
    		return posrx
    	end
	end)
	:case(7, function(dim_max, pos, veh)
		if ENTITY.GET_ENTITY_SPEED(veh) > 1 then return end
		local posly = features.get_offset_from_entity_in_world_coords(veh, vector3.forward(dim_max.y + .5)) -- front
		local success, groundZ = features.get_ground_z(posly)
    	if not features.get_raycast_result(pos, posly, veh).didHit and success and abs(groundZ - pos.z) < 3 then
    		return posly
    	end
	end)
	:case(8, function(dim_max, pos, veh)
    	local posry = features.get_offset_from_entity_in_world_coords(veh, vector3.back(dim_max.y + .5)) -- back
    	local success, groundZ = features.get_ground_z(posry)
    	if not features.get_raycast_result(pos, posry, veh).didHit and success and abs(groundZ - pos.z) < 3 then
    		return posry
    	end
	end)
	:default(function(dim_max, pos, veh)
		return pos + vector3.up(dim_max.z) -- top
	end)

--- @param veh Vehicle
--- @return vector3
function features.get_space_near_vehicle(veh)
    local dim_max = select(2, features.get_model_dimentions(ENTITY.GET_ENTITY_MODEL(veh)))
    local pos = features.get_entity_coords(veh)
    for i = 1, 9 do
    	local result = IsFree(i, dim_max, pos, veh)
    	if result then
    		return result
    	end
    end
end

--- @return int
function features.get_collider_usage()
	local handle = memory.read_int64(s_memory.phInstance)
	if handle == 0 then return 0 end
	local usedCollidersOffset = memory.read_int(s_memory.ColliderOffset + 3)
	local maxCollidersOffset = memory.read_int(s_memory.ColliderOffset + 9)
	return memory.read_int(handle + maxCollidersOffset) - memory.read_int(handle + usedCollidersOffset)
end

--- @return bool
function features.can_activate_physics()
	return features.get_collider_usage() > 50
end

--- @param stat int
--- @return float
function stat.get_float(stat)
	local value = s_memory.alloc()
	STATS.STAT_GET_FLOAT(stat, value, -1)
	return memory.read_float(value)
end

--- @return int
function features.get_last_char()
	return stat.get_int(utils.joaat("MPPLY_LAST_MP_CHAR"))
end

--- @param entity Entity
--- @param x float
--- @param y float
--- @param z float
function features.set_entity_velocity(entity, x, y, z)
	if not features.can_activate_physics() then return end
	ENTITY.SET_ENTITY_VELOCITY(entity, x, y, z)
end

--- @param entity Entity
--- @param forceFlags int
--- @param x float
--- @param y float
--- @param z float
--- @param offx float
--- @param offy float
--- @param offz float
--- @param boneIndex int
--- @param isDirectionRel bool
--- @param ignoreUpVec bool
--- @param isForceRel bool
--- @param p12 bool
--- @param p13 bool
function features.apply_force_to_entity(entity, forceFlags, x, y, z, offX, offY, offZ, boneIndex, isDirectionRel, ignoreUpVec, isForceRel, p12, p13)
	if not features.can_activate_physics() then return end
	ENTITY.APPLY_FORCE_TO_ENTITY(entity, forceFlags, x, y, z, offX, offY, offZ, boneIndex, isDirectionRel, ignoreUpVec, isForceRel, p12, p13)
end

--- @param start vector3
--- @param end vector3
--- @param ent_ignore Entity
--- @param falg? int
function features.get_raycast_result(start, end_pos, ent_ignore, flag)
	flag = flag or -1
	local hit, endCoords, surfaceNormal, entityHit = s_memory.alloc(), s_memory.allocv3(), s_memory.allocv3(), s_memory.alloc(8)
	SHAPETEST.GET_SHAPE_TEST_RESULT(
		SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(start.x, start.y, start.z, end_pos.x, end_pos.y, end_pos.z, flag, ent_ignore, 1),
		hit, endCoords, surfaceNormal, entityHit
	)
	return {
		didHit = features.to_bool(memory.read_byte(hit)),
		endCoords = s_memory.readv3(endCoords),
		surfaceNormal = s_memory.readv3(surfaceNormal),
		hitEntity = memory.read_int(entityHit)
	}
end

Global.attachment_bl = {}
--- @param entity Entity
--- @param entities? table
--- @return table
function features.get_all_attachments(entity, entities)
	entities = entities or {}
	for _, v in ipairs(features.get_entities())
	do
		if ENTITY.IS_ENTITY_A_PED(v) then
			local weapo = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(v, 1)
			Global.attachment_bl[weapo] = true
		end
		if ENTITY.GET_ENTITY_ATTACHED_TO(v) == entity then
			if not Global.attachment_bl[v] then
				insert(entities, v)
			end
			features.get_all_attachments(v, entities)
		end
	end
	Global.attachment_bl = {}
	return entities
end

--- @param entity Entity
--- @return Entity
function features.get_parent_attachment(entity)
	if ENTITY.IS_ENTITY_ATTACHED(entity) == 1 then
		return features.get_parent_attachment(ENTITY.GET_ENTITY_ATTACHED_TO(entity))
	else
		return entity
	end
end

--- @param entity Entity
--- @return table
function features.get_entity_proofs(entity)
	local bulletProof, fireProof, explosionProof, collisionProof, meleeProof, steamProof, p7, drownProof = s_memory.alloc_get(8)
	ENTITY._GET_ENTITY_PROOFS(entity, bulletProof, fireProof, explosionProof, collisionProof, meleeProof, steamProof, p7, drownProof)
	return {
		bulletProof 	= features.to_bool(memory.read_byte(bulletProof)),
		fireProof 		= features.to_bool(memory.read_byte(fireProof)),
		explosionProof = features.to_bool(memory.read_byte(explosionProof)),
		collisionProof = features.to_bool(memory.read_byte(collisionProof)),
		meleeProof 		= features.to_bool(memory.read_byte(meleeProof)),
		steamProof 		= features.to_bool(memory.read_byte(steamProof)),
		p7 				= features.to_bool(memory.read_byte(p7)),
		drownProof 		= features.to_bool(memory.read_byte(drownProof))
	}
end

--- @param player? Player
--- @return int
function features.has_player_been_damaged(player)
	local ped = features.player_ped(player)
	if ENTITY.GET_ENTITY_MAX_HEALTH(ped) > ENTITY.GET_ENTITY_HEALTH(ped) and ENTITY.HAS_ENTITY_BEEN_DAMAGED_BY_ANY_PED(ped) == 0 then return -1 end
	for i = 0, 31
	do
		if ENTITY.HAS_ENTITY_BEEN_DAMAGED_BY_ENTITY(ped, features.player_ped(i), true) == 1 then
			return i
		end
	end
	return -1
end

--- @param entity Entity
--- @return bool
function features.get_godmode(entity)
	if ENTITY.DOES_ENTITY_EXIST(entity) == 0 or ENTITY.IS_ENTITY_DEAD(entity, false) == 1 then return false end
	local proofs = features.get_entity_proofs(entity)
	return ENTITY._GET_ENTITY_CAN_BE_DAMAGED(entity) == 0 or (proofs.bulletProof and proofs.fireProof and proofs.explosionProof)
end

--- @param entity Entity
--- @return bool
function features.is_frozen(entity)
	if ENTITY.DOES_ENTITY_EXIST(entity) == 0 then return false end
	return MISC.IS_BIT_SET(memory.handle_to_pointer(entity) + 0x2E, 1) == 1
end

--- @param entity Entity
--- @return bool
function features.has_gravity(entity)
	if ENTITY.DOES_ENTITY_EXIST(entity) == 0 then return false end
	return MISC.IS_BIT_SET(memory.handle_to_pointer(entity) + 26, 4) == 0
end

--- @param entity Entity
--- @return bool
function features.is_invincible(entity)
	if ENTITY.DOES_ENTITY_EXIST(entity) == 0 then return false end
	return MISC.IS_BIT_SET(memory.handle_to_pointer(entity) + 392, 8) == 1
end

local ent = memory.malloc(4)
--- @param entity Entity
--- @return bool
function features.delete_entity(entity)
	if not entity or entity == features.player_ped() or ENTITY.DOES_ENTITY_EXIST(entity) == 0 then return end
	if PED.GET_VEHICLE_PED_IS_IN(features.player_ped(), false) == entity then TASK.CLEAR_PED_TASKS_IMMEDIATELY(features.player_ped()) end
	for _, v in ipairs(features.get_all_attachments(entity))
	do
		features.delete_entity(v)
	end
	entities.request_control(entity, function()
		if ENTITY.DOES_ENTITY_EXIST(entity) == 0 then return end
		ENTITY.SET_ENTITY_COLLISION(entity, false, true)
		ENTITY.DETACH_ENTITY(entity, true, true)
		NETWORK._NETWORK_SET_ENTITY_INVISIBLE_TO_NETWORK(entity, true)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(entity, 0, 0, 0, false, false, false)
		ENTITY.SET_ENTITY_AS_MISSION_ENTITY(entity, true, true)
		memory.write_int(ent, entity)
		ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(ent)
		ENTITY.DELETE_ENTITY(ent)
	end)
	return true
end

--- @param ... Entity
function features.unload_models(...)
	for _, v in ipairs({...}) do
		STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(v)
	end
end

--- @param hashname string|int
--- @return int
--- @return int?
function features.request_model(hashname)
	local hash = 0
	if tonumber(hashname) then 
		hash = tonumber(hashname) 
	else
		hash = utils.joaat(hashname)
	end 
	if STREAMING.IS_MODEL_VALID(hash) == 0 then return 0 end
	STREAMING.REQUEST_MODEL(hash)
	return STREAMING.HAS_MODEL_LOADED(hash), hash
end

--- @param model int
--- @return vector3 min
--- @return vector3 max
function features.get_model_dimentions(model)
	local data = cache:get(tostring(model))
	if data then return vector3(data.minimum), vector3(data.maximum) end
	local vec_min = s_memory.alloc(6 * 4)
	local vec_max = s_memory.alloc(6 * 4)
	MISC.GET_MODEL_DIMENSIONS(model, vec_min, vec_max)
	local minimum = s_memory.readv3(vec_min)
	local maximum = s_memory.readv3(vec_max)
	cache:set(tostring(model), {minimum = minimum, maximum = maximum}, 1000)
	return minimum, maximum
end

--- @param color table
--- @return table
function features.fix_color(color)
	for k, v in pairs(color)
	do
		if features.is_float(v) then
			color[k] = select(2,math.modf(v)) < .5 and floor(v) or ceil(v)
		end
	end
	return color
end

--- @param values any
--- @return bool
function features.is_float(value)
	if type(value) ~= 'number' then return end
	return select(2,math.modf(value)) ~= 0
end

--- @param value float
--- @param to? int
--- @return float
function features.round(value, to)
	return tonumber(format("%."..to.."f", value))
end

--- @param param any
--- @param ... any
--- @return bool
function features.compare(param, ...)
	for _, v in pairs({...})
	do
		if v == param then
			return true
		end
	end
	return false
end

--- @param tabl table
--- @return bool
function features.is_table_empty(tabl)
	if type(tabl) ~= 'table' then return end
	for _ in pairs(tabl)
	do
		return false
	end
	return true
end

--- @param array table
--- @return float
function features.sum_table(array)
	local sum = 0
	for _, v in ipairs(array) do
		sum = sum + v
	end
	return sum
end

local players = {
	kick = {},
	crash = {}
}

--- @param ped? Ped
--- @return vector3
function features.get_bullet_impact(ped)
	ped = ped or PLAYER.PLAYER_PED_ID()
	local vec = s_memory.alloc(6 * 4)
	WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(ped, vec)
	return s_memory.readv3(vec)
end

--- @param player Player
--- @param wanted int
function features.set_wanted_level(player, wanted)
	if PLAYER.IS_PLAYER_PLAYING(player) == 1 then
		PLAYER.REPORT_CRIME(player, 19, wanted)
	end
end

--- @param player Player
--- @param amount? int
function features.set_bounty(player, amount)
	amount = tonumber(amount) or 10000
	for i = 0, 31
	do	
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) ~= 0 then
			online.send_script_event(i, 1915499503, PLAYER.PLAYER_ID(), player, 1, (amount >= 0 and amount <= 10000) and floor(amount) or 10000, 0, 1,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, globals.get_int(1920255 + 9), globals.get_int(1920255 + 10))
		end
	end
end

--- @return table of strings
function features.get_players_names()
	local names = {}
	for i = 0, 31
	do
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 then
			insert(names, online.get_name(i):lower())
		end
	end
	return names
end

--- @param player Player
function features.crash_player(player)
	if (NETWORK.NETWORK_IS_PLAYER_CONNECTED(player) == 0) or (player == PLAYER.PLAYER_ID()) or (players.crash[player] and players.crash[player] > time()) then return end

	system.log('Imagined Menu', format("Sending crash to %s", online.get_name(player)))
	system.notify('Imagined Menu', format(TRANSLATION["Sending crash to %s"], online.get_name(player)), settings.General["HudColorNotifyNormal"])
	-- infinite while loops
	online.send_script_event(player, -555356783, PLAYER.PLAYER_ID(), -72614, 63007, 59027, -12012, -26996, 33398, player)
	online.send_script_event(player, 526822748, PLAYER.PLAYER_ID(), 2147483647, 2147483647, -72614, 63007, 59027, -12012, -26996, 33398, player)
	online.send_script_event(player, 526822748, PLAYER.PLAYER_ID(), 2147483647, 2147483647, -788905164)
	online.send_script_event(player, -555356783, PLAYER.PLAYER_ID(), 4294894682, -4294904289, -788905164)

	players.crash[player] = time() + 10
end

--- @param player Player
function features.kick_player(player)
	if (NETWORK.NETWORK_IS_PLAYER_CONNECTED(player) == 0) or (player == PLAYER.PLAYER_ID()) or (players.kick[player] and players.kick[player] > time()) then return end

	system.log('Imagined Menu', format("Kicking %s", online.get_name(player)))
	system.notify('Imagined Menu', format(TRANSLATION["Kicking %s"], online.get_name(player)), settings.General["HudColorNotifyNormal"])

	if NETWORK.NETWORK_IS_HOST() == 1 then
		NETWORK.NETWORK_SESSION_KICK_PLAYER(player)
	else
		local state = 0
		local wait_time
		system.thread(true, 'player_kick_'..player, function()
			if state == 0 then -- force network bail
				online.send_script_event(player, 1674887089, PLAYER.PLAYER_ID(), globals.get_int(1892703 + (1 + (player * 599) + 510))) 
				online.send_script_event(player, 1674887089, PLAYER.PLAYER_ID(), globals.get_int(1920254))
				state = 1
				wait_time = os.clock() + .1
				return
			elseif state == 1 and wait_time < os.clock() then
				online.send_script_event(player, -1663428414, PLAYER.PLAYER_ID(), get_random_args(15))
				online.send_script_event(player, 608596116, PLAYER.PLAYER_ID(), get_random_args(15))
				online.send_script_event(player, 1781594056, PLAYER.PLAYER_ID(), get_random_args(15))
				online.send_script_event(player, -1427892428, PLAYER.PLAYER_ID(), get_random_args(15))
				online.send_script_event(player, 463008662, PLAYER.PLAYER_ID(), get_random_args(15))
				online.send_script_event(player, -442434037, PLAYER.PLAYER_ID(), get_random_args(15))
				online.send_script_event(player, -2056857136, PLAYER.PLAYER_ID(), get_random_args(15))
				online.send_script_event(player, -1991423686, PLAYER.PLAYER_ID(), 0, 30583, 0, 0, 0, -328966, 2098891836, 0)
				online.send_script_event(player, 2071375245, PLAYER.PLAYER_ID(), 1, -1)
				state = 2
				return
			elseif state == 2 then -- invalid apartment invite
				online.send_script_event(player, -1390976345, PLAYER.PLAYER_ID(), random(32, 2147483647), random(-2147483647, 2147483647), 1, 115, random(-2147483647, 2147483647), random(-2147483647, 2147483647), random(-2147483647, 2147483647))
				online.send_script_event(player, -1390976345, PLAYER.PLAYER_ID(), random(-2147483647, -1), random(-2147483647, 2147483647), 1, 115, random(-2147483647, 2147483647), random(-2147483647, 2147483647), random(-2147483647, 2147483647))
			end
		end)
	end
	players.kick[player] = time() + 10
end

return features