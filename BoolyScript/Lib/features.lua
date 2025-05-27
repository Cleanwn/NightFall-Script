local features = {}

local callbacks = require '\\BoolyScript\\Lib\\callbacks'

local dlcNames = {
    ["TitleUpdate"] = "GTA V Release",
    ["mpchristmas2017"] = "[1.42] The Doomsday Heist",
    ["mpheist4"] = "[1.53] The Cayo Perico Heist",
    ["mpbusiness"] = "[1.11] Business Update",
    ["mpsmuggler"] = "[1.41] Smuggler's Run",
    ["mpgunrunning"] = "[1.40] Gunrunning",
    ["mpg9ec"] = "[1.59/1.60] Next Gen Update",
    ["mpheist3"] = "[1.49] The Diamond Casino Heist",
    ["mpsecurity"] = "[1.55/1.58] The Contract",
    ["mpbiker"] = "[1.36] Bikers",
    ["mpapartment"] = "[1.31] Executives and Other",
    ["mpjanuary2016"] = "[1.32] January 2016",
    ["mppilot"] = "[1.16] San Andreas Flight School",
    ["mpexecutive"] = "[1.34] Further Adventures",
    ["mpstunt"] = "[1.35] Cunning Stunts",
    ["mpbeach"] = "[1.06] Beach Bum Update",
    ["mphipster"] = "[1.14] I'm Not a Hipster",
    ["mpimportexport"] = "[1.37] Import/Export",
    ["spupgrade"] = "Enhanced Edition Release",
    ["mpbattle"] = "[1.44] After Hours Update",
    ["mpheist"] = "[1.21] Heists Update",
    ["mpluxe2"] = "[1.28] Ill-Gotten Gains Part 2",
    ["mpsum2"] = "[1.61] The Criminal Enterprises",
    ["mpchristmas2018"] = "[1.46] Arena War",
    ["mpvalentines"] = "[1.32x] Be My Valentine ",
    ["mphalloween"] = "Surprise Halloween",
    ["mptuner"] = "[1.54/1.57] Los Santos Tuners",
    ["mpassault"] = "[1.43] Southern SA SSS",
    ["mpvinewood"] = "[1.47/1.48] The Diamond Casino",
    ["mplowrider"] = "[1.30] Lowriders",
    ["mpsum"] = "[1.52] LS Summer Special",
    ["mplowrider2"] = "[1.33] Lowriders 2",
    ["mpluxe"] = "[1.27] Ill-Gotten Gains Part 1",
    ["mpspecialraces"] = "[1.38] Cunning Stunts",
    ["mplts"] = "[1.17] Last Team Standing Update",
    ["mpbusiness2"] = "[1.13] High Life Update",
    ["mpchristmas2"] = "[1.19] Festive Surprise",
    ["mpindependence"] = "[1.15] Independence Day",
    ["mpxmas_604490"] = "[1.31x] Festive Surprise"
}

function features.getScriptPath()
    local str = debug.getinfo(2, "S").source:sub(2)
	return str:match("(.*[/\\])")
end


function features.doesFileExist(file)
	local ok, err, code = os.rename(file, file)
	if not ok then
	   if code == 13 then
		  return true
	   end
	end
	return ok, err
end

function features.doesFolderExist(path)
	return features.doesFileExist(path.."/")
 end

function features.note(text)
	system.notify("Note", tostring(text), 51, 102, 153, 255)
end

function features.alert(text)
	system.notify("Alert", tostring(text), 255, 0, 0, 255)
	system.log("Alert", tostring(text))
end

function features.notify(text)
	system.notify("BoolyScript", tostring(text), 105, 19, 55, 255)
	system.log("BoolyScript", tostring(text))
end

function features.getEntityCoords(entity)
    return ENTITY.GET_ENTITY_COORDS(entity, true)
end

function features.getPlayerVehicle(ply, includeLast)
	return PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(ply), includeLast)
end

