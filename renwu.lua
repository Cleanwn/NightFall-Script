system.log("任务Lua","欢迎使用任务Lua~ WWWW")

local global = require("menu/globals/heist_control")
local stats = require("menu/stats/heist_control")
local main = global.main

local active_funcs = {}

local function AddOrRemove(name, val, func)
	if val then
		system.log("调试", "添加 " .. name)
		active_funcs[name] = func
	else
		system.log("调试", "移除 " .. name)
		active_funcs[name] = nil
	end
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

local function add_preset(v, sub)
	if v.stats then
		ui.add_click_option(v.name, sub, function()
			for _, stat_info in ipairs(v.stats) do
				set_stat_int(stat_info[1], stat_info[2])
			end
		end)
	elseif v.func then
		ui.add_bool_option(v.name, sub, v.func)
	end
end

local presets = {
	{name = "困难 - 猎豹雕像", cayo = true, stats = stats.cayo.only_primary.diaoxiang},
	{name = "普通 - 猎豹雕像", cayo = true, stats = stats.cayo.only_primary.diaoxiangpt},
	{name = "困难 - 粉钻", cayo = true, stats = stats.cayo.only_primary.fenzuan},
	{name = "普通 - 粉钻", cayo = true, stats = stats.cayo.only_primary.fenzuanpt},
	{name = "困难 - 红宝石项链", cayo = true, stats = stats.cayo.only_primary.hongbaoshi},
	{name = "普通 - 红宝石项链", cayo = true, stats = stats.cayo.only_primary.hongbaoshipt},
	{name = "困难 - 不记名债券", cayo = true, stats = stats.cayo.only_primary.zhaiquan},
	{name = "普通 - 不记名债券", cayo = true, stats = stats.cayo.only_primary.zhaiquanpt},
	{name = "困难 - 西西米托龙舌兰", cayo = true, stats = stats.cayo.only_primary.longshelan},
	{name = "普通 - 西西米托龙舌兰", cayo = true, stats = stats.cayo.only_primary.longshelanpt},
	{name = "困难 - 玛德拉索文件", cayo = true, stats = stats.cayo.only_primary.wenjian},
	{name = "普通 - 玛德拉索文件(第一回可跳)", cayo = true, stats = stats.cayo.only_primary.wenjianpt},
	{name = "重置小岛抢劫冷却时间", cayo = true, stats = stats.cayo.only_primary.xdlengque},
	{name = "佩里科岛抢劫面板重置", cayo = true, stats = stats.cayo.only_primary.xdchongzhi},

	{name = "钻石 - 潜踪匿迹", casino = true, stats = stats.casino.diamonds.silent},
	{name = "钻石 - 兵不厌诈", casino = true, stats = stats.casino.diamonds.bigcon},
	{name = "钻石 - 气势汹汹", casino = true, stats = stats.casino.diamonds.aggressive},
	{name = "画像 - 潜踪匿迹", casino = true, stats = stats.casino.diamonds.huaxiangy},
	{name = "画像 - 兵不厌诈", casino = true, stats = stats.casino.diamonds.huaxiangb},
	{name = "画像 - 气势汹汹", casino = true, stats = stats.casino.diamonds.huaxiangq},
	{name = "现金 - 潜踪匿迹", casino = true, stats = stats.casino.diamonds.xianjiny},
	{name = "现金 - 兵不厌诈", casino = true, stats = stats.casino.diamonds.xianjinb},
	{name = "现金 - 气势汹汹", casino = true, stats = stats.casino.diamonds.xianjinq},
	{name = "黄金 - 潜踪匿迹(第一回拍完照可跳)", casino = true, stats = stats.casino.diamonds.huangjiny},
	{name = "黄金 - 兵不厌诈(第一回拍完照可跳)", casino = true, stats = stats.casino.diamonds.huangjinb},
	{name = "黄金 - 气势汹汹(第一回拍完照可跳)", casino = true, stats = stats.casino.diamonds.huangjinq},
	{name = "重置赌场抢劫冷却时间", casino = true, stats = stats.casino.diamonds.dclengque},
	{name = "赌场抢劫面板重置", casino = true, stats = stats.casino.diamonds.dcchongzhi},

	{name = "末日一 : 数据泄露", doomsday = true, stats = stats.doomsday.act1},
	{name = "末日二 : 波格丹危机", doomsday = true, stats = stats.doomsday.act2},
	{name = "末日三 : 末日将至", doomsday = true, stats = stats.doomsday.act3},


	{name = "跳过公寓前置  (开任务看动画点)", classic = true, stats = stats.classic.gongyu},
	{name = "取消抢劫并重新开始", classic = true, stats = stats.classic.qxqiangjie},

	{name = "玩家 - 性别修改(去重新捏脸)", qita = true, stats = stats.qita.xingbie},
	{name = "资产 - 补满夜总会人气", qita = true, stats = stats.qita.yezonghui},
	{name = "资产 - 摩托帮自动进货(切换战局)", qita = true, stats = stats.qita.motuobang},
	{name = "资产 - 地堡自动进货(切换战局)", qita = true, stats = stats.qita.dibao},
	{name = "解锁 - CEO办公室满地钱和小金人", qita = true, stats = stats.qita.mandiqian},
	{name = "解锁 - 电话联系人", qita = true, stats = stats.qita.lianxiren},
	{name = "解锁 - 限定载具节日涂装", qita = true, stats = stats.qita.tuzhuang},
	{name = "解锁 - 外星人纹身", qita = true, stats = stats.qita.xenshen},
	{name = "解锁 - 全部游艇任务", qita = true, stats = stats.qita.youting},
	{name = "解锁 - 载具金属质感喷漆与铝合金轮毅", qita = true, stats = stats.qita.tuzhuang},
	{name = "解锁 - 解锁CEO特殊载具任务", qita = true, stats = stats.qita.teshu},
	{name = "解决问题 - 解决赌场侦察拍照问题", qita = true, stats = stats.qita.paizhao},

	{name = "终章 240万", contract = true, func = function(val)
		apply_stats(stats.contract.final)
		AddOrRemove("最终合同", val, function()
			globals.set_int(main + global.contract.earnings, 2400000)
		end)
	end},
	{name = "联合储蓄银行合约", tuners = true, stats = stats.tuner.union},
	{name = "大钞交易", tuners = true, stats = stats.tuner.superdollar},
	{name = "银行合约", tuners = true, stats = stats.tuner.bank_contract},
	{name = "电控单元合约", tuners = true, stats = stats.tuner.ecu},
	{name = "监狱合约", tuners = true, stats = stats.tuner.prison},
	{name = "IAA交易", tuners = true, stats = stats.tuner.agency},
	{name = "失落摩托帮合约", tuners = true, stats = stats.tuner.lost},
	{name = "数据合约", tuners = true, stats = stats.tuner.data},
	{name = "重置收益&完成", tuners = true, stats = stats.tuner.reset_gains},
	{name = "完成任务", tuners = true, stats = stats.tuner.complete},
	{name = "夜总会 (准备)", contract = true, stats = stats.contract.nightclub},
	{name = "码头 (准备)", contract = true, stats = stats.contract.marina},
	{name = "夜生活泄漏 (任务)", contract = true, stats = stats.contract.nightlife},
	{name = "乡村俱乐部 (准备)", contract = true, stats = stats.contract.country_club},
	{name = "宾客名单 (准备)", contract = true, stats = stats.contract.guest_list},
	{name = "上流社会 (任务)", contract = true, stats = stats.contract.high_society},
	{name = "戴维斯 (准备)", contract = true, stats = stats.contract.davis},
	{name = "巴拉斯 (准备)", contract = true, stats = stats.contract.ballas},
	{name = "代理工作室 (任务)", contract = true, stats = stats.contract.agency_studio},
	{name = "最终任务:别惹德瑞", contract = true, stats = stats.contract.final},
}
local function sub_tab(name, sub_id)
	local tab = ui.add_submenu(name)
	ui.add_sub_option(name, sub_id, tab)
	return tab
