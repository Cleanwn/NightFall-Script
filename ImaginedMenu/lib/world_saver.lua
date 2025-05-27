--
-- made by FoxxDash/aka Ðr ÐºήgΣr & SATTY
--
-- Copyright © 2022 Imagined Menu
--

-- Global to local
local insert = table.insert
local require = require
local tonumber = tonumber
local tostring = tostring
local ipairs = ipairs
local pairs = pairs
local memory = memory
local system = system
local AUDIO = AUDIO
local PED = PED
local PLAYER = PLAYER
local VEHICLE = VEHICLE
local NETWORK = NETWORK
local STREAMING = STREAMING
local ui = ui
local WEAPON = WEAPON
local TASK = TASK
local OBJECT = OBJECT
local ENTITY = ENTITY
local DECORATOR = DECORATOR

local features = require 'features'
local vehicles = require 'vehicle'
local s_memory = require 'script_memory'
local vector3 = require 'vector3'
local peds = require 'peds'
local EntityDb = require 'entity_database'
local json = require 'JSON'
local filesystem = require 'filesys'
local TRANSLATION = require('default').translation
local settings = require('default').settings

local world_saver = {}

local function dynamic_get(ent)
    if EntityDb.IsValid(ent) then
        return ui.get_value(EntityDb.spawned_options[ent].dynamic)
    end
    return true
end

local function gravity_get(ent)
    if EntityDb.IsValid(ent) then
        return ui.get_value(EntityDb.spawned_options[ent].has_gravity)
    end
    return true
end

