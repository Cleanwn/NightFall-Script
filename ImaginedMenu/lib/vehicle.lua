--
-- made by FoxxDash/aka Ðr ÐºήgΣr & SATTY
--
-- Copyright © 2022 Imagined Menu
--

-- Global to local
local random = math.random
local insert = table.insert
local type = type
local require = require
local tonumber = tonumber
local tostring = tostring
local ipairs = ipairs
local memory = memory
local system = system
local AUDIO = AUDIO
local PED = PED
local PLAYER = PLAYER
local VEHICLE = VEHICLE
local NETWORK = NETWORK
local STREAMING = STREAMING
local utils = utils
local entities = entities
local globals = globals
local ui = ui
local ENTITY = ENTITY
local DECORATOR = DECORATOR

local features = require 'features'
local TRANSLATION = require('default').translation
local settings = require('default').settings
local s_memory = require 'script_memory'
local switch = require 'switch'
local vector3 = require 'vector3'
local enum = require 'enums'
local json = require 'JSON'
local file = require 'filesys'
local vehicles = {}
vehicles.class = {}
vehicles.class_manufacturer = {}
vehicles.class_hash = {}
vehicles.data = json:decode(file.read_all(files['VehData']))
vehicles.models = {}
vehicles.hashes = {}

vehicles.colors = {
    {255, 255, 255},
    {2, 21, 255},
    {3, 83, 255},
    {0, 255, 140},
    {94, 255, 1},
    {255, 255, 0},
    {255, 150, 5},
    {255, 62, 0},
    {255, 1, 1},
    {255, 50, 100},
    {255, 5, 190},
    {35, 1, 255},
    {15, 3, 255},
    {96, 0, 180},
    {0, 255, 255},
    {122, 255, 99},
    {0, 0, 0},
    {255, 90, 90},
    {55, 0, 255},
    {255, 121, 238},
}

vehicles.torque_mult = {}
vehicles.rpm_mult = {}

vehicles.horns = {}

for _, v in ipairs(enum.horns)
do
    local label = HUD._GET_LABEL_TEXT(v)
    insert(vehicles.horns, label == "NULL" and "" or label)
end

function vehicles.xenon_names()
    return {
        TRANSLATION["None"],
        TRANSLATION["White"],
        TRANSLATION["Blue"],
        TRANSLATION["Electric Blue"],
        TRANSLATION["Mint Green"],
        TRANSLATION["Lime Green"],
        TRANSLATION["Yellow"],
        TRANSLATION["Golden Shower"],
        TRANSLATION["Orange"],
        TRANSLATION["Red"],
        TRANSLATION["Pony Pink"],
        TRANSLATION["Hot Pink"],
        TRANSLATION["Purple"],
        TRANSLATION["Blacklight"]
    }
end

function vehicles.door_index()
    return {
        [0] = TRANSLATION["Driver's Front Door"],
        TRANSLATION["Passenger's Front Door"],
        TRANSLATION["Driver's Rear Door"],
        TRANSLATION["Passenger's Rear Door"],
        TRANSLATION["Vehicle Hood"],
        TRANSLATION["Vehicle Trunk"]
    }
end

--- @param hashname string|int
--- @param pos vector3
--- @param heading? float
--- @return int Vehicle
function vehicles.spawn_vehicle(hashname, pos, heading)
    local hash = 0
	if tonumber(hashname) then
		hash = tonumber(hashname)
	else
		hash = utils.joaat(hashname)
	end
	if STREAMING.IS_MODEL_VALID(hash) == 0 or not vehicles.hashes[hash] then return 0 end
	local vehicle = entities.create_vehicle(hash, pos.x, pos.y, pos.z)
    if heading then
        ENTITY.SET_ENTITY_HEADING(vehicle, heading)
    end
    return vehicle
end

--- @param hashname string|int
--- @return strin label
function vehicles.get_label_name(hashname)
    if not hashname then return 'NULL' end
    local hash = 0
    if tonumber(hashname) then 
        hash = tonumber(hashname) 
    else
        hash = utils.joaat(hashname)
    end 
    if STREAMING.IS_MODEL_VALID(hash) == 0 then return 'NULL' end
    local label = HUD._GET_LABEL_TEXT(VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(hash))
    return label
end

--- @return bool
vehicles.is_model_non_drivable = switch()
    :case(356391690,
          1502869817,
          3334677549,
          1030400667,
          920453016,
          240201337,
          642617954,
          868868440,
          586013744, function()
        return true
    end)
    :default(function()
        return false
    end)

local GetDlc = switch()
    :case("TitleUpdate", function()
        return 23
    end)
    :case("mpbeach", function()
        return 24
    end)
    :case("mpvalentines", function()
        return 25
    end)
    :case("mpbusiness", function()
        return 26
    end)
    :case("mpbusiness2", function()
        return 27
    end)
    :case("mphipster", function()
        return 28
    end)
    :case("mpindependence", function()
        return 29
    end)
    :case("mppilot", function()
        return 30
    end)
    :case("mplts", function()
        return 31
    end)
    :case("spupgrade", function()
        return 32
    end)
    :case("mpchristmas2", function()
        return 33
    end)
    :case("mpheist", function()
        return 34
    end)
    :case("mpluxe", function()
        return 35
    end)
    :case("mpluxe2", function()
        return 36
    end)
    :case("mplowrider", function()
        return 37
    end)
    :case("mphalloween", function()
        return 38
    end)
    :case("mpapartment", function()
        return 39
    end)
    :case("mpxmas_604490", function()
        return 40
    end)
    :case("mpjanuary2016", function()
        return 41
    end)
    :case("mpvalentines2", function()
        return 42
    end)
    :case("mplowrider2", function()
        return 43
    end)
    :case("mpexecutive", function()
        return 44
    end)
    :case("mpstunt", function()
        return 45
    end)
    :case("mpbiker", function()
        return 46
    end)
    :case("mpimportexport", function()
        return 47
    end)
    :case("mpspecialraces", function()
        return 48
    end)
    :case("mpgunrunning", function()
        return 49
    end)
    :case("mpsmuggler", function()
        return 50
    end)
    :case("mpchristmas2017", function()
        return 51
    end)
    :case("mpassault", function()
        return 52
    end)
    :case("mpbattle", function()
        return 53
    end)
    :case("mpchristmas2018", function()
        return 54
    end)
    :case("mpvinewood", function()
        return 55
    end)
    :case("mpheist3", function()
        return 56
    end)
    :case("mpsum", function()
        return 57
    end)
    :case("mpheist4", function()
        return 58
    end)
    :case("mptuner", function()
        return 59
    end)
    :case("mpsecurity", function()
        return 60
    end)
    :case("mpsum2", function()
        return 61
    end)
    :case("mpchristmas3", function()
        return 62
    end)

