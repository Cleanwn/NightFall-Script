--- Additions Menu | Version: sr2
--- Author: 不世出の天才
--- Credits to: OxiGen, Anry, Raymond and pnn for helping.


function log(text)
	system.log("Additions Menu.lua", tostring(text))
end

function notify(text)
    local str_text = tostring(text)
    system.notify("Additions Menu CV", str_text, 0, 255, 0, 255)
    system.log("Additions Menu CV", str_text)
end

function player_exists(pid)
    return NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 1
end

function ui.add_submenu_to(str_name, int_subID)
    local sub = ui.add_submenu(str_name)
    ui.add_sub_option(str_name, int_subID, sub)
    return sub
end

--███████╗████████╗ █████╗ ██████╗ ████████╗
--██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝
--███████╗   ██║   ███████║██████╔╝   ██║   
--╚════██║   ██║   ██╔══██║██╔══██╗   ██║   
--███████║   ██║   ██║  ██║██║  ██║   ██║   
--╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   
                                          
notify("Additions CV Menu 成功加载！\n当前版本：V2.02")
notify("作者：不世出の天才\n翻译：MG\n部分功能协助：OxiGen")
notify("鸣谢：\n不世出の天才\nMG\nOxiGen")
notify("AdditinonsCNMenu版本唯一指定QQ群：\n568418736\n如果你是从其他群获得该脚本，那么转发的人Si妈了")
notify("免费脚本\n付费购买恭喜被骗")
system.log("INIT", "Additions Menu 成功加载！翻译者：MG\n唯一指定Q群：568418736\n唯一指定Q群：568418736\n唯一指定Q群：568418736\n唯一指定Q群：568418736\n唯一指定Q群：568418736\n唯一指定Q群：568418736   ")
system.log("INIT", " 如果你是从其他群获得该脚本，那么转发的人Si妈了\n唯一指定Q群：568418736\n唯一指定Q群：568418736\n唯一指定Q群：568418736\n唯一指定Q群：568418736\n唯一指定Q群：568418736\n唯一指定Q群：568418736 ")








--██╗      ██████╗  ██████╗ █████╗ ██╗          ██████╗ ██████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
--██║     ██╔═══██╗██╔════╝██╔══██╗██║         ██╔═══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
--██║     ██║   ██║██║     ███████║██║         ██║   ██║██████╔╝   ██║   ██║██║   ██║██╔██╗ ██║███████╗
--██║     ██║   ██║██║     ██╔══██║██║         ██║   ██║██╔═══╝    ██║   ██║██║   ██║██║╚██╗██║╚════██║
--███████╗╚██████╔╝╚██████╗██║  ██║███████╗    ╚██████╔╝██║        ██║   ██║╚██████╔╝██║ ╚████║███████║
--╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝     ╚═════╝ ╚═╝        ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
-- (They are after interactions with player)
                                                                                                     
main_sub = ui.add_main_submenu("Additions CV Menu")

selftools_sub = ui.add_submenu("自我选项")

sessiontools_sub = ui.add_submenu("战局选项")

protectiontools_sub = ui.add_submenu("保护选项")

selfvehtools_sub = ui.add_submenu("载具选项")

recoverytools_sub = ui.add_submenu("恢复选项")

worldtools_sub = ui.add_submenu("世界选项")

misctools_sub = ui.add_submenu("其他选项")


--██████╗ ██╗      █████╗ ██╗   ██╗███████╗██████╗      ██████╗ ██████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
--██╔══██╗██║     ██╔══██╗╚██╗ ██╔╝██╔════╝██╔══██╗    ██╔═══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
--██████╔╝██║     ███████║ ╚████╔╝ █████╗  ██████╔╝    ██║   ██║██████╔╝   ██║   ██║██║   ██║██╔██╗ ██║███████╗
--██╔═══╝ ██║     ██╔══██║  ╚██╔╝  ██╔══╝  ██╔══██╗    ██║   ██║██╔═══╝    ██║   ██║██║   ██║██║╚██╗██║╚════██║
--██║     ███████╗██║  ██║   ██║   ███████╗██║  ██║    ╚██████╔╝██║        ██║   ██║╚██████╔╝██║ ╚████║███████║
--╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝     ╚═════╝ ╚═╝        ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝

mainplayertools_sub = ui.add_player_submenu("Addition Menu玩家选项")

ply_helpful = ui.add_submenu_to("友好选项", mainplayertools_sub)

ply_remote = ui.add_submenu_to("远程选项", mainplayertools_sub)

ply_CEO = ui.add_submenu_to("CEO选项", mainplayertools_sub)

ply_mod = ui.add_submenu_to("恶搞选项", mainplayertools_sub)

ply_trolling = ui.add_submenu_to("实体恶搞选项", mainplayertools_sub)

ply_vehtools = ui.add_submenu_to("载具选项", mainplayertools_sub)

ply_notifytools = ui.add_submenu_to("虚假通知选项", mainplayertools_sub)


--██╗  ██╗███████╗██╗     ██████╗ ███████╗██╗   ██╗██╗          ██████╗ ██████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
--██║  ██║██╔════╝██║     ██╔══██╗██╔════╝██║   ██║██║         ██╔═══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
--███████║█████╗  ██║     ██████╔╝█████╗  ██║   ██║██║         ██║   ██║██████╔╝   ██║   ██║██║   ██║██╔██╗ ██║███████╗
--██╔══██║██╔══╝  ██║     ██╔═══╝ ██╔══╝  ██║   ██║██║         ██║   ██║██╔═══╝    ██║   ██║██║   ██║██║╚██╗██║╚════██║
--██║  ██║███████╗███████╗██║     ██║     ╚██████╔╝███████╗    ╚██████╔╝██║        ██║   ██║╚██████╔╝██║ ╚████║███████║
--╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     ╚═╝      ╚═════╝ ╚══════╝     ╚═════╝ ╚═╝        ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝

ui.add_separator("解锁选项", ply_helpful)

ui.add_click_option("电影道具", ply_helpful, function()
	local ind = PLAYER.GET_PLAYER_INDEX()
	local target = online.get_selected_player()
	for i = 0, 9 do
		online.send_script_event(target, 995853474, ind, 0, i, 1, 1, 1)
	system.yield(5000)
	end
end)

ui.add_click_option("隐藏包裹", ply_helpful, function()
	local ind = PLAYER.GET_PLAYER_INDEX()
	local target = online.get_selected_player()
	for i = 0, 9 do
		online.send_script_event(target, 995853474, ind, 1, i, 1, 1, 1)
	system.yield(5000)
	end
end)

ui.add_click_option("宝箱", ply_helpful, function()
	local ind = PLAYER.GET_PLAYER_INDEX()
	local target = online.get_selected_player()
	for i = 0, 1 do
		online.send_script_event(target, 995853474, ind, 2, i, 1, 1, 1)
	system.yield(5000)
	end
end)

ui.add_click_option("为他完成修复天线/放松依旧洛圣都", ply_helpful, function()
	local ind = PLAYER.GET_PLAYER_INDEX()
	local target = online.get_selected_player()
	for i = 0, 9 do
		online.send_script_event(target, 995853474, ind, 3, i, 1, 1, 1)
	system.yield(5000)
	end
end)

ui.add_click_option("解锁媒体记忆棒/迷你专辑", ply_helpful, function()
	local ind = PLAYER.GET_PLAYER_INDEX()
	local target = online.get_selected_player()
	for i = 0, 19 do
		online.send_script_event(target, 995853474, ind, 4, i, 1, 1, 1)
	system.yield(5000)
	end
end)

ui.add_click_option("沉船宝箱", ply_helpful, function()
	local ind = PLAYER.GET_PLAYER_INDEX()
	local target = online.get_selected_player()
		online.send_script_event(target, 995853474, ind, 5, 0, 1, 1, 1)
	system.yield(5000)
end)

ui.add_click_option("藏匿物品", ply_helpful, function()
	local ind = PLAYER.GET_PLAYER_INDEX()
	local target = online.get_selected_player()
	for i = 0, 9 do
		online.send_script_event(target, 995853474, ind, 6, i, 1, 1, 1)
	system.yield(5000)
	end
end)


