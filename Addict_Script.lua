

-- Credits 🧐🔽🔽🔽
local Credits_To = {
    "FoxxDash/aka Ðr ÐºήgΣr",
    "不世出の天才",
    "Raymond",
    "OxiGen", -- Help With loops 😎
    "SATTY",
    "Anry",
    "pnn",
}
-- For functions 🧐🔼🔼🔼

-------------
-- Functions
-------------

function notify(text)
    local str_text = tostring(text)
    system.notify("Addict Script.lua加载完毕", str_text, 0, 255, 0, 255)
    system.log("Addict Script.lua 加载完毕", str_text)
end

function log(text)
    local str_text = tostring(text)
    system.log("", str_text)
end

function request_model(hash, onSuccess)
    if STREAMING.IS_MODEL_VALID(hash) == 0 then return end
    local tries = 0
    while tries < 50 and STREAMING.HAS_MODEL_LOADED(hash) == 0 do
        STREAMING.REQUEST_MODEL(hash);
        tries = tries + 1
        system.yield(100)
    end
    if STREAMING.HAS_MODEL_LOADED(hash) == 1 then onSuccess() return end
end

function ui.add_submenu_to(str_name, int_subID)
    local sub = ui.add_submenu(str_name)
    ui.add_sub_option(str_name, int_subID, sub)
    return sub
end

function player_exists(pid)
    return NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 1
end

function LocalPed()
    return PLAYER.PLAYER_PED_ID()
end

log("░█████╗░██████╗░██████╗░██╗░█████╗░████████╗  ░██████╗░█████╗░██████╗░██╗██████╗░████████╗")
log("██╔══██╗██╔══██╗██╔══██╗██║██╔══██╗╚══██╔══╝  ██╔════╝██╔══██╗██╔══██╗██║██╔══██╗╚══██╔══╝")
log("███████║██║░░██║██║░░██║██║██║░░╚═╝░░░██║░░░  ╚█████╗░██║░░╚═╝██████╔╝██║██████╔╝░░░██║░░░")
log("██╔══██║██║░░██║██║░░██║██║██║░░██╗░░░██║░░░  ░╚═══██╗██║░░██╗██╔══██╗██║██╔═══╝░░░░██║░░░")
log("██║░░██║██████╔╝██████╔╝██║╚█████╔╝░░░██║░░░  ██████╔╝╚█████╔╝██║░░██║██║██║░░░░░░░░██║░░░")
log("╚═╝░░╚═╝╚═════╝░╚═════╝░╚═╝░╚════╝░░░░╚═╝░░░  ╚═════╝░░╚════╝░╚═╝░░╚═╝╚═╝╚═╝░░░░░░░░╚═╝░░░")
log("▒▒▒▒██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▒▒▒▒")
log("▒▒████▄▒▒▒▄▄▄▄▄▄▄▒▒▒▄████▒▒")
log("▒▒▒▒▒▀▀▒▄█████████▄▒▀▀▒▒▒▒▒")
log("▒▒▒▒▒▒▒█████████████▒▒▒▒▒▒▒")
log("▒▒▒▒▒▒▒██▀▀▀███▀▀▀██▒▒▒▒▒▒▒")
log("▒▒▒▒▒▒▒██▒▒▒███▒▒▒██▒▒▒▒▒▒▒")
log("▒▒▒▒▒▒▒█████▀▄▀█████▒▒▒▒▒▒▒")
log("▒▒▒▒▒▒▒▒▒▒███████▒▒▒▒▒▒▒▒▒▒")
log("▒▒▒▒▄▄▄██▒▒█▀█▀█▒▒██▄▄▄▒▒▒▒")
log("▒▒▒▒▀▀██▒▒▒▒▒▒▒▒▒▒▒██▀▀▒▒▒▒")
log("▒▒▒▒▒▒▀▀▒▒▒▒▒▒▒▒▒▒▒▀▀▒▒▒▒▒▒")
notify("欢迎使用Addict Script! v0.3\n作者:Candy")

----------------------------------------------------------------------------------------------------------

