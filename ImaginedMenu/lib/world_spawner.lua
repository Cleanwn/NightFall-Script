--
-- made by FoxxDash/aka Ðr ÐºήgΣr & SATTY
--
-- Copyright © 2022 Imagined Menu
--

-- Global to local
local insert = table.insert
local require = require
local tonum = tonumber
local tostring = tostring
local ipairs = ipairs
local pairs = pairs
local memory = memory
local system = system
local entities = entities
local AUDIO = AUDIO
local PED = PED
local PLAYER = PLAYER
local VEHICLE = VEHICLE
local NETWORK = NETWORK
local STREAMING = STREAMING
local WEAPON = WEAPON
local TASK = TASK
local OBJECT = OBJECT
local ENTITY = ENTITY

local features = require 'features'
local switch = require 'switch'
local vehicles = require 'vehicle'
local vector3 = require 'vector3'
local peds = require 'peds'
local EntityDb = require 'entity_database'
local world_saver = require 'world_saver'
local xml2lua = require "xml2lua"
local handler = require "xmlhandler.tree"
local TRANSLATION = require('default').translation
local settings = require('default').settings
local world_spawner = {}
local xml_handle
local spawned = 0
local failed_to_spawn = 0
local new_request = {}

local tonumber = function (num)
    return tonum(num) or 0
end

--- @param data table
--- @return int
function world_spawner.request(data)
    system.notify(TRANSLATION['Info'], TRANSLATION['Waiting for models to load...'], settings.General["HudColorNotifyNormal"])
    for _, v in ipairs(data)
    do
        if v.model then
            local loaded, hash = features.request_model(v.model)
            if not hash then system.notify(TRANSLATION["Error"], TRANSLATION["Something went wrong"], settings.General["HudColorNotifyError"]) return -1 end
            if loaded == 0 then return 0 end
        end
    end
    return 1
end

--- @param data table
--- @return bool
function world_spawner.unload(data)
    for _, v in ipairs(data)
    do
        if v.model then
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(v.model)
        end
    end
    return true
end

--- @param properties table
--- @return table
local function get_menyoo_outfit(properties)
    local out = {
        components = {},
        props = {}
    }
    for k, v in pairs(properties.PedComps or {})
    do
        v = type(v) == "string" and v:split(",", "")
        out.components[k:gsub("_", "")] = {tonumber(v[1]), tonumber(v[1])}
    end
    for k, v in pairs(properties.PedProps or {})
    do
        v = type(v) == "string" and v:split(",", "")
        out.props[k:gsub("_", "")] = {tonumber(v[1]), tonumber(v[1])}
    end
    return out
end

--- @param modes string
--- @return bool
local function get_veh_mods(mods)
    if type(mods) == "string" and mods:find(",") then
        mods = mods:split(",", true)
        return {tonumber(mods[1]), features.to_bool(mods[2])}
    end
    return features.to_bool(mods)
end

--- @param data table
--- @return int
local function get_type(data)
    if data.Type then
        return tonumber(data.Type)
    end
    return 2
end

