main_sub = ui.add_main_submenu("MG's Hesit Control")

perico_sub = ui.add_submenu("perico")

ui.add_sub_option("perico", main_sub, perico_sub)

casion_sub = ui.add_submenu("casion")

ui.add_sub_option("casion", main_sub, casion_sub)

--------REQUIRE NATIVES----------------------------------------

require '\\MGLUA\\natives-1672190175'
require '\\MGLUA\\natives-1627063482'

--------DEFINE SOME FUNCTION-----------------------------------
        util = utils

        function get_player()
        local index = globals.get_int(1574918)
        if index == 0 then
          return "MP0_"
        else
          return "MP1_"
        end
        end

        function STAT_SET_INT(Stat, Value)
            local index = get_player()
            local hash = index..Stat
            STATS.STAT_SET_INT(util.joaat(hash), Value, true)
        end


        function STAT_SET_FLOAT(Stat, Value)
            local index = get_player()
            local hash = index..Stat
            STATS.STAT_SET_FLOAT(util.joaat(hash), Value, true)
        end


        function STAT_SET_BOOL(Stat, Value)
            local index = get_player()
            local hash = index..Stat
            STATS.STAT_SET_BOOL(util.joaat(hash), Value, true)
        end


        function STAT_SET_STRING(Stat, Value)
            local index = get_player()
            local hash = index..Stat
            STATS.STAT_SET_STRING(util.joaat(hash), Value, true)
        end


        function STAT_SET_DATE(Stat, Year, Month, Day, Hour, Min)
            local DatePTR = memory.alloc(7*8)
            memory.write_int(DatePTR, Year)
            memory.write_int(DatePTR+8, Month)
            memory.write_int(DatePTR+16, Day)
            memory.write_int(DatePTR+24, Hour)
            memory.write_int(DatePTR+32, Min)
            memory.write_int(DatePTR+40, 0) 
            memory.write_int(DatePTR+48, 0) 
            local index = get_player()
            local hash = index..Stat
            STATS.STAT_SET_DATE(util.joaat(hash), DatePTR, 7, true)
        end


        function STAT_SET_MASKED_INT(Stat, Value1, Value2)
            STATS.STAT_SET_MASKED_INT(util.joaat(Stat), Value1, Value2, 8, true)
        end


        function SET_PACKED_STAT_BOOL_CODE(Stat, Value)
            STATS.SET_PACKED_STAT_BOOL_CODE(Stat, Value, util.get_char_slot())
        end


        function STAT_SET_INCREMENT(Stat, Value)
            STATS.STAT_INCREMENT(util.joaat(ADD_MP_INDEX(Stat)), Value, true)
        end


        function STAT_GET_INT(Stat)
            local IntPTR = memory.alloc_int()
            STATS.STAT_GET_INT(util.joaat(ADD_MP_INDEX(Stat)), IntPTR, -1)
            return memory.read_int(IntPTR)
        end


        function STAT_GET_FLOAT(Stat)
            local FloatPTR = memory.alloc_int()
            STATS.STAT_GET_FLOAT(util.joaat(ADD_MP_INDEX(Stat)), FloatPTR, -1)
            return tonumber(string.format("%.3f", memory.read_float(FloatPTR)))
        end


        function STAT_GET_BOOL(Stat)
            if STAT_GET_INT(Stat) == 0 then
                return "false"
            elseif STAT_GET_INT(Stat) == 1 then
                return "true"
            else
                return "STAT_UNKNOWN"
            end 
        end


        function STAT_GET_STRING(Stat)
            return STATS.STAT_GET_STRING(util.joaat(ADD_MP_INDEX(Stat)), -1)
        end


        function STAT_GET_DATE(Stat, Sort)
            local DatePTR = memory.alloc(7*8) -- Thanks for helping memory stuffs, aaronlink127#0127
            STATS.STAT_GET_DATE(util.joaat(ADD_MP_INDEX(Stat)), DatePTR, 7, true)
            local Add = 0
            if Sort == "Years" then
                Add = 0
            elseif Sort == "Months" then
                Add = 8
            elseif Sort == "Days" then
                Add = 16
            elseif Sort == "Hours" then
                Add = 24
            elseif Sort == "Mins" then
                Add = 32
            end
            return memory.read_int(DatePTR+Add)
        end


        function SET_INT_GLOBAL(Global, Value)
            memory.write_int(memory.script_global(Global), Value)
        end
        function SET_FLOAT_GLOBAL(Global, Value)
            memory.write_float(memory.script_global(Global), Value)
        end


        function GET_INT_GLOBAL(Global)
            return memory.read_int(memory.script_global(Global))
        end


        function SET_PACKED_INT_GLOBAL(StartGlobal, EndGlobal, Value)
            for i = StartGlobal, EndGlobal do
                SET_INT_GLOBAL(262145 + i, Value)
            end
        end


        function SET_INT_LOCAL(Script, Local, Value)
            if memory.script_local(Script, Local) ~= 0 then
                memory.write_int(memory.script_local(Script, Local), Value)
            end
        end

        function SET_FLOAT_LOCAL(Script, Local, Value)
            if memory.script_local(Script, Local) ~= 0 then
                memory.write_float(memory.script_local(Script, Local), Value)
            end
        end


        function GET_INT_LOCAL(Script, Local)
            if memory.script_local(Script, Local) ~= 0 then
                local Value = memory.read_int(memory.script_local(Script, Local))
                if Value ~= nil then
                    return Value
                end
            end
        end