--- @param ent Entity
--- @param first? bool
--- @return table
function world_saver.get_properties(ent, first)
    first = first ~= nil and first or features.get_parent_attachment(ent) == ent
    local data = {
        parent = first,
        type = ENTITY.GET_ENTITY_TYPE(ent),
        model = ENTITY.GET_ENTITY_MODEL(ent),
        handle_id = ent,
        godmode = features.get_godmode(ent),
        freeze = cache:get("Vehicle") ~= ent and features.is_frozen(ent),
        dynamic = dynamic_get(ent),
        gravity = gravity_get(ent),
        collision = ENTITY.GET_ENTITY_COLLISION_DISABLED(ent) == 0,
        invisible = ENTITY.IS_ENTITY_VISIBLE(ent) == 0,
        attached = ENTITY.IS_ENTITY_ATTACHED(ent) == 1,
        opacity = ENTITY.GET_ENTITY_ALPHA(ent),
        lod_dist = ENTITY.GET_ENTITY_LOD_DIST(ent),
        health = ENTITY.GET_ENTITY_HEALTH(ent)
    }
    if data.type == 1 then
        data.outfit = peds.get_outfit(ent)
        if PED.IS_PED_IN_ANY_VEHICLE(ent, false) == 1 then
            data.in_vehicle = PED.GET_VEHICLE_PED_IS_IN(ent, false)
            local seat_index = -1
            for i = -1, VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(ENTITY.GET_ENTITY_MODEL(data.in_vehicle)) - 2
            do
                if VEHICLE.GET_PED_IN_VEHICLE_SEAT(data.in_vehicle, i, true) == ent then
                    seat_index = i
                    break
                end
            end
            data.seat_index = seat_index
        end
        data.can_ragdoll = PED.CAN_PED_RAGDOLL(ent) == 1
        data.is_tiny = PED.GET_PED_CONFIG_FLAG(ent, 223, false) == 1
        data.armor = PED.GET_PED_ARMOUR(ent)
        data.noflee = EntityDb.IsValid(ent) and ui.get_value(EntityDb.spawned_options[ent].block_flee) or false
        local weap = s_memory.alloc()
        WEAPON.GET_CURRENT_PED_WEAPON(ent, weap, true)
        data.current_weapon = memory.read_int(weap)
        --data.head_blend = peds.get_head_blend(ent)
        --data.overlay = peds.get_ped_overlay(ent)
        data.task_anim = EntityDb.IsValid(ent) and EntityDb.entity_data[ent].task_anim or nil
        data.task_scenario = EntityDb.IsValid(ent) and EntityDb.entity_data[ent].task_scenario or nil
    elseif data.type == 2 then
        local primary, secondary, interior, dashboard = s_memory.alloc_get(4)
        data.light_mult = vehicles.get_lights_intensity(ent),
        VEHICLE.GET_VEHICLE_COLOURS(ent, primary, secondary)
        VEHICLE._GET_VEHICLE_INTERIOR_COLOR(ent, interior)
        VEHICLE._GET_VEHICLE_DASHBOARD_COLOR(ent, dashboard)
        data.colors = {
            paint_fade = VEHICLE.GET_VEHICLE_ENVEFF_SCALE(ent),
            xenons = VEHICLE._GET_VEHICLE_XENON_LIGHTS_COLOR(ent),
            interior = memory.read_int(interior),
            dashboard = memory.read_int(dashboard),
            primary = memory.read_int(primary),
            secondary = memory.read_int(secondary),
            custom_primary = VEHICLE.GET_IS_VEHICLE_PRIMARY_COLOUR_CUSTOM(ent) == 1,
            custom_secondary = VEHICLE.GET_IS_VEHICLE_SECONDARY_COLOUR_CUSTOM(ent) == 1,
        }
        local pearlescentColor, wheelColor, tr, tg, tb = s_memory.alloc_get(5)
        VEHICLE.GET_VEHICLE_TYRE_SMOKE_COLOR(ent, tr, tg, tb)
        VEHICLE.GET_VEHICLE_EXTRA_COLOURS(ent, pearlescentColor, wheelColor)
        data.colors.pearl = memory.read_int(pearlescentColor)
        data.colors.wheel = memory.read_int(wheelColor)
        data.colors.tyre_smoke_r = memory.read_int(tr)
        data.colors.tyre_smoke_g = memory.read_int(tg)
        data.colors.tyre_smoke_b = memory.read_int(tb)
        if data.colors.custom_primary then
            local r, g, b = s_memory.alloc_get(3)
            VEHICLE.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(ent, r, g, b)
            data.colors.custom_1r = memory.read_int(r)
            data.colors.custom_1g = memory.read_int(g)
            data.colors.custom_1b = memory.read_int(b)
        end
        if data.colors.custom_secondary then
            local r, g, b = s_memory.alloc_get(3)
            VEHICLE.GET_VEHICLE_CUSTOM_SECONDARY_COLOUR(ent, r, g, b)
            data.colors.custom_2r = memory.read_int(r)
            data.colors.custom_2g = memory.read_int(g)
            data.colors.custom_2b = memory.read_int(b)
        end
        data.number_plate_index = VEHICLE.GET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(ent)
        data.number_plate_text = VEHICLE.GET_VEHICLE_NUMBER_PLATE_TEXT(ent)
        data.wheel_type = VEHICLE.GET_VEHICLE_WHEEL_TYPE(ent)
        local nr, ng, nb = s_memory.alloc_get(3)
        VEHICLE._GET_VEHICLE_NEON_LIGHTS_COLOUR(ent, nr, ng, nb)
        data.neons = {
            left = VEHICLE._IS_VEHICLE_NEON_LIGHT_ENABLED(ent, 0),
            right = VEHICLE._IS_VEHICLE_NEON_LIGHT_ENABLED(ent, 1),
            front = VEHICLE._IS_VEHICLE_NEON_LIGHT_ENABLED(ent, 2),
            back = VEHICLE._IS_VEHICLE_NEON_LIGHT_ENABLED(ent, 3),
            r = memory.read_int(nr),
            g = memory.read_int(ng),
            b = memory.read_int(nb)
        }
        data.break_door = {}
        data.open_door = {}
        for i = 0, 5
        do
            data.break_door[i] = VEHICLE.IS_VEHICLE_DOOR_DAMAGED(ent, i) == 1
            data.open_door[i] = VEHICLE.GET_VEHICLE_DOOR_ANGLE_RATIO(ent, i) ~= 0
        end
        data.mods = {}
        for i = 0, 49
        do
            if i < 17 or i > 22 then
                data.mods[i] = {VEHICLE.GET_VEHICLE_MOD(ent, i), VEHICLE.GET_VEHICLE_MOD_VARIATION(ent, i) == 1}
            else
                data.mods[i] = VEHICLE.IS_TOGGLE_MOD_ON(ent, i) == 1
            end
        end
        data.bullet_proof_tyres = VEHICLE.GET_VEHICLE_TYRES_CAN_BURST(ent) == 0
        data.drift_tires = VEHICLE._GET_DRIFT_TYRES_ENABLED(ent) == 1
        data.window_tint = VEHICLE.GET_VEHICLE_WINDOW_TINT(ent)
        data.door_lock_status = VEHICLE.GET_VEHICLE_DOOR_LOCK_STATUS(ent)
        data.engine_on = VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(ent) == 1
        data.siren = VEHICLE.IS_VEHICLE_SIREN_ON(ent) == 1
        data.engine_sound = EntityDb.IsValid(ent) and EntityDb.entity_data[ent].engine_sound or ""
        data.torque_multiplier = vehicles.get_torque_mult(ent)
        data.rpm_multiplier = vehicles.get_rpm_mult(ent)
        data.dirt_level = VEHICLE.GET_VEHICLE_DIRT_LEVEL(ent)
        local lightsOn, highbeamsOn = s_memory.alloc_get(2)
        VEHICLE.GET_VEHICLE_LIGHTS_STATE(ent, lightsOn, highbeamsOn)
        local light_mode
        if memory.read_byte(highbeamsOn) == 1 then
            light_mode = 2
        elseif memory.read_byte(lightsOn) == 1 then
            light_mode = 1
        else
            light_mode = 0
        end
        data.lights = light_mode
        data.extra = {}
        for i = 0, 20
        do
            if VEHICLE.DOES_EXTRA_EXIST(ent, i) == 1 then
                data.extra[i] = VEHICLE.IS_VEHICLE_EXTRA_TURNED_ON(ent, i) == 1
            end
        end
        data.tyres_bursted = {}
        for i = 0, 5
        do
            data.tyres_bursted[i] = VEHICLE.IS_VEHICLE_TYRE_BURST(ent, i, true) == 1
        end
        data.livery = VEHICLE.GET_VEHICLE_LIVERY(ent)
        data.roofstate = VEHICLE.GET_CONVERTIBLE_ROOF_STATE(ent)
        data.render_scorched = features.is_render_scorched(ent)
        data.reduce_grip = vehicles.has_reduced_grip(ent)
    elseif data.type == 3 then
        data.texture = OBJECT._GET_OBJECT_TEXTURE_VARIATION(ent)
    end
    data.position = features.get_entity_coords(ent)
    data.position.pitch = ENTITY.GET_ENTITY_PITCH(ent)
    data.position.roll = ENTITY.GET_ENTITY_ROLL(ent)
    data.position.yaw = features.get_entity_rot(ent).z
    if data.attached then
        local parent_of_attachment = ENTITY.GET_ENTITY_ATTACHED_TO(ent)

        if EntityDb.IsValid(ent) and EntityDb.entity_data[ent].is_attached then
            data.attachment = {
                attached_to = ENTITY.GET_ENTITY_ATTACHED_TO(ent),
                bone = EntityDb.entity_data[ent].attach_bone,
                pos = vector3(EntityDb.entity_data[ent].attachx, EntityDb.entity_data[ent].attachy, EntityDb.entity_data[ent].attachz),
                pitch = EntityDb.entity_data[ent].pitch,
                roll = EntityDb.entity_data[ent].roll,
                yaw = EntityDb.entity_data[ent].yaw
            }
        else
            local offset = vector3(ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ent, 0, 0, VEHICLE._GET_VEHICLE_SUSPENSION_HEIGHT(ent) ~= -1 and VEHICLE._GET_VEHICLE_SUSPENSION_HEIGHT(ent) or 0))
            local offpos1 = vector3(ENTITY.GET_OFFSET_FROM_ENTITY_GIVEN_WORLD_COORDS(ent, offset.x, offset.y, offset.z))
            local offset = vector3(ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(parent_of_attachment, 0, 0, VEHICLE._GET_VEHICLE_SUSPENSION_HEIGHT(parent_of_attachment) ~= -1 and VEHICLE._GET_VEHICLE_SUSPENSION_HEIGHT(ENTITY.GET_ENTITY_ATTACHED_TO(ent)) or 0))
            local offpos2 = vector3(ENTITY.GET_OFFSET_FROM_ENTITY_GIVEN_WORLD_COORDS(parent_of_attachment, offset.x, offset.y, offset.z))
            local pos = features.get_entity_coords(ent) + offpos1 + offpos2
            local rot1 = features.get_entity_rot(parent_of_attachment)
            local rot2 = features.get_entity_rot(ent)
            local pitch, roll, yaw = (rot2 - rot1):get()
            data.attachment = {
                attached_to = parent_of_attachment,
                bone = 0,
                pos = vector3(ENTITY.GET_OFFSET_FROM_ENTITY_GIVEN_WORLD_COORDS(parent_of_attachment, pos.x, pos.y, pos.z)),
                pitch = pitch,
                roll = roll,
                yaw = yaw
            }
        end
    end
    return data
