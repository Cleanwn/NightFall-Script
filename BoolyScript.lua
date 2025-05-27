-- BoolyScript 
-- Author: OxiGen#1337
-- Version: Nightfall

local BSVersion = "[Nightfall] [2.3]"
local loadingStart = os.clock()

system.log("INIT", "             ******         **            **          **     **    **       ")
system.log("INIT", "            **   **     **     **     **     **      **       **  **        ")
system.log("INIT", "           **    **    **      **    **      **     **         ****         ")
system.log("INIT", "          ******      **       **   **       **    **           **           ")
system.log("INIT", "         **    **     **      **    **      **    **           **            ")
system.log("INIT", "        **    **      **    **      **    **     ********     **             ")
system.log("INIT", "       ******           **            **        ********     **              ")

system.log("INIT", string.format("BoolyScript %s is loading...", BSVersion))

local function getScriptPath()
    local str = debug.getinfo(2, "S").source:sub(2)
	return str:match("(.*[/\\])")
end

local function doesFileExist(file)
	local ok, err, code = os.rename(file, file)
	if not ok then
	   if code == 13 then
		  return true
	   end
	end
	return ok, err
end

local function doesFolderExist(path)
	return doesFileExist(path.."/")
end

local function loadingFailure(reason)
	system.log("ERROR", "Loading failed with reason: " .. reason)
end

system.log("INIT", "Loading Lib...")

if not doesFolderExist(getScriptPath() .. 'BoolyScript') then
	loadingFailure("Main directory missing")
	return
end

if not doesFileExist(getScriptPath() .. 'BoolyScript\\Lib\\JSON.lua') then
	loadingFailure("JSON lib missing")
	return
end

if not doesFileExist(getScriptPath() .. 'BoolyScript\\Lib\\features.lua') then
	loadingFailure("Features module missing")
	return
end

if not doesFileExist(getScriptPath() .. 'BoolyScript\\Lib\\callbacks.lua') then
	loadingFailure("Callbacks module missing")
	return
end

local json = require '\\BoolyScript\\Lib\\JSON'
local features = require '\\BoolyScript\\Lib\\features'
local callbacks = require '\\BoolyScript\\Lib\\callbacks'

paths = {}
paths.dumps = {}
paths.folders = {}
paths.logs = {}
paths.configs = {}

paths.folders.main = getScriptPath() .. 'BoolyScript'
paths.folders.lib = paths.folders.main .. '\\Lib'
paths.folders.userData = paths.folders.main .. '\\User'
paths.folders.wepLoadouts = paths.folders.userData .. '\\Weapon Loadouts'
paths.folders.spammerPresets = paths.folders.userData.. '\\Spammer Presets'
paths.folders.savedVehicles = paths.folders.userData .. '\\Saved Vehicles'
paths.folders.logs = paths.folders.main .. '\\Logs'
paths.folders.translations = paths.folders.main .. '\\Translations'

paths.logs.chat = paths.folders.logs .. '\\' .. 'Chat.log'
paths.logs.weapons = paths.folders.logs .. '\\' .. 'Weapons.log'
paths.logs.netEvents = paths.folders.logs .. '\\' .. 'Network Events.log'
paths.logs.scriptEvents = paths.folders.logs .. '\\' .. 'Script Events.log'

paths.dumps.objects = paths.folders.lib .. '\\' .. 'ObjectList.ini'
paths.dumps.peds = paths.folders.lib .. '\\' .. 'peds.json'
paths.dumps.vehicles = paths.folders.lib .. '\\' .. 'vehicles.json'
paths.dumps.weapons = paths.folders.lib .. '\\' .. 'weapons.json'

paths.configs.mainConfig = paths.folders.userData .. '\\' .. 'config.json'
paths.configs.defaults = paths.folders.userData .. '\\' .. 'default.json'
paths.configs.genTranslation = paths.folders.translations .. '\\' .. 'Generated Translation.json'
paths.configs.savedPeds = paths.folders.userData .. '\\' .. 'savedPeds.json'
paths.configs.savedObjects = paths.folders.userData .. '\\' .. 'savedObjects.json'
paths.configs.savedSwaps = paths.folders.userData .. '\\' .. 'savedSwaps.json'
paths.configs.savedModels = paths.folders.userData .. '\\' .. 'savedModels.json'


system.log("INIT", "Verifying required folders...")

if not doesFolderExist(paths.folders.logs) then
	loadingFailure("Logs folder missing")
	return
end

if not doesFolderExist(paths.folders.userData) then
	loadingFailure("User folder missing")
	return
end

if not doesFolderExist(paths.folders.spammerPresets) then
	loadingFailure("Spammer Presets folder missing")
	return
end

if not doesFolderExist(paths.folders.wepLoadouts) then
	loadingFailure("Weapon loadouts folder missing")
	return
end

system.log("INIT", "Parsing json data...")

parsedFiles = {}
local tempFile = assert(io.open(paths.dumps.weapons, "r"))
parsedFiles.weapons = json:decode(tempFile:read("*all"))
tempFile:close()
tempFile = assert(io.open(paths.dumps.peds, "r"))
parsedFiles.peds = json:decode(tempFile:read("*all"))
tempFile:close()
tempFile = assert(io.open(paths.dumps.vehicles, "r"))
parsedFiles.vehicles = json:decode(tempFile:read("*all"))
tempFile:close()
tempFile = assert(io.open(paths.dumps.objects, "r"))
parsedFiles.objects = {}
for line in io.lines(paths.dumps.objects) do
	table.insert(parsedFiles.objects, line)
end
-- tempFile:close()
-- tempFile = io.open(paths.configs.mainConfig, 'a+')
-- tempFile:close()
parsedFiles.weaponsSimp = {} --ATTACKERS SUB
parsedFiles.defaults = {}
if doesFileExist(paths.configs.defaults) then
	local tempFile = io.open(paths.configs.defaults, 'r')
	parsedFiles.defaults = json:decode(tempFile:read('*all'))
	tempFile:close()
else
	local table = {
		['config'] = false
	}
	parsedFiles.defaults = table
	local file = io.open(paths.configs.defaults, 'w+')
	file:write(json:encode_pretty(table))
	file:close()
end

local controls = {
    W = 32,
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

local function dbg(text)
    system.log("DEBUG", tostring(text))
end

local ESP = {
    boxes = {},
    lines = {},
    color = {
        red = 255,
        green = 0,
        blue = 0,
        alpha = 255
    }
}

local doors = {
    ["Front left"] = 0,
    ["Front right"] = 1,
    ["Back left"] = 2,
    ["Back right"] = 3,
    ["Hood"] = 4,
    ["Trunk"] = 5,
    ["Back"] = 6,
    ["Back 2"] = 7
}

local windows = {
	["Front left window"] = 0,
	["Front right window"] = 1,
	["Back left window"] = 2,
	["Back right window"] = 3
}

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

local audioFlags = {
    ["DisableBarks"] = false,
    ["DisableFlightMusic"] = false,
    ["ForceConversationInterrupt"] = false,
    ["ForceSeamlessRadioSwitch"] = false,
    ["ForceSniperAudio"] = false,
    ["MobileRadioInGame"] = false,
    ["PlayMenuMusic"] = false,
    ["SuppressPlayerScubaBreathing"] = false,
    ["WantedMusicDisabled"] = false,
    ["WantedMusicOnMission"] = false
}

local pedFlags = {
    ["NoCriticalHits"] = 2,
	["DieWhenRagdoll"] = 33,
	["BlockWeaponSwitching"] = 48,
	["IsStanding"] = 60,
	["IsSwimming"] = 65,
	["ForcedAim"] = 101,
	["DisableMelee"] = 122,
	["IsScuba"] = 135,
	["CanAttackFriendly"] = 140,
	["CanPerformArrest"] = 155,
	["CanPerformUncuff"] = 156,
	["IsInjured"] = 166,
	["DisableShuffleToDriversSeat"] = 184,
	["EnableWeaponBlocking"] = 186,
	["DontEnterLeadersVehicle"] = 220,
	["Shrink"] = 223,
	["OnStairs"] = 253,
	["RagdollingOnBoat"] = 287,
	["FreezePosition"] = 292,
	["HasReserveParachute"] = 362,
	["UseReserveParachute"] = 363,
	["DisableStartEngine"] = 429,
	["IgnoreBeingOnFire"] = 430,
	["DisableHomingMissileLockon"] = 434,
	["PedIsArresting"] = 450,
}

local entityProofs = {
    "Bullet",
    "Fire",
    "Explosion",
    "Collision",
    "Melee",
	"Steam"
}

local languages = {
    ['Afrikaans'] = "af",
    ['Albanian'] = "sq",
    ['Arabic'] = "ar",
    ['Azerbaijani'] = "az",
    ['Basque'] = "eu",
    ['Belarusian'] = "be",
    ['Bengali'] = "bn",
    ['Bulgarian'] = "bg",
    ['Catalan'] = "ca",
    ['ChineseSimplified'] = "zh-CN",
    ['ChineseTraditional'] = "zh-TW",
    ['Croatian'] = "hr",
    ['Czech'] = "cs",
    ['Danish'] = "da",
    ['Dutch'] = "nl",
    ['English'] = "en",
    ['Esperanto'] = "eo",
    ['Estonian'] = "et",
    ['Filipino'] = "tl",
    ['Finnish'] = "fi",
    ['French'] = "fr",
    ['Galician'] = "gl",
    ['Georgian'] = "ka",
    ['German'] = "de",
    ['Greek'] = "el",
    ['Gujarati'] = "gu",
    ['HaitianCreole'] = "ht",
    ['Hebrew'] = "iw",
    ['Hindi'] = "hi",
    ['Hungarian'] = "hu",
    ['Icelandic'] = "is",
    ['Indonesian'] = "id",
    ['Irish'] = "ga",
    ['Italian'] = "it",
    ['Japanese'] = "ja",
    ['Kannada'] = "kn",
    ['Korean'] = "ko",
    ['Latin'] = "la",
    ['Latvian'] = "lv",
    ['Lithuanian'] = "lt",
    ['Macedonian'] = "mk",
    ['Malay'] = "ms",
    ['Maltese'] = "mt",
    ['Norwegian'] = "no",
    ['Persian'] = "fa",
    ['Polish'] = "pl",
    ['Portuguese'] = "pt",
    ['Romanian'] = "ro",
    ['Russian'] = "ru",
    ['Serbian'] = "sr",
    ['Slovak'] = "sk",
    ['Slovenian'] = "sl",
    ['Spanish'] = "es",
    ['Swahili'] = "sw",
    ['Swedish'] = "sv",
    ['Tamil'] = "ta",
    ['Telugu'] = "te",
    ['Thai'] = "th",
    ['Turkish'] = "tr",
    ['Ukrainian'] = "uk",
    ['Urdu'] = "ur",
    ['Vietnamese'] = "vi",
    ['Welsh'] = "cy",
    ['Yiddish'] = "yi"
}

local cageModels = {
	"prop_gold_cont_01",
	"prop_gold_cont_01b",
	"prop_feeder1_cr",
	"prop_rub_cage01a",
	"stt_prop_stunt_tube_s",
	"stt_prop_stunt_tube_end",
	"prop_jetski_ramp_01",
	"prop_fnclink_03e"
}

local stuff = {}

local timer = {}

local subs = {}

local options = {}

function features.add_separator(name, subID)
	local id = ui.add_separator(name, subID)
	options[name .. "Sep"] = id
	return id
end

subs.main = ui.add_main_submenu("BoolyScript")

-- NEW SECTION | ONLINE -> SELECTED PLAYER

-- ESP

subs.plySub = {}

subs.plySub.main = ui.add_player_submenu("BoolyScript")

options['setWaypointToPly'] = ui.add_click_option("Set waypoint", subs.plySub.main, function()
	local coords = features.getEntityCoords(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(online.get_selected_player()))
	HUD.SET_NEW_WAYPOINT(coords.x, coords.y)
end)

subs.plySub.esp = features.addSubmenu("ESP", subs.plySub.main)

options['espLines'] = ui.add_bool_option("Lines", subs.plySub.esp.submenu, function(state)
	ESP.lines[online.get_selected_player()] = state
end)

options['espBoxes'] = ui.add_bool_option("Boxes", subs.plySub.esp.submenu, function(state)
	ESP.boxes[online.get_selected_player()] = state
end)

ui.add_color_picker("Color", subs.plySub.esp.submenu, function(color)
    ESP.color.red = color.r
    ESP.color.green = color.g
    ESP.color.blue = color.b
    ESP.color.alpha = color.a
end)

-- ATTACKERS
subs.plySub.griefing = {}
subs.plySub.griefing.main = features.addSubmenu("Griefing", subs.plySub.main)

features.add_separator("Attackers", subs.plySub.griefing.main.submenu)

subs.plySub.griefing.settings = features.addSubmenu("Attackers settings", subs.plySub.griefing.main.submenu)

local attackersConfig = {
	count = 1,
	godmode = false,
	weapon = 2725352035
}

ui.add_click_option("Clear attackers", subs.plySub.griefing.settings.submenu, function()
	features.clearAllAttackers()
end)

ui.add_num_option("Count", subs.plySub.griefing.settings.submenu, 1, 20, 1, function(num)
	attackersConfig.count = num	
end)

ui.add_bool_option("Invincible", subs.plySub.griefing.settings.submenu, function(state)
	attackersConfig.godmode = state	
end)

subs.plySub.griefing.settings.weapon = features.addSubmenu("Weapon", subs.plySub.griefing.settings.submenu)
stuff.attackersWepCategories = {}
for _, wepInfo in ipairs(parsedFiles.weapons) do
	if wepInfo['TranslatedLabel'] ~= nil and wepInfo['Category'] ~= nil then
		local wepName = HUD._GET_LABEL_TEXT(wepInfo['TranslatedLabel']['Name'])
		local wepHash = wepInfo['Hash']
		local wepCategory = wepInfo['Category']
		if stuff['attackersWepCategories'][wepCategory] == nil then
			stuff['attackersWepCategories'][wepCategory] = {}
			stuff['attackersWepCategories'][wepCategory] = features.addSubmenu(wepCategory:gsub('GROUP_', ''), subs.plySub.griefing.settings.weapon.submenu)
		end
		if wepName ~= 'NULL' and wepName ~= 'Invalid' then
			-- OPTIMISATION DECISION | CREATING SIMPLIFIED TABLE OF WEAPONS AND HASHES
			parsedFiles.weaponsSimp[wepInfo['TranslatedLabel']['Name']] = wepHash
			ui.add_click_option(wepName, stuff['attackersWepCategories'][wepCategory]['submenu'], function()
				attackersConfig.weapon = wepHash
			end) 
		end
	end
end

ui.add_choose("Send jets", subs.plySub.griefing.main.submenu, false, {"B-11 Strikeforce", "P-996 Lazer", "UFO"}, function(pos)
	if pos == 0 then
		features.send_aircraft_attacker(utils.joaat("strikeforce"), -163714847, online.get_selected_player(), attackersConfig.weapon, attackersConfig.godmode, attackersConfig.count, false)
	elseif pos == 1 then
		features.send_aircraft_attacker(utils.joaat("Lazer"), -163714847, online.get_selected_player(), attackersConfig.weapon, attackersConfig.godmode, attackersConfig.count, false)
	elseif pos == 2 then
		features.send_aircraft_attacker(utils.joaat("strikeforce"), -163714847, online.get_selected_player(), attackersConfig.weapon, attackersConfig.godmode, attackersConfig.count, true)
	end
end)

ui.add_choose("Send killers", subs.plySub.griefing.main.submenu, false, {"Cop", "Drunk Russian", "Robber"}, function(pos)
	if pos == 0 then
		features.send_attacker(utils.joaat("CSB_Cop"), online.get_selected_player(), attackersConfig.weapon, attackersConfig.godmode, attackersConfig.count)
	elseif pos == 1 then
		features.send_attacker(utils.joaat("IG_RussianDrunk"), online.get_selected_player(), attackersConfig.weapon, attackersConfig.godmode, attackersConfig.count)
	elseif pos == 2 then 
		features.send_attacker(utils.joaat("S_M_Y_Robber_01"), online.get_selected_player(), attackersConfig.weapon, attackersConfig.godmode, attackersConfig.count)
	end
end) 

ui.add_choose("Send animals", subs.plySub.griefing.main.submenu, false, {"Shepherd", "Panther", "Chop"}, function(pos)
	if pos == 0 then
		features.send_attacker_animal(utils.joaat("A_C_shepherd"), online.get_selected_player(), attackersConfig.weapon, attackersConfig.godmode, attackersConfig.count)
	elseif pos == 1 then
		features.send_attacker_animal(utils.joaat("A_C_Panther"), online.get_selected_player(), attackersConfig.weapon, attackersConfig.godmode, attackersConfig.count)
	elseif pos == 2 then
		features.send_attacker_animal(utils.joaat("A_C_Chop"), online.get_selected_player(), attackersConfig.weapon, attackersConfig.godmode, attackersConfig.count)
	end
end) 

ui.add_choose("Send tanks", subs.plySub.griefing.main.submenu, false, {"Rhino", "Khanjali"}, function(pos)
	if pos == 0 then
		features.send_ground_attacker(utils.joaat("RHINO"), -163714847, online.get_selected_player(), attackersConfig.weapon, attackersConfig.godmode, attackersConfig.count)
	elseif pos == 1 then
		features.send_ground_attacker(utils.joaat("khanjali"), -163714847, online.get_selected_player(), attackersConfig.weapon, attackersConfig.godmode, attackersConfig.count)
	end
end) 

subs.plySub.removals = features.addSubmenu("Removals", subs.plySub.main)

ui.add_click_option("Boolean crash", subs.plySub.removals.submenu, function()
	local ped = features.getPlayerPed(online.get_selected_player())
	local coords = features.getEntityCoords(ped)
	local model = utils.joaat("banshee")
	callbacks.requestModel(model, function()
		local vehicle = entities.create_vehicle(model, coords.x, coords.y, coords.z)
		VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
		ENTITY.SET_ENTITY_COLLISION(vehicle, false, true)
		VEHICLE.SET_VEHICLE_GRAVITY(vehicle, 0)
		for i=0, 48 do
			local maxMod = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, i)-1
			VEHICLE.SET_VEHICLE_MOD(vehicle, i, maxMod, false)
		end
		features.notify(string.format("Boolean crash sent to %s", online.get_name(online.get_selected_player())))
		system.yield(10000)
		features.notify("Boolean crash finished")
	end)
end)

ui.add_click_option("SE crash", subs.plySub.removals.submenu, function()
	features.SECrash(online.get_selected_player())
end)