-------STAR ----------------------------------------


ui.add_separator("one player",perico_sub)

ui.add_click_option("Sapphire Panther", perico_sub, function ()
	            STAT_SET_INT("H4CNF_BOLTCUT", -1)
                STAT_SET_INT("H4CNF_UNIFORM", -1)
                STAT_SET_INT("H4CNF_GRAPPEL", -1)
                STAT_SET_INT("H4_MISSIONS", -1)
                STAT_SET_INT("H4CNF_WEAPONS", 1)
                STAT_SET_INT("H4CNF_TROJAN", 5)
                STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 100)
                STAT_SET_INT("H4CNF_TARGET", 5)
                STAT_SET_INT("H4LOOT_CASH_I", 5551206)
                STAT_SET_INT("H4LOOT_CASH_I_SCOPED", 5551206)
                STAT_SET_INT("H4LOOT_CASH_C", 0)
                STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 0)
                STAT_SET_INT("H4LOOT_COKE_I", 4884838)
                STAT_SET_INT("H4LOOT_COKE_I_SCOPED", 4884838)
                STAT_SET_INT("H4LOOT_COKE_C", 0)
                STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 0)
                STAT_SET_INT("H4LOOT_GOLD_I", 0)
                STAT_SET_INT("H4LOOT_GOLD_I_SCOPED", 0)
                STAT_SET_INT("H4LOOT_GOLD_C", 192)
                STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 192)
                STAT_SET_INT("H4LOOT_WEED_I", 0)
                STAT_SET_INT("H4LOOT_WEED_I_SCOPED", 0)
                STAT_SET_INT("H4LOOT_WEED_C", 0)
                STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 0)
                STAT_SET_INT("H4LOOT_PAINT", 120)
                STAT_SET_INT("H4LOOT_PAINT_SCOPED", 120)
                STAT_SET_INT("H4LOOT_CASH_V", 224431)
                STAT_SET_INT("H4LOOT_COKE_V", 353863)
                STAT_SET_INT("H4LOOT_GOLD_V", 471817)
                STAT_SET_INT("H4LOOT_PAINT_V", 353863)
                STAT_SET_INT("H4LOOT_WEED_V", 0)
                STAT_SET_INT("H4_PROGRESS", 131055)
                STAT_SET_INT("H4CNF_BS_GEN", -1)
                STAT_SET_INT("H4CNF_BS_ENTR", -1)
                STAT_SET_INT("H4CNF_BS_ABIL", -1)
                STAT_SET_INT("H4CNF_WEP_DISRP", 3)
                STAT_SET_INT("H4CNF_ARM_DISRP", 3)
                STAT_SET_INT("H4CNF_HEL_DISRP", 3)
                STAT_SET_INT("H4CNF_APPROACH", -1)
end
)