--███╗░░░███╗███████╗███╗░░██╗██╗░░░██╗  ██████╗░░█████╗░░█████╗░████████╗
--████╗░████║██╔════╝████╗░██║██║░░░██║  ██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝
--██╔████╔██║█████╗░░██╔██╗██║██║░░░██║  ██████╔╝██║░░██║██║░░██║░░░██║░░░
--██║╚██╔╝██║██╔══╝░░██║╚████║██║░░░██║  ██╔══██╗██║░░██║██║░░██║░░░██║░░░
--██║░╚═╝░██║███████╗██║░╚███║╚██████╔╝  ██║░░██║╚█████╔╝╚█████╔╝░░░██║░░░
--╚═╝░░░░░╚═╝╚══════╝╚═╝░░╚══╝░╚═════╝░  ╚═╝░░╚═╝░╚════╝░░╚════╝░░░░╚═╝░░░

-------------------------------------------------------
Menu_Root_Select = ui.add_main_submenu("Addict 脚本")
-------------------------------------------------------

Recovery_Menu = ui.add_submenu_to("金钱选项", Menu_Root_Select) -- Recovery
ui.add_separator("金钱恢复", Recovery_Menu)

ui.add_bool_option("金钱增加", Recovery_Menu, function()
    local _peds = entities.get_peds()
    for i, _ped in pairs(_peds) do
        if _ped and not PED.IS_PED_A_PLAYER(_ped) then
            PED.SET_AMBIENT_PEDS_DROP_MONEY(true)
            PED.SET_PED_MONEY(_ped, 2000)
        else
            PED.SET_AMBIENT_PEDS_DROP_MONEY(false)
            PED.SET_PED_MONEY(_ped, 2000)
        end
    end
end)

Fun_Menu = ui.add_submenu_to("娱乐功能", Menu_Root_Select) -- Fun Features
ui.add_separator("恢复娱乐功能", Fun_Menu)

ui.add_bool_option("漂移模式", Fun_Menu, function(on)
	local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true)
    if on then
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(vehicle, true)
		VEHICLE._SET_VEHICLE_REDUCE_TRACTION(vehicle, 50)
	else
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(vehicle, false)
		VEHICLE._SET_VEHICLE_REDUCE_TRACTION(vehicle, 100)
	end
end)

----------------------------------------------------------------------------------------------------------

--██████╗░██╗░░░░░░█████╗░██╗░░░██╗███████╗██████╗░--███╗░░░███╗███████╗███╗░░██╗██╗░░░██╗
--██╔══██╗██║░░░░░██╔══██╗╚██╗░██╔╝██╔════╝██╔══██╗--████╗░████║██╔════╝████╗░██║██║░░░██║
--██████╔╝██║░░░░░███████║░╚████╔╝░█████╗░░██████╔╝--██╔████╔██║█████╗░░██╔██╗██║██║░░░██║
--██╔═══╝░██║░░░░░██╔══██║░░╚██╔╝░░██╔══╝░░██╔══██╗--██║╚██╔╝██║██╔══╝░░██║╚████║██║░░░██║
--██║░░░░░███████╗██║░░██║░░░██║░░░███████╗██║░░██║--██║░╚═╝░██║███████╗██║░╚███║╚██████╔╝
--╚═╝░░░░░╚══════╝╚═╝░░╚═╝░░░╚═╝░░░╚══════╝╚═╝░░╚═╝--╚═╝░░░░░╚═╝╚══════╝╚═╝░░╚══╝░╚═════╝░

----------------------------------------------------------------------------------------------------------
Player_List_Select = ui.add_player_submenu("Addict脚本")
-----------------------------------------------------------

Friendly_List = ui.add_submenu_to("友好选项", Player_List_Select) -- Friendly
ui.add_separator("崩溃", Friendly_List)

Crash_List = ui.add_submenu_to("崩溃", Player_List_Select) -- Crashes
ui.add_separator("崩溃", Crash_List)

Menu_Crash_List = ui.add_submenu_to("菜单崩溃", Crash_List)
        
