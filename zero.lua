local fun = require '\\MGMenu\\Functions'

local packed_funs = require '\\MGMenu\\ceyice'

local features = {}
features.player_excludes = {}

--online
MG_option = ui.add_player_submenu("MGmenu")

Crash = ui.add_submenu_to("crash", MG_option)

Kick = ui.add_submenu_to("kick", MG_option)

MiscOnline = ui.add_submenu_to("misc", MG_option)

--local
main_sub = ui.add_main_submenu("MGmenu")

self_sub = ui.add_submenu("self")

session_sub = ui.add_submenu("session")

world_sub = ui.add_submenu("world")

selfveh_sub = ui.add_submenu("veh")

recovery_sub = ui.add_submenu("recovery")

misc_sub = ui.add_submenu("misc")


--ui.add_sub_option("Crash", Crash, MG_option)


ui.add_separator("Script eventcrash", Crash)

ui.add_click_option("Script eventcrashv1", Crash, function()
	local target = online.get_selected_player()
	local name = online.get_name(target)
	notify("sendScript eventcrashv1to " .. name .. "")
		online.send_script_event(target, 962740265, 2000000, 2000000, 2000000, 2000000)
    notify("sendScript eventcrashv1to" .. name .. "finished")
end)

ui.add_click_option("Script eventcrashv2", Crash, function()
	local target = online.get_selected_player()
	local name = online.get_name(target)
	notify("sendScript eventcrashv2to " .. name .. "")
		online.send_script_event(target, 1228916411, 1, 1245317585)
		online.send_script_event(target, 962740265, 1, 0, 144997919, -1907798317, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1)
		online.send_script_event(target, -1386010354, 1, 0, 92623021, -1907798317, 0, 0, 0, 0, 1)
    notify("sendScript eventcrashv2to" .. name .. "finished")
end)

ui.add_click_option("Script eventcrashv3", Crash, function()
	local target = online.get_selected_player()
	local name = online.get_name(target)
	local ind = PLAYER.GET_PLAYER_INDEX()
	notify("sendScript eventcrashv3to" .. name .. "")
		for i = 1, 15 do
			online.send_script_event(target, -393294520, 2147483647, 2147483647, 2147483647, 1, i, ind)
		system.yield(10)
	end
    notify("sendScript eventcrashv3to" .. name .. "finished")
end)

ui.add_click_option("sendScript eventcrashv4", Crash, function()
	local target = online.get_selected_player()
	local name = online.get_name(target)
	notify("sendScript eventcrashv4to" .. name .. "")
		online.send_script_event(target, -555356783, PlayerID ,85952,99999,52682274855,526822745)
        online.send_script_event(target, 526822748, PlayerID ,78552,99999 ,7949161,789454312)
        online.send_script_event(target, -66669983, PlayerID ,526822748,555555, math.random(80521,2959749521))
        online.send_script_event(target, -1733737974, PlayerID ,789522 ,59486,48512151,-9545440,5845131,848153,math.random(1,2959749),189958)
        online.send_script_event(target, -1529596656, PlayerID ,795221,59486,48512151,-9545440 , math.random(1,2959749))
        online.send_script_event(target, -8965204809, PlayerID ,795221,59486,48512151,-9545440)
    notify("sendScript eventcrashv4to" .. name .. "finished")
end)


ui.add_separator("实体crash", Crash)

ui.add_click_option("Next-Gencrash", Crash, function()
	local target = online.get_selected_player()
	local selectedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
	local coords = ENTITY.GET_ENTITY_COORDS(selectedPlayer, 1)
	local hash = 1349725314

	coords.x = coords.x + 2
	coords.y = coords.y + 2

	STREAMING.REQUEST_MODEL(hash)
	if STREAMING.HAS_MODEL_LOADED(hash) then
		TASK.CLEAR_PED_TASKS_IMMEDIATELY(selectedPlayer)
		system.yield(100)
		local vehicle = entities.create_vehicle(hash, coords.x, coords.y, coords.z)
		entities.request_control(vehicle, function()
		VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
		ENTITY.SET_ENTITY_COLLISION(vehicle, false, true)
		VEHICLE.SET_VEHICLE_MOD(vehicle, 0, VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, 0)-1, true)
		end)
	end
    notify("Next-Gencrashfinished")
end)

