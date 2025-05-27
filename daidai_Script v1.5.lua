function notify(text)
	system.notify("daidai_Script.lua", text, 30, 222, 255, 255)
	system.log("daidai_Script.lua", text)
end
function player_exists(pid)
	return NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid)
end
notify("daidai_Script BY:呆呆")
notify("Version 1.5")
notify("欢迎加群343798401")
--

--ui.add_bool_option-----选择
--ui.add_click_option----点击

local global = require("daidai_Script/globals/heist_control")
local stats = require("daidai_Script/stats/heist_control")
local features = require ("daidai_Script/lib/features")
local callbacks = require ("daidai_Script/lib/callbacks")



local main_sub = ui.add_main_submenu("daidai_Script")






----恶搞选项
self_list = ui.add_submenu("自我选项")
	ui.add_sub_option("自我选项", main_sub, self_list)
online_list = ui.add_submenu("在线选项")
	ui.add_sub_option("在线选项", main_sub, online_list)
weapons = ui.add_submenu("武器选项")
	ui.add_sub_option("武器选项", main_sub, weapons)
vehicle = ui.add_submenu("载具选项")
	ui.add_sub_option("载具选项", main_sub, vehicle)
funfeatures = ui.add_submenu("娱乐选项")
	ui.add_sub_option("娱乐选项", main_sub, funfeatures)
LLtool = ui.add_submenu("任务选项")
	ui.add_sub_option("任务选项", main_sub, LLtool)
worldlist = ui.add_submenu("世界选项")
	ui.add_sub_option("世界选项", main_sub, worldlist)
other_list = ui.add_submenu("其他选项")
	ui.add_sub_option("其他选项", main_sub, other_list)




----自我选项
recover = ui.add_submenu("恢复")
	ui.add_sub_option("恢复", self_list, recover)

		ui.add_click_option("补充血量", recover, function()
			ENTITY.SET_ENTITY_HEALTH(PLAYER.PLAYER_PED_ID(), PED.GET_PED_MAX_HEALTH(PLAYER.PLAYER_PED_ID()), 0)
		end)
		ui.add_click_option("补充护甲", recover, function()
			PED.SET_PED_ARMOUR(PLAYER.PLAYER_PED_ID(), 100)
		end)

		ui.add_click_option("补充所有零食", recover, function()
			local char = features.getMpChar()
			STATS.STAT_SET_INT(utils.joaat("MP" .. char .."_NO_BOUGHT_YUM_SNACKS"), 100, 1);
			STATS.STAT_SET_INT(utils.joaat("MP" .. char .."_NO_BOUGHT_HEALTH_SNACKS"), 100, 1);
			STATS.STAT_SET_INT(utils.joaat("MP" .. char .."_NO_BOUGHT_EPIC_SNACKS"), 100, 1);
			STATS.STAT_SET_INT(utils.joaat("MP" .. char .."_CIGARETTES_BOUGHT"), 100, 1);
			STATS.STAT_SET_INT(utils.joaat("MP" .. char .."_NUMBER_OF_ORANGE_BOUGHT"), 100, 1);
			STATS.STAT_SET_INT(utils.joaat("MP" .. char .."_NUMBER_OF_BOURGE_BOUGHT"), 100, 1);
		end)

		ui.add_num_option("玩家隐身",self_list, 0, 255, 51, function(num)
			local ped = PLAYER.PLAYER_PED_ID()
			ENTITY.SET_ENTITY_ALPHA(ped, num, false)
		end)
		ui.add_num_option("假通缉等级", self_list, 0, 6, 1, function(num)
			MISC.SET_FAKE_WANTED_LEVEL(num)
		end)
		ui.add_click_option("起飞", self_list, function()
			local myped = PLAYER.PLAYER_PED_ID()
			local myPos = ENTITY.GET_ENTITY_COORDS(myped, false)
				ENTITY.SET_ENTITY_COORDS(myped, myPos.x, myPos.y, myPos.z + 250.0, 1, 0, 0, 1)
		end)
		ui.add_click_option("拉便便", self_list, function() 
			local ped = PLAYER.PLAYER_PED_ID()
			local shit = utils.joaat("prop_big_shit_02")
			local coords = features.getEntityCoords(ped)
			coords.z = coords.z - 1
			callbacks.requestAnimDict("missfbi3ig_0", function()
				TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
				TASK.TASK_PLAY_ANIM(ped, "missfbi3ig_0", "shit_loop_trev" , 8.0, 8.0, 3000, 0, 0, true, true, true)
				system.yield(1000)
				entities.create_object(shit, coords)
			end)
		end)
		ui.add_bool_option("无脚步声",self_list, function(toggle)
			local ped = PLAYER.PLAYER_PED_ID()
				AUDIO._SET_PED_AUDIO_FOOTSTEP_LOUD(ped, not toggle)
		end)

		ui.add_click_option("清洁自身",self_list, function()
			PED.CLEAR_PED_BLOOD_DAMAGE(PLAYER.PLAYER_PED_ID())
    		PED.CLEAR_PED_WETNESS(PLAYER.PLAYER_PED_ID())
    		PED.CLEAR_PED_ENV_DIRT(PLAYER.PLAYER_PED_ID())
		end)

----在线选项
--ui.add_separator("噪音", online_list)
	ui.add_bool_option("噪音", online_list, function()
		local ped = PLAYER.PLAYER_PED_ID()
		for i = 0, 5 do
			AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "07", ped, "DLC_GR_CS2_Sounds", true, 0)
		end
	end)





OLtool = ui.add_submenu("全局恶搞")
	ui.add_sub_option("全局恶搞", online_list, OLtool)

	crashall = ui.add_submenu("崩溃选项")
	ui.add_sub_option("崩溃选项", OLtool, crashall)

		ui.add_click_option("声音崩溃", crashall, function()
			local ped = PLAYER.PLAYER_PED_ID()
			for i = 0, 50 do
				AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Event_Message_Purple", ped, "GTAO_FM_Events_Soundset", true, 0)
			end
			system.yield(500)
		end)

		ui.add_separator("发送玩家", OLtool)
		ui.add_click_option("发送所有玩家到海滩", OLtool, function()
			for pids = 0, 31 do
				if pids ~= PLAYER.GET_PLAYER_INDEX() then
					online.send_script_event(pids, 330622597 ,1, 0, 0, 4,0, PLAYER.GET_PLAYER_INDEX(), pids)
				end
			end
		end)
		ui.add_click_option("发送所有玩家到岛屿", OLtool, function()
			for pids = 0, 31 do
				if pids ~= PLAYER.GET_PLAYER_INDEX() then
					online.send_script_event(pids, 330622597, 1, 0, 0, 1, 1,PLAYER.GET_PLAYER_INDEX(), pids)
				end
			end
		end)
