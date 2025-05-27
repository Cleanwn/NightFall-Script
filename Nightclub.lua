main_sub = ui.add_main_submenu("夜总会恢复选项")

function get_last_char()
    local pArg = memory.malloc(4)
    STATS.STAT_GET_INT(utils.joaat("MPPLY_LAST_MP_CHAR"), pArg, -1)
    local char = memory.read_int(pArg)
    memory.free(pArg)
    return tostring(char)
end

local n = "MP" .. get_last_char()

ui.add_click_option("使用教学", main_sub, function()
    system.notify("夜总会刷钱", "买一个夜总会\n设置好你的夜总会\n把前置做完\n进去夜总会\n使用“传送到保险箱”\n打开保险箱\n打开夜总会循坏刷钱开关\n不要一次刷太多", 13, 37, 28, 255)
end)

ui.add_click_option("传送到保险箱", main_sub, function()
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), -1615.6827392578, -3015.6813964844, -75.205070495605, false, false, false)
end)

loop = ui.add_bool_option("夜总会循坏刷钱开关", main_sub, function(state)
    system.notify("夜总会刷钱", "风险自负!", 13, 37, 28, 255)
    globals.set_int(262145+23112 , 133377)
end)

local startTime = os.time()

while true do
    if ui.get_value(loop) and os.time() - startTime >= 8 then
        globals.set_int(262145 + 24073, 300000) -- KEEP AT 300000 OR YOU WILL NEED TO DELETE & RE-MAKE YOUR CHARACTER, IT WILL BUG THE NIGHTCLUB SAFE!
        globals.set_int(262145 + 24069, 300000) -- KEEP AT 300000 OR YOU WILL NEED TO DELETE & RE-MAKE YOUR CHARACTER, IT WILL BUG THE NIGHTCLUB SAFE!
        STATS.STAT_SET_INT(utils.joaat(n .. "_CLUB_POPULARITY"), 10000, true)
        STATS.STAT_SET_INT(utils.joaat(n .. "_CLUB_PAY_TIME_LEFT"), -1, true)
        STATS.STAT_SET_INT(utils.joaat(n .. "_CLUB_POPULARITY"), 100000, true)
        startTime = os.time()
    end
    system.yield()
end