ui.add_click_option("ghost chrash (it maybe crash yourself)", Crash, function()
     local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
     local SelfPlayerPed = PLAYER.PLAYER_PED_ID()
     local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(SelfPlayerPed, true)
     local Spawned_tr3 = entities.create_vehicle(utils.joaat("tr3"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(SelfPlayerPed), true)
     ENTITY.ATTACH_ENTITY_TO_ENTITY(Spawned_tr3, SelfPlayerPed, 0, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true)
     ENTITY.SET_ENTITY_VISIBLE(Spawned_tr3, false, 0)
     local Spawned_chernobog = entities.create_vehicle(utils.joaat("chernobog"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(SelfPlayerPed), true)
     ENTITY.ATTACH_ENTITY_TO_ENTITY(Spawned_chernobog, SelfPlayerPed, 0, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true)
     ENTITY.SET_ENTITY_VISIBLE(Spawned_chernobog, false, 0)
     local Spawned_avenger = entities.create_vehicle(utils.joaat("avenger"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(SelfPlayerPed), true)
     ENTITY.ATTACH_ENTITY_TO_ENTITY(Spawned_avenger, SelfPlayerPed, 0, 0, 0, 0, 0, 0, 0, 0, true, true, false, 0, true)
     ENTITY.SET_ENTITY_VISIBLE(Spawned_avenger, false, 0)
     for i = 0, 100 do
         local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
         ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, true, false, false)
         system.yield(10 * math.random())
         ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, SelfPlayerPos.x, SelfPlayerPos.y, SelfPlayerPos.z, true, false, false)
         system.yield(10 * math.random())
     end
     notify("ghost crash finisheded")
end)


ui.add_click_option("ACEcrash", Crash, function()
     local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
     local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
     local SpawnPed_Wade = { }
     for i = 1, 60 do
          SpawnPed_Wade[i] = entities.create_ped(26, utils.joaat("PLAYER_TWO"),TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
          system.yield(1)
     end
     system.yield(5000)
     notify("ACEcrashfinished")
end)


ui.add_click_option("Toiltecrash", Crash, function()
	for i = 1, 10 do
        local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		local cord = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
        STREAMING.REQUEST_MODEL(-930879665)
        system.yield(10)
        STREAMING.REQUEST_MODEL(3613262246)
        system.yield(10)
        STREAMING.REQUEST_MODEL(452618762)
        system.yield(10)
        while not STREAMING.HAS_MODEL_LOADED(-930879665) do system.yield() end
        while not STREAMING.HAS_MODEL_LOADED(3613262246) do system.yield() end
        while not STREAMING.HAS_MODEL_LOADED(452618762) do system.yield() end
        local a1 = entities.create_object(-930879665, cord)
        system.yield(10)
        local a2 = entities.create_object(3613262246, cord)
        system.yield(10)
        local b1 = entities.create_object(452618762, cord)
        system.yield(10)
        local b2 = entities.create_object(3613262246, cord)
        system.yield(300)
        entities.delete(a1)
        entities.delete(a2)
        entities.delete(b1)
        entities.delete(b2)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(452618762)
        system.yield(10)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(3613262246)
        system.yield(10)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(-930879665)
        system.yield(10)
    end
    notify("Toiltecrashfinished")
end)


ui.add_click_option("Wadecrash", Crash, function()
     local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
     local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
     local SpawnPed_Wade = { }
     for i = 1, 60 do
         SpawnPed_Wade[i] = entities.create_ped(26, utils.joaat("ig_wade"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
         system.yield(1)
     end
     system.yield(5000)
     for i = 1, 60 do
         entities.delete(SpawnPed_Wade[i])
     end
     notify("Wadecrashfinished")
end)


ui.add_click_option("待finished的crash", Crash, function()
     local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
     local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
     local Object_jb1 = entities.create_object(0xD75E01A6, TargetPlayerPos)
     local Object_jb2 = entities.create_object(0x675D244E, TargetPlayerPos)
     local Object_jb3 = entities.create_object(0x799B48CA, TargetPlayerPos)
     local Object_jb4 = entities.create_object(0x68E49D4D, TargetPlayerPos)
     local Object_jb5 = entities.create_object(0x66F34017, TargetPlayerPos)
     local Object_jb6 = entities.create_object(0xDE1807BB, TargetPlayerPos)
     local Object_jb7 = entities.create_object(0xC4C9551E, TargetPlayerPos)
     local Object_jb8 = entities.create_object(0xCF37BA1F, TargetPlayerPos)
     local Object_jb9 = entities.create_object(0xB69AD9F8, TargetPlayerPos)
     local Object_jb10 = entities.create_object(0x5D750529, TargetPlayerPos)
     local Object_jb11 = entities.create_object(0x1705D85C, TargetPlayerPos)
     for i = 0, 1000 do 
         local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true);
         ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb1, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
         ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb2, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
         ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb3, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
         ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb4, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
         ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb5, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
         ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb6, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
         ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb7, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
         ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb8, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
         ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb9, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
         ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb10, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
         ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_jb11 ,TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
         system.yield(10)
     end
     system.yield(5500)
     entities.delete(Object_jb1)
     entities.delete(Object_jb2)
     entities.delete(Object_jb3)
     entities.delete(Object_jb4)
     entities.delete(Object_jb5)
     entities.delete(Object_jb6)
     entities.delete(Object_jb7)
     entities.delete(Object_jb8)
     entities.delete(Object_jb9)
     entities.delete(Object_jb10)
     entities.delete(Object_jb11)

     notify("111")
end)


--ui.add_sub_option("Kick", Kick, MG_option)

ui.add_click_option("host kick ", Kick, function()
	local target = online.get_selected_player()
	local name = online.get_name(target)
	notify("successfully host kick " .. name .. "")
	NETWORK.NETWORK_SESSION_KICK_PLAYER(target)
end)


ui.add_click_option("Script eventkickv1", Kick, function()
	local target = online.get_selected_player()
	local name = online.get_name(target)
	local pid = PLAYER.GET_PLAYER_INDEX()
	notify("Sending ScriptKick v1 to  " .. name .. "")
	    online.send_script_event(target, 111242367, pid, -210634234)
    notify("ScriptKick v1 finisheded")
end)

ui.add_click_option("Script eventkickv2", Kick, function()
	local target = online.get_selected_player()
	local name = online.get_name(target)
	local pid = PLAYER.GET_PLAYER_INDEX()
	notify("Sending ScriptKick v2 to " .. name .. "")
	    online.send_script_event(target, 421832664, pid, 0, 1951261, 829)
    notify("ScriptKick v2 finisheded")
end)

ui.add_click_option("Script eventkickv3", Kick, function()
	local target = online.get_selected_player()
	local name = online.get_name(target)
	local pid = PLAYER.GET_PLAYER_INDEX()
	notify("Sending ScriptKick v3 to " .. name .. "")
	    online.send_script_event(target, 0xB9BA4D30, PlayerID, 0x4, -1, 1, 1, 1)
    notify("ScriptKick v3 finisheded")
end)

ui.add_click_option("Script eventkickv4", Kick, function()
	local target = online.get_selected_player()
	local name = online.get_name(target)
	local pid = PLAYER.GET_PLAYER_INDEX()
	notify("Sending ScriptKick v4 to  " .. name .. "")
    for i = 1, 12 do
	    online.send_script_event(target, 1228916411, math.random(-1, 1), generic_player_global(online.get_selected_player()))
    end
    notify("ScriptKick v4 finisheded")
end)

ui.add_click_option("Script eventkickv5", Kick, function()
	local target = online.get_selected_player()
	local name = online.get_name(target)
	notify("Sending ScriptKick v5 to " .. name .. "")
		online.send_script_event(target, 603406648, 0, 380565701, -1443464333, 1, 115, 954851592, -768074745, 1278027916)
end)

ui.add_click_option("Script eventkickv6", Kick, function()
	local target = online.get_selected_player()
	local name = online.get_name(target)
	notify("Sending ScriptKick v6 to " .. name .. "")
		online.send_script_event(target, 603406648, 0, 1279476345, 655005918, 1, 115, 1997628673, 6299376, -302416007)
end)



--ui.add_sub_option("Misc", MiscOnline, MG_option)

ui.add_click_option("wanted him 5", MiscOnline, function()
	local target = online.get_selected_player()
	local name = online.get_name(target)
	local pid = PLAYER.GET_PLAYER_INDEX()
	PLAYER.SET_PLAYER_WANTED_LEVEL_NO_DROP(target, 5, false)
    PLAYER.SET_PLAYER_WANTED_LEVEL_NOW(target, false)
    notify("finished")
end)

ui.add_click_option("freeze him 5s", MiscOnline, function()
	local target = online.get_selected_player()
	local pid = PLAYER.GET_PLAYER_INDEX()
	local name = online.get_name(target)
	notify("freeze player: " .. name .. "")
		online.send_script_event(target, 1214823473, pid, 0, 0, 0, 0, 0)
end)


--local
ui.add_sub_option("self", main_sub, self_sub)

ui.add_separator("waiting for more function!", self_sub)

ui.add_bool_option("fireself", self_sub, function(on)
    local ped = PLAYER.PLAYER_PED_ID()
    local Player = PLAYER.PLAYER_PED_ID()
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    local pos = ENTITY.GET_ENTITY_COORDS(ped, true)
    local hash = utils.joaat("sanctus")
	local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
	if on then
    requestModel(hash, function()
        entities.create_vehicle(1491277511, pos)
    end)
        FIRE.START_ENTITY_FIRE(ped)
		ENTITY.SET_ENTITY_INVINCIBLE(ped, true)
		ENTITY.SET_ENTITY_INVINCIBLE(veh, true)
		
    else
        FIRE.STOP_ENTITY_FIRE(ped)
		ENTITY.SET_ENTITY_INVINCIBLE(ped, false)
    end
end)--为了完成这个功能，OxiGento予了MG很多的帮助，一定要感谢OxiGen！！

ui.add_num_option("alpha", self_sub, 0, 255, 1, function(num)
	local ped = PLAYER.PLAYER_PED_ID()
	ENTITY.SET_ENTITY_ALPHA(ped, num, false)
end)

ui.add_click_option("reset alpha", self_sub, function()
	local ped = PLAYER.PLAYER_PED_ID()
	ENTITY.SET_ENTITY_ALPHA(ped, 255, false)
end)

ui.add_bool_option("fake wanted", self_sub, function(on)

    if on then
		MISC.SET_FAKE_WANTED_LEVEL(6)
	else
		MISC.SET_FAKE_WANTED_LEVEL(0)
	end

end)



ui.add_sub_option("session", main_sub, session_sub)

--ui.add_bool_option("嘲讽"， session_sub, function(open)
   -- if open then

--end

--function on_crash_attempt(int player_id, int action_id)


ui.add_sub_option("world", main_sub, world_sub)



ui.add_sub_option("veh", main_sub, selfveh_sub)



--子选项↓
ui.add_click_option("ghost bike", selfveh_sub, function()
    local ped = PLAYER.PLAYER_PED_ID()
    local Player = PLAYER.PLAYER_PED_ID()
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    local pos = ENTITY.GET_ENTITY_COORDS(ped, true)
    local hash = utils.joaat("sanctus")
	local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
    requestModel(hash, function()
        entities.create_vehicle(1491277511, pos)
    end)
end)

ui.add_click_option("policecar", selfveh_sub, function()
    local ped = PLAYER.PLAYER_PED_ID()
    local Player = PLAYER.PLAYER_PED_ID()
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    local pos = ENTITY.GET_ENTITY_COORDS(ped, true)
    local hash = -1536924937
	local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
    requestModel(hash, function()
        entities.create_vehicle(-1536924937, pos)
    end)
end)

ui.add_click_option("policecar2", selfveh_sub, function()
    local ped = PLAYER.PLAYER_PED_ID()
    local Player = PLAYER.PLAYER_PED_ID()
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    local pos = ENTITY.GET_ENTITY_COORDS(ped, true)
    local hash = -1779120616
	local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
    requestModel(hash, function()
        entities.create_vehicle(-1779120616, pos)
    end)
end)

ui.add_click_option("police helic", selfveh_sub, function()
    local ped = PLAYER.PLAYER_PED_ID()
    local Player = PLAYER.PLAYER_PED_ID()
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    local pos = ENTITY.GET_ENTITY_COORDS(ped, true)
    local hash = 353883353
	local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
    requestModel(hash, function()
        entities.create_vehicle(353883353, pos)
    end)
end)

ui.add_click_option("FIB car", selfveh_sub, function()
    local ped = PLAYER.PLAYER_PED_ID()
    local Player = PLAYER.PLAYER_PED_ID()
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    local pos = ENTITY.GET_ENTITY_COORDS(ped, true)
    local hash = 1127131465
	local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
    requestModel(hash, function()
        entities.create_vehicle(1127131465, pos)
    end)
end)
 --子选项↑       




ui.add_sub_option("recovery", main_sub, recovery_sub)

ui.add_separator("--------get money--------", recovery_sub)

ui.add_bool_option("get money(75K/1min)", recovery_sub, function(on)
    if on then
       while true do
         give750()
         system.yield(60000)
       end
    else
       system.yield()
    end

end)



ui.add_separator("--------cayo--------", recovery_sub)

ui.add_click_option("finish mission", recovery_sub, function ()
		globals.set_int("H4_MISSIONS", -1)
        globals.set_int("H4CNF_APPROACH", -1)
		globals.set_int("H4CNF_TARGET", 5) ---panther
        globals.set_int("H4CNF_BS_ENTR", 63)
        globals.set_int("H4CNF_BS_GEN", 63)
    notify("1")
end)


ui.add_num_option("player 1 Dividends", recovery_sub, 0, 100, 1, function(num)
	globals.set_int(1973321 + 823 + 56, num)
end)

ui.add_num_option("player 2 Dividends", recovery_sub, 0, 100, 1, function(num)
	globals.set_int(1973321 + 823 + 56+1, num)
end)

ui.add_num_option("player3Dividends", recovery_sub, 0, 100, 1, function(num)
	globals.set_int(1973321 + 823 + 56+2, num)
end)

ui.add_num_option("player4Dividends", recovery_sub, 0, 100, 1, function(num)
	globals.set_int(1973321 + 823 + 56+3, num)
end)

ui.add_click_option("finished cayo mission", recovery_sub, function()
		if globals.is_script_active("fm_mission_controller_2020") then
			globals.set_local("fm_mission_controller_2020", 38397, 51338752)
			globals.set_local("fm_mission_controller_2020", 39772, 50) 
		end
end)

ui.add_separator("-------casino-------", recovery_sub)

ui.add_num_option("player1Dividends", recovery_sub, 0, 200, 1, function(num)
	globals.set_int(1966534 + 1497 + 736 + 92, num)
end)

ui.add_num_option("player2Dividends", recovery_sub, 0, 200, 1, function(num)
	globals.set_int(1966534 + 1497 + 736 + 92 + 1, num)
end)

ui.add_num_option("player3Dividends", recovery_sub, 0, 200, 1, function(num)
	globals.set_int(1966534 + 1497 + 736 + 92 + 2, num)
end)

ui.add_num_option("player4Dividends", recovery_sub, 0, 200, 1, function(num)
	globals.set_int(1966534 + 1497 + 736 + 92 + 3, num)
end)




ui.add_sub_option("tp", main_sub, misc_sub)


ui.add_click_option("传送到机库", misc_sub, function()
	pedp = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    ENTITY.SET_ENTITY_COORDS(pedp, -2021, 3156, 33, false, false, false, true)
end)

ui.add_click_option("CEO办公室入口", misc_sub, function()
	   pedp = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
       ENTITY.SET_ENTITY_COORDS(pedp, -1368.743164, -478.036407, 89.764458, false, false, false, true)
end)



--[[小岛子界面↓
local xiaodao = ui.add_submenu_to("小岛", recovery_sub)

ui.add_separator("小岛", xiaodao)

ui.add_click_option("删除冷却", xiaodao, function( )
	mpIndex = globals.get_int(1574918)
	if mpIndex == 0 then
                 stats.set_int("MP0_H4_TARGET_POSIX", 1659429119) 
		 stats.set_int("MP0_H4_COOLDOWN", 0)
	         stats.set_int("MP0_H4_COOLDOWN_HARD", 0)
	else
		  stats.set_int("MP1_H4_COOLDOWN", 0)
                  stats.set_int("MP1_H4_TARGET_POSIX", 1659429119)
		  stats.set_int("MP1_H4_COOLDOWN_HARD", 0)
	end
end
)

--defined function for mission
local globals = {
	main = 262145,
	char_id = 1574915,
	cayo = {
		lives = 44664 + 865 + 1,
	},
	casino = {
		lives = 26105 + 1322 + 1,
	},
	tuner = {
		earnings = 30690, 
		fee = {
			30687,
		}
	},
	contract = {
		earnings = 31389, 
		cd_hit = {
			31345, 
			31407  
		},
		cd = {
			31423
		},
		call_cd = 2720311
	}
}

options['otherdriveToWp'] = ui.add_bool_option("代驾到导航点", selfveh_sub, function(state)
	local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true)
	if vehicle == nil then ui.set_value(options['otherdriveToWp'], false, false) return end
	local coords = ENTITY.GET_ENTITY_COORDS(vehicle, true)
    local waypoint = HUD.GET_BLIP_COORDS(HUD.GET_FIRST_BLIP_INFO_ID(8))
	local ped = stuff.driveToMePed
	if state then
    PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), 0)
		requestModel(utils.joaat("HC_Driver"), function()
			stuff.driveToMePed = entities.create_ped(utils.joaat("HC_Driver"), coords)
			ped = stuff.driveToMePed
			ENTITY.SET_ENTITY_INVINCIBLE(ped, true)
			ENTITY.SET_ENTITY_VISIBLE(ped, false, false)
			PED.SET_PED_INTO_VEHICLE(ped, vehicle, -1)
			TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(ped, vehicle, coords.x, coords.y, coords.z + 1, 30, 4, 5)
			successfulnotify("正在向导航点代驾过去")
		end)
	elseif not state then
		VEHICLE.SET_VEHICLE_FIXED(vehicle)
		VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, 0)
		TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
		entities.delete(ped)
    PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false), -1)
		successfulnotify("它停止了")
	end
end)