--- @param veh Vehicle
--- @param sub int
--- @param parent int
--- @param no_sub? bool
function vehicles.tuning_menu(veh, sub, parent, no_sub)
    if not no_sub then
        parent.sub_mods = ui.add_submenu(TRANSLATION["Vehicle customs"])
        parent.subopt_mods = ui.add_sub_option(TRANSLATION["Vehicle customs"], sub, parent.sub_mods)
    else
        ui.hide(parent.subopt_mods, false)
    end
    VEHICLE.SET_VEHICLE_MOD_KIT(veh, 0)
    parent.tune_preset = ui.add_choose(TRANSLATION["Presets"], parent.sub_mods, false, {TRANSLATION["Stock"], TRANSLATION["Max upgrade"], TRANSLATION["Max without livery"], TRANSLATION["Performance"], TRANSLATION["Performance with spoiler"]}, function(int)
        if utils.show_info("upgrade [choose]") then return end
        if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
        utils.hud_sound("YES")
        entities.request_control(veh, function()
            VEHICLE.SET_VEHICLE_MOD_KIT(veh, 0)
            if int == 0 then
                vehicles.stock(veh)
            elseif int == 1 then
                vehicles.upgrade(veh)
            elseif int == 2 then
                vehicles.upgrade(veh)
                VEHICLE.SET_VEHICLE_MOD(veh, 48, -1, false)
            elseif int == 3 then
                vehicles.stock(veh)
                vehicles.performance(veh)
            elseif int == 4 then
                vehicles.stock(veh)
                vehicles.performance(veh)
                local num = VEHICLE.GET_NUM_VEHICLE_MODS(veh, 0) - 1
                VEHICLE.SET_VEHICLE_MOD(veh, 0, num, false)
            end
        end)
    end, no_sub ~= nil and {"upgrade"})
    parent.paint_primary_sub = ui.add_submenu(TRANSLATION["Primary color"])
    parent.paint_primary_subopt = ui.add_sub_option(TRANSLATION["Primary color"], parent.sub_mods, parent.paint_primary_sub)
    parent.paint_primary_classic_sub = ui.add_submenu(TRANSLATION["Classic"])
    parent.paint_primary_classic_subopt = ui.add_sub_option(TRANSLATION["Classic"], parent.paint_primary_sub, parent.paint_primary_classic_sub)
    for _, e in ipairs(enum.vehicle_color_classic)
    do
        parent["color_primary_"..e[1]] = ui.add_click_option(e[1], parent.paint_primary_classic_sub, function()
            if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
            utils.hud_sound("SELECT")
            entities.request_control(veh, function()
                VEHICLE.CLEAR_VEHICLE_CUSTOM_PRIMARY_COLOUR(veh)
                local prim, sec = s_memory.alloc_get(2)
                VEHICLE.GET_VEHICLE_COLOURS(veh, prim, sec)
                VEHICLE.SET_VEHICLE_COLOURS(veh, e[2], memory.read_int(sec))

                local r, g, b = s_memory.alloc_get(3)
                VEHICLE.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(veh, r, g, b)
                ui.set_value(parent.paint_primary_select, e[2], true)
                ui.set_value(parent.paint_primary_rgb, memory.read_int(r), memory.read_int(g), memory.read_int(b), 255, true)
            end)
        end)
    end
    parent.paint_primary_worn_sub = ui.add_submenu(TRANSLATION["Worn"])
    parent.paint_primary_worn_subopt = ui.add_sub_option(TRANSLATION["Worn"], parent.paint_primary_sub, parent.paint_primary_worn_sub)
    for _, e in ipairs(enum.vehicle_color_worn)
    do
        parent["color_primary_"..e[1]] = ui.add_click_option(e[1], parent.paint_primary_worn_sub, function()
            if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
            utils.hud_sound("SELECT")
            entities.request_control(veh, function()
                VEHICLE.CLEAR_VEHICLE_CUSTOM_PRIMARY_COLOUR(veh)
                local prim, sec = s_memory.alloc_get(2)
                VEHICLE.GET_VEHICLE_COLOURS(veh, prim, sec)
                VEHICLE.SET_VEHICLE_COLOURS(veh, e[2], memory.read_int(sec))

                local r, g, b = s_memory.alloc_get(3)
                VEHICLE.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(veh, r, g, b)
                ui.set_value(parent.paint_primary_select, e[2], true)
                ui.set_value(parent.paint_primary_rgb, memory.read_int(r), memory.read_int(g), memory.read_int(b), 255, true)
            end)
        end)
    end
    parent.paint_primary_util_sub = ui.add_submenu(TRANSLATION["Util"])
    parent.paint_primary_util_subopt = ui.add_sub_option(TRANSLATION["Util"], parent.paint_primary_sub, parent.paint_primary_util_sub)
    for _, e in ipairs(enum.vehicle_color_util)
    do
        parent["color_primary_"..e[1]] = ui.add_click_option(e[1], parent.paint_primary_util_sub, function()
            if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
            utils.hud_sound("SELECT")
            entities.request_control(veh, function()
                VEHICLE.CLEAR_VEHICLE_CUSTOM_PRIMARY_COLOUR(veh)
                local prim, sec = s_memory.alloc_get(2)
                VEHICLE.GET_VEHICLE_COLOURS(veh, prim, sec)
                VEHICLE.SET_VEHICLE_COLOURS(veh, e[2], memory.read_int(sec))

                local r, g, b = s_memory.alloc_get(3)
                VEHICLE.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(veh, r, g, b)
                ui.set_value(parent.paint_primary_select, e[2], true)
                ui.set_value(parent.paint_primary_rgb, memory.read_int(r), memory.read_int(g), memory.read_int(b), 255, true)
            end)
        end)
    end
    parent.paint_primary_matte_sub = ui.add_submenu(TRANSLATION["Matte"])
    parent.paint_primary_matte_subopt = ui.add_sub_option(TRANSLATION["Matte"], parent.paint_primary_sub, parent.paint_primary_matte_sub)
    for _, e in ipairs(enum.vehicle_color_matte)
    do
        parent["color_primary_"..e[1]] = ui.add_click_option(e[1], parent.paint_primary_matte_sub, function()
            if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
            utils.hud_sound("SELECT")
            entities.request_control(veh, function()
                VEHICLE.CLEAR_VEHICLE_CUSTOM_PRIMARY_COLOUR(veh)
                local prim, sec = s_memory.alloc_get(2)
                VEHICLE.GET_VEHICLE_COLOURS(veh, prim, sec)
                VEHICLE.SET_VEHICLE_COLOURS(veh, e[2], memory.read_int(sec))

                local r, g, b = s_memory.alloc_get(3)
                VEHICLE.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(veh, r, g, b)
                ui.set_value(parent.paint_primary_select, e[2], true)
                ui.set_value(parent.paint_primary_rgb, memory.read_int(r), memory.read_int(g), memory.read_int(b), 255, true)
            end)
        end)
    end
    parent.paint_primary_metal_sub = ui.add_submenu(TRANSLATION["Metal"])
    parent.paint_primary_metal_subopt = ui.add_sub_option(TRANSLATION["Metal"], parent.paint_primary_sub, parent.paint_primary_metal_sub)
    for _, e in ipairs(enum.vehicle_color_metal)
    do
        parent["color_primary_"..e[1]] = ui.add_click_option(e[1], parent.paint_primary_metal_sub, function()
            if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
            utils.hud_sound("SELECT")
            entities.request_control(veh, function()
                VEHICLE.CLEAR_VEHICLE_CUSTOM_PRIMARY_COLOUR(veh)
                local prim, sec = s_memory.alloc_get(2)
                VEHICLE.GET_VEHICLE_COLOURS(veh, prim, sec)
                VEHICLE.SET_VEHICLE_COLOURS(veh, e[2], memory.read_int(sec))

                local r, g, b = s_memory.alloc_get(3)
                VEHICLE.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(veh, r, g, b)
                ui.set_value(parent.paint_primary_select, e[2], true)
                ui.set_value(parent.paint_primary_rgb, memory.read_int(r), memory.read_int(g), memory.read_int(b), 255, true)
            end)
        end)
    end
    parent.paint_primary_select = ui.add_num_option(TRANSLATION["Color"], parent.paint_primary_sub,  0, 160, 1, function(int)
        if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
        utils.hud_sound("YES")
        entities.request_control(veh, function()
            VEHICLE.CLEAR_VEHICLE_CUSTOM_PRIMARY_COLOUR(veh)
            local prim, sec = s_memory.alloc_get(2)
            VEHICLE.GET_VEHICLE_COLOURS(veh, prim, sec)
            VEHICLE.SET_VEHICLE_COLOURS(veh, int, memory.read_int(sec))
        end)
    end)
    parent.paint_primary_rgb = ui.add_color_picker(TRANSLATION["RGB"], parent.paint_primary_sub, function(color)
        if ui.ignore_rgb_callback[parent.paint_primary_rgb] then ui.ignore_rgb_callback[parent.paint_primary_rgb] = nil return end
        if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
        color = features.fix_color(color)
        entities.request_control(veh, function()
            VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(veh, color.r, color.g, color.b)
        end)
    end)
    parent.paint_primary_apply_choose = ui.add_choose(TRANSLATION["Apply to"], parent.paint_primary_sub, false, {TRANSLATION["Secondary"], TRANSLATION["Pearlescent"], TRANSLATION["Neon"], TRANSLATION["Wheel"], TRANSLATION["Tyre smoke"]}, function(int)
        if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
        utils.hud_sound("YES")
        local prim, sec = s_memory.alloc_get(2)
        VEHICLE.GET_VEHICLE_COLOURS(veh, prim, sec)
        entities.request_control(veh, function()
            if int == 0 then
                VEHICLE.SET_VEHICLE_COLOURS(veh, memory.read_int(prim), memory.read_int(prim))
                if VEHICLE.GET_IS_VEHICLE_PRIMARY_COLOUR_CUSTOM(veh) then
                    local r, g, b = s_memory.alloc_get(3)
                    VEHICLE.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(veh, r, g, b)
                    VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(veh, memory.read_int(r), memory.read_int(g), memory.read_int(b))
                end
            elseif int == 1 then
                local pearl, wheel = s_memory.alloc_get(2)
                VEHICLE.GET_VEHICLE_EXTRA_COLOURS(veh, pearl, wheel)
                VEHICLE.SET_VEHICLE_EXTRA_COLOURS(veh, memory.read_int(prim), memory.read_int(wheel))
            elseif int == 2 then
                local r, g, b = s_memory.alloc_get(3)
                VEHICLE.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(veh, r, g, b)
                VEHICLE._SET_VEHICLE_NEON_LIGHTS_COLOUR(veh, memory.read_int(r), memory.read_int(g), memory.read_int(b))
            elseif int == 3 then
                local pearl, wheel = s_memory.alloc_get(2)
                VEHICLE.GET_VEHICLE_EXTRA_COLOURS(veh, pearl, wheel)
                VEHICLE.SET_VEHICLE_EXTRA_COLOURS(veh, memory.read_int(pearl), memory.read_int(prim))
            elseif int == 4 then
                local r, g, b = s_memory.alloc_get(3)
                VEHICLE.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(veh, r, g, b)
                VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(veh, memory.read_int(r), memory.read_int(g), memory.read_int(b))
            end
        end)
    end)
    parent.paint_secondary_sub = ui.add_submenu(TRANSLATION["Secondary color"])
    parent.paint_secondary_subopt = ui.add_sub_option(TRANSLATION["Secondary color"], parent.sub_mods, parent.paint_secondary_sub)
    parent.paint_secondary_classic_sub = ui.add_submenu(TRANSLATION["Classic"])
    parent.paint_secondary_classic_subopt = ui.add_sub_option(TRANSLATION["Classic"], parent.paint_secondary_sub, parent.paint_secondary_classic_sub)
    for _, e in ipairs(enum.vehicle_color_classic)
    do
        parent["color_secondary_"..e[1]] = ui.add_click_option(e[1], parent.paint_secondary_classic_sub, function()
            if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
            utils.hud_sound("SELECT")
            entities.request_control(veh, function()
                VEHICLE.CLEAR_VEHICLE_CUSTOM_SECONDARY_COLOUR(veh)
                local prim, sec = s_memory.alloc_get(2)
                VEHICLE.GET_VEHICLE_COLOURS(veh, prim, sec)
                VEHICLE.SET_VEHICLE_COLOURS(veh, memory.read_int(prim), e[2])

                local r, g, b = s_memory.alloc_get(3)
                VEHICLE.GET_VEHICLE_CUSTOM_SECONDARY_COLOUR(veh, r, g, b)
                ui.set_value(parent.paint_secondary_select, e[2], true)
                ui.set_value(parent.paint_secondary_rgb, memory.read_int(r), memory.read_int(g), memory.read_int(b), 255, true)
            end)
        end)
    end
    parent.paint_secondary_worn_sub = ui.add_submenu(TRANSLATION["Worn"])
    parent.paint_secondary_worn_subopt = ui.add_sub_option(TRANSLATION["Worn"], parent.paint_secondary_sub, parent.paint_secondary_worn_sub)
    for _, e in ipairs(enum.vehicle_color_worn)
    do
        parent["color_secondary_"..e[1]] = ui.add_click_option(e[1], parent.paint_secondary_worn_sub, function()
            if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
            utils.hud_sound("SELECT")
            entities.request_control(veh, function()
                VEHICLE.CLEAR_VEHICLE_CUSTOM_SECONDARY_COLOUR(veh)
                local prim, sec = s_memory.alloc_get(2)
                VEHICLE.GET_VEHICLE_COLOURS(veh, prim, sec)
                VEHICLE.SET_VEHICLE_COLOURS(veh, memory.read_int(prim), e[2])

                local r, g, b = s_memory.alloc_get(3)
                VEHICLE.GET_VEHICLE_CUSTOM_SECONDARY_COLOUR(veh, r, g, b)
                ui.set_value(parent.paint_secondary_select, e[2], true)
                ui.set_value(parent.paint_secondary_rgb, memory.read_int(r), memory.read_int(g), memory.read_int(b), 255, true)
            end)
        end)
    end
    parent.paint_secondary_util_sub = ui.add_submenu(TRANSLATION["Util"])
    parent.paint_secondary_util_subopt = ui.add_sub_option(TRANSLATION["Util"], parent.paint_secondary_sub, parent.paint_secondary_util_sub)
    for _, e in ipairs(enum.vehicle_color_util)
    do
        parent["color_secondary_"..e[1]] = ui.add_click_option(e[1], parent.paint_secondary_util_sub, function()
            if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
            utils.hud_sound("SELECT")
            entities.request_control(veh, function()
                VEHICLE.CLEAR_VEHICLE_CUSTOM_SECONDARY_COLOUR(veh)
                local prim, sec = s_memory.alloc_get(2)
                VEHICLE.GET_VEHICLE_COLOURS(veh, prim, sec)
                VEHICLE.SET_VEHICLE_COLOURS(veh, memory.read_int(prim), e[2])

                local r, g, b = s_memory.alloc_get(3)
                VEHICLE.GET_VEHICLE_CUSTOM_SECONDARY_COLOUR(veh, r, g, b)
                ui.set_value(parent.paint_secondary_select, e[2], true)
                ui.set_value(parent.paint_secondary_rgb, memory.read_int(r), memory.read_int(g), memory.read_int(b), 255, true)
            end)
        end)
    end
    parent.paint_secondary_matte_sub = ui.add_submenu(TRANSLATION["Matte"])
    parent.paint_secondary_matte_subopt = ui.add_sub_option(TRANSLATION["Matte"], parent.paint_secondary_sub, parent.paint_secondary_matte_sub)
    for _, e in ipairs(enum.vehicle_color_matte)
    do
        parent["color_secondary_"..e[1]] = ui.add_click_option(e[1], parent.paint_secondary_matte_sub, function()
            if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
            utils.hud_sound("SELECT")
            entities.request_control(veh, function()
                VEHICLE.CLEAR_VEHICLE_CUSTOM_SECONDARY_COLOUR(veh)
                local prim, sec = s_memory.alloc_get(2)
                VEHICLE.GET_VEHICLE_COLOURS(veh, prim, sec)
                VEHICLE.SET_VEHICLE_COLOURS(veh, memory.read_int(prim), e[2])

                local r, g, b = s_memory.alloc_get(3)
                VEHICLE.GET_VEHICLE_CUSTOM_SECONDARY_COLOUR(veh, r, g, b)
                ui.set_value(parent.paint_secondary_select, e[2], true)
                ui.set_value(parent.paint_secondary_rgb, memory.read_int(r), memory.read_int(g), memory.read_int(b), 255, true)
            end)
        end)
    end
    parent.paint_secondary_metal_sub = ui.add_submenu(TRANSLATION["Metal"])
    parent.paint_secondary_metal_subopt = ui.add_sub_option(TRANSLATION["Metal"], parent.paint_secondary_sub, parent.paint_secondary_metal_sub)
    for _, e in ipairs(enum.vehicle_color_metal)
    do
        parent["color_secondary_"..e[1]] = ui.add_click_option(e[1], parent.paint_secondary_metal_sub, function()
            if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
            utils.hud_sound("SELECT")
            entities.request_control(veh, function()
                VEHICLE.CLEAR_VEHICLE_CUSTOM_SECONDARY_COLOUR(veh)
                local prim, sec = s_memory.alloc_get(2)
                VEHICLE.GET_VEHICLE_COLOURS(veh, prim, sec)
                VEHICLE.SET_VEHICLE_COLOURS(veh, memory.read_int(prim), e[2])

                local r, g, b = s_memory.alloc_get(3)
                VEHICLE.GET_VEHICLE_CUSTOM_SECONDARY_COLOUR(veh, r, g, b)
                ui.set_value(parent.paint_secondary_select, e[2], true)
                ui.set_value(parent.paint_secondary_rgb, memory.read_int(r), memory.read_int(g), memory.read_int(b), 255, true)
            end)
        end)
    end
    parent.paint_secondary_select = ui.add_num_option(TRANSLATION["Color"], parent.paint_secondary_sub,  0, 160, 1, function(int)
        if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
        utils.hud_sound("YES")
        entities.request_control(veh, function()
            VEHICLE.CLEAR_VEHICLE_CUSTOM_SECONDARY_COLOUR(veh)
            local prim, sec = s_memory.alloc_get(2)
            VEHICLE.GET_VEHICLE_COLOURS(veh, prim, sec)
            VEHICLE.SET_VEHICLE_COLOURS(veh, memory.read_int(prim), int)
        end)
    end)
    parent.paint_secondary_rgb = ui.add_color_picker(TRANSLATION["RGB"], parent.paint_secondary_sub, function(color)
        if ui.ignore_rgb_callback[parent.paint_secondary_rgb] then ui.ignore_rgb_callback[parent.paint_secondary_rgb] = nil return end
        if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
        color = features.fix_color(color)
        entities.request_control(veh, function()
            VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(veh, color.r, color.g, color.b)
        end)
    end)
    parent.paint_secondary_apply_choose = ui.add_choose(TRANSLATION["Apply to"], parent.paint_secondary_sub, false, {TRANSLATION["Primary"], TRANSLATION["Pearlescent"], TRANSLATION["Neon"], TRANSLATION["Wheel"], TRANSLATION["Tyre smoke"]}, function(int)
        if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
        utils.hud_sound("YES")
        local prim, sec = s_memory.alloc_get(2)
        VEHICLE.GET_VEHICLE_COLOURS(veh, prim, sec)
        entities.request_control(veh, function()
            if int == 0 then
                VEHICLE.SET_VEHICLE_COLOURS(veh, memory.read_int(sec), memory.read_int(sec))
                if VEHICLE.GET_IS_VEHICLE_SECONDARY_COLOUR_CUSTOM(veh) then
                    local r, g, b = s_memory.alloc_get(3)
                    VEHICLE.GET_VEHICLE_CUSTOM_SECONDARY_COLOUR(veh, r, g, b)
                    VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(veh, memory.read_int(r), memory.read_int(g), memory.read_int(b))
                end
            elseif int == 1 then
                local pearl, wheel = s_memory.alloc_get(2)
                VEHICLE.GET_VEHICLE_EXTRA_COLOURS(veh, pearl, wheel)
                VEHICLE.SET_VEHICLE_EXTRA_COLOURS(veh, memory.read_int(sec), memory.read_int(wheel))
            elseif int == 2 then
                local r, g, b = s_memory.alloc_get(3)
                VEHICLE.GET_VEHICLE_CUSTOM_SECONDARY_COLOUR(veh, r, g, b)
                VEHICLE._SET_VEHICLE_NEON_LIGHTS_COLOUR(veh, memory.read_int(r), memory.read_int(g), memory.read_int(b))
            elseif int == 3 then
                local pearl, wheel = s_memory.alloc_get(2)
                VEHICLE.GET_VEHICLE_EXTRA_COLOURS(veh, pearl, wheel)
                VEHICLE.SET_VEHICLE_EXTRA_COLOURS(veh, memory.read_int(pearl), memory.read_int(sec))
            elseif int == 4 then
                local r, g, b = s_memory.alloc_get(3)
                VEHICLE.GET_VEHICLE_CUSTOM_SECONDARY_COLOUR(veh, r, g, b)
                VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(veh, memory.read_int(r), memory.read_int(g), memory.read_int(b))
            end
        end)
    end)
    parent.paint_pearlescent_sub = ui.add_submenu(TRANSLATION["Pearlescent"])
    parent.paint_pearlescent_subopt = ui.add_sub_option(TRANSLATION["Pearlescent"], parent.sub_mods, parent.paint_pearlescent_sub)
    parent.paint_pearlescent_classic_sub = ui.add_submenu(TRANSLATION["Classic"])
    parent.paint_pearlescent_classic_subopt = ui.add_sub_option(TRANSLATION["Classic"], parent.paint_pearlescent_sub, parent.paint_pearlescent_classic_sub)
    for _, e in ipairs(enum.vehicle_color_classic)
    do
        parent["color_pearlescent_"..e[1]] = ui.add_click_option(e[1], parent.paint_pearlescent_classic_sub, function()
            if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
            utils.hud_sound("SELECT")
            entities.request_control(veh, function()
                local pearl, wheel = s_memory.alloc_get(2)
                VEHICLE.GET_VEHICLE_EXTRA_COLOURS(veh, pearl, wheel)
                VEHICLE.SET_VEHICLE_EXTRA_COLOURS(veh, e[2], memory.read_int(wheel))

                ui.set_value(parent.paint_pearlescent_select, e[2], true)
            end)
        end)
    end
    parent.paint_pearlescent_worn_sub = ui.add_submenu(TRANSLATION["Worn"])
    parent.paint_pearlescent_worn_subopt = ui.add_sub_option(TRANSLATION["Worn"], parent.paint_pearlescent_sub, parent.paint_pearlescent_worn_sub)
    for _, e in ipairs(enum.vehicle_color_worn)
    do
        parent["color_pearlescent_"..e[1]] = ui.add_click_option(e[1], parent.paint_pearlescent_worn_sub, function()
            if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
            utils.hud_sound("SELECT")
            entities.request_control(veh, function()
                local pearl, wheel = s_memory.alloc_get(2)
                VEHICLE.GET_VEHICLE_EXTRA_COLOURS(veh, pearl, wheel)
                VEHICLE.SET_VEHICLE_EXTRA_COLOURS(veh, e[2], memory.read_int(wheel))

                ui.set_value(parent.paint_pearlescent_select, e[2], true)
            end)
        end)
    end
    parent.paint_pearlescent_util_sub = ui.add_submenu(TRANSLATION["Util"])
    parent.paint_pearlescent_util_subopt = ui.add_sub_option(TRANSLATION["Util"], parent.paint_pearlescent_sub, parent.paint_pearlescent_util_sub)
    for _, e in ipairs(enum.vehicle_color_util)
    do
        parent["color_pearlescent_"..e[1]] = ui.add_click_option(e[1], parent.paint_pearlescent_util_sub, function()
            if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
            utils.hud_sound("SELECT")
            entities.request_control(veh, function()
                local pearl, wheel = s_memory.alloc_get(2)
                VEHICLE.GET_VEHICLE_EXTRA_COLOURS(veh, pearl, wheel)
                VEHICLE.SET_VEHICLE_EXTRA_COLOURS(veh, e[2], memory.read_int(wheel))

                ui.set_value(parent.paint_pearlescent_select, e[2], true)
            end)
        end)
    end
    parent.paint_pearlescent_matte_sub = ui.add_submenu(TRANSLATION["Matte"])
    parent.paint_pearlescent_matte_subopt = ui.add_sub_option(TRANSLATION["Matte"], parent.paint_pearlescent_sub, parent.paint_pearlescent_matte_sub)
    for _, e in ipairs(enum.vehicle_color_matte)
    do
        parent["color_pearlescent_"..e[1]] = ui.add_click_option(e[1], parent.paint_pearlescent_matte_sub, function()
            if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
            utils.hud_sound("SELECT")
            entities.request_control(veh, function()
                local pearl, wheel = s_memory.alloc_get(2)
                VEHICLE.GET_VEHICLE_EXTRA_COLOURS(veh, pearl, wheel)
                VEHICLE.SET_VEHICLE_EXTRA_COLOURS(veh, e[2], memory.read_int(wheel))

                ui.set_value(parent.paint_pearlescent_select, e[2], true)
            end)
        end)
    end
    parent.paint_pearlescent_metal_sub = ui.add_submenu(TRANSLATION["Metal"])
    parent.paint_pearlescent_metal_subopt = ui.add_sub_option(TRANSLATION["Metal"], parent.paint_pearlescent_sub, parent.paint_pearlescent_metal_sub)
    for _, e in ipairs(enum.vehicle_color_metal)
    do
        parent["color_pearlescent_"..e[1]] = ui.add_click_option(e[1], parent.paint_pearlescent_metal_sub, function()
            if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
            utils.hud_sound("SELECT")
            entities.request_control(veh, function()
                local pearl, wheel = s_memory.alloc_get(2)
                VEHICLE.GET_VEHICLE_EXTRA_COLOURS(veh, pearl, wheel)
                VEHICLE.SET_VEHICLE_EXTRA_COLOURS(veh, e[2], memory.read_int(wheel))

                ui.set_value(parent.paint_pearlescent_select, e[2], true)
            end)
        end)
    end
    parent.paint_pearlescent_select = ui.add_num_option(TRANSLATION["Color"], parent.paint_pearlescent_sub, 0, 160, 1, function(int)
        if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
        utils.hud_sound("YES")
        entities.request_control(veh, function()
            local pearl, wheel = s_memory.alloc_get(2)
            VEHICLE.GET_VEHICLE_EXTRA_COLOURS(veh, pearl, wheel)
            VEHICLE.SET_VEHICLE_EXTRA_COLOURS(veh, int, memory.read_int(wheel))
        end)
    end)
    for i = 0, 48
    do
        if i < 17 or i > 24 then
            local num_mod = VEHICLE.GET_NUM_VEHICLE_MODS(veh, i)
            if num_mod ~= 0 then
                if i == 14 then
                    parent["veh_mod_"..i] = ui.add_choose(enum.vehicle_mod_slot_names[i], parent.sub_mods, true, vehicles.horns, function(type)
                        if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
                        utils.hud_sound("YES")
                        entities.request_control(veh, function()
                            VEHICLE.SET_VEHICLE_MOD_KIT(veh, 0)
                            VEHICLE.SET_VEHICLE_MOD(veh, i, type - 1, false)
                        end)
                    end)
                else
                    parent["veh_mod_"..i] = ui.add_num_option(enum.vehicle_mod_slot_names[i], parent.sub_mods, 0, num_mod, 1, function(type)
                        if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
                        utils.hud_sound("YES")
                        entities.request_control(veh, function()
                            VEHICLE.SET_VEHICLE_MOD_KIT(veh, 0)
                            VEHICLE.SET_VEHICLE_MOD(veh, i, type - 1, false)
                        end)
                    end)
                end
            end
        end
    end
    parent.turbo = ui.add_bool_option(TRANSLATION["Turbo tuning"], parent.sub_mods, function(bool)
        if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
        utils.hud_sound("TOGGLE_ON")
        entities.request_control(veh, function()
            VEHICLE.TOGGLE_VEHICLE_MOD(veh, 18, bool)
        end)
    end)
    parent.xenons = ui.add_bool_option(TRANSLATION["Xenon lights"], parent.sub_mods, function(bool)
        if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
        utils.hud_sound("TOGGLE_ON")
        entities.request_control(veh, function()
            VEHICLE.TOGGLE_VEHICLE_MOD(veh, 22, bool)
        end)
    end)
    parent.licence_sep = ui.add_separator(TRANSLATION["Licence plate"], parent.sub_mods)
    parent.licence_index = ui.add_choose(TRANSLATION["Index"], parent.sub_mods, true, enum.plate_index, function(type)
        if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
        utils.hud_sound("YES")
        entities.request_control(veh, function()
            VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(veh, type)
        end)
    end)
    parent.licence_text = ui.add_input_string(TRANSLATION["Text"], parent.sub_mods, function(text)
        if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
        entities.request_control(veh, function()
            VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(veh, text:sub(1,8))
        end)
        ui.set_value(parent.licence_text, text:sub(1,8):upper(), true)
    end)
    parent.extra_separator = ui.add_separator(TRANSLATION["Extra"], parent.sub_mods)
    local found
    for i = 0, 20
    do
        if VEHICLE.DOES_EXTRA_EXIST(veh, i) == 1 then
            found = true
            parent["extra_"..i] = ui.add_bool_option(TRANSLATION["Extra"]..' '..i, parent.sub_mods, function(bool)
                if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
                utils.hud_sound("TOGGLE_ON")
                entities.request_control(veh, function()
                    VEHICLE.SET_VEHICLE_EXTRA(veh, i, not bool)
                end)
            end)
        end
    end
    if not found then
        ui.remove(parent.extra_separator)
        parent.extra_separator = nil
    end
    parent.other_separator = ui.add_separator(TRANSLATION["Other"], parent.sub_mods)
    parent.torque_mult = ui.add_float_option(TRANSLATION["Torque multiplier"], parent.sub_mods, -1000000, 1000000, .1, 3, function(float)
        if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
        utils.hud_sound("YES")
        vehicles.set_torque_mult(veh, float)
    end)
    parent.rpm_mult = ui.add_float_option(TRANSLATION["Horse power multiplier"], parent.sub_mods, -1000000, 1000000, .1, 3, function(float)
        if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
        utils.hud_sound("YES")
        vehicles.set_rpm_mult(veh, float)
    end)
    parent.window_tint = ui.add_choose(TRANSLATION["Window tint"], parent.sub_mods, true, {TRANSLATION["None"], TRANSLATION["Black"], TRANSLATION["Dark smoke"], TRANSLATION["Light smoke"], TRANSLATION["Stock"], TRANSLATION["Limo"], TRANSLATION["Green"]}, function(int)
        if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
        utils.hud_sound("YES")
        entities.request_control(veh, function()
            VEHICLE.SET_VEHICLE_WINDOW_TINT(veh, int)
        end)
    end)
    parent.xenon_color = ui.add_choose(TRANSLATION["Xenon color"], parent.sub_mods, true, vehicles.xenon_names(), function(int)
        if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
        utils.hud_sound("YES")
        entities.request_control(veh, function()
            VEHICLE._SET_VEHICLE_XENON_LIGHTS_COLOR(veh, int - 1)
        end)
    end)
    parent.interior_color = ui.add_choose(TRANSLATION["Interior color"], parent.sub_mods, true, enum.vehicle_color, function(int)
        if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
        utils.hud_sound("YES")
        entities.request_control(veh, function()
            VEHICLE._SET_VEHICLE_INTERIOR_COLOR(veh, int)
        end)
    end)
    parent.dashboard_color = ui.add_choose(TRANSLATION["Dashboard color"], parent.sub_mods, true, enum.vehicle_color, function(int)
        if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
        utils.hud_sound("YES")
        entities.request_control(veh, function()
            VEHICLE._SET_VEHICLE_DASHBOARD_COLOR(veh, int)
        end)
    end)
    parent.neon_sub = ui.add_submenu(TRANSLATION["Neon lights"])
    parent.neon_subopt = ui.add_sub_option(TRANSLATION["Neon lights"], parent.sub_mods, parent.neon_sub)
    for i, v in ipairs({TRANSLATION["Left"], TRANSLATION["Right"], TRANSLATION["Front"], TRANSLATION["Back"]})
    do
        parent['neon_'..i-1] = ui.add_bool_option(v, parent.neon_sub, function(bool)
            if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
            utils.hud_sound("TOGGLE_ON")
            entities.request_control(veh, function()
                VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(veh, i - 1, bool)
            end)
        end)
    end
    parent.neon_rgb = ui.add_color_picker(TRANSLATION["Color"], parent.neon_sub, function(color)
        if ui.ignore_rgb_callback[parent.neon_rgb] then ui.ignore_rgb_callback[parent.neon_rgb] = nil return end
        if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
        color = features.fix_color(color)
        entities.request_control(veh, function()
            VEHICLE._SET_VEHICLE_NEON_LIGHTS_COLOUR(veh, color.r, color.g, color.b)
        end)
    end)
    parent.wheel_sub = ui.add_submenu(TRANSLATION["Wheels"])
    parent.wheel_subopt = ui.add_sub_option(TRANSLATION["Wheels"], parent.sub_mods, parent.wheel_sub)
    parent.bulletproof_tires = ui.add_bool_option(TRANSLATION["Bulletproof tires"], parent.wheel_sub, function(bool)
        if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
        utils.hud_sound("TOGGLE_ON")
        entities.request_control(veh, function()
            VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(veh, not bool)
        end)
    end)
    parent.drift_tires = ui.add_bool_option(TRANSLATION["Drift tires"], parent.wheel_sub, function(bool)
        if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
        utils.hud_sound("TOGGLE_ON")
        entities.request_control(veh, function()
            VEHICLE._SET_DRIFT_TYRES_ENABLED(veh, bool)
        end)
    end)
    local model = ENTITY.GET_ENTITY_MODEL(veh)
    parent.custom_wheels = ui.add_bool_option(TRANSLATION["Custom wheels"], parent.wheel_sub, function(bool)
        if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
        utils.hud_sound("TOGGLE_ON")
        entities.request_control(veh, function()
            if VEHICLE.IS_THIS_MODEL_A_BIKE(model) == 1 then
                VEHICLE.SET_VEHICLE_MOD(veh, 24, VEHICLE.GET_VEHICLE_MOD(veh, 24), bool)
            end
            VEHICLE.SET_VEHICLE_MOD(veh, 23, VEHICLE.GET_VEHICLE_MOD(veh, 23), bool)
        end)
    end)
    if VEHICLE.IS_THIS_MODEL_A_BIKE(model) == 1 then
        parent.wheels_front = ui.add_num_option(TRANSLATION["Front wheel"], parent.wheel_sub, 0, VEHICLE.GET_NUM_VEHICLE_MODS(veh, 23), 1, function(int)
            if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
            utils.hud_sound("YES")
            entities.request_control(veh, function()
                VEHICLE.SET_VEHICLE_WHEEL_TYPE(veh, 6)
                VEHICLE.SET_VEHICLE_MOD(veh, 23, int, ui.get_value(parent.custom_wheels))
            end)
        end)
        parent.wheels_back = ui.add_num_option(TRANSLATION["Back wheel"], parent.wheel_sub, 0, VEHICLE.GET_NUM_VEHICLE_MODS(veh, 24), 1, function(int)
            if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
            utils.hud_sound("YES")
            entities.request_control(veh, function()
                VEHICLE.SET_VEHICLE_WHEEL_TYPE(veh, 6)
                VEHICLE.SET_VEHICLE_MOD(veh, 24, int - 1, ui.get_value(parent.custom_wheels))
            end)
        end)
    else
        local wheel_types = {TRANSLATION["Sport"], TRANSLATION["Muscle"], TRANSLATION["Lowrider"], TRANSLATION["SUV"], TRANSLATION["Offroad"], TRANSLATION["Tuner"], TRANSLATION["High-End"], TRANSLATION["Benny's Originals"], TRANSLATION["Benny's Bespoke"], TRANSLATION["Open Wheel"], TRANSLATION["Street"], TRANSLATION["Track"]}
        parent.wheel_type = ui.add_choose(TRANSLATION["Wheel type"], parent.wheel_sub, true, wheel_types, function(int)
            if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
            int = int > 5 and int + 1 or int
            utils.hud_sound("YES")
            entities.request_control(veh, function()
                VEHICLE.SET_VEHICLE_WHEEL_TYPE(veh, int)
                VEHICLE.SET_VEHICLE_MOD(veh, 23, -1, ui.get_value(parent.custom_wheels))
            end)
            -- ui.set_value(parent.wheels, 0, true)
        end)
        parent.wheels = ui.add_num_option(TRANSLATION["Rim"], parent.wheel_sub, 0, VEHICLE.GET_NUM_VEHICLE_MODS(veh, 23), 1, function(int)
            if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
            utils.hud_sound("YES")
            entities.request_control(veh, function()
                VEHICLE.SET_VEHICLE_MOD(veh, 23, int - 1, ui.get_value(parent.custom_wheels))
            end)
        end)
    end
    parent.wheel_color_sep = ui.add_separator(TRANSLATION["Color"], parent.wheel_sub)
    parent.paint_wheel_classic_sub = ui.add_submenu(TRANSLATION["Classic"])
    parent.paint_wheel_classic_subopt = ui.add_sub_option(TRANSLATION["Classic"], parent.wheel_sub, parent.paint_wheel_classic_sub)
    for _, e in ipairs(enum.vehicle_color_classic)
    do
        parent["color_wheel_"..e[1]] = ui.add_click_option(e[1], parent.paint_wheel_classic_sub, function()
            if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
            utils.hud_sound("SELECT")
            entities.request_control(veh, function()
                local pearl, wheel = s_memory.alloc_get(2)
                VEHICLE.GET_VEHICLE_EXTRA_COLOURS(veh, pearl, wheel)
                VEHICLE.SET_VEHICLE_EXTRA_COLOURS(veh, memory.read_int(pearl), e[2])
            end)
        end)
    end
    parent.paint_wheel_worn_sub = ui.add_submenu(TRANSLATION["Worn"])
    parent.paint_wheel_worn_subopt = ui.add_sub_option(TRANSLATION["Worn"], parent.wheel_sub, parent.paint_wheel_worn_sub)
    for _, e in ipairs(enum.vehicle_color_worn)
    do
        parent["color_wheel_"..e[1]] = ui.add_click_option(e[1], parent.paint_wheel_worn_sub, function()
            if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
            utils.hud_sound("SELECT")
            entities.request_control(veh, function()
                local pearl, wheel = s_memory.alloc_get(2)
                VEHICLE.GET_VEHICLE_EXTRA_COLOURS(veh, pearl, wheel)
                VEHICLE.SET_VEHICLE_EXTRA_COLOURS(veh, memory.read_int(pearl), e[2])
            end)
        end)
    end
    parent.paint_wheel_util_sub = ui.add_submenu(TRANSLATION["Util"])
    parent.paint_wheel_util_subopt = ui.add_sub_option(TRANSLATION["Util"], parent.wheel_sub, parent.paint_wheel_util_sub)
    for _, e in ipairs(enum.vehicle_color_util)
    do
        parent["color_wheel_"..e[1]] = ui.add_click_option(e[1], parent.paint_wheel_util_sub, function()
            if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
            utils.hud_sound("SELECT")
            entities.request_control(veh, function()
                local pearl, wheel = s_memory.alloc_get(2)
                VEHICLE.GET_VEHICLE_EXTRA_COLOURS(veh, pearl, wheel)
                VEHICLE.SET_VEHICLE_EXTRA_COLOURS(veh, memory.read_int(pearl), e[2])
            end)
        end)
    end
    parent.paint_wheel_matte_sub = ui.add_submenu(TRANSLATION["Matte"])
    parent.paint_wheel_matte_subopt = ui.add_sub_option(TRANSLATION["Matte"], parent.wheel_sub, parent.paint_wheel_matte_sub)
    for _, e in ipairs(enum.vehicle_color_matte)
    do
        parent["color_wheel_"..e[1]] = ui.add_click_option(e[1], parent.paint_wheel_matte_sub, function()
            if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
            utils.hud_sound("SELECT")
            entities.request_control(veh, function()
                local pearl, wheel = s_memory.alloc_get(2)
                VEHICLE.GET_VEHICLE_EXTRA_COLOURS(veh, pearl, wheel)
                VEHICLE.SET_VEHICLE_EXTRA_COLOURS(veh, memory.read_int(pearl), e[2])
            end)
        end)
    end
    parent.paint_wheel_metal_sub = ui.add_submenu(TRANSLATION["Metal"])
    parent.paint_wheel_metal_subopt = ui.add_sub_option(TRANSLATION["Metal"], parent.wheel_sub, parent.paint_wheel_metal_sub)
    for _, e in ipairs(enum.vehicle_color_metal)
    do
        parent["color_wheel_"..e[1]] = ui.add_click_option(e[1], parent.paint_wheel_metal_sub, function()
            if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
            utils.hud_sound("SELECT")
            entities.request_control(veh, function()
                local pearl, wheel = s_memory.alloc_get(2)
                VEHICLE.GET_VEHICLE_EXTRA_COLOURS(veh, pearl, wheel)
                VEHICLE.SET_VEHICLE_EXTRA_COLOURS(veh, memory.read_int(pearl), e[2])
            end)
        end)
    end
    parent.wheel_color = ui.add_num_option(TRANSLATION["Wheel color"], parent.wheel_sub,  0, 160, 1, function(int)
        if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
        utils.hud_sound("YES")
        entities.request_control(veh, function()
            local pearl, wheel = s_memory.alloc_get(2)
            VEHICLE.GET_VEHICLE_EXTRA_COLOURS(veh, pearl, wheel)
            VEHICLE.SET_VEHICLE_EXTRA_COLOURS(veh, memory.read_int(pearl), int)
        end)
    end)
    parent.tyre_smoke = ui.add_bool_option(TRANSLATION["Tire smoke"], parent.wheel_sub, function(bool)
        if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
        utils.hud_sound("TOGGLE_ON")
        entities.request_control(veh, function()
            VEHICLE.TOGGLE_VEHICLE_MOD(veh, 20, bool)
        end)
    end)
    parent.tyre_smoke_color = ui.add_color_picker(TRANSLATION["Tyre smoke color"], parent.wheel_sub, function(color)
        if ui.ignore_rgb_callback[parent.tyre_smoke_color] then ui.ignore_rgb_callback[parent.tyre_smoke_color] = nil return end
        if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return utils.hud_sound("ERROR") end
        color = features.fix_color(color)
        entities.request_control(veh, function()
            VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(veh, color.r, color.g, color.b)
        end)
    end)