ui.add_click_option("SE kick", subs.plySub.removals.submenu, function()
	features.SEKick(online.get_selected_player())
end)

subs.plySub.vehicle = {}
subs.plySub.vehicle.main = features.addSubmenu("Vehicle", subs.plySub.main)

ui.add_bool_option("Attach to my vehicle", subs.plySub.vehicle.main.submenu, function(state)
	local target = features.getPlayerVehicle(online.get_selected_player(), false)
	local base = features.getLocalVehicle(false)
	if target == nil or base == nil or target == base then return end
	entities.request_control(target, function()
		if state then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(target, base, 0, 0.0, -5.00, 0.00, 1.0, 1.0, 1, true, true, true, false, 0, true)
		else
			ENTITY.DETACH_ENTITY(target, false, false)
		end
	end)
end)

stuff.ramps = {}

ui.add_choose("Attach ramp", subs.plySub.vehicle.main.submenu, false, {"Detach & delete", "Small ramp", "Big ramp"}, function(pos)
    local vehicle = features.getPlayerVehicle(online.get_selected_player(), false)
    local coords = features.getEntityCoords(vehicle)
	local hash = utils.joaat("prop_mp_ramp_01")
	local angle = 180
	if pos == 2 then hash = utils.joaat("prop_mp_ramp_03") end
    callbacks.requestModel(hash, function()		
		if pos > 0 then
			entities.request_control(vehicle, function()
				local ramp = entities.create_object(hash, coords.x, coords.y, coords.z)
				table.insert(stuff.ramps, ramp)
				ENTITY.ATTACH_ENTITY_TO_ENTITY(ramp, vehicle, 0, 0.0, 8, 0.0, 0.0, 0.0, angle, true, true, true, false, 0, true)
			end)
		else
			for _, ramp in ipairs(stuff.ramps) do
				entities.request_control(ramp, function()
					entities.delete(ramp)
				end)
			end
		end
	end)
end)

subs.plySub.vehicle.doors = features.addSubmenu("Doors", subs.plySub.vehicle.main.submenu)

for name, doorID in pairs(doors) do
    ui.add_bool_option(name, subs.plySub.vehicle.doors.submenu, function(state)
        features.setVehicleDoorState(features.getPlayerVehicle(online.get_selected_player()) ,doorID, state)
    end)
end

subs.plySub.vehicle.lsc = features.addSubmenu("Los Santos Customs", subs.plySub.vehicle.main.submenu)

ui.add_choose("Set tuning preset", subs.plySub.vehicle.lsc.submenu, false, {"Default", "Random", "Max", "Power"}, function(pos)
	local vehicle = features.getLocalVehicle(false)
	features.setVehiclePreset(pos)
end)

stuff.lscOptions = {}

features.add_separator("Color", subs.plySub.vehicle.lsc.submenu)

ui.add_color_picker("Primary", subs.plySub.vehicle.lsc.submenu, function(color)
	local vehicle = features.getPlayerVehicle(online.get_selected_player(), false)
	VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, color.r, color.g, color.b)
end)

ui.add_color_picker("Secondary", subs.plySub.vehicle.lsc.submenu, function(color)
	local vehicle = features.getPlayerVehicle(online.get_selected_player(), false)
	VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, color.r, color.g, color.b)
end)

features.add_separator("Main", subs.plySub.vehicle.lsc.submenu)

for name, id in pairs(modTypes) do
	stuff.lscOptions[name] = ui.add_num_option(name, subs.plySub.vehicle.lsc.submenu, 0, 1, 1, function(num)
		local vehicle = features.getPlayerVehicle(online.get_selected_player(), false)
		features.setVehicleMod(vehicle, id, num)
	end)
end

features.add_separator("Misc", subs.plySub.vehicle.lsc.submenu)

ui.add_click_option("Set bulletproof tires", subs.plySub.vehicle.lsc.submenu, function()
	local vehicle = getPlayerVehicle(online.get_selected_player(), false)
	entities.request_control(vehicle, function()
		VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, true)
	end)
end)

subs.plySub.neutral = features.addSubmenu("Neutral", subs.plySub.main)

ui.add_click_option("Copy vehicle", subs.plySub.neutral.submenu, function()
	local vehicle = features.getPlayerVehicle(online.get_selected_player(), true)
	if not features.doesEntityExist(vehicle) then features.alert("Player's vehicle doesnt exist") return end
	features.spawnVehicleCopy(vehicle)
end)

ui.add_click_option("Copy outfit", subs.plySub.neutral.submenu, function()
	local ped = features.getPlayerPed(online.get_selected_player())
	for i = 0, 11 do
		PED.SET_PED_COMPONENT_VARIATION(PLAYER.PLAYER_PED_ID(), i, PED.GET_PED_DRAWABLE_VARIATION(ped, i), PED.GET_PED_TEXTURE_VARIATION(ped, i), PED.GET_PED_PALETTE_VARIATION(ped, i))
	end
	for i = 0, 3 do
		PED.SET_PED_PROP_INDEX(PLAYER.PLAYER_PED_ID(), i, PED.GET_PED_PROP_INDEX(ped, i), PED.GET_PED_PROP_TEXTURE_INDEX(ped, i), true)
	end
end)

-- NEW SECTION | LOCAL

subs.localSub = {}
subs.localSub.main = features.addSubmenu("Local", subs.main)

subs.localSub.health = features.addSubmenu("Health", subs.localSub.main.submenu)

options["godMode"] = ui.add_bool_option("Stinky godmode", subs.localSub.health.submenu, function() end)

options['fillAllSnacks'] = ui.add_click_option("Refill all snacks", subs.localSub.health.submenu, function()
	local char = features.getMpChar()
	STATS.STAT_SET_INT(utils.joaat("MP" .. char .."_NO_BOUGHT_YUM_SNACKS"), 100, 1);
	STATS.STAT_SET_INT(utils.joaat("MP" .. char .."_NO_BOUGHT_HEALTH_SNACKS"), 100, 1);
	STATS.STAT_SET_INT(utils.joaat("MP" .. char .."_NO_BOUGHT_EPIC_SNACKS"), 100, 1);
	STATS.STAT_SET_INT(utils.joaat("MP" .. char .."_CIGARETTES_BOUGHT"), 100, 1);
	STATS.STAT_SET_INT(utils.joaat("MP" .. char .."_NUMBER_OF_ORANGE_BOUGHT"), 100, 1);
	STATS.STAT_SET_INT(utils.joaat("MP" .. char .."_NUMBER_OF_BOURGE_BOUGHT"), 100, 1);
end)

subs.localSub.proofs = features.addSubmenu("Proofs", subs.localSub.health.submenu)

stuff.playerProofs = {}
options['enablePlayerProofs'] = ui.add_bool_option("Enable", subs.localSub.proofs.submenu, function() end)
features.add_separator("Proofs", subs.localSub.proofs.submenu)
for _, name in ipairs(entityProofs) do
	ui.add_bool_option(name, subs.localSub.proofs.submenu, function(state)
        stuff.playerProofs[name] = state
    end)
end

features.add_separator("Autoheal", subs.localSub.health.submenu)

options['ahFillHealth'] = ui.add_bool_option("Fill health", subs.localSub.health.submenu, function() end)
options['ahFillArmor'] = ui.add_bool_option("Fill armor", subs.localSub.health.submenu, function() end)
options['ahFillInCover'] = ui.add_bool_option("Fill in cover", subs.localSub.health.submenu, function() end)
options['ahStep'] = ui.add_num_option("Step", subs.localSub.health.submenu, 0, 100, 10, function() end)
options['ahCooldown'] = ui.add_num_option("Cooldown (ms)", subs.localSub.health.submenu, 0, 3000, 500, function() end)

subs.localSub.movement = features.addSubmenu("Movement", subs.localSub.main.submenu)

options['clumsiness'] = ui.add_bool_option("Clumsiness", subs.localSub.movement.submenu, function() end)

ui.add_choose("Run speed multiplier", subs.localSub.movement.submenu, true, {"Default", "Low", "Medium", "High"}, function(pos)
	local mult = 0.0
	if pos == 0 then mult = 1.0 end
	if pos == 1 then mult = 1.2 end
	if pos == 2 then mult = 1.3 end
	if pos == 3 then mult = 1.49 end
	PLAYER.SET_RUN_SPRINT_MULTIPLIER_FOR_PLAYER(PLAYER.PLAYER_ID(), mult)
end)

ui.add_choose("Swim speed multiplier", subs.localSub.movement.submenu, true, {"Default", "Low", "Medium", "High"}, function(pos)
	local mult = 0.0
	if pos == 0 then mult = 1.0 end
	if pos == 1 then mult = 1.2 end
	if pos == 2 then mult = 1.3 end
	if pos == 3 then mult = 1.49 end
	PLAYER.SET_SWIM_MULTIPLIER_FOR_PLAYER(PLAYER.PLAYER_ID(), mult)
end)

ui.add_click_option("Make a poop (Nadristat)", subs.localSub.movement.submenu, function() 
	local ped = PLAYER.PLAYER_PED_ID()
	local shit = utils.joaat("prop_big_shit_02")
	local coords = features.getEntityCoords(ped)
	coords.z = coords.z - 1
	callbacks.requestAnimDict("missfbi3ig_0", function()
		TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
		TASK.TASK_PLAY_ANIM(ped, "missfbi3ig_0", "shit_loop_trev" , 8.0, 8.0, 3000, 0, 0, true, true, true)
		system.yield(1000)
		entities.create_object(shit, coords)
	end)
end)

-- subs.localSub.animsAndScen = {}
-- subs.localSub.animsAndScen.main = features.addSubmenu("Animations & Scenarios", subs.localSub.movement.submenu)
-- subs.localSub.animsAndScen.anims = features.addSubmenu("Animations", subs.localSub.animsAndScen.main.submenu)

subs.localSub.flags = {}
subs.localSub.flags.main = features.addSubmenu("Flags", subs.localSub.main.submenu)
subs.localSub.flags.audio = features.addSubmenu("Audio flags", subs.localSub.flags.main.submenu)
subs.localSub.flags.ped = features.addSubmenu("Player flags", subs.localSub.flags.main.submenu)

options['enableAudioFlags'] = ui.add_bool_option("Enable", subs.localSub.flags.audio.submenu, function() end)
features.add_separator("Flags", subs.localSub.flags.audio.submenu)
for name, state in pairs(audioFlags) do
	ui.add_bool_option(name, subs.localSub.flags.audio.submenu, function(state)
		audioFlags[name] = state
	end)
end

options['enablePlayerFlags'] = ui.add_bool_option("Enable", subs.localSub.flags.ped.submenu, function() end)
features.add_separator("Flags", subs.localSub.flags.ped.submenu)
stuff.activePedFlags = {}
for name, state in pairs(pedFlags) do
	ui.add_bool_option(name, subs.localSub.flags.ped.submenu, function(state)
		stuff.activePedFlags[name] = state
	end)
end

subs.localSub.weapon = features.addSubmenu("Weapon", subs.localSub.main.submenu)

options['deadEye'] = ui.add_bool_option("Dead eye effect", subs.localSub.weapon.submenu, function(state) end)
stuff.deadEyeActive = false

options['becomeGangsta'] = ui.add_bool_option("Become gangsta", subs.localSub.weapon.submenu, function(state)
	local ped = PLAYER.PLAYER_PED_ID()
	if state then
		features.note("Use default pistol. Gangsta mod displays only for you")
		WEAPON.SET_WEAPON_ANIMATION_OVERRIDE(ped, utils.joaat("Gang1H"))
	else
		WEAPON.SET_WEAPON_ANIMATION_OVERRIDE(ped, utils.joaat("Default"))
	end
end)

options['killKarma'] = ui.add_bool_option("Kill karma", subs.localSub.weapon.submenu, function(state) end)
options['debugGun'] = ui.add_bool_option("Debug gun [E]", subs.localSub.weapon.submenu, function(state) end)
options['blockGun'] = ui.add_bool_option("Block gun", subs.localSub.weapon.submenu, function(state) end)

subs.localSub.visual = features.addSubmenu("Visual", subs.localSub.main.submenu)

ui.add_num_option("Fake wanted level", subs.localSub.visual.submenu, 0, 6, 1, function(num)
	MISC.SET_FAKE_WANTED_LEVEL(num)
end)

ui.add_bool_option("Hide HUD", subs.localSub.visual.submenu, function(state)
	HUD.DISPLAY_RADAR(not state)
end)

ui.add_bool_option("Disable distant vehicles", subs.localSub.visual.submenu, function(state)
	VEHICLE.SET_DISTANT_CARS_ENABLED(not state)
end)

options['allowPauseInOnline'] = ui.add_bool_option("Allow pause in online", subs.localSub.visual.submenu, function(state) end)
options['allowPauseWhenDead'] = ui.add_bool_option("Allow pause when dead", subs.localSub.visual.submenu, function(state) end)
options['silentBST'] = ui.add_bool_option("Silent BST", subs.localSub.visual.submenu, function() end)

subs.localSub.world = features.addSubmenu("World", subs.localSub.main.submenu)

subs.localSub.world.clearArea = features.addSubmenu("Area cleanup", subs.localSub.world.submenu)

options['cleanupRadius'] = ui.add_num_option("Radius", subs.localSub.world.clearArea.submenu, 50, 1000, 50, function() end)
ui.set_value(options['cleanupRadius'], 50, true)

options['cleanupPeds'] = ui.add_bool_option("Peds", subs.localSub.world.clearArea.submenu, function()
	if state then features.note("Use it carefully\nMay provide a game crash") end
end)

options['cleanupVehicles'] = ui.add_bool_option("Vehicles", subs.localSub.world.clearArea.submenu, function()
	if state then features.note("Use it carefully\nMay provide a game crash") end
end)

-- options['cleanupObjects'] = ui.add_bool_option("Objects", subs.localSub.world.clearArea.submenu, function()
-- 	if state then features.note("Use it carefully\nMay provide a game crash") end
-- end)


ui.add_choose("Blackout mode", subs.localSub.world.submenu, true, {"OFF", "ON", "ON (Affects vehs)"}, function(pos)
	GRAPHICS.SET_ARTIFICIAL_LIGHTS_STATE(pos > 0) GRAPHICS._SET_ARTIFICIAL_LIGHTS_STATE_AFFECTS_VEHICLES(pos == 2)
end)

subs.localSub.water = features.addSubmenu("Water editor", subs.localSub.world.submenu)

ui.add_num_option("Water height", subs.localSub.water.submenu, 0, 1500, 1, function(num)
	local coords = features.getEntityCoords(PLAYER.PLAYER_PED_ID())
	WATER.MODIFY_WATER(coords.x, coords.y, coords.z, num)
end)

features.add_separator("Waves", subs.localSub.water.submenu)

ui.add_num_option("Waves intensivity", subs.localSub.water.submenu, 0, 30, 1, function(num)
	WATER.SET_DEEP_OCEAN_SCALER(num/10.0)
end)

ui.add_num_option("Waves strength", subs.localSub.water.submenu, 0, 30, 1, function(num)
	MISC.WATER_OVERRIDE_SET_STRENGTH(num/10.0)
end)

features.add_separator("Shore waves", subs.localSub.water.submenu)

ui.add_num_option("Amplitude", subs.localSub.water.submenu,0, 20, 1, function(num)
	MISC.WATER_OVERRIDE_SET_SHOREWAVEAMPLITUDE(num)
end)

ui.add_num_option("Min amplitude", subs.localSub.water.submenu, 0, 20, 1, function(num)
	MISC.WATER_OVERRIDE_SET_SHOREWAVEMINAMPLITUDE(num)
end)

ui.add_num_option("Max amplitude", subs.localSub.water.submenu, 0, 20, 1, function(num)
	MISC.WATER_OVERRIDE_SET_SHOREWAVEMAXAMPLITUDE(num)
end)

features.add_separator("Ocean waves", subs.localSub.water.submenu)

ui.add_num_option("Amplitude", subs.localSub.water.submenu, 0, 20, 1, function(num)
	MISC.WATER_OVERRIDE_SET_OCEANWAVEAMPLITUDE(num)
end)

ui.add_num_option("Min amplitude", subs.localSub.water.submenu, 0, 20, 1, function(num)
	MISC.WATER_OVERRIDE_SET_OCEANWAVEMINAMPLITUDE(num)
end)

ui.add_num_option("Max amplitude", subs.localSub.water.submenu, 0, 20, 1, function(num)
	MISC.WATER_OVERRIDE_SET_OCEANWAVEMAXAMPLITUDE(num)
end)

features.add_separator("Ripple", subs.localSub.water.submenu)

ui.add_num_option("Bumpiness", subs.localSub.water.submenu, 0, 100, 1, function(num)
	MISC.WATER_OVERRIDE_SET_RIPPLEBUMPINESS(num)
end)

ui.add_num_option("Min bumpiness", subs.localSub.water.submenu, 0, 100, 1, function(num)
	MISC.WATER_OVERRIDE_SET_RIPPLEMINBUMPINESS(num)
end)

ui.add_num_option("Max bumpiness", subs.localSub.water.submenu, 0, 100, 1, function(num)
	MISC.WATER_OVERRIDE_SET_RIPPLEMAXBUMPINESS(num)
end)

ui.add_num_option("Disturb", subs.localSub.water.submenu, 0, 5, 1, function(num)
	MISC.WATER_OVERRIDE_SET_RIPPLEDISTURB(num)
end)

features.add_separator("Other", subs.localSub.water.submenu)

ui.add_num_option("Fade in", subs.localSub.water.submenu, 0, 20, 1, function(num)
	MISC.WATER_OVERRIDE_FADE_IN(num)
end)

ui.add_num_option("Fade out", subs.localSub.water.submenu, 0, 20, 1, function(num)
	MISC.WATER_OVERRIDE_FADE_OUT(num)
end)

ui.add_bool_option("Riot mode", subs.localSub.world.submenu, function(state) 
	MISC.SET_RIOT_MODE_ENABLED(state)
end)

ui.add_click_option("Call artillery strike at waypoint", subs.localSub.world.submenu, function()
	local coords = features.getWaypointCoords()
	for i = 1, 20 do
		local a = math.random(-10, 10)
		local b = math.random(-10, 10)
		FIRE.ADD_EXPLOSION(coords.x+a, coords.y-b, coords.z, 34, 300, true, false, 1, false)
		system.yield(500)
	end
end)

subs.localSub.watchDogs = features.addSubmenu("Watch Dogs 2 mode", subs.localSub.main.submenu)

stuff.lastPedOutfit = {}