end

local heist_tab = ui.add_main_submenu("任务Lua")

local casino = sub_tab("名钻赌场", heist_tab)
local casino_presets = sub_tab("预设", casino)
for k, v in ipairs(presets) do
	if v.casino then
		add_preset(v, casino_presets)
	end
end

ui.add_click_option("名钻赌场全员135分红", casino, function()
	globals.set_int(1966534 + 1497 + 736 + 92+1, 135)
	globals.set_int(1966534 + 1497 + 736 + 92+2, 135)
	globals.set_int(1966534 + 1497 + 736 + 92+3, 135)
	globals.set_int(1966534 + 1497 + 736 + 92+4, 135)
end)



ui.add_num_option("名钻赌场玩家1-4分红", casino, 0, 500, 1, function(num)
	globals.set_int(1966534 + 1497 + 736 + 92+1, num)
	globals.set_int(1966534 + 1497 + 736 + 92+2, num)
	globals.set_int(1966534 + 1497 + 736 + 92+3, num)
	globals.set_int(1966534 + 1497 + 736 + 92+4, num)

end)

ui.add_num_option("赌场玩家1分红", casino, 0, 500, 1, function(num)
	globals.set_int(1966534 + 1497 + 736 + 92 + 1, num)
end)

ui.add_num_option("赌场玩家2分红", casino, 0, 500, 1, function(num)
	globals.set_int(1966534 + 1497 + 736 + 92 + 2, num)
end)