ui.add_click_option("Ruby Necklace", perico_sub, function ()
                STAT_SET_INT("H4CNF_TARGET", 1)
                STAT_SET_INT("H4LOOT_CASH_I", 9208137)
                STAT_SET_INT("H4LOOT_CASH_I_SCOPED", 9208137)
                STAT_SET_INT("H4LOOT_CASH_C", 0)
                STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 0)
                STAT_SET_INT("H4LOOT_COKE_I", 1048704)
                STAT_SET_INT("H4LOOT_COKE_I_SCOPED", 1048704)
                STAT_SET_INT("H4LOOT_COKE_C", 0)
                STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 0)
                STAT_SET_INT("H4LOOT_GOLD_I", 0)
                STAT_SET_INT("H4LOOT_GOLD_I_SCOPED", 0)
                STAT_SET_INT("H4LOOT_GOLD_C", 255)
                STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 255)
                STAT_SET_INT("H4LOOT_WEED_I", 4206596)
                STAT_SET_INT("H4LOOT_WEED_I_SCOPED", 4206596)
                STAT_SET_INT("H4LOOT_WEED_C", 0)
                STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 0)
                STAT_SET_INT("H4LOOT_PAINT", 127)
                STAT_SET_INT("H4LOOT_PAINT_SCOPED", 127)
                STAT_SET_INT("H4LOOT_CASH_V", 424431)
                STAT_SET_INT("H4LOOT_COKE_V", 848863)
                STAT_SET_INT("H4LOOT_GOLD_V", 1131817)
                STAT_SET_INT("H4LOOT_PAINT_V", 848863)
                STAT_SET_INT("H4LOOT_WEED_V", 679090)
                STAT_SET_INT("H4_PROGRESS", 131055)
                STAT_SET_INT("H4CNF_BS_GEN", 262143)
                STAT_SET_INT("H4CNF_BS_ENTR", 63)
                STAT_SET_INT("H4CNF_BS_ABIL", 63)
                STAT_SET_INT("H4CNF_WEP_DISRP", 3)
                STAT_SET_INT("H4CNF_ARM_DISRP", 3)
                STAT_SET_INT("H4CNF_HEL_DISRP", 3)
                STAT_SET_INT("H4CNF_APPROACH", -1)
                STAT_SET_INT("H4CNF_BOLTCUT", 4424)
                STAT_SET_INT("H4CNF_UNIFORM", 5256)
                STAT_SET_INT("H4CNF_GRAPPEL", 5156)
                STAT_SET_INT("H4_MISSIONS", -1)
                STAT_SET_INT("H4CNF_WEAPONS", 1)
                STAT_SET_INT("H4CNF_TROJAN", 5)
                STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 100)
end
)

ui.add_separator("two players",perico_sub)

ui.add_click_option("Sapphire Panther", perico_sub, function ()
                STAT_SET_INT("H4CNF_BOLTCUT", 4424)
                STAT_SET_INT("H4CNF_UNIFORM", 5256)
                STAT_SET_INT("H4CNF_GRAPPEL", 5156)
                STAT_SET_INT("H4_MISSIONS", -1)
                STAT_SET_INT("H4CNF_WEAPONS", 1)
                STAT_SET_INT("H4CNF_TROJAN", 5)
                STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 100)
                STAT_SET_INT("H4CNF_TARGET", 5)
                STAT_SET_INT("H4LOOT_CASH_I", 2359448)
                STAT_SET_INT("H4LOOT_CASH_I_SCOPED", 2359448)
                STAT_SET_INT("H4LOOT_CASH_C", 0)
                STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 0)
                STAT_SET_INT("H4LOOT_COKE_I", 2)
                STAT_SET_INT("H4LOOT_COKE_I_SCOPED", 2)
                STAT_SET_INT("H4LOOT_COKE_C", 0)
                STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 0)
                STAT_SET_INT("H4LOOT_GOLD_I", 0)
                STAT_SET_INT("H4LOOT_GOLD_I_SCOPED", 0)
                STAT_SET_INT("H4LOOT_GOLD_C", 255)
                STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 255)
                STAT_SET_INT("H4LOOT_WEED_I", 0)
                STAT_SET_INT("H4LOOT_WEED_I_SCOPED", 0)
                STAT_SET_INT("H4LOOT_WEED_C", 0)
                STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 0)
                STAT_SET_INT("H4LOOT_PAINT", 127)
                STAT_SET_INT("H4LOOT_PAINT_SCOPED", 127)
                STAT_SET_INT("H4LOOT_CASH_V", 474431)
                STAT_SET_INT("H4LOOT_COKE_V", 948863)
                STAT_SET_INT("H4LOOT_GOLD_V", 1265151)
                STAT_SET_INT("H4LOOT_PAINT_V", 948863)
                STAT_SET_INT("H4LOOT_WEED_V", 0)
                STAT_SET_INT("H4_PROGRESS", 126823)
                STAT_SET_INT("H4CNF_BS_GEN", 262143)
                STAT_SET_INT("H4CNF_BS_ENTR", 63)
                STAT_SET_INT("H4CNF_BS_ABIL", 63)
                STAT_SET_INT("H4CNF_WEP_DISRP", 3)
                STAT_SET_INT("H4CNF_ARM_DISRP", 3)
                STAT_SET_INT("H4CNF_HEL_DISRP", 3)
                STAT_SET_INT("H4CNF_APPROACH", -1)