end

--- @param veh vehicle
--- @return float
function vehicles.fuel_get(veh)
    if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return 0 end
    local fuel = memory.read_float(memory.handle_to_pointer(veh) + s_memory.FuelOffset)
    return features.round(fuel, 3)
end

--- @param veh Vehicle
--- @param fuel float
function vehicles.fuel_set(veh, fuel)
    if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return end
    memory.write_float(memory.handle_to_pointer(veh) + s_memory.FuelOffset, fuel)
end

--- @param veh Vehicle
--- @return float
function vehicles.gear_get(veh)
    if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return -1 end
    return memory.read_short(memory.handle_to_pointer(veh) + s_memory.CurrentGear)
end

--- @param vehicle Vehicle
--- @return float
function vehicles.get_rpm(veh)
    if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return 0 end
    local rpm = memory.read_float(memory.handle_to_pointer(veh) + s_memory.RPM)
    return features.round(rpm, 3)
end

--- @param veh Vehicle
--- @param rpm float
function vehicles.set_rpm(veh, rpm)
    if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return end
     memory.write_float(memory.handle_to_pointer(veh) + s_memory.RPM, rpm)
end

--- @param veh Vehicle
--- @return float
function vehicles.get_throttle(veh)
    if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return 0 end
    local throttle = memory.read_float(memory.handle_to_pointer(veh) + s_memory.Throttle)
    return features.round(throttle, 3)