----武器选项

ui.add_click_option("移除所有武器", weapons, function()
	WEAPON.REMOVE_ALL_PED_WEAPONS(PLAYER.PLAYER_PED_ID(), false)
end)

----载具选项
ui.add_click_option("传送到最近载具", vehicle, function()
	local vehicle = features.getClosestVehicle()
	local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1, false)
	if VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, -1, false) == 1 then
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), vehicle, -1)
    else
		if PED.IS_PED_A_PLAYER(driver) == 0 then
			entities.delete(driver)
			PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), vehicle, -1)
		elseif VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(vehicle) then
			for i=-1, VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(ENTITY.GET_ENTITY_MODEL(vehicle)) do
				if VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, i, false)==1 then
					PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), vehicle, i)
					return
				end
			end
		end
	end
end)
ui.add_choose("换座", vehicle, false, {"司机", "副驾驶", "左乘客", "右乘客"}, function(pos)
	local ped = PLAYER.PLAYER_PED_ID()
	local vehicle = features.getLocalVehicle(false)
	PED.SET_PED_INTO_VEHICLE(ped, vehicle, pos-1)
end)
ui.add_click_option("清洁载具", vehicle, function(on_click)
	local last_vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true)
		GRAPHICS.REMOVE_DECALS_FROM_VEHICLE(last_vehicle)
    	VEHICLE.SET_VEHICLE_DIRT_LEVEL(last_vehicle, 0)
end)
ui.add_click_option("强制离开载具", vehicle, function(on_click)
	local ped = PLAYER.PLAYER_PED_ID()
    	TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
    	TASK.TASK_LEAVE_ANY_VEHICLE(ped, 0, 16)
end)
ui.add_bool_option("瘫痪驾驶", vehicle, function(on)
	local last_vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true)
    if on then
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(last_vehicle, true)
		VEHICLE._SET_VEHICLE_REDUCE_TRACTION(last_vehicle, 50)
	else
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(last_vehicle, false)
		VEHICLE._SET_VEHICLE_REDUCE_TRACTION(last_vehicle, 100)
	end
end)
ui.add_num_option("设置污垢", vehicle, 0.0, 15, 1, function(num)
	local last_vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true)
    	VEHICLE.SET_VEHICLE_DIRT_LEVEL(last_vehicle, num)
end)

ui.add_bool_option("引擎始终开启", vehicle, function()
	local vehicle = features.getLocalVehicle(false)
	if features.doesEntityExist(vehicle) then
		VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
		VEHICLE.SET_VEHICLE_LIGHTS(vehicle, 0)
		VEHICLE._SET_VEHICLE_LIGHTS_MODE(vehicle, 2)
	end
end)
ui.add_bool_option("移除湍流", vehicle, function(on)
    if on then
		VEHICLE.SET_PLANE_TURBULENCE_MULTIPLIER(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), 0), 0.0)
	else
		VEHICLE.SET_PLANE_TURBULENCE_MULTIPLIER(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), 0), 1.0)
	end
end)
ui.add_click_option("启用警报（30 秒）", vehicle, function()
	local vehicle = features.getLocalVehicle(true)
	if features.doesEntityExist(vehicle) then
		entities.request_control(vehicle, function()	
			VEHICLE.SET_VEHICLE_ALARM(vehicle, true)
			VEHICLE.START_VEHICLE_ALARM(vehicle)
		end)
	end
end)
ui.add_bool_option("反相控制", vehicle, function(state)
	local vehicle = features.getLocalVehicle(true)
	entities.request_control(vehicle, function()
		VEHICLE._SET_VEHICLE_CONTROLS_INVERTED(vehicle, state)
	end)
end)

cardoor = ui.add_submenu("车门控制")
	ui.add_sub_option("车门控制", vehicle, cardoor)

ui.add_choose("车门开/关", cardoor, false, {"引擎盖", "后备箱", "左前门", "右前门", "后左门", "后右门"}, function (select)
	local last_vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true)
		if select == 0 then
			VEHICLE.SET_VEHICLE_DOOR_OPEN(last_vehicle, 4, false, false)
		end
		if select == 1 then
			VEHICLE.SET_VEHICLE_DOOR_OPEN(last_vehicle, 5, false, false)
		end
		if select == 2 then
			VEHICLE.SET_VEHICLE_DOOR_OPEN(last_vehicle, 0, false, false)
		end
		if select == 3 then
			VEHICLE.SET_VEHICLE_DOOR_OPEN(last_vehicle, 1, false, false)
		end
		if select == 4 then
			VEHICLE.SET_VEHICLE_DOOR_OPEN(last_vehicle, 2, false, false)
		end
		if select == 5 then
			VEHICLE.SET_VEHICLE_DOOR_OPEN(last_vehicle, 3, false, false)
		end
end)

ui.add_click_option("打开所有门", cardoor, function()
	local last_vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true)
		for i = 0, 5 do
			VEHICLE.SET_VEHICLE_DOOR_OPEN(last_vehicle, i, false, false)
		end
end)

ui.add_click_option("关闭所有门", cardoor, function()
	local last_vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true)
    	VEHICLE.SET_VEHICLE_DOORS_SHUT(last_vehicle, false)
end)





----娱乐选项
ui.add_bool_option("暴动模式", funfeatures, function(state) 
	MISC.SET_RIOT_MODE_ENABLED(state)
end)
ui.add_click_option("在航路点呼叫炮击", funfeatures, function()
	local coords = features.getWaypointCoords()
	for i = 1, 20 do
		local a = math.random(-10, 10)
		local b = math.random(-10, 10)
		FIRE.ADD_EXPLOSION(coords.x+a, coords.y-b, coords.z, 34, 300, true, false, 1, false)
		system.yield(500)
	end
end)
------------------------------------------任务选项

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