end
)

ui.add_click_option("Ruby Necklace", perico_sub, function ()
                STAT_SET_INT("H4CNF_TARGET", 1)
                STAT_SET_INT("H4LOOT_CASH_I", 9208137)
                STAT_SET_INT("H4LOOT_CASH_I_SCOPED", 9208137)
                STAT_SET_INT("H4LOOT_CASH_C", 0)
                STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 0)
                STAT_SET_INT("H4LOOT_COKE_I", 1048704)
                STAT_SET_INT("H4LOOT_COKE_I_SCOPED", 1048704)
                STAT_SET_INT("H4LOOT_COKE_C", 0)
                STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 0)
                STAT_SET_INT("H4LOOT_GOLD_I", 0)
                STAT_SET_INT("H4LOOT_GOLD_I_SCOPED", 0)
                STAT_SET_INT("H4LOOT_GOLD_C", 255)
                STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 255)
                STAT_SET_INT("H4LOOT_WEED_I", 4206596)
                STAT_SET_INT("H4LOOT_WEED_I_SCOPED", 4206596)
                STAT_SET_INT("H4LOOT_WEED_C", 0)
                STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 0)
                STAT_SET_INT("H4LOOT_PAINT", 127)
                STAT_SET_INT("H4LOOT_PAINT_SCOPED", 127)
                STAT_SET_INT("H4LOOT_CASH_V", 572727)
                STAT_SET_INT("H4LOOT_COKE_V", 1145454)
                STAT_SET_INT("H4LOOT_GOLD_V", 1527272)
                STAT_SET_INT("H4LOOT_PAINT_V", 1145454)
                STAT_SET_INT("H4LOOT_WEED_V", 916363)
                STAT_SET_INT("H4_PROGRESS", 126823)
                STAT_SET_INT("H4CNF_BS_GEN", 262143)
                STAT_SET_INT("H4CNF_BS_ENTR", 63)
                STAT_SET_INT("H4CNF_BS_ABIL", 63)
                STAT_SET_INT("H4CNF_WEP_DISRP", 3)
                STAT_SET_INT("H4CNF_ARM_DISRP", 3)
                STAT_SET_INT("H4CNF_HEL_DISRP", 3)
                STAT_SET_INT("H4CNF_APPROACH", -1)
                STAT_SET_INT("H4CNF_BOLTCUT", 4424)
                STAT_SET_INT("H4CNF_UNIFORM", 5256)
                STAT_SET_INT("H4CNF_GRAPPEL", 5156)
                STAT_SET_INT("H4_MISSIONS", -1)
                STAT_SET_INT("H4CNF_WEAPONS", 1)
                STAT_SET_INT("H4CNF_TROJAN", 5)
                STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 100)
end
)

ui.add_separator("three players",perico_sub)