--██████╗ ███████╗███╗   ███╗ ██████╗ ████████╗███████╗     ██████╗ ██████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
--██╔══██╗██╔════╝████╗ ████║██╔═══██╗╚══██╔══╝██╔════╝    ██╔═══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
--██████╔╝█████╗  ██╔████╔██║██║   ██║   ██║   █████╗      ██║   ██║██████╔╝   ██║   ██║██║   ██║██╔██╗ ██║███████╗
--██╔══██╗██╔══╝  ██║╚██╔╝██║██║   ██║   ██║   ██╔══╝      ██║   ██║██╔═══╝    ██║   ██║██║   ██║██║╚██╗██║╚════██║
--██║  ██║███████╗██║ ╚═╝ ██║╚██████╔╝   ██║   ███████╗    ╚██████╔╝██║        ██║   ██║╚██████╔╝██║ ╚████║███████║
--╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝ ╚═════╝    ╚═╝   ╚══════╝     ╚═════╝ ╚═╝        ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝

ui.add_separator("远程选项", ply_remote)

ui.add_click_option("不封锁被动", ply_remote, function()
	local ind = PLAYER.GET_PLAYER_INDEX()
	local target = online.get_selected_player()
		online.send_script_event(target, 1114091621, ind, ind, 0)
		online.send_script_event(target, 2033772643, ind, ind, 0)
end)

ui.add_choose("上岛", ply_remote, false, {"有动画", "W无动画"}, function (select)
	local target = online.get_selected_player()
	local name = online.get_name(target)

	if select == 0 then 
	notify("Teleporting " .. name .. " to Cayo Perico")
		online.send_script_event(target, -621279188, 0)
	end

	if select == 1 then
	notify("Teleporting " .. name .. " to Cayo Perico (N/C)")
		online.send_script_event(target, 1463943751, 1, 0, 0, 4, 1)
	end

end)

ui.add_click_option("送到海滩", ply_remote, function()
	local target = online.get_selected_player()
	local name = online.get_name(target)
	notify("Teleporting " .. name .. " to beach")
		online.send_script_event(target, 1463943751, 1, 0, 0, 4, 0)
end)

ui.add_click_option("让他看赌场动画(可能自崩)", ply_remote, function()
	local target = online.get_selected_player()
	local ind = PLAYER.GET_PLAYER_INDEX()
	local name = online.get_name(target)
	notify("Sending " .. name .. " to casino cutscene...\nPlease wait!")
	local selfped = PLAYER.PLAYER_PED_ID()
	local selfcoords = get_local_coords(selfped)
	local selectedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
	local coords = get_entity_coords(selectedPlayer)
	local last_vehicle = PED.GET_VEHICLE_PED_IS_IN(selfped, true)
		ENTITY.SET_ENTITY_VISIBLE(selfped, false, false)
    	ENTITY.SET_ENTITY_COORDS(selfped, coords.x + 15, coords.y + 15, coords.z, 0, 0, 0, 0)
			online.send_script_event(target, 1068259786, ind, 0)
			online.send_script_event(target, 1068259786)
				system.yield(3500)
			online.send_script_event(target, 1068259786)
			online.send_script_event(target, 1068259786, ind, 0)
		ENTITY.SET_ENTITY_VISIBLE(selfped, true, false)
		ENTITY.SET_ENTITY_COORDS(selfped, selfcoords.x, selfcoords.y, selfcoords.z, 0, 0, 0, 0)
		PED.SET_PED_INTO_VEHICLE(selfped, last_vehicle, -1)
	notify("Enjoy!\n" .. name .. " now probably watching casino cutscene!")
end)

function get_entity_coords(entity)
	local entity_pos = ENTITY.GET_ENTITY_COORDS(entity, true)
	return entity_pos
end

function get_local_coords(entity)
	local local_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
	return local_pos
end

ui.add_click_option("让他看佩里科岛动画", ply_remote, function()
	local name = online.get_name(online.get_selected_player())
	local target = online.get_selected_player()
	notify("Sending " .. name .. " to Cayo Perico cutscene")
		online.send_script_event(target, 1463943751, PLAYER.GET_PLAYER_INDEX(), 0, 0, 5, 1)
end)

ui.add_click_option("发送公寓邀请", ply_remote, function()
	local target = online.get_selected_player()
	local name = online.get_name(target)
	local ind = PLAYER.GET_PLAYER_INDEX()
	notify("Sending Endless Apartment Invite to " .. name .. "")
		online.send_script_event(target, 603406648, ind, 1, -1, 1, 115, 0, 0, 0)
end)

ui.add_choose("送他去仓库", ply_remote, false, {"Teleport To Elysian Island Nort", "Teleport To La Puerta North", "Teleport To La Mesa Mid", "Teleport To Rancho West", "Teleport To West Vinewood", "Teleport To LSIA North", "Teleport To Del Perro", "Teleport To LSIA South", "Teleport To Elysian Island South", "Teleport To El Burro Heights", "Teleport To Elysian Island West", "Teleport To Textile City", "Teleport To La Puerta South", "Teleport To Strawberry", "Teleport To Downtown Vinewood North", "Teleport To La Mesa South", "Teleport To La Mesa North", "Teleport To Cypress Flats North", "Teleport To Cypress Flats South", "Teleport To West Vinewood", "Teleport To Rancho East", "Teleport To Banning"}, function (select)
	local target = online.get_selected_player()
	local name = online.get_name(target)

	if select == 0 then 
		online.send_script_event(target, -446275082, 1, 0, 1, 1)
	end

	if select == 1 then
		online.send_script_event(target, -446275082, 1, 0, 1, 2)
	end

	if select == 2 then
		online.send_script_event(target, -446275082, 1, 0, 1, 2)
	end

	if select == 3 then
		online.send_script_event(target, -446275082, 1, 0, 1, 3)
	end

	if select == 4 then
		online.send_script_event(target, -446275082, 1, 0, 1, 4)
	end

	if select == 5 then
		online.send_script_event(target, -446275082, 1, 0, 1, 5)
	end

	if select == 6 then
		online.send_script_event(target, -446275082, 1, 0, 1, 6)
	end

	if select == 7 then
		online.send_script_event(target, -446275082, 1, 0, 1, 7)
	end
	
	if select == 8 then
		online.send_script_event(target, -446275082, 1, 0, 1, 8)
	end

	if select == 9 then
		online.send_script_event(target, -446275082, 1, 0, 1, 9)
	end

	if select == 10 then
		online.send_script_event(target, -446275082, 1, 0, 1, 10)
	end

	if select == 11 then
		online.send_script_event(target, -446275082, 1, 0, 1, 11)
	end
	
	if select == 12 then
		online.send_script_event(target, -446275082, 1, 0, 1, 12)
	end
	
	if select == 13 then
		online.send_script_event(target, -446275082, 1, 0, 1, 13)
	end

	if select == 14 then
		online.send_script_event(target, -446275082, 1, 0, 1, 14)
	end

	if select == 15 then
		online.send_script_event(target, -446275082, 1, 0, 1, 15)
	end

	if select == 16 then
		online.send_script_event(target, -446275082, 1, 0, 1, 16)
	end

	if select == 17 then
		online.send_script_event(target, -446275082, 1, 0, 1, 17)
	end

	if select == 18 then
		online.send_script_event(target, -446275082, 1, 0, 1, 18)
	end

	if select == 19 then
		online.send_script_event(target, -446275082, 1, 0, 1, 19)
	end

	if select == 20 then
		online.send_script_event(target, -446275082, 1, 0, 1, 20)
	end

	if select == 21 then
		online.send_script_event(target, -446275082, 1, 0, 1, 21)
	end

	if select == 22 then
		online.send_script_event(target, -446275082, 1, 0, 1, 22)
	end

end)

ui.add_click_option("强制执行仓库任务", ply_remote, function()
	online.send_script_event(online.get_selected_player(), -943413695, 1, online.get_selected_player())
end)

ui.add_choose("让他去做任务", ply_remote, false, {"Send To Severe Weather Patterns Job", "Send To Half Track Bully Job", "Send To Exit Strategy Job", "Send To Offshore Assets Job", "Send To Cover Blown Job", "Send To Mole Hunt Job", "Send To Data Breach Job", "Send To Work Dispute Job"}, function (select)
	local target = online.get_selected_player()
	local name = online.get_name(target)

	if select == 0 then 
		online.send_script_event(target, 2020588206, 0, 0)
	end

	if select == 1 then
		online.send_script_event(target, 2020588206, 0, 1)
	end

	if select == 2 then
		online.send_script_event(target, 2020588206, 0, 2)
	end

	if select == 3 then
		online.send_script_event(target, 2020588206, 0, 3)
	end

	if select == 4 then
		online.send_script_event(target, 2020588206, 0, 4)
	end

	if select == 5 then
		online.send_script_event(target, 2020588206, 0, 5)
	end

	if select == 6 then
		online.send_script_event(target, 2020588206, 0, 6)
	end

	if select == 7 then
		online.send_script_event(target, 2020588206, 0, 7)
	end

end)