function features.getLocalVehicle(includeLast)
	return PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), includeLast)
end

function features.getPlayerPed(ply)
	return PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(ply)
end

local activeSubs = {}

function features.addSubmenu(str_name, int_subID)
    local sub = {}
    sub.submenu = ui.add_submenu(str_name)
    sub.option = ui.add_sub_option(str_name, int_subID, sub.submenu)
	activeSubs[str_name] = sub.option
    return sub
end

function features.getActiveSubs()
	return activeSubs
end

function features.addBlipForEntity(entity, blipSprite, colour)
	local blip = HUD.ADD_BLIP_FOR_ENTITY(entity)
	HUD.SET_BLIP_SPRITE(blip, blipSprite)
	HUD.SET_BLIP_COLOUR(blip, colour)
	HUD.SHOW_HEIGHT_ON_BLIP(blip, false)
	HUD.SET_BLIP_ROTATION(blip, math.ceil(ENTITY.GET_ENTITY_HEADING(entity)))
	NETWORK.SET_NETWORK_ID_CAN_MIGRATE(entity, false)
	return blip
end

function features.playerExists(pid)
    return (NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 1)
end

function features.getWaypointCoords()
	if not HUD.IS_WAYPOINT_ACTIVE() then return end
    local blip = HUD.GET_FIRST_BLIP_INFO_ID(8)
    return HUD.GET_BLIP_COORDS(blip)
end

function features.SECrash(ply)
	online.send_script_event(ply, -555356783, 2000000, 2000000, 2000000, 2000000)
end

function features.SEKick(ply)
	online.send_script_event(online.get_selected_player(), 111242367, online.get_selected_player(), -210634234) 
end

function features.getDistance(coords1, coords2, useZ)
    return MISC.GET_DISTANCE_BETWEEN_COORDS(coords1.x, coords1.y, coords1.z, coords2.x, coords2.y, coords2.z, useZ)
end

function features.drawLineToPlayer(ply, color)
	local localCoords = features.getEntityCoords(PLAYER.PLAYER_PED_ID())
	local plyCoords = features.getEntityCoords(features.getPlayerPed(ply))
	GRAPHICS.DRAW_LINE(localCoords.x, localCoords.y, localCoords.z, plyCoords.x, plyCoords.y, plyCoords.z, color.red, color.green, color.blue, color.alpha)
end

function features.drawBoxOnPlayer(ply, color)
	local offset_x = 0.3
	local offset_z = 1.1
	local plyCoords = features.getEntityCoords(features.getPlayerPed(ply))
	local right_down_ang = {
		["x"] = plyCoords.x+offset_x,
		["y"] = plyCoords.y,
		["z"] = plyCoords.z-offset_z
	}
	local right_up_ang = {
		["x"] = plyCoords.x+offset_x,
		["y"] = plyCoords.y,
		["z"] = plyCoords.z+offset_z
	}
	local left_down_ang = {
		["x"] = plyCoords.x-offset_x,
		["y"] = plyCoords.y,
		["z"] = plyCoords.z-offset_z
	}
	local left_up_ang = {
		["x"] = plyCoords.x-offset_x,
		["y"] = plyCoords.y,
		["z"] = plyCoords.z+offset_z
	}
	GRAPHICS.DRAW_LINE(right_down_ang["x"], right_down_ang["y"], right_down_ang["z"], right_up_ang["x"], right_up_ang["y"], right_up_ang["z"], color.red, color.green, color.blue, color.alpha)
	GRAPHICS.DRAW_LINE(right_up_ang["x"], right_up_ang["y"], right_up_ang["z"], left_up_ang["x"], left_up_ang["y"], left_up_ang["z"], color.red, color.green, color.blue, color.alpha)
	GRAPHICS.DRAW_LINE(left_up_ang["x"], left_up_ang["y"], left_up_ang["z"], left_down_ang["x"], left_down_ang["y"], left_down_ang["z"], color.red, color.green, color.blue, color.alpha)
	GRAPHICS.DRAW_LINE(left_down_ang["x"], left_down_ang["y"], left_down_ang["z"], right_down_ang["x"], right_down_ang["y"], right_down_ang["z"], color.red, color.green, color.blue, color.alpha)