ui.add_click_option("Sapphire Panther", perico_sub, function ()
                STAT_SET_INT("H4CNF_BOLTCUT", 4424)
                STAT_SET_INT("H4CNF_UNIFORM", 5256)
                STAT_SET_INT("H4CNF_GRAPPEL", 5156)
                STAT_SET_INT("H4_MISSIONS", -1)
                STAT_SET_INT("H4CNF_WEAPONS", 1)
                STAT_SET_INT("H4CNF_TROJAN", 5)
                STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 100)
                STAT_SET_INT("H4CNF_TARGET", 5)
                STAT_SET_INT("H4LOOT_CASH_I", 2359448)
                STAT_SET_INT("H4LOOT_CASH_I_SCOPED", 2359448)
                STAT_SET_INT("H4LOOT_CASH_C", 0)
                STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 0)
                STAT_SET_INT("H4LOOT_COKE_I", 4901222)
                STAT_SET_INT("H4LOOT_COKE_I_SCOPED", 4901222)
                STAT_SET_INT("H4LOOT_COKE_C", 0)
                STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 0)
                STAT_SET_INT("H4LOOT_GOLD_I", 0)
                STAT_SET_INT("H4LOOT_GOLD_I_SCOPED", 0)
                STAT_SET_INT("H4LOOT_GOLD_C", 255)
                STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 255)
                STAT_SET_INT("H4LOOT_WEED_I", 0)
                STAT_SET_INT("H4LOOT_WEED_I_SCOPED", 0)
                STAT_SET_INT("H4LOOT_WEED_C", 0)
                STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 0)
                STAT_SET_INT("H4LOOT_PAINT", 127)
                STAT_SET_INT("H4LOOT_PAINT_SCOPED", 127)
                STAT_SET_INT("H4LOOT_CASH_V", 515151)
                STAT_SET_INT("H4LOOT_COKE_V", 1030303)
                STAT_SET_INT("H4LOOT_GOLD_V", 1373737)
                STAT_SET_INT("H4LOOT_PAINT_V", 1030303)
                STAT_SET_INT("H4LOOT_WEED_V", 0)
                STAT_SET_INT("H4_PROGRESS", 126823)
                STAT_SET_INT("H4CNF_BS_GEN", 262143)
                STAT_SET_INT("H4CNF_BS_ENTR", 63)
                STAT_SET_INT("H4CNF_BS_ABIL", 63)
                STAT_SET_INT("H4CNF_WEP_DISRP", 3)
                STAT_SET_INT("H4CNF_ARM_DISRP", 3)
                STAT_SET_INT("H4CNF_HEL_DISRP", 3)
                STAT_SET_INT("H4CNF_APPROACH", -1)
end
)

ui.add_click_option("Ruby Necklace", perico_sub, function ()
                STAT_SET_INT("H4CNF_TARGET", 1)
                STAT_SET_INT("H4LOOT_CASH_I", 9208137)
                STAT_SET_INT("H4LOOT_CASH_I_SCOPED", 9208137)
                STAT_SET_INT("H4LOOT_CASH_C", 0)
                STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 0)
                STAT_SET_INT("H4LOOT_COKE_I", 1048704)
                STAT_SET_INT("H4LOOT_COKE_I_SCOPED", 1048704)
                STAT_SET_INT("H4LOOT_COKE_C", 0)
                STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 0)
                STAT_SET_INT("H4LOOT_GOLD_I", 0)
                STAT_SET_INT("H4LOOT_GOLD_I_SCOPED", 0)
                STAT_SET_INT("H4LOOT_GOLD_C", 255)
                STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 255)
                STAT_SET_INT("H4LOOT_WEED_I", 4206596)
                STAT_SET_INT("H4LOOT_WEED_I_SCOPED", 4206596)
                STAT_SET_INT("H4LOOT_WEED_C", 0)
                STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 0)
                STAT_SET_INT("H4LOOT_PAINT", 127)
                STAT_SET_INT("H4LOOT_PAINT_SCOPED", 127)
                STAT_SET_INT("H4LOOT_CASH_V", 598268)
                STAT_SET_INT("H4LOOT_COKE_V", 1196536)
                STAT_SET_INT("H4LOOT_GOLD_V", 1595382)
                STAT_SET_INT("H4LOOT_PAINT_V", 1196536)
                STAT_SET_INT("H4LOOT_WEED_V", 957229)
                STAT_SET_INT("H4_PROGRESS", 126823)
                STAT_SET_INT("H4CNF_BS_GEN", 262143)
                STAT_SET_INT("H4CNF_BS_ENTR", 63)
                STAT_SET_INT("H4CNF_BS_ABIL", 63)
                STAT_SET_INT("H4CNF_WEP_DISRP", 3)
                STAT_SET_INT("H4CNF_ARM_DISRP", 3)
                STAT_SET_INT("H4CNF_HEL_DISRP", 3)
                STAT_SET_INT("H4CNF_APPROACH", -1)
                STAT_SET_INT("H4CNF_BOLTCUT", 4424)
                STAT_SET_INT("H4CNF_UNIFORM", 5256)
                STAT_SET_INT("H4CNF_GRAPPEL", 5156)
                STAT_SET_INT("H4_MISSIONS", -1)
                STAT_SET_INT("H4CNF_WEAPONS", 1)
                STAT_SET_INT("H4CNF_TROJAN", 5)
                STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 100)