ui.add_click_option("开始自由模式任务", ply_remote, function()
	local target = online.get_selected_player()
	local ind = PLAYER.GET_PLAYER_INDEX()
	online.send_script_event(target, 522189882, ind, 263, -1)
end)


-- ██████╗███████╗ ██████╗      ██████╗ ██████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
--██╔════╝██╔════╝██╔═══██╗    ██╔═══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
--██║     █████╗  ██║   ██║    ██║   ██║██████╔╝   ██║   ██║██║   ██║██╔██╗ ██║███████╗
--██║     ██╔══╝  ██║   ██║    ██║   ██║██╔═══╝    ██║   ██║██║   ██║██║╚██╗██║╚════██║
--╚██████╗███████╗╚██████╔╝    ╚██████╔╝██║        ██║   ██║╚██████╔╝██║ ╚████║███████║
-- ╚═════╝╚══════╝ ╚═════╝      ╚═════╝ ╚═╝        ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝

ui.add_separator("CEO选项", ply_CEO)

ui.add_click_option("踢出CEO", ply_CEO, function()
	local name = online.get_name(online.get_selected_player())
	local target = online.get_selected_player()
	local ind = PLAYER.GET_PLAYER_INDEX()
	notify("Successfully kicked " .. name .. " from CEO")
		online.send_script_event(target, 248967238, ind, 0, 5)
end)

ui.add_click_option("打断CEO任务", ply_CEO, function()
	local ind = PLAYER.GET_PLAYER_INDEX()
	local target = online.get_selected_player()
		online.send_script_event(target, 522189882, ind, 0, 1)
end)


--███╗   ███╗ ██████╗ ██████╗ ███████╗██████╗  █████╗ ████████╗██╗ ██████╗ ███╗   ██╗     ██████╗ ██████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
--████╗ ████║██╔═══██╗██╔══██╗██╔════╝██╔══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║    ██╔═══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
--██╔████╔██║██║   ██║██║  ██║█████╗  ██████╔╝███████║   ██║   ██║██║   ██║██╔██╗ ██║    ██║   ██║██████╔╝   ██║   ██║██║   ██║██╔██╗ ██║███████╗
--██║╚██╔╝██║██║   ██║██║  ██║██╔══╝  ██╔══██╗██╔══██║   ██║   ██║██║   ██║██║╚██╗██║    ██║   ██║██╔═══╝    ██║   ██║██║   ██║██║╚██╗██║╚════██║
--██║ ╚═╝ ██║╚██████╔╝██████╔╝███████╗██║  ██║██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║    ╚██████╔╝██║        ██║   ██║╚██████╔╝██║ ╚████║███████║
--╚═╝     ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝ ╚═╝        ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝

ui.add_separator("冻结选项", ply_mod)

ui.add_click_option("脚本冻结玩家", ply_mod, function()
	local target = online.get_selected_player()
	local ind = PLAYER.GET_PLAYER_INDEX()
	local name = online.get_name(target)
	notify("可能失效了\n但还是继续发送冻结给：" .. name .. "")
		online.send_script_event(target, 603406648, ind, 15, -1, 0, 115, -1, -1, 1)
end)

ui.add_click_option("脚本冻结玩家5秒左右", ply_mod, function()
	local target = online.get_selected_player()
	local pid = PLAYER.GET_PLAYER_INDEX()
	local name = online.get_name(target)
	notify("5秒冻结玩家：" .. name .. "")
		online.send_script_event(target, 1214823473, pid, 0, 0, 0, 0, 0)
end)

ui.add_click_option("冻结玩家载具", ply_mod, function()
	local target = online.get_selected_player()
	local ind = PLAYER.GET_PLAYER_INDEX()
	local name = online.get_name(target)
	local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
	notify("冻结该玩家载具：" .. name .. "")
	ENTITY.FREEZE_ENTITY_POSITION(vehicle, true)	
end)

ui.add_click_option("取消冻结玩家载具", ply_mod, function()
	local target = online.get_selected_player()
	local ind = PLAYER.GET_PLAYER_INDEX()
	local name = online.get_name(target)
	local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
	notify("取消冻结该玩家载具：" .. name .. "")
	ENTITY.FREEZE_ENTITY_POSITION(vehicle, false)	
end)




ui.add_separator("崩溃选项", ply_mod)

