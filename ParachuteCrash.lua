
local umbrella = 3315065500
local yield = system.yield

while true do
	while not STREAMING.HAS_MODEL_LOADED(umbrella) do
		STREAMING.REQUEST_MODEL(umbrella)
		yield(10)
	end
	if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), 0) then
		VEHICLE._SET_VEHICLE_PARACHUTE_MODEL(PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), 0), umbrella)
	end
	yield(0)
end