end

--- @param veh Vehicle
--- @param throttle float
function vehicles.set_throttle(veh, throttle)
    if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return end
     memory.write_float(memory.handle_to_pointer(veh) + s_memory.Throttle, throttle)
end

--- @param veh Vehicle
--- @return float
function vehicles.get_gravity(veh)
    if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return 0 end
    local gravity = memory.read_float(memory.handle_to_pointer(veh) + s_memory.GravityOffset)
    return features.round(gravity, 3)
end

--- @param veh Vehicle
--- @param gravity float
function vehicles.set_gravity(veh, gravity)
    if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return end
     memory.write_float(memory.handle_to_pointer(veh) + s_memory.GravityOffset, gravity < 50 and gravity or 50)
end

--- @param veh Vehicle
--- @return float
function vehicles.get_rpm_mult(veh)
    if ENTITY.DOES_ENTITY_EXIST(veh) == 0 or not vehicles.rpm_mult[veh] then return 1 end
    return vehicles.rpm_mult[veh]
end

--- @param veh Vehicle
--- @param mult float
function vehicles.set_rpm_mult(veh, mult)
    if ENTITY.DOES_ENTITY_EXIST(veh) == 0 or not mult then return end
    VEHICLE.MODIFY_VEHICLE_TOP_SPEED(veh, mult)
    vehicles.rpm_mult[veh] = mult