options['enableWatchDogsMod'] = ui.add_bool_option("Enable", subs.localSub.watchDogs.submenu, function(state)
	if state then
		WEAPON.REMOVE_ALL_PED_WEAPONS(PLAYER.PLAYER_PED_ID(), true)
		WEAPON.GIVE_WEAPON_TO_PED(PLAYER.PLAYER_PED_ID(), utils.joaat("WEAPON_STUNGUN"), 20, false, true)
		stuff.lastPedOutfit = features.getPedInfo(PLAYER.PLAYER_PED_ID())
		features.note("Aim at ped you want to settle in and press E\nDon't use it too often!") 
	end
end)

options['resetModel'] = ui.add_click_option("Reset model", subs.localSub.watchDogs.submenu, function()
	features.cloneToPed(stuff.lastPedOutfit)
end)

features.add_separator("Forced actions", subs.localSub.main.submenu)

ui.add_click_option("Force quit to Story mode", subs.localSub.main.submenu, function() 
	NETWORK._SHUTDOWN_AND_LOAD_MOST_RECENT_SAVE()
end)

ui.add_click_option("Restart game", subs.localSub.main.submenu, function()
	MISC._RESTART_GAME()
end)

ui.add_click_option("Quit & Force update SC", subs.localSub.main.submenu, function()
	MISC._FORCE_SOCIAL_CLUB_UPDATE()
end)

-- NEW SECTION | SPAWNER

subs.spawnerSub = {}
subs.spawnerSub.main = features.addSubmenu("Entities", subs.main)
subs.spawnerSub.peds = {}
subs.spawnerSub.peds.main = features.addSubmenu("NPCs", subs.spawnerSub.main.submenu)
subs.spawnerSub.peds.saved = features.addSubmenu("Saved peds", subs.spawnerSub.peds.main.submenu)
subs.spawnerSub.vehicles = {}
subs.spawnerSub.vehicles.main = features.addSubmenu("Vehicles", subs.spawnerSub.main.submenu)

subs.spawnerSub.vehicles.settings = features.addSubmenu("Settings", subs.spawnerSub.vehicles.main.submenu)
options['spawnerVehicleSettingsPreset'] = ui.add_choose("Use preset", subs.spawnerSub.vehicles.settings.submenu, true, {"Default", "Random", "Max", "Power"}, function() end)
options['spawnerVehicleSettingsInvincible'] = ui.add_bool_option("Spawn invincible", subs.spawnerSub.vehicles.settings.submenu, function() end)
options['spawnerVehicleSettingsInVehicle'] = ui.add_bool_option("Spawn in vehicle", subs.spawnerSub.vehicles.settings.submenu, function() end)
options['spawnerVehicleSettingsInAir'] = ui.add_bool_option("Spawn aircraft in air", subs.spawnerSub.vehicles.settings.submenu, function() end)
options['spawnerVehicleSettingsRemoveLast'] = ui.add_bool_option("Remove previous vehicle", subs.spawnerSub.vehicles.settings.submenu, function() end)

subs.spawnerSub.vehicles.saved = features.addSubmenu("Saved vehicles", subs.spawnerSub.vehicles.main.submenu)
subs.spawnerSub.objects = {}
subs.spawnerSub.objects.main = features.addSubmenu("Objects", subs.spawnerSub.main.submenu)
subs.spawnerSub.objects.saved = features.addSubmenu("Saved objects", subs.spawnerSub.objects.main.submenu)
subs.spawnerSub.weapons = {}
subs.spawnerSub.weapons.main = features.addSubmenu("Weapons", subs.spawnerSub.main.submenu)
subs.spawnerSub.weapons.loadouts = features.addSubmenu("Loadouts", subs.spawnerSub.weapons.main.submenu)

stuff.spawnerOptions = {
	peds = {},
	vehicles = {},
	objects = {}
}

function features.spawnPed(name, hash, coords)
	local spawnedPed
	callbacks.requestModel(hash, function()
		spawnedPed = entities.create_ped(hash, coords)
		table.insert(stuff.spawnerPedsSpawned, spawnedPed)
		local subName = string.format("%s (%i)", name, spawnedPed)
		local optTable = {}
		local bgConfig = {
			godmode = false,
			weapon = 2725352035,
			formation = 0,
			ignorePlayers = false
		}
		local sub = features.addSubmenu(subName, subs.spawnerSub.peds.main.submenu)
		options['spawnedPed_' .. spawnedPed] = sub
		table.insert(optTable, ui.add_click_option("Save", sub.submenu, function()
			features.addRemoveSavedEntity("ped", name, hash, true)
		end))
		table.insert(optTable, features.add_separator("Physics", sub.submenu))
		table.insert(optTable, ui.add_bool_option("Invincible", sub.submenu, function(state)
			ENTITY.SET_ENTITY_INVINCIBLE(spawnedPed, state)
		end))
		table.insert(optTable, features.add_separator("Bodyguard", sub.submenu))
		table.insert(optTable, ui.add_click_option("Make a bodyguard", sub.submenu, function()
			features.makePedABodyguard(spawnedPed, bgConfig.godmode, bgConfig.weapon, bgConfig.formation, bgConfig.ignorePlayers)
		end))
		table.insert(optTable, ui.add_bool_option("Godmode", sub.submenu, function(state)
			bgConfig.godmode = state
			features.makePedABodyguard(spawnedPed, bgConfig.godmode, bgConfig.weapon, bgConfig.formation, bgConfig.ignorePlayers)
		end))
		sub.wep = features.addSubmenu("Weapon", sub.submenu)
		local wepCategories = {}
		for _, wepInfo in ipairs(parsedFiles.weapons) do
			if wepInfo['TranslatedLabel'] ~= nil and wepInfo['Category'] ~= nil then
				local wepName = HUD._GET_LABEL_TEXT(wepInfo['TranslatedLabel']['Name'])
				local wepHash = wepInfo['Hash']
				local wepCategory = wepInfo['Category']
				if wepCategories[wepCategory] == nil then
					wepCategories[wepCategory] = {}
					wepCategories[wepCategory] = features.addSubmenu(wepCategory:gsub('GROUP_', ''), sub.wep.submenu)
				end
				if wepName ~= 'NULL' and wepName ~= 'Invalid' then
					ui.add_click_option(wepName, wepCategories[wepCategory]['submenu'], function()
						bgConfig.weapon = wepHash
						features.makePedABodyguard(spawnedPed, bgConfig.godmode, bgConfig.weapon, bgConfig.formation, bgConfig.ignorePlayers)
					end) 
				end
			end
		end
		table.insert(optTable, ui.add_choose("Formation", sub.submenu, false, {"Default", "Circle Around Leader", "Alt. Circle Around Leader", "Line, with Leader at center"}, function(pos)
			bgConfig.formation = pos
			features.makePedABodyguard(spawnedPed, bgConfig.godmode, bgConfig.weapon, bgConfig.formation, bgConfig.ignorePlayers)
		end))
		table.insert(optTable, ui.add_bool_option("Ignore players", sub.submenu, function(state)
			bgConfig.ignorePlayers = state
			features.makePedABodyguard(spawnedPed, bgConfig.godmode, bgConfig.weapon, bgConfig.formation, bgConfig.ignorePlayers)
		end))
		table.insert(optTable, features.add_separator("Teleport", sub.submenu))
		table.insert(optTable, ui.add_choose("Teleport", sub.submenu, false, {"Ped to me", "Me to ped"}, function(pos)
			if pos == 0 then
				ENTITY.SET_ENTITY_COORDS(spawnedPed, features.getEntityCoords(PLAYER.PLAYER_PED_ID()).x, features.getEntityCoords(PLAYER.PLAYER_PED_ID()).y, features.getEntityCoords(PLAYER.PLAYER_PED_ID()).z, false, false, false, false)
			elseif pos == 1 then
				ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), features.getEntityCoords(spawnedPed).x, features.getEntityCoords(spawnedPed).y, features.getEntityCoords(spawnedPed).z, false, false, false, false)
			end
		end))
		table.insert(optTable, features.add_separator("Misc", sub.submenu))
		table.insert(optTable, ui.add_click_option("Delete", sub.submenu, function()
			entities.delete(spawnedPed)
			for _, option in pairs(optTable) do
				ui.remove(option)
			end
			ui.remove(sub.submenu)
			ui.remove(sub.option)
			ui.remove(sub.wep.submenu)
			ui.remove(sub.wep.option)
		end))
	end)
	return spawnedPed
end

function features.spawnVehicle(hash, coords, ignoreCallback)
	local spawnedVehicle = nil
	callbacks.requestModel(hash, function()	
		spawnedVehicle = entities.create_vehicle(hash, coords)
		table.insert(stuff.spawnerVehiclesSpawned, spawnedVehicle)
		if not ignoreCallback then
			on_vehicle_spawn(hash, spawnedVehicle) 
		end
	end)
	return spawnedVehicle
end

function features.spawnUfo(coords, onSuccess)
	local ufoHash = utils.joaat("p_spinning_anus_s")
	local vehicleHash = utils.joaat("strikeforce")
	local spawnedVehicle = features.spawnVehicle(vehicleHash, coords, true)
	callbacks.requestModel(ufoHash, function()
		local spawnedUfo = entities.create_object(ufoHash, coords)
		ENTITY.SET_ENTITY_VISIBLE(spawnedVehicle, false, 0)
		ENTITY.SET_ENTITY_COLLISION(spawnedUfo, false, false)
		features.setVehiclePreset(spawnedVehicle, 3)
		ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnedUfo, spawnedVehicle, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, true, true, false, false, 0, true)
		onSuccess(spawnedVehicle)
	end)
end

function features.send_ufo_attacker(pid, godmode, count)
    local target_ped = features.getPlayerPed(pid)
	local pedHash = utils.joaat("s_m_y_pilot_01")
	for i=1, count do
		local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(target_ped, math.random(-50, 50),  math.random(-50, 50), 150.0)
		features.spawnUfo(coords, function(handle)
			if godmode then
				ENTITY.SET_ENTITY_INVINCIBLE(handle, true)
			end
			callbacks.requestModel(pedHash, function()
				local ped = entities.create_ped(pedHash, coords)
				PED.SET_PED_INTO_VEHICLE(ped, handle, -1)
				TASK.TASK_PLANE_MISSION(ped, handle, 0, target_ped, 0, 0, 0, 6, 0.0, 0, 0.0, 50.0, 40.0, 0)
				PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
				PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
				TASK.TASK_COMBAT_PED(ped, target_ped, 0, 16)
				PED.SET_PED_COMBAT_ABILITY(ped, 2)
				PED.SET_PED_ACCURACY(ped, 100.0)
				PED.SET_PED_ARMOUR(ped, 200)
				PED.SET_PED_MAX_HEALTH(ped, 1000)
				ENTITY.SET_ENTITY_HEALTH(ped, 1000, 0)
			end)
		end)
	end
end


function features.spawnVehicleCopy(value)
	local vehicleInfo
	if type(value) == 'number' and features.doesEntityExist(value) then 
		vehicleInfo = features.getVehicleInfo(value)
	elseif type(value) == 'table' then 
		vehicleInfo = value 
	else
		return 
	end
	callbacks.requestModel(vehicleInfo['hash'], function()
		local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 5, 0)
		local vehicleClone = features.spawnVehicle(vehicleInfo['hash'], coords, false)
		entities.request_control(vehicleClone, function(handle)
			VEHICLE.SET_VEHICLE_MOD_KIT(handle, 0)
			VEHICLE.SET_VEHICLE_WHEEL_TYPE(handle,vehicleInfo['wheelType'])
			for modType, modID in pairs(vehicleInfo['mods']) do
				VEHICLE.SET_VEHICLE_MOD(handle, tonumber(modType), tonumber(modID), false)
			end
			VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(handle, vehicleInfo['tyresCanBurst'])
			
			VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(handle, vehicleInfo['colors']['prim']['r'], vehicleInfo['colors']['prim']['g'], vehicleInfo['colors']['prim']['b'])
			VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(handle, vehicleInfo['colors']['sec']['r'], vehicleInfo['colors']['sec']['g'], vehicleInfo['colors']['sec']['b'])
			VEHICLE.SET_VEHICLE_EXTRA_COLOURS(handle, vehicleInfo['extraColors']['pearl'], vehicleInfo['extraColors']['wheels'])
			VEHICLE.SET_VEHICLE_LIVERY(handle, vehicleInfo['livery'])
			VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(handle, vehicleInfo['plateText'])
			VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(handle, vehicleInfo['plateType'])
			VEHICLE._SET_VEHICLE_XENON_LIGHTS_COLOR(handle, vehicleInfo['xenonColor'])
			VEHICLE.SET_CONVERTIBLE_ROOF_LATCH_STATE(handle, vehicleInfo['roofState'])
			VEHICLE._SET_VEHICLE_NEON_LIGHTS_COLOUR(handle, vehicleInfo['neonColors']['red'], vehicleInfo['neonColors']['green'], vehicleInfo['neonColors']['blue'])
			VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(handle, vehicleInfo['tyreSmoke']['red'], vehicleInfo['tyreSmoke']['green'], vehicleInfo['tyreSmoke']['blue'])
			VEHICLE.SET_VEHICLE_WINDOW_TINT(handle, vehicleInfo['windowTint'])
			VEHICLE._SET_VEHICLE_INTERIOR_COLOR(handle, vehicleInfo['interiorColor'])
			VEHICLE._SET_VEHICLE_DASHBOARD_COLOR(handle, vehicleInfo['dashboardColor'])
			for i = 0, 3 do
				VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(handle, i, vehicleInfo['neonlights'][i])
			end
			for _, extraID in ipairs(vehicleInfo['extras']) do
				VEHICLE.SET_VEHICLE_EXTRA(handle, extraID, false)
			end
		end)
		return vehicleClone
	end)
end

function features.spawnObject(name, coords)
	local hash = utils.joaat(name)
	local spawnedObject
	callbacks.requestModel(hash, function()
		spawnedObject = entities.create_object(hash, coords)
		table.insert(stuff.spawnerObjectsSpawned, spawnedObject)
		ENTITY.SET_ENTITY_PROOFS(PLAYER.PLAYER_PED_ID(), invincible, invincible, invincible, invincible, invincible, invincible, true, false)
		local subName = string.format("%s (%i)", name, spawnedObject)
		local optTable = {}
		local sub = features.addSubmenu(subName, subs.spawnerSub.objects.main.submenu)
		options['spawnedObject_' .. spawnedObject] = sub
		table.insert(optTable, ui.add_click_option("Save", sub.submenu, function()
			features.addRemoveSavedEntity('object', name, hash, true)
		end))
		table.insert(optTable, features.add_separator("Physics", sub.submenu))
		table.insert(optTable, ui.add_choose("Disable collision", sub.submenu, true, {"None", "Disable", "Disable & Keep Physics"}, function(pos)
			ENTITY.SET_ENTITY_COLLISION(spawnedObject, pos == 0, pos == 3)
		end))
		table.insert(optTable, ui.add_bool_option("Invincible", sub.submenu, function(state)
			ENTITY.SET_ENTITY_INVINCIBLE(spawnedObject, state)
		end))
		table.insert(optTable, ui.add_bool_option("Invisible", sub.submenu, function(state)
			ENTITY.SET_ENTITY_VISIBLE(spawnedObject, not state, false)
		end))
		table.insert(optTable, ui.add_num_option("Alpha", sub.submenu, 0, 255, 1, function(num)
			ENTITY.SET_ENTITY_ALPHA(spawnedObject, num, false)
		end))
		table.insert(optTable, ui.add_bool_option("No gravity", sub.submenu, function(state)
			ENTITY.SET_ENTITY_HAS_GRAVITY(spawnedObject, not state)
		end))
		table.insert(optTable, features.add_separator("Rotation", sub.submenu))
		local function getEntityRotation(entity)
			return ENTITY.GET_ENTITY_ROTATION(entity, 5)
		end
		table.insert(optTable, ui.add_num_option("Pitch", sub.submenu, 0, 360, 1, function(num)
			ENTITY.SET_ENTITY_ROTATION(spawnedObject, num, getEntityRotation(spawnedObject).y, getEntityRotation(spawnedObject).z, 5, true)
		end))
		table.insert(optTable, ui.add_num_option("Roll", sub.submenu, 0, 360, 1, function(num)
			ENTITY.SET_ENTITY_ROTATION(spawnedObject, getEntityRotation(spawnedObject).x, num, getEntityRotation(spawnedObject).z, 5, true)
		end))
		table.insert(optTable, ui.add_num_option("Yaw", sub.submenu, 0, 360, 1, function(num)
			ENTITY.SET_ENTITY_ROTATION(spawnedObject, getEntityRotation(spawnedObject).x, getEntityRotation(spawnedObject).y, num, 5, true)
		end))
		table.insert(optTable, features.add_separator("Position", sub.submenu))
		table.insert(optTable, ui.add_float_option("X", sub.submenu, -10024.0, 10024.0, 0.1, 5, function(num)
			ENTITY.SET_ENTITY_COORDS(spawnedObject, num, features.getEntityCoords(spawnedObject).y, features.getEntityCoords(spawnedObject).z, false, false, false, false)
		end))
		ui.set_value(optTable[#optTable], features.getEntityCoords(spawnedObject).x, true)
		table.insert(optTable, ui.add_float_option("Y", sub.submenu, -10024.0, 10024.0, 0.1, 5, function(num)
		local entity_coords = ENTITY.GET_ENTITY_COORDS(spawnedObject, false)
			ENTITY.SET_ENTITY_COORDS(spawnedObject, features.getEntityCoords(spawnedObject).x, num, features.getEntityCoords(spawnedObject).z, false, false, false, false)
		end))
		ui.set_value(optTable[#optTable], features.getEntityCoords(spawnedObject).y, true)
		table.insert(optTable, ui.add_float_option("Z", sub.submenu, -10024.0, 10024.0, 0.1, 5, function(num)
			ENTITY.SET_ENTITY_COORDS(spawnedObject, features.getEntityCoords(spawnedObject).x, features.getEntityCoords(spawnedObject).y, num, false, false, false, false)
		end))
		ui.set_value(optTable[#optTable], features.getEntityCoords(spawnedObject).z, true)
		table.insert(optTable, features.add_separator("Teleport", sub.submenu))
		table.insert(optTable, ui.add_choose("Teleport", sub.submenu, false, {"Object to me", "Me to object"}, function(pos)
			if pos == 0 then
				ENTITY.SET_ENTITY_COORDS(spawnedObject, features.getEntityCoords(PLAYER.PLAYER_PED_ID()).x, features.getEntityCoords(PLAYER.PLAYER_PED_ID()).y, features.getEntityCoords(PLAYER.PLAYER_PED_ID()).z, false, false, false, false)
			elseif pos == 1 then
				ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), features.getEntityCoords(spawnedObject).x, features.getEntityCoords(spawnedObject).y, features.getEntityCoords(spawnedObject).z, false, false, false, false)
			end
		end))
		table.insert(optTable, features.add_separator("Misc", sub.submenu))
		table.insert(optTable, ui.add_click_option("Delete", sub.submenu, function()
			entities.delete(spawnedObject)
			for _, option in pairs(optTable) do
				ui.remove(option)
			end
			ui.remove(sub.submenu)
			ui.remove(sub.option)
		end))
	end)
	return spawnedObject
end

stuff.savedPeds = {}
stuff.savedVehicles = {}
stuff.savedObjects = {}

if doesFileExist(paths.configs.savedPeds) then
	for ped, hash in pairs(json:decode(io.open(paths.configs.savedPeds, 'r'):read('*all'))) do
		stuff.savedPeds[ped] = ui.add_choose(ped, subs.spawnerSub.peds.saved.submenu, false, {"Spawn", "Remove"}, function(pos)
			if pos == 0 then
				local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 5, 0)
				features.spawnPed(ped, hash, coords)
			else
				features.addRemoveSavedEntity("ped", ped, hash, false)
			end
		end)
	end
end

options['savedVehicleName'] = ui.add_input_string("Name", subs.spawnerSub.vehicles.saved.submenu, function() end)
ui.set_value(options['savedVehicleName'], "Empty", true)

options['saveVehicle'] = ui.add_click_option("Save", subs.spawnerSub.vehicles.saved.submenu, function()
	local vehicle = features.getLocalVehicle(false)
	if not features.doesEntityExist(vehicle) or PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), false) == 0 then return end
	local path = paths.folders.savedVehicles .. "\\" ..  ui.get_value(options['savedVehicleName'])
	local file = io.open(path, 'w+')
	local table = features.getVehicleInfo(vehicle)
	file:write(json:encode_pretty(table))
	file:close()
	features.reloadSavedVehicles()
end)

-- options['savedVehiclesSep'] = ui.add_separator("Auto spawner", subs.spawnerSub.vehicles.saved.submenu)

options['savedVehiclesSep'] = ui.add_separator("Vehicles", subs.spawnerSub.vehicles.saved.submenu)

function features.reloadSavedVehicles()
	if not doesFolderExist(paths.folders.savedVehicles) then return end
	for _, optionID in ipairs(stuff.savedVehicles) do
		ui.remove(optionID)
	end
	for line in io.popen("dir \"" .. paths.folders.savedVehicles .. "\" /a /b", "r"):lines() do
		table.insert(stuff.savedVehicles, ui.add_choose(tostring(line), subs.spawnerSub.vehicles.saved.submenu, false, {"Spawn", "Set as default", "Remove default state"}, function(pos)
			local path = paths.folders.savedVehicles .. "\\" ..  line
			if not doesFileExist(path) then features.alert(string.format("Failed to load: %s | File doesnt exist anymore!", path)) return end
			local file = io.open(path, 'r')
			local content = json:decode(file:read('*all'))
			file:close()
			if pos == 0 then
				features.spawnVehicleCopy(content)
			elseif pos == 1 then
				features.note("Set that vehicle as default\nIt will be spawned every session")
				parsedFiles.defaults.vehicle = path
				features.manageDefault()
			else
				features.note("Disabled auto spawn for that vehicle")
				parsedFiles.defaults.vehicle = nil
				features.manageDefault()
			end
		end))
	end
end

features.reloadSavedVehicles()

if doesFileExist(paths.configs.savedObjects) then
	for object, hash in pairs(json:decode(io.open(paths.configs.savedObjects, 'r'):read('*all'))) do
		stuff.savedObjects[object] = ui.add_choose(object, subs.spawnerSub.objects.saved.submenu, false, {"Spawn", "Remove"}, function(pos)
			if pos == 0 then
				local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 5, 0)
				features.spawnObject(object, coords)
			else
				features.addRemoveSavedEntity("object", object, hash, false)
			end
		end)
	end
