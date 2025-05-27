local main_sub = ui.add_main_submenu("Stats spoofer")

function set_info_global(pid, value, id)
   	local global_info = globals.get_int(globals.at(1853128, pid, 888) + 205 + id)
   	globals.set_int(global_info, value)
end

local rank_spoof = false
local rank_spoof_int = 0

function on_rank_spoof()
   rank_spoof = not rank_spoof
end
function on_rank_input(var)
   rank_spoof_int = var
end

local money_spoof = false
local money_spoof_int = 0
function on_money_spoof()
   money_spoof = not money_spoof
end
function on_money_input(var)
   money_spoof_int = var
end

local kills_spoof = false
local kills_spoof_int = 0
function on_kills_spoof()
   kills_spoof = not kills_spoof
end
function on_kills_input(var)
   kills_spoof_int = var
end

local deaths_spoof = false
local deaths_spoof_int = 0
function on_deaths_spoof()
   deaths_spoof = not deaths_spoof
end
function on_deaths_input(var)
   deaths_spoof_int = var
end

ui.add_bool_option("Rank spoof", main_sub, on_rank_spoof)
ui.add_num_option("Rank", main_sub, -2147483648, 2147483647, 1, on_rank_input)

ui.add_separator("Money", main_sub)
ui.add_bool_option("Money spoof", main_sub, on_money_spoof)
ui.add_num_option("Money", main_sub, -2147483648, 2147483647, 1, on_money_input)

ui.add_separator("Kills", main_sub)
ui.add_bool_option("Kills spoof", main_sub, on_kills_spoof)
ui.add_num_option("Kills", main_sub, -2147483648, 2147483647, 1, on_kills_input)

ui.add_separator("Deaths", main_sub)
ui.add_bool_option("Deaths spoof", main_sub, on_deaths_spoof)
ui.add_num_option("Deaths", main_sub, -2147483648, 2147483647, 1, on_deaths_input)

function tick()
	if NETWORK.NETWORK_IS_SESSION_STARTED() == 1 then
		local local_id = PLAYER.PLAYER_ID()
		if rank_spoof then
			set_info_global(local_id, rank_spoof_int, 6)
		end
		if money_spoof then
			set_info_global(local_id, money_spoof_int, 56)
		end
		if kills_spoof then
			set_info_global(local_id, kills_spoof_int, 28)
		end
		if deaths_spoof then
			set_info_global(local_id, deaths_spoof_int, 29)
		end
	end
end

while true do
	tick()
    system.yield(0)
end