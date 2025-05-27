
---API

function notify(text)
	system.notify("Remtool.lua", text, 30, 222, 255, 255)
	system.log("Remtool.lua", text)
end
function player_exists(pid)
	return NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid)
end
notify("Rem菜单工具BY:雷姆")
--
local main_sub = ui.add_main_submenu("RemMenu")

OLtool = ui.add_submenu("Rem")

ui.add_sub_option("Tool", main_sub, OLtool)

ui.add_separator("Player spoof", OLtool)


ui.add_click_option("发送所有玩家海滩", OLtool, function()
	for pids = 0, 31 do
		if pids ~= PLAYER.GET_PLAYER_INDEX() then
			online.send_script_event(pids, 1214823473, 1, 0, 0, 4,0, PLAYER.GET_PLAYER_INDEX(), pids)
		end
	end
end)
ui.add_click_option("发送所有玩家岛屿", OLtool, function()
	for pids = 0, 31 do
		if pids ~= PLAYER.GET_PLAYER_INDEX() then
			online.send_script_event(pids, 1214823473, 1, 0, 0, 1, 1,PLAYER.GET_PLAYER_INDEX(), pids)
		end
	end
end)

ui.add_separator("Cayo Heist", OLtool)

ui.add_click_option("佩里科岛全员85分红", OLtool, function()
	globals.set_int(1973321 + 823 + 56, 85)
	globals.set_int(1973321 + 823 + 56+1, 85)
	globals.set_int(1973321 + 823 + 56+2, 85)
	globals.set_int(1973321 + 823 + 56+3, 85)
end)

ui.add_click_option("佩里科岛全员100分红", OLtool, function()
	globals.set_int(1973321 + 823 + 56, 100)
	globals.set_int(1973321 + 823 + 56+1, 100)
	globals.set_int(1973321 + 823 + 56+2, 100)
	globals.set_int(1973321 + 823 + 56+3, 100)
end)
ui.add_click_option("快速完成佩里科岛", OLtool, function()
		if globals.is_script_active("fm_mission_controller_2020") then
			globals.set_local("fm_mission_controller_2020", 38397, 51338752) ---BY:来源2t任务脚本
			globals.set_local("fm_mission_controller_2020", 39772, 50) 
			;
		end
	end
)

ui.add_separator("Casino Heist", OLtool)

ui.add_click_option("赌场全员85分红", OLtool, function()
	globals.set_int(1966534 + 1497 + 736 + 92, 85)
	globals.set_int(1966534 + 1497 + 736 + 92+1, 85)
	globals.set_int(1966534 + 1497 + 736 + 92+2, 85)
	globals.set_int(1966534 + 1497 + 736 + 92+3, 85)
end)
ui.add_click_option("赌场全员100分红", OLtool, function()
	globals.set_int(1966534 + 1497 + 736 + 92, 100)
	globals.set_int(1966534 + 1497 + 736 + 92+1, 100)
	globals.set_int(1966534 + 1497 + 736 + 92+2, 100)
	globals.set_int(1966534 + 1497 + 736 + 92+3, 100)  ----- Aure
end)

ui.add_click_option("快速完成名钻赌场", OLtool, function()
notify("只支持气势汹汹")
		if globals.is_script_active("fm_mission_controller") then
			globals.set_local("fm_mission_controller", 22365, 10000000)
			globals.set_local("fm_mission_controller", 19679, 12)
			globals.set_local("fm_mission_controller", 28299, 99999)
			globals.set_local("fm_mission_controller", 31623, 99999)			---BY:来源2t任务脚本
			;
		end
	end
)

local main_sub = ui.add_player_submenu("Rem Tool")

ui.add_click_option("发送到玩家海滩", main_sub, function()
	online.send_script_event(online.get_selected_player(), 1214823473, 1, 0, 0, 4,0,online.get_selected_player())
end)

ui.add_click_option("发送到玩家岛屿", main_sub, function()
	online.send_script_event(online.get_selected_player(), 1214823473, 1, 0, 0, 1,1,online.get_selected_player())
end)




while true do
	for pid = 0, 32 do
		player_exists(pid)
	end
	system.yield(0)
end