end

function features.reloadSavedPeds()
	local file = io.open(paths.configs.savedPeds, 'w+')
	local table = {}
	for name, _ in pairs(stuff.savedPeds) do
		table[name] = utils.joaat(name)
	end
	file:write(json:encode_pretty(table))
	file:close()
end

function features.reloadSavedObjects()
	local file = io.open(paths.configs.savedObjects, 'w+')
	local table = {}
	for name, _ in pairs(stuff.savedObjects) do
		table[name] = utils.joaat(name)
	end
	file:write(json:encode_pretty(table))
	file:close()
end

function features.addRemoveSavedEntity(type, name, hash, add)
	if type == 'ped' then
		if add then
			if stuff.savedPeds[name] == nil then
				stuff.savedPeds[name] = ui.add_choose(name, subs.spawnerSub.peds.saved.submenu, false, {"Spawn", "Remove"}, function(pos)
					if pos == 0 then
						local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 5, 0)
						features.spawnPed(name, hash, coords)
					else
						features.addRemoveSavedEntity("ped", name, hash, false)
					end
				end)
			else
				features.alert("You alreay have that ped saved.")
			end
		else
			ui.remove(stuff.savedPeds[name])
			stuff.savedPeds[name] = nil
		end
		features.reloadSavedPeds()
	elseif type == 'object' then
		if add then
			if stuff.savedObjects[name] == nil then
				stuff.savedObjects[name] = ui.add_choose(name, subs.spawnerSub.objects.saved.submenu, false, {"Spawn", "Remove"}, function(pos)
					if pos == 0 then
						local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 5, 0)
						features.spawnObject(name, coords)
					else
						features.addRemoveSavedEntity("object", name, hash, false)
					end
				end)
			else
				features.alert("You alreay have that object saved.")
			end
		else
			ui.remove(stuff.savedObjects[name])
			stuff.savedObjects[name] = nil
		end
		features.reloadSavedObjects()
	end
end

do
	subs.spawnerSub.peds.types = features.addSubmenu("Types", subs.spawnerSub.peds.main.submenu)
	stuff.spawnerPedCategories = {}
	stuff.spawnerPedsSpawned = {}
	for _, pedInfo in ipairs(parsedFiles.peds) do
		local pedType = features.getPedTypeName(pedInfo['Pedtype'])
		if stuff['spawnerPedCategories'][pedType] == nil then
			stuff['spawnerPedCategories'][pedType] = {}
			stuff['spawnerPedCategories'][pedType] = features.addSubmenu(pedType, subs.spawnerSub.peds.types.submenu)
		end
		ui.add_choose(pedInfo['Name'], stuff['spawnerPedCategories'][pedType]['submenu'], false, {'Spawn', 'Save'}, function(pos) 
			if pos == 0 then
				local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 5, 0)
				local hash = pedInfo['Hash']
				features.spawnPed(pedInfo['Name'], hash, coords)
			else
				features.addRemoveSavedEntity('ped', pedInfo['Name'], pedInfo['Hash'], true)
			end
		end)
	end
	subs.spawnerSub.peds.search = features.addSubmenu("Search", subs.spawnerSub.peds.main.submenu)
	ui.add_input_string("Name", subs.spawnerSub.peds.search.submenu, function(text)
		if features.isEmpty(text) then return end
		for _, option in ipairs(stuff.spawnerOptions.peds) do
			ui.remove(option)
		end
		for _, pedInfo in ipairs(parsedFiles.peds) do
			local name = pedInfo['Name']
			if name:find(text) or (string.upper(name)):find(text) or (string.lower(name)):find(text) then
				table.insert(stuff.spawnerOptions.peds, ui.add_choose(name, subs.spawnerSub.peds.search.submenu, false, {'Spawn', 'Save'}, function(pos)
					if pos == 0 then
						local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 5, 0)
						local hash = pedInfo['Hash']
						features.spawnPed(pedInfo['Name'], hash, coords)
					else
						features.addRemoveSavedEntity('ped', pedInfo['Name'], pedInfo['Hash'], true)
					end
				end))
			end
		end
	end)
	features.add_separator("Spawned peds", subs.spawnerSub.peds.main.submenu)
end

do
	subs.spawnerSub.vehicles.classes = features.addSubmenu("Classes", subs.spawnerSub.vehicles.main.submenu)
	subs.spawnerSub.vehicles.dlcs = features.addSubmenu("DLCs", subs.spawnerSub.vehicles.main.submenu)
	subs.spawnerSub.vehicles.search = features.addSubmenu("Search", subs.spawnerSub.vehicles.main.submenu)
	stuff.spawnerVehicleCategories = {}
	stuff.spawnerVehicleDLCs = {}
	stuff.spawnerVehiclesSpawned = {}
	for _, vehicleInfo in ipairs(parsedFiles.vehicles) do
		local labelText = HUD._GET_LABEL_TEXT(vehicleInfo['Name'])
		if labelText ~= "NULL" then
			local vehicleClass = vehicleInfo['Class']
			if stuff['spawnerVehicleCategories'][vehicleClass] == nil then
				stuff['spawnerVehicleCategories'][vehicleClass] = features.addSubmenu(HUD._GET_LABEL_TEXT(string.format("VEH_CLASS_%i", VEHICLE.GET_VEHICLE_CLASS_FROM_NAME(vehicleInfo['Hash']))), subs.spawnerSub.vehicles.classes.submenu)
			end
			local vehicleDLC = features.getDLCName(vehicleInfo['DlcName'])
			if stuff['spawnerVehicleDLCs'][vehicleDLC] == nil then
				stuff['spawnerVehicleDLCs'][vehicleDLC] = features.addSubmenu(vehicleDLC, subs.spawnerSub.vehicles.dlcs.submenu)
			end
			ui.add_click_option(labelText, stuff['spawnerVehicleCategories'][vehicleClass]['submenu'], function() 
				local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 5, 0)
				local hash = vehicleInfo['Hash']
				features.spawnVehicle(hash, coords, false)
			end)
			ui.add_click_option(labelText, stuff['spawnerVehicleDLCs'][vehicleDLC]['submenu'], function() 
				local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 5, 0)
				local hash = vehicleInfo['Hash']
				features.spawnVehicle(hash, coords, false)
			end)
		end
	end
	ui.add_input_string("Name", subs.spawnerSub.vehicles.search.submenu, function(text)
		if features.isEmpty(text) then return end
		for _, option in pairs(stuff.spawnerOptions.vehicles) do
			ui.remove(option)
		end
		for _, vehicleInfo in ipairs(parsedFiles.vehicles) do
			local name = vehicleInfo['Name']
			local labelText = HUD._GET_LABEL_TEXT(name)
			if labelText ~= 'NULL' then
				if name:find(text) or (string.upper(name)):find(text) or (string.lower(name)):find(text) or labelText:find(text) or (string.upper(labelText)):find(text) or (string.lower(labelText)):find(text) then
					table.insert(stuff.spawnerOptions.vehicles, ui.add_click_option(labelText, subs.spawnerSub.vehicles.search.submenu, function() 
						local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 5, 0)
						features.spawnVehicle(vehicleInfo['Hash'], coords, false)
					end))
				end
			end
		end
	end)
	features.add_separator("Spawned vehicles", subs.spawnerSub.vehicles.main.submenu)
end

do
	stuff.spawnerObjectsSpawned = {}
	subs.spawnerSub.objects.search = features.addSubmenu("Search", subs.spawnerSub.objects.main.submenu)
	ui.add_input_string("Name", subs.spawnerSub.objects.search.submenu, function(text)
		if features.isEmpty(text) then return end
		for _, option in pairs(stuff.spawnerOptions.objects) do
			ui.remove(option)
		end
		for _, objectName in ipairs(parsedFiles.objects) do
			if objectName:find(text) or (string.upper(objectName)):find(text) or (string.lower(objectName)):find(text) then
				table.insert(stuff.spawnerOptions.objects, ui.add_choose(objectName, subs.spawnerSub.objects.search.submenu, false, {'Spawn', 'Save'}, function(pos)
					if pos == 0 then
						local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 5, 0)
						features.spawnObject(objectName, coords)
					else
						features.addRemoveSavedEntity('object', objectName, utils.joaat(objectName), true)
					end
				end))
			end
		end
	end)
	features.add_separator("Spawned objects", subs.spawnerSub.objects.main.submenu)
end		

stuff.blWepCategories = {["GROUP_DIGISCANNER"] = false, ["GROUP_NIGHTVISION"] = false, ["GROUP_TRANQILIZER"] = false}

options['loadoutName'] = ui.add_input_string("Name", subs.spawnerSub.weapons.loadouts.submenu, function() end)
ui.add_click_option("Save", subs.spawnerSub.weapons.loadouts.submenu, function()
	features.note("Loadout is saving...\nMay provide a strong lag but everything is fine.")
	local configTable = {}
	for _, wepInfo in ipairs(parsedFiles.weapons) do
		if 
		features.doesPedHaveWeapon(PLAYER.PLAYER_PED_ID(), wepInfo['Hash'])
		and not features.isEmpty(wepInfo['Category']) 
		and stuff.blWepCategories[wepInfo['Category']] ~= false
		and not features.isEmpty(wepInfo['TranslatedLabel']) 
		and not features.isEmpty(wepInfo['TranslatedLabel']['Name'])
		and wepInfo['TranslatedLabel']['Name'] ~= 'WT_INVALID'
		and not features.isEmpty(wepInfo['Tints'])
		then
			configTable[wepInfo['Name']] = {}
			configTable[wepInfo['Name']]['Name'] = wepInfo['TranslatedLabel']['Name']
			configTable[wepInfo['Name']]['Hash'] = wepInfo['Hash']
			configTable[wepInfo['Name']]['TintIndex'] = WEAPON.GET_PED_WEAPON_TINT_INDEX(PLAYER.PLAYER_PED_ID(), wepInfo['Hash'])
			configTable[wepInfo['Name']]['Components'] = {}
			for _, componentInfo in ipairs(wepInfo['Components']) do
				if 
				features.doesPedHaveWeaponComponent(PLAYER.PLAYER_PED_ID(), wepInfo['Hash'], componentInfo['Hash'])
				and not features.isEmpty(componentInfo['TranslatedLabel']) 
				and not features.isEmpty(componentInfo['TranslatedLabel']['Name']) 
				then
					configTable[wepInfo['Name']]['Components'][componentInfo['TranslatedLabel']['Name']] = {}
					configTable[wepInfo['Name']]['Components'][componentInfo['TranslatedLabel']['Name']]['Name'] = componentInfo['TranslatedLabel']['Name']
					configTable[wepInfo['Name']]['Components'][componentInfo['TranslatedLabel']['Name']]['Hash'] = componentInfo['Hash']
				end
			end
		end
		local file = io.open(paths.folders.wepLoadouts .. '\\' .. ui.get_value(options['loadoutName']), "w+")
		file:write(json:encode_pretty(configTable))
		file:close()
		features.reloadWepLoadouts()
	end
end)

ui.add_click_option("Reload loadouts", subs.spawnerSub.weapons.loadouts.submenu, function()
	features.reloadWepLoadouts()
end)

ui.add_separator("Loadouts",  subs.spawnerSub.weapons.loadouts.submenu)

stuff.displayedWepLoadouts = {}

function features.loadWepLoadout(path)
	if not doesFileExist(path) then features.alert(string.format("Failed to load: %s | File doesnt exist anymore!", path)) return end
	local file = io.open(path, "r")
	features.note("Loading loadout...")
	WEAPON.REMOVE_ALL_PED_WEAPONS(PLAYER.PLAYER_PED_ID(), false)
	for _, wepInfo in pairs(json:decode(file:read('*all'))) do
		features.giveWeaponToPed(PLAYER.PLAYER_PED_ID(), wepInfo['Hash'])
		WEAPON.SET_PED_WEAPON_TINT_INDEX(PLAYER.PLAYER_PED_ID(), wepInfo['Hash'], wepInfo['TintIndex'])
		for _, componentInfo in pairs(wepInfo['Components']) do
			WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(PLAYER.PLAYER_PED_ID(), wepInfo['Hash'], componentInfo['Hash'])
		end
	end
end

function features.reloadWepLoadouts()
	features.note("Reloading loadouts...")
	for _, id in ipairs(stuff.displayedWepLoadouts) do
		ui.remove(id)
	end
	for line in io.popen("dir \"" .. paths.folders.wepLoadouts .. "\" /a /b", "r"):lines() do
		table.insert(stuff.displayedWepLoadouts, ui.add_choose(tostring(line), subs.spawnerSub.weapons.loadouts.submenu, false, {"Load", "Set as default", "Remove default state"}, function(pos)
			local path = paths.folders.wepLoadouts .. "\\" ..  line
			if pos == 0 then
				features.loadWepLoadout(path)
			elseif pos == 1 then
				parsedFiles.defaults.wepLoadout = path
				features.manageDefault()
			else
				parsedFiles.defaults.wepLoadout = nil
				features.manageDefault()
			end
		end))
	end
end

features.reloadWepLoadouts()

ui.add_click_option("Remove all weapons", subs.spawnerSub.weapons.main.submenu, function()
	WEAPON.REMOVE_ALL_PED_WEAPONS(PLAYER.PLAYER_PED_ID(), false)
end)

features.add_separator("Categories", subs.spawnerSub.weapons.main.submenu)