local function add_preset(v, sub)
	if v.stats then
		ui.add_click_option(v.name, sub, function()
			for _, stat_info in ipairs(v.stats) do
				set_stat_int(stat_info[1], stat_info[2])
			end
			notify("设置成功，如未生效，请离开此区域重新进入/换战局")
		end)
	elseif v.func then
		ui.add_bool_option(v.name, sub, v.func)
	end
end

local presets = {
	{name = "完成虎鲸准备任务[190w]", cayo = true, stats = stats.cayo.only_primary.diaoxiang},
	{name = "虎鲸抢劫面板重置", cayo = true, stats = stats.cayo.only_primary.xdchongzhi},


	{name = "钻石 - 气势汹汹", casino = true, stats = stats.casino.diamonds.aggressive},
	{name = "赌场抢劫面板重置", casino = true, stats = stats.casino.diamonds.dcchongzhi},

	{name = "末日一 : 数据泄露", doomsday = true, stats = stats.doomsday.act1},
	{name = "末日二 : 波格丹危机", doomsday = true, stats = stats.doomsday.act2},
	{name = "末日三 : 末日将至", doomsday = true, stats = stats.doomsday.act3},
	{name = "重置面板(切换战局生效)", doomsday = true, stats = stats.doomsday.act4}
}

local function sub_tab(name, sub_id)
	local tab = ui.add_submenu(name)
	ui.add_sub_option(name, sub_id, tab)
	return tab