end

local attackersTable = {}

function features.send_ground_attacker(vehicleHash, pedHash, pid, weapon, godmode, count)
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    callbacks.requestModel(vehicleHash, function()
		callbacks.requestModel(pedHash, function()
			for i=1, count do
				local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(player_ped, math.random(-20, 20), math.random(-20, 20), 0.0)
				local tank = entities.create_vehicle(vehicleHash, coords)
				table.insert(attackersTable, tank)
				for i = -1, VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(vehicleHash) - 2 do
					local driver = entities.create_ped(pedHash, coords)
					table.insert(attackersTable, driver)
					if i == -1 then
						TASK.TASK_VEHICLE_CHASE(driver, player_ped)
					end
					PED.SET_PED_INTO_VEHICLE(driver, tank, i)
					WEAPON.GIVE_WEAPON_TO_PED(driver, atkgun, 1000, false, true)
					PED.SET_PED_COMBAT_ATTRIBUTES(driver, 5, true)
					PED.SET_PED_COMBAT_ATTRIBUTES(driver, 46, true)
					TASK.TASK_COMBAT_PED(driver, player_ped, 0, 16)
					if godmode then
						ENTITY.SET_ENTITY_INVINCIBLE(tank, true)
						ENTITY.SET_ENTITY_INVINCIBLE(driver, true)
					end
					WEAPON.GIVE_WEAPON_TO_PED(driver, weapon, 0, false, true)
					system.yield(100)
				end
			end
		end)		
	end)
end

function features.send_attacker(hash, pid, weapon, godmode, count)
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
    callbacks.requestModel(hash, function()
		for i=1, count do
			coords.x = coords.x + math.random(-10, 10)
			coords.y = coords.y + math.random(-10, 10)
			local attacker = entities.create_ped(hash, coords)
			table.insert(attackersTable, attacker)
			if godmode then
				ENTITY.SET_ENTITY_INVINCIBLE(attacker, true)
			end
			TASK.TASK_COMBAT_PED(attacker, target_ped, 0, 16)
			PED.SET_PED_ACCURACY(attacker, 100.0)
			PED.SET_PED_COMBAT_ABILITY(attacker, 2)
			PED.SET_PED_AS_ENEMY(attacker, true)
			PED.SET_PED_ARMOUR(attacker, 200)
			PED.SET_PED_MAX_HEALTH(attacker, 10000)
			ENTITY.SET_ENTITY_HEALTH(attacker, 10000, 0)
			PED.SET_PED_FLEE_ATTRIBUTES(attacker, 0, false)
			PED.SET_PED_COMBAT_ATTRIBUTES(attacker, 46, true)
			WEAPON.GIVE_WEAPON_TO_PED(attacker, weapon, 0, false, true)
			system.yield(100)
		end
	end)
end

function features.send_attacker_animal(hash, pid, weapon, godmode, count)
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(target_ped, false)
    callbacks.requestModel(hash, function()
		for i=1, count do
			coords.x = coords.x + math.random(-10, 10)
			coords.y = coords.y + math.random(-10, 10)
			local attacker = entities.create_ped(hash, coords)
			table.insert(attackersTable, attacker)
			if godmode then
				ENTITY.SET_ENTITY_INVINCIBLE(attacker, true)
			end
			TASK.TASK_COMBAT_PED(attacker, target_ped, 0, 16)
			PED.SET_PED_ACCURACY(attacker, 100.0)
			PED.SET_PED_COMBAT_ABILITY(attacker, 2)
			PED.SET_PED_AS_ENEMY(attacker, true)
			PED.SET_PED_MAX_HEALTH(attacker, 10000)
			ENTITY.SET_ENTITY_HEALTH(attacker, 10000, 0)
			system.yield(100)
		end
	end)