ui.add_click_option("Next-Gen崩溃", ply_mod, function()
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

ui.add_click_option("送崩溃给踢出的玩家", ply_mod, function()
	local target = online.get_selected_player()
	local name = online.get_name(target)
	notify("Sending Crash Player Modder Kick to " .. name .. "")
		online.send_script_event(target, 962740265, 23135423, 3, 827870001, 2022580431, -918761645, 1754244778, 827870001, 1754244778, 23135423, 827870001, 23135423)
		online.send_script_event(target, -1386010354, 23135423, 3, 827870001, 2022580431, -918761645, 1754244778, 827870001, 1754244778, 23135423, 827870001, 23135423)
		online.send_script_event(target, 2112408256, 23135423, 3, 827870001, 2022580431, -918761645, 1754244778, 827870001, 1754244778, 23135423, 827870001, 23135423)
		online.send_script_event(target, 677240627, 23135423, 3, 827870001, 2022580431, -918761645, 1754244778, 827870001, 1754244778, 23135423, 827870001, 23135423)
		online.send_script_event(target, 962740265, 1, 0, 30583, 0, 0, 0, -328966, 1132039228, 0)
		online.send_script_event(target, -1386010354, 1, 0, 30583, 0, 0, 0, -328966, 1132039228, 0)
		online.send_script_event(target, 2112408256, 1, 0, 30583, 0, 0, 0, -328966, 1132039228, 0)
		online.send_script_event(target, 677240627, 1, 0, 30583, 0, 0, 0, -328966, 1132039228, 0)
end)

ui.add_click_option("脚本崩溃v1", ply_mod, function()
	local target = online.get_selected_player()
	local name = online.get_name(target)
	notify("Sending Script Event Crash v1 to " .. name .. "")
		online.send_script_event(target, 962740265, 2000000, 2000000, 2000000, 2000000)
end)

ui.add_click_option("脚本崩溃v2", ply_mod, function()
	local target = online.get_selected_player()
	local name = online.get_name(target)
	notify("Sending Script Event Crash v2 to " .. name .. "")
		online.send_script_event(target, 1228916411, 1, 1245317585)
		online.send_script_event(target, 962740265, 1, 0, 144997919, -1907798317, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1)
		online.send_script_event(target, -1386010354, 1, 0, 92623021, -1907798317, 0, 0, 0, 0, 1)
end)

ui.add_click_option("脚本崩溃v3", ply_mod, function()
	local target = online.get_selected_player()
	local name = online.get_name(target)
	local ind = PLAYER.GET_PLAYER_INDEX()
	notify("Sending Script Event Crash v3 to " .. name .. "")
		for i = 1, 15 do
			online.send_script_event(target, -393294520, 2147483647, 2147483647, 2147483647, 1, i, ind)
		system.yield(10)
	end
end)




ui.add_separator("踢出选项", ply_mod)

ui.add_click_option("房主踢", ply_mod, function()
	local target = online.get_selected_player()
	local name = online.get_name(target)
	notify("Successfully Host Kicked " .. name .. "")
	NETWORK.NETWORK_SESSION_KICK_PLAYER(target)
end)

ui.add_click_option("发送非房主踢v1", ply_mod, function()
	local target = online.get_selected_player()
	local name = online.get_name(target)
	notify("Sending Non-Host Kick v1 to " .. name .. "")
		online.send_script_event(target, 603406648, 0, 380565701, -1443464333, 1, 115, 954851592, -768074745, 1278027916)
end)

ui.add_click_option("发送非房主踢vv2", ply_mod, function()
	local target = online.get_selected_player()
	local name = online.get_name(target)
	notify("Sending Non-Host Kick v2 to " .. name .. "")
		online.send_script_event(target, 603406648, 0, 1279476345, 655005918, 1, 115, 1997628673, 6299376, -302416007)
end)

ui.add_click_option("发送非房主踢v3", ply_mod, function()
	local target = online.get_selected_player()
	local name = online.get_name(target)
	notify("Sending Non-Host Kick v3 to " .. name .. "")
		online.send_script_event(target, 1445703181, 1, 1, 1841685865, 136236, 27769, -1450989833, -2082595, 1587193, -6701543, 147649, 651264, -2507024, 11951923, -833146974, -1799182, 2359273, 4959292, 1)
end)

ui.add_click_option("脚本踢出v1", ply_mod, function()
	local target = online.get_selected_player()
	local name = online.get_name(target)
	local pid = PLAYER.GET_PLAYER_INDEX()
	notify("发送脚本踢出v1给" .. name .. "")
	    online.send_script_event(target, 111242367, pid, -210634234)
end)

ui.add_click_option("脚本踢出v2", ply_mod, function()
	local target = online.get_selected_player()
	local name = online.get_name(target)
	local pid = PLAYER.GET_PLAYER_INDEX()
	notify("发送脚本踢出v2给" .. name .. "")
	    online.send_script_event(target, 421832664, pid, 0, 1951261, 829)
end)




ui.add_separator("正义选项", ply_mod)

ui.add_click_option("移除玩家无敌", ply_mod, function()
	local target = online.get_selected_player()
	local name = online.get_name(target)
	local pid = PLAYER.GET_PLAYER_INDEX()
	notify("这个功能会被大多数菜单拦截\n 发送给" .. name .. "")
	    online.send_script_event(target, -1388926377, pid, -1762807505, math.random(0, 9999))
end)

ui.add_click_option("移除玩家载具无敌", ply_mod, function()
	local target = online.get_selected_player()
	local name = online.get_name(target)
	local pid = PLAYER.GET_PLAYER_INDEX()
	notify("这个功能不成熟、不稳定\n 发送移除无敌给" .. name .. "")
    local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
	local veh = PED.GET_VEHICLE_PED_IS_IN(player, false)
    ENTITY.SET_ENTITY_CAN_BE_DAMAGED(veh, true)
    ENTITY.SET_ENTITY_INVINCIBLE(veh, false)
    ENTITY.SET_ENTITY_PROOFS(veh, false, false, false, false, false, 0, 0, false)
end)


--████████╗██████╗  ██████╗ ██╗     ██╗     ██╗███╗   ██╗ ██████╗      ██████╗ ██████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
--╚══██╔══╝██╔══██╗██╔═══██╗██║     ██║     ██║████╗  ██║██╔════╝     ██╔═══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
--   ██║   ██████╔╝██║   ██║██║     ██║     ██║██╔██╗ ██║██║  ███╗    ██║   ██║██████╔╝   ██║   ██║██║   ██║██╔██╗ ██║███████╗
--   ██║   ██╔══██╗██║   ██║██║     ██║     ██║██║╚██╗██║██║   ██║    ██║   ██║██╔═══╝    ██║   ██║██║   ██║██║╚██╗██║╚════██║
--   ██║   ██║  ██║╚██████╔╝███████╗███████╗██║██║ ╚████║╚██████╔╝    ╚██████╔╝██║        ██║   ██║╚██████╔╝██║ ╚████║███████║
--   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝╚═╝╚═╝  ╚═══╝ ╚═════╝      ╚═════╝ ╚═╝        ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝                                                                                                                         

ui.add_separator("实体恶搞", ply_trolling)

ui.add_click_option("在他面前放一堵墙bengkui", ply_trolling, function()
	local target = online.get_selected_player()
	local selfped = PLAYER.PLAYER_PED_ID()
	local selectedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
	local forwardOffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(selectedPlayer, 0, 4, 0)
	local coords = ENTITY.GET_ENTITY_COORDS(selectedPlayer, 1)
	local pheading = ENTITY.GET_ENTITY_HEADING(selectedPlayer)
	local wall = utils.joaat("prop_bush_lrg_02b")
	local a1 = OBJECT.CREATE_OBJECT(wall, forwardOffset.x, forwardOffset.y, forwardOffset.z + 3, true, false, false)
		ENTITY.SET_ENTITY_HEADING(a1, pheading + 90)
		ENTITY.SET_ENTITY_HEADING(a1, pheading - 90)
		ENTITY.SET_ENTITY_HEADING(a1, pheading + 80)
		ENTITY.SET_ENTITY_HEADING(a1, pheading - 80)
		ENTITY.SET_ENTITY_HEADING(a1, pheading + 50)
		ENTITY.SET_ENTITY_HEADING(a1, pheading - 50)
		ENTITY.SET_ENTITY_HEADING(a1, pheading + 30)
		ENTITY.SET_ENTITY_HEADING(a1, pheading - 30)
		system.yield(2500)
		entities.request_control(a1, function()
		entities.delete(a1)
	end)
	notify("Crash finished")

end)

ui.add_click_option("在他面前放沙发", ply_trolling, function()
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

ui.add_separator("破坏选项", ply_trolling)

ui.add_click_option("空袭玩家", ply_trolling, function()
	local target = online.get_selected_player()
	local selectedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
	local playerPed = PLAYER.PLAYER_PED_ID()
	local coords = ENTITY.GET_ENTITY_COORDS(selectedPlayer, 1)
	local airStrike = MISC.GET_HASH_KEY("WEAPON_AIRSTRIKE_ROCKET")
		WEAPON.REQUEST_WEAPON_ASSET(airStrike, 31, false)
		MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(coords.x, coords.y, coords.z + 20, coords.x, coords.y, coords.z, 250, 1, airStrike, playerPed, 1, 0, -1.0)
end)

ui.add_click_option("删除所有炸药", ply_trolling, function()
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

ui.add_click_option("原子能枪攻击", ply_trolling, function()
	local target = online.get_selected_player()
	local selectedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
	local pos = ENTITY.GET_ENTITY_COORDS(selectedPlayer, 1)
	local hash = utils.joaat("weapon_raypistol")
		MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z, pos.x , pos.y, pos.z-2, 200, 0, hash, 0, true, false, 2500.0)
end)

ui.add_click_option("在他脚下生成手榴弹", ply_trolling, function()
	local target = online.get_selected_player()
	local selectedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
	local playerPed = PLAYER.PLAYER_PED_ID()
	local pos = ENTITY.GET_ENTITY_COORDS(selectedPlayer, 1)
		MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1.4, pos.x, pos.y, pos.z + 1.3, 100, 1, -1813897027, playerPed, 1, 0, -1.0)
end)

ui.add_click_option("在他脚下生成黏弹", ply_trolling, function()
	local target = online.get_selected_player()
	local selectedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
	local playerPed = PLAYER.PLAYER_PED_ID()
	local pos = ENTITY.GET_ENTITY_COORDS(selectedPlayer, 1)
		MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1 , pos.x, pos.y, pos.z + 1.1, 10, 1, 741814745, playerPed, 1, 0, -1.0)
end)

ui.add_separator("笼子选项", ply_trolling)

ui.add_click_option("他进笼子v1", ply_trolling, function(on_click)
	local target = online.get_selected_player()
	local selectedPlayer = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
	local playerPed = PLAYER.PLAYER_PED_ID()
	local pos = ENTITY.GET_ENTITY_COORDS(selectedPlayer, 1)
	local objHash = utils.joaat("prop_gold_cont_01")
		TASK.CLEAR_PED_TASKS_IMMEDIATELY(selectedPlayer)
	local obj = OBJECT.CREATE_OBJECT(objHash, pos.x, pos.y, pos.z - 1.0, true, false, false)
		ENTITY.FREEZE_ENTITY_POSITION(obj, true)
end)

ui.add_click_option("他进笼子v2", ply_trolling, function(on_click)
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

ui.add_click_option("把他关进赛车笼子", ply_trolling, function(on_click)
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

--██████╗ ███████╗███╗   ███╗ ██████╗ ████████╗███████╗    ██╗   ██╗███████╗██╗  ██╗██╗ ██████╗██╗     ███████╗    ████████╗ ██████╗  ██████╗ ██╗     ███████╗
--██╔══██╗██╔════╝████╗ ████║██╔═══██╗╚══██╔══╝██╔════╝    ██║   ██║██╔════╝██║  ██║██║██╔════╝██║     ██╔════╝    ╚══██╔══╝██╔═══██╗██╔═══██╗██║     ██╔════╝
--██████╔╝█████╗  ██╔████╔██║██║   ██║   ██║   █████╗      ██║   ██║█████╗  ███████║██║██║     ██║     █████╗         ██║   ██║   ██║██║   ██║██║     ███████╗
--██╔══██╗██╔══╝  ██║╚██╔╝██║██║   ██║   ██║   ██╔══╝      ╚██╗ ██╔╝██╔══╝  ██╔══██║██║██║     ██║     ██╔══╝         ██║   ██║   ██║██║   ██║██║     ╚════██║
--██║  ██║███████╗██║ ╚═╝ ██║╚██████╔╝   ██║   ███████╗     ╚████╔╝ ███████╗██║  ██║██║╚██████╗███████╗███████╗       ██║   ╚██████╔╝╚██████╔╝███████╗███████║
--╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝ ╚═════╝    ╚═╝   ╚══════╝      ╚═══╝  ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝╚══════╝       ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚══════╝
                                                                                                                                                            
ui.add_separator("传送选项", ply_vehtools)

ui.add_click_option("传送载具到导航点", ply_vehtools, function()
	local target = online.get_selected_player()
	local selfped = PLAYER.PLAYER_PED_ID()
	local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target)
	local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target), 0)
	local blip = HUD.GET_FIRST_BLIP_INFO_ID(8)
	local waypoint_pos = HUD.GET_BLIP_COORDS(blip)

	if blip == 0 then
		notify("你™没有设置导航点!")
	return end

	entities.request_control(vehicle, function()
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, waypoint_pos.x, waypoint_pos.y, waypoint_pos.z + 75, 0, 0, 1)
	end)