ui.add_click_option("北域崩溃", Menu_Crash_List, function()
    local target = online.get_selected_player()
    local selectedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(selectedPlayer, 0, 2, 0)
    local pedHash = utils.joaat("player_zero")
    request_model(pedHash, function()
        local npc = entities.create_ped(pedHash, coords)
        entities.request_control(npc, function(handle)
            PED.SET_PED_COMPONENT_VARIATION(npc, 0, 0, 6, 0)
            PED.SET_PED_COMPONENT_VARIATION(npc, 0, 0, 7, 0)
            notify("北域崩溃发送到 " .. online.get_name(pid))
            system.yield(50)
            entities.delete(handle)
        end)
    end)
end)

ui.add_click_option("反弹崩溃", Menu_Crash_List, function()
    local target = online.get_selected_player()
    local selectedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(selectedPlayer, 0, 2, 0)
    local mdl = utils.joaat("mp_m_freemode_01")
    local veh_mdl = utils.joaat("taxi")
    request_model(mdl, function()
        request_model(veh_mdl, function()
        local veh = entities.create_vehicle(veh_mdl, coords)
        local jesus = entities.create_ped(mdl, coords)
        entities.request_control(veh, function(handle)
            entities.request_control(jesus, function(handles)
            PED.SET_PED_INTO_VEHICLE(jesus, veh, -1)
            system.yield(100)
            TASK.TASK_VEHICLE_HELI_PROTECT(jesus, veh, selectedPlayer, 10.0, 0, 10, 0, 0)
            notify("反弹崩溃发送到 " .. online.get_name(pid))
            system.yield(1000)
            entities.delete(handle)
            entities.delete(handles)
            end)
            end)
        end)
    end)
end)


Sync_Crash_List = ui.add_submenu_to("同步崩溃", Crash_List)

ui.add_click_option("同步崩溃V1", Sync_Crash_List, function()
	local target = online.get_selected_player()
	local selectedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
	local forwardOffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(selectedPlayer, 0, 4, 0)
	local object1 = utils.joaat("virgo")
	local a = OBJECT.CREATE_OBJECT(object1, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, false, false)
	local object2 = utils.joaat("swift2")
	local b = OBJECT.CREATE_OBJECT(object2, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, false, false)
    local object3 = utils.joaat("osiris")
	local c = OBJECT.CREATE_OBJECT(object3, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, false, false)
    local object4 = utils.joaat("v_serv_firealarm")
	local d = OBJECT.CREATE_OBJECT(object4, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, false, false)
    local object5 = utils.joaat("v_serv_bs_cond")
	local e = OBJECT.CREATE_OBJECT(object5, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, false, false)
    local object6 = utils.joaat("v_serv_bs_foamx3")
	local f = OBJECT.CREATE_OBJECT(object6, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, false, false)
    local object7 = utils.joaat("v_serv_ct_monitor07")
	local g = OBJECT.CREATE_OBJECT(object7, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, false, false)
    local object8 = utils.joaat("v_serv_ct_monitor06")
	local h = OBJECT.CREATE_OBJECT(object8, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, false, false)
    local object9 = utils.joaat("v_serv_ct_monitor05")
	local i = OBJECT.CREATE_OBJECT(object9, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, false, false)
    local object10 = utils.joaat("v_serv_bs_gelx3")
	local j = OBJECT.CREATE_OBJECT(object10, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, false, false)
    local object11 = utils.joaat("v_serv_ct_monitor01")
	local k = OBJECT.CREATE_OBJECT(object11, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, false, false)
    local object12 = utils.joaat("feltzer3")
	local l = OBJECT.CREATE_OBJECT(object12, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, false, false)
    local object13 = utils.joaat("v_serv_ct_monitor02")
	local m = OBJECT.CREATE_OBJECT(object13, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, false, false)
    local object14 = utils.joaat("windsor")
	local n = OBJECT.CREATE_OBJECT(object14, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, false, false)
    local object15 = utils.joaat("v_serv_ct_monitor04")
	local o = OBJECT.CREATE_OBJECT(object15, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, false, false)
    local object16 = utils.joaat("v_serv_ct_monitor03")
	local p = OBJECT.CREATE_OBJECT(object16, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, false, false)
    local object17 = utils.joaat("v_serv_bs_clutter")
	local q = OBJECT.CREATE_OBJECT(object17, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, false, false)
    end)

    Para_Crash_List = ui.add_submenu_to("降落伞崩溃", Crash_List)

    ui.add_click_option("降落伞崩溃", Para_Crash_List, function()
        local player_ped = PLAYER.PLAYER_PED_ID()    
        local old_coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player_ped, 0, 4, 0)
        for n = 0 , 5 do
            PEDP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
                object_hash = 1043035044
                STREAMING.REQUEST_MODEL(object_hash)
            while not STREAMING.HAS_MODEL_LOADED(object_hash) do
                system.yield()
                end
                PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
                WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
                system.yield(1000)
            for i = 0 , 20 do
                PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
                end
                system.yield(1000)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player_ped, -1087.7434, -3015.614, 13.9411745, 0, 0, 0)
            bush_hash = 1585741317
                STREAMING.REQUEST_MODEL(bush_hash)
        while not STREAMING.HAS_MODEL_LOADED(bush_hash) do
            system.yield()
            end
            PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),bush_hash)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player_ped, -1087.7434, -3015.614, 13.9411745, 0, 0, 0)
            WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
            system.yield(1000)
        for i = 0 , 20 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
            end
            system.yield(1000)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player_ped, old_coords.x, old_coords.y, old_coords.z)
        end
    end)