--- @param data_in table
--- @return table
local function get_properties(data_in)
    local data = {}
    data.parent = not data_in.Attachment
    data.type = get_type(data_in)
    data.model = tonumber(data_in.ModelHash)
    data.handle_id = tonumber(data_in.InitialHandle)
    data.godmode = features.to_bool(data_in.IsInvincible)
    data.freeze = features.to_bool(data_in.FrozenPos)
    data.dynamic = features.to_bool(data_in.Dynamic)
    data.gravity = features.to_bool(data_in.HasGravity)
    data.collision = true
    data.invisible = not features.to_bool(data_in.IsVisible)
    data.attached = data_in.Attachment and data_in.Attachment.AttachedTo ~= nil
    data.opacity = tonumber(data_in.OpacityLevel)
    data.lod_dist = tonumber(data_in.LodDistance)
    data.health = tonumber(data_in.Health)
    if data.type == 1 and data_in.PedProperties then
        data.outfit = get_menyoo_outfit(data_in.PedProperties)
        data.can_ragdoll = features.to_bool(data_in.PedProperties.CanRagdoll)
        data.armor = features.to_bool(data_in.PedProperties.Armour)
        data.noflee = features.to_bool(data_in.PedProperties.IsStill)
        data.current_weapon = tonumber(data_in.PedProperties.CurrentWeapon)
        if features.to_bool(data_in.PedProperties.AnimActive) then
            data.task_anim = {
                dict = data_in.PedProperties.AnimDict,
                name = data_in.PedProperties.AnimName,
                blend_in = 8,
                blend_out = -8,
                playback = 0,
                duration = -1,
                flags = 1
            }
        end
         if features.to_bool(data_in.PedProperties.ScenarioActive) then
            data.task_scenario = data_in.PedProperties.ScenarioName
        end
        if data_in.TaskSequence then
            for k, v in pairs(data_in.TaskSequence or {})
            do
                if tonumber(v.Type) == 14 and not data.task_anim then
                    data.task_anim = {
                        dict = v.AnimDict,
                        name = v.AnimName,
                        blend_in = tonumber(v.Speed),
                        blend_out = tonumber(v.SpeedMultiplier),
                        playback = 0,
                        duration = tonumber(v.Duration),
                        flags = tonumber(v.Flag)
                    }
                end
                if tonumber(v.Type) == 32 and not data.in_vehicle then
                    data.in_vehicle = v.VehicleInitHandle
                    data.seat_index = v.SeatIndex
                end
            end
        end
    elseif data.type == 2 and data_in.VehicleProperties then
        local color = data_in.VehicleProperties.Colours
        data.light_mult = 1
        data.colors = {
            paint_fade = tonumber(data_in.VehicleProperties.PaintFade),
            xenons = color and tonumber(color.LrXenonHeadlights),
            interior = color and tonumber(color.LrInterior),
            dashboard = color and tonumber(color.LrDashboard),
            primary = color and tonumber(color.Primary),
            secondary = color and tonumber(color.Secondary),
            custom_primary = color and features.to_bool(color.IsPrimaryColourCustom),
            custom_secondary = color and features.to_bool(color.IsSecondaryColourCustom),
            pearl = color and tonumber(color.Pearl),
            wheel = color and tonumber(color.Rim),
            tyre_smoke_r = color and tonumber(color.tyreSmoke_R),
            tyre_smoke_g = color and tonumber(color.tyreSmoke_G),
            tyre_smoke_b = color and tonumber(color.tyreSmoke_B)
        }
        if color.IsPrimaryColourCustom then
            data.colors.custom_1r = tonumber(color.Cust1_R)
            data.colors.custom_1g = tonumber(color.Cust1_G)
            data.colors.custom_1b = tonumber(color.Cust1_B)
        end
        if color.IsSecondaryColourCustom then
            data.colors.custom_2r = tonumber(color.Cust2_R)
            data.colors.custom_2g = tonumber(color.Cust2_G)
            data.colors.custom_2b = tonumber(color.Cust2_B)
        end
        data.number_plate_index = tonumber(data_in.VehicleProperties.NumberPlateIndex)
        data.number_plate_text = tostring(data_in.VehicleProperties.NumberPlateText)
        data.wheel_type = tonumber(data_in.VehicleProperties.WheelType)
        local neons = data_in.VehicleProperties.Neons
        data.neons = {
            left = (neons and features.to_bool(neons.Left)) and 1 or 0,
            right = (neons and features.to_bool(neons.Right)) and 1 or 0,
            front = (neons and features.to_bool(neons.Front)) and 1 or 0,
            back = (neons and features.to_bool(neons.Back)) and 1 or 0,
            r = neons and tonumber(neons.R),
            g = neons and tonumber(neons.G),
            b = neons and tonumber(neons.B)
        }
        local doorsb = data_in.VehicleProperties.DoorsBroken
        data.break_door = {
            [0] = doorsb and features.to_bool(doorsb.FrontLeftDoor),
            doorsb and features.to_bool(doorsb.FrontRightDoor),
            doorsb and features.to_bool(doorsb.BackLeftDoor),
            doorsb and features.to_bool(doorsb.BackRightDoor),
            doorsb and features.to_bool(doorsb.Hood),
            doorsb and features.to_bool(doorsb.Trunk),
        }
        local doorso = data_in.VehicleProperties.DoorsOpen
        data.open_door = {
            [0] = doorso and features.to_bool(doorso.FrontLeftDoor),
            doorso and features.to_bool(doorso.FrontRightDoor),
            doorso and features.to_bool(doorso.BackLeftDoor),
            doorso and features.to_bool(doorso.BackRightDoor),
            doorso and features.to_bool(doorso.Hood),
            doorso and features.to_bool(doorso.Trunk),
        }
        local mods = data_in.VehicleProperties.Mods
        data.mods = {}
        for k, v in pairs(mods or {}) do
            data.mods[k:gsub("_", "")] = get_veh_mods(v)
        end
        data.bullet_proof_tyres = features.to_bool(data_in.VehicleProperties.BulletProofTyres)
        data.window_tint = tonumber(data_in.VehicleProperties.WindowTint)
        data.door_lock_status = tonumber(data_in.VehicleProperties.LockStatus)
        data.engine_on = features.to_bool(data_in.VehicleProperties.EngineOn)
        data.siren = features.to_bool(data_in.VehicleProperties.SirenActive)
        data.engine_sound = type(data_in.VehicleProperties.EngineSoundName) ~= "table" and tostring(data_in.VehicleProperties.EngineSoundName) or ""
        data.torque_multiplier = data_in.VehicleProperties.TorqueMultiplier and tonumber(data_in.VehicleProperties.TorqueMultiplier) or 1
        data.rpm_multiplier = data_in.VehicleProperties.RpmMultiplier and tonumber(data_in.VehicleProperties.RpmMultiplier) or 1
        data.dirt_level = tonumber(data_in.VehicleProperties.DirtLevel)
        data.extra = {}
        for k, v in pairs(data_in.VehicleProperties.ModExtras or {})
        do
            data.extra[k:gsub("_", "")] = features.to_bool(v)
        end
        local tyres = data_in.VehicleProperties.TyresBursted
        data.tyres_bursted = {
            [0] = tyres and features.to_bool(tyres.FrontLeft),
            tyres and features.to_bool(tyres.FrontRight),
            tyres and features.to_bool(tyres._2),
            tyres and features.to_bool(tyres._3),
            tyres and features.to_bool(tyres.BackLeft),
            tyres and features.to_bool(tyres.BackRight),
        }
        data.livery = tonumber(data_in.VehicleProperties.Livery)
    elseif data.type == 3 and data_in.ObjectProperties then
        data.texture = tonumber(data_in.ObjectProperties.TextureVariation)
    end
    if data_in.PositionRotation then
        data.position = vector3(tonumber(data_in.PositionRotation.X),tonumber(data_in.PositionRotation.Y),tonumber(data_in.PositionRotation.Z))
        data.position.pitch = tonumber(data_in.PositionRotation.Pitch)
        data.position.roll = tonumber(data_in.PositionRotation.Roll)
        data.position.yaw = tonumber(data_in.PositionRotation.Yaw)
    end
    if data.attached then
        data.attachment = {
            attached_to = tonumber(data_in.Attachment.AttachedTo),
            bone = tonumber(data_in.Attachment.BoneIndex),
            pos = vector3(tonumber(data_in.Attachment.X),tonumber(data_in.Attachment.Y),tonumber(data_in.Attachment.Z)),
            pitch = tonumber(data_in.Attachment.Pitch),
            roll = tonumber(data_in.Attachment.Roll),
            yaw = tonumber(data_in.Attachment.Yaw)
        }
    end
    return data