end)

ui.add_click_option("传送载具到海中", ply_vehtools, function()
	local target = online.get_selected_player()
	local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target), 0)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
	entities.request_control(vehicle, function()
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, -15000, -15000, 0, 0, 0, 1)
	end)
end)

ui.add_click_option("传送载具到花园银行楼顶", ply_vehtools, function()
	local target = online.get_selected_player()
	local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target), 0)
	entities.request_control(vehicle, function()
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, -76, -819, 327, 0, 0, 1)
	end)
end)

ui.add_click_option("传送载具到监狱", ply_vehtools, function()
	local target = online.get_selected_player()
	local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target), 0)
	entities.request_control(vehicle, function()
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, 1680.11, 2512.89, 45.56, 0, 0, 1)
	end)
end)

ui.add_click_option("送载具到军事基地", ply_vehtools, function()
	local target = online.get_selected_player()
	local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target), 0)
	entities.request_control(vehicle, function()
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, -2219.0, 3213.0, 32.81, 0, 0, 1)
	end)
end)

ui.add_separator("远程载具控制", ply_vehtools)

ui.add_click_option("载具摧毁", ply_vehtools, function()
	local target = online.get_selected_player()
	local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target), 0)
	entities.request_control(vehicle, function()
		VEHICLE.SET_VEHICLE_PETROL_TANK_HEALTH(vehicle, -999.90002441406)
	end)
end)

ui.add_click_option("向上发射载具", ply_vehtools, function()
	local target = online.get_selected_player()
	local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target), 0)
	entities.request_control(vehicle, function()
		ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(vehicle, 1, 0, 0, 10000, true, false, true, false)
	end)
end)

ui.add_choose("强制载具推进方向", ply_vehtools, false, {"东边", "西边", "南边", "北边"}, function (select)
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

ui.add_click_option("踢出载具(温柔地)", ply_vehtools, function()
	local target = online.get_selected_player()
	local ind = PLAYER.GET_PLAYER_INDEX()
	online.send_script_event(target, 578856274, ind, -1, -1, -1, -1)
end)

ui.add_click_option("分离Trailer", ply_vehtools, function()
	local target = online.get_selected_player()
	local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target), 0)
	entities.request_control(vehicle, function()
		VEHICLE.DETACH_VEHICLE_FROM_TRAILER(vehicle)
	end)
end)

