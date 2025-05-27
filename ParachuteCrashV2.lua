local pile_of_shit = -2071359746
local yield = system.yield

while true do
	while not STREAMING.HAS_MODEL_LOADED(pile_of_shit) do
		STREAMING.REQUEST_MODEL(pile_of_shit)
		yield(10)
	end
	PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(), pile_of_shit)
	yield(0)
end