end

--- @param veh Vehicle
--- @return float
function vehicles.get_torque_mult(veh)
    if ENTITY.DOES_ENTITY_EXIST(veh) == 0 or not vehicles.torque_mult[veh] then return 1 end
    return vehicles.torque_mult[veh]
end

--- @param veh Vehicle
--- @param mult float
function vehicles.set_torque_mult(veh, mult)
    if ENTITY.DOES_ENTITY_EXIST(veh) == 0 or not mult then return end
    if mult == 1 then vehicles.torque_mult[veh] = nil return end
    vehicles.torque_mult[veh] = mult
end

function vehicles.do_torque_tick()
    local veh = vehicles.get_player_vehicle()
    if veh == 0 or not vehicles.torque_mult[veh] then return end
    VEHICLE.SET_VEHICLE_CHEAT_POWER_INCREASE(veh, vehicles.torque_mult[veh])
end

--- @param veh Vehicle
function vehicles.repair(veh)
    if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return end
	FIRE.STOP_ENTITY_FIRE(veh)
    VEHICLE.SET_VEHICLE_FIXED(veh)
    VEHICLE.SET_VEHICLE_DEFORMATION_FIXED(veh)
    VEHICLE.SET_VEHICLE_ENGINE_HEALTH(veh, 1000.0)
    VEHICLE.SET_VEHICLE_DIRT_LEVEL(veh, 0)
    VEHICLE.SET_VEHICLE_ENVEFF_SCALE(veh, 0)