ui.add_choose("引擎", ply_vehtools, false, {"摧毁引擎", "修复引擎"}, function (select)
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

ui.add_choose("车门", ply_vehtools, false, {"把玩家锁在车里", "取消锁住他"}, function (select)
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

ui.add_separator("加速选项", ply_vehtools)

ui.add_choose("加速选项", ply_vehtools, false, {"提高向前加速度", "提高向后加速度", "重置加速度"}, function (select)
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

ui.add_separator("直升机选项", ply_vehtools)

ui.add_click_option("摧毁螺旋桨", ply_vehtools, function()
	local target = online.get_selected_player()
	local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(target), 0)
	entities.request_control(vehicle, function()
		VEHICLE._SET_HELI_MAIN_ROTOR_HEALTH(vehicle, 0) 
	end)
end)

ui.add_choose("螺旋桨设置", ply_vehtools, false, {"设置螺旋桨速度为0%", "设置螺旋桨速度为100%"}, function(select)
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

ui.add_separator("杂技选项", ply_vehtools)

ui.add_choose("杂技", ply_vehtools, false, {"Ollie", "Kick Flip", "Double Kick Flip", "Heel Flip"}, function (select)
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

--███╗   ██╗ ██████╗ ████████╗██╗███████╗██╗ ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗     ██████╗ ██████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
--████╗  ██║██╔═══██╗╚══██╔══╝██║██╔════╝██║██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║    ██╔═══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
--██╔██╗ ██║██║   ██║   ██║   ██║█████╗  ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║    ██║   ██║██████╔╝   ██║   ██║██║   ██║██╔██╗ ██║███████╗
--██║╚██╗██║██║   ██║   ██║   ██║██╔══╝  ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║    ██║   ██║██╔═══╝    ██║   ██║██║   ██║██║╚██╗██║╚════██║
--██║ ╚████║╚██████╔╝   ██║   ██║██║     ██║╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║    ╚██████╔╝██║        ██║   ██║╚██████╔╝██║ ╚████║███████║
--╚═╝  ╚═══╝ ╚═════╝    ╚═╝   ╚═╝╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝ ╚═╝        ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
                                                                                                                                                     
ui.add_separator("发送通知", ply_notifytools)

ui.add_click_option("发送检查点赢家通知", ply_notifytools, function()
	local ind = PLAYER.GET_PLAYER_INDEX()
	local target = online.get_selected_player()
		online.send_script_event(target, 677240627, ind, -1530692143)
end)

ui.add_click_option("轻松的方式解脱通知", ply_notifytools, function()
	local ind = PLAYER.GET_PLAYER_INDEX()
	local target = online.get_selected_player()
		online.send_script_event(target, 677240627, ind, 1916687397)
end)

ui.add_click_option("袭击运钞车通知", ply_notifytools, function()
	local ind = PLAYER.GET_PLAYER_INDEX()
		online.send_script_event(target, 677240627, ind, -1020918645)
end)

ui.add_click_option("Player Sat In Transport Message", ply_notifytools, function()
	local ind = PLAYER.GET_PLAYER_INDEX()
	local target = online.get_selected_player()
		online.send_script_event(target, 677240627, ind, 1914235728)
end)

ui.add_click_option("杀死城堡之王", ply_notifytools, function()
	local ind = PLAYER.GET_PLAYER_INDEX()
	local target = online.get_selected_player()
		online.send_script_event(target, 677240627, ind, -1771709808)
end)

ui.add_click_option("虚假雷达透视通知", ply_notifytools, function()
	local ind = PLAYER.GET_PLAYER_INDEX()
	local target = online.get_selected_player()
		online.send_script_event(target, 677240627, ind, 2025562671)
end)

ui.add_click_option("劫匪通知", ply_notifytools, function()
	local ind = PLAYER.GET_PLAYER_INDEX()
	local target = online.get_selected_player()
		online.send_script_event(target, 677240627, ind, -155076576)
end)

ui.add_click_option("现金删除通知", ply_notifytools, function()
	local ind = PLAYER.GET_PLAYER_INDEX()
	local target = online.get_selected_player()
		online.send_script_event(target, 677240627, ind, 689178114, 2147483647, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
end)

ui.add_click_option("现金被偷通知", ply_notifytools, function()
	local ind = PLAYER.GET_PLAYER_INDEX()
	local target = online.get_selected_player()
		online.send_script_event(target, 677240627, ind, -2106994199, 2147483647, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
end)

ui.add_click_option("现金存入银行", ply_notifytools, function()
	local ind = PLAYER.GET_PLAYER_INDEX()
	local target = online.get_selected_player()
		online.send_script_event(target, 677240627, ind, 1990572980, 2147483647, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
end)

ui.add_click_option("摧毁载具并理赔", ply_notifytools, function()
	local ind = PLAYER.GET_PLAYER_INDEX()
	local target = online.get_selected_player()
		online.send_script_event(target, 802133775, ind, 666)
end)

ui.add_separator("虚假邀请", ply_notifytools)

ui.add_choose("虚假邀请选项", ply_notifytools, false, {"虚假游艇邀请", "虚假办公室邀请", "虚假夜总会邀请", "虚假办公室车库邀请", "虚假LSC邀请", "虚假公寓邀请"}, function (select)
	local target = online.get_selected_player()
	local ind = PLAYER.GET_PLAYER_INDEX()
	local name = online.get_name(target)

	if select == 0 then 
		online.send_script_event(target, 1132878564, ind, 1)
	end

	if select == 1 then
		online.send_script_event(target, 1132878564, ind, 2)
	end

	if select == 2 then
		online.send_script_event(target, 1132878564, ind, 3)
	end

	if select == 3 then
		online.send_script_event(target, 1132878564, ind, 4)
	end

	if select == 4 then
		online.send_script_event(target, 1132878564, ind, 5)
	end

	if select == 5 then
		online.send_script_event(target, 2020588206, ind, 5)
	end

	if select == 6 then
		online.send_script_event(target, 1132878564, ind, 6)
	end

end)

local inv_spam_npc_list = {}

ui.add_bool_option("NPC邀请邮件", ply_notifytools, function(state)
    inv_spam_npc_list[online.get_selected_player()] = state
    local name = online.get_name(online.get_selected_player())
    if state then notify("发送大量垃圾虚假信息给".. name .."") end
end)

function inv_spam_npc()
    for pid, state in pairs(inv_spam_npc_list) do
        if not player_exists(pid) then inv_spam_npc_list[pid] = nil end
        if inv_spam_npc_list[pid] then
               for i = 101, 175 do
                   online.send_script_event(online.get_selected_player(), 922450413, 0, i, online.get_selected_player())
                   system.yield(10)
               end
        end
    end
end




--███████╗███████╗██╗     ███████╗     ██████╗ ██████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
--██╔════╝██╔════╝██║     ██╔════╝    ██╔═══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
--███████╗█████╗  ██║     █████╗      ██║   ██║██████╔╝   ██║   ██║██║   ██║██╔██╗ ██║███████╗
--╚════██║██╔══╝  ██║     ██╔══╝      ██║   ██║██╔═══╝    ██║   ██║██║   ██║██║╚██╗██║╚════██║
--███████║███████╗███████╗██║         ╚██████╔╝██║        ██║   ██║╚██████╔╝██║ ╚████║███████║
--╚══════╝╚══════╝╚══════╝╚═╝          ╚═════╝ ╚═╝        ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
                                                                                            
ui.add_sub_option("自我选项", main_sub, selftools_sub)

ui.add_separator("角色选项", selftools_sub)

function requestModel(hash, onSuccess)
    if STREAMING.IS_MODEL_VALID(hash) == 0 then return end
    local tries = 0
    while tries < 50 and STREAMING.HAS_MODEL_LOADED(hash) == 0 do
        STREAMING.REQUEST_MODEL(hash);
        tries = tries + 1
        system.yield(100)
    end
    if STREAMING.HAS_MODEL_LOADED(hash) == 1 then onSuccess() return end
end

ui.add_bool_option("恶灵骑士完全版", selftools_sub, function(on)
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
		notify("地上有摩托！")
    else
        FIRE.STOP_ENTITY_FIRE(ped)
		ENTITY.SET_ENTITY_INVINCIBLE(ped, false)
    end
end)--为了完成这个功能，OxiGen给予了MG很多的帮助，一定要感谢OxiGen！！



ui.add_num_option("玩家隐身", selftools_sub, 0, 255, 1, function(num)
	local ped = PLAYER.PLAYER_PED_ID()
	ENTITY.SET_ENTITY_ALPHA(ped, num, false)
end)

ui.add_click_option("隐身程度", selftools_sub, function()
	local ped = PLAYER.PLAYER_PED_ID()
	ENTITY.RESET_ENTITY_ALPHA(ped)
end)

ui.add_bool_option("无脚步声", selftools_sub, function(toggle)
	local ped = PLAYER.PLAYER_PED_ID()
		AUDIO._SET_PED_AUDIO_FOOTSTEP_LOUD(ped, not toggle)
end)

ui.add_click_option("变成警察(警察无视你)", selftools_sub, function()
	local ped = PLAYER.PLAYER_PED_ID()
		PED.SET_PED_AS_COP(ped, true)
		notify("You are now on duty, cops will ignore you.\nSwat and army can still shoot you.")
end)


ui.add_separator("武器选项", selftools_sub)

ui.add_bool_option("友好的火", selftools_sub, function(toggle)
	local ped = PLAYER.PLAYER_PED_ID()
		PED.SET_CAN_ATTACK_FRIENDLY(ped, toggle, false)
end)

ui.add_click_option("删除所有黏弹", selftools_sub, function()
	local stb = utils.joaat("weapon_stickybomb")
		WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(stb, false)
end)

ui.add_separator("通缉等级选项", selftools_sub)

ui.add_bool_option("虚假通缉等级→6星", selftools_sub, function(on)

    if on then
		MISC.SET_FAKE_WANTED_LEVEL(6)
	else
		MISC.SET_FAKE_WANTED_LEVEL(0)
	end

end)

ui.add_separator("传送选项", selftools_sub)

ui.add_click_option("起飞！", selftools_sub, function()
	local myped = PLAYER.PLAYER_PED_ID()
    local myPos = ENTITY.GET_ENTITY_COORDS(myped, false)
    	ENTITY.SET_ENTITY_COORDS(myped, myPos.x, myPos.y, myPos.z + 250.0, 1, 0, 0, 1)
end)

ui.add_choose("传送", selftools_sub, false, {"佩里托小海湾", "国际机场", "赌场门口", "传送到乞力耶德山山顶", "花园银行楼顶", "监狱", "军事基地"}, function (select)
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

--███████╗███████╗███████╗███████╗██╗ ██████╗ ███╗   ██╗     ██████╗ ██████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
--██╔════╝██╔════╝██╔════╝██╔════╝██║██╔═══██╗████╗  ██║    ██╔═══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
--███████╗█████╗  ███████╗███████╗██║██║   ██║██╔██╗ ██║    ██║   ██║██████╔╝   ██║   ██║██║   ██║██╔██╗ ██║███████╗
--╚════██║██╔══╝  ╚════██║╚════██║██║██║   ██║██║╚██╗██║    ██║   ██║██╔═══╝    ██║   ██║██║   ██║██║╚██╗██║╚════██║
--███████║███████╗███████║███████║██║╚██████╔╝██║ ╚████║    ╚██████╔╝██║        ██║   ██║╚██████╔╝██║ ╚████║███████║
--╚══════╝╚══════╝╚══════╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝ ╚═╝        ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
                                                                                                                  
ui.add_sub_option("战局选项", main_sub, sessiontools_sub)

ui.add_separator("噪音", sessiontools_sub)

ui.add_bool_option("打开噪音", sessiontools_sub, function()
    local ped = PLAYER.PLAYER_PED_ID()

	for i = 0, 5 do
    	AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "07", ped, "DLC_GR_CS2_Sounds", true, 0)
	end
	
end)

ui.add_separator("远程选项", sessiontools_sub)

ui.add_click_option("崩溃所有人", sessiontools_sub, function()
    local ped = PLAYER.PLAYER_PED_ID()

	for i = 0, 50 do
		AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Event_Message_Purple", ped, "GTAO_FM_Events_Soundset", true, 0)
	end

	system.yield(500)

end)

ui.add_choose("雷达隐身", sessiontools_sub, false, {"战局雷达隐身开启", "战局雷达隐身关闭"}, function (select)

	if select == 0 then 
		for pids = 0, 31 do
			if pids ~= PLAYER.GET_PLAYER_INDEX() then
				NETWORK._SET_RELATIONSHIP_TO_PLAYER(pids, true)
				notify("You are ghostly!")
				system.yield(0)
			end
		end
	end

	if select == 1 then
		for pids = 0, 31 do
			if pids ~= PLAYER.GET_PLAYER_INDEX() then
				NETWORK._SET_RELATIONSHIP_TO_PLAYER(pids, false)
				notify("You are no longer ghostly!")
			end
		end
	end

end)

ui.add_click_option("摧毁战局所有人的个人载具", sessiontools_sub, function()
	
	notify("Demolishing cars...")

	for pids = 0, 31 do
		if pids ~= PLAYER.GET_PLAYER_INDEX() then
			online.send_script_event(pids, 3268179810, PLAYER.GET_PLAYER_INDEX(), pids)
			online.send_script_event(pids, 578856274, PLAYER.GET_PLAYER_INDEX(), pids, 0, 0, 0, 0, 1)
		end
	end

end)

ui.add_click_option("送所有人上岛", sessiontools_sub, function()
	
	notify("Teleporting all players to Cayo Perico")

	for pids = 0, 31 do
		if pids ~= PLAYER.GET_PLAYER_INDEX() then
			online.send_script_event(pids, 1463943751, 1, 0, 0, 4, PLAYER.GET_PLAYER_INDEX(), pids, 0)
		end
	end

end)

ui.add_click_option("送所有人上岛(无动画)", sessiontools_sub, function()

	notify("Teleporting all players to Cayo Perico (N/C)")

	for pids = 0, 31 do
		if pids ~= PLAYER.GET_PLAYER_INDEX() then
			online.send_script_event(pids, 1463943751, 1, 0, 0, 4, 1, PLAYER.GET_PLAYER_INDEX(), pids)
		end
	end

end)

ui.add_click_option("送所有人到海滩", sessiontools_sub, function()
	notify("Teleporting all players to Beach")

	for pids = 0, 31 do
		if pids ~= PLAYER.GET_PLAYER_INDEX() then
			online.send_script_event(pids, 1463943751, 1, 0, 0, 4, 0, PLAYER.GET_PLAYER_INDEX(), pids)
		end
	end

end)

ui.add_separator("聊天选项", sessiontools_sub)

ui.add_click_option("开始假打字", sessiontools_sub, function()

	for pids = 0, 31 do
		if pids ~= PLAYER.GET_PLAYER_INDEX() then
			online.send_script_event(pids, 747270864, PLAYER.GET_PLAYER_INDEX(), pids, 6769)
		end
	end

end)

ui.add_click_option("停止假打字", sessiontools_sub, function()

	for pids = 0, 31 do
		if pids ~= PLAYER.GET_PLAYER_INDEX() then
			online.send_script_event(pids, -990958325, PLAYER.GET_PLAYER_INDEX(), pids, 7556)
		end
	end

end)

--██╗   ██╗███████╗██╗  ██╗██╗ ██████╗██╗     ███████╗     ██████╗ ██████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
--██║   ██║██╔════╝██║  ██║██║██╔════╝██║     ██╔════╝    ██╔═══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
--██║   ██║█████╗  ███████║██║██║     ██║     █████╗      ██║   ██║██████╔╝   ██║   ██║██║   ██║██╔██╗ ██║███████╗
--╚██╗ ██╔╝██╔══╝  ██╔══██║██║██║     ██║     ██╔══╝      ██║   ██║██╔═══╝    ██║   ██║██║   ██║██║╚██╗██║╚════██║
-- ╚████╔╝ ███████╗██║  ██║██║╚██████╗███████╗███████╗    ╚██████╔╝██║        ██║   ██║╚██████╔╝██║ ╚████║███████║
--  ╚═══╝  ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝╚══════╝     ╚═════╝ ╚═╝        ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
                                                                                                                
ui.add_sub_option("载具选项", main_sub, selfvehtools_sub)

ui.add_separator("载具选项", selfvehtools_sub)

ui.add_click_option("强制离开载具", selfvehtools_sub, function(on_click)
	local ped = PLAYER.PLAYER_PED_ID()
    	TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
    	TASK.TASK_LEAVE_ANY_VEHICLE(ped, 0, 16)
end)

ui.add_bool_option("停止控制", selfvehtools_sub, function(on)
	local last_vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true)
    if on then
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(last_vehicle, true)
		VEHICLE._SET_VEHICLE_REDUCE_TRACTION(last_vehicle, 50)
	else
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(last_vehicle, false)
		VEHICLE._SET_VEHICLE_REDUCE_TRACTION(last_vehicle, 100)
	end

end)


ui.add_num_option("设置污垢等级", selfvehtools_sub, 0.0, 15, 1, function(num)
	local last_vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true)
    	VEHICLE.SET_VEHICLE_DIRT_LEVEL(last_vehicle, num)
end)

ui.add_click_option("清理载具", selfvehtools_sub, function(on_click)
	local last_vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true)
		GRAPHICS.REMOVE_DECALS_FROM_VEHICLE(last_vehicle)
    	VEHICLE.SET_VEHICLE_DIRT_LEVEL(last_vehicle, 0)
end)

ui.add_choose("车门开/关", selfvehtools_sub, false, {"引擎盖", "后备箱", "左前门", "右前门", "后左门", "后右门"}, function (select)
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

ui.add_click_option("打开所有门", selfvehtools_sub, function()
	local last_vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true)

	for i = 0, 5 do
		VEHICLE.SET_VEHICLE_DOOR_OPEN(last_vehicle, i, false, false)
	end

end)

ui.add_click_option("关闭所有门", selfvehtools_sub, function()
	local last_vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true)
    	VEHICLE.SET_VEHICLE_DOORS_SHUT(last_vehicle, false)
end)

ui.add_bool_option("关闭湍流", selfvehtools_sub, function(on)

    if on then
		VEHICLE.SET_PLANE_TURBULENCE_MULTIPLIER(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), 0), 0.0)
	else
		VEHICLE.SET_PLANE_TURBULENCE_MULTIPLIER(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), 0), 1.0)
	end
