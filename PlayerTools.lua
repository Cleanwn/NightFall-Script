local main_sub = ui.add_player_submenu("Tools")

local function player_exists(pid)
	return NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid)
end

local function generic_player_global(pid)
	return globals.get_int(1893548 + (1 + (pid * 600) + 511))
end

local script_freeze = {}

local script_freeze_bool = ui.add_bool_option("Script freeze", main_sub, function(state)
	script_freeze[online.get_selected_player()] = state
end)

local warehouse = ui.add_click_option("Send to warehouse", main_sub, function()
	online.send_script_event(online.get_selected_player(), -446275082, PLAYER.PLAYER_ID(), 0, 1, math.random(1, 22))
end)

local se_kick = ui.add_click_option("Script event kick", main_sub, function()
	for i = 1, 12 do
		online.send_script_event(online.get_selected_player(), 1228916411, math.random(-1, 1), generic_player_global(online.get_selected_player()))
	end
end)

local host_kick = ui.add_click_option("Host kick", main_sub, function()
	NETWORK.NETWORK_SESSION_KICK_PLAYER(online.get_selected_player())
end)

function on_player_leave(pid)
	script_freeze[pid] = false
end

while true do
	for i = 0, 32 do
		if player_exists and script_freeze[i] then
			online.send_script_event(i, -446275082, PLAYER.PLAYER_ID(), 0, 1, 0)
			system.yield(10)
		end
	end
	system.yield(0)
end