end



		perrico_island = ui.add_submenu("佩里科岛")
			ui.add_sub_option("佩里科岛", LLtool, perrico_island)

				ui.add_click_option("呼叫虎鲸",perrico_island, function()
					globals.set_int(2793046 + 954, 1)
				end)
				ui.add_click_option("传送到虎鲸",perrico_island, function()
						pedp = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
						ENTITY.SET_ENTITY_COORDS(pedp, 1561.2369, 385.8771, -49.689915, false, false, false, true)
				end)

				local cayo_presets = sub_tab("任务设定", perrico_island)
					for k, v in ipairs(presets) do
						if v.cayo then
							add_preset(v, cayo_presets)
							globals.set_local("heist_island_planning", 1525, 2)----刷新
						end
					end

				TELEPORT_island = ui.add_submenu("地点传送")
					ui.add_sub_option("地点传送", perrico_island, TELEPORT_island)
				
					ui.add_click_option("传送到大门(外侧)", TELEPORT_island, function()
						pedp = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
						ENTITY.SET_ENTITY_COORDS(pedp, 4974.189, -5703.279, 19.898539, false, false, false, true)
					end)
					ui.add_click_option("传送到大门(内测)", TELEPORT_island, function()
						pedp = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
						ENTITY.SET_ENTITY_COORDS(pedp, 4993.189, -5720.279, 19.898539, false, false, false, true)
					end)
					ui.add_click_option("主要目标", TELEPORT_island, function()
						pedp = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
						ENTITY.SET_ENTITY_COORDS(pedp, 5006.7, -5756.2, 14.8, false, false, false, true)
					end)
					ui.add_click_option("次要目标", TELEPORT_island, function()
						pedp = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
						ENTITY.SET_ENTITY_COORDS(pedp, 4999.764160, -5749.863770, 14.840000, false, false, false, true)
					end)
					ui.add_click_option("机场(逃离)", TELEPORT_island, function()
						pedp = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
						ENTITY.SET_ENTITY_COORDS(pedp, 4443.189, -4510.279, 4.898539, false, false, false, true)
					end)
					ui.add_click_option("传送到大海", TELEPORT_island, function()
						pedp = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
						ENTITY.SET_ENTITY_COORDS(pedp, 3235, -4938, 56, false, false, false, true)
					end)


				island_FH = ui.add_submenu("玩家分红")
					ui.add_sub_option("玩家分红", perrico_island, island_FH)

						ui.add_click_option("全员100分红", island_FH, function()
							globals.set_int(1977693 + 823 + 56, 100)
							globals.set_int(1977693 + 823 + 56 + 1, 100)
							globals.set_int(1977693 + 823 + 56 + 2, 100)
							globals.set_int(1977693 + 823 + 56 + 3, 100)
							globals.set_int(1977693 + 823 + 56 + 4, 100)
						end)
						ui.add_click_option("全员135分红", island_FH, function()
							globals.set_int(1977693 + 823 + 56, 135)
							globals.set_int(1977693 + 823 + 56 + 1, 135)
							globals.set_int(1977693 + 823 + 56 + 2, 135)
							globals.set_int(1977693 + 823 + 56 + 3, 135)
							globals.set_int(1977693 + 823 + 56 + 4, 135)
						end)
						ui.add_click_option("自保分红", island_FH, function()
							globals.set_int(1977693 + 823 + 56, 60)
							globals.set_int(1977693 + 823 + 56 + 1, 60)
							globals.set_int(1977693 + 823 + 56 + 2, 135)
							globals.set_int(1977693 + 823 + 56 + 3, 135)
							globals.set_int(1977693 + 823 + 56 + 4, 135)
						end)
						ui.add_num_option("自定义分红", island_FH, 0, 500, 5, function(num)
							globals.set_int(1977693 + 823 + 56, num)
							globals.set_int(1977693 + 823 + 56 + 1, num)
							globals.set_int(1977693 + 823 + 56 + 2, num)
							globals.set_int(1977693 + 823 + 56 + 3, num)
							globals.set_int(1977693 + 823 + 56 + 4, num)
						end)
				done_quickly_island = ui.add_submenu("高级选项")
					ui.add_sub_option("高级选项", perrico_island, done_quickly_island)
						ui.add_click_option("一键完成佩里科岛", done_quickly_island, function()
							if globals.is_script_active("fm_mission_controller_2020") then
								globals.set_local("fm_mission_controller_2020", 42279 + 1, 51338752)
								globals.set_local("fm_mission_controller_2020", 42279 + 1375 + 1, 50) 
							end
							notify("如果卡住, 切换战局即可")
					end)
					ui.add_click_option("跳过指纹锁", done_quickly_island, function()
						if globals.get_local_int("fm_mission_controller_2020", 22032) == 4 then
							globals.set_local("fm_mission_controller_2020", 22032, 5)
						end
						notify("先进行骇入")
					end)
						--[[ ui.add_bool_option("Always dry",done_quickly_island, function(bool)
							
							end) ]]



		casino = ui.add_submenu("名钻赌场")
			ui.add_sub_option("名钻赌场", LLtool, casino)

				local casino_presets = sub_tab("任务设定", casino)
					for k, v in ipairs(presets) do
						if v.casino then
							add_preset(v, casino_presets)
						end
					end

			casino_FH = ui.add_submenu("玩家分红")
				ui.add_sub_option("玩家分红", casino, casino_FH)

					ui.add_click_option("全员100分红", casino_FH, function()
						globals.set_int(1970895 + 1497 + 736 + 92, 100)
						globals.set_int(1970895 + 1497 + 736 + 92+1, 100)
						globals.set_int(1970895 + 1497 + 736 + 92+2, 100)
						globals.set_int(1970895 + 1497 + 736 + 92+3, 100)
						globals.set_int(1970895 + 1497 + 736 + 92+4, 100) 
					end)
					ui.add_click_option("全员200分红", casino_FH, function()
						globals.set_int(1970895 + 1497 + 736 + 92, 200)
						globals.set_int(1970895 + 1497 + 736 + 92+1, 200)
						globals.set_int(1970895 + 1497 + 736 + 92+2, 200)
						globals.set_int(1970895 + 1497 + 736 + 92+3, 200)
						globals.set_int(1970895 + 1497 + 736 + 92+4, 200) 
					end)
					ui.add_click_option("自保分红", casino_FH, function()
						globals.set_int(1970895 + 1497 + 736 + 92, 60)
						globals.set_int(1970895 + 1497 + 736 + 92+1, 60)
						globals.set_int(1970895 + 1497 + 736 + 92+2, 250)
						globals.set_int(1970895 + 1497 + 736 + 92+3, 250)
						globals.set_int(1970895 + 1497 + 736 + 92+4, 250)  ----- Aure
					end)
					ui.add_num_option("自定义分红", casino_FH, 0, 500, 5, function(num)
						globals.set_int(1970895 + 1497 + 736 + 92, num)
						globals.set_int(1970895 + 1497 + 736 + 92 + 1, num)
						globals.set_int(1970895 + 1497 + 736 + 92 + 2, num)
						globals.set_int(1970895 + 1497 + 736 + 92 + 3, num)
						globals.set_int(1970895 + 1497 + 736 + 92 + 4, num)
					end)

				TELEPORT_casino = ui.add_submenu("地点传送")
					ui.add_sub_option("地点传送", casino, TELEPORT_casino)
				
					ui.add_click_option("计划面板(游戏厅)", TELEPORT_casino, function()
						pedp = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
						ENTITY.SET_ENTITY_COORDS(pedp, 2711.773, -369.458, -54.781, false, false, false, true)
					end)
					ui.add_click_option("车库出口(游戏厅)", TELEPORT_casino, function()
						pedp = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
						ENTITY.SET_ENTITY_COORDS(pedp, 2677.237, -361.494, -55.187, false, false, false, true)
					end)
					ui.add_click_option("门口(赌场)", TELEPORT_casino, function()
						pedp = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
						ENTITY.SET_ENTITY_COORDS(pedp, 917.24634, 48.989567, 80.89892, false, false, false, true)
					end)
					ui.add_click_option("员工大厅(赌场)", TELEPORT_casino, function()
						pedp = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
						ENTITY.SET_ENTITY_COORDS(pedp, 965.14856, -9.05023, 80.63045, false, false, false, true)
					end)
					ui.add_click_option("废物处理间(赌场)", TELEPORT_casino, function()
						pedp = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
						ENTITY.SET_ENTITY_COORDS(pedp, 997.5346, 84.51491, 80.990555, false, false, false, true)
					end)
					ui.add_click_option("废物处理间(赌场)", TELEPORT_casino, function()
						pedp = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
						ENTITY.SET_ENTITY_COORDS(pedp, 2542.052, -214.3084, -58.722965, false, false, false, true)
					end)
					ui.add_click_option("员工大门(赌场)", TELEPORT_casino, function()
						pedp = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
						ENTITY.SET_ENTITY_COORDS(pedp, 2547.9192, -273.16754, -58.723003, false, false, false, true)
					end)
					ui.add_click_option("双人刷卡点(赌场)", TELEPORT_casino, function()
						pedp = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
						ENTITY.SET_ENTITY_COORDS(pedp, 2465.4746, -279.2276, -70.694145, false, false, false, true)
					end)
					ui.add_click_option("金库内部(赌场)", TELEPORT_casino, function()
						pedp = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
						ENTITY.SET_ENTITY_COORDS(pedp, 2515.1252, -238.91661, -70.73713, false, false, false, true)
					end)
					ui.add_click_option("库外部(赌场)", TELEPORT_casino, function()
						pedp = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
						ENTITY.SET_ENTITY_COORDS(pedp, 2497.5098, -238.50768, -70.7388, false, false, false, true)
					end)
					ui.add_click_option("小金库(赌场)", TELEPORT_casino, function()
						pedp = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
						ENTITY.SET_ENTITY_COORDS(pedp, 2520.8645, -286.30685, -58.723007, false, false, false, true)
					end)
			done_quickly_casino = ui.add_submenu("高级选项")
				ui.add_sub_option("高级选项", casino, done_quickly_casino)
					ui.add_click_option("一键完成名钻赌场(仅气势汹汹)", done_quickly_casino, function()
						if globals.is_script_active("fm_mission_controller") then
							globals.set_local("fm_mission_controller", 19707 + 1741, 151)
							globals.set_local("fm_mission_controller", 19707 + 2686, 10000000) 
							globals.set_local("fm_mission_controller", 27471 + 859, 99999) 
							globals.set_local("fm_mission_controller", 31585 + 69, 99999) 
							globals.set_local("fm_mission_controller", 31585 + 97, 79) 
						end
						notify("如果卡住, 切换战局即可")
					end)

		doomsday = ui.add_submenu("末日豪杰")
			ui.add_sub_option("末日豪杰", LLtool, doomsday)

				local doomsday_presets = sub_tab("任务设定", doomsday)
					for k, v in ipairs(presets) do
						if v.doomsday then
							add_preset(v, doomsday_presets)
						end
					end

				TELEPORT_doomsday = ui.add_submenu("地点传送")
					ui.add_sub_option("地点传送", doomsday, TELEPORT_doomsday)
			
					ui.add_click_option("抢劫屏幕", TELEPORT_doomsday, function()
						pedp = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
						ENTITY.SET_ENTITY_COORDS(pedp, 350.69284, 4872.308, -60.794243, false, false, false, true)
					end)
					doomsday_FH = ui.add_submenu("玩家分红")
					ui.add_sub_option("玩家分红", doomsday, doomsday_FH)

					ui.add_click_option("全员100分红", doomsday_FH, function()
						globals.set_int(1966831 + 812 + 50, 100)
						globals.set_int(1966831 + 812 + 50 + 1, 100)
						globals.set_int(1966831 + 812 + 50 + 2, 100)
						globals.set_int(1966831 + 812 + 50 + 3, 100)
						globals.set_int(1966831 + 812 + 50 + 4, 100) 
					end)
					ui.add_click_option("全员200分红", doomsday_FH, function()
						globals.set_int(1966831 + 812 + 50, 200)
						globals.set_int(1966831 + 812 + 50 + 1, 200)
						globals.set_int(1966831 + 812 + 50 + 2, 200)
						globals.set_int(1966831 + 812 + 50 + 3, 200)
						globals.set_int(1966831 + 812 + 50 + 4, 200) 
					end)
					ui.add_click_option("自保分红", doomsday_FH, function()
						globals.set_int(1966831 + 812 + 50, 60)
						globals.set_int(1966831 + 812 + 50 + 1, 60)
						globals.set_int(1966831 + 812 + 50 + 2, 250)
						globals.set_int(1966831 + 812 + 50 + 3, 250)
						globals.set_int(1966831 + 812 + 50 + 4, 250)  ----- Aure
					end)
					ui.add_num_option("自定义分红", doomsday_FH, 0, 500, 5, function(num)
						globals.set_int(1966831 + 812 + 50, num)
						globals.set_int(1966831 + 812 + 50 + 1, num)
						globals.set_int(1966831 + 812 + 50 + 2, num)
						globals.set_int(1966831 + 812 + 50 + 3, num)
						globals.set_int(1966831 + 812 + 50 + 4, num)
					end)