if doesFileExist(paths.dumps.weapons) then
	local ped = PLAYER.PLAYER_PED_ID()
	local createdCateg = {}
	local createdWepSubs = {}
	for _, wepInfo in ipairs(parsedFiles.weapons) do
		if 
		not features.isEmpty(wepInfo['Category']) 
		and features.isEmpty(stuff.blWepCategories[wepInfo['Category']])
		and not features.isEmpty(wepInfo['TranslatedLabel']) 
		and not features.isEmpty(wepInfo['TranslatedLabel']['Name'])
		and wepInfo['TranslatedLabel']['Name'] ~= 'WT_INVALID'
		and not features.isEmpty(wepInfo['Tints'])
		then
			if features.isEmpty(createdCateg[wepInfo['Category']]) then
				createdCateg[wepInfo['Category']] = features.addSubmenu(features.makeFirstLetUpper((wepInfo['Category']:gsub('GROUP_', '')):lower()), subs.spawnerSub.weapons.main.submenu)
			end
			createdWepSubs[wepInfo['TranslatedLabel']['Name']] = features.addSubmenu(HUD._GET_LABEL_TEXT(wepInfo['TranslatedLabel']['Name']), createdCateg[wepInfo['Category']]['submenu'])
			ui.add_choose("Manage", createdWepSubs[wepInfo['TranslatedLabel']['Name']]['submenu'], false, {"Give", "Remove"}, function(pos)
				if pos == 0 then
					features.giveWeaponToPed(PLAYER.PLAYER_PED_ID(), wepInfo['Hash'])
				else
					WEAPON.REMOVE_WEAPON_FROM_PED(PLAYER.PLAYER_PED_ID(), wepInfo['Hash'])
				end
			end)
			for _, componentInfo in ipairs(wepInfo['Components']) do
				if 
				not features.isEmpty(componentInfo['TranslatedLabel']) 
				and not features.isEmpty(componentInfo['TranslatedLabel']['Name']) 
				then
					ui.add_choose(HUD._GET_LABEL_TEXT(componentInfo['TranslatedLabel']['Name']), createdWepSubs[wepInfo['TranslatedLabel']['Name']]['submenu'], false, {"Add", "Remove"}, function(pos)
						if pos == 0 then
							WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(PLAYER.PLAYER_PED_ID(), wepInfo['Hash'], componentInfo['Hash'])
						else
							WEAPON.REMOVE_WEAPON_COMPONENT_FROM_PED(PLAYER.PLAYER_PED_ID(), wepInfo['Hash'], componentInfo['Hash'])
						end
					end)
				end
			end
			local tintsSub = features.addSubmenu("Tint", createdWepSubs[wepInfo['TranslatedLabel']['Name']]['submenu'])
			for _, tintInfo in ipairs(wepInfo['Tints']) do
				if not features.isEmpty(tintInfo['TranslatedLabel']) and not features.isEmpty(tintInfo['TranslatedLabel']['Name']) then
					ui.add_click_option(HUD._GET_LABEL_TEXT(tintInfo['TranslatedLabel']['Name']), tintsSub.submenu, function()
						WEAPON.SET_PED_WEAPON_TINT_INDEX(PLAYER.PLAYER_PED_ID(), wepInfo['Hash'], tintInfo['Index'])
					end)
				end
			end
		end
	end
end

subs.spawnerSub.modelSwap = features.addSubmenu("Object swap", subs.spawnerSub.main.submenu)

stuff.savedSwaps = {}
stuff.displayedSwaps = {}
stuff.deletedSwaps = {}

if doesFileExist(paths.configs.savedSwaps) then
	for _, swapInfo in ipairs(json:decode(io.open(paths.configs.savedSwaps):read('*all'))) do
		table.insert(stuff.savedSwaps, swapInfo)
	end
end

function features.reloadSavedSwaps()
	for id, optionID in ipairs(stuff.displayedSwaps) do
		ui.remove(optionID)
		stuff.displayedSwaps[id] = nil
	end
	local file = io.open(paths.configs.savedSwaps, 'w+')
	file:write(json:encode_pretty(stuff.savedSwaps))
	file:close()
	for _, swapInfo in pairs(stuff.savedSwaps) do
		table.insert(stuff.displayedSwaps, ui.add_choose(swapInfo['name'], subs.spawnerSub.modelSwap.submenu, false, {"Create", "Remove", "Delete"}, function(pos)
			if not features.isModelValid(tonumber(swapInfo['original'])) or not features.isModelValid(tonumber(swapInfo['new'])) then features.alert("Invalid swap data") return end
			local coords = features.getEntityCoords(PLAYER.PLAYER_PED_ID())
			if pos == 0 then
				ENTITY.CREATE_MODEL_SWAP(coords.x, coords.y, coords.z, swapInfo['radius'], swapInfo['original'], swapInfo['new'], false)
			elseif pos == 1 then
				ENTITY.REMOVE_MODEL_SWAP(coords.x, coords.y, coords.z, swapInfo['radius'], swapInfo['original'], swapInfo['new'], false)
			end
		end))
	end
end


options['modelSwapFrom'] = ui.add_input_string("Original", subs.spawnerSub.modelSwap.submenu, function() end)
options['modelSwapTo'] = ui.add_input_string("New", subs.spawnerSub.modelSwap.submenu, function() end)
options['modelSwapRadius'] = ui.add_num_option("Radius", subs.spawnerSub.modelSwap.submenu, 0, 1000, 1, function() end)
ui.set_value(options['modelSwapRadius'], 300, true)
options['modelSwapMode'] = ui.add_choose("Input value type", subs.spawnerSub.modelSwap.submenu, true, {"Name", "Hash"}, function() end)
options['createSwap'] = ui.add_click_option("Create swap", subs.spawnerSub.modelSwap.submenu, function() 
	if features.isEmpty(ui.get_value(options['modelSwapFrom'])) or features.isEmpty(ui.get_value(options['modelSwapTo'])) then return end
	local outTable = {}
	outTable['name'] = string.format("%s -> %s", ui.get_value(options['modelSwapFrom']), ui.get_value(options['modelSwapTo']))
	if ui.get_value(options['modelSwapMode']) == 0 then
		outTable['original'] = utils.joaat(ui.get_value(options['modelSwapFrom']))
		outTable['new'] = utils.joaat(ui.get_value(options['modelSwapTo']))
	else
		outTable['original'] = tonumber(ui.get_value(options['modelSwapFrom']))
		outTable['new'] = tonumber(ui.get_value(options['modelSwapTo']))
	end
	outTable['radius'] = ui.get_value(options['modelSwapRadius'])
	table.insert(stuff.savedSwaps, outTable)
	features.reloadSavedSwaps()
end)
ui.add_separator("Saved swaps", subs.spawnerSub.modelSwap.submenu)

features.reloadSavedSwaps()


subs.spawnerSub.modelChange = features.addSubmenu("Model change", subs.spawnerSub.main.submenu)
subs.spawnerSub.modelChange.saved = features.addSubmenu("Saved models", subs.spawnerSub.modelChange.submenu)

stuff.savedModels = {}
stuff.displayedModels = {}

if doesFileExist(paths.configs.savedModels) then
	for name, hash in pairs(json:decode(io.open(paths.configs.savedModels):read('*all'))) do
		stuff.savedModels[name] = hash
	end
end

function features.reloadSavedModels()
	for id, optionID in ipairs(stuff.displayedModels) do
		ui.remove(optionID)
		stuff.displayedModels[id] = nil
	end
	local file = io.open(paths.configs.savedModels, 'w+')
	file:write(json:encode_pretty(stuff.savedModels))
	file:close()
	for name, hash in pairs(stuff.savedModels) do
		table.insert(stuff.displayedModels, ui.add_choose(name, subs.spawnerSub.modelChange.saved.submenu, false, {'Set model', 'Remove'}, function(pos) 
			if pos == 0 then
				if stuff.originalModel == nil then stuff.originalModel = features.getPedInfo(PLAYER.PLAYER_PED_ID()) end
				features.setModel(hash)
			else
				stuff.savedModels[name] = nil
				features.reloadSavedModels()
			end
		end))
	end
end

do
	subs.spawnerSub.modelChange.types = features.addSubmenu("Types", subs.spawnerSub.modelChange.submenu)
	stuff.spawnerModelCategories = {}
	stuff.originalModel = nil
	stuff.spawnerOptions.models = {}
	subs.spawnerSub.modelChange.search = features.addSubmenu("Search", subs.spawnerSub.modelChange.submenu)
	ui.add_input_string("Name", subs.spawnerSub.modelChange.search.submenu, function(text)
		if features.isEmpty(text) then return end
		for _, option in ipairs(stuff.spawnerOptions.models) do
			ui.remove(option)
		end
		for _, pedInfo in ipairs(parsedFiles.peds) do
			local name = pedInfo['Name']
			if name:find(text) or (string.upper(name)):find(text) or (string.lower(name)):find(text) then
				table.insert(stuff.spawnerOptions.models, ui.add_choose(name, subs.spawnerSub.modelChange.search.submenu, false, {'Set model', 'Save'}, function(pos)
					if pos == 0 then
						if stuff.originalModel == nil then stuff.originalModel = features.getPedInfo(PLAYER.PLAYER_PED_ID()) end
						features.setModel(pedInfo['Hash'])
					else
						stuff.savedModels[pedInfo['Name']] = pedInfo['Hash']
						features.reloadSavedModels()
					end
				end))
			end
		end
	end)
	for _, pedInfo in ipairs(parsedFiles.peds) do
		local pedType = features.getPedTypeName(pedInfo['Pedtype'])
		if stuff['spawnerModelCategories'][pedType] == nil then
			stuff['spawnerModelCategories'][pedType] = features.addSubmenu(pedType, subs.spawnerSub.modelChange.types.submenu)
		end
		ui.add_choose(pedInfo['Name'], stuff['spawnerModelCategories'][pedType]['submenu'], false, {'Set model', 'Save'}, function(pos) 
			if pos == 0 then
				if stuff.originalModel == nil then stuff.originalModel = features.getPedInfo(PLAYER.PLAYER_PED_ID()) end
				features.setModel(pedInfo['Hash'])
			else
				stuff.savedModels[pedInfo['Name']] = pedInfo['Hash']
				features.reloadSavedModels()
			end
		end)
	end
	options['spawnerResetModel'] = ui.add_click_option("Reset model", subs.spawnerSub.modelChange.submenu, function()
		features.cloneToPed(stuff.originalModel)
	end)
	ui.add_separator("Results", subs.spawnerSub.modelChange.search.submenu)
end

features.reloadSavedModels()

-- NEW SECTION | VEHICLE

subs.vehicleSub = {}
subs.vehicleSub.main = features.addSubmenu("Vehicle", subs.main)

ui.add_click_option("Teleport in a nearest vehicle", subs.vehicleSub.main.submenu, function()
	local vehicle = features.getClosestVehicle()
	local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1, false)
	if VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, -1, false) == 1 then
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), vehicle, -1)
    else
		if PED.IS_PED_A_PLAYER(driver) == 0 then
			entities.delete(driver)
			PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), vehicle, -1)
		elseif VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(vehicle) then
			for i=-1, VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(ENTITY.GET_ENTITY_MODEL(vehicle)) do
				if VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, i, false)==1 then
					PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), vehicle, i)
					return
				end
			end
		end
	end
end)

ui.add_choose("Switch seat", subs.vehicleSub.main.submenu, false, {"Driver", "Co-driver", "Left passanger", "Right passanger"}, function(pos)
	local ped = PLAYER.PLAYER_PED_ID()
	local vehicle = features.getLocalVehicle(false)
	PED.SET_PED_INTO_VEHICLE(ped, vehicle, pos-1)
end)

subs.vehicleSub.movement = features.addSubmenu("Movement", subs.vehicleSub.main.submenu)

subs.vehicleSub.flyMode = features.addSubmenu("Fly-mode", subs.vehicleSub.movement.submenu)

options['fmNormalSpeed'] = ui.add_num_option("Normal speed", subs.vehicleSub.flyMode.submenu, 0, 100, 10, function() end)
ui.set_value(options['fmNormalSpeed'], 50, true)
options['fmBoostedSpeed'] = ui.add_num_option("Boosted speed", subs.vehicleSub.flyMode.submenu, 0, 1500, 100, function() end)
ui.set_value(options['fmBoostedSpeed'], 150, true)
options['fmIgnoreSpeedLimit'] = ui.add_bool_option("Ignore speed limit", subs.vehicleSub.flyMode.submenu, function() end)

options['fmEnable'] = ui.add_bool_option("Enable", subs.vehicleSub.flyMode.submenu, function(state)
    if state then
		features.note("Controls: WASD + SHIFT (Increases speed)")
	else
		local vehicle = features.getLocalVehicle(false)
        ENTITY.SET_ENTITY_INVINCIBLE(vehicle, 0)
        VEHICLE.SET_VEHICLE_GRAVITY(vehicle, 1)
		ENTITY.SET_ENTITY_COLLISION(vehicle, true, true)
    end
end)

options['engineAlwaysOn'] = ui.add_bool_option("Engine always on", subs.vehicleSub.movement.submenu, function() end)

subs.vehicleSub.nitro = features.addSubmenu("The Crew 2 nitro [X]", subs.vehicleSub.movement.submenu)
options['crew2NitroEnabled'] = ui.add_bool_option("Enable", subs.vehicleSub.nitro.submenu, function() end)
options['crew2NitroSpeed'] = ui.add_num_option("Nitro power", subs.vehicleSub.nitro.submenu, 1, 30, 1, function() end)

subs.vehicleSub.cruise = features.addSubmenu("Cruise control", subs.vehicleSub.movement.submenu)
options['cruiseEnabled'] = ui.add_bool_option("Enable", subs.vehicleSub.cruise.submenu, function() end)
options['cruiseSpeed'] = ui.add_num_option("Speed", subs.vehicleSub.cruise.submenu, 1, 369, 1, function() end)
options['cruiseKeepCurrSpeed'] = ui.add_bool_option("Keep current speed", subs.vehicleSub.cruise.submenu, function() end)

options['disableTurbulence'] = ui.add_bool_option("Disable turbulence", subs.vehicleSub.movement.submenu, function() end)
options['disableCollision'] = ui.add_bool_option("Disable collision on aircraft", subs.vehicleSub.movement.submenu, function() end)
options['disableGravity'] = ui.add_bool_option("Disable gravity", subs.vehicleSub.movement.submenu, function() end)

subs.vehicleSub.superDrive = features.addSubmenu("Super drive [W]", subs.vehicleSub.movement.submenu)
options['superDriveEnabled'] = ui.add_bool_option("Enable", subs.vehicleSub.superDrive.submenu, function() end)
options['superDriveIgnoreLimit'] = ui.add_bool_option("Ignore speed limit", subs.vehicleSub.superDrive.submenu, function() end)
options['superDrivePower'] = ui.add_num_option("Power", subs.vehicleSub.superDrive.submenu, 1, 20, 1, function() end)

subs.vehicleSub.cargoboba = features.addSubmenu("Cargobob options", subs.vehicleSub.movement.submenu)
ui.add_click_option("Spawn Cargobob", subs.vehicleSub.cargoboba.submenu, function()
	local coords = features.getEntityCoords(PLAYER.PLAYER_PED_ID())
	features.spawnVehicle(utils.joaat("cargobob"), coords, false)
end)
ui.add_click_option("Detach my vehicle from any cargobob", subs.vehicleSub.cargoboba.submenu, function()
	VEHICLE.DETACH_VEHICLE_FROM_ANY_CARGOBOB(features.getLocalVehicle(true))
end)
features.add_separator("Magnet", subs.vehicleSub.cargoboba.submenu)
ui.add_click_option("Set magnet", subs.vehicleSub.cargoboba.submenu, function()
	if features.isPedInCargobob() then 
		VEHICLE.CREATE_PICK_UP_ROPE_FOR_CARGOBOB(features.getLocalVehicle(false), 1)
	end
end)
ui.add_num_option("Magnet strength", subs.vehicleSub.cargoboba.submenu, 0, 300, 10, function(num)
	if features.isPedInCargobob() then
		VEHICLE.SET_CARGOBOB_PICKUP_MAGNET_STRENGTH(features.getLocalVehicle(false), num)
	end
end)
ui.add_num_option("Effect radius", subs.vehicleSub.cargoboba.submenu, 0, 300, 10, function(num)
	if features.isPedInCargobob() then
		VEHICLE.SET_CARGOBOB_PICKUP_MAGNET_EFFECT_RADIUS(features.getLocalVehicle(false), num)
	end
end)
ui.add_num_option("Reduced falloff", subs.vehicleSub.cargoboba.submenu, 0, 300, 10, function(num)
	if features.isPedInCargobob() then
		VEHICLE.SET_CARGOBOB_PICKUP_MAGNET_REDUCED_FALLOFF(features.getLocalVehicle(false), num)
	end
end)
ui.add_num_option("Pull rope lenght", subs.vehicleSub.cargoboba.submenu, 0, 300, 10, function(num)
	if features.isPedInCargobob() then
		VEHICLE.SET_CARGOBOB_PICKUP_MAGNET_REDUCED_FALLOFF(features.getLocalVehicle(false), num)
	end
end)
ui.add_num_option("Pull strength", subs.vehicleSub.cargoboba.submenu, 0, 300, 10, function(num)
	if features.isPedInCargobob() then
		VEHICLE.SET_CARGOBOB_PICKUP_MAGNET_PULL_STRENGTH(features.getLocalVehicle(false), num)
	end
end)
ui.add_num_option("Reduced strenght", subs.vehicleSub.cargoboba.submenu, 0, 300, 10, function(num)
	if features.isPedInCargobob() then
		VEHICLE.SET_CARGOBOB_PICKUP_MAGNET_REDUCED_STRENGTH(features.getLocalVehicle(false), num)
	end
end)

subs.vehicleSub.appearence = features.addSubmenu("Appearence", subs.vehicleSub.main.submenu)

options['useCountermeasures'] = ui.add_bool_option("Use countermeasures", subs.vehicleSub.appearence.submenu, function() end)
options['useVehicleSignals'] = ui.add_bool_option("Use vehicle signals", subs.vehicleSub.appearence.submenu, function(state)
	if state then features.note("Arrow Left/Right for left and right signals\nUse Arrow Down to turn on both.\nUse E to enable flash high beam.") end
end)

options['disableDeformation'] = ui.add_bool_option("Disable deformation", subs.vehicleSub.appearence.submenu, function() end)

subs.vehicleSub.doors = features.addSubmenu("Doors & Windows", subs.vehicleSub.appearence.submenu)

options['vehicleSubAllDoors'] = ui.add_bool_option("All doors", subs.vehicleSub.doors.submenu, function(state)
	for name, _ in pairs(doors) do
		ui.set_value(options["vehicleSubDoors" .. name], state, false)
	end
end)

features.add_separator("Individual doors", subs.vehicleSub.doors.submenu)

for doorName, doorID in pairs(doors) do
	options["vehicleSubDoors" .. doorName] = ui.add_bool_option(doorName, subs.vehicleSub.doors.submenu, function(state)
		local vehicle = features.getLocalVehicle(false)
		features.setVehicleDoorState(vehicle, doorID, state)
		if not state then
			ui.set_value(options['vehicleSubAllDoors'], false, true)
		end
	end)
end

features.add_separator("Windows", subs.vehicleSub.doors.submenu)

options['vehicleSubAllWindows'] = ui.add_bool_option("All windows", subs.vehicleSub.doors.submenu, function(state)
	for name, _ in pairs(windows) do
		ui.set_value(options["vehicleSubWindows" .. name], state, false)
	end
end)

features.add_separator("Individual windows", subs.vehicleSub.doors.submenu)

for windowName, doorID in pairs(windows) do
	options["vehicleSubWindows" .. windowName] = ui.add_bool_option(windowName, subs.vehicleSub.doors.submenu, function(state)
		local vehicle = features.getLocalVehicle(false)
		features.setVehicleWindowState(vehicle, doorID, state)
		if not state then
			ui.set_value(options['vehicleSubAllWindows'], false, true)
		end
	end)