end
)

ui.add_separator("four players",perico_sub)

ui.add_click_option("Sapphire Panther", perico_sub, function ()
                STAT_SET_INT("H4CNF_TARGET", 5)
                STAT_SET_INT("H4LOOT_CASH_I", 2359448)
                STAT_SET_INT("H4LOOT_CASH_I_SCOPED", 2359448)
                STAT_SET_INT("H4LOOT_CASH_C", 0)
                STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 0)
                STAT_SET_INT("H4LOOT_COKE_I", 4901222)
                STAT_SET_INT("H4LOOT_COKE_I_SCOPED", 4901222)
                STAT_SET_INT("H4LOOT_COKE_C", 0)
                STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 0)
                STAT_SET_INT("H4LOOT_GOLD_I", 0)
                STAT_SET_INT("H4LOOT_GOLD_I_SCOPED", 0)
                STAT_SET_INT("H4LOOT_GOLD_C", 255)
                STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 255)
                STAT_SET_INT("H4LOOT_WEED_I", 0)
                STAT_SET_INT("H4LOOT_WEED_I_SCOPED", 0)
                STAT_SET_INT("H4LOOT_WEED_C", 0)
                STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 0)
                STAT_SET_INT("H4LOOT_PAINT", 127)
                STAT_SET_INT("H4LOOT_PAINT_SCOPED", 127)
                STAT_SET_INT("H4LOOT_CASH_V", 599431)
                STAT_SET_INT("H4LOOT_COKE_V", 1198863)
                STAT_SET_INT("H4LOOT_GOLD_V", 1598484)
                STAT_SET_INT("H4LOOT_PAINT_V", 1198863)
                STAT_SET_INT("H4LOOT_WEED_V", 0)
                STAT_SET_INT("H4_PROGRESS", 126823)
                STAT_SET_INT("H4CNF_BS_GEN", 262143)
                STAT_SET_INT("H4CNF_BS_ENTR", 63)
                STAT_SET_INT("H4CNF_BS_ABIL", 63)
                STAT_SET_INT("H4CNF_WEP_DISRP", 3)
                STAT_SET_INT("H4CNF_ARM_DISRP", 3)
                STAT_SET_INT("H4CNF_HEL_DISRP", 3)
                STAT_SET_INT("H4CNF_APPROACH", -1)
                STAT_SET_INT("H4CNF_BOLTCUT", 4424)
                STAT_SET_INT("H4CNF_UNIFORM", 5256)
                STAT_SET_INT("H4CNF_GRAPPEL", 5156)
                STAT_SET_INT("H4_MISSIONS", -1)
                STAT_SET_INT("H4CNF_WEAPONS", 1)
                STAT_SET_INT("H4CNF_TROJAN", 5)
                STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 100)
end
)