end

function features.send_aircraft_attacker(vehicleHash, pedHash, pid, weapon, godmode, count, isUfo)
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    callbacks.requestModel(vehicleHash, function()
		callbacks.requestModel(pedHash, function()
			for i=1, count do
				local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(target_ped, math.random(-50, 50),  math.random(-50, 50), 150.0)
				local aircraft = entities.create_vehicle(vehicleHash, coords)
				table.insert(attackersTable, aircraft)
				VEHICLE.CONTROL_LANDING_GEAR(aircraft, 3)
				VEHICLE.SET_HELI_BLADES_FULL_SPEED(aircraft)
				VEHICLE.SET_VEHICLE_FORWARD_SPEED(aircraft, VEHICLE.GET_VEHICLE_ESTIMATED_MAX_SPEED(aircraft))
				if godmode then
					ENTITY.SET_ENTITY_INVINCIBLE(aircraft, true)
				end
				for i = -1, VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(vehicleHash) - 2 do
					local ped = entities.create_ped(pedHash, coords)
					table.insert(attackersTable, ped)
					if i == -1 then
						TASK.TASK_PLANE_MISSION(ped, aircraft, 0, target_ped, 0, 0, 0, 6, 0.0, 0, 0.0, 50.0, 40.0, 0)
					end
					PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
					PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
					PED.SET_PED_INTO_VEHICLE(ped, aircraft, i)
					TASK.TASK_COMBAT_PED(ped, target_ped, 0, 16)
					PED.SET_PED_COMBAT_ABILITY(ped, 2)
					PED.SET_PED_ACCURACY(ped, 100.0)
					PED.SET_PED_ARMOUR(ped, 200)
					PED.SET_PED_MAX_HEALTH(ped, 1000)
					ENTITY.SET_ENTITY_HEALTH(ped, 1000, 0)
					if isUfo then
						local ufoHash = utils.joaat("p_spinning_anus_s")
						callbacks.requestModel(ufoHash, function()
							local spawnedUfo = entities.create_object(ufoHash, coords)
							table.insert(attackersTable, spawnedUfo)
							ENTITY.SET_ENTITY_COLLISION(spawnedUfo, false, false)
							ENTITY.SET_ENTITY_VISIBLE(aircraft, false, false)
							ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnedUfo, aircraft, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, true, true, false, false, 0, true)
						end)
					end
				end
    		end
		end)
	end)
end


function features.clearAllAttackers()
	for _, handle in ipairs(attackersTable) do
		if features.doesEntityExist(handle) then
			entities.request_control(handle, function(entity)
				entities.delete(entity)
			end)
		end
	end
end

function features.setVehicleMod(vehicle, modType, modIndex)
	entities.request_control(vehicle, function()
		VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
		VEHICLE.SET_VEHICLE_MOD(vehicle, modType, modIndex, false)
	end)
end