----世界选项
weather = ui.add_submenu("天气选项")
		ui.add_sub_option("天气选项", worldlist, weather)
	ui.add_click_option("打雷", weather, function()
		MISC.FORCE_LIGHTNING_FLASH()
	end)
	ui.add_num_option("设置风速", weather, 0, 15, 1, function(num)
		MISC.SET_WIND_SPEED(num)
	end)
	ui.add_bool_option("停止下雨", weather, function(on)
		if on then
			MISC._SET_RAIN_LEVEL(0.0)
		else
			MISC._SET_RAIN_LEVEL(0.5)
		end
	end)

visual_effects = ui.add_submenu("视觉特效")
	ui.add_sub_option("视觉特效", worldlist, visual_effects)
		ui.add_bool_option("DMT", visual_effects, function(on)
			if on then
				GRAPHICS.ANIMPOSTFX_PLAY("DMT_flight", 0, true)
			else
				GRAPHICS.ANIMPOSTFX_STOP("DMT_flight")
			end
		end)
		ui.add_bool_option("小丑", visual_effects, function(on)
			if on then
				GRAPHICS.ANIMPOSTFX_PLAY("DrugsTrevorClownsFight", 0, true)
			else
				GRAPHICS.ANIMPOSTFX_STOP("DrugsTrevorClownsFight")
			end
		end)
		ui.add_bool_option("狗的视觉", visual_effects, function(on)
			if on then
				GRAPHICS.ANIMPOSTFX_PLAY("ChopVision", 0, true)
			else
				GRAPHICS.ANIMPOSTFX_STOP("ChopVision")
			end
		end)
		ui.add_bool_option("横冲直撞", visual_effects, function(on)
			if on then
				GRAPHICS.ANIMPOSTFX_PLAY("Rampage", 0, true)
			else
				GRAPHICS.ANIMPOSTFX_STOP("Rampage")
			end
		end)
		ui.add_bool_option("末日", visual_effects, function(on)
			if on then
				GRAPHICS.ANIMPOSTFX_PLAY("DeadlineNeon", 0, true)
			else
				GRAPHICS.ANIMPOSTFX_STOP("DeadlineNeon")
			end
		end)
		ui.add_bool_option("集中驾驶", visual_effects, function(on)
			if on then
				GRAPHICS.ANIMPOSTFX_PLAY("DrivingFocus", 0, true)
			else
				GRAPHICS.ANIMPOSTFX_STOP("DrivingFocus")
			end
		end)