ui.add_click_option("Ruby Necklace", perico_sub, function ()
                STAT_SET_INT("H4CNF_TARGET", 1)
                STAT_SET_INT("H4LOOT_CASH_I", 9208137)
                STAT_SET_INT("H4LOOT_CASH_I_SCOPED", 9208137)
                STAT_SET_INT("H4LOOT_CASH_C", 0)
                STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 0)
                STAT_SET_INT("H4LOOT_COKE_I", 1048704)
                STAT_SET_INT("H4LOOT_COKE_I_SCOPED", 1048704)
                STAT_SET_INT("H4LOOT_COKE_C", 0)
                STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 0)
                STAT_SET_INT("H4LOOT_GOLD_I", 0)
                STAT_SET_INT("H4LOOT_GOLD_I_SCOPED", 0)
                STAT_SET_INT("H4LOOT_GOLD_C", 255)
                STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 255)
                STAT_SET_INT("H4LOOT_WEED_I", 4206596)
                STAT_SET_INT("H4LOOT_WEED_I_SCOPED", 4206596)
                STAT_SET_INT("H4LOOT_WEED_C", 0)
                STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 0)
                STAT_SET_INT("H4LOOT_PAINT", 127)
                STAT_SET_INT("H4LOOT_PAINT_SCOPED", 127)
                STAT_SET_INT("H4LOOT_CASH_V", 655681)
                STAT_SET_INT("H4LOOT_COKE_V", 1311363)
                STAT_SET_INT("H4LOOT_GOLD_V", 1748484)
                STAT_SET_INT("H4LOOT_PAINT_V", 1311363)
                STAT_SET_INT("H4LOOT_WEED_V", 1049090)
                STAT_SET_INT("H4_PROGRESS", 126823)
                STAT_SET_INT("H4CNF_BS_GEN", 262143)
                STAT_SET_INT("H4CNF_BS_ENTR", 63)
                STAT_SET_INT("H4CNF_BS_ABIL", 63)
                STAT_SET_INT("H4CNF_WEP_DISRP", 3)
                STAT_SET_INT("H4CNF_ARM_DISRP", 3)
                STAT_SET_INT("H4CNF_HEL_DISRP", 3)
                STAT_SET_INT("H4CNF_APPROACH", -1)
                STAT_SET_INT("H4CNF_BOLTCUT", 4424)
                STAT_SET_INT("H4CNF_UNIFORM", 5256)
                STAT_SET_INT("H4CNF_GRAPPEL", 5156)
                STAT_SET_INT("H4_MISSIONS", -1)
                STAT_SET_INT("H4CNF_WEAPONS", 1)
                STAT_SET_INT("H4CNF_TROJAN", 5)
                STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 100)

end
)

ui.add_separator("other",perico_sub)

ui.add_click_option("Skip The Hacking Process", perico_sub, function ()
   globals.set_local("fm_mission_controller_2020", 22032, 5)
end
)

ui.add_click_option("Skip Cutting The Sewer Grill", perico_sub, function ()
   globals.set_local("fm_mission_controller_2020", 26746, 6)
end
)

ui.add_click_option("Skip Cutting The Glass", perico_sub, function ()
   globals.set_local("fm_mission_controller_2020", 27985 + 3, 0)
end
)

ui.add_click_option("Infinite Plasma Cutter Heat", perico_sub, function ()
   globals.set_local("fm_mission_controller_2020", 27985 + 4, 0)
end
)

ui.add_click_option("Infinite Voltage Timer", perico_sub, function ()
   globals.set_local("fm_mission_controller_2020", 1717, 0)
end
)

ui.add_click_option("Remove The Fencing Fee And Pavel's Cut", perico_sub, function ()
   globals.set_float(262145 + 29991, 0)
   globals.set_float(262145 + 29992, 1)
   globals.set_float(262145 + 29991, -0.1)
   globals.set_float(262145 + 29992, -0.02)
end
)

ui.add_click_option("Obtain The Primary Target", perico_sub, function( )
	globals.set_local("fm_mission_controller_2020", 27984, 5)
	globals.set_local("fm_mission_controller_2020", 27985, 3)
end
)

ui.add_click_option("Remove The Drainage Pipe", perico_sub, function ()
            local hash = -1297635988
            for _, ent in pairs(entities.get_all_objects()) do
                if ENTITY.GET_ENTITY_MODEL(ent) == Hash then
                    entities.delete(ent)
                end
            end
end
)

system.notify("loading successful!", 0, 255, 0, 255)

while true do 
system.yield(10)
end


-----------I WILL UPDATE THIS SCRIPT AS SOON AS POSSIBLE---------------------------------------------
--
-- FOR TRANSLATER:
-- DO NOT ADD YOUR ANY INFOR INTO THIS SCRIPT, PLEASE RESPECT ME