ui.add_num_option("赌场玩家3分红", casino, 0, 500, 1, function(num)
	globals.set_int(1966534 + 1497 + 736 + 92 + 3, num)
end)

ui.add_num_option("赌场玩家4分红", casino, 0, 500, 1, function(num)
	globals.set_int(1966534 + 1497 + 736 + 92 + 4, num)
end)

ui.add_click_option("赌场 : 指纹复制器", casino, function()
		globals.set_local("fm_mission_controller", 52929, 5)
end)

ui.add_click_option("赌场 : 密码门禁", casino, function()
		globals.set_local("fm_mission_controller", 53991, 5)
end)

ui.add_num_option("修改总收入", casino, 0, 10000000, 10000, function(num)
		globals.set_local("fm_mission_controller", 22365, num)
end)

ui.add_click_option("快速完成气势汹汹", casino, function()
		if globals.is_script_active("fm_mission_controller") then
			globals.set_local("fm_mission_controller", 22365, 10000000)
			globals.set_local("fm_mission_controller", 19679, 12)
			globals.set_local("fm_mission_controller", 28299, 99999)
			globals.set_local("fm_mission_controller", 31623, 99999)			---BY:来源首领任务脚本
			;
		end
	end)

local doom = sub_tab("末日豪劫", heist_tab)
local doom_presets = sub_tab("预设", doom)
for k, v in ipairs(presets) do
	if v.doomsday then
		add_preset(v, doom_presets)
	end
end

ui.add_click_option("数据泄漏普通251分红", doom, function()
	globals.set_int(1962546 + 812 + 50 + 1, 251)
	globals.set_int(1962546 + 812 + 50 + 2, 251)
	globals.set_int(1962546 + 812 + 50 + 3, 251)
	globals.set_int(1962546 + 812 + 50 + 4, 251)
end)
ui.add_num_option("末日豪劫玩家1-4分红", doom, 0, 500, 1, function(num)
	globals.set_int(1962546 + 812 + 50 + 1, num)
	globals.set_int(1962546 + 812 + 50 + 2, num)
	globals.set_int(1962546 + 812 + 50 + 3, num)
	globals.set_int(1962546 + 812 + 50 + 4, num)
end)

ui.add_num_option("末日玩家1分红", doom, 0, 500, 1, function(num)
	globals.set_int(1962546 + 812 + 50 + 1, num)
end)

ui.add_num_option("末日玩家2分红", doom, 0, 500, 1, function(num)
	globals.set_int(1962546 + 812 + 50 + 2, num)
end)

ui.add_num_option("末日玩家3分红", doom, 0, 500, 1, function(num)
	globals.set_int(1962546 + 812 + 50 + 3, num)
end)

ui.add_num_option("末日玩家4分红", doom, 0, 500, 1, function(num)
	globals.set_int(1962546 + 812 + 50 + 4, num)
end)

ui.add_click_option("末日三 : 激光破解", doom, function()
		globals.set_local("fm_mission_controller", 1398, 3)
end)

ui.add_click_option("快速完成数据泄漏", doom, function()
		if globals.is_script_active("fm_mission_controller") then
			globals.set_local("fm_mission_controller", 19679, 12)
			globals.set_local("fm_mission_controller", 28299, 99999)
			globals.set_local("fm_mission_controller", 31623, 99999)
	---BY:来源首领任务脚本
			;
		end
	end
)