Rand_Crash_List = ui.add_submenu_to("随机崩溃", Crash_List)

ui.add_click_option("下一代崩溃", Rand_Crash_List, function()
    local target = online.get_selected_player()
    local selectedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(selectedPlayer, 0, 2, 0)
    local hash = 1349725314
    request_model(hash, function()
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(selectedPlayer)
    system.yield(100)
    veh = entities.create_vehicle(hash, coords)
    entities.request_control(veh, function(handle)
    VEHICLE.SET_VEHICLE_MOD_KIT(veh, 0)
    VEHICLE.SET_VEHICLE_MOD(veh, 34, 3, false)
    VEHICLE.TOGGLE_VEHICLE_MOD(veh, 34, true)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(veh, false, false)
    system.yield(50)
	entities.delete(handle)
    notify("下一代崩溃")
    end)
    end)
end)

--------------------------------------------------------------------------------------------

Kick_List = ui.add_submenu_to("踢出", Player_List_Select) -- Kicks
ui.add_separator("踢出", Kick_List)

ui.add_click_option("SE 踢出", Kick_List, function()
	local target = online.get_selected_player()
    for i = 1, 15 do
    online.send_script_event(target, 1727896103, 27, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    online.send_script_event(target, 1017995959, 27, 0)
    end
end)

--------------------------------------------------------------------------------------------

Troll_List = ui.add_submenu_to("攻击", Player_List_Select) -- Trolls
ui.add_separator("攻击", Troll_List)

ui.add_click_option("'布里'是攻击", Troll_List, function()
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(player_ped, false)
    PED.SET_PED_RELATIONSHIP_GROUP_HASH(player_ped, utils.joaat("PLAYER"))
    local flag_hash = utils.joaat("prop_flag_uk")
    local hash = 905946442
    request_model(hash)
    player_Brish_army = entities.create_ped(hash, pos)
    entities.request_control(player_Brish_army, function(handle)
    WEAPON.GIVE_WEAPON_TO_PED(handle, 2460120199, 1000, false, true)
    PED.SET_PED_MAX_HEALTH(player_Brish_army, 100)
    ENTITY.SET_ENTITY_INVINCIBLE(player_Brish_army, true)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(player_Brish_army)
    PED.SET_PED_AS_ENEMY(player_Brish_army, true)
    PED.SET_PED_FLEE_ATTRIBUTES(player_Brish_army, 0, false)
    PED.SET_PED_COMBAT_ATTRIBUTES(player_Brish_army, 46, true)
    PED.SET_PED_RELATIONSHIP_GROUP_HASH(player_Brish_army ,utils.joaat("HATES_PLAYER"))
    request_model(flag_hash)
    local object = entities.create_object(flag_hash, pos)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(object, player_Brish_army, 0, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true)
    notify("英国人被派往 " .. online.get_name(pid))
end)
end)

--------------------------------------------------------------------------------------------

local Loops = {}
local pass = function () end -- An empty function that does nothing. You can use it as a callback in any option if you don't need to do anything on option execution.

Loops["Friendly_Drop_Cash_Fast"] = ui.add_bool_option("快速现金 (Fast)", Friendly_List, pass)

Loops["Friendly_Drop_Cash"] = ui.add_bool_option("刷手办(元子)", Friendly_List, pass)

Loops["Friendly_Drop_RP"] = ui.add_bool_option("刷手办(RP)", Friendly_List, pass)

Loops["Recovery_Stealth_Loop"] = ui.add_bool_option("$500k + $750k", Recovery_Menu, pass)

while true do
    if ui.get_value(Loops["Recovery_Stealth_Loop"]) then
        globals.set_int(1968313, 1)
        notify("$ 500K添加")
        globals.set_int(1968313, 2)
        notify("$ 750K添加")
    end
    if ui.get_value(Loops["Friendly_Drop_RP"]) then
        local target = online.get_selected_player()
        local selectedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
        local coords = ENTITY.GET_ENTITY_COORDS(selectedPlayer, true)
        coords.z = coords.z + 1.5
        local random_hash = 0x4D6514A3
        local random_int = math.random(1, 8)
        if random_int == 1 then
            random_hash = 0x4D6514A3
        elseif random_int == 2 then
            random_hash = 0x748F3A2A
        elseif random_int == 3 then
            random_hash = 0x1A9736DA
        elseif random_int == 4 then
            random_hash = 0x3D1B7A2F
        elseif random_int == 5 then
            random_hash = 0x1A126315
        elseif random_int == 6 then
            random_hash = 0xD937A5E9
        elseif random_int == 7 then
            random_hash = 0x23DDE6DB
        elseif random_int == 8 then
            random_hash = 0x991F8C36
        end
        STREAMING.REQUEST_MODEL(random_hash)
        if STREAMING.HAS_MODEL_LOADED(random_hash) == false then  
            STREAMING.REQUEST_MODEL(random_hash)
        end
        OBJECT.CREATE_AMBIENT_PICKUP(-1009939663, coords.x, coords.y, coords.z, 0, 1, random_hash, false, true)
        notify("RP降至 " .. online.get_name(pid))
        system.yield(0)
    end
    if ui.get_value(Loops["Friendly_Drop_Cash"]) then
    local target = online.get_selected_player()
    local selectedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
    local coords = ENTITY.GET_ENTITY_COORDS(selectedPlayer, true)
        coords.z = coords.z + 1.5
        local cash = MISC.GET_HASH_KEY("PICKUP_VEHICLE_MONEY_VARIABLE")
        STREAMING.REQUEST_MODEL(cash)
        if STREAMING.HAS_MODEL_LOADED(cash) == false then  
            STREAMING.REQUEST_MODEL(cash)
            return
        end
        OBJECT.CREATE_AMBIENT_PICKUP(1704231442, coords.x, coords.y, coords.z, 0, 2000, cash, false, true)
        notify("现金降至 " .. online.get_name(pid))
        system.yield(3600)
    end
    if ui.get_value(Loops["Friendly_Drop_Cash_Fast"]) then
        local target = online.get_selected_player()
        local selectedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
        local coords = ENTITY.GET_ENTITY_COORDS(selectedPlayer, true)
            coords.z = coords.z + 1.5
            local cash = MISC.GET_HASH_KEY("PICKUP_VEHICLE_MONEY_VARIABLE")
            STREAMING.REQUEST_MODEL(cash)
            if STREAMING.HAS_MODEL_LOADED(cash) == false then  
                STREAMING.REQUEST_MODEL(cash)
                return
            end
            OBJECT.CREATE_AMBIENT_PICKUP(1704231442, coords.x, coords.y, coords.z, 0, 2000, cash, false, true)
            notify("现金降至 " .. online.get_name(pid))
            system.yield(0)
        end
    system.yield()
end