end

--- @param data_in table
--- @param data_out? table
--- @return table
local function copy_ent_data(data_in, data_out)
    local data_out = data_out or {}
    if xml_handle.root.Vehicle then
        local data = get_properties(data_in)
        if data_in.SpoonerAttachments then
            for _, v in pairs(data_in.SpoonerAttachments.Attachment)
            do
                copy_ent_data(v, data_out)
            end
        end
        insert(data_out, data)
    elseif xml_handle.root.SpoonerPlacements then
        local root = xml_handle.root.SpoonerPlacements
        for k, v in pairs(root.Placement)
        do
            insert(data_out, get_properties(v))
        end
        local pos = root.ReferenceCoords
        insert(data_out, {
            reference = vector3(tonumber(pos.X),tonumber(pos.Y),tonumber(pos.Z))
        })
    end
    return data_out
end

--- @param file string
--- @return table
function world_spawner.xml_to_entity(file)
    xml_handle = handler:new()
    local parser = xml2lua.parser(xml_handle)
    parser:parse(xml2lua.loadFile(file))
    return copy_ent_data(xml_handle.root.Vehicle or xml_handle.root.SpoonerPlacements)
end

--- @param entity table
--- @param spawn_i int request index
--- @param pos vector3
--- @param id int spawn Id
--- @return Entity
function world_spawner.spawn(entity, spawn_i, pos, id)
    local data = entity[id]
    if data.reference or new_request[spawn_i][data.handle_id] then return end
    local SpawnEntity = switch()
        :case(1, function()
            return peds.create_ped(data.model, pos)
        end)
        :case(2, function()
            return vehicles.spawn_vehicle(data.model, pos)
        end)
        :case(3, function()
            local ent = features.create_object(data.model, pos)
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(ent), true)
            NETWORK._NETWORK_SET_ENTITY_INVISIBLE_TO_NETWORK(ent, false)
            return ent
        end)
    local ent = SpawnEntity(data.type)
    if ent == 0 then failed_to_spawn = failed_to_spawn + 1;system.log('Imagined Menu', "Failed to spawn entity model: "..data.model.." | "..tostring(STREAMING.IS_MODEL_VALID(data.model) and "Valid" or "Invalid").." | Handle: "..data.handle_id.." | Type: "..data.type) end
    EntityDb.AddEntityToDatabase(ent)
    if data.position then
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(ent, data.position.x, data.position.y, data.position.z, false, false, false)
        ENTITY.SET_ENTITY_ROTATION(ent, data.position.pitch, data.position.roll, data.position.yaw, 2, true)
    end
    if not new_request[spawn_i].parent and data.parent then
        new_request[spawn_i].parent = ent
    end
    new_request[spawn_i][data.handle_id] = ent
    if data.godmode then
        features.set_godmode(ent, data.godmode)
    end
    if data.gravity ~= nil then
        ENTITY.SET_ENTITY_HAS_GRAVITY(ent, data.gravity)
    end
    if data.dynamic ~= nil then
        ENTITY.SET_ENTITY_DYNAMIC(ent, data.dynamic)
    end
    ENTITY.SET_ENTITY_HEALTH(ent, data.health, 0)
    if data.type == 1 then
        peds.apply_outfit(data.outfit.components, data.outfit.props, ent)
        if data.godmode then
            peds.set_ped_god(ent)
        end
        if data.in_vehicle then
            PED.SET_PED_INTO_VEHICLE(ent, new_request[spawn_i][data.in_vehicle], data.seat_index)
        end
        if data.noflee then
            peds.calm_ped(ent, true)
        end
        if data.armor then
            PED.SET_PED_ARMOUR(ent, data.armor)
        end
        if data.can_ragdoll ~= nil then
            PED.SET_PED_CAN_RAGDOLL(ent, data.can_ragdoll)
            PED.SET_PED_CAN_RAGDOLL_FROM_PLAYER_IMPACT(ent, data.can_ragdoll)
        end
        if data.is_tiny then
            PED.SET_PED_CONFIG_FLAG(ent, 223, true)
        end
        if data.current_weapon then
            WEAPON.GIVE_WEAPON_TO_PED(ent, data.current_weapon, 9999, false, true)
            WEAPON.SET_CURRENT_PED_WEAPON(ent, data.current_weapon, true)
        end
        -- if data.head_blend then
        --     peds.set_ped_head_blend(ent, data.head_blend)
        -- end
        -- if data.overlay then
        --     peds.set_ped_head_blend(ent, data.overlay)
        -- end
        EntityDb.entity_data[ent].noflee = data.noflee
        if data.task_anim then
            EntityDb.entity_data[ent].task_anim = data.task_anim
            EntityDb.TaskAnim(ent)
        end
        if data.task_scenario then
            EntityDb.entity_data[ent].task_scenario = data.task_scenario
            peds.play_scenario(ent, data.task_scenario)
        end
    elseif data.type == 2 then
        -- DECORATOR.DECOR_SET_INT(ent, "MPBitset", 1024)
        VEHICLE.SET_VEHICLE_MOD_KIT(ent, 0)
        vehicles.repair(ent)
        if data.godmode then
            vehicles.set_godmode(ent, data.godmode)
        end
        if data.colors.paint_fade then
            VEHICLE.SET_VEHICLE_ENVEFF_SCALE(ent, data.colors.paint_fade)
        end
        if data.colors.interior then
            VEHICLE._SET_VEHICLE_INTERIOR_COLOR(ent, data.colors.interior)
        end
        if data.colors.dashboard then
            VEHICLE._SET_VEHICLE_DASHBOARD_COLOR(ent, data.colors.dashboard)
        end
        if data.colors.xenons then
            VEHICLE._SET_VEHICLE_XENON_LIGHTS_COLOR(ent, data.colors.xenons)
        end
        VEHICLE.SET_VEHICLE_COLOURS(ent, data.colors.primary, data.colors.secondary)
        if data.colors.custom_primary then
            VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(ent, data.colors.custom_1r, data.colors.custom_1g, data.colors.custom_1b)
        end
        if data.colors.custom_secondary then
            VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(ent, data.colors.custom_2r, data.colors.custom_2g, data.colors.custom_2b)
        end
        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(ent, data.colors.pearl, data.colors.wheel)
        VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(ent , data.colors.tyre_smoke_r, data.colors.tyre_smoke_g, data.colors.tyre_smoke_b)
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(ent, data.number_plate_index)
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(ent, data.number_plate_text)
        VEHICLE.SET_VEHICLE_WHEEL_TYPE(ent, data.wheel_type)
        if data.engine_sound ~= '' then
            AUDIO._FORCE_VEHICLE_ENGINE_AUDIO(ent, data.engine_sound)
        end
        for k, v in pairs(data.mods)
        do
            local i = tonumber(k)
            if i < 17 or i > 22 and v[1] ~= -1 then
                VEHICLE.SET_VEHICLE_MOD(ent, i, v[1], v[2])
            else
                VEHICLE.TOGGLE_VEHICLE_MOD(ent, i, v)
            end
        end

        if data.extra then
            for k, v in pairs(data.extra)
            do
                local i = tonumber(k)
                VEHICLE.SET_VEHICLE_EXTRA(ent, i, not v)
            end
        end

        VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(ent, not data.bullet_proof_tyres)
        for k, v in pairs(data.tyres_bursted)
        do
            local i = tonumber(k)
            if v then
                VEHICLE.SET_VEHICLE_TYRE_BURST(ent, i, true, 1000.0)
            end
        end
        VEHICLE._SET_DRIFT_TYRES_ENABLED(ent, data.drift_tires)
        VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(ent, 0, data.neons.left == 1)
        VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(ent, 1, data.neons.right == 1)
        VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(ent, 2, data.neons.front == 1)
        VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(ent, 3, data.neons.back == 1)
        VEHICLE._SET_VEHICLE_NEON_LIGHTS_COLOUR(ent, data.neons.r, data.neons.g, data.neons.b)
        VEHICLE.SET_VEHICLE_WINDOW_TINT(ent, data.window_tint)
        VEHICLE.SET_VEHICLE_ENGINE_ON(ent, data.engine_on, true, false)
        VEHICLE.SET_VEHICLE_SIREN(ent, data.siren)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED(ent, data.door_lock_status)
        vehicles.set_torque_mult(ent, data.torque_multiplier)
        if data.rmp_multiplier then data.rpm_multiplier = data.rmp_multiplier end
        vehicles.set_rpm_mult(ent, data.rpm_multiplier)
        VEHICLE.SET_VEHICLE_DIRT_LEVEL(ent, data.dirt_level)
        VEHICLE._SET_VEHICLE_LIGHTS_MODE(ent, data.lights)
        VEHICLE.SET_VEHICLE_LIVERY(ent, data.livery)
        local Roof = switch()
            :case(0, function()
                VEHICLE.RAISE_CONVERTIBLE_ROOF(ent, true)
            end)
            :case(1, function()
                VEHICLE.LOWER_CONVERTIBLE_ROOF(ent, false)
            end)
            :case(2, function()
                VEHICLE.LOWER_CONVERTIBLE_ROOF(ent, true)
            end)
            :case(3, function()
                VEHICLE.LOWER_CONVERTIBLE_ROOF(ent, true)
                VEHICLE.RAISE_CONVERTIBLE_ROOF(ent, false)
            end)

        Roof(data.roofstate)
        for k, v in pairs(data.open_door)
        do
            local i = tonumber(k)
            if data.open_door[k] then
                VEHICLE.SET_VEHICLE_DOOR_OPEN(ent, i, false, true)
            end
            if data.break_door[k] then
                VEHICLE._SET_VEHICLE_DOOR_CAN_BREAK(ent, i, true)
                VEHICLE.SET_VEHICLE_DOOR_BROKEN(ent, i, true)
            end
        end
        VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(ent, data.light_mult or 1)
        if data.render_scorched then
            ENTITY.SET_ENTITY_RENDER_SCORCHED(ent, true)
        end
        if data.reduce_grip then
            VEHICLE.SET_VEHICLE_REDUCE_GRIP(ent, true)
        end
    elseif data.type == 3 then
        OBJECT._SET_OBJECT_TEXTURE_VARIATION(ent, data.texture)
    end

    if data.opacity ~= 255 then
        ENTITY.SET_ENTITY_ALPHA(ent, data.opacity, false)
    end
    ENTITY.SET_ENTITY_LOD_DIST(ent, data.lod_dist)
    ENTITY.FREEZE_ENTITY_POSITION(ent, data.freeze)
    ENTITY.SET_ENTITY_COLLISION(ent, data.collision, true)
    ENTITY.SET_ENTITY_VISIBLE(ent, not data.invisible, false)
    if not data.attached then return ent end
    if new_request[spawn_i][data.attachment.attached_to] == ent then return ent end -- don't attach to itself
    local found = true
    if not new_request[spawn_i][data.attachment.attached_to] then -- checks if entity to attach exist
        found = false
        for i, v in ipairs(entity)
        do
            if v.handle_id == data.attachment.attached_to then
                world_spawner.spawn(entity, spawn_i, pos, i)
                found = true
                break
            end
        end
    end
    if not found then return ent end
    ENTITY.ATTACH_ENTITY_TO_ENTITY(ent, new_request[spawn_i][data.attachment.attached_to], data.attachment.bone,
        data.attachment.pos.x, data.attachment.pos.y, data.attachment.pos.z,
        data.attachment.pitch, data.attachment.roll, data.attachment.yaw,
        false, true, data.collision, data.type == 1, 2, true
    )
    if EntityDb.entity_data[ent] then
        EntityDb.entity_data[ent].attach_bone = data.attachment.bone
        EntityDb.entity_data[ent].attachx = data.attachment.pos.x
        EntityDb.entity_data[ent].attachy = data.attachment.pos.y
        EntityDb.entity_data[ent].attachz = data.attachment.pos.z
        EntityDb.entity_data[ent].pitch = data.attachment.pitch
        EntityDb.entity_data[ent].roll = data.attachment.roll
        EntityDb.entity_data[ent].yaw = data.attachment.yaw
    end
    return ent