local cayo = sub_tab("佩里科岛", heist_tab)
local cayo_presets = sub_tab("预设", cayo)
for k, v in ipairs(presets) do
	if v.cayo then
		add_preset(v, cayo_presets)
	end
end

ui.add_click_option("佩里科岛全员135分红", cayo, function()
	globals.set_int(1973321 + 823 + 56+1, 135)
	globals.set_int(1973321 + 823 + 56+2, 135)
	globals.set_int(1973321 + 823 + 56+3, 135)
	globals.set_int(1973321 + 823 + 56+4, 135)
end)

ui.add_num_option("佩里科岛玩家1-4分红", cayo, 0, 500, 1, function(num)
	globals.set_int(1973321 + 823 + 56+1, num)
	globals.set_int(1973321 + 823 + 56+2, num)
	globals.set_int(1973321 + 823 + 56+3, num)
	globals.set_int(1973321 + 823 + 56+4, num)

end)

ui.add_num_option("小岛玩家1分红", cayo, 0, 500, 1, function(num)
	globals.set_int(1973321 + 823 + 56+1, num)
end)

ui.add_num_option("小岛玩家2分红", cayo, 0, 500, 1, function(num)
	globals.set_int(1973321 + 823 + 56+2, num)
end)

ui.add_num_option("小岛玩家3分红", cayo, 0, 500, 1, function(num)
	globals.set_int(1973321 + 823 + 56+3, num)
end)

ui.add_num_option("小岛玩家4分红", cayo, 0, 500, 1, function(num)
	globals.set_int(1973321 + 823 + 56+4, num)
end)

ui.add_click_option("佩里科岛 : 切割格栅", cayo, function()
		globals.set_local("fm_mission_controller_2020", 27500, 6)
end)

ui.add_click_option("佩里科岛 : 指纹复制器", cayo, function()
		globals.set_local("fm_mission_controller_2020", 23385, 5)
end)

ui.add_num_option("修改总收入", cayo, 0, 12000000, 10000, function(num)
		globals.set_local("fm_mission_controller_2020", 43152, num)
end)

ui.add_click_option("快速完成佩里科岛", cayo, function()
		if globals.is_script_active("fm_mission_controller_2020") then
			globals.set_local("fm_mission_controller_2020", 38397, 51338752)
			globals.set_local("fm_mission_controller_2020", 39772, 50) 
		end
end)

local classic = sub_tab("公寓抢劫", heist_tab)
local classic_presets = sub_tab("预设", classic)
for k, v in ipairs(presets) do
	if v.classic then
		add_preset(v, classic_presets)
	end
end

ui.add_num_option("公寓玩家1-4分红", classic, 0, 10000, 1, function(num)
	globals.set_int(1933908 + 3008 + 1, num)
	globals.set_int(1933908 + 3008 + 2, num)
	globals.set_int(1933908 + 3008 + 3, num)
	globals.set_int(1933908 + 3008 + 4, num)
end)

ui.add_num_option("公寓玩家1分红", classic, 0, 10000, 1, function(num)
	globals.set_int(1933908 + 3008 + 1, num)
end)

ui.add_num_option("公寓玩家2分红  (全福改相同)", classic, 0, 10000, 1, function(num)
	globals.set_int(1933908 + 3008 + 2, num)
end)

ui.add_num_option("公寓玩家3分红", classic, 0, 10000, 1, function(num)
	globals.set_int(1933908 + 3008 + 3, num)
end)

ui.add_num_option("公寓玩家4分红", classic, 0, 10000, 1, function(num)
	globals.set_int(1933908 + 3008 + 4, num)
end)

ui.add_click_option("全福银行 : 电路破解", classic, function()
		globals.set_local("fm_mission_controller", 11755, 7)
end)

ui.add_click_option("太平洋 : 破解", classic, function()
		globals.set_local("fm_mission_controller", 146, 7)
end)
ui.add_click_option("快速完成公寓抢劫", classic, function()
		if globals.is_script_active("fm_mission_controller") then
			globals.set_local("fm_mission_controller", 19679, 12)
			globals.set_local("fm_mission_controller", 28299, 99999)
			globals.set_local("fm_mission_controller", 31623, 99999)
	---BY:来源首领任务脚本
			;
		end
	end
)