end

--- @param veh Vehicle
--- @param bool bool enable
--- @param dont_repair? bool
function vehicles.set_godmode(veh, bool, dont_repair)
    if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return end
	if bool and not dont_repair then 
        vehicles.repair(veh)
    end
    VEHICLE.SET_VEHICLE_CAN_BREAK(veh, not bool)
    VEHICLE.SET_VEHICLE_CAN_BE_VISIBLY_DAMAGED(veh, not bool)
    ENTITY.SET_ENTITY_CAN_BE_DAMAGED(veh, not bool)
    ENTITY.SET_ENTITY_PROOFS(veh, bool, bool, bool, bool, bool, bool, bool, bool)
    VEHICLE.SET_VEHICLE_STRONG(veh, bool)
    VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(veh, not bool)
    ENTITY.SET_ENTITY_INVINCIBLE(veh, bool)
    VEHICLE._SET_VEHICLE_CAN_BE_LOCKED_ON(veh, not bool, false)
end

--- @param veh Vehicle
function vehicles.upgrade(veh)
	VEHICLE.SET_VEHICLE_MOD_KIT(veh, 0)
    VEHICLE.TOGGLE_VEHICLE_MOD(veh, 18, true)
    VEHICLE.TOGGLE_VEHICLE_MOD(veh, 20, true)
    VEHICLE.TOGGLE_VEHICLE_MOD(veh, 22, true)
    VEHICLE.SET_VEHICLE_WHEEL_TYPE(veh, 7)
    for i = 0, 54 do
        local num = VEHICLE.GET_NUM_VEHICLE_MODS(veh, i) - 1
        if i < 17 or i > 22 then 
            VEHICLE.SET_VEHICLE_MOD(veh, i, num, (i == 23 or i == 24) and true or false)
        end
    end
    for i = 0, 3 do
        VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(veh, i, true)
    end
    local p = random(1, #vehicles.colors)
    VEHICLE.SET_VEHICLE_WINDOW_TINT(veh, 6)
    VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(veh, false)
    VEHICLE.SET_VEHICLE_EXTRA_COLOURS(veh, 160, 160)
    VEHICLE.SET_VEHICLE_COLOURS(veh,  160, 160)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(veh, 5)
    VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(veh, 0, 0, 0)
    VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(veh, vehicles.colors[p][1], vehicles.colors[p][2], vehicles.colors[p][3])
    VEHICLE._SET_VEHICLE_NEON_LIGHTS_COLOUR(veh, vehicles.colors[p][1], vehicles.colors[p][2], vehicles.colors[p][3])
    VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(veh, vehicles.colors[p][1], vehicles.colors[p][2], vehicles.colors[p][3])
end

--- @param veh Vehicle
function vehicles.stock(veh)
    for i = 0, 54 do
        VEHICLE.REMOVE_VEHICLE_MOD(veh, i)
    end
    for i = 0, 3 do
        VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(veh, i, false)
    end
    VEHICLE.SET_VEHICLE_WINDOW_TINT(veh, 0)
    VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(veh, true)
    VEHICLE.CLEAR_VEHICLE_CUSTOM_PRIMARY_COLOUR(veh)
    VEHICLE.CLEAR_VEHICLE_CUSTOM_SECONDARY_COLOUR(veh)
    VEHICLE.SET_VEHICLE_EXTRA_COLOURS(veh, -1, -1)
    VEHICLE.SET_VEHICLE_COLOURS(veh, -1, -1)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(veh, -1)
    VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(veh, 255, 255, 255)
    VEHICLE._SET_VEHICLE_NEON_LIGHTS_COLOUR(veh, 255, 255, 255)
end

--- @param veh Vehicle
function vehicles.performance(veh)
    VEHICLE.SET_VEHICLE_MOD_KIT(veh, 0)
    VEHICLE.TOGGLE_VEHICLE_MOD(veh, 18, true)
    for _, v in ipairs({11,12,13,15})
    do
        local num = VEHICLE.GET_NUM_VEHICLE_MODS(veh, v) - 1
        VEHICLE.SET_VEHICLE_MOD(veh, v, num, false)
    end
end

--- @param pos vector3
function vehicles.get_closest_vehicle(pos)
    local vehicle, distance = 0, 100000000
    for _, v in ipairs(entities.get_vehs()) do
        local dist = vector3(pos):sqrlen(features.get_entity_coords(v))
        if dist < distance then
            vehicle = v
            distance = dist
        end
    end
    return vehicle, distance
end

--- @param vehicle Vehicle
--- @return int?
function vehicles.get_first_free_seat(vehicle)
    local max = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(ENTITY.GET_ENTITY_MODEL(vehicle)) - 2
    for i = -1, max do
        if VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, i, true) == 1 then
            return i
        end
    end
