
local boostForce = 0.5
local speedLimit  = 250

local controls = {
    W = 32`,
    S = 33,
    D = 35,
	A = 34,
	X = 357,
	E = 86,
	arrowLeft = 308,
	arrowRight = 307,
    SHIFT = 21,
	SPACE = 22
}



function isControlPressed(ID)
	return PAD.IS_CONTROL_PRESSED(1, ID) == 1
end

function isPedAnyVehicle(includeLast)
	return PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), includeLast)
end

function getLocalVehicle(includeLast)
	return PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), includeLast)
end

function getVehicleSpeed(speedType)
	return math.floor(ENTITY.GET_ENTITY_SPEED(getLocalVehicle(false)) * (speed_type == "kmh" and 3.6 or (speed_type == "mph" and 2.2369 or 0)))
end

function boostVehicle(keyID)
	if isPedAnyVehicle(false) == 1 and isControlPressed(keyID) and getVehicleSpeed("kmh") < speedLimit then
		ENTITY.APPLY_FORCE_TO_ENTITY(getLocalVehicle(false), 1, 0, boostForce, 0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
	end
end

while true do
	boostVehicle(controls.X)
    system.yield()
end