function set_int(Stat, Value)
	STATS.STAT_SET_INT(utils.joaat(Stat), Value, true)
end

local prefix_base = "MP%s_"
local function GetPrefix()
	local char = globals.get_int(global.char_id)
	return prefix_base:format(char)
end

local function set_stat_int(stat, val)
	local prefix = GetPrefix()
	local mp_stat = prefix .. stat
	local hash = utils.joaat(mp_stat)
	system.log("统计数据", tostring(mp_stat))
	return STATS.STAT_SET_INT(hash, val, true)
end

local function apply_stats(tbl)
	for _, stat_info in ipairs(tbl) do
		set_stat_int(stat_info[1], stat_info[2])
	end
end




ui.add_click_option("完成前置任务", xiaodao, function ()

		globals.set_int("MP0_H4_PROGRESS", 131055)
		globals.set_int("MP0_H4CNF_TARGET", 3)
		globals.set_int("MP0_H4_MISSIONS", 65283)
		globals.set_int("MP0_H4CNF_WEAPONS", 1)
		globals.set_int("MP0_H4CNF_WEP_DISRP", 3)
		globals.set_int("MP0_H4CNF_ARM_DISRP", 3)
		globals.set_int("MP0_H4CNF_HEL_DISRP", 3)
		globals.set_int("MP0_H4_PLAYTHROUGH_STATUS", 10)

		globals.set_int("MP1_H4_PROGRESS", 131055)
		globals.set_int("MP1_H4CNF_TARGET", 3)
		globals.set_int("MP1_H4_MISSIONS", 65283)
		globals.set_int("MP1_H4CNF_WEAPONS", 1)
		globals.set_int("MP1_H4CNF_WEP_DISRP", 3)
		globals.set_int("MP1_H4CNF_ARM_DISRP", 3)
		globals.set_int("MP1_H4CNF_HEL_DISRP", 3)
		globals.set_int("MP1_H4_PLAYTHROUGH_STATUS", 10)

end)