function features.setVehiclePreset(vehicle, preset)
	local modTypes = {
		["Spoilers"] = 0,
		["Front Bumper"] = 1,
		["Rear Bumper"] = 2,
		["Side Skirt"] = 3,
		["Exhaust"] = 4,
		["Frame"] = 5,
		["Grille"] = 6, 
		["Hood"] = 7,
		["Fender"] = 8,
		["Right Fender"] = 9,
		["Roof"] = 10,
		["Engine"] = 11,
		["Brakes"] = 12,
		["Transmission"] = 13, 
		["Horns"] = 14,
		["Suspension"] = 15, 
		["Armor"] = 16,
		["Front Wheels"] = 23,
		["Back Wheels"] = 24,
		["Plate Holders"] = 25,
		["Trim Design"] = 27,
		["Ornaments"] = 28,
		["Dial Design"] = 30,
		["Steering Wheel"] = 33,
		["Shifter Leavers"] = 34,
		["Plaques"] = 35,
		["Hydraulics"] = 38,
		["Livery"] = 48
	}
	local modTypesPower = {
		["Engine"] = 11,
		["Brakes"] = 12,
		["Transmission"] = 13,
		["Suspension"] = 15
	}
	local function getMaxMods(vehicle, modType)
		local val = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, modType)
		if val > 0 then
			return val - 1
		else
			return 0
		end
	end
	entities.request_control(vehicle, function()
		VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
		if preset == 0 then -- DEFAULT
			for _, modType in pairs(modTypes) do
				VEHICLE.SET_VEHICLE_MOD(vehicle, modType, 0, false)
			end
		elseif preset == 1 then -- RANDOM
			for _, modType in pairs(modTypes) do
				VEHICLE.SET_VEHICLE_MOD(vehicle, modType, math.random(0, getMaxMods(vehicle, modType)), false)
				VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, math.random(0, 1))
			end
		elseif preset == 2 then -- POWER
			for _, modType in pairs(modTypesPower) do
				VEHICLE.SET_VEHICLE_MOD(vehicle, modType, getMaxMods(vehicle, modType), false)
				VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, false)
			end
		elseif preset == 3 then -- MAX
			for _, modType in pairs(modTypes) do
				VEHICLE.SET_VEHICLE_MOD(vehicle, modType, getMaxMods(vehicle, modType), false)
				VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, false)
			end
		end
	end)
end

function features.setVehicleDoorState(vehicle, door, state)
	entities.request_control(vehicle, function()
		if state then 
			VEHICLE.SET_VEHICLE_DOOR_OPEN(vehicle, door, false, true)
		else
			VEHICLE.SET_VEHICLE_DOOR_SHUT(vehicle, door, false)
		end
	end)
end

function features.makePedABodyguard(ped, godmode, weapon, formation, ignorePlayers)
	PED.SET_PED_HIGHLY_PERCEPTIVE(ped, true)
	PED.SET_PED_SEEING_RANGE(ped, 100.0)
	PED.SET_PED_CONFIG_FLAG(ped, 208, true)
	WEAPON.GIVE_WEAPON_TO_PED(ped, weapon, -1, false, true)
	WEAPON.SET_CURRENT_PED_WEAPON(ped, weapon, false)
	PED.SET_PED_FIRING_PATTERN(ped, 0xC6EE6B4C)
	PED.SET_PED_SHOOT_RATE(ped, 100.0)
	ENTITY.SET_ENTITY_INVINCIBLE(ped, godmode)
	ENTITY.SET_ENTITY_PROOFS(ped, godmode, godmode, godmode, godmode, godmode, godmode, 1, godmode)
	local group
	if PED.IS_PED_IN_GROUP(PLAYER.PLAYER_PED_ID()) then
		group = PED.GET_PED_GROUP_INDEX(PLAYER.PLAYER_PED_ID())
	else
		group = PED.CREATE_GROUP(0)
		PED.SET_PED_AS_GROUP_LEADER(PLAYER.PLAYER_PED_ID(), group)
	end
	PED.SET_PED_AS_GROUP_MEMBER(ped, group)
	PED.SET_GROUP_FORMATION_SPACING(group, 1.0, 0.9, 3.0)
	PED.SET_GROUP_SEPARATION_RANGE(group, 200.0)
	PED.SET_GROUP_FORMATION(group, formation)
	if ignorePlayers then
		PED.SET_PED_RELATIONSHIP_GROUP_HASH(ped, PED.GET_PED_RELATIONSHIP_GROUP_HASH(PLAYER.PLAYER_PED_ID()))
	end
end

function features.getDLCName(dlc)
	if dlcNames[dlc] ~= nil then return dlcNames[dlc]
	else return "Unknown DLC" end
end