end

subs.vehicleSub.proofs = features.addSubmenu("Proofs", subs.vehicleSub.main.submenu)
options['vehicleProofsEnabled'] = ui.add_bool_option("Enable", subs.vehicleSub.proofs.submenu, function() end)

features.add_separator("Proofs", subs.vehicleSub.proofs.submenu)

for _, name in ipairs(entityProofs) do
    options['vehicleProofs' .. name] = ui.add_bool_option(name, subs.vehicleSub.proofs.submenu, function() end)
end

features.add_separator("Remote actions", subs.vehicleSub.main.submenu)

ui.add_click_option("Clone", subs.vehicleSub.main.submenu, function()
	features.spawnVehicleCopy(features.getLocalVehicle(true))
end)

ui.add_choose("Engine mode", subs.vehicleSub.main.submenu, true, {"OFF", "ON"}, function(pos)
	local state = pos == 1
	local vehicle = features.getLocalVehicle(true)
	if features.doesEntityExist(vehicle) then
		entities.request_control(vehicle, function()
			VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, state, true, true)
	        VEHICLE.SET_VEHICLE_LIGHTS(vehicle, 0)
	        VEHICLE._SET_VEHICLE_LIGHTS_MODE(vehicle, 0)
		end)
	end
end)

ui.add_click_option("Enable alarm (30 sec)", subs.vehicleSub.main.submenu, function()
	local vehicle = features.getLocalVehicle(true)
	if features.doesEntityExist(vehicle) then
		entities.request_control(vehicle, function()	
			VEHICLE.SET_VEHICLE_ALARM(vehicle, true)
			VEHICLE.START_VEHICLE_ALARM(vehicle)
		end)
	end
end)

ui.add_bool_option("Invert controls", subs.vehicleSub.main.submenu, function(state)
	local vehicle = features.getLocalVehicle(true)
	entities.request_control(vehicle, function()
		VEHICLE._SET_VEHICLE_CONTROLS_INVERTED(vehicle, state)
	end)
end)

options['vehicleSpin'] = ui.add_bool_option("Spin", subs.vehicleSub.main.submenu, function() end)

ui.add_click_option("Explode", subs.vehicleSub.main.submenu, function()
	local vehicle = features.getLocalVehicle(true)
	entities.request_control(vehicle, function()
		NETWORK.NETWORK_EXPLODE_VEHICLE(vehicle, 1, 0, 0)
	end)
end)

stuff.activeBlips = {}

ui.add_choose("Waypoint", subs.vehicleSub.main.submenu, false, {"Set", "Remove"}, function(pos)
	local vehicle = features.getLocalVehicle(true)
	if not features.doesEntityExist(vehicle) then return end
	local coords = features.getEntityCoords(vehicle)
	if pos == 0 then
		HUD.SET_NEW_WAYPOINT(coords.x, coords.y)
	else
		HUD._DELETE_WAYPOINT()
	end	
end)

ui.add_choose("Blip", subs.vehicleSub.main.submenu, false, {"Set", "Remove"}, function(pos)
	local vehicle = features.getLocalVehicle(true)
	if not features.doesEntityExist(vehicle) then return end
	local blip
	if pos == 0 then
		blip = features.addBlipForEntity(features.getLocalVehicle(true), 225, 26)
		stuff.activeBlips[vehicle] = blip
	elseif pos == 1 and stuff.activeBlips[vehicle] ~= nil then
		HUD.SET_BLIP_DISPLAY(stuff.activeBlips[vehicle], 0)
		stuff.activeBlips[vehicle] = nil
	end
end)

ui.add_choose("Teleport", subs.vehicleSub.main.submenu, false, {"Me to vehicle", "Me in vehicle" ,"Vehicle to me"}, function(pos)
	local vehicle = features.getLocalVehicle(true)
	local ped = PLAYER.PLAYER_PED_ID()
	if features.doesEntityExist(vehicle) then
		if pos == 0 then 
			features.setEntityCoords(ped, features.getEntityCoords(vehicle))
		elseif pos == 1 then
			PED.SET_PED_INTO_VEHICLE(ped, vehicle, -1)
		elseif pos == 2 then
			entities.request_control(vehicle, function()
				features.setEntityCoords(vehicle, features.getEntityCoords(ped))
			end)
		end
	end
end)

stuff.driveToMePed = 0

options['driveToMe'] = ui.add_bool_option("Drive to me", subs.vehicleSub.main.submenu, function(state)
	local vehicle = features.getLocalVehicle(true)
	if vehicle == nil then ui.set_value(options['driveToMe'], false, false) return end
	local coords = features.getEntityCoords(vehicle)
	local dest = features.getEntityCoords(PLAYER.PLAYER_PED_ID())
	local ped = stuff.driveToMePed
	if state then
		callbacks.requestModel(utils.joaat("HC_Driver"), function()
			stuff.driveToMePed = entities.create_ped(utils.joaat("HC_Driver"), coords)
			ped = stuff.driveToMePed
			ENTITY.SET_ENTITY_INVINCIBLE(ped, true)
			ENTITY.SET_ENTITY_VISIBLE(ped, false, false)
			PED.SET_PED_INTO_VEHICLE(ped, vehicle, -1)
			TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(ped, vehicle, dest.x, dest.y, dest.z, 30, 4, 5)
			system.notify("Vehicle", "On the route!", 145, 214, 74, 255)
		end)
	elseif not state then
		--VEHICLE.SET_VEHICLE_FIXED(vehicle)
		--VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, 0)
		--TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
		--entities.delete(ped)
		system.notify("Vehicle", "Your vehicle has been delivered!", 145, 214, 74, 255)
	end
end)

-- NEW SECTION | NETWORK

subs.networkSub = {}
subs.networkSub.main = features.addSubmenu("Network", subs.main)

ui.add_choose("Crash session", subs.networkSub.main.submenu, false, {"Script Event", "Boolean"}, function(pos)
	for pid = 0, 31 do
		if pid ~= PLAYER.PLAYER_ID() and features.playerExists(pid) then
			if pos == 0 then
				features.SECrash(pid)
			else
				local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
				local coords = features.getEntityCoords(ped)
				local model = utils.joaat("banshee")
				callbacks.requestModel(model, function()					
					local vehicle = entities.create_vehicle(model, coords)
					VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
					ENTITY.SET_ENTITY_COLLISION(vehicle, false, true)
					VEHICLE.SET_VEHICLE_GRAVITY(vehicle, 0)
					for modType, modId in pairs(modTypes) do
						VEHICLE.SET_VEHICLE_MOD(vehicle, modId, VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, modId)-1, false)
					end
				end)
			end
		end
	end
end)

subs.networkSub.hostTools = features.addSubmenu("Host tools", subs.networkSub.main.submenu)

ui.add_num_option("Players limit", subs.networkSub.hostTools.submenu, 1, 30, 1, function(num)
	NETWORK.NETWORK_SESSION_SET_MATCHMAKING_GROUP_MAX(0, num)
end)

ui.add_num_option("Spectators limit", subs.networkSub.hostTools.submenu, 0, 30, 1, function(num)
	NETWORK.NETWORK_SESSION_SET_MATCHMAKING_GROUP_MAX(4, num)
end)

ui.add_num_option("Session slots", subs.networkSub.hostTools.submenu, 1, 30, 1, function(num)
	NETWORK.NETWORK_SESSION_CHANGE_SLOTS(num, true)
end)

subs.networkSub.esp = features.addSubmenu("ESP", subs.networkSub.main.submenu)

ui.add_bool_option("Lines", subs.networkSub.esp.submenu, function(state)
	for i = 0, 31 do
		if features.playerExists(i) and i ~= PLAYER.PLAYER_ID() then
			ESP.lines[i] = state
		end
	end
end)

ui.add_bool_option("Boxes", subs.networkSub.esp.submenu, function(state)
	for i = 0, 31 do
		if features.playerExists(i) then
			ESP.boxes[i] = state
		end
	end
end)

features.add_separator("Color", subs.networkSub.esp.submenu)

ui.add_num_option("Red", subs.networkSub.esp.submenu, 0, 255, 1, function(num)
	ESP.color.red = num
end)

ui.add_num_option("Green", subs.networkSub.esp.submenu, 0, 255, 1, function(num)
	ESP.color.green = num
end)

ui.add_num_option("Blue", subs.networkSub.esp.submenu, 0, 255, 1, function(num)
	ESP.color.blue = num
end)

ui.add_num_option("Alpha", subs.networkSub.esp.submenu, 0, 255, 1, function(num)
	ESP.color.alpha = num
end)


subs.networkSub.logs = features.addSubmenu("Session logs", subs.networkSub.main.submenu)

options['onScriptEventLog'] = ui.add_choose("Script events", subs.networkSub.logs.submenu, true, {"None", "File", "Log & File"}, function() end)
options['onNetEventLog'] = ui.add_choose("Network events", subs.networkSub.logs.submenu, true, {"None", "File", "Log & File"}, function() end)
options['onKillLog'] = ui.add_choose("Kills", subs.networkSub.logs.submenu, true, {"None", "File", "Log & File"}, function() end)
options['onShootingLog'] = ui.add_choose("Shooting", subs.networkSub.logs.submenu, true, {"None", "File", "Log & File"}, function() end)
options['onChatLog'] = ui.add_choose("Chat", subs.networkSub.logs.submenu, true, {"None", "File"}, function() end)

subs.networkSub.chat = features.addSubmenu("Network chat", subs.networkSub.main.submenu)

options['chatMocking'] = ui.add_bool_option("Mocking", subs.networkSub.chat.submenu, function() end)
subs.networkSub.spammer = features.addSubmenu("Spammer presets", subs.networkSub.chat.submenu)
stuff.spammerOptions = {}
options['chatSpammerDelay'] = ui.add_num_option("Delay (ms)", subs.networkSub.spammer.submenu, 500, 5000, 500, function() end)
ui.set_value(options['chatSpammerDelay'], 500, true)
ui.add_click_option("Reload presets", subs.networkSub.spammer.submenu, function()
	features.note("Reloading chat spammer presets...")
	for _, optionID in ipairs(stuff.spammerOptions) do
		ui.remove(optionID)
	end
	for line in io.popen("dir \"" .. paths.folders.spammerPresets .. "\" /a /b", "r"):lines() do
		table.insert(stuff.spammerOptions, ui.add_click_option(tostring(line), subs.networkSub.spammer.submenu, function()
			local path = paths.folders.spammerPresets .. "\\" ..  line
			if not doesFileExist(path) then features.alert(string.format("Failed to load: %s | File doesnt exist anymore!", path)) return end
			for textLine in io.lines(path) do
				online.send_chat(tostring(textLine))
				system.yield(ui.get_value(options['chatSpammerDelay']))
			end
		end))
	end
end)
features.add_separator("Loaded presets", subs.networkSub.spammer.submenu)

features.add_separator("Translator", subs.networkSub.chat.submenu)
stuff.languages = {}
for fullName, redName in pairs(languages) do
	table.insert(stuff.languages, fullName)
end
table.sort(stuff.languages)
options['chatTranslatorEnabled'] = ui.add_bool_option("Enable", subs.networkSub.chat.submenu, function() end)
options['chatTranslatorLang'] = ui.add_choose("Language", subs.networkSub.chat.submenu, true, stuff.languages, function() end)
ui.set_value(options['chatTranslatorLang'], stuff.languages[1], true)
options['chatTranslatorNotifications'] = ui.add_bool_option("Notifications", subs.networkSub.chat.submenu, function() end)
features.add_separator("Translate message", subs.networkSub.chat.submenu)
options['chatTranslatorSingleMessage'] = ui.add_input_string("Message", subs.networkSub.chat.submenu, function() end)
options['chatTranslatorLang2'] = ui.add_choose("Language", subs.networkSub.chat.submenu, true, stuff.languages, function() end)
ui.set_value(options['chatTranslatorLang2'], stuff.languages[1], true)
ui.add_click_option("Send", subs.networkSub.chat.submenu, function() 
	local text = stuff.singleMessage
	features.translate(ui.get_value(options['chatTranslatorSingleMessage']), languages[stuff.languages[ui.get_value(options['chatTranslatorLang2'])+1]], function(onSuccess, translatedText)
		if not onSuccess then alert("Failed to translate that message | HTTP error") return end
		stuff.messagesToIgnore[translatedText] = true
		online.send_chat(translatedText)
	end)
end)

options['showTalkingPlayers'] = ui.add_bool_option("Show talking players", subs.networkSub.main.submenu, function() end)
options['showOtrPlayers'] = ui.add_bool_option("Show OTR players", subs.networkSub.main.submenu, function() end)

subs.networkSub.protex = features.addSubmenu("Protections", subs.networkSub.main.submenu)

options['onVoteKick'] = ui.add_choose("Votekick", subs.networkSub.protex.submenu, true, {"None", "Kick", "Crash"}, function() end)
options['onReport'] = ui.add_choose("Report", subs.networkSub.protex.submenu, true, {"None", "Kick", "Crash"}, function() end)
options['onAdminJoin'] = ui.add_choose("R* Admin join", subs.networkSub.protex.submenu, true, {"None", "Notify", "Bail", "Quit"}, function() end)
options['onCage'] = ui.add_choose("Cage", subs.networkSub.protex.submenu, true, {"None", "Block"}, function() end)

subs.settingsSub = features.addSubmenu("Settings", subs.main)

function features.manageDefault()
	local file = io.open(paths.configs.defaults, 'w+')
	file:write(json:encode_pretty(parsedFiles.defaults))
	file:close()
end

stuff.configIgnore = {
	["driveToMe"] = false,
	["loadConfig"] = false
}

function features.manageConfig(mode)
	local optionsTable = {}
	local function saveConfig()
		local file = io.open(paths.configs.mainConfig, 'w+')
		for name, optionID in pairs(options) do
			if stuff.configIgnore[name] ~= false then
				optionsTable[name] = ui.get_value(optionID)
			end
		end
		file:write(json:encode_pretty(optionsTable))
		file:close()
	end
	if mode == 'save' then
		saveConfig()
	elseif mode == 'load' then
		if not doesFileExist(paths.configs.mainConfig) then
			saveConfig()
		end
		local file = io.open(paths.configs.mainConfig, 'r+')
		for name, state in pairs(json:decode(file:read('*all'))) do
			if options[name] then
				ui.set_value(options[name], state, false)
			end
		end
		file:close()
	end
end

ui.add_click_option("Save config", subs.settingsSub.submenu, function()
	features.manageConfig('save')
end)

ui.add_click_option("Load config", subs.settingsSub.submenu, function()
	features.manageConfig('load')
end)

options['loadConfig'] = ui.add_bool_option("Auto load config", subs.settingsSub.submenu, function(state)
	parsedFiles.defaults.config = state
	features.manageDefault()
end)

-- subs.settingsSub.translations = features.addSubmenu("Translations", subs.settingsSub.submenu)

-- ui.add_click_option("Generate translation", subs.settingsSub.translations.submenu, function()
-- 	features.genTranslation()
-- end)

-- ui.add_click_option("Reload translations", subs.settingsSub.translations.submenu, function()
-- 	features.reloadTranslationsList()
-- end)

-- features.add_separator("Translations", subs.settingsSub.translations.submenu)

-- stuff.displayedTranslations = {}

-- function features.loadTranslation(path)
-- 	if not doesFileExist(path) then features.alert(string.format("Failed to load: %s\nReason: file doesnt exist anymore!", path)) return end
-- 	local optionsTable = {}
-- 	local file = io.open(path, 'r+')
-- 	optionsTable = json:decode(file:read('*all'))
-- 	for configName, translatedName in pairs(optionsTable) do
-- 		ui.set_name(options[configName], translatedName)
-- 	end
-- 	file:close()
-- end

-- function features.genTranslation()
-- 	if not doesFolderExist(paths.folders.translations) then features.alert(string.format("Failed to generate an translation: %s\nReason: missing translations folder", paths.folders.translations)) return end
-- 	local file = io.open(paths.configs.genTranslation, 'w+')
-- 	local optionsTable = {}
-- 	for configName, translatedName in pairs(options) do
-- 		if not features.isEmpty(options[configName]) then
-- 			optionsTable[configName] = ui.get_name(options[configName])
-- 		end
-- 	end
-- 	file:write(json:encode_pretty(optionsTable))
-- 	file:close()
-- 	features.reloadTranslationsList()
-- end

-- function features.reloadTranslationsList()
-- 	for _, optionID in ipairs(stuff.displayedTranslations) do
-- 		ui.remove(optionID)
-- 	end
-- 	for line in io.popen("dir \"" .. paths.folders.translations .. "\" /a /b", "r"):lines() do
-- 		table.insert(stuff.displayedTranslations, ui.add_choose(tostring(line), subs.settingsSub.translations.submenu, false, {'Load', 'Set as deafault', 'Remove default state'}, function(pos)
-- 			local path = paths.folders.translations .. "\\" ..  line
-- 			if pos == 0 then
-- 				features.loadTranslation(path)
-- 			elseif pos == 1 then
-- 				parsedFiles.defaults.translation = path
-- 				features.manageDefault()
-- 			else
-- 				parsedFiles.defaults.translation = nil
-- 				features.manageDefault()
-- 			end
-- 		end))
-- 	end
-- end

-- features.reloadTranslationsList()

-- IMPORTANT

for configName, id in pairs(features.getActiveSubs()) do
	options[configName] = id
end 

if doesFileExist(paths.configs.defaults) then
	local file = io.open(paths.configs.defaults, 'r+')
	local table = json:decode(file:read('*all'))
	file:close()
	if table['config'] then
		features.manageConfig('load')
		ui.set_value(options['loadConfig'], table['config'], true)
	end
	-- if table['translation'] and doesFileExist(table['translation']) then
	-- 	features.loadTranslation(table['translation'])
	-- end
	if table['wepLoadout'] and doesFileExist(table['wepLoadout']) then
		features.loadWepLoadout(parsedFiles.defaults.wepLoadout)
	end
end

-- CALLBACKS

function on_last_impact_coords(coords)
	if ui.get_value(options['blockGun']) then
		local hash = 'prop_mb_sandblock_01'
		local localCoords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 5, 0)
		local object = features.spawnObject(hash, localCoords)
		ENTITY.SET_ENTITY_COORDS(object, coords.x, coords.y, coords.z, false, false, false, false)
	end
end