end

--- @param vehicle Vehicle
--- @return bool
function vehicles.has_reduced_grip(vehicle)
    if ENTITY.DOES_ENTITY_EXIST(vehicle) == 0 then return false end
    local pointer = memory.handle_to_pointer(vehicle) + 5400
    return s_memory.is_bit_set(pointer, 6)
end

--- @param vehicle Vehicle
--- @return float
function vehicles.get_lights_intensity(vehicle)
    if ENTITY.DOES_ENTITY_EXIST(vehicle) == 0 then return 1 end
    local pointer = memory.handle_to_pointer(vehicle) + 0x9F4
    return memory.read_float(pointer)
end

--- @param vehicle Vehicle
--- @param toggle bool
function VEHICLE._SET_DRIFT_TYRES_ENABLED(vehicle, toggle)
    if ENTITY.DOES_ENTITY_EXIST(vehicle) == 0 then return end
    local handle = memory.handle_to_pointer(vehicle) + 0xAC2
    memory.write_byte(handle, toggle and 1 or 0)
end

--- @param vehicle Vehicle
--- @return int bool
function VEHICLE._GET_DRIFT_TYRES_ENABLED(vehicle)
    if ENTITY.DOES_ENTITY_EXIST(vehicle) == 0 then return 0 end
    local handle = memory.handle_to_pointer(vehicle) + 0xAC2
    return memory.read_byte(handle)