function features.getPedTypeName(pedType)
	local types = {
		["Animal"] = "Animal",
		["civmale"] = "Civilian male",
		["CIVFEMALE"] = "Civilian female",
		["COP"] = "Cop",
		["PLAYER_1"] = "Franklin",
		["PLAYER_2"] = "Trevor",
		["PLAYER_0"] = "Michael",
		["army"] = "Army",
		["MEDIC"] = "Medical",
		["FIREMAN"] = "Fireman",
		["Swat"] = "SWAT",
	}
	if types[pedType] == nil then return "Uknown type" end
	return types[pedType]
end

function features.setEntityCoords(entity, coords)
	entities.request_control(entity, function()
		ENTITY.SET_ENTITY_COORDS(entity, coords.x, coords.y, coords.z, false, false, false, false)
	end)
end

function features.getClosestVehicle()
	local minDistance = 1337228
	local closestVehicle
	local localCoords = features.getEntityCoords(PLAYER.PLAYER_PED_ID())
	for _, vehicle in ipairs(entities.get_vehs()) do
		local vehicleCoords = features.getEntityCoords(vehicle)
		local distance = features.getDistance(localCoords, vehicleCoords)
		if distance < minDistance then
			closestVehicle = vehicle
			minDistance = distance
		end
	end
	return closestVehicle
end

function features.isControlPressed(ctrlID)
	return PAD.IS_CONTROL_PRESSED(1, ctrlID) == 1
end

function features.isPedInCargobob()
	local cargobobs = {1394036463, -50547061, 2025593404, 1621617168, 4244420235}
	for _, hash in ipairs(cargobobs) do
		if hash == ENTITY.GET_ENTITY_MODEL(features.getLocalVehicle(false)) then return true end
	end
	return false
end

function features.isControlJustPressed(ctrlID)
	return PAD.IS_CONTROL_JUST_PRESSED(1, ctrlID) == 1
end

function features.setVehicleDoorState(vehicle, doorID, state)
	if state then 
		VEHICLE.SET_VEHICLE_DOOR_OPEN(vehicle, doorID, false, false)
	else
		VEHICLE.SET_VEHICLE_DOOR_SHUT(vehicle, doorID, false)
	end
end

function features.setVehicleWindowState(vehicle, windowID, state)
	if state then 
		VEHICLE.ROLL_DOWN_WINDOW(vehicle, windowID)
	else
		VEHICLE.ROLL_UP_WINDOW(vehicle, windowID)
	end
end

function features.doesEntityExist(entity)
	return ENTITY.DOES_ENTITY_EXIST(entity) == 1
end

function features.isPlayerOTR(pid)
	return globals.get_int(2689235 + (1 + (pid * 453)) + 208) == 1
end

function features.isEmpty(value)
	return ((value == nil) or (value == "") )
end

function features.isPlayerDead(pid)
	return PLAYER.IS_PLAYER_DEAD(pid) == 1
end

function features.isPedAPlayer(ped)
	return PED.IS_PED_A_PLAYER(ped) == 1
end

function features.getPidFromPed(ped)
	return NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ped)
end

function features.getWepVehName(hash, table)
	if WEAPON.IS_WEAPON_VALID(hash) == 1 then
		for name, wepHash in pairs(table) do
			if wepHash == hash then
				local labelText = HUD._GET_LABEL_TEXT(name)
				if labelText ~= "NULL" then
					return labelText
				else
					return name
				end
			end
		end
	elseif ENTITY.IS_ENTITY_A_VEHICLE(hash) == 1 then
		return HUD._GET_LABEL_TEXT(VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(hash))
	end
	return "UNKNOWN"
end

function features.isPedShooting(ped)
	return PED.IS_PED_SHOOTING(ped) == 1
end

function features.translate(text, lang, callback)
	if text == nil then return end
	local function encode(text)
		return string.gsub(text, "%s", "+")
	end
	http.get("translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=" .. lang .. "&dt=t&q="..encode(text), function(resp, header, code)
		if code ~= 200 then alert("HTTP error. | Code: " .. code) return end
		local translation 
		local original 
		local sourceLang
		translation, original, sourceLang = resp:match("^%[%[%[\"(.-)\",\"(.-)\",.-,.-,.-]],.-,\"(.-)\"")
		callback(code == 200, translation)
	end)