end

--- @param vehicle table
--- @param conf? table
--- @param clone? Vehicle
function world_spawner.create_vehicle(vehicle, conf, clone)
    system.thread(true, 'request_model_'..system.thread_count(), function()
        local result = world_spawner.request(vehicle)
        if result == -1 then return 0 end -- invalid model
        if result == 0 then return end -- not loaded
        spawned = spawned + 1
        local spawn_i = spawned
        new_request[spawn_i] = {}
        local pos = features.get_offset_from_player_coords(vector3(0,8,0))
        failed_to_spawn = 0
        for i, v in ipairs(vehicle)
        do
            local ent = world_spawner.spawn(vehicle, spawn_i, pos, i)
            if ent and not settings.Vehicle["AddToDb"] then
                EntityDb.entity_data[ent] = nil
            end
        end
        if failed_to_spawn > 0 then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Failed to spawn %i entities"]:format(failed_to_spawn), settings.General["HudColorNotifyError"]) end
        world_spawner.unload(vehicle)
        local prev_veh = vehicles.get_player_vehicle()
        local velocity
        if conf and settings.Vehicle["SpawnerKeepSpeed"] and settings.Vehicle["SpawnerInside"] and prev_veh ~= 0 then
            velocity = ENTITY.GET_ENTITY_VELOCITY(prev_veh)
        end
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(new_request[spawn_i].parent, pos.x, pos.y, pos.z, false, false, false)
        ENTITY.SET_ENTITY_HEADING(new_request[spawn_i].parent, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
        if conf and settings.Vehicle["SpawnerKeepSpeed"] and settings.Vehicle["SpawnerInside"] and prev_veh ~= 0 then
            velocity = ENTITY.GET_ENTITY_VELOCITY(prev_veh)
        end
        if conf and settings.Vehicle["SpawnerDeleteOld"] and prev_veh ~= 0 then
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
            features.delete_entity(prev_veh)
        end
        if velocity then
            ENTITY.SET_ENTITY_VELOCITY(new_request[spawn_i].parent, velocity.x, velocity.y, velocity.z)
        end
        if settings.Vehicle["SpawnerInside"] then
            PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), new_request[spawn_i].parent, -1)
        end
        if clone then
            VEHICLE.COPY_VEHICLE_DAMAGES(clone, new_request[spawn_i].parent)
            ENTITY.SET_ENTITY_COLLISION(new_request[spawn_i].parent, true, true)
            ENTITY.RESET_ENTITY_ALPHA(new_request[spawn_i].parent)
        end
        return 0
    end)