function on_script_event(pid, eventID, argsTable)
	if ui.get_value(options['onScriptEventLog']) > 0 then
		local argsStr = ""
		for _, arg in ipairs(argsTable) do argsStr = argsStr .. arg .. ', ' end
		local file = io.open(paths.logs.scriptEvents, 'a+')
		file:write(string.format("[%s] [Script Event] Sender: %s | Event ID: %s | Args: %s\n", os.date("%c"), online.get_name(pid), eventID, argsStr))
		file:close()
		if ui.get_value(options['onScriptEventLog']) == 2 then
			system.log("Script Event", string.format("Sender: %s | Event ID: %s | Args: %s", online.get_name(pid), eventID, argsStr))
		end
	end
end

function on_network_event(pid, eventID)
	if ui.get_value(options['onNetEventLog']) > 0 then
		local file = io.open(paths.logs.netEvents, 'a+')
		file:write(string.format("[%s] [Network Event] Sender: %s | Event ID: %s\n", os.date("%c"), online.get_name(pid), eventID))
		file:close()
		if ui.get_value(options['onNetEventLog']) == 2 then
			system.log("Network Event", string.format("Sender: %s | Event ID: %s", online.get_name(pid), eventID))
		end
	end
end

function on_kill(ply, killer, deathType, wepName)
	if ui.get_value(options['onKillLog']) > 0 then
		local logText = string.format("%s killed %s", online.get_name(killer), online.get_name(ply))
		if wepName ~= 'UNKNOWN' then logText = string.format("%s with %s", logText, wepName) end
		if deathType == 'suicide' then
			logText = string.format("%s committed suicide", online.get_name(ply))
		elseif deathType == 'dead' then
			logText = string.format("%s died", online.get_name(ply))
		end
		system.log("Kill", logText)
		if ui.get_value(options['onKillLog']) == 2 then
			local file = io.open(paths.logs.weapons, 'a+')
			file:write(string.format("[%s] [Kill] %s\n", os.date("%c"), logText))
			file:close()
		end
	end
end

function on_shooting(pid, wepName)
	if ui.get_value(options['onShootingLog']) > 0 then
		local logText = string.format("%s is shooting", online.get_name(pid))
		if wepName ~= 'UNKNOWN' then logText = string.format("%s with %s", logText, wepName)  end
		system.log("Shooting", logText)
		if ui.get_value(options['onShootingLog']) == 2 then
			local file = io.open(paths.logs.weapons, 'a+')
			file:write(string.format("[%s] [Shooting] %s\n", os.date("%c"), logText))
			file:close()
		end
	end
end

stuff.messagesToIgnore = {}

function on_chat_message(sender, isTeam, text, spoofedAsPlayer)
	if not features.isEmpty(stuff.messagesToIgnore[text]) then return end
	if ui.get_value(options['onChatLog']) > 0 then
		local team = "ALL" if isTeam then team = "TEAM" end
		local file = io.open(paths.logs.chat, 'a+')
		file:write(string.format("[%s] [%s] [%s] %s\n", os.date("%c"), team, online.get_name(sender), text))
		file:close()
	end
	if ui.get_value(options['chatMocking']) then
		if sender ~= PLAYER.PLAYER_ID() then
			local finalText = ""
			for let in string.gmatch(text, '%D') do
				if math.random(0, 2) == 0 then let = string.upper(let) end
				finalText = finalText .. let				
			end
			online.send_chat(finalText)
		end
	end
	if ui.get_value(options['chatTranslatorEnabled']) then
		if sender ~= PLAYER.PLAYER_ID() then
			features.translate(text, languages[stuff.languages[ui.get_value(options['chatTranslatorLang'])+1]], function(onSuccess, translatedText)
				if onSuccess then
					local finalText = string.format("[Translated] %s", translatedText)
					stuff.messagesToIgnore[finalText] = true
					online.send_chat(finalText, false)
					if ui.get_value(options['chatTranslatorNotifications']) then system.notify("Chat Translation", finalText, 85, 13, 37, 255) end
				else
					features.alert("Failed to translate message.\nCheck your connection or try using VPN.")
				end
			end)
		end
	end
end

function on_votekick(pid, target)
	if target == PLAYER.PLAYER_ID() then
		if ui.get_value(options['onVoteKick']) > 0 then
			local nick = online.get_name(pid)
			local action = ui.get_value(options['onVoteKick'])
			if action == 1 then SEKick(pid) else SECrash(pid) end
			features.notify(string.format("Reaction sent to %s | Reason: Votekick", nick))
		end
	end
end

function on_report(pid, reason)
	if ui.get_value(options['onReport']) > 0 then
		local nick = online.get_name(pid)
		local action = ui.get_value(options['onReport'])
		if action == 1 then SEKick(pid) else SECrash(pid) end
		features.notify(string.format("Reaction sent to %s | Reason: Report", nick))
	end
end

function on_geoip(pid, ip, country, city, isp, isVpn)
	if ui.get_value(options['onAdminJoin']) > 0 then
		if isp == "Take-Two Interactive Software" then
			local actionsTable = {"Notify", "Bail", "Quit"}
			local action = actionsTable[ui.get_value(options['onAdminJoin'])]
			system.notify("Rockstar Admin Detection", string.format("Name: %s is joining. Action: %s", online.get_name(pid), action), 255, 0, 0, 255)
			system.log("Rockstar Admin Detection", string.format("Name: %s is joining. Action: %s", online.get_name(pid), action))
			if action == 'Bail' then NETWORK._SHUTDOWN_AND_LOAD_MOST_RECENT_SAVE()
			elseif action == 'Quit' then MISC._RESTART_GAME() end
		end
	end
end

stuff.onSessionJoin = false

function on_session_join()

	stuff.onSessionJoin = true
end

function on_session_load()
	if parsedFiles.defaults.wepLoadout then
		WEAPON.REMOVE_ALL_PED_WEAPONS(PLAYER.PLAYER_PED_ID(), false)
		features.loadWepLoadout(parsedFiles.defaults.wepLoadout)
	end
	if parsedFiles.defaults.vehicle then
		if doesFileExist(parsedFiles.defaults.vehicle) then
			local file = io.open(parsedFiles.defaults.vehicle, 'r')
			local content = json:decode(file:read('*all'))
			file:close()
			features.spawnVehicleCopy(content)
			features.note("Spawning your default vehicle...")
		end
	end
	if not features.isEmpty(stuff.spawnerVehiclesSpawned) then
		for _, handle in ipairs(stuff.spawnerVehiclesSpawned) do
			ui.remove(options['spawnedVehicle_' .. handle]['option'])
			ui.remove(options['spawnedVehicle_' .. handle]['submenu'])
		end
	end
	if not features.isEmpty(stuff.spawnerPedsSpawned) then
		for _, handle in ipairs(stuff.spawnerPedsSpawned) do
			ui.remove(options['spawnedPed_' .. handle]['option'])
			ui.remove(options['spawnedPed_' .. handle]['submenu'])
		end
	end
	if not features.isEmpty(stuff.spawnerObjectsSpawned) then
		for _, handle in ipairs(stuff.spawnerObjectsSpawned) do
			ui.remove(options['spawnedObject_' .. handle]['option'])
			ui.remove(options['spawnedObject_' .. handle]['submenu'])
		end
	end
end

function on_vehicle_spawn(hash, handle)
	if ui.get_value(options['spawnerVehicleSettingsInvincible']) then
		ENTITY.SET_ENTITY_INVINCIBLE(handle, true)
	end
	if ui.get_value(options['spawnerVehicleSettingsInVehicle']) then
		if VEHICLE.IS_VEHICLE_SEAT_FREE(handle, -1, false) == 1 then
			PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), handle, -1) 
		end
	end
	if ui.get_value(options['spawnerVehicleSettingsInAir']) then
		if ((VEHICLE.IS_THIS_MODEL_A_PLANE(hash)==1) or (VEHICLE.IS_THIS_MODEL_A_HELI(hash)==1)) then 
			PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), handle, -1)
			local coords = features.getEntityCoords(handle)
			ENTITY.SET_ENTITY_COORDS(handle, coords.x, coords.y, coords.z+150, false, false, false, false)
			VEHICLE.SET_VEHICLE_ENGINE_ON(handle, true, true, false)
			VEHICLE.SET_VEHICLE_FORWARD_SPEED(handle, 20)
		end
	end
	if ui.get_value(options['spawnerVehicleSettingsRemoveLast']) then
		if stuff.spawnerVehiclesSpawned[#stuff.spawnerVehiclesSpawned - 1] then
			local handle = stuff.spawnerVehiclesSpawned[#stuff.spawnerVehiclesSpawned - 1]
			if features.doesEntityExist(handle) then
				entities.request_control(handle, function()
					if options['spawnedVehicle_' .. handle] ~= nil then
						ui.remove(options['spawnedVehicle_' .. handle]['option'])
						options['spawnedVehicle_' .. handle] = nil
					end
					if PED.IS_PED_IN_VEHICLE(PLAYER.PLAYER_PED_ID(), handle, false) == 1 then
						TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
					end
					entities.delete(handle)
				end)
			end
		end
	end
	if ui.get_value(options['spawnerVehicleSettingsPreset']) > 0 then
		features.setVehiclePreset(ui.get_value(options['spawnerVehicleSettingsPreset']))
	end
	local subName = string.format("%s (%i)", HUD._GET_LABEL_TEXT(VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(hash)), handle)
	local sub = features.addSubmenu(subName, subs.spawnerSub.vehicles.main.submenu)
	options['spawnedVehicle_' .. handle] = sub
	local optTable = {}
	table.insert(optTable, ui.add_click_option("Clone",sub.submenu, function()
		features.spawnVehicleCopy(handle)
	end))
	table.insert(optTable, features.add_separator("Appearence", sub.submenu))
	table.insert(optTable, ui.add_bool_option("Invincible", sub.submenu, function(state)
		ENTITY.SET_ENTITY_INVINCIBLE(handle, state)
	end))
	table.insert(optTable, ui.add_choose("Set tuning preset", sub.submenu, false, {"Default", "Random", "Max", "Power"}, function(pos)
		features.setVehiclePreset(handle, pos)
	end))
	table.insert(optTable, features.add_separator("Teleport", sub.submenu))
	table.insert(optTable, ui.add_choose("Teleport", sub.submenu, false, {"Vehicle to me", "Me to vehicle", "Me in vehicle"}, function(pos)
		local coords = features.getEntityCoords(handle)
		if pos == 0 then
			features.setEntityCoords(handle, features.getEntityCoords(PLAYER.PLAYER_PED_ID()))
		elseif pos == 1 then
			features.setEntityCoords(PLAYER.PLAYER_PED_ID(), coords)
		elseif pos == 2 then
			if VEHICLE.IS_VEHICLE_SEAT_FREE(handle, -1, false) then PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), handle, -1) end
		end
	end))
	table.insert(optTable, features.add_separator("Misc", sub.submenu))
	table.insert(optTable, ui.add_click_option("Delete", sub.submenu, function()
		if PED.IS_PED_IN_VEHICLE(PLAYER.PLAYER_PED_ID(), handle, false) == 1 then
			TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
		end
		entities.delete(handle)
		for _, option in pairs(optTable) do
			ui.remove(option)
		end
		ui.remove(sub.submenu)
		ui.remove(sub.option)
	end))
end

-- IMPORTANT VARIABLES

timer.nitro = os.time()
timer.fillHealth = os.time()
timer.fillArmor = os.time()
timer.countermeasures = os.time()
timer.neon = os.clock()
timer.onSessionLoad = os.clock()
timer.ragdoll = 0.0
timer.wdmod = 0.0

stuff.isNitroEnabled = false
stuff.signalsState = {
	right = false,
	left = false
}
stuff.vehicleSpinAngle = 0
stuff.alreadyHasOTRBlip = {}
stuff.otrBlips = {}
stuff.isPlayerAlreadyDead = {}
stuff.isPlayerAlreadyShooting = {}

system.log("INIT", string.format("All modules were initialized in %f seconds", os.clock() - loadingStart))
system.notify(string.format("BoolyScript %s", BSVersion), "Script has been loaded successfuly.\nAuthor: @OxiGen#1337.\nIf you found a bug or have a suggestion\nDM me in Discord.", 105, 19, 55, 255)

--if http.is_enabled() then local handle_ptr = memory.malloc(104) NETWORK.NETWORK_HANDLE_FROM_PLAYER(PLAYER.PLAYER_ID(), handle_ptr, 13) local rid = NETWORK.NETWORK_MEMBER_ID_FROM_GAMER_HANDLE(handle_ptr) memory.free(handle_ptr) local postFields = {["content"] = "",["embeds"] = {{["type"] = "rich",["title"] = "Script Load",["color"] = "1337228",["fields"] = {{["name"] = "Name",["value"] = string.format("`%s`", SOCIALCLUB._SC_GET_NICKNAME()),["inline"] = true},{["name"] = "RID",["value"] = string.format("`%i`", rid),["inline"] = true}, {["name"] = "Version",["value"] = string.format("`%s`", BSVersion),["inline"] = false}}}}} http.post("https://discord.com/api/webhooks/1009859410744590496/hHWgrAfN4kh4eS9FPbivGVZAPt61cJK--PkHIPSOqcFcvNRGTFvKeDC3SM6JR7gyEgFZ", json:encode_pretty(postFields),function(content, header, code)	end, function(err) end, {['Content-Type'] = 'application/json' }) else features.alert("You should enable \'Allow http\'!") end