end

function features.giveWeaponToPed(ped, wepHash)
	WEAPON.GIVE_WEAPON_TO_PED(ped, wepHash, 1000, false, true)
end

function features.doesPedHaveWeapon(ped, wepHash)
	return WEAPON.HAS_PED_GOT_WEAPON(ped, wepHash, false) == 1
end

function features.doesPedHaveWeaponComponent(ped, wepHash, wepComponent)
	return WEAPON.HAS_PED_GOT_WEAPON_COMPONENT(ped, wepHash, wepComponent) == 1
end

function features.makeFirstLetUpper(text)
	local output = ''
	local iter = 0
	for let in text:gmatch('%D') do
		if iter == 0 then
			let = let:upper()
		end
		output = output .. let
		iter = iter + 1
	end
	return output
end

function features.getVehicleInfo(vehicle)
	if not features.doesEntityExist(vehicle) then return nil end
	local outTable = {}
	outTable['hash'] = ENTITY.GET_ENTITY_MODEL(vehicle)
	outTable['coords'] = features.getEntityCoords(vehicle)
	outTable['wheelType'] = VEHICLE.GET_VEHICLE_WHEEL_TYPE(vehicle)
	outTable['mods'] = {}
	for i = 0, 49 do
		outTable['mods'][i] = VEHICLE.GET_VEHICLE_MOD(vehicle, i)
	end
	outTable['tyresCanBurst'] = VEHICLE.GET_VEHICLE_TYRES_CAN_BURST(vehicle) == 1
	local pR, pG, pB = memory.malloc(4), memory.malloc(4), memory.malloc(4)
	VEHICLE.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, pR, pG, pB)
	outTable['colors'] = {}
	outTable['colors']['prim'] = {
		['r'] = memory.read_int(pR),
		['g'] = memory.read_int(pG),
		['b'] = memory.read_int(pB)
	}
	VEHICLE.GET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, pR, pG, pB)
	outTable['colors']['sec'] = {
		['r'] = memory.read_int(pR),
		['g'] = memory.read_int(pG),
		['b'] = memory.read_int(pB)
	}
	VEHICLE.GET_VEHICLE_EXTRA_COLOURS(vehicle, pR, pG)
	outTable['extraColors'] = {
		['pearl'] = memory.read_int(pR),
		['wheels'] = memory.read_int(pG)
	}
	memory.free(pR) memory.free(pG)  memory.free(pB) 
	outTable['livery'] = VEHICLE.GET_VEHICLE_LIVERY(vehicle)
	outTable['plateText'] = VEHICLE.GET_VEHICLE_NUMBER_PLATE_TEXT(vehicle)
	outTable['plateType'] = VEHICLE.GET_VEHICLE_PLATE_TYPE(vehicle)
	outTable['xenonColor'] = VEHICLE._GET_VEHICLE_XENON_LIGHTS_COLOR(vehicle)
	outTable['roofState'] = VEHICLE.GET_CONVERTIBLE_ROOF_STATE(vehicle)
	local pR, pG, pB = memory.malloc(4), memory.malloc(4), memory.malloc(4)
	VEHICLE._GET_VEHICLE_NEON_LIGHTS_COLOUR(vehicle, pR, pG, pB)
	outTable['neonColors'] = {}
	outTable['neonColors']['red'], outTable['neonColors']['green'], outTable['neonColors']['blue'] = memory.read_int(pR), memory.read_int(pG), memory.read_int(pB)
	memory.free(pR) memory.free(pG) memory.free(pB)
	local pR, pG, pB = memory.malloc(4), memory.malloc(4), memory.malloc(4)
	VEHICLE.GET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, pR, pG, pB)
	outTable['tyreSmoke'] = {}
	outTable['tyreSmoke']['red'], outTable['tyreSmoke']['green'], outTable['tyreSmoke']['blue'] = memory.read_int(pR), memory.read_int(pG), memory.read_int(pB)
	memory.free(pR) memory.free(pG) memory.free(pB)
	outTable['windowTint'] = VEHICLE.GET_VEHICLE_WINDOW_TINT(vehicle)
	local pColor = memory.malloc(4)
	VEHICLE._GET_VEHICLE_INTERIOR_COLOR(vehicle, pColor)
	outTable['interiorColor'] = memory.read_int(pColor)
	memory.free(pColor)
	local pColor = memory.malloc(4)
	VEHICLE._GET_VEHICLE_DASHBOARD_COLOR(vehicle, pColor)
	outTable['dashboardColor'] = memory.read_int(pColor)
	memory.free(pColor)
	outTable['neonlights'] = {}
	for i = 0, 3 do
		outTable['neonlights'][i] = VEHICLE._IS_VEHICLE_NEON_LIGHT_ENABLED(vehicle, i) == 1
	end
	outTable['extras'] = {}
	for i = 1, 9 do
		if VEHICLE.DOES_EXTRA_EXIST(vehicle, i)==1 then
			table.insert(outTable['extras'], i)
		end
	end
	return outTable