end)

ui.add_click_option("远程开启个人载具引擎", selfvehtools_sub, function()
	local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
	if ENTITY.DOES_ENTITY_EXIST(vehicle) then
		VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
		VEHICLE.SET_VEHICLE_LIGHTS(vehicle, 0)
		VEHICLE._SET_VEHICLE_LIGHTS_MODE(vehicle, 2)
	end
end)



--██████╗ ███████╗ ██████╗ ██████╗ ██╗   ██╗███████╗██████╗ ██╗   ██╗     ██████╗ ██████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
--██╔══██╗██╔════╝██╔════╝██╔═══██╗██║   ██║██╔════╝██╔══██╗╚██╗ ██╔╝    ██╔═══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
--██████╔╝█████╗  ██║     ██║   ██║██║   ██║█████╗  ██████╔╝ ╚████╔╝     ██║   ██║██████╔╝   ██║   ██║██║   ██║██╔██╗ ██║███████╗
--██╔══██╗██╔══╝  ██║     ██║   ██║╚██╗ ██╔╝██╔══╝  ██╔══██╗  ╚██╔╝      ██║   ██║██╔═══╝    ██║   ██║██║   ██║██║╚██╗██║╚════██║
--██║  ██║███████╗╚██████╗╚██████╔╝ ╚████╔╝ ███████╗██║  ██║   ██║       ╚██████╔╝██║        ██║   ██║╚██████╔╝██║ ╚████║███████║
--╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═════╝   ╚═══╝  ╚══════╝╚═╝  ╚═╝   ╚═╝        ╚═════╝ ╚═╝        ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
                                                                                                                               
ui.add_sub_option("恢复选项", main_sub, recoverytools_sub)

ui.add_separator("抢劫选项", recoverytools_sub)

ui.add_click_option("修复赌场抢劫", recoverytools_sub, function()
	notify("It might help if you broke the heist...")
		STATS.STAT_SET_INT(utils.joaat("MP0_H3OPT_POI"), 0, true)
		STATS.STAT_SET_INT(utils.joaat("MP0_H3OPT_ACCESSPOINTS"), 0, true)
end)

ui.add_separator("游戏币助手", recoverytools_sub)

local function tpToBlip(blip)
	local last_vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true)
	local pos = HUD.GET_BLIP_COORDS(blip)
	local ped = PLAYER.PLAYER_PED_ID()
	local tpEntity = (PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true) and last_vehicle)
		ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), pos.x, pos.y, pos.z, 0, 0, 0, 0)
			entities.request_control(last_vehicle, function()
				ENTITY.SET_ENTITY_COORDS(last_vehicle, pos.x, pos.y, pos.z, 0, 0, 0, 0)
				PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), last_vehicle, -1)
	end)
end

ui.add_click_option("传送到时间挑战赛(100k$)", recoverytools_sub, function()
	local ttBlip = HUD._GET_CLOSEST_BLIP_OF_TYPE(430)
		tpToBlip(ttBlip)
end)

local function tpToBlip2(blip)
	local last_vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true)
	local pos = HUD.GET_BLIP_COORDS(blip)
	local ped = PLAYER.PLAYER_PED_ID()
	local tpEntity = (PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true) and last_vehicle)
		ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), pos.x, pos.y, pos.z, 0, 0, 0, 0)
end

ui.add_click_option("传送到RC时间挑战赛(100k$)", recoverytools_sub, function()
	local ttBlip2 = HUD._GET_CLOSEST_BLIP_OF_TYPE(673)
		tpToBlip2(ttBlip2)
end)