ui.add_click_option("删除所有黏弹", worldlist, function()
	local stb = utils.joaat("weapon_stickybomb")
		WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(stb, false)
end)
ui.add_choose("灯光", worldlist, true, {"关闭", "开启", "开（影响车辆)"}, function(pos)
	GRAPHICS.SET_ARTIFICIAL_LIGHTS_STATE(pos > 0) GRAPHICS._SET_ARTIFICIAL_LIGHTS_STATE_AFFECTS_VEHICLES(pos == 2)
end)
ui.add_choose("传送", worldlist, false, {"佩里托小海湾", "国际机场", "赌场门口", "传送到乞力耶德山山顶", "花园银行楼顶", "监狱", "军事基地"}, function (select)
    local myped = PLAYER.PLAYER_PED_ID()
	local lveh = PED.GET_VEHICLE_PED_IS_IN(myped, true)

	if select == 0 then
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(myped, -1282.57, 5367.05, 2.73, 0, 0, 1)
	end

	if select == 1 then
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(myped, -1084.29, -2987.18, 13.94, 0, 0, 1)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(lveh, -1084.29, -2987.18, 13.94, 0, 0, 1)
		PED.SET_PED_INTO_VEHICLE(myped, lveh, -1)
	end

	if select == 2 then
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(myped, 905.54, 39.39, 80.53, 0, 0, 1)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(lveh, 905.54, 39.39, 80.53, 0, 0, 1)
		PED.SET_PED_INTO_VEHICLE(myped, lveh, -1)
	end

	if select == 3 then
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(myped, 499.74, 5590.85, 795.99, 0, 0, 1)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(lveh, 499.74, 5590.85, 795.99, 0, 0, 1)
		PED.SET_PED_INTO_VEHICLE(myped, lveh, -1)
	end

	if select == 4 then
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(myped, -76, -819, 327, 0, 0, 1)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(lveh, -76, -819, 327, 0, 0, 1)
		PED.SET_PED_INTO_VEHICLE(myped, lveh, -1)
	end

	if select == 5 then
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(myped, 1680.11, 2512.89, 45.56, 0, 0, 1)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(lveh, 1680.11, 2512.89, 45.56, 0, 0, 1)
		PED.SET_PED_INTO_VEHICLE(myped, lveh, -1)
	end

	if select == 6 then
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(myped, -2219.0, 3213.0, 32.81, 0, 0, 1)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(lveh, -2219.0, 3213.0, 32.81, 0, 0, 1)
		PED.SET_PED_INTO_VEHICLE(myped, lveh, -1)
	end

end)




---其他选项
ui.add_bool_option("隐藏 HUD", other_list, function(state)
	HUD.DISPLAY_RADAR(not state)
end)
ui.add_click_option("故事模式",other_list, function()
	NETWORK._SHUTDOWN_AND_LOAD_MOST_RECENT_SAVE()
end)
ui.add_click_option("强制重启游戏", other_list, function()
	NETWORK._SHUTDOWN_AND_LOAD_MOST_RECENT_SAVE()
end)