end

function features.getPedInfo(ped)
	local outTable = {}
	outTable.hash = ENTITY.GET_ENTITY_MODEL(ped)
	outTable.coords = features.getEntityCoords(ped)
	outTable.outfit = {}
	for componentID = 0, 12 do
		outTable['outfit'][componentID] = {}
		outTable['outfit'][componentID]['drawableID'] = PED.GET_PED_DRAWABLE_VARIATION(ped, componentID)
		outTable['outfit'][componentID]['textureID'] = PED.GET_PED_TEXTURE_VARIATION(ped, componentID)
		outTable['outfit'][componentID]['paletteID'] = PED.GET_PED_PALETTE_VARIATION(ped, componentID)
	end
	outTable.props = {}
	for componentID = 0, 3 do
		outTable['props'][componentID] = {}
		outTable['props'][componentID]['drawableID'] = PED.GET_PED_PROP_INDEX(ped, componentID)
		outTable['props'][componentID]['textureID'] = PED.GET_PED_PROP_TEXTURE_INDEX(ped, componentID)
	end
	return outTable
end

function features.cloneToPed(infoTable)
	if infoTable == nil then return end
	callbacks.requestModel(infoTable.hash, function()
		PLAYER.SET_PLAYER_MODEL(PLAYER.PLAYER_ID(), infoTable.hash)
		if not features.isModelValid(infoTable.hash) then return end
		features.setEntityCoords(PLAYER.PLAYER_PED_ID(), infoTable.coords)
		for componentID = 0, 12 do
			PED.SET_PED_COMPONENT_VARIATION(PLAYER.PLAYER_PED_ID(), componentID, infoTable['outfit'][componentID]['drawableID'], infoTable['outfit'][componentID]['textureID'], infoTable['outfit'][componentID]['paletteID'])
		end
		for componentID = 0, 3 do
			PED.SET_PED_PROP_INDEX(PLAYER.PLAYER_PED_ID(), componentID, infoTable['props'][componentID]['drawableID'], infoTable['props'][componentID]['textureID'], true)
		end
	end)
end

function features.isModelValid(hash)
	return STREAMING.IS_MODEL_VALID(hash) == 1
end

function features.getMpChar()
	local pArg = memory.malloc(4)
	STATS.STAT_GET_INT(utils.joaat("MPPLY_LAST_MP_CHAR"), pArg, -1)
	local char = memory.read_int(pArg)
	memory.free(pArg)
	return tostring(char)
end

function features.setModel(hash)
	callbacks.requestModel(hash, function()
		PLAYER.SET_PLAYER_MODEL(PLAYER.PLAYER_ID(), hash)
	end)
end

return features