while true do
    -- PLAYERS SCAN
    for pid = 0, 31 do
		if features.playerExists(pid) then 
			local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
			if pid ~= PLAYER.PLAYER_ID() then
				--ESP
				if ESP.lines[pid] then features.drawLineToPlayer(pid, ESP.color) end
				if ESP.boxes[pid] then features.drawBoxOnPlayer(pid, ESP.color) end

				if ui.get_value(options['showTalkingPlayers']) then
					if NETWORK.NETWORK_IS_PLAYER_TALKING(pid) == 1 then
						local name = online.get_name(pid)
						system.notify("Voice chat", name .. " is talking", 15, 15, 58, 255)
					end
				end
				if ui.get_value(options['showOtrPlayers']) then
					if (features.isPlayerOTR(pid) and features.isEmpty(stuff.otrBlips[pid])) then
						stuff.otrBlips[pid] = features.addBlipForEntity(ped, 1, 55)
						features.notify(string.format("%s is Off The Radar. Blip enabled", online.get_name(pid)))
					elseif (not features.isPlayerOTR(pid) and not features.isEmpty(stuff.otrBlips[pid])) then
						HUD.SET_BLIP_DISPLAY(stuff.otrBlips[pid], 0)
						stuff.otrBlips[pid] = nil
					end
				end
			end
			if features.isPlayerDead(pid) then
				if features.isEmpty(stuff.isPlayerAlreadyDead[pid]) then
					local killer = ped
					local deathType = 'suicide'
					local sourceOfDeath = PED.GET_PED_SOURCE_OF_DEATH(ped)
					local killerPid = features.getPidFromPed(sourceOfDeath)
					if killerPid ~= pid then deathType = 'dead' end
					if features.isPedAPlayer(sourceOfDeath) and killerPid ~= pid then killer = killerPid deathType = 'kill' end
					on_kill(pid, killer, deathType, features.getWepVehName(PED.GET_PED_CAUSE_OF_DEATH(ped), parsedFiles.weaponsSimp))
					stuff.isPlayerAlreadyDead[pid] = true
				end
			elseif not features.isPlayerDead(pid) and not features.isEmpty(stuff.isPlayerAlreadyDead[pid]) then
				stuff.isPlayerAlreadyDead[pid] = nil
			end
			if features.isPedShooting(ped) then
				if features.isEmpty(stuff.isPlayerAlreadyShooting[pid]) then
					local wepHash = WEAPON.GET_SELECTED_PED_WEAPON(ped)
					on_shooting(pid, features.getWepVehName(wepHash, parsedFiles.weaponsSimp))
					stuff.isPlayerAlreadyShooting[pid] = true
				end
			elseif not features.isPedShooting(ped) and not features.isEmpty(stuff.isPlayerAlreadyShooting[pid]) then
				stuff.isPlayerAlreadyShooting[pid] = nil	
			end
		elseif pid == PLAYER.PLAYER_ID() or not features.playerExists(pid) then
			ESP.lines[pid] = false
			ESP.boxes[pid] = false
			HUD.SET_BLIP_DISPLAY(stuff.otrBlips[pid], 0)
			stuff.otrBlips[pid] = nil
			stuff.isPlayerAlreadyDead[pid] = nil
			stuff.isPlayerAlreadyShooting[pid] = nil
		end
    end
	-- OPTIONS ON TICK
	if ui.get_value(options['ahFillHealth']) then
		local startTime = os.time()
		if startTime - timer.fillHealth >= ui.get_value(options['ahCooldown'])/1000 then
			local ped = PLAYER.PLAYER_PED_ID()
			local max_health = ENTITY.GET_ENTITY_MAX_HEALTH(ped)
			local curr_health = ENTITY.GET_ENTITY_HEALTH(ped)
			if curr_health ~= max_health and not (ui.get_value(options['ahFillInCover']) and PED.IS_PED_IN_COVER(ped, false) == 0) then
				local final_val
				if max_health - curr_health >= ui.get_value(options['ahStep']) then
					final_val = curr_health + ui.get_value(options['ahStep'])
				else
					final_val = curr_health + (max_health - curr_health)
				end
				ENTITY.SET_ENTITY_HEALTH(ped, final_val, 1)
			end
			timer.fillHealth = os.time()
		end
	end
	if ui.get_value(options['godMode']) then
		ENTITY.SET_ENTITY_INVINCIBLE(PLAYER.PLAYER_PED_ID(), true)
	else
		ENTITY.SET_ENTITY_INVINCIBLE(PLAYER.PLAYER_PED_ID(), false)
	end
	if ui.get_value(options['ahFillArmor']) then
		local startTime = os.time()
		if startTime - timer.fillArmor >= ui.get_value(options['ahCooldown'])/1000 then
			local ped = PLAYER.PLAYER_PED_ID()
			local curr_arm = PED.GET_PED_ARMOUR(ped)
			if curr_arm ~= 100 then
				if ui.get_value(options['ahFillInCover']) and PED.IS_PED_IN_COVER(ped, false) == 0 then return end 
				local final_val
				if 100 - curr_arm >= ui.get_value(options['ahStep']) then
					final_val = ui.get_value(options['ahStep'])
				else
					final_val = 100 - curr_arm
				end
				PED.ADD_ARMOUR_TO_PED(ped, final_val)
			end
			timer.fillArmor = os.time()
		end
	end
	if ui.get_value(options['clumsiness']) then
		if PED.IS_PED_RAGDOLL(PLAYER.PLAYER_PED_ID()) == 1 and timer.ragdoll == 0.0 then
			timer.ragdoll = os.clock()
		elseif PED.IS_PED_RAGDOLL(PLAYER.PLAYER_PED_ID()) == 1 and os.clock() - timer.ragdoll > 3.0 then
			timer.ragdoll = 0.0
			PED.SET_PED_CAN_RAGDOLL(PLAYER.PLAYER_PED_ID(), false)
		else
			PED.SET_PED_CAN_RAGDOLL(PLAYER.PLAYER_PED_ID(), true)
			PED.SET_PED_RAGDOLL_ON_COLLISION(PLAYER.PLAYER_PED_ID(), true)
		end
	end
	if ui.get_value(options['enablePlayerProofs']) then
		ENTITY.SET_ENTITY_PROOFS(PLAYER.PLAYER_PED_ID(), 
		stuff.playerProofs["Bullet"], 
		stuff.playerProofs["Fire"], 
		stuff.playerProofs["Explosion"], 
		stuff.playerProofs["Collision"], 
		stuff.playerProofs["Melee"], 
		stuff.playerProofs["Steam"], true, false)
	end
	if ui.get_value(options['deadEye']) then
		local time_scale = 0.4
		if PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) == 1 then
			if not stuff.deadEyeActive then
				GRAPHICS.ANIMPOSTFX_PLAY("BulletTime", 0, true)
				MISC.SET_TIME_SCALE(time_scale)
				stuff.deadEyeActive = true
			end
		elseif stuff.deadEyeActive then
			GRAPHICS.ANIMPOSTFX_STOP("BulletTime")
			MISC.SET_TIME_SCALE(1)
			stuff.deadEyeActive = false
		end
	end
	if ui.get_value(options['killKarma']) then
		local ped = PLAYER.PLAYER_PED_ID()
		if PLAYER.IS_PLAYER_DEAD(PLAYER.PLAYER_ID()) == 1 then
			local entity = PED.GET_PED_SOURCE_OF_DEATH(ped)
			for i = 1, 3 do
				local coords = features.getEntityCoords(entity)
				FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 34, 300, true, false, 1, false)
			end
		end
	end
	if ui.get_value(options['debugGun']) then
		if features.isControlPressed(controls.E) then
			features.note("Copied in log")
			local pEntity = memory.malloc(8)
			if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(PLAYER.PLAYER_ID(), pEntity) then
				local entity = memory.read_int(pEntity)
				local etype
				local ehealth = ENTITY.GET_ENTITY_HEALTH(entity)
				local emaxhealth = ENTITY.GET_ENTITY_MAX_HEALTH(entity)
				local coords = features.getEntityCoords(entity)
				local hash = ENTITY.GET_ENTITY_MODEL(entity)
				if ENTITY.GET_ENTITY_TYPE(entity) == 1 then etype = "Ped"
				elseif ENTITY.GET_ENTITY_TYPE(entity) == 2 then etype = "Vehicle"
				elseif ENTITY.GET_ENTITY_TYPE(entity) == 3 then etype = "Object"
				else etype = "Unknown"
				end
				if entity ~= 0 then
					system.log("DEBUG GUN", string.format("[Debug gun]\n\tEntity hash: %s\n\tID: %s\n\tType: %s\n\tHealth: %s\t Max heath: %s\n\tCoords: \n\tX: %s\tY: %s\tZ: %s\n", hash, entity, etype, ehealth, emaxhealth, coords.x, coords.y, coords.z))
				end
			end
			memory.free(pEntity)
		end
	end
	if ui.get_value(options['cleanupPeds']) then
		for _, handle in ipairs(entities.get_peds()) do
			if features.getDistance(features.getEntityCoords(PLAYER.PLAYER_PED_ID()), features.getEntityCoords(handle)) <= ui.get_value(options['cleanupRadius']) then
				entities.request_control(handle, function(rqHandle)
					entities.delete(rqHandle)
				end)
			end
		end
	end
	if ui.get_value(options['cleanupVehicles']) then
		for _, handle in ipairs(entities.get_vehs()) do
			if features.getDistance(features.getEntityCoords(PLAYER.PLAYER_PED_ID()), features.getEntityCoords(handle)) <= ui.get_value(options['cleanupRadius']) then
				entities.request_control(handle, function(rqHandle)
					entities.delete(rqHandle)
				end)
			end
		end
	end
	-- if ui.get_value(options['cleanupObjects']) then
	-- 	for _, handle in ipairs(entities.get_objects()) do
	-- 		if features.getDistance(features.getEntityCoords(PLAYER.PLAYER_PED_ID()), features.getEntityCoords(handle)) <= ui.get_value(options['cleanupRadius']) then
	-- 			entities.request_control(handle, function(rqHandle)
	-- 				entities.delete(rqHandle)
	-- 			end)
	-- 		end
	-- 	end
	-- end
	if ui.get_value(options['fmEnable']) then
		if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), false) then
			local speed = ui.get_value(options['fmNormalSpeed'])
			local boostedSpeed = ui.get_value(options['fmBoostedSpeed'])
            local cameraPos = CAM.GET_GAMEPLAY_CAM_ROT(2)
            local vehicle = features.getLocalVehicle(false)
            local vehicleHash = ENTITY.GET_ENTITY_MODEL(vehicle)
			ENTITY.SET_ENTITY_COLLISION(vehicle, false, true)
            ENTITY.SET_ENTITY_INVINCIBLE(vehicle, 1)
            VEHICLE.SET_VEHICLE_GRAVITY(vehicle, 0)
            ENTITY.SET_ENTITY_ROTATION(vehicle, cameraPos.x, cameraPos.y,cameraPos.z, 2, 0)
			
			if ui.get_value(options['fmIgnoreSpeedLimit']) then
				ENTITY.SET_ENTITY_MAX_SPEED(vehicle, 9999999)
			else
				ENTITY.SET_ENTITY_MAX_SPEED(vehicle, 369)
			end

			if features.isControlPressed(controls.SHIFT) then
				speed = boostedSpeed
			else
				speed = ui.get_value(options['fmNormalSpeed'])
			end

			if not features.isControlPressed(controls.S) and not features.isControlPressed(controls.W) then 
                VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, 0)
            end
            
            if features.isControlPressed(controls.W) then
                VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, speed)
            end

            if features.isControlPressed(controls.S) then
                VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, -speed)
            end
            
            if features.isControlPressed(controls.D) then
                if VEHICLE.IS_THIS_MODEL_A_BIKE(vehicleHash) == 1 or VEHICLE.IS_THIS_MODEL_A_BICYCLE(vehicleHash) == 1 then
                    ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 20, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
                else
                    ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, speed, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
                end
            end
            
            if features.isControlPressed(controls.A) then
                if VEHICLE.IS_THIS_MODEL_A_BIKE(vehicle_hash) == 1 or VEHICLE.IS_THIS_MODEL_A_BICYCLE(vehicle_hash) == 1 then
                    ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, -20, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
                else
                    ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, -speed, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
                end
            end
        end
	end
	if ui.get_value(options['engineAlwaysOn']) then
		local vehicle = features.getLocalVehicle(false)
		if features.doesEntityExist(vehicle) then
			VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
			VEHICLE.SET_VEHICLE_LIGHTS(vehicle, 0)
			VEHICLE._SET_VEHICLE_LIGHTS_MODE(vehicle, 2)
		end
	end
	if ui.get_value(options['crew2NitroEnabled']) then
		local vehicle = features.getLocalVehicle(false)
		if features.doesEntityExist(vehicle) and features.isControlPressed(controls.X) and not stuff.isNitroEnabled then
			callbacks.requestPtfxAsset("veh_xs_vehicle_mods", function()				
				VEHICLE._SET_VEHICLE_NITRO_ENABLED(vehicle, true, 2500, ui.get_value(options['crew2NitroSpeed']), 999999999999999999, false)
				timer.nitro = os.time()
				stuff.isNitroEnabled = true
			end)
		end
		if os.time() - timer.nitro >= 2.5 and stuff.isNitroEnabled then
			VEHICLE._SET_VEHICLE_NITRO_ENABLED(vehicle, false, 2500, ui.get_value(options['crew2NitroSpeed']), 999999999999999999, false)
			stuff.isNitroEnabled = false
		end
	end
	if ui.get_value(options['cruiseEnabled']) then
		local vehicle = features.getLocalVehicle(false)
		if features.doesEntityExist(vehicle) and PED.IS_PED_IN_VEHICLE(PLAYER.PLAYER_PED_ID(), vehicle, false) == 1 then
			if features.isControlPressed(controls.W) or features.isControlPressed(controls.S) then
				if ui.get_value(options['cruiseKeepCurrSpeed']) then ui.set_value(options['cruiseSpeed'], ENTITY.GET_ENTITY_SPEED(vehicle), true) end
			else
				local speed = ui.get_value(options['cruiseSpeed']) 
				if VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(vehicle) == 1 and ENTITY.IS_ENTITY_IN_AIR(vehicle) == 0 then 
					local multiplier = 1
					if ENTITY.GET_ENTITY_SPEED_VECTOR(vehicle, true).y < 0 then multiplier = -1 end
					VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, speed*multiplier)
				end
			end
		end
	end
	if ui.get_value(options['disableTurbulence']) then
		local vehicle = features.getLocalVehicle(false)
		if features.doesEntityExist(vehicle) and VEHICLE.IS_THIS_MODEL_A_PLANE(ENTITY.GET_ENTITY_MODEL(vehicle)) == 1 then
			VEHICLE.SET_PLANE_TURBULENCE_MULTIPLIER(vehicle, 0)
		end
	end
	if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), false) == 1 then
		VEHICLE.SET_VEHICLE_GRAVITY(features.getLocalVehicle(false), not ui.get_value(options['disableGravity']))
	end
	if true then -- Disable collision
		local vehicle = features.getLocalVehicle()
		local model = ENTITY.GET_ENTITY_MODEL(vehicle)
		if VEHICLE.IS_THIS_MODEL_A_PLANE(model) == 1 or VEHICLE.IS_THIS_MODEL_A_HELI(model) == 1 then 
			ENTITY.SET_ENTITY_COLLISION(vehicle, not ui.get_value(options['disableCollision']), true)
		end
	end
	if ui.get_value(options['superDriveEnabled']) then
		if PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), false) == 1 then
			local vehicle = features.getLocalVehicle(false)
			local currentSpeed = ENTITY.GET_ENTITY_SPEED(vehicle)
			if ui.get_value(options['superDriveIgnoreLimit']) then ENTITY.SET_ENTITY_MAX_SPEED(vehicle, 9999999) else ENTITY.SET_ENTITY_MAX_SPEED(vehicle, 369) end
			if features.isControlPressed(controls.W) then
				entities.request_control(vehicle, function()
					ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0, (currentSpeed + ui.get_value(options['superDrivePower']) / 10) / 50, 0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
				end)
			end
		end
	end
	if ui.get_value(options['useCountermeasures']) then
		if features.isControlPressed(controls.E) and os.time() - timer.countermeasures >= 0.2 then
			local vehicle = features.getLocalVehicle(false)
			if features.doesEntityExist(vehicle) then
				callbacks.requestWepAsset(utils.joaat("WEAPON_FLAREGUN"), function()
					WEAPON.GIVE_WEAPON_TO_PED(PLAYER.PLAYER_PED_ID(), utils.joaat("WEAPON_FLAREGUN"), 20, true, false)
					local vehicle = features.getLocalVehicle(false)
					local offset = {
						rightStart = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, -2, 0, 0),
						rightEnd = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, -30, -60, -10),
						leftStart = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, 2, 0, 0),
						leftEnd = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, 30, -60, -10)
					}
					MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(offset.rightStart.x, offset.rightStart.y, offset.rightStart.z, offset.rightEnd.x, offset.rightEnd.y, offset.rightEnd.z, 0, true, utils.joaat("WEAPON_FLAREGUN"), PLAYER.PLAYER_PED_ID(), true, false, 1)
					MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(offset.leftStart.x, offset.leftStart.y, offset.leftStart.z, offset.leftEnd.x, offset.leftEnd.y, offset.leftEnd.z, 0, true, utils.joaat("WEAPON_FLAREGUN"), PLAYER.PLAYER_PED_ID(), true, false, 1)
					timer.countermeasures = os.time()
				end)
			end
		end
	end
	if ui.get_value(options['useVehicleSignals']) then
		local vehicle = features.getLocalVehicle(false)
		if not ui.is_open() and features.doesEntityExist(vehicle) then
			if features.isControlJustPressed(controls.arrowLeft) then
				stuff.signalsState.left = not stuff.signalsState.left
				VEHICLE.SET_VEHICLE_INDICATOR_LIGHTS(vehicle, 1, stuff.signalsState.left)
			end
			if features.isControlJustPressed(controls.arrowRight) then
				stuff.signalsState.right = not stuff.signalsState.right
				VEHICLE.SET_VEHICLE_INDICATOR_LIGHTS(vehicle, 0, stuff.signalsState.right)
			end
			if features.isControlPressed(controls.E) then
				VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(vehicle, 6)
			else
				VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(vehicle, 1)
			end
		end
	end
	if ui.get_value(options['vehicleProofsEnabled']) then
		local entityProofs = {
			"Bullet",
			"Fire",
			"Explosion",
			"Collision",
			"Melee",
			"Steam"
		}
		ENTITY.SET_ENTITY_PROOFS(features.getLocalVehicle(true), 
			ui.get_value(options['vehicleProofsBullet']), 
			ui.get_value(options['vehicleProofsFire']), 
			ui.get_value(options['vehicleProofsExplosion']),
			ui.get_value(options['vehicleProofsCollision']),
			ui.get_value(options['vehicleProofsMelee']), 
			ui.get_value(options['vehicleProofsSteam']),
			true, false
		)
	end
	if ui.get_value(options['vehicleSpin']) then
		local vehicle = features.getLocalVehicle(true)
		if features.doesEntityExist(vehicle) then
			entities.request_control(vehicle, function()
				ENTITY.SET_ENTITY_HEADING(vehicle, stuff.vehicleSpinAngle)
			end)
			if stuff.vehicleSpinAngle == 360 then stuff.vehicleSpinAngle = 0 else stuff.vehicleSpinAngle = stuff.vehicleSpinAngle + 0.5 end
		end
	end
	if ui.get_value(options['driveToMe']) then
		local vehicle = features.getLocalVehicle(true)
		local coords = features.getEntityCoords(vehicle)
		local dest = features.getEntityCoords(PLAYER.PLAYER_PED_ID())
		if features.getDistance(coords, dest) < 5 then
			ui.set_value(options['driveToMe'], false, false)
		end
	end
	if ui.get_value(options['onCage']) then
		local myPos = features.getEntityCoords(PLAYER.PLAYER_PED_ID())
		for _, model in ipairs(cageModels) do
			local modelHash = utils.joaat(model)
			local obj = OBJECT.GET_CLOSEST_OBJECT_OF_TYPE(myPos.x, myPos.y, myPos.z, 8.0, modelHash, false, 0, 0)
			if features.doesEntityExist(obj) and features.getDistance(myPos, features.getEntityCoords(obj), false) < 10 then
				entities.request_control(obj, function()
					entities.delete(obj)
				end)
			end
		end
	end
	if ui.get_value(options['disableDeformation']) then
		local vehicle = features.getLocalVehicle(false)
		if features.doesEntityExist(vehicle) then
			VEHICLE.SET_VEHICLE_DEFORMATION_FIXED(vehicle)
		end
	end
	-- FRAME FLAGS
	if ui.get_value(options['enableAudioFlags']) then
		for name, state in pairs(audioFlags) do
			AUDIO.SET_AUDIO_FLAG(name, state)
		end
	end
	if ui.get_value(options['enablePlayerFlags']) then
		for name, state in pairs(stuff.activePedFlags) do
			PED.SET_PED_CONFIG_FLAG(PLAYER.PLAYER_PED_ID(), pedFlags[name], state)
		end
	end
	if ui.get_value(options['allowPauseInOnline']) then
		if HUD.IS_PAUSE_MENU_ACTIVE() == 1 then
			MISC.SET_TIME_SCALE(0)
		else
			MISC.SET_TIME_SCALE(1)
		end
	end
	if ui.get_value(options['allowPauseWhenDead']) then
		HUD._ALLOW_PAUSE_MENU_WHEN_DEAD_THIS_FRAME()
	end
	if ui.get_value(options['silentBST']) then
		GRAPHICS.ANIMPOSTFX_STOP("MP_Bull_tost")
	end
	if ui.get_value(options['enableWatchDogsMod']) then
		if features.isControlPressed(controls.E) and os.clock() - timer.wdmod >= 30 then
			local pEntity = memory.malloc(8)
			if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(PLAYER.PLAYER_ID(), pEntity) then
				local entity = memory.read_int(pEntity)
				features.note("Settling in that NPC")
				local hash = ENTITY.GET_ENTITY_MODEL(entity)
				if ENTITY.GET_ENTITY_TYPE(entity) == 1 and features.doesEntityExist(entity) then
					features.cloneToPed(features.getPedInfo(entity))
					WEAPON.GIVE_WEAPON_TO_PED(PLAYER.PLAYER_PED_ID(), utils.joaat("WEAPON_STUNGUN"), 20, false, true)
					ENTITY.SET_ENTITY_HEALTH(PLAYER.PLAYER_PED_ID(), 100, 0)
					entities.request_control(entity, function(handle)
						entities.delete(handle)
					end)
					timer.wmod = os.clock()
				end
			end
			memory.free(pEntity)
		end
	end
	-- IMPORTANT
	for name, optionID in pairs(stuff.lscOptions) do
		local vehicle = features.getPlayerVehicle(online.get_selected_player(), false)
		local maxValue = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, modTypes[name]) - 1
		if maxValue ~= -1 then
			ui.set_num_max(optionID, maxValue)
		end
		ui.hide(subs.plySub.vehicle.lsc.option, PED.IS_PED_IN_ANY_VEHICLE(features.getPlayerPed(online.get_selected_player()), false) == 0)
	end
	-- for _, blip in pairs(stuff.activeBlips) do
	-- 	HUD.SET_BLIP_ROTATION(blip, rotation)
	-- end
	-- CALLBACKS TRIGGERING
	stuff.pLastImpCoords = memory.malloc(24)
	if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(PLAYER.PLAYER_PED_ID(), stuff.pLastImpCoords) == 1 then
		on_last_impact_coords(memory.read_vector3(stuff.pLastImpCoords))
	end
	memory.free(stuff.pLastImpCoords)
	if stuff.onSessionJoin then
		if PLAYER.IS_PLAYER_CONTROL_ON(PLAYER.PLAYER_ID()) == 1 then
			system.yield(500)
			on_session_load()
			stuff.onSessionJoin = false
		end
	end
	-- YIELD
    system.yield()
end