end

--- @param veh Entity
--- @param tick int
--- @return bool
function world_saver.save_vehicle(veh, tick)
    if tick == 0 then
        cache:set("Vehicle", features.get_parent_attachment(veh))
        cache:set("Rotation", features.get_entity_rot(cache:get("Vehicle")))
        cache:set("Velocity", ENTITY.GET_ENTITY_VELOCITY(cache:get("Vehicle")))
        ENTITY.SET_ENTITY_ROTATION(cache:get("Vehicle"), 0, 0, 0, 2, true)
        ENTITY.SET_ENTITY_VELOCITY(cache:get("Vehicle"), 0, 0, 0)
        ENTITY.FREEZE_ENTITY_POSITION(cache:get("Vehicle"), true)
        return
    elseif tick == 1 then
        ENTITY.FREEZE_ENTITY_POSITION(cache:get("Vehicle"), true)
        ENTITY.PROCESS_ENTITY_ATTACHMENTS(cache:get("Vehicle"))
        return
    end
    local Veh = {}
    insert(Veh, world_saver.get_properties(cache:get("Vehicle"), true))
    for _, v in ipairs(features.get_all_attachments(cache:get("Vehicle")))
    do
        insert(Veh, world_saver.get_properties(v, false))
    end
    cache:set('Save Veh', Veh)
    ENTITY.FREEZE_ENTITY_POSITION(cache:get("Vehicle"), false)
    local Rot = cache:get("Rotation")
    ENTITY.SET_ENTITY_ROTATION(cache:get("Vehicle"), Rot.x, Rot.y, Rot.z, 2, true)
    local Velocity = cache:get("Velocity")
    ENTITY.SET_ENTITY_VELOCITY(cache:get("Vehicle"), Velocity.x, Velocity.y, Velocity.z)
    cache:delete("Vehicle")
    return true
end

--- @param entities table
--- @param path string
--- @param refernce_pos vector3
function world_saver.save_map(entities, path, refernce_pos)
    local data = {}
    for _, v in ipairs(entities) do
        insert(data, world_saver.get_properties(v))
    end
    system.notify(TRANSLATION["Imagined Menu"], string.format(TRANSLATION["Saved %i entities"], #data), settings.General["HudColorNotifySuccess"], true)
    insert(data, {reference = refernce_pos})
    filesystem.write(json:encode_pretty(data), path)
end

return world_saver