--------玩家选项
local main_sub = ui.add_player_submenu("daidai Script")

	TP_player = ui.add_submenu("发送玩家")
		ui.add_sub_option("发送玩家", main_sub, TP_player)

			ui.add_separator("玩家传送", TP_player)
				ui.add_click_option("发送玩家到海滩", TP_player, function()
					local target = online.get_selected_player()
					local name = online.get_name(target)
					notify("传送 " .. name .. " 到海滩")
					online.send_script_event(online.get_selected_player(), 330622597, 1, 0, 0, 4,0,online.get_selected_player())
				end)
				ui.add_click_option("发送玩家到岛屿", TP_player, function()
					local target = online.get_selected_player()
					local name = online.get_name(target)
					notify("传送 " .. name .. " 到佩里科岛")
					online.send_script_event(online.get_selected_player(), 330622597, 1, 0, 0, 3,1,online.get_selected_player())
				end)

	spoof_car = ui.add_submenu("载具恶搞")
		ui.add_sub_option("载具恶搞", main_sub, spoof_car)
			ui.add_separator("传送选项", spoof_car)

				ui.add_click_option("传送载具到导航点", spoof_car, function()
					local target = online.get_selected_player()
					local selfped = PLAYER.PLAYER_PED_ID()
					local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
					local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target), 0)
					local blip = HUD.GET_FIRST_BLIP_INFO_ID(8)
					local waypoint_pos = HUD.GET_BLIP_COORDS(blip)
					if blip == 0 then
						notify("你还没有设置导航点哦")
					return end
					entities.request_control(vehicle, function()
						ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, waypoint_pos.x, waypoint_pos.y, waypoint_pos.z + 75, 0, 0, 1)
					end)
				end)
				
				ui.add_click_option("传送载具到海中", spoof_car, function()
					local target = online.get_selected_player()
					local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target), 0)
					local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
					entities.request_control(vehicle, function()
						ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, -15000, -15000, 0, 0, 0, 1)
					end)
				end)
				
				ui.add_click_option("传送载具到花园银行楼顶", spoof_car, function()
					local target = online.get_selected_player()
					local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target), 0)
					entities.request_control(vehicle, function()
						ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, -76, -819, 327, 0, 0, 1)
					end)
				end)
				
				ui.add_click_option("传送载具到监狱", spoof_car, function()
					local target = online.get_selected_player()
					local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target), 0)
					entities.request_control(vehicle, function()
						ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, 1680.11, 2512.89, 45.56, 0, 0, 1)
					end)
				end)
				
				ui.add_click_option("送载具到军事基地", spoof_car, function()
					local target = online.get_selected_player()
					local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target), 0)
					entities.request_control(vehicle, function()
						ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, -2219.0, 3213.0, 32.81, 0, 0, 1)
					end)
				end)
				
				ui.add_separator("远程载具控制", spoof_car)
				
				ui.add_click_option("载具摧毁", spoof_car, function()
					local target = online.get_selected_player()
					local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target), 0)
					entities.request_control(vehicle, function()
						VEHICLE.SET_VEHICLE_PETROL_TANK_HEALTH(vehicle, -999.90002441406)
					end)
				end)
				ui.add_click_option("向上发射载具", spoof_car, function()
					local target = online.get_selected_player()
					local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target), 0)
					entities.request_control(vehicle, function()
						ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(vehicle, 1, 0, 0, 10000, true, false, true, false)
					end)
				end)
				ui.add_choose("强制载具推进方向", spoof_car, false, {"东边", "西边", "南边", "北边"}, function (select)
					local target = online.get_selected_player()
					local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target), 0)
						if select == 0 then
							entities.request_control(vehicle, function()
								ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(vehicle, 1, 10000, 0, 0, true, false, true, false)
							end)
						end
						if select == 1 then
							entities.request_control(vehicle, function()
								ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(vehicle, 1, -10000, 0, 0, true, false, true, false)
							end)
						end
						if select == 2 then
							entities.request_control(vehicle, function()
								ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(vehicle, 1, 0, -10000, 0, true, false, true, false)
							end)
						end
						if select == 3 then
							entities.request_control(vehicle, function()
								ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(vehicle, 1, 0, 10000, 0, true, false, true, false)
							end)
						end
				end)
				ui.add_click_option("踢出载具", spoof_car, function()
					local target = online.get_selected_player()
					local ind = PLAYER.GET_PLAYER_INDEX()
					online.send_script_event(target, 578856274, ind, -1, -1, -1, -1)
				end)
				ui.add_click_option("分离Trailer", spoof_car, function()
					local target = online.get_selected_player()
					local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target), 0)
					entities.request_control(vehicle, function()
						VEHICLE.DETACH_VEHICLE_FROM_TRAILER(vehicle)
					end)
				end)
				ui.add_choose("控制引擎", spoof_car, false, {"摧毁引擎", "修复引擎"}, function (select)
					local target = online.get_selected_player()
					local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target), 0)
						if select == 0 then
							entities.request_control(vehicle, function()
								VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, -4000)
								VEHICLE.SET_VEHICLE_BODY_HEALTH(vehicle, -4000)
								VEHICLE.SET_VEHICLE_PETROL_TANK_HEALTH(vehicle, -4000)
							end)
						end
						if select == 1 then
							entities.request_control(vehicle, function()
								VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, 1000)
								VEHICLE.SET_VEHICLE_BODY_HEALTH(vehicle, 1000)
								VEHICLE.SET_VEHICLE_PETROL_TANK_HEALTH(vehicle, 1000)
							end)
						end
				end)
				ui.add_choose("控制车门", spoof_car, false, {"把玩家锁在车里", "取消锁住他"}, function (select)
					local target = online.get_selected_player()
					local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target), 0)
						if select == 0 then
							entities.request_control(vehicle, function()
								VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 4) 
								VEHICLE.SET_VEHICLE_COLOURS(vehicle, 135, 135)
								VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, 5)
								VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "LOCKED") --- Doesn't work on personal vehicles.
							end)
						end
						if select == 1 then
							entities.request_control(vehicle, function()
								VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 1)
								VEHICLE.SET_VEHICLE_COLOURS(vehicle, 92, 92)
								VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, 5)
								VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "URFREE") --- Doesn't work on personal vehicles.
							end)
						end
				end)
				
				ui.add_separator("加速选项", spoof_car)
				
				ui.add_choose("加速选项", spoof_car, false, {"提高向前加速度", "提高向后加速度", "重置加速度"}, function (select)
					local target = online.get_selected_player()
					local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target), 0)
						if select == 0 then
							entities.request_control(vehicle, function()
								VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 9999999) 
							end)
						end
						if select == 1 then
							entities.request_control(vehicle, function()
								VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, -2147483647) 
							end)
						end
						if select == 2 then
							entities.request_control(vehicle, function()
								VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 1) 
							end)
						end
				end)
				
				ui.add_separator("直升机选项", spoof_car)
				
				ui.add_click_option("摧毁螺旋桨", spoof_car, function()
					local target = online.get_selected_player()
					local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target), 0)
					entities.request_control(vehicle, function()
						VEHICLE._SET_HELI_MAIN_ROTOR_HEALTH(vehicle, 0) 
					end)
				end)
				ui.add_choose("螺旋桨设置", spoof_car, false, {"设置螺旋桨速度为0%", "设置螺旋桨速度为100%"}, function(select)
					local target = online.get_selected_player()
					local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target), 0)
						if select == 0 then
							entities.request_control(vehicle, function()
								VEHICLE.SET_HELI_BLADES_SPEED(vehicle, 0.0)
							end)
						end
						if select == 1 then
							entities.request_control(vehicle, function()
								VEHICLE.SET_HELI_BLADES_SPEED(vehicle, 1.0) 
							end)
						end
				end)
				
				ui.add_separator("杂技选项", spoof_car)
				
				ui.add_choose("杂技", spoof_car, false, {"豚跳", "左侧空翻", "双左侧空翻", "右侧空翻"}, function (select)
					local target = online.get_selected_player()
					local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target), 0)
						if select == 0 then
							entities.request_control(vehicle, function()
								ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 10.0, 0.0, 0.0, 0.0, 1, false, true, true, true, true)
							end)
						end
						if select == 1 then
							entities.request_control(vehicle, function()
								ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 10.71, 5.0, 0.0, 0.0, 1, false, true, true, true, true)
							end)	
						end
						if select == 2 then
							entities.request_control(vehicle, function()
								ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 21.43, 20.0, 0.0, 0.0, 1, false, true, true, true, true)
							end)	
						end
						if select == 3 then
							entities.request_control(vehicle, function()
								ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, 10.71, -5.0, 0.0, 0.0, 1, false, true, true, true, true)
							end)	
						end
				end)


	spoof_option = ui.add_submenu("恶搞选项")
		ui.add_sub_option("恶搞选项", main_sub, spoof_option)

			ui.add_separator("崩溃选项", spoof_option)
				ui.add_click_option("崩溃v1", spoof_option, function()
					local target = online.get_selected_player()
					local selectedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
					local coords = ENTITY.GET_ENTITY_COORDS(selectedPlayer, 1)
					local hash = 3253274834
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
				end)

				ui.add_separator("实体选项", spoof_option)
				ui.add_click_option("在他面前放一堵墙", spoof_option, function()
					local target = online.get_selected_player()
					local selfped = PLAYER.PLAYER_PED_ID()
					local selectedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
					local forwardOffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(selectedPlayer, 0, 4, 0)
					local coords = ENTITY.GET_ENTITY_COORDS(selectedPlayer, 1)
					local pheading = ENTITY.GET_ENTITY_HEADING(selectedPlayer)
					local wall = utils.joaat("prop_shuttering03")
					local a1 = OBJECT.CREATE_OBJECT(wall, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, false, false)
						ENTITY.SET_ENTITY_HEADING(a1, pheading + 90)
						system.yield(2500)
						entities.request_control(a1, function()
						entities.delete(a1)
					end)
				end)
				
				ui.add_click_option("在他面前放沙发", spoof_option, function()
					local target = online.get_selected_player()
					local selectedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
					local forwardOffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(selectedPlayer, 0, 4, 0)
					local pheading = ENTITY.GET_ENTITY_HEADING(selectedPlayer)
					local hash = -406716247
					local a1 = OBJECT.CREATE_OBJECT(hash, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, false, false)
						ENTITY.SET_ENTITY_HEADING(a1, pheading)
					local b1 = OBJECT.CREATE_OBJECT(hash, forwardOffset.x, forwardOffset.y, forwardOffset.z, true, false, false)
						ENTITY.SET_ENTITY_HEADING(b1, pheading)
						system.yield(2500)
						entities.request_control(a1, function()
						entities.delete(a1)
					end)
						entities.request_control(b1, function()
						entities.delete(b1)
					end)
					system.yield(2500)
				end)
				
				ui.add_separator("破坏选项", spoof_option)
				
				ui.add_click_option("空袭玩家", spoof_option, function()
					local target = online.get_selected_player()
					local selectedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
					local playerPed = PLAYER.PLAYER_PED_ID()
					local coords = ENTITY.GET_ENTITY_COORDS(selectedPlayer, 1)
					local airStrike = MISC.GET_HASH_KEY("WEAPON_AIRSTRIKE_ROCKET")
						WEAPON.REQUEST_WEAPON_ASSET(airStrike, 31, false)
						MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(coords.x, coords.y, coords.z + 20, coords.x, coords.y, coords.z, 250, 1, airStrike, playerPed, 1, 0, -1.0)
				end)
				
				ui.add_click_option("删除所有炸药", spoof_option, function()
					local target = online.get_selected_player()
					local selectedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
						WEAPON.REMOVE_WEAPON_FROM_PED(selectedPlayer, -1312131151) -- RPG
						WEAPON.REMOVE_WEAPON_FROM_PED(selectedPlayer, 1672152130) -- HOMING LAUNCHER
						WEAPON.REMOVE_WEAPON_FROM_PED(selectedPlayer, -1568386805) -- GRENADE LAUNCHER
						WEAPON.REMOVE_WEAPON_FROM_PED(selectedPlayer, 125959754) -- COMPACT GRENADE LAUNCHER
						WEAPON.REMOVE_WEAPON_FROM_PED(selectedPlayer, -1813897027) -- GRENADE
						WEAPON.REMOVE_WEAPON_FROM_PED(selectedPlayer, 741814745) -- STICKY BOMB
						WEAPON.REMOVE_WEAPON_FROM_PED(selectedPlayer, -1420407917) -- PROXIMITY MINE
						WEAPON.REMOVE_WEAPON_FROM_PED(selectedPlayer, -1169823560) -- PIPEBOMB
				end)
				
				ui.add_click_option("原子能枪", spoof_option, function()
					local target = online.get_selected_player()
					local selectedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
					local pos = ENTITY.GET_ENTITY_COORDS(selectedPlayer, 1)
					local hash = utils.joaat("weapon_raypistol")
						MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z, pos.x , pos.y, pos.z-2, 200, 0, hash, 0, true, false, 2500.0)
				end)
				
				ui.add_click_option("生成手榴弹", spoof_option, function()
					local target = online.get_selected_player()
					local selectedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
					local playerPed = PLAYER.PLAYER_PED_ID()
					local pos = ENTITY.GET_ENTITY_COORDS(selectedPlayer, 1)
						MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1.4, pos.x, pos.y, pos.z + 1.3, 100, 1, -1813897027, playerPed, 1, 0, -1.0)
				end)
				
				ui.add_click_option("生成黏弹", spoof_option, function()
					local target = online.get_selected_player()
					local selectedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
					local playerPed = PLAYER.PLAYER_PED_ID()
					local pos = ENTITY.GET_ENTITY_COORDS(selectedPlayer, 1)
						MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1 , pos.x, pos.y, pos.z + 1.1, 10, 1, 741814745, playerPed, 1, 0, -1.0)
				end)


	LZ_player = ui.add_submenu("套笼子")
		ui.add_sub_option("套笼子", main_sub, LZ_player)

			ui.add_separator("实体模型", LZ_player)
					ui.add_click_option("普通笼子", LZ_player, function()
						local target = online.get_selected_player()
						local selectedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
						local playerPed = PLAYER.PLAYER_PED_ID()
						local pos = ENTITY.GET_ENTITY_COORDS(selectedPlayer, 1)
						local objHash = utils.joaat("prop_gold_cont_01")
							TASK.CLEAR_PED_TASKS_IMMEDIATELY(selectedPlayer)
						local obj = OBJECT.CREATE_OBJECT(objHash, pos.x, pos.y, pos.z - 1.0, true, false, false)
							ENTITY.FREEZE_ENTITY_POSITION(obj, true)
					end)
					ui.add_click_option("高笼子", LZ_player, function()
						local target = online.get_selected_player()
						local selectedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
						local playerPed = PLAYER.PLAYER_PED_ID()
						local pos = ENTITY.GET_ENTITY_COORDS(selectedPlayer, 1)
						local objHash = utils.joaat("prop_rub_cage01a")
							TASK.CLEAR_PED_TASKS_IMMEDIATELY(selectedPlayer)
						local obj1 = OBJECT.CREATE_OBJECT(objHash, pos.x, pos.y, pos.z - 1.0, true, false, false)
						local obj2 = OBJECT.CREATE_OBJECT(objHash, pos.x, pos.y, pos.z + 1.2, true, false, false)
							ENTITY.SET_ENTITY_ROTATION(obj2, -180.0, ENTITY.GET_ENTITY_ROTATION(obj2, 0).y, 90.0, 1, true)
							ENTITY.FREEZE_ENTITY_POSITION(obj1, true)
							ENTITY.FREEZE_ENTITY_POSITION(obj2, true)
					end)
					ui.add_click_option("赛车笼子", LZ_player, function()
						local target = online.get_selected_player()
						local selectedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
						local playerPed = PLAYER.PLAYER_PED_ID()
						local pos = ENTITY.GET_ENTITY_COORDS(selectedPlayer, 1)
						local objHash = utils.joaat("stt_prop_stunt_tube_s")
						local obj = OBJECT.CREATE_OBJECT(objHash, pos.x, pos.y, pos.z - 1.0, true, false, false)
						local rot = ENTITY.GET_ENTITY_ROTATION(obj, 0)
							ENTITY.SET_ENTITY_ROTATION(obj, rot.x, 90.0, rot.z, 1, true)
							ENTITY.FREEZE_ENTITY_POSITION(obj, true)
					end)



					

while true do
	for pid = 0, 32 do
		player_exists(pid)
	end
	system.yield(0)
end