local function tpToMissionBlip(blip)
local last_vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), true)
local missionBlip = HUD.GET_FIRST_BLIP_INFO_ID(1)
local pos = HUD.GET_BLIP_COORDS(blip)
local ped = PLAYER.PLAYER_PED_ID()
local tpEntity = (PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true) and last_vehicle)
	ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), pos.x, pos.y, pos.z, 0, 0, 0, 0)
		entities.request_control(last_vehicle, function()
			ENTITY.SET_ENTITY_COORDS(last_vehicle, pos.x, pos.y, pos.z, 0, 0, 0, 0)
			PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), last_vehicle, -1)
	end)
end

ui.add_click_option("传送到任务点(黄色)", recoverytools_sub, function()
    local missionBlip = HUD.GET_FIRST_BLIP_INFO_ID(1)

    local check = false
    for count = 0, 100 do
        if HUD.GET_BLIP_COLOUR(missionBlip) == 60 then 
            check = true
            break
        end

        missionBlip = HUD.GET_NEXT_BLIP_INFO_ID(1)
    end

    if not check then return end
    
    tpToMissionBlip(missionBlip)
end)








--██╗    ██╗ ██████╗ ██████╗ ██╗     ██████╗      ██████╗ ██████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
--██║    ██║██╔═══██╗██╔══██╗██║     ██╔══██╗    ██╔═══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
--██║ █╗ ██║██║   ██║██████╔╝██║     ██║  ██║    ██║   ██║██████╔╝   ██║   ██║██║   ██║██╔██╗ ██║███████╗
--██║███╗██║██║   ██║██╔══██╗██║     ██║  ██║    ██║   ██║██╔═══╝    ██║   ██║██║   ██║██║╚██╗██║╚════██║
--╚███╔███╔╝╚██████╔╝██║  ██║███████╗██████╔╝    ╚██████╔╝██║        ██║   ██║╚██████╔╝██║ ╚████║███████║
-- ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════╝      ╚═════╝ ╚═╝        ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
                                                                                                       
ui.add_sub_option("世界选项", main_sub, worldtools_sub)

ui.add_separator("天气选项", worldtools_sub)

ui.add_click_option("打雷", worldtools_sub, function()
	MISC.FORCE_LIGHTNING_FLASH()
end)

ui.add_num_option("设置风速", worldtools_sub, 0, 15, 1, function(num)
	MISC.SET_WIND_SPEED(num)
end)

ui.add_bool_option("停止下雨", worldtools_sub, function(on)
	
	if on then
		MISC._SET_RAIN_LEVEL(0.0)
	else
		MISC._SET_RAIN_LEVEL(0.5)
	end

end)

ui.add_separator("屏幕特效", worldtools_sub)

ui.add_bool_option("DMT", worldtools_sub, function(on)
	
	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("DMT_flight", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("DMT_flight")
    end

end)

ui.add_bool_option("Clowns", worldtools_sub, function(on)

	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("DrugsTrevorClownsFight", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("DrugsTrevorClownsFight")
    end

end)

ui.add_bool_option("Dog Vision", worldtools_sub, function(on)

	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("ChopVision", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("ChopVision")
    end

end)

ui.add_bool_option("Rampage", worldtools_sub, function(on)

	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("Rampage", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("Rampage")
    end

end)

ui.add_bool_option("Deadline", worldtools_sub, function(on)

	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("DeadlineNeon", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("DeadlineNeon")
    end

end)

ui.add_bool_option("Driving Focus", worldtools_sub, function(on)

	if on then
        GRAPHICS.ANIMPOSTFX_PLAY("DrivingFocus", 0, true)
    else
        GRAPHICS.ANIMPOSTFX_STOP("DrivingFocus")
    end

end)


--███╗   ███╗██╗███████╗ ██████╗     ██████╗ ██████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
--████╗ ████║██║██╔════╝██╔════╝    ██╔═══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
--██╔████╔██║██║███████╗██║         ██║   ██║██████╔╝   ██║   ██║██║   ██║██╔██╗ ██║███████╗
--██║╚██╔╝██║██║╚════██║██║         ██║   ██║██╔═══╝    ██║   ██║██║   ██║██║╚██╗██║╚════██║
--██║ ╚═╝ ██║██║███████║╚██████╗    ╚██████╔╝██║        ██║   ██║╚██████╔╝██║ ╚████║███████║
--╚═╝     ╚═╝╚═╝╚══════╝ ╚═════╝     ╚═════╝ ╚═╝        ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
                                                                                          
ui.add_sub_option("其他选项", main_sub, misctools_sub)

ui.add_separator("游戏币", misctools_sub)

ui.add_click_option("把银行的钱取出来", misctools_sub, function(feat)
	local walletCash = MONEY.NETWORK_GET_VC_WALLET_BALANCE(0)
	local bankCash = MONEY.NETWORK_GET_VC_BANK_BALANCE()

	if bankCash > 0 then
		NETSHOPPING._NET_GAMESERVER_TRANSFER_BANK_TO_WALLET(0, bankCash)
		notify("Transferred "..bankCash.."$ to the wallet.\nYour current wallet balance is now "..walletCash)
	else
		notify("Funds could not be transffered, your bank balance is "..bankCash)
	end

end)

ui.add_click_option("存进去银行", misctools_sub, function(feat)
	local walletCash = MONEY.NETWORK_GET_VC_WALLET_BALANCE(0)
	local bankCash = MONEY.NETWORK_GET_VC_BANK_BALANCE()

	if walletCash > 0 then
		NETSHOPPING._NET_GAMESERVER_TRANSFER_WALLET_TO_BANK(0, walletCash)
		notify("Transferred "..walletCash.."$ to the bank.\nYour current bank balance is now "..bankCash)
	else
		notify("Funds could not be transffered, your wallet balance is "..walletCash)
	end

end)


ui.add_separator("游戏工具", misctools_sub)

ui.add_bool_option("允许在任何时候使用P暂停菜单", misctools_sub, function(toggle)

	if toggle then
        MISC.SET_THIS_SCRIPT_CAN_BE_PAUSED(1)
    else
		MISC.SET_THIS_SCRIPT_CAN_BE_PAUSED(0)
    end

end)


ui.add_click_option("强制重启游戏", misctools_sub, function()
	notify("Restarting your game...")
    	NETWORK._SHUTDOWN_AND_LOAD_MOST_RECENT_SAVE()
end)


--夜总会
ncr_sub = ui.add_submenu("其他选项")
ui.add_sub_option("夜总会刷钱", main_sub, ncr_sub)
 

function get_last_char()
    local pArg = memory.malloc(4)
    STATS.STAT_GET_INT(utils.joaat("MPPLY_LAST_MP_CHAR"), pArg, -1)
    local char = memory.read_int(pArg)
    memory.free(pArg)
    return tostring(char)
end

local n = "MP" .. get_last_char()

ui.add_click_option("使用教学", ncr_sub, function()
    system.notify("夜总会刷钱", "买一个夜总会\n设置好你的夜总会\n把前置做完\n进去夜总会\n使用“传送到保险箱”\n打开保险箱\n打开夜总会循坏刷钱开关\n不要一次刷太多\n唯一指定Q群：568418736\n唯一指定Q群：568418736", 13, 37, 28, 255)
end)

ui.add_click_option("传送到保险箱", ncr_sub, function()
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), -1615.6827392578, -3015.6813964844, -75.205070495605, false, false, false)
end)

loop = ui.add_bool_option("夜总会循坏刷钱开关", ncr_sub, function(state)
    system.notify("夜总会刷钱", "风险自负!", 13, 37, 28, 255)
    globals.set_int(262145+23112 , 133377)
end)

local startTime = os.time()



while true do
   if ui.get_value(loop) and os.time() - startTime >= 8 then
        globals.set_int(262145 + 24073, 250000) -- KEEP AT 300000 OR YOU WILL NEED TO DELETE & RE-MAKE YOUR CHARACTER, IT WILL BUG THE NIGHTCLUB SAFE!
        globals.set_int(262145 + 24069, 250000) -- KEEP AT 300000 OR YOU WILL NEED TO DELETE & RE-MAKE YOUR CHARACTER, IT WILL BUG THE NIGHTCLUB SAFE!
        STATS.STAT_SET_INT(utils.joaat(n .. "_CLUB_POPULARITY"), 10000, true)
        STATS.STAT_SET_INT(utils.joaat(n .. "_CLUB_PAY_TIME_LEFT"), -1, true)
        STATS.STAT_SET_INT(utils.joaat(n .. "_CLUB_POPULARITY"), 100000, true)
        startTime = os.time()
    end

	inv_spam_npc()
    system.yield(500)
end