end

--- @param data table
--- @param no_db? bool
function world_spawner.spawn_map(data, no_db, copy)
    system.thread(true, 'request_model_'..system.thread_count(), function()
        local result = world_spawner.request(data)
        if result == -1 then return 0 end -- invalid model
        if result == 0 then return end -- not loaded
        spawned = spawned + 1
        local spawn_i = spawned
        new_request[spawn_i] = {}
        failed_to_spawn = 0
        for i, v in ipairs(data)
        do
            local ent = world_spawner.spawn(data, spawn_i, vector3(), i)
            if i == 1 and ent and copy then
                entities.request_control(ent, function()
                    ENTITY.ATTACH_ENTITY_TO_ENTITY(ent, v.attachment.attached_to, v.attachment.bone,
                        v.attachment.pos.x, v.attachment.pos.y, v.attachment.pos.z,
                        v.attachment.pitch, v.attachment.roll, v.attachment.yaw,
                        false, true, v.collision, v.type == 1, 2, true
                    )
                    if EntityDb.entity_data[ent] then
                        EntityDb.entity_data[ent].attach_bone = v.attachment.bone
                        EntityDb.entity_data[ent].attachx = v.attachment.pos.x
                        EntityDb.entity_data[ent].attachy = v.attachment.pos.y
                        EntityDb.entity_data[ent].attachz = v.attachment.pos.z
                        EntityDb.entity_data[ent].pitch = v.attachment.pitch
                        EntityDb.entity_data[ent].roll = v.attachment.roll
                        EntityDb.entity_data[ent].yaw = v.attachment.yaw
                    end
                end)
            end
            if no_db and ent then
                EntityDb.entity_data[ent] = nil
            end
        end
        if failed_to_spawn > 0 then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Failed to spawn %i entities"]:format(failed_to_spawn)) end
        return 0
    end)
end

--- @param entity Entity
--- @param attachments? bool
--- @param is_attached? bool
function world_spawner.copy_entity(entity, attachments, is_attached)
    local data = {}
    if attachments then
        local entity = features.get_parent_attachment(entity)
        data = {world_saver.get_properties(entity, true)}
        for _, v in ipairs(features.get_all_attachments(entity)) do
            insert(data, world_saver.get_properties(v, false))
        end
    else
        data = {world_saver.get_properties(entity, true)}
        data[1].attached = false
        data[1].in_vehicle = nil
    end
    world_spawner.spawn_map(data, false, not attachments and is_attached)
end

return world_spawner