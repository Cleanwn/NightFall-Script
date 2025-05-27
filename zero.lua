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









while true do
    system.yield()
end