ui.add_click_option("一键100分红", xiaodao, function ()
    globals.set_int(1973321 + 823 + 56+1, 100)
    globals.set_int(1973321 + 823 + 56+2, 100)
    globals.set_int(1973321 + 823 + 56+3, 100)
    globals.set_int(1973321 + 823 + 56+4, 100)
end)


ui.add_num_option("小岛玩家1分红", xiaodao, 0, 100, 1, function(num)
	globals.set_int(1973321 + 823 + 56+1, num)
end)

ui.add_num_option("小岛玩家2分红", xiaodao, 0, 100, 1, function(num)
	globals.set_int(1973321 + 823 + 56+2, num)
end)

ui.add_num_option("小岛玩家3分红", xiaodao, 0, 100, 1, function(num)
	globals.set_int(1973321 + 823 + 56+3, num)
end)

ui.add_num_option("小岛玩家4分红", xiaodao, 0, 100, 1, function(num)
	globals.set_int(1973321 + 823 + 56+4, num)
end)

ui.add_click_option("删除格栅", xiaodao, function()
		globals.set_local("fm_mission_controller_2020", 27500, 6)
end)

ui.add_click_option("解锁指纹复制器", xiaodao, function()
		globals.set_local("fm_mission_controller_2020", 23385, 5)
end)

ui.add_num_option("总收入", xiaodao, 0, 12000000, 10000, function(num)
		globals.set_local("fm_mission_controller_2020", 43152, num)
end)

ui.add_click_option("完成小岛", xiaodao, function()
		if globals.is_script_active("fm_mission_controller_2020") then
			globals.set_local("fm_mission_controller_2020", 38397, 51338752)
			globals.set_local("fm_mission_controller_2020", 39772, 50) 
		end
end)
--小岛子界面↑

--DC子界面↓
local DC = ui.add_submenu_to("DC赌场", recovery_sub)


ui.add_separator("DC", DC)

ui.add_click_option("前置-隐迹潜踪", DC, function()
                    STATS.STAT_SET_INT("H3_COMPLETEDPOSIX", -1)
                    STATS.STAT_SET_INT("H3OPT_MASKS", 4)
                    STATS.STAT_SET_INT("H3OPT_WEAPS", 1)
                    STATS.STAT_SET_INT("H3OPT_VEHS", 3)
                    STATS.STAT_SET_INT("CAS_HEIST_FLOW", -1)
                    STATS.STAT_SET_INT("H3_LAST_APPROACH", 0)
                    STATS.STAT_SET_INT("H3OPT_APPROACH", 1)
                    STATS.STAT_SET_INT("H3_HARD_APPROACH", 0)
                    STATS.STAT_SET_INT("H3OPT_TARGET", 3)
                    STATS.STAT_SET_INT("H3OPT_POI", 1023)
                    STATS.STAT_SET_INT("H3OPT_ACCESSPOINTS", 2047)
                    STATS.STAT_SET_INT("H3OPT_CREWWEAP", 4)
                    STATS.STAT_SET_INT("H3OPT_CREWDRIVER", 3)
                    STATS.STAT_SET_INT("H3OPT_CREWHACKER", 4)
                    STATS.STAT_SET_INT("H3OPT_DISRUPTSHIP", 3)
                    STATS.STAT_SET_INT("H3OPT_BODYARMORLVL", -1)
                    STATS.STAT_SET_INT("H3OPT_KEYLEVELS", 2)
                    STATS.STAT_SET_INT("H3OPT_BITSET1", 127)
                    STATS.STAT_SET_INT("H3OPT_BITSET0", 262270)
end
)

ui.add_click_option("前置-气势汹汹", DC, function()
                    STATS.STAT_SET_INT("H3_COMPLETEDPOSIX", -1)
                    STATS.STAT_SET_INT("H3OPT_MASKS", 4)
                    STATS.STAT_SET_INT("H3OPT_WEAPS", 1)
                    STATS.STAT_SET_INT("H3OPT_VEHS", 3)
                    STATS.STAT_SET_INT("CAS_HEIST_FLOW", -1)
                    STATS.STAT_SET_INT("H3_LAST_APPROACH", 0)
                    STATS.STAT_SET_INT("H3OPT_APPROACH", 3)
                    STATS.STAT_SET_INT("H3_HARD_APPROACH", 0)
                    STATS.STAT_SET_INT("H3OPT_TARGET", 3)
                    STATS.STAT_SET_INT("H3OPT_POI", 1023)
                    STATS.STAT_SET_INT("H3OPT_ACCESSPOINTS", 2047)
                    STATS.STAT_SET_INT("H3OPT_CREWWEAP", 4)
                    STATS.STAT_SET_INT("H3OPT_CREWDRIVER", 3)
                    STATS.STAT_SET_INT("H3OPT_CREWHACKER", 4)
                    STATS.STAT_SET_INT("H3OPT_DISRUPTSHIP", 3)
                    STATS.STAT_SET_INT("H3OPT_BODYARMORLVL", -1)
                    STATS.STAT_SET_INT("H3OPT_KEYLEVELS", 2)
                    STATS.STAT_SET_INT("H3OPT_BITSET1", 799)
                    STATS.STAT_SET_INT("H3OPT_BITSET0", 3670102)
end
)



ui.add_click_option("前置-兵不厌诈", DC, function()
                    STATS.STAT_SET_INT("H3_COMPLETEDPOSIX", -1)
                    STATS.STAT_SET_INT("H3OPT_MASKS", 2)
                    STATS.STAT_SET_INT("H3OPT_WEAPS", 1)
                    STATS.STAT_SET_INT("H3OPT_VEHS", 3)
                    STATS.STAT_SET_INT("CAS_HEIST_FLOW", -1)
                    STATS.STAT_SET_INT("H3_LAST_APPROACH", 0)
                    STATS.STAT_SET_INT("H3OPT_APPROACH", 2)
                    STATS.STAT_SET_INT("H3_HARD_APPROACH", 0)
                    STATS.STAT_SET_INT("H3OPT_TARGET", 3)
                    STATS.STAT_SET_INT("H3OPT_POI", 1023)
                    STATS.STAT_SET_INT("H3OPT_ACCESSPOINTS", 2047)
                    STATS.STAT_SET_INT("H3OPT_CREWWEAP", 4)
                    STATS.STAT_SET_INT("H3OPT_CREWDRIVER", 3)
                    STATS.STAT_SET_INT("H3OPT_CREWHACKER", 4)
                    STATS.STAT_SET_INT("H3OPT_DISRUPTSHIP", 3)
                    STATS.STAT_SET_INT("H3OPT_BODYARMORLVL", -1)
                    STATS.STAT_SET_INT("H3OPT_KEYLEVELS", 2)
                    STATS.STAT_SET_INT("H3OPT_BITSET1", 159)
                    STATS.STAT_SET_INT("H3OPT_BITSET0", 524118)
end
)

ui.add_click_option("所有玩家到账3500k-选择最低出价的买家", DC, function( )
                    STATS.STAT_SET_INT("H3_COMPLETEDPOSIX", -1)
                    STATS.STAT_SET_INT("H3OPT_MASKS", 4)
                    STATS.STAT_SET_INT("H3OPT_WEAPS", 1)
                    STATS.STAT_SET_INT("H3OPT_VEHS", 3)
                    STATS.STAT_SET_INT("CAS_HEIST_FLOW", -1)
                    STATS.STAT_SET_INT("H3_LAST_APPROACH", 0)
                    STATS.STAT_SET_INT("H3OPT_APPROACH", 1)
                    STATS.STAT_SET_INT("H3_HARD_APPROACH", 0)
                    STATS.STAT_SET_INT("H3OPT_TARGET", 3)
                    STATS.STAT_SET_INT("H3OPT_POI", 1023)
                    STATS.STAT_SET_INT("H3OPT_ACCESSPOINTS", 2047)
                    STATS.STAT_SET_INT("H3OPT_CREWWEAP", 4)
                    STATS.STAT_SET_INT("H3OPT_CREWDRIVER", 3)
                    STATS.STAT_SET_INT("H3OPT_CREWHACKER", 4)
                    STATS.STAT_SET_INT("H3OPT_DISRUPTSHIP", 3)
                    STATS.STAT_SET_INT("H3OPT_BODYARMORLVL", -1)
                    STATS.STAT_SET_INT("H3OPT_KEYLEVELS", 2)
                    STATS.STAT_SET_INT("H3OPT_BITSET1", 127)
                    STATS.STAT_SET_INT("H3OPT_BITSET0", 262270)
end
)

function chatspam()
	local sends = ui.get_value(options['chatspam'])
    if sneds == 0 then
        online.send_chat(string.format("%s", spam))
        system.yield(500)
        online.send_chat(string.format("%s", spam))
    elseif sends == 1 then 
        online.send_chat(string.format("%s", spam))
        system.yield(500)
        online.send_chat(string.format("%s", spam))
        system.yield(500)
        online.send_chat(string.format("%s", spam))
    elseif sends == 2 then
        online.send_chat(string.format("%s", spam))
        system.yield(500)
        online.send_chat(string.format("%s", spam))
        system.yield(500)
        online.send_chat(string.format("%s", spam))
        system.yield(500)
        online.send_chat(string.format("%s", spam))
    else
    end
end


ui.add_bool_option("开启公屏广告机",  session_sub, function(on)
    local me = PLAYER.PLAYER_PED_ID()
	if on then
      while on and ENTITY.DOES_ENTITY_EXIST(me) do
      system.yield(50)
      chatspam()
     -- online.change_session(1)
      system.yield(50)
      end
    end
    if not on then 
    end
end
)

ui.add_click_option("cs", session_sub, function( )
    online.send_chat(string.format("%s", spam))
end
)

ui.add_click_option("ped", session_sub, function()
	local me = PLAYER.PLAYER_ID()
    if  player_exist()  then
    failednotify("yes")
    else
    failednotify("no")
    end

end
)

options['chatspam'] = ui.add_choose("广告机发送次数", session_sub, true, {"2", "3", "4"}, function()
end
)




ui.add_click_option("一键100分红", DC, function ()
    globals.set_int(1966534 + 1497 + 736 + 92 + 1, 100)
    globals.set_int(1966534 + 1497 + 736 + 92 + 2, 100)
    globals.set_int(1966534 + 1497 + 736 + 92 + 3, 100)
    globals.set_int(1966534 + 1497 + 736 + 92 + 4, 100)
end)

ui.add_num_option("赌场玩家1分红", DC, 0, 200, 1, function(num)
	globals.set_int(1966534 + 1497 + 736 + 92 + 1, num)
end)

ui.add_num_option("赌场玩家2分红", DC, 0, 200, 1, function(num)
	globals.set_int(1966534 + 1497 + 736 + 92 + 2, num)
end)

ui.add_num_option("赌场玩家3分红", DC, 0, 200, 1, function(num)
	globals.set_int(1966534 + 1497 + 736 + 92 + 3, num)
end)

ui.add_num_option("赌场玩家4分红", DC, 0, 200, 1, function(num)
	globals.set_int(1966534 + 1497 + 736 + 92 + 4, num)
end)

ui.add_click_option("指纹复制器", DC, function()
		globals.set_local("fm_mission_controller", 52929, 5)
end)

ui.add_click_option("密码门禁", DC, function()
		globals.set_local("fm_mission_controller", 53991, 5)
end)

ui.add_num_option("总收入", DC, 0, 10000000, 10000, function(num)
		globals.set_local("fm_mission_controller", 22365, num)
end)

ui.add_click_option("快速完成(仅气势汹汹)", DC, function()
		if globals.is_script_active("fm_mission_controller") then
			globals.set_local("fm_mission_controller", 22365, 10000000)
			globals.set_local("fm_mission_controller", 19679, 12)
			globals.set_local("fm_mission_controller", 28299, 99999)
			globals.set_local("fm_mission_controller", 31623, 99999)	
		end
	end)
]]


--[[local function clearBit(addr, bitIndex)
    memory.write_int(addr, memory.read_int(addr) &~ (bitIndex))
end

local function bitTest(addr, offset)
    return (memory.read_int(addr) & (offset)) ~= 0
end

ui.add_click_option("索赔载具", selfveh_sub, function()
    local count = memory.read_int(memory.script_global(1585857))
    for i = 0, count do
        local canFix = (bitTest(memory.script_global(1585857 + 1 + (i * 142) + 103), 1) and bitTest(memory.script_global(1585857 + 1 + (i * 142) + 103), 2))
        if canFix then
            clearBit(memory.script_global(1585857 + 1 + (i * 142) + 103), 1)
            clearBit(memory.script_global(1585857 + 1 + (i * 142) + 103), 3)
            clearBit(memory.script_global(1585857 + 1 + (i * 142) + 103), 16)
            
        end
    end

end
)
]]


while true do
    system.yield()
end