end

--- @param ped Ped
--- @return int?
function vehicles.get_ped_seat(ped)
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(ped, false)
    local max = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(ENTITY.GET_ENTITY_MODEL(vehicle)) - 2
    for i = -1, max do
        if VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, i, true) == ped then return i end
    end
end

--- @return int
function vehicles.get_personal_vehicle()
    return globals.get_int(2793044 + 299)
end

--- @param veh? Vehicle
--- @param player? Player
--- @return bool
function vehicles.is_player_driving_vehicle(veh, player)
    player = player or PLAYER.PLAYER_ID()
    veh = veh or vehicles.get_player_vehicle(player)
    if ENTITY.DOES_ENTITY_EXIST(veh) == 0 then return false end
    return VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1, false) == features.player_ped(player)
end

--- @param player? Player
--- @return int
function vehicles.get_player_vehicle(player)
    local ped = features.player_ped(player or PLAYER.PLAYER_ID())
	if PED.IS_PED_IN_ANY_VEHICLE(ped, false) == 0 then return 0 end
	return PED.GET_VEHICLE_PED_IS_IN(ped, false)
end

--- @param player Player
--- @return int
function vehicles.get_player_last_vehicle(player)
    return PED.GET_VEHICLE_PED_IS_IN(features.player_ped(player or PLAYER.PLAYER_ID()), true)
end

--- @param pos int
--- @param cl int
--- @return int index of vehicle
function vehicles.get_veh_index(pos, cl)
    local index = 1
    for i = 1, #vehicles.models
    do
        if vehicles.models[i][2] == vehicles.class_hash[cl][pos] then
            index = i
            break
        end
    end
    return index
end

for _, v in ipairs(vehicles.data)
do
    if v.DlcName ~= "mpg9ec" then
        insert(vehicles.models, {v.Name, v.Hash, vehicles.get_label_name(v.Name), VEHICLE.GET_VEHICLE_CLASS_FROM_NAME(v.Hash)})
        vehicles.hashes[v.Hash] = true
        local c = VEHICLE.GET_VEHICLE_CLASS_FROM_NAME(v.Hash)
        local dlc = GetDlc(v.DlcName)
        if not vehicles.class[c] then
            vehicles.class[c] = {}
            vehicles.class_manufacturer[c] = {}
            vehicles.class_hash[c] = {}
        end
        if dlc and not vehicles.class[dlc] then
            vehicles.class[dlc] = {}
            vehicles.class_manufacturer[dlc] = {}
            vehicles.class_hash[dlc] = {}
        end
        local name = vehicles.get_label_name(v.Name)
        insert(vehicles.class_manufacturer[c], HUD._GET_LABEL_TEXT(v.Manufacturer) ~= 'NULL' and HUD._GET_LABEL_TEXT(v.Manufacturer)..' '..name or name)
        insert(vehicles.class[c], name)
        insert(vehicles.class_hash[c], v.Hash)
        if dlc then
            insert(vehicles.class_manufacturer[dlc], HUD._GET_LABEL_TEXT(v.Manufacturer) ~= 'NULL' and HUD._GET_LABEL_TEXT(v.Manufacturer)..' '..name or name)
            insert(vehicles.class[dlc], name)
            insert(vehicles.class_hash[dlc], v.Hash)
        end
    end
end

return vehicles