local contract = sub_tab("合约", heist_tab)
local contract_presets = sub_tab("预设", contract)
for k, v in ipairs(presets) do
	if v.contract then
		add_preset(v, contract_presets)
	end
end

local tuners = sub_tab("车友会", heist_tab)
local tuners_presets = sub_tab("预设", tuners)
for k, v in ipairs(presets) do
	if v.tuners then
		add_preset(v, tuners_presets)
	end
end

ui.add_bool_option("100万收入", tuners, function(val)
	AddOrRemove("车友会 100万", val, function()
		for i = 0, 8 do
			globals.set_int(main + global.tuner.earnings + i, 1000000)
		end
	end)
end)
ui.add_bool_option("移除IA费用", tuners, function(val)
	AddOrRemove("tuners fee", val, function()
		globals.set_int(main + global.tuner.fee[1], 0)
	end)
end)

ui.add_click_option("立即结算改装铺合约", contract, function()
		if globals.is_script_active("fm_mission_controller_2020") then
			globals.set_local("fm_mission_controller_2020", 39772, 102)
			globals.set_local("fm_mission_controller_2020", 38396, 9) 
		end
end)

ui.add_bool_option("移除冷却时间", contract, function(val)
	AddOrRemove("移除冷却时间", val, function()
		for k, v in ipairs(global.contract.cd_hit) do
			globals.set_int(main + v, 0)
		end
		globals.set_int(main + global.contract.cd[1], 0)
		globals.set_int(global.contract.call_cd, 0)
	end)
end)

local cameras = {
	[utils.joaat("prop_cctv_cam_06a")] = true,
	[utils.joaat("prop_cctv_cam_04a")] = true,
	[utils.joaat("prop_cctv_cam_05a")] = true,
	[utils.joaat("prop_cctv_cam_02a")] = true,
	[utils.joaat("prop_cctv_cam_01a")] = true,
	[utils.joaat("prop_cctv_cam_07a")] = true,
	[utils.joaat("prop_cctv_cam_03a")] = true,
	[utils.joaat("prop_cctv_cam_01b")] = true,
	[utils.joaat("prop_cctv_cam_04c")] = true,
	[utils.joaat("prop_cs_cctv")] = true,
	[utils.joaat("hei_prop_bank_cctv_01")] = true,
	[utils.joaat("hei_prop_bank_cctv_02")] = true,
	[utils.joaat("p_cctv_s")] = true,
	[3061645218] = true
}

local other = sub_tab("其他选项", heist_tab)
for k, v in ipairs(presets) do
	if v.qita then
		add_preset(v, other)
	end
end

ui.add_click_option("移除镜头", other, function()
	local objects = entities.get_objects()
	for _, ent in ipairs(objects) do
		local model = ENTITY.GET_ENTITY_MODEL(ent)
		if cameras[model] then
			system.log("镜头", "请求控制镜头 " .. tostring(ent) .. " 带模型 " .. tostring(model))
			entities.request_control(ent, function()
				system.log("镜头", "移除镜头 " .. tostring(ent) .. " 带模型 " .. tostring(model))
				entities.delete(ent)
			end)
		end
	end
end)

ui.add_click_option("传送拾取物到我", other, function()
	local me = PLAYER.PLAYER_PED_ID()
	local pos = ENTITY.GET_ENTITY_COORDS(me, true)
	local pickups = entities.get_pickups()
	for _, ent in pairs(pickups) do
		entities.request_control(ent, function()
			ENTITY.SET_ENTITY_COORDS(ent, pos.x, pos.y, pos.z, false, false, false, false)
		end)
	end
end)

ui.add_bool_option("任务中无限团队生命", other, function(val)
	AddOrRemove("无限团队生命", val, function()
		if globals.is_script_active("fm_mission_controller") then
			globals.set_local("fm_mission_controller", global.casino.lives, 2147483646)
		end
		if globals.is_script_active("fm_mission_controller_2020") then
			globals.set_local("fm_mission_controller_2020", global.cayo.lives, 2147483646)
		end
	end)
end)

local shoul = sub_tab("有待开发", heist_tab)
for k, v in ipairs(presets) do
	if v.shoul then
		add_preset(v, other)
	end
end

ui.add_click_option("Main By:首领", shoul, function()
	system.log("任务Lua","随便搞搞")
end)



while true do
	for k, v in pairs(active_funcs) do
		v()
	end
	system.yield(0)
end