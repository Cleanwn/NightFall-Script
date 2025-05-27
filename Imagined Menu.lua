--
-- made by FoxxDash/aka Ðr ÐºήgΣr & SATTY
--
-- Copyright © 2022 Imagined Menu
--

local VERSION = '1.3.0'
local TIME = os.clock()
system.yield()

-- Global to local
local random = math.random
local floor = math.floor
local rad = math.rad
local abs = math.abs
local sqrt = math.sqrt
local clock = os.clock
local rename = os.rename
local os_time = os.time
local format = string.format
local len = string.len
local gsub = string.gsub
local insert = table.insert
local concat = table.concat
local lines = io.lines
local type = type
local select = select
local require = require
local unpack = unpack
local setmetatable = setmetatable
local tonumber = tonumber
local xpcall = xpcall
local tostring = tostring
local ipairs = ipairs
local pairs = pairs
local memory = memory
local PED = PED
local PLAYER = PLAYER
local VEHICLE = VEHICLE
local NETWORK = NETWORK
local http = http
local stat = stat
local utils = utils
local globals = globals
local online = online
local ui = ui
local system = system
local OBJECT = OBJECT
local ENTITY = ENTITY
print=function(text)system.log("LUA", text)end

print([[

         *****  *                                                                               **            *****   **    **                                        
      ******  *                                               *                                  **        ******  ***** *****                                        
     **   *  *                                               ***                                 **       **   *  *  ***** *****                                      
    *    *  *                                                 *                                  **      *    *  *   * **  * **                                       
        *  *                                                                                     **          *  *    *     *                            **   ****     
       ** **      *** **** ****       ****        ****      ***     ***  ****       ***      *** **         ** **    *     *        ***    ***  ****     **    ***  * 
       ** **       *** **** ***  *   * ***  *    *  ***  *   ***     **** **** *   * ***    *********       ** **    *     *       * ***    **** **** *  **     ****  
     **** **        **  **** ****   *   ****    *    ****     **      **   ****   *   ***  **   ****        ** **    *     *      *   ***    **   ****   **      **   
    * *** **        **   **   **   **    **    **     **      **      **    **   **    *** **    **         ** **    *     *     **    ***   **    **    **      **   
       ** **        **   **   **   **    **    **     **      **      **    **   ********  **    **         ** **    *     **    ********    **    **    **      **   
  **   ** **        **   **   **   **    **    **     **      **      **    **   *******   **    **         *  **    *     **    *******     **    **    **      **   
 ***   *  *         **   **   **   **    **    **     **      **      **    **   **        **    **            *     *      **   **          **    **    **      **   
  ***    *          **   **   **   **    **    **     **      **      **    **   ****    * **    **        ****      *      **   ****    *   **    **     ******* **  
   ******           ***  ***  ***   ***** **    ********      *** *   ***   ***   *******   *****         *  *****           **   *******    ***   ***     *****   ** 
     ***             ***  ***  ***   ***   **     *** ***      ***     ***   ***   *****     ***         *     **                  *****      ***   ***               
                                                       ***                                               *                                                            
                                                 ****   ***                                               **                                                          
                                               *******  **                                                                                                            
                                              *     ****                                                                                                              
]]..format('v%s', VERSION))

--- @return string ScriptPath
function system.script_dir()
	local source = debug.getinfo(1).source
	local pwd = source:sub(2)
	return pwd:sub(1, pwd:find("[^\\]*%.lua")-1)
end

paths = {}
paths['Lua'] = system.script_dir()
paths['ImaginedMenu'] = paths['Lua']..[[ImaginedMenu]]
paths['Library'] = paths['ImaginedMenu']..[[\lib]]
paths['Data'] = paths['ImaginedMenu']..[[\data]]
paths['Translations'] = paths['ImaginedMenu']..[[\translations]]
paths['SavedVehicles'] = paths['ImaginedMenu']..[[\saved_vehicles]]
paths['SavedMaps'] = paths['ImaginedMenu']..[[\saved_maps]]
paths['CustomCommands'] = paths['ImaginedMenu']..[[\custom_commands]]
paths['Cache'] = paths['ImaginedMenu']..[[\cache]]
paths['XML'] = paths['Library']..[[\xmlhandler]]

files = {
	-- Important
	['EntityDb'] = paths['Library']..[[\entity_database.lua]],
	['Features'] = paths['Library']..[[\features.lua]],
	['FileSystem'] = paths['Library']..[[\filesys.lua]],
	['FuelConfig'] = paths['Library']..[[\fuel_consumption.lua]],
	['Global'] = paths['Library']..[[\global.lua]],
	['Json'] = paths['Library']..[[\JSON.lua]],
	['Peds'] = paths['Library']..[[\peds.lua]],
	['String'] = paths['Library']..[[\lua-string.lua]],
	['ScriptMemory'] = paths['Library']..[[\script_memory.lua]],
	['Switch'] = paths['Library']..[[\switch.lua]],
	['Vector3'] = paths['Library']..[[\vector3.lua]],
	['Vehicle'] = paths['Library']..[[\vehicle.lua]],
	['Weapons'] = paths['Library']..[[\weapons.lua]],
	['WorldSaver'] = paths['Library']..[[\world_saver.lua]],
	['WorldSpawner'] = paths['Library']..[[\world_spawner.lua]],
	['xml2lua'] = paths['Library']..[[\xml2lua.lua]],
	['XmlParser'] = paths['Library']..[[\XmlParser.lua]],
	['xmltree'] = paths['XML']..[[\tree.lua]],

	['TrapStTube'] = paths['Data']..[[\cages\st_tube.json]],
	['TrapStTubeInv'] = paths['Data']..[[\cages\st_tube_inv.json]],
	['TrapCage'] = paths['Data']..[[\cages\cage.json]],
	['Default'] = paths['Data']..[[\default.lua]],
	['Enums'] = paths['Data']..[[\enums.lua]],
	['GtaMap'] = paths['Data']..[[\gtamap.lua]],
	['Inputs'] = paths['Data']..[[\inputs.txt]],
	['IPLloc'] = paths['Data']..[[\ipls.lua]],
	['ObjectList'] = paths['Data']..[[\objectlist.txt]],
	['PedList'] = paths['Data']..[[\peds.txt]],
	['Props'] = paths['Data']..[[\props.lua]],
	['Ranks'] = paths['Data']..[[\ranks.lua]],
	['VehData'] = paths['Data']..[[\vehicle_data.json]],
	['WeaponData'] = paths['Data']..[[\weapons.json]],

	['Cache'] = paths['Cache']..[[\cache.lua]],
	['Dump'] = paths['Cache']..[[\dump.lua]],
	['Halo'] = paths['Cache']..[[\halo.lua]],
	['Loadchunk'] = paths['Cache']..[[\loadchunk.lua]],
	['CacheUtil'] = paths['Cache']..[[\util.lua]],
	['HaloClass'] = paths['Cache']..[[\halo\class.lua]],
	['HaloRegistry'] = paths['Cache']..[[\halo\registry.lua]],
	['HaloUtil'] = paths['Cache']..[[\halo\util.lua]],
	['Inmem'] = paths['Cache']..[[\lib\inmem.lua]],
	['UtilIs'] = paths['Cache']..[[\util\is.lua]],
	['UtilString'] = paths['Cache']..[[\util\string.lua]],
	['UtilTable'] = paths['Cache']..[[\util\table.lua]],
	['UtilTypeof'] = paths['Cache']..[[\util\typeof.lua]]
}

--for _, v in pairs(files) do print(v:gsub(system.script_dir(), ""):gsub("\\", "/")) end

local files = files
local paths = paths

local _insert = table.insert
table.insert = function(t, pos, value)
	if (value == nil) then
		t[#t+1] = pos
	else
		_insert( t, pos, value )
	end
end

function utils.check_files()
	system.log("Imagined Menu", "Checking files...")
	local missing = {}
	local function exists(file)
	    local ok, err, code = rename(file, file)
	    if not ok and code == 13 then
	        return true
	    end
	    return ok, err
	end

	for _, v in pairs(files)
	do
		if not exists(v) then
			insert(missing, v)
		end
	end

	if #missing == 0 then return end
	error('Missing files found:\n'..concat(missing, "\n"), 0)
end
utils.check_files()

files['TimeToBurn'] = paths['ImaginedMenu']..[[\time_to_burn.wav]]
files['Config'] = paths['ImaginedMenu']..[[\config.json]]
files['VehicleBlacklist'] = paths['ImaginedMenu']..[[\vehicle_blacklist.json]]
files['PlayerExcludes'] = paths['ImaginedMenu']..[[\player_excludes.json]]
files['SavedLocations'] = paths['ImaginedMenu']..[[\saved_locations.json]]
files['ForcedOutfit'] = paths['ImaginedMenu']..[[\forced_outfit.json]]

package.path = concat({package.path, paths['Library']..[[\?.lua]], paths['Data']..[[\?.lua]], paths['Cache']..[[\?.lua]]}, ';')

local inmem = require('lib.inmem')
require 'lua-string'
cache = inmem.new(30)
local cache = cache
local switch = require 'switch'
local json = require 'JSON'
local filesystem = require 'filesys'
local TRANSLATION = require('default').translation
local settings = require('default').settings
local vector3 = require 'vector3'
local enum = require 'enums'
local Global = require 'global'
local s_memory = require 'script_memory'
local features = require 'features'
local vehicles = require 'vehicle'
local weapons = require 'weapons'
local peds = require 'peds'
local objects = require 'props'
local EntityDb = require 'entity_database'
local world_spawner = require 'world_spawner'
local world_saver = require 'world_saver'
local fuelConsumption = require 'fuel_consumption'
local ipls = require 'ipls'

local function Init()
	cache:set('Default config', settings, 1000000)

	if not filesystem.isdir(paths['Translations']) then
		filesystem.make_dir(paths['Translations'])
	end

	if not filesystem.isdir(paths['SavedVehicles']) then
		filesystem.make_dir(paths['SavedVehicles'])
	end

	if not filesystem.isdir(paths['CustomCommands']) then
		filesystem.make_dir(paths['CustomCommands'])
	end

	for _, v in ipairs(objects)
	do
		Global.valid_objects[utils.joaat(v)] = true
	end
end

Init()

local POP_THREAD = 0
local __submenus = {}
local __suboptions = {}
local __options = {
	bool = {},
	click = {},
	num = {},
	choose = {},
	players = {},
	color = {},
	string = {}
}
local native = {}
local vehicle_blacklist = {}
vehicle_blacklist.vehicles = {}
vehicle_blacklist.options = {}

-- features
--- @param add bool
--- @param name string
--- @param func function()
--- @param priority? bool
--- @return bool
function system.thread(add, name, func, priority)
	name = tostring(name)
	if add then
		Global.thread_count = Global.thread_count + 1
		Global.threads[name] = {f = func, time = clock(), priority = (priority == true)}
	else
		if not Global.threads[name] then return false end
		Global.threads[name] = nil
	end
	system.reset_thread_tick(name)
	return true
end

--- @param name? string
--- @return bool
function system.remove_thread(name)
	return system.thread(false, name or Global.this_name)
end

--- @return int
function system.thread_count()
	return Global.thread_count
end

--- @param time int
--- @param name? string
function system.thread_pause(time, name)
	time = tonumber(time) and tonumber(time) or 0
	Global.threads[name or Global.this_name].pause = clock() + time / 1000
end

--- @param name? string
--- @return int
function system.get_tick(name)
	return Global.ticks[name or Global.this_name] or 0
end

--- @param name? string
--- @return bool
function system.is_thread_active(name)
	return Global.threads[name or Global.this_name] ~= nil
end

--- @param name? string
function system.reset_thread_tick(name)
	Global.ticks[name or Global.this_name] = nil
end

--- @param entity Entity
--- @param func function()
--- @param timeout? float
function entities.request_control(entity, func, timeout)
	if not entity or not func or ENTITY.DOES_ENTITY_EXIST(entity) == 0 then return end
	Global.to_request_control[Global.to_request_count] = {entity = entity, func = func, timeout = clock() + (timeout or 2)}
	Global.to_request_count = Global.to_request_count + 1
end

native.log = system.log

--- @param prefix any
--- @param text any
system.log = function(...)
	local prefix, text
	if select("#",...) == 1 then
		prefix = TRANSLATION["Imagined Menu"]
		text = ...
	else
		prefix, text = ...
	end
	prefix, text = tostring(prefix), tostring(text)
	if prefix == "debug" and not settings.Dev.Enable then return end
	if cache:get("last_log") == format("[%s] %s", prefix, text) then
		Global.log_repeats = Global.log_repeats + 1
		return
	else
		if cache:get("last_log") and Global.log_repeats > 0 then
			native.log("repeated", format("(%i) %s", Global.log_repeats, Global.log_repeats == 1 and "time" or "times"))
		end
		native.log(prefix, text)
		cache:set("last_log", format("[%s] %s", prefix, text), 1000000)
		Global.log_repeats = 0
	end
end

native.notify = system.notify

--- @param prefix string
--- @param text string
--- @param color table
--- @param sound? bool
--- @param log? bool
--- @param tutorial? bool
system.notify = function(prefix, text, color, sound, log, tutorial)
	if settings.General["DisableNotifications"] and not tutorial then return end
	if settings.General["NotificationSound"] and sound then AUDIO.PLAY_SOUND_FRONTEND(-1, "GOLF_EAGLE", "HUD_AWARDS", true) end
	color = color or settings.General["HudColorNotifyNormal"]
	native.notify(prefix, text, color.r, color.g, color.b, color.a)
	if not log then return end
	system.log(TRANSLATION["Imagined Menu"], text)
end

native.get_selected = online.get_selected_player

--- @return int Player
online.get_selected_player = function()
	return Global.selected_player or native.get_selected()
end

native.send_chat = online.send_chat

--- @param message string
--- @param ignore_queue? bool
online.send_chat = function(message, ignore_queue)
	if ignore_queue == true then return native.send_chat(message) end
	if settings.Session["DisableChat"] then return end
	insert(Global.chat_queue, message)
end

system.thread(true, 'send_chat_queue', function()
	if (Global.chat_wait and Global.chat_wait > clock()) or #Global.chat_queue == 0 then return end
	native.send_chat(Global.chat_queue[1])
	table.remove(Global.chat_queue, 1)
	Global.chat_wait = clock() + .1
end)

native.add_submenu = ui.add_submenu

--- @param name string
--- @return int sub_id
ui.add_submenu = function(name)
	local sub = native.add_submenu(name)
	Global.subs[sub] = true
	return sub
end

native.add_sub_option = ui.add_sub_option

--- @param name string
--- @param sub_parent int
--- @param sub int
--- @return int option_id
ui.add_sub_option = function(name, sub_parent, sub)
	local subopt = native.add_sub_option(name, sub_parent, sub)
	Global.sub_parent[sub] = sub_parent
	if not Global.sub_kids[sub_parent] then
		Global.sub_kids[sub_parent] = {}
	end
	Global.sub_kids[sub_parent][sub] = true
	return subopt
end

native.ui_close = ui.close
ui.close = function()
	Global.disable_menu_sound = true
	return native.ui_close()
end

native.ui_open = ui.open
ui.open = function()
	Global.disable_menu_sound = true
	return native.ui_open()
end

--- @param command table
--- @param data table
function system.register_command(command, data)
	if type(command) ~= "table" then return end
	for _, v in ipairs(command)
	do
		if not Global.commands[v] then
			insert(Global.command_list, v)
			table.sort(Global.command_list)
		end
		Global.commands[v] = data
	end
end

--- @param command string
function system.unregister_command(command)
	Global.commands[command] = nil
	for i, v in ipairs(Global.command_list)
	do
		if v == command then
			table.remove(Global.command_list, i)
			return
		end
	end
end

native.ui_click = ui.add_click_option

--- @param name string
--- @param sub int
--- @param func function()
--- @param command? table
--- @param is_player? bool
--- @return int option_id
ui.add_click_option = function(name, sub, func, command, is_player)
	local opt = native.ui_click(name, sub, func)
	local data = {
		type = "click",
		func = func,
		is_player = is_player,
		option_id = opt
	}
	system.register_command(command, data)
	return opt
end

native.ui_tog = ui.add_bool_option

--- @param name string
--- @param sub int
--- @param func function(bool)
--- @param command? table
--- @param is_player? bool
--- @return int option_id
ui.add_bool_option = function(name, sub, func, command, is_player)
	local opt = native.ui_tog(name, sub, func)
	local data = {
		type = "tog",
		is_player = is_player,
		option_id = opt
	}
	system.register_command(command, data)
	return opt
end

function utils.get_choose_actions(actions)
	local lower_case = {}
	for i, v in ipairs(actions) do
		lower_case[i] = v:lower()
	end
	return lower_case
end

native.ui_choose = ui.add_choose

--- @param name string
--- @param sub int
--- @param horizontal bool
--- @param actions table
--- @param func function(int)
--- @param command? table
--- @param is_player? bool
--- @return int option_id
ui.add_choose = function(name, sub, horizontal, actions, func, command, is_player)
	local opt = native.ui_choose(name, sub, horizontal, actions, func)
	local data = {
		type = "choose",
		func = func,
		actions = utils.get_choose_actions(actions),
		is_player = is_player,
		option_id = opt
	}
	system.register_command(command, data)
	return opt
end

native.ui_num = ui.add_num_option

--- @param name string
--- @param sub int
--- @param min int
--- @param max int
--- @param step int
--- @param func function(int)
--- @param command? table
--- @param is_player? bool
--- @return int option_id
ui.add_num_option = function(name, sub, min, max, step, func, command, is_player)
	local opt = native.ui_num(name, sub, min, max, step, func)
	local data = {
		type = "int",
		min = min,
		max = max,
		step = step,
		is_player = is_player,
		option_id = opt
	}
	system.register_command(command, data)
	return opt
end

native.ui_float = ui.add_float_option

--- @param name string
--- @param sub int
--- @param min float
--- @param max float
--- @param step float
--- @param precision float
--- @param func function(float)
--- @param command? table
--- @param is_player? bool
--- @return int option_id
ui.add_float_option = function(name, sub, min, max, step, precision, func, command, is_player)
	local opt = native.ui_float(name, sub, min, max, step, precision, func)
	local data = {
		type = "float",
		min = min,
		max = max,
		step = step,
		is_player = is_player,
		option_id = opt
	}
	system.register_command(command, data)
	return opt
end

native.ui_str = ui.add_input_string

--- @param name string
--- @param sub int
--- @param func function(string)
--- @param command? table
--- @param is_player? bool
--- @return int option_id
ui.add_input_string = function(name, sub, func, command, is_player)
	local opt = native.ui_str(name, sub, func)
	local data = {
		type = "string",
		func = func,
		is_player = is_player,
		option_id = opt
	}
	system.register_command(command, data)
	return opt
end

native.ui_remove = ui.remove

--- @param optionID int
ui.remove = function(optionID)
	if not optionID then return end
	native.ui_remove(optionID)
	if Global.subs[optionID] then
		local parent = Global.sub_parent[optionID]
		if parent and Global.sub_kids[parent] then
			Global.sub_kids[parent][optionID] = nil
		end
		Global.sub_kids[optionID] = nil
		Global.subs[optionID] = nil
	end
end

ui.ignore_rgb_callback = {}
native.set_value = ui.set_value

--- @param optionID int
--- @param value bool 
--- @param ignore_callback bool
ui.set_value = function(optionID, ...) -- fix for color_picker executing callbacks
	if select('#', ...) > 3 then
		local r, g, b, a, ignore_callback = ...
		if ignore_callback then
			ui.ignore_rgb_callback[optionID] = true
		end
		native.set_value(optionID, r, g, b, a, ignore_callback)
	else
		local value, ignore_callback = ...
		native.set_value(optionID, value, ignore_callback)
	end
end

local command_move = {}

function command_move.set_last(pos)
	Global.last_com_pos = pos
	system.open_command_box(Global.last_commands[pos])
end

function command_move.last_up()
	local len = #Global.last_commands
	local pos = Global.last_com_pos + 1 <= len and Global.last_com_pos + 1 or 1
	command_move.set_last(pos)
end

function command_move.last_down()
	local len = #Global.last_commands
	local pos = Global.last_com_pos - 1 >= 1 and Global.last_com_pos - 1 or len
	command_move.set_last(pos)
end

function command_move.set_result(pos)
	Global.result_com_pos = pos
	system.open_command_box(Global.command_results[pos])
	if not Global.command_scroll_wait then
		Global.command_scroll_wait = clock() + .5
	end
end

function command_move.result_up()
	local len = #Global.command_results
	local pos = Global.result_com_pos + 1 <= len and Global.result_com_pos + 1 or 1
	command_move.set_result(pos)
end

function command_move.result_down()
	local len = #Global.command_results
	local pos = Global.result_com_pos - 1 >= 1 and Global.result_com_pos - 1 or len
	command_move.set_result(pos)
end

--- @param command string
--- @param cleardata? bool
system.open_command_box = function(command, cleardata)
	MISC.DISPLAY_ONSCREEN_KEYBOARD(6, "PC_CHEAT_TITLE", "", command:ensurestart("> "), "", "", "", 60)
	Global.onscreen_keyboard = true
	if cleardata then
		Global.is_menu_open = ui.is_open()
		Global.command_results = {}
		Global.last_com_pos = 0
		Global.result_com_pos = 1
	end
end

local Instructional = {}
function Instructional:New()
	if GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(self.scaleform) == 1 then
		GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(self.scaleform, "CLEAR_ALL")
		GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
    	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(self.scaleform, "TOGGLE_MOUSE_BUTTONS")
		GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(true)
		GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
		self.pos = 0
    	return true
	else
		self.scaleform = GRAPHICS.REQUEST_SCALEFORM_MOVIE("INSTRUCTIONAL_BUTTONS")
		return
  	end
end

function Instructional:BackgroundColor(r, g, b, a)
	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(self.scaleform, "SET_BACKGROUND_COLOUR")
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(r)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(g)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(b)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(a)
	GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
end

function Instructional:SetDataSlot(control, name, button)
	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(self.scaleform, "SET_DATA_SLOT")
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(self.pos)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_PLAYER_NAME_STRING(button)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(name)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(false)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(control)
	GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
	self.pos = self.pos + 1
end

function Instructional.AddButton(control, name)
	local button = PAD.GET_CONTROL_INSTRUCTIONAL_BUTTON(0, control, true)
  	Instructional:SetDataSlot(control, name, button)
end

function Instructional:Draw()
	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(self.scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
	GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
  	GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(self.scaleform, 255, 255, 255, 255, 0)
	self.pos = 0
end

local function hide_subs(bool)
	for _, v in ipairs({"Self", "Session", "Vehicle", "World", "Teleport", "Weapons", "Misc", "Recovery"})
	do
		ui.hide(__suboptions[v], bool)
	end
end

local function get_version(version)
	local ver = {}
	for match in version:gmatch("%d+")
	do
		insert(ver, tonumber(match))
	end
	return ver
end

local function compare_versions(version1, version2)
	if version1[1] > version2[1] then
		return true
	elseif version1[1] < version2[1] then
		return false
	elseif version1[2] > version2[2] then
		return true
	elseif version1[2] < version2[2] then
		return false
	elseif version1[3] > version2[3] then
		return true
	else
		return false
	end
end

local function start_tutorial()
	if system.is_thread_active("tutorial") then return utils.hud_sound("ERROR") end
	settings.General["IsTutorialCompleted"] = false
	hide_subs(true)
	local step_completed = {}
	local step
	local wait
	local time = clock() + 5
	system.register_command({"completetutorial"}, {type = "click", func = function()
		if not system.is_thread_active("tutorial") then return utils.hud_sound("ERROR") end
		system.remove_thread("tutorial")
		settings.General["IsTutorialCompleted"] = true
		system.notify(TRANSLATION["Tutorial"], TRANSLATION["Tutorial completed"].." :)", nil, nil, nil, true)
		hide_subs(false)
		utils.hud_sound("SELECT")
		local conf = cache:get("LoadedConfig") or cache:get("Default config")
		conf.General["IsTutorialCompleted"] = true
		cache:set("LoadedConfig", conf, 1000000)
		system.save_conf(conf)
	end})
	system.thread(true, "tutorial", function()
		if not step then
			if time > clock() then return end
			system.notify(TRANSLATION["Tutorial"], TRANSLATION["You can display option info by holding \"%s\" and pressing an option"]:format("V"), nil, true, nil, true)
			step = 1
			time = clock() + 9
		end
		if step == 0 then
			if not wait then wait = clock() + 11 end
			if Global.onscreen_keyboard then
				step = 2
				return
			elseif wait and wait < clock() then
				step = 1
				wait = nil
				return
			end
		end
		if step == 1 and time < clock() then
			system.notify(TRANSLATION["Tutorial"], TRANSLATION["Please open command box by pressing F2 or find it in the Imagined Menu"], nil, true, nil, true)
			step = 0
			return
		end
		if step == 2 and time < clock() then
			if step_completed[2] then step = 3 return end
			system.notify(TRANSLATION["Tutorial"], TRANSLATION["You can use autocomplete in command box by pressing enter"], nil, true, nil, true)
			time = clock() + 9
			step_completed[2] = true
			step = 3
		end
		if step > 2 and not Global.onscreen_keyboard then
			step = 1
		end
		if step == 3 and time < clock() then
			if step_completed[3] then step = 4 return end
			system.notify(TRANSLATION["Tutorial"], TRANSLATION["Then switch commands by using Tab and LShift + Tab"], nil, true, nil, true)
			time = clock() + 9
			step_completed[3] = true
			step = 4
		end
		if step == 4 and time < clock() then
			if step_completed[4] then step = 5 return end
			system.notify(TRANSLATION["Tutorial"], TRANSLATION["Script will remember your last commands"], nil, true, nil, true)
			time = clock() + 9
			step_completed[4] = true
			step = 5
		end
		if step == 5 and time < clock() then
			if step_completed[5] then step = 6 return end
			system.notify(TRANSLATION["Tutorial"], TRANSLATION["You can switch between last commands by using up and down arrows"], nil, true, nil, true)
			time = clock() + 9
			step_completed[5] = true
			step = 6
		end
		if step == 6 and time < clock() then
			system.notify(TRANSLATION["Tutorial"], TRANSLATION["Please type \"%s\" to finish"]:format("completetutorial"), nil, true, nil, true)
			step = 7
		end
	end)
end

local function do_saving_anim()
	local loops = 0
	system.thread(true, 'saving_anim', function(tick)
		if loops == 5 or not settings.General["ShowSaveIcon"] then return POP_THREAD end
		local res = features.get_screen_resolution()
		local ratioY = 0.004 * (res.x / res.y)
		if tick < 10 then
			GRAPHICS.DRAW_RECT(0.95, 0.95, 0.004, ratioY, 255, 255, 255, 168, true)
		elseif tick < 20 then
			GRAPHICS.DRAW_RECT(0.95, 0.95, 0.004, ratioY, 255, 255, 255, 128, true)
			GRAPHICS.DRAW_RECT(0.96, 0.95, 0.004, ratioY, 255, 255, 255, 168, true)
		elseif tick < 30 then
			GRAPHICS.DRAW_RECT(0.95, 0.95, 0.004, ratioY, 255, 255, 255, 128, true)
			GRAPHICS.DRAW_RECT(0.96, 0.95, 0.004, ratioY, 255, 255, 255, 168, true)
			GRAPHICS.DRAW_RECT(0.97, 0.95, 0.004, ratioY, 255, 255, 255, 128, true)
		elseif tick < 40 then
			GRAPHICS.DRAW_RECT(0.96, 0.95, 0.004, ratioY, 255, 255, 255, 128, true)
			GRAPHICS.DRAW_RECT(0.97, 0.95, 0.004, ratioY, 255, 255, 255, 168, true)
		elseif tick < 50 then
			GRAPHICS.DRAW_RECT(0.97, 0.95, 0.004, ratioY, 255, 255, 255, 168, true)
		else
			loops = loops + 1
			system.reset_thread_tick()
		end
	end)
end

--- @param tab1 table
--- @param tab2 table
--- @return table
function utils.connect_tables(tab1, tab2)
	for _, v in ipairs(tab2)
	do
		insert(tab1, v)
	end
	return tab1
end

--- @param object int|string
--- @param x float
--- @param y float
--- @param z float
--- @param rotx float
--- @param roty float
--- @param rotz float
--- @param invisible? bool 
function utils.block_area(object, x, y, z, rotx, roty, rotz, invisible)
	system.thread(true, 'request_model_'..system.thread_count(), function()
	  	if features.request_model(object) == 0 then return end
	    local obj = features.create_object(object, vector3(x, y, z))
	    if obj == 0 then return POP_THREAD end
	    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(obj, false, true)
	    ENTITY._SET_ENTITY_CLEANUP_BY_ENGINE(obj, true)
	    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(obj, x, y, z, false, false, false)
	    ENTITY.SET_ENTITY_ROTATION(obj, rotx, roty, rotz, 5, true)
	    ENTITY.FREEZE_ENTITY_POSITION(obj, true)
		ENTITY.SET_ENTITY_LOD_DIST(obj, 0xffff) -- make it to not disappear, so I can remove this
	    insert(Global.blockobjects, obj)
	    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(object)
	    if not invisible then return POP_THREAD end
	    ENTITY.SET_ENTITY_VISIBLE(obj, false, false)
	   	return POP_THREAD
	end)
end

--- @param name string
--- @param ref string
--- @param entity Entity
function utils.play_sound(name, ref, entity)
	local entity = entity or features.player_ped()
	AUDIO.PLAY_SOUND_FROM_ENTITY(-1, name, entity, ref, true, 0)
end

function utils.stop_sounds()
	for i = 0, 100
	do
		AUDIO.STOP_SOUND(i)
	end
end

local function welcome_screen()
	local scaleform = GRAPHICS.REQUEST_SCALEFORM_MOVIE("MP_BIG_MESSAGE_FREEMODE")
	while GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(scaleform) == 0
	do
		system.yield()
	end
	local welcome = (not settings.General["IsTutorialCompleted"] and TRANSLATION["Welcome %s to Imagined Menu!"] or TRANSLATION["Welcome back %s!"])
	system.notify('Imagined Menu', format(welcome..'\n%s %s\n%s %s, %s %s %s', SOCIALCLUB._SC_GET_NICKNAME(), TRANSLATION["Version"], VERSION, TRANSLATION["Credits to"], 'SATTY', 'Dr Donger', TRANSLATION["and"], 'ItsPxel'), settings.General["HudColorNotifySuccess"])
	AUDIO.PLAY_SOUND_FRONTEND(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true)
	local t = clock() + 2.5
	system.thread(true, 'start_screen', function()
		if clock() <= t then
			GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
			GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(scaleform, 0, 0, 0, 0, 0)
			GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING('~p~'..TRANSLATION["Welcome"])
			GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(format('~b~'..welcome, SOCIALCLUB._SC_GET_NICKNAME()))
			GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
			return
		end
		AUDIO.PLAY_SOUND_FRONTEND(-1, "FocusOut", "HintCamSounds", true)
		return POP_THREAD
	end)
end

--- @param type int
function utils.block_passive(type)
	for i = 0, 31 do
		if i ~= PLAYER.PLAYER_ID() and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and not (settings.General['Exclude Friends'] and features.is_friend(i)) and not features.is_excluded(i) then
			online.send_script_event(i, 1920583171, PLAYER.PLAYER_ID(), type)
		end
	end
end

--- @param type int
--- @return bool
function utils.inf_invite(type)
	local found
	for i = 0, 31 do
		if i ~= PLAYER.PLAYER_ID() and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and not (settings.General['Exclude Friends'] and features.is_friend(i)) and not features.is_excluded(i) then
	      	online.send_script_event(i, -168599209, PLAYER.PLAYER_ID(), i, 4294967295, 1, 115, type, type, type)
	      	found = true
      	end
  	end
  	return found
end

--- @param message string
--- @return bool
function utils.is_begging(message)
	local text = message:strip():lower()
	for _, v in ipairs(enum.begger_messages)
	do
		if text:find(v) then
			return true
		end
	end
	return false
end

function utils.no_sounds_this_frame()
	Global.dont_play_tog = true
end

local function play_hud_sound()
	AUDIO.PLAY_SOUND_FRONTEND(-1, Global.sound_name, "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
	system.remove_thread()
end

--- @param name string
function utils.hud_sound(name)
	if not settings.General["HudSounds"] or (features.compare(name, "TOGGLE_ON", "YES") and Global.dont_play_tog) or ((name == "continue" or name == "Back") and Global.disable_menu_sound) then return end
	Global.sound_name = name
	system.thread(true, 'play_hud_sound', play_hud_sound)
end

--- @param command string
--- @param additionalinfo? string
function utils.show_info(command, additionalinfo)
	if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.NEXT_CAMERA) == 0 then return end
	system.notify(TRANSLATION["Imagined Menu"], ("%s%s%s"):format(additionalinfo and (TRANSLATION["Info"]..': '..additionalinfo) or "", (additionalinfo and not command:isblank()) and ("\n") or "", (not command:isblank() and TRANSLATION["Command"]..": "..command) or ""), settings.General["HudColorOptionInfo"])
	return true
end

--- @param command string
--- @return bool
function utils.is_chat_command(command)
	if command:lower():find(format('^%s', Global.commad_prefix[settings.Commands['CommandsPrefix']]:escpattern())) then return true end
	return false
end

-- menu commands

do
	system.register_command({"maxgear", "allweapons"}, {
		type = "click",
		func = function()
			local weapon = {}
			for _, v in ipairs(weapons.hashes)
			do
				insert(weapon, {Hash = v, Tint = 0, Components = weapons.components[v]})
			end
			peds.set_weapons(weapon)
			utils.hud_sound("SELECT")
		end
	})
	system.register_command({"getweapon"}, {
		type = "choose",
		actions = utils.get_choose_actions(weapons.names),
		func = function(weapo)
			utils.hud_sound("SELECT")
			local hash = weapons.hashes[weapo]
            WEAPON.GIVE_WEAPON_TO_PED(features.player_ped(), hash, 9999, false, false)
            for _, e in ipairs(weapons.components[hash])
            do
                if WEAPON.HAS_PED_GOT_WEAPON_COMPONENT(features.player_ped(), hash, e) == 0 then
                    WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(features.player_ped(), hash, e)
                end
            end
			peds.set_max_ammo(hash)
		end
	})
	system.register_command({"removeweapons"}, {
		type = "click",
		func = function()
			utils.hud_sound("SELECT")
			WEAPON.REMOVE_ALL_PED_WEAPONS(features.player_ped(), false)
		end
	})
	system.register_command({"heal"}, {
		type = "click",
		func = function()
			utils.hud_sound("SELECT")
			local health = ENTITY.GET_ENTITY_MAX_HEALTH(features.player_ped())
			ENTITY.SET_ENTITY_HEALTH(features.player_ped(), health, 0)
		end
	})
	system.register_command({"fullammo", "giveammo"}, {
		type = "click",
		func = function()
			utils.hud_sound("SELECT")
			local weapon = peds.get_weapons()
			for _, v in ipairs(weapon)
			do
				peds.set_max_ammo(v.Hash)
			end
		end
	})
	system.register_command({"nigger", "nigga"}, {
		type = "click",
		hidden = true,
		func = function()
			local model = ENTITY.GET_ENTITY_MODEL(features.player_ped())
			if model ~= utils.joaat("mp_f_freemode_01") and model ~= utils.joaat("mp_m_freemode_01") then return utils.hud_sound("ERROR") end
			utils.hud_sound("SELECT")
			PED.SET_PED_HEAD_BLEND_DATA(features.player_ped(), 0, 0,  0, 2, 2, 2, 0, 1, 0, false)
			system.notify(TRANSLATION["Imagined Menu"], "Who's black now?", settings.General["HudColorNotifyNormal"])
		end
	})
	system.register_command({"kys"}, {
		type = "click",
		hidden = true,
		func = function()
			if NETWORK.NETWORK_IS_SESSION_STARTED() == 0 then return utils.hud_sound("ERROR") end
			utils.hud_sound("SELECT")
			WEAPON.GIVE_WEAPON_TO_PED(features.player_ped(), utils.joaat("weapon_pistol"), 9999, false, false)
			system.notify(TRANSLATION["Imagined Menu"], "Ok", settings.General["HudColorNotifyNormal"])
			globals.set_int(1574582 + 6, 1)
		end
	})
	system.register_command({"nightfall"}, {
		type = "click",
		func = function()
			ui.open()
			utils.hud_sound("SELECT")
		end
	})

end

-- commands
local cmd = {}

cmd.spawn = function(id, veh)
	if Global.veh_spawn_timeout[id] and Global.veh_spawn_timeout[id] > clock() then return end
	if not veh or veh:isblank() then return false, "Enter name or hash of vehicle" end
	local loaded, hash = features.request_model(veh)
	if not hash and #veh > 2 then
		local name = veh:escpattern():ensurestart('^')
		for _, v in ipairs(vehicles.data)
		do
			if v.Name:find(name) or (v.DisplayName and v.DisplayName:lower():find(name)) or vehicles.get_label_name(v.Hash):lower():find(name) then
				hash = v.Hash
				break
			end
		end
		if STREAMING.IS_MODEL_VALID(hash) == 1 and STREAMING.IS_MODEL_A_VEHICLE(hash) == 1 then
			veh = hash
		else
			return false, "Invalid model"
		end
	end
	if STREAMING.IS_MODEL_A_VEHICLE(hash) == 0 then return false, "This model is not a vehicle" end
	system.log('debug', hash)
	if settings.Session["VehicleBlacklist"] and vehicle_blacklist.vehicles[tostring(hash)] and not (features.is_friend(id) and settings.General["Exclude Friends"]) then
		system.notify(TRANSLATION["Imagined Menu"], format(TRANSLATION["Player %s tried to spawn a blacklisted vehicle"], online.get_name(id)), settings.General["HudColorNotifyError"]) 
		return false, "This model is blacklisted"
	end
	Global.veh_spawn[id] = Global.veh_spawn[id] + 1
	if Global.veh_spawn[id] > 5 then
		Global.veh_spawn_timeout[id] = clock() + 60
		Global.veh_spawn[id] = 0
		system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Player %s spawned too many vehicles using commands, timeout 1 minute"]:format(online.get_name(id)), settings.General["HudColorNotifyNormal"])
		return false, "You tried to spawn more than 5 vehicles and you have been timed out for 1 minute"
	end
	Global.veh_spawn_timeout[id] = nil
	system.thread(true, 'cmd_spawn_'..system.thread_count(), function(tick)
		if tick==3000 then return POP_THREAD end
		loaded, hash = features.request_model(veh)
		if loaded == 0 then return end
		local target = ENTITY.IS_ENTITY_VISIBLE(features.player_ped(id)) == 1 and features.get_offset_coords_from_entity_rot(features.player_ped(id), 6, 0, true) or features.get_player_coords2(id)
		local vehicle = vehicles.spawn_vehicle(hash, target, features.get_player_heading(id))
		if vehicle == 0 then return POP_THREAD end
		entities.request_control(vehicle, function()
			-- DECORATOR.DECOR_SET_INT(vehicle, "MPBitset", 1024)
			VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, false)
			VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "Nightfal")
		end)
		STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
		return POP_THREAD
	end)
	return true
end

cmd.freeze = function(id, pl, bool)
	if not pl then return false, "Enter player id or name" end
	local target = features.player_from_name(pl)
	if not target then return false, (tonumber(pl) and tonumber(pl) < 32 and tonumber(pl) >= 0) and ("There is no player with id "..pl) or ("There is no player with name "..pl) end
	if target == PLAYER.PLAYER_ID() or (settings.Commands["Don't Affect Friends"] and features.is_friend(target)) or features.is_excluded(target) then return false, "You can't use it on this player" end
	if bool and bool:tobool() == false then
		Global.playerlist[target]["Freeze"] = false
	elseif bool and bool:tobool() == true then
		Global.playerlist[target]["Freeze"] = true
	else
		Global.playerlist[target]["Freeze"] = not Global.playerlist[target]["Freeze"]
	end
	return true
end

cmd.island = function(id, pl)
	if not pl then return false, "Enter player id or name" end
	local target = features.player_from_name(pl)
	if not target then return false, (tonumber(pl) and tonumber(pl) < 32 and tonumber(pl) >= 0) and ("There is no player with id "..pl) or ("There is no player with name "..pl) end
	if target == PLAYER.PLAYER_ID() or (settings.Commands["Don't Affect Friends"] and features.is_friend(target)) or features.is_excluded(target) then return false, "You can't use it on this player" end
	system.thread(true, 'cmd_island_'..id, function()
		online.send_script_event(target, -910497748, PLAYER.PLAYER_ID(), 1)
		return POP_THREAD
	end)
	return true
end

cmd.kick = function(id, pl)
	if not pl then return false, "Enter player id or name" end
	local target = features.player_from_name(pl)
	if not target then return false, (tonumber(pl) and tonumber(pl) < 32 and tonumber(pl) >= 0) and ("There is no player with id "..pl) or ("There is no player with name "..pl) end
	if target == PLAYER.PLAYER_ID() or (settings.Commands["Don't Affect Friends"] and features.is_friend(target)) or features.is_excluded(target) then return false, "You can't use it on this player" end
	system.thread(true, 'cmd_kick_'..id, function()
		features.kick_player(target)
		return POP_THREAD
	end)
	return true
end

cmd.crash = function(id, pl)
	if not pl then return false, "Enter player id or name" end
	local target = features.player_from_name(pl)
	if not target then return false, (tonumber(pl) and tonumber(pl) < 32 and tonumber(pl) >= 0) and ("There is no player with id "..pl) or ("There is no player with name "..pl) end
	if target == PLAYER.PLAYER_ID() or (settings.Commands["Don't Affect Friends"] and features.is_friend(target)) or features.is_excluded(target) then return false, "You can't use it on this player" end
	system.thread(true, 'cmd_crash_'..id, function()
		features.crash_player(target)
		return POP_THREAD
	end)
	return true
end

cmd.explode = function(id, pl)
	if not pl then return false, "Enter player id or name" end
	local target = features.player_from_name(pl)
	if not target then return false, (tonumber(pl) and tonumber(pl) < 32 and tonumber(pl) >= 0) and ("There is no player with id "..pl) or ("There is no player with name "..pl) end
	if target == PLAYER.PLAYER_ID() or (settings.Commands["Don't Affect Friends"] and features.is_friend(target)) or features.is_excluded(target) then return false, "You can't use it on this player" end
	system.thread(true, 'cmd_explode_'..id, function()
		local pos = features.get_player_coords2(target)
		FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, enum.explosion.ROCKET, 10, true, false, 1.0, false)
		return POP_THREAD
	end)
	return true
end

cmd.kickAll = function(id)
	system.thread(true, 'cmd_kickall_'..id, function(i)
		if not (settings.Commands["Don't Affect Friends"] and features.is_friend(i)) and (i ~= id) and (i ~= PLAYER.PLAYER_ID()) and not features.is_excluded(i) and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 then
			features.kick_player(i)
		end
		if i == 31 then return POP_THREAD end
	end)
	return true
end

cmd.crashAll = function(id)
	system.thread(true, 'cmd_crashall_'..id, function(i)
		if not (settings.Commands["Don't Affect Friends"] and features.is_friend(i)) and (i ~= id) and (i ~= PLAYER.PLAYER_ID()) and not features.is_excluded(i) and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 then
			features.crash_player(i)
		end
		if i == 31 then return POP_THREAD end
	end)
	return true
end

cmd.explodeAll = function(id)
	system.thread(true, 'cmd_explodeall_'..id, function()
		for i = 0, 31 do
			if not (settings.Commands["Don't Affect Friends"] and features.is_friend(i)) and (i ~= id) and (i ~= PLAYER.PLAYER_ID()) and not features.is_excluded(i) and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 then
				local pos = features.get_player_coords2(i)
				FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, enum.explosion.ROCKET, 10, true, false, 1.0, false)
			end
		end
		return POP_THREAD
	end)
	return true
end

cmd.clearwanted = function(id, bool)
	if bool and bool:tobool() == false then
		bool = false
	elseif bool and bool:tobool() == true then
		bool = true
	else
		bool = not system.is_thread_active('cmd_clearwanted_'..id)
	end
	if settings.Commands["ChatCommandResponse"] then
		online.send_chat(("∑ %s clear wanted level for %s"):format(bool and "Enabled" or "Disabled", online.get_name(id)))
	end
	system.thread(true, 'cmd_clearwanted_'..id, function(tick)
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(id) == 0 or NETWORK.NETWORK_IS_SESSION_STARTED() == 0 or not bool then return POP_THREAD end
		if tick%5~=0 or PLAYER.GET_PLAYER_WANTED_LEVEL(id) == 0 then return end
		online.send_script_event(id, 2080651008, PLAYER.PLAYER_ID(), globals.get_int(1894573 + (1 + (id * 608) + 510)))
		online.send_script_event(id, 1071490035, PLAYER.PLAYER_ID(), 0, 0, NETWORK.GET_NETWORK_TIME(), 0, globals.get_int(1894573 + (1 + (id * 608) + 510)))
	end)
	return true
end

cmd.offradar = function(id, bool)
	if bool and bool:tobool() == false then
		bool = false
	elseif bool and bool:tobool() == true then
		bool = true
	else
		bool = not system.is_thread_active('cmd_offradar_'..id)
	end
	if settings.Commands["ChatCommandResponse"] then
		online.send_chat(("∑ %s off the radar for %s"):format(bool and "Enabled" or "Disabled", online.get_name(id)))
	end
	system.thread(true, 'cmd_offradar_'..id, function(tick)
		if tick%5~=0 then return end
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(id) == 0 or NETWORK.NETWORK_IS_SESSION_STARTED() == 0 or not bool then return POP_THREAD end
		online.send_script_event(id, -162943635, PLAYER.PLAYER_ID(), NETWORK.GET_NETWORK_TIME() - 60, NETWORK.GET_NETWORK_TIME(), 1, 1, globals.get_int(1894573 + (1 + (id * 608) + 510)))
	end)
	return true
end

cmd.vehiclegod = function(id, bool)
	system.thread(true, 'cmd_vehiclegod_'..id, function()
		local value = true
		if bool and bool:tobool() == false then
			value = false
		end
		local veh = vehicles.get_player_vehicle(id)
		if veh == 0 then return POP_THREAD end
		entities.request_control(veh, function() vehicles.set_godmode(veh, value) end)
		return POP_THREAD
	end)
	return true
end

cmd.upgrade = function(id)
	system.thread(true, 'cmd_upgrade_'..id, function()
		local veh = vehicles.get_player_vehicle(id)
		if veh == 0 then return POP_THREAD end
		entities.request_control(veh, function() vehicles.upgrade(veh) end)
		return POP_THREAD
	end)
	return true
end

cmd.repair = function(id)
	system.thread(true, 'cmd_repair_'..id, function()
		local veh = vehicles.get_player_vehicle(id)
		if veh == 0 then return POP_THREAD end
		entities.request_control(veh, function() vehicles.repair(veh) end)
		return POP_THREAD
	end)
	return true
end

cmd.freezeall = function(id, bool)
	if bool and bool:tobool() == false then
		bool = false
	else
		bool = true
	end
	if settings.Commands["ChatCommandResponse"] then
		online.send_chat(("∑ %s freeze for all"):format(bool and "Enabled" or "Disabled"))
	end
	for i = 0, 31
	do
		if not (settings.Commands["Don't Affect Friends"] and features.is_friend(i)) and (i ~= id) and (i ~= PLAYER.PLAYER_ID()) and not features.is_excluded(i) then
			Global.playerlist[i]["Freeze"] = false
		end
	end
	return true
end

cmd.bounty = function(id, pl, amount)
	if not pl then return false, "Enter player id or name" end
	local target = features.player_from_name(pl)
	if not target then return false, (tonumber(pl) and tonumber(pl) < 32 and tonumber(pl) >= 0) and ("There is no player with id "..pl) or ("There is no player with name "..pl) end
	if target == PLAYER.PLAYER_ID() or (settings.Commands["Don't Affect Friends"] and features.is_friend(target)) or features.is_excluded(target) then return false, "You can't use it on this player" end
	system.thread(true, 'cmd_bounty_'..id, function()
		local amount = (amount and tonumber(amount)) or 10000
		features.set_bounty(pl, amount)
		return POP_THREAD
	end)
	return true
end

cmd.bountyall = function(id, amount)
	system.thread(true, 'cmd_bountyall', function()
		local amount = (amount and tonumber(amount)) or 10000
		for i = 0, 31
		do
			if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and not (settings.Commands["Don't Affect Friends"] and features.is_friend(i)) and (i ~= id) and (i ~= PLAYER.PLAYER_ID()) and not features.is_excluded(i) then
				features.set_bounty(i, amount)
			end
		end
		return POP_THREAD
	end)
	return true
end

cmd.apartment = function(id, pl, apart)
	if not pl then return false, "Enter player id or name" end
	local target = features.player_from_name(pl)
	if not target then return false, (tonumber(pl) and tonumber(pl) < 32 and tonumber(pl) >= 0) and ("There is no player with id "..pl) or ("There is no player with name "..pl) end
	if target == PLAYER.PLAYER_ID() or (settings.Commands["Don't Affect Friends"] and features.is_friend(target)) or features.is_excluded(target) then return false, "You can't use it on this player" end
	local apart = (apart and tonumber(apart) and tonumber(apart) > 0 and tonumber(apart) < 115) and floor(tonumber(apart)) or 1
	system.thread(true, 'cmd_explode_'..id, function()
		online.send_script_event(target, -168599209, PLAYER.PLAYER_ID(), target, 1, 0, apart, 1, 1, 1)
		return POP_THREAD
	end)
	return true
end

cmd.killaliens = function(id, bool)
	utils.no_sounds_this_frame()
	local tog
	if bool and bool:tobool() == false then
		tog = false
	elseif bool and bool:tobool() == true then
		tog = true
	else
		tog = not ui.get_value(__options.bool["KillAliens"])
	end
	ui.set_value(__options.bool["KillAliens"], tog, false)
	if settings.Commands["ChatCommandResponse"] then
		online.send_chat(("∑ %s kill aliens"):format(tog and "Enabled" or "Disabled"))
	end
	return true
end

cmd.kickbarcodes = function(id, bool)
	utils.no_sounds_this_frame()
	local tog
	if bool and bool:tobool() == false then
		tog = false
	elseif bool and bool:tobool() == true then
		tog = true
	else
		tog = not ui.get_value(__options.bool["KickBarcodes"])
	end
	ui.set_value(__options.bool["KickBarcodes"], tog, false)
	if settings.Commands["ChatCommandResponse"] then
		online.send_chat(("∑ %s kick barcodes"):format(tog and "Enabled" or "Disabled"))
	end
	return true
end

cmd.gift = function(id)
	local veh = vehicles.get_player_vehicle(id)
	if veh == 0 then return false, "You are not in vehicle" end
	entities.request_control(veh, function()
		local pl_veh
		DECORATOR.DECOR_REGISTER("Player_Vehicle", 3)
		DECORATOR.DECOR_REGISTER("Previous_Owner", 3)
		DECORATOR.DECOR_REGISTER("Vehicle_Reward", 3)
		DECORATOR.DECOR_REGISTER("MPBitset", 3)
		DECORATOR.DECOR_REGISTER("Veh_Modded_By_Player", 3)
		local net_hash = NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(id)
		if ENTITY.IS_ENTITY_VISIBLE(veh) == 1 then
			if DECORATOR.DECOR_EXIST_ON(veh, "Player_Vehicle") == 1 then
				DECORATOR.DECOR_SET_INT(veh, "Player_Vehicle", net_hash)
			else
				pl_veh = DECORATOR.DECOR_GET_INT(veh, "Player_Vehicle")
				DECORATOR.DECOR_SET_INT(veh, "Player_Vehicle", net_hash)
			end
			if pl_veh and pl_veh ~= -1 then
				DECORATOR.DECOR_SET_INT(veh, "Previous_Owner", pl_veh)
			end
		end
		if DECORATOR.DECOR_EXIST_ON(veh, "Vehicle_Reward") == 0 then
			DECORATOR.DECOR_SET_BOOL(veh, "Vehicle_Reward", true)
			DECORATOR.DECOR_SET_INT(veh, "Vehicle_Reward", net_hash)
		end
		local veh_modd = DECORATOR.DECOR_GET_INT(veh, "Veh_Modded_By_Player")
		if veh_modd ~= 0 and veh_modd ~= -1 then
			DECORATOR.DECOR_SET_INT(veh, "Veh_Modded_By_Player", -1)
		end
	end)
	return true
end

cmd.giveweapons = function(id)
	local weapon = {}
	for _, v in ipairs(weapons.hashes)
	do
		insert(weapon, {Hash = v, Tint = 0, Components = {}})
	end
	peds.set_weapons(weapon, features.player_ped(id))
	return true
end

cmd.wanted = function(id, pl, bool)
	if not pl then return false, "Enter player id or name" end
	local target = features.player_from_name(pl)
	if not target then return false, (tonumber(pl) and tonumber(pl) < 32 and tonumber(pl) >= 0) and ("There is no player with id "..pl) or ("There is no player with name "..pl) end
	if target == PLAYER.PLAYER_ID() or (settings.Commands["Don't Affect Friends"] and features.is_friend(target)) or features.is_excluded(target) then return false, "You can't use it on this player" end
	if bool and bool:tobool() == false then
		Global.playerlist[target]["AlwaysWanted"] = false
	elseif bool and bool:tobool() == true then
		Global.playerlist[target]["AlwaysWanted"] = true
	else
		Global.playerlist[target]["AlwaysWanted"] = not Global.playerlist[target]["AlwaysWanted"]
	end
	if settings.Commands["ChatCommandResponse"] then
		online.send_chat(("∑ %s wanted level for %s"):format(Global.playerlist[target]["AlwaysWanted"] and "Enabled" or "Disabled"), online.get_name(target))
	end
	return true
end

local DoCommand = switch()
	:case('spawn', function(id, command)
		return cmd.spawn(id, concat(command, " ", 2))
	end)
	:case('freeze', function(id, command)
		return cmd.freeze(id, command[2], command[3])
	end)
	:case('island', function(id, command)
		return cmd.island(id, command[2])
	end)
	:case('kick', function(id, command)
		return cmd.kick(id, command[2])
	end)
	:case('crash', function(id, command)
		return cmd.crash(id, command[2])
	end)
	:case('explode', function(id, command)
		return cmd.explode(id, command[2])
	end)
	:case('kickall', function(id, command)
		return cmd.kickAll(id)
	end)
	:case('crashall', function(id, command)
		return cmd.crashAll(id)
	end)
	:case('explodeall', function(id, command)
		return cmd.explodeAll(id)
	end)
	:case('clearwanted', function(id, command)
		return cmd.clearwanted(id, command[2])
	end)
	:case('offradar', function(id, command)
		return cmd.offradar(id, command[2])
	end)
	:case('vehiclegod', function(id, command)
		return cmd.vehiclegod(id, command[2])
	end)
	:case('upgrade', function(id, command)
		return cmd.upgrade(id)
	end)
	:case('repair', function(id, command)
		return cmd.repair(id)
	end)
	:case('freezeall', function(id, command)
		return cmd.freezeall(id, command[2])
	end)
	:case('bounty', function(id, command)
		return cmd.bounty(id, command[2], command[3])
	end)
	:case('bountyall', function(id, command)
		return cmd.bountyall(id, command[2])
	end)
	:case('apartment', function(id, command)
		return cmd.apartment(id, command[2], command[3])
	end)
	:case('killaliens', function(id, command)
		return cmd.killaliens(id, command[2])
	end)
	:case('kickbarcodes', function(id, command)
		return cmd.kickbarcodes(id, command[2])
	end)
	:case('gift', function(id, command)
		return cmd.gift(id)
	end)
	:case('giveweapons', function(id, command)
		return cmd.giveweapons(id)
	end)
	:case('wanted', function(id, command)
		return cmd.wanted(id, command[2], command[3])
	end)

local function HandleCommand(command, id)
	system.log('debug', format('command from %i', id))
	return DoCommand(command[1], id, command)
end

-- callbacks

function on_votekick(ply, target)
	system.log('debug', 'votekick recived...')
	if target == PLAYER.PLAYER_ID() then
		if (features.is_friend(ply) and settings.General['Exclude Friends']) or features.is_excluded(ply) then return end
		if settings.Misc.OnVotekickSendChat then
			system.thread(true, 'vote_kick_'..system.thread_count(), function()
				online.send_chat(format("∑ %s tried to votekick a Nightfall user!", online.get_name(ply)))
				return POP_THREAD
			end)
		end
		if settings.Misc.OnVotekickCrash then
			system.thread(true, 'vote_kick_'..system.thread_count(), function()
				features.crash_player(ply)
				return POP_THREAD
			end)
		end
		if settings.Misc.OnVotekickKick then
			system.thread(true, 'vote_kick_'..system.thread_count(), function()
				features.kick_player(ply)
				return POP_THREAD
			end)
		end
	end
end

function on_report(ply, reason)
	system.log('debug', 'report recived...')
	if (features.is_friend(ply) and settings.General['Exclude Friends']) or features.is_excluded(ply) then return end
	if settings.Misc.OnReportSendChat then
		system.thread(true, 'report_'..system.thread_count(), function()
			online.send_chat(format("∑ %s tried to report a Nightfall user!", online.get_name(ply)))
			return POP_THREAD
		end)
	end
	if settings.Misc.OnReportCrash then
		system.thread(true, 'report_'..system.thread_count(), function()
			features.crash_player(ply)
			return POP_THREAD
		end)
	end
	if settings.Misc.OnReportKick then
		system.thread(true, 'report_'..system.thread_count(), function()
			features.kick_player(ply)
			return POP_THREAD
		end)
	end
end


local SimplifiedCommand = switch()
	:case('kill', function()
		return 'explode'
	end)
	:case('killa', function()
		return 'explodeall'
	end)
	:case('nocop', function()
		return 'clearwanted'
	end)
	:case('ghost', function()
		return 'offradar'
	end)
	:case('god', function()
		return 'vehiclegod'
	end)
	:case('vaca', function()
		return 'island'
	end)
	:case('sp', function()
		return 'spawn'
	end)
	:case('rep', 'fix', function()
		return 'repair'
	end)
	:case('upg', function()
		return 'upgrade'
	end)
	:case('bye', function()
		return 'crash'
	end)
	:case('byea', function()
		return 'crashall'
	end)
	:case('nomove', function()
		return 'freeze'
	end)
	:case('leave', function()
		return 'kick'
	end)
	:case('plsleave', function()
		return 'kickall'
	end)
	:case('nomovea', function()
		return 'freezeall'
	end)
	:case('hunt', function()
		return 'bounty'
	end)
	:case('hunta', function()
		return 'bountyall'
	end)
	:case('apa', function()
		return 'apartment'
	end)
	:case('nogay', function()
		return 'killaliens'
	end)
	:case('lz', function()
		return 'kickbarcodes'
	end)
	:case('giveweapons', function()
		return 'weapo'
	end)

local BeggerPunishment = switch()
	:case(1, function(id)
		system.thread(true, 'begger_punishment_'..system.thread_count(), function()
			local pos = features.get_player_coords2(id)
			local veh = vehicles.get_player_vehicle(id)
			if veh ~= 0 then
				entities.request_control(veh, function()
					vehicles.set_godmode(veh, false)
					NETWORK.NETWORK_EXPLODE_VEHICLE(veh, true, false, id)
				end)
			end
			FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, enum.explosion.ROCKET, 10, false, false, 1.0, false)
			return POP_THREAD
		end)
	end)
	:case(2, function(id)
		Global.playerlist[id]["Freeze"] = true
	end)
	:case(3, function(id)
  		system.thread(true, 'begger_punishment_'..system.thread_count(), function()
			features.kick_player(id)
			return POP_THREAD
		end)
	end)
	:case(4, function(id)
		system.thread(true, 'begger_punishment_'..system.thread_count(), function()
			features.crash_player(id)
			return POP_THREAD
		end)
	end)
	:case(5, function(id)
		system.thread(true, 'begger_punishment_'..system.thread_count(), function()
			online.send_script_event(id, -910497748, PLAYER.PLAYER_ID(), 1)
			return POP_THREAD
		end)
	end)

local DetectionFlags = switch()
	:case(0, function()
		return TRANSLATION["Name spoof"]
	end)
	:case(1, function()
		return TRANSLATION["RID spoof"]
	end)
	:case(2, function()
		return TRANSLATION["IP spoof"]
	end)
	:case(3, function()
		return TRANSLATION["Chat spoof"]
	end)
	:case(4, function()
		return TRANSLATION["Force host"]
	end)
	:case(5, function()
		return TRANSLATION["Rockstar anticheat flag"]
	end)
	:case(6, function()
		return TRANSLATION["Crash attempt"]
	end)
	:case(7, function()
		return TRANSLATION["Chat filter bypass"]
	end)
	:case(8, function()
		return TRANSLATION["Super jump"]
	end)
	:case(9, function()
		return TRANSLATION["Godmode"]
	end)
	:case(10, function()
		return TRANSLATION["Illegal model"]
	end)
	:case(11, function()
		return TRANSLATION["Damage modifiers"]
	end)
	:case(12, function()
		return TRANSLATION["Network kick"]
	end)
	:case(13, function()
		return TRANSLATION["Invalid name"]
	end)
	:case(14, function()
		return TRANSLATION["Attacking when godmode"]
	end)
	:case(15, function()
		return TRANSLATION["Too fast movement"]
	end)
	:case(16, function()
		return TRANSLATION["Out of world borders"]
	end)
	:case(17, function()
		return TRANSLATION["Invalid RID"]
	end)
	:case(18, function()
		return TRANSLATION["Kd mismatch"]
	end)
	:case(19, function()
		return TRANSLATION["Rank mismatch"]
	end)
	:case(20, function()
		return TRANSLATION["Invalid script event data"]
	end)
	:case(21, function()
		return TRANSLATION["Illegal vehicle"]
	end)
	:case(22, function()
		return TRANSLATION["Suspicious activity"]
	end)
	:case(23, function()
		return TRANSLATION["Previous modder"]
	end)

function utils.is_event_valid(sender, args)
	if args[3] ~= sender then return false end --[[this arg always equals sender id in R* scripts]]
	return true
end

function on_player_leave(ply)
	for i = 0, 23
	do
		Global.modder_detection[ply][i] = false
	end
	for i = 1, 4
	do
		Global.suspicious[ply][i] = false
	end
	for k in pairs(Global.playerlist[ply])
	do
		Global.playerlist[ply][k] = false
	end
	Global.modder_detection[ply].triggered = false
	Global.veh_spawn[ply] = 0
	Global.veh_spawn_timeout[ply] = nil
end

local function on_modder_detection_handle(ply, action_id)
	if Global.modder_detection[ply][action_id] then return end
	Global.modder_detection[ply][action_id] = true
	if (settings.General["Exclude Friends"] and features.is_friend(ply)) or features.is_excluded(ply) then return end
	Global.modder_detection[ply].triggered = true
	local rid = online.get_rockstar_id(ply)
	if not Global.players_history[rid] then
		Global.players_history[rid] = {modder = true}
	end
	local text = format(TRANSLATION["Player [%s] has triggered detection: %s"], online.get_name(ply), DetectionFlags(action_id))
	if not (settings.General["Exclude Friends"] and features.is_friend(ply)) and not features.is_excluded(ply) and settings.General["ModderDetection"..action_id] == 1 or settings.General["ModderDetection"..action_id] == 3 then 
		system.notify(TRANSLATION["Imagined Menu"], text, settings.General["HudColorModder"], true, true)
	end
	if not (settings.General["Exclude Friends"] and features.is_friend(ply)) and not features.is_excluded(ply) and settings.General["ModderDetection"..action_id] == 2 or settings.General["ModderDetection"..action_id] == 3 then
		online.send_chat('∑ '..text)
	end
end

function on_script_event(ply, event_id, args)
	if __options.bool["DebugSELog"] and ui.get_value(__options.bool["DebugSELog"]) then
		local name = online.get_name(ply):lpad(16)
		local arguments = concat(args, ", ", 3 --[[actual args start at 3]]):gsub(',[, 0]+$', "") -- don't need those "0s" at the end
		local count = arguments:split(',', true)
		local event_id = format("Event ID: (%i)", event_id):lpad(25)
		system.log("SE log", format("Script event from: %s | %s | Args [%i]: {%s}", name, event_id, #count, arguments))
	end
	if Global.modder_detection[ply][20] == false and not utils.is_event_valid(ply, args) then
		on_modder_detection_handle(ply, 20)
	end
end

function utils.is_name_valid(name)
	return #name >= 6 and #name <= 16 and name:lower():gsub("[1234567890qwertyuiopasdfghjklzxcvbnm%.%-_]+", "") == ""
end

function on_player_join(ply)
	local name = online.get_name(ply)
	local rid = online.get_rockstar_id(ply)
	Global.detection_info.is_player_dead[ply] = true
	Global.player_dead_time[ply] = true
	Global.player_otr_time[ply] = true
	if Global.players_history[rid] and Global.players_history[rid].modder then on_modder_detection_handle(ply, 23) end
	if not Global.modder_detection[ply][0] and not utils.is_name_valid(name) then on_modder_detection_handle(ply, 13) end
	if not Global.modder_detection[ply][1] and #tostring(online.get_rockstar_id(ply)) < 5 then on_modder_detection_handle(ply, 17) end
	for k in pairs(Global.playerlist[ply])
	do
		Global.playerlist[ply][k] = false
	end
end

function on_modder_detection(ply, action_id)
	on_modder_detection_handle(ply, action_id)
end

function utils.does_command_exist(command)
	return Global.commands[command] ~= nil
end

function utils.is_command(text)
	return text:startswith("> ")
end

function utils.get_command_results()
	return #Global.command_results > 0
end

local function process_command(command, command_data)
	if command_data.type == "click" then
		if not command[3]:isblank() then return 2, TRANSLATION["Invalid input"] end
		command_data.func()
		system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Command executed successfully"], settings.General["HudColorNotifySuccess"])
		return 1
	elseif command_data.type == "tog" then
		local value = not ui.get_value(command_data.option_id)
		if command[3] ~= nil and command[3]:tobool() == true then
			value = true
		elseif command[3] ~= nil and command[3]:tobool() == false then
			value = false
		elseif not command[3]:isblank() then
			Global.command_results = {}
			local found
			for i, v in ipairs({"1", "0", "true", "false", "on", "off", "yes", "no", "y", "n"})
			do
				if v:find('^'..command[3]:escpattern()) then
					insert(Global.command_results, command[2].." "..v)
					found = true
				end
			end
			if found then return 0 end
			return 2, TRANSLATION["Invalid input"]
		end
		ui.set_value(command_data.option_id, value, false)
		system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["%s is now %s"]:format(ui.get_name(command_data.option_id), value and TRANSLATION["enabled"] or TRANSLATION["disabled"]), settings.General["HudColorNotifySuccess"])
		return 1
	elseif command_data.type == "choose" then
		local value
		Global.command_results = {}
		for i, v in ipairs(command_data.actions)
		do
			if v == command[3] then
				value = i
				break
			end
			if v:find('^'..command[3]:escpattern()) then
				insert(Global.command_results, command[2].." "..v)
			end
		end
		local val = tonumber(command[3])
		if not value and val and val >= 0 and val < #command_data.actions then
			value = val + 1
		end
		if value then
			if command_data.option_id then
				ui.set_value(command_data.option_id, value - 1, false)
			elseif command_data.func then
				command_data.func(value, command[3])
			end
			system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Command executed successfully"], settings.General["HudColorNotifySuccess"])
			return 1
		end
		if not command[3]:isblank() and not utils.get_command_results() then
			return 2, TRANSLATION["There is no value \"%s\""]:format(command[3])
		end
		return 0
	elseif command_data.type == "int" or command_data.type == "float" then
		command[3] = command_data.type == "int" and command[3]:gsub("^int", "") or command[3]:gsub("^float", "")
		if not tonumber(command[3]) then
			if (command[3]):isblank() then
				return 2, command_data.type == "int" and TRANSLATION["Please enter a number value between [%i - %i]"]:format(command_data.min, command_data.max) or TRANSLATION["Please enter a number value between [%f - %f]"]:format(command_data.min, command_data.max)
			end
			return 2, TRANSLATION["\"%s\" is not a number"]:format(command[3])
		end
		local value = command_data.type == "int" and floor(tonumber(command[3])) or tonumber(command[3])
		if value > command_data.max then
			value = command_data.max
		elseif value < command_data.min then
			value = command_data.min
		end
		if command_data.option_id then
			ui.set_value(command_data.option_id, value, false)
		elseif command_data.func then
			command_data.func(value)
		end
		system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Command executed successfully"], settings.General["HudColorNotifySuccess"])
		return 1
	elseif command_data.type == "string" then
		if not command[3] or (command[3]):isblank() then
			return 2, TRANSLATION["Please enter text"]
		end
		command_data.func(command[3])
		system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Command executed successfully"], settings.General["HudColorNotifySuccess"])
		return 1
	end
	return 0
end

local function on_menu_command(text)
	if not utils.is_command(text) then return -1 end
	local command = text:split("%s", true)
	if not command[2] or command[2]:isblank() or not utils.does_command_exist(command[2]) then
		local text = command[2] or ""
		local _text = text:escpattern()
		Global.command_results = {}
		Global.result_com_pos = 1
		local matches = {}
		local finds = {}
		for _, v in ipairs(Global.command_list)
		do
			if not Global.commands[v].hidden then
				if not text:isblank() then
					local match = v:match(("[%s]+"):format(_text))
					local match2 = v:match(("[%s]+$"):format(_text))
					if (#text > 2 and v:find(_text)) or text:find(v:escpattern()) then
						insert(finds, v)
					elseif match and #v - #(match) < 3 or match2 and #(match2) / #v >= .5 then
						insert(matches, v)
					end
				end
				if v:find("^".._text) then
					if Global.commands[v].is_player then
						v = v.." "
					elseif Global.commands[v].type == "choose" then
						v = v.." "
					elseif Global.commands[v].type == "string" then
						v = v.." "
					elseif Global.commands[v].type == "int" then
						v = v.." int"
					elseif Global.commands[v].type == "float" then
						v = v.." float"
					end
					insert(Global.command_results, v)
				end
			end
		end
		matches = utils.connect_tables(finds, matches)
		return 0, command[2] and #matches > 0 and TRANSLATION["I don't know the command \"%s\", but I found some similar:%s"]:format(command[2], "\n"..concat(matches, "\n", 1, #matches < 20 and #matches or 20)) or TRANSLATION["I don't know the command \"%s\""]:format(command[2])
	end
	local command_data = Global.commands[command[2]]
	if command_data.is_player then
		command[3] = command[3] or ""
		Global.command_results = {}
		local name
		for i, v in ipairs(features.get_players_names())
		do
			local start, _end = concat(command, " ", 3):find('^'..v:escpattern())
			if start then
				if not name then
					name = v
				elseif _end > #name then
					name = v
				end
			end
			if v:find('^'..concat(command, " ", 3):escpattern()) then
				if Global.commands[command[2]].type == "choose" then
					v = v.." "
				elseif Global.commands[command[2]].type == "string" then
					v = v.." "
				elseif Global.commands[command[2]].type == "int" then
					v = v.." int"
				elseif Global.commands[command[2]].type == "float" then
					v = v.." float"
				end
				insert(Global.command_results, command[2].." "..v)
			end
		end
		if name then
			command[3] = concat(command, " ", 3):gsub(name:escpattern().."%s?", "", 1)
			command[2] = command[2]..' '..name
			local player = features.player_from_name(name)
			if not player then return 0, TRANSLATION["Player is no longer in session"] end
			Global.selected_player = player
			goto continue
		elseif not utils.get_command_results() and not command[3]:isblank() then
			return 2, TRANSLATION["There is no player with name \"%s\""]:format(command[3])
		end
		return 0
	end

	command[3] = concat(command, " ", 3)
	::continue::

	return process_command(command, command_data)
end

function on_chat_message(id, is_team, text, spoofed_as_ply)
	if settings.Misc["LogChat"] then
		system.log(format("Chat|%s", is_team and 'Team' or 'All'), format("%s wrote: %s", online.get_name(id), text))
	end
	if settings.Session["PunishBeggers"] ~= 0 and spoofed_as_ply == -1 and utils.is_begging(text) then
		if not (settings.General["Exclude Friends"] and features.is_friend(id)) and not features.is_excluded(id) then
	   		BeggerPunishment(settings.Session["PunishBeggers"], id)
		end
	end

	if spoofed_as_ply == -1 and utils.is_chat_command(text) then
		local text = text:lower():gsub(format('^%s', Global.commad_prefix[settings.Commands['CommandsPrefix']]:escpattern()), '')
		local no_perms
		if settings.Commands["Friends Only"] and not features.is_friend(id) and not Global.playerlist[id].Commands then
			no_perms = true
		end
		local command = text:split('%s+', true)
		command[1] = SimplifiedCommand(command[1]) or command[1]
		if not settings.Commands['cmd_'..command[1]] then
			if not no_perms and settings.Commands["ChatCommandResponse"] then
				online.send_chat(("∑ I don't know the command \"%s\""):format(command[1]))
			end
			return true
		end
		if no_perms then
			if settings.Commands["ChatCommandResponse"] then
				online.send_chat("∑ You don't have permission to use this")
			end
			return true
		end
		local success, err = HandleCommand(command, id)
		if success then
			system.notify(TRANSLATION['Chat command'], format(TRANSLATION["Player %s requested command %s"], online.get_name(id), command[1]), settings.General["HudColorNotifyNormal"], false, true)
		elseif success == false and err and settings.Commands["ChatCommandResponse"] then
			online.send_chat("∑ "..err)
		end
		return true
	elseif (settings.Session["ChatMocker"] and not (settings.General["Exclude Friends"] and features.is_friend(id)) and not features.is_excluded(id)) or Global.playerlist[id].ChatMock then
		local message = {}
		for i = 1, #text
		do
			local character = text[i]
			message[i] = i%2 ~= 0 and character:lower() or character:upper()
		end
		message = concat(message, "")
		if settings.Session["ReverseMessages"] then
			message = message:reverse()
		end
		if settings.Session["OwoifyChat"] then
			message = text:gsub("[lr]", 'w'):gsub("[LR]", 'W')
		end
		online.send_chat(message)
	end
end

function utils.get_lang()
	local curr_lang = LOCALIZATION.GET_CURRENT_LANGUAGE()
	if Global.languages[curr_lang] then
		return Global.languages[curr_lang]
	end
	return Global.languages[0]
end

--settings

function system.save_conf(conf)
	do_saving_anim()
	Global.AutosaveTimer = clock()
	system.log('debug', 'saving config...')
	local config = {}
	local default = cache:get('Default config')
	for k, v in pairs(conf or settings) do
		if not config[k] then config[k] = {} end
		for e, i in pairs(v) do
			if i ~= default[k][e] and not features.is_table_empty(i) then
				config[k][e] = i
			end
		end
	end
	filesystem.write(json:encode_pretty(config), files['Config'])
end

function system.load_conf()
	if not filesystem.exists(files['Config']) then return end
	local success, new = xpcall(function() return json:decode(filesystem.read_all(files['Config'])) end, function() system.log('Imagined Menu', 'Failed to load config') end)
	if not success then
		new = settings
	end
	for k, v in pairs(new) do
	  	for i, e in pairs(v) do
	  		if settings[k] and settings[k][i] ~= nil and type(settings[k][i]) == type(e) then
	  			settings[k][i] = e
	  		end
	  	end
	end
	cache:set("LoadedConfig", settings, 1000000)
end
system.log('Imagined Menu', 'Loading config...')
system.load_conf()
if not filesystem.exists(files['Config']) then system.save_conf() end

function system.apply_config(conf)
	utils.no_sounds_this_frame()
	for k, v in pairs(conf) do
		for i, x in pairs(v) do
			if type(x) == 'boolean' and __options.bool[i] then
				ui.set_value(__options.bool[i], x, false)
				-- ui.set_value(__options.bool[i], x, true)
			elseif type(x) == 'number' then
				if __options.num[i] then
					ui.set_value(__options.num[i], x, false)
					-- ui.set_value(__options.num[i], x, true)
				end
				if __options.choose[i] then
					ui.set_value(__options.choose[i], x, false)
					-- ui.set_value(__options.choose[i], x, true)
				end
			elseif type(x) == 'table' and __options.color[i] and x.r and x.g and x.b and x.a then
				ui.set_value(__options.color[i], x.r, x.g, x.b, x.a, false)
				settings[k][i] = x
			elseif i == "BlockInput" and type(x) == 'table' then
				for _, e in pairs(x)
				do
					if __options.bool["INPUT_"..e] then
						ui.set_value(__options.bool["INPUT_"..e], true, true)
					end
				end
			elseif i == 'Translation' and type(x) == 'string' and not x:isempty() then
				for e, v in pairs(Global.translation_files) do
					if v == x then
						ui.set_value(__options.choose[i], e-1, true)
						break
					end
				end
			elseif type(x) == 'string' and __options.string[i] then
				ui.set_value(__options.string[i], x, false)
			end
		end
	end
end

local function SaveTranslation()
	filesystem.write(json:encode_pretty(TRANSLATION), paths['Translations']:ensureend('\\')..settings.General.Translation:ensureend('.json'))
end

local function LoadTranslations()
	if not settings.General.Translation or settings.General.Translation:isblank() then settings.General.Translation = utils.get_lang() end
	if not filesystem.exists(paths['Translations']:ensureend('\\')..settings.General.Translation) then
		system.notify(TRANSLATION["Imagined Menu"], format('No translation found for your language! You can translate the %s file if you want :)', settings.General.Translation), settings.General["HudColorNotifyNormal"])
		system.log('Imagined Menu', format('Translation %s not found!', settings.General.Translation))
		SaveTranslation()
		return
	end

	local success, new = xpcall(function() return json:decode(filesystem.read_all(paths['Translations']:ensureend('\\')..settings.General.Translation)) end, function() system.log("Imagined Menu", "Failed to load translation") end)
    if not success then
    	new = TRANSLATION
    end
    for k, v in pairs(new) do
    	if type(v) == 'table' then
    		TRANSLATION[1].Credits = v.Credits or ""
    		TRANSLATION[1].Language = v.Language or ""
		elseif TRANSLATION[k] then
			TRANSLATION[k] = v
		end
    end

    SaveTranslation()
    if not TRANSLATION[1].Credits:isblank() then
    	system.log('Imagined Menu', TRANSLATION[1].Language..' translation loaded, made by '..TRANSLATION[1].Credits)
    end
end

LoadTranslations()

local function SaveLocations()
	filesystem.write(json:encode_pretty(Global.saved_locations), files['SavedLocations'])
end

local function LoadLocations()
	if not filesystem.exists(files['SavedLocations']) then return end
	local result = json:decode(filesystem.read_all(files['SavedLocations']))
	Global.saved_locations = type(result) == "table" and result or {}
	local i = 1
	while i <= #Global.saved_locations
	do
		local v = Global.saved_locations[i]
		if not v.name or not v.x or not v.y or not v.z then
			table.remove(Global.saved_locations, i)
		else
			i = i + 1
		end
	end
	system.log('Imagined Menu', format(TRANSLATION["Saved locations found %s"], #Global.saved_locations))
end

xpcall(LoadLocations, function() system.log("ERROR", "Failed to load locations file");Global.saved_locations = {} end)

local function get_files()
	Global.script_files = false
	local URL = [[https://raw.githubusercontent.com/ProDash1998/ImaginatedMenuLua/main/files]]
	local download = false
	http.get(URL, function(content, header, response_code)
		download = true
		if response_code ~= 200 then Global.script_files = "" return end
		Global.script_files = content
	end)
	while not download do system.yield(100) end
end

local function download_file(filename)
	Global.download_finished[filename] = false
	local URL = [[https://raw.githubusercontent.com/ProDash1998/ImaginatedMenuLua/main/]]..filename:gsub(" ", "%%20")
	local download = false
	http.get(URL, function(content, header, response_code)
		download = true
		if response_code ~= 200 then Global.download_finished[filename] = "" return end
		Global.download_finished[filename] = content
	end)
	while not download do system.yield(100) end
end

local function download_update()
	if not Global.Version or system.is_thread_active("updater") or system.is_thread_active("downloader") then return end
	local state = 0
	Global.download_finished = {}
	system.thread(true, "updater", function()
		if state == 0 then
			state = 1
			system.log("Updater", "Getting files...")
			get_files()
			return
		elseif state == 1 and Global.script_files then
			if Global.script_files:isblank() then return POP_THREAD end
			system.log("Updater", "Preparing download...")
			Global.script_files_tab = {}
			for _, file in ipairs(Global.script_files:split("\n", true))
			do
				if not file:isblank() then
					insert(Global.script_files_tab, file)
				end
			end
			state = 2
			return
		elseif state == 2 then
			if type(Global.script_files_tab) ~= "table" then return POP_THREAD end
			local set_download = 1
			Global.downloaded = {}
			local filename = Global.script_files_tab[set_download]
			local downloading
			local fails = 0
			system.thread(true, "downloader", function()
				if set_download > #Global.script_files_tab then
					system.log("Updater", "Installing...")
					for _, v in ipairs(Global.downloaded)
					do
						local path = v.name == "Imagined Menu.lua" and (debug.getinfo(1).source):sub(2) or paths["Lua"]..v.name
						filesystem.write_file(path, v.data)
					end
					system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Updated successfully!"], settings.General["HudColorNotifySuccess"])
					return POP_THREAD
				end
				if Global.download_finished[filename] then
					if Global.download_finished[filename]:isblank() then
						downloading = false
						Global.download_finished[filename] = nil
						system.log("Updater", "Failed to download "..filename)
						if fails > 1 then return POP_THREAD end
						fails = fails + 1
						system.log("Updater", "Retrying to download "..filename.."...")
						return system.thread_pause(15000)
					end
					fails = 0
					insert(Global.downloaded, {
						name = filename,
						data = Global.download_finished[filename]
					})
					downloading = false
					set_download = set_download + 1
					filename = Global.script_files_tab[set_download]
					return
				end
				if downloading then return end
				system.log("Updater", "Downloading "..set_download.."/"..#Global.script_files_tab)
				download_file(filename)
				downloading = true
			end)
			return POP_THREAD
		end
	end)
end

local function check_for_updates()
	local URL = [[https://raw.githubusercontent.com/ProDash1998/ImaginatedMenuLua/main/version]]
	http.get(URL, function(content, header, response_code)
		Global.uc_finished = true
		system.thread(true, 'add_download_button', function()
			if response_code ~= 200 or not content or content:isempty() or type(content) ~= 'string' then system.notify(TRANSLATION["Error"], TRANSLATION["Failed to check for updates"], settings.General["HudColorNotifyError"], true) return POP_THREAD end
			local success, char = content:find('\n')
			if not success then return POP_THREAD end
			local content = content:sub(1, char-1)
			if content == VERSION or not (compare_versions(get_version(content), get_version(VERSION))) then
				return POP_THREAD
			end
			Global.Version = content
			system.log('Imagined Menu', format('New version available: %s', content))
			system.notify('Imagined Menu', format(TRANSLATION['New version available: %s'], content), settings.General["HudColorNotifySuccess"], true)
			__options.click["Download"] = ui.add_click_option(TRANSLATION["Changelog"]..' »', __submenus["MainSub"], function()
				if utils.show_info("changelog", [[Opens https://github.com/ProDash1998/ImaginatedMenuLua/releases/tag/]]..content) then return end
				utils.hud_sound("SELECT")
				filesystem.open([[https://github.com/ProDash1998/ImaginatedMenuLua/releases/tag/]]..content)
			end, {"changelog"})

			if settings.General["AutoUpdate"] then download_update() end

			__options.click["Download"] = ui.add_click_option(TRANSLATION["Manual update"], __submenus["MainSub"], function()
				if utils.show_info("download") then return end
				utils.hud_sound("SELECT")
				download_update()
			end, {"download"})

			return POP_THREAD
		end)
	end)
end

if VERSION:find('pre') then
	system.log('Imagined Menu', 'Update check is disabled in pre-release versions')
	Global.uc_finished = true
elseif http.is_enabled() then
	system.log('Imagined Menu', 'Checking for updates...')
	check_for_updates()
	Global.uc_finished = true
else
	local time = clock() + 11
	system.thread(true, system.thread_count(), function()
		if time > clock() then return end
		system.notify('Imagined Menu', TRANSLATION['Enable "Allow http" to check for updates'], settings.General["HudColorNotifyNormal"], true)
		return POP_THREAD
	end)
	Global.uc_finished = true
end

while not Global.uc_finished
do
	system.yield(100)
end

function vehicle_blacklist.add_option_vehicle(hash, model, v_kick, v_max_speed, v_expl, v_del, v_laun, killzone, kick, crash)
	if vehicle_blacklist.options[hash] or not __submenus["BlacklistedVehicles"] then return end
	local name = vehicles.get_label_name(model)
	local sub = ui.add_submenu(name)
	vehicle_blacklist.options[hash] = {
		sub_menu = sub,
		sub_option = ui.add_sub_option(name, __submenus["BlacklistedVehicles"], sub),
		remove = ui.add_click_option(TRANSLATION["Remove"], sub, function() system.thread(true, 'veh_bl_remove', function(tick) if tick < 10 then return end utils.hud_sound("SELECT") vehicle_blacklist.remove(hash);vehicle_blacklist.remove_option_vehicle(hash);vehicle_blacklist.save() return POP_THREAD end) end),
		separator = ui.add_separator(TRANSLATION["Reactions"], sub),
		opt_v_kick = ui.add_bool_option(TRANSLATION["Kick from vehicle"], sub, function(bool) utils.hud_sound("TOGGLE_ON") vehicle_blacklist.vehicles[hash].vehicle_kick = bool;vehicle_blacklist.save() end),
		opt_v_max_speed = ui.add_bool_option(TRANSLATION["Limit max speed"], sub, function(bool) utils.hud_sound("TOGGLE_ON") vehicle_blacklist.vehicles[hash].set_max_speed = bool;vehicle_blacklist.save() end),
		opt_v_expl = ui.add_bool_option(TRANSLATION["Explode vehicle"], sub, function(bool) utils.hud_sound("TOGGLE_ON") vehicle_blacklist.vehicles[hash].vehicle_explode = bool;vehicle_blacklist.save() end),
		opt_v_del = ui.add_bool_option(TRANSLATION["Delete vehicle"], sub, function(bool) utils.hud_sound("TOGGLE_ON") vehicle_blacklist.vehicles[hash].vehicle_delete = bool;vehicle_blacklist.save() end),
		opt_v_laun = ui.add_bool_option(TRANSLATION["Launch vehicle"], sub, function(bool) utils.hud_sound("TOGGLE_ON") vehicle_blacklist.vehicles[hash].vehicle_launch = bool;vehicle_blacklist.save() end),
		opt_tp_killzone = ui.add_bool_option(TRANSLATION["Teleport to kill zone"], sub, function(bool) utils.hud_sound("TOGGLE_ON") vehicle_blacklist.vehicles[hash].tp_killzone = bool;vehicle_blacklist.save() end),
		opt_kick = ui.add_bool_option(TRANSLATION["Kick player"], sub, function(bool) utils.hud_sound("TOGGLE_ON") vehicle_blacklist.vehicles[hash].kick = bool;vehicle_blacklist.save() end),
		opt_crash = ui.add_bool_option(TRANSLATION["Crash player"], sub, function(bool) utils.hud_sound("TOGGLE_ON") vehicle_blacklist.vehicles[hash].crash = bool;vehicle_blacklist.save() end),
	}
	local tabl = vehicle_blacklist.options[hash]
	ui.set_value(tabl.opt_v_kick, v_kick, true)
	ui.set_value(tabl.opt_v_max_speed, v_max_speed, true)
	ui.set_value(tabl.opt_v_expl, v_expl, true)
	ui.set_value(tabl.opt_v_del, v_del, true)
	ui.set_value(tabl.opt_v_laun, v_laun, true)
	ui.set_value(tabl.opt_tp_killzone, killzone, true)
	ui.set_value(tabl.opt_kick, kick, true)
	ui.set_value(tabl.opt_crash, crash, true)
end

function vehicle_blacklist.remove_option_vehicle(hash)
	system.log('debug', 'removing vehicle blacklist '..hash)
	if not vehicle_blacklist.options[hash] or not __submenus["BlacklistedVehicles"] then return end
	local tabl = vehicle_blacklist.options[hash]
	for k, v in pairs(tabl)
	do
		ui.remove(v)
	end
	vehicle_blacklist.options[hash] = nil
end

function vehicle_blacklist.save()
	system.log('debug', 'saving vehicle blacklist...')
	filesystem.write(json:encode_pretty(vehicle_blacklist.vehicles), files['VehicleBlacklist'])
end 

function vehicle_blacklist.load()
	if not filesystem.exists(files['VehicleBlacklist']) then return end
	system.log('Imagined Menu', 'Loading vehicle blacklist...')
	local success, tabl = xpcall(function() return json:decode(filesystem.read_all(files['VehicleBlacklist'])) end, function() system.log("ERROR", "Failed to load vehicle blacklist") end)
	if not success then return end
	vehicle_blacklist.vehicles = tabl
	for k, v in pairs(vehicle_blacklist.vehicles)
	do
		if not tonumber(k) then error('Failed to load vehicle from blacklist invalid hash', 1) end
		if not v.model then error('Failed to load vehicle from blacklist invalid model', 1) end
		if v.vehicle_kick == nil then v.vehicle_kick = false end
		if v.set_max_speed == nil then v.set_max_speed = false end
		if v.vehicle_explode == nil then v.vehicle_explode = false end
		if v.vehicle_delete == nil then v.vehicle_delete = false end
		if v.vehicle_launch == nil then v.vehicle_launch = false end
		if v.tp_killzone == nil then v.tp_killzone = false end
		if v.kick == nil then v.kick = false end
		if v.crash == nil then v.crash = false end
		vehicle_blacklist.add_option_vehicle(k, v.model, v.vehicle_kick, v.set_max_speed, v.vehicle_explode, v.vehicle_delete, v.vehicle_launch, v.tp_killzone, v.kick, v.crash)
	end
end

function vehicle_blacklist.add(int)
	system.thread(true, 'adding_blacklist_'..system.thread_count(), function()
		local hash = tostring(vehicles.models[int][2])
		if vehicle_blacklist.vehicles[hash] then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION['Vehicle already blacklisted'], settings.General["HudColorNotifyError"], true) return POP_THREAD end
		vehicle_blacklist.vehicles[hash] = {
			model = vehicles.models[int][1],
			vehicle_kick = settings.Session["VehBlVehicleKick"],
			set_max_speed = settings.Session["VehBlSetMaxSpeed"],
			vehicle_explode = settings.Session["VehBlVehicleExplode"],
			vehicle_delete = settings.Session["VehBlVehicleDelete"],
			vehicle_launch = settings.Session["VehBlVehicleLaunch"],
			tp_killzone = settings.Session["VehBlKillZone"],
			kick = settings.Session["VehBlKick"],
			crash = settings.Session["VehBlCrash"],
		}
		vehicle_blacklist.save()
		system.notify(TRANSLATION["Imagined Menu"], TRANSLATION['Vehicle added to blacklist'], settings.General["HudColorNotifySuccess"], true)
		vehicle_blacklist.add_option_vehicle(hash, vehicles.models[int][1],
			settings.Session["VehBlVehicleKick"],
			settings.Session["VehBlSetMaxSpeed"],
			settings.Session["VehBlVehicleExplode"],
			settings.Session["VehBlVehicleDelete"],
			settings.Session["VehBlVehicleLaunch"],
			settings.Session["VehBlKillZone"],
			settings.Session["VehBlKick"],
			settings.Session["VehBlCrash"])
		return POP_THREAD
	end)
end

function vehicle_blacklist.remove(hash)
	vehicle_blacklist.vehicles[hash] = nil
	vehicle_blacklist.save()
	system.notify(TRANSLATION["Imagined Menu"], TRANSLATION['Vehicle removed from blacklist'], settings.General["HudColorNotifySuccess"], true)
end

local function SaveExcludes()
	system.log('debug', 'saving player excludes...')
	filesystem.write(json:encode_pretty(features.player_excludes), files['PlayerExcludes'])
end

local function LoadExcludes()
	if not filesystem.exists(files['PlayerExcludes']) then return end
	system.log('Imagined Menu', 'Loading excluded players...')
	local success, tabl = xpcall(function() return json:decode(filesystem.read_all(files['PlayerExcludes'])) end, function() system.log("ERROR", "Failed to load excluded players") end)
	if not success then return end
	features.player_excludes = tabl
end
LoadExcludes()

local Cages = {
	[0] = json:decode(filesystem.read_all(files['TrapStTube'])),
	json:decode(filesystem.read_all(files['TrapStTubeInv'])),
	json:decode(filesystem.read_all(files['TrapCage']))
}

---------------------------------------------------------------------------------------------------------------------------------
-- Main Sub
---------------------------------------------------------------------------------------------------------------------------------

system.log('Imagined Menu', "Initializing options...")

__submenus["MainSub"] = ui.add_main_submenu(TRANSLATION["Imagined Menu"])
Global.subs[__submenus["MainSub"]] = true

do
	local unload
	local was_open
	local open_time = clock()
	ui.add_click_option(TRANSLATION["Stop script"], __submenus["MainSub"], function()
		if utils.show_info("stopscript, unload", "Stops the script") then return end
		if open_time > clock() then utils.hud_sound("ERROR") return end
		utils.hud_sound("SELECT")
		if not unload and ui.is_sub_open(__submenus["MainSub"]) then
			system.notify(TRANSLATION["Warning"], TRANSLATION["Are you sure you want to quit?"], settings.General["HudColorNotifyWarning"], true)
			unload = true
			return
		end
		system.thread(true, 'stop_script', function(tick)
			if tick < 10 then return end
			system.log('Imagined Menu', 'Unloading Imagined Menu...')
			if settings.General["AutoSave"] then system.save_conf() end
			utils.no_sounds_this_frame()
			for _, v in pairs(__options.bool)
			do
				if ui.get_value(v) then
					ui.set_value(v, false, false)
				end
			end
			if ui.get_value(__options.num["SwimSpeed"]) ~= 1 then
				ui.set_value(__options.num["SwimSpeed"], 1, false)
			end
			if ui.get_value(__options.num["RunSpeed"]) ~= 1 then
				ui.set_value(__options.num["RunSpeed"], 1, false)
			end
			for _, v in pairs(Global.vehicle_blips)
			do
				features.remove_blip(v[2])
			end
			Global.gRunning = false
			system.notify(TRANSLATION["Imagined Menu"], TRANSLATION['See you soon!']..' :)', settings.General["HudColorNotifyNormal"])
			return POP_THREAD
		end)
	end, {"stopscript", "unload"})

	system.thread(true, 'is_main_sub_open', function()
		if not was_open and ui.is_sub_open(__submenus["MainSub"]) then
			was_open = true
			open_time = clock() + .5
		elseif was_open and not ui.is_sub_open(__submenus["MainSub"]) then
			was_open = false
		end
		if unload and not ui.is_sub_open(__submenus["MainSub"]) then
			unload = false
		end
	end)
end

---------------------------------------------------------------------------------------------------------------------------------
-- Players
---------------------------------------------------------------------------------------------------------------------------------

__submenus["PlayerList"] = ui.add_player_submenu(TRANSLATION["Imagined Menu"])
Global.subs[__submenus["PlayerList"]] = true

__submenus["Info"] = ui.add_submenu(TRANSLATION["Info"])
__suboptions["Info"] = ui.add_sub_option(TRANSLATION["Info"], __submenus["PlayerList"], __submenus["Info"])

__submenus["PlayerlistVehicle"] = ui.add_submenu(TRANSLATION["Vehicle"])
__suboptions["PlayerlistVehicle"] = ui.add_sub_option(TRANSLATION["Vehicle"], __submenus["PlayerList"], __submenus["PlayerlistVehicle"])

__submenus["SpawnVehicle"] = ui.add_submenu(TRANSLATION["Spawn vehicle"])
__suboptions["SpawnVehicle"] = ui.add_sub_option(TRANSLATION["Spawn vehicle"], __submenus["PlayerlistVehicle"], __submenus["SpawnVehicle"])

__submenus["PlayerlistTeleport"] = ui.add_submenu(TRANSLATION["Teleport"])
__suboptions["PlayerlistTeleport"] = ui.add_sub_option(TRANSLATION["Teleport"], __submenus["PlayerList"], __submenus["PlayerlistTeleport"])

__submenus["PlayerlistOther"] = ui.add_submenu(TRANSLATION["Other"])
__suboptions["PlayerlistOther"] = ui.add_sub_option(TRANSLATION["Other"], __submenus["PlayerList"], __submenus["PlayerlistOther"])

ui.add_separator(TRANSLATION["Trolling"], __submenus["PlayerList"])

do
	__submenus["Blame"] = ui.add_submenu(TRANSLATION["Blame"])
	__suboptions["Blame"] = ui.add_sub_option(TRANSLATION["Blame"], __submenus["PlayerList"], __submenus["Blame"])

	ui.add_click_option(TRANSLATION["All"], __submenus["Blame"], function()
		if utils.show_info(("blame %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
		if Global.blame_delay > clock() then return end
		local target = online.get_selected_player()
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(target) == 0 then return utils.hud_sound("ERROR") end
		local ped = features.player_ped(target)
		local found
		features.patch_blame(true)
		for i = 0, 31 do
			if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and i ~= PLAYER.PLAYER_ID() and not (settings.General["Exclude Friends"] and features.is_friend(i)) and not features.is_excluded(i) then
				local pos = features.get_player_coords2(i)
				FIRE.ADD_OWNED_EXPLOSION(ped, pos.x, pos.y, pos.z, enum.explosion.GRENADE, 1, true, false, 1.0)
				found = true
			end
		end
		features.patch_blame(false)
		if not found then return utils.hud_sound("ERROR") end
		utils.hud_sound("SELECT")
		Global.blame_delay = clock() + .2
	end, {"blame"}, true)
	ui.add_separator(TRANSLATION["Player"], __submenus["Blame"])

	local blame_players = {}
	system.thread(true, 'blame_players', function()
		for i = 0, 31
		do
			if not blame_players[i] and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and NETWORK.NETWORK_IS_SESSION_STARTED() == 1 then
				local tag = ""
				if i == PLAYER.PLAYER_ID() then
					tag = format('(%s)', TRANSLATION["Self"])
				elseif features.is_friend(i) then
					tag = format('(%s)', TRANSLATION["Friend"])
				end
				local name = online.get_name(i)..' '..tag
				blame_players[i] = ui.add_click_option(name, __submenus["Blame"], function()
					if utils.show_info(("blameas %s %s"):format(online.get_name(online.get_selected_player()):lower(), online.get_name(i):lower())) then return end
					if Global.blame_delay > clock() then utils.hud_sound("ERROR") return end
					utils.hud_sound("SELECT")
					local ped = features.player_ped(online.get_selected_player())
					local pos = features.get_player_coords2(i)
					features.patch_blame(true)
					FIRE.ADD_OWNED_EXPLOSION(ped, pos.x, pos.y, pos.z, enum.explosion.GRENADE, 1, true, false, 1.0)
					features.patch_blame(false)
					Global.blame_delay = clock() + .2
				end)
			elseif blame_players[i] and (NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 0 or NETWORK.NETWORK_IS_SESSION_STARTED() == 0) then
				ui.remove(blame_players[i])
				blame_players[i] = nil
			end
		end
	end)

	system.register_command({"blameas"}, {type="choose", actions=Global.players_by_name, is_player=true, func=function(i, str)
		local player = features.player_from_name(str)
		local pid = online.get_selected_player()
		if Global.blame_delay > clock() or NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or NETWORK.NETWORK_IS_PLAYER_CONNECTED(player) == 0 then utils.hud_sound("ERROR") return end
		utils.hud_sound("SELECT")
		local ped = features.player_ped(pid)
		local pos = features.get_player_coords2(player)
		features.patch_blame(true)
		FIRE.ADD_OWNED_EXPLOSION(ped, pos.x, pos.y, pos.z, enum.explosion.GRENADE, 1, true, false, 1.0)
		features.patch_blame(false)
		Global.blame_delay = clock() + .2
	end})

end

do
	local coords
	local veh
	local current
	local hash2
	local amount = 1
	local pid
	local pos
	local enemy_vehicles = {}

	local function spawn_0()
		coords = pos:point_on_circle(rad((360/amount) * current), 10)
		local success, Z = features.get_ground_z(coords)
		veh = vehicles.spawn_vehicle(hash2, vector3(coords.x, coords.y, success and Z or coords.z))
		insert(enemy_vehicles[pid], veh)
		features.set_entity_face_entity(veh, features.player_ped(pid))
		VEHICLE.SET_VEHICLE_MOD_KIT(veh, 0)
		VEHICLE.SET_VEHICLE_MOD(veh, 10, 2, false)
		local blip = HUD.ADD_BLIP_FOR_ENTITY(veh)
		HUD.SET_BLIP_SPRITE(blip, enum.blip_sprite.gr_wvm_1)
	end

	local function spawn_1()
		coords = pos:point_on_circle(rad((360/amount) * current), 10)
		local success, Z = features.get_ground_z(coords)
		veh = vehicles.spawn_vehicle(hash2, vector3(coords.x, coords.y, success and Z or coords.z))
		insert(enemy_vehicles[pid], veh)
		features.set_entity_face_entity(veh, features.player_ped(pid))
		local blip = HUD.ADD_BLIP_FOR_ENTITY(veh)
		HUD.SET_BLIP_SPRITE(blip, enum.blip_sprite.arena_rc_car)
	end

	local function spawn_2()
		coords = pos:point_on_circle(rad((360/amount) * current), 20)
		local success, Z = features.get_ground_z(coords)
		veh = vehicles.spawn_vehicle(hash2, vector3(coords.x, coords.y, success and Z or coords.z))
		insert(enemy_vehicles[pid], veh)
		features.set_entity_face_entity(veh, features.player_ped(pid))
		local blip = HUD.ADD_BLIP_FOR_ENTITY(veh)
		HUD.SET_BLIP_SPRITE(blip, enum.blip_sprite.tank)
	end

	local function spawn_3()
		coords = pos:point_on_circle(rad((360/amount) * current), 200)
		veh = vehicles.spawn_vehicle(hash2, vector3(coords.x, coords.y, coords.z + 500))
		insert(enemy_vehicles[pid], veh)
		features.set_entity_face_entity(veh, features.player_ped(pid), true)
		VEHICLE.CONTROL_LANDING_GEAR(veh, 3)
	  	VEHICLE.SET_HELI_BLADES_FULL_SPEED(veh)
	  	VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, 200)
  		local blip = HUD.ADD_BLIP_FOR_ENTITY(veh)
		HUD.SET_BLIP_SPRITE(blip, enum.blip_sprite.player_jet)
	end

	local function spawn_4()
		coords = pos:point_on_circle(rad((360/amount) * current), 50)
		veh = vehicles.spawn_vehicle(hash2, vector3(coords.x, coords.y, coords.z + 30))
		insert(enemy_vehicles[pid], veh)
		features.set_entity_face_entity(veh, features.player_ped(pid))
  		VEHICLE.SET_HELI_BLADES_FULL_SPEED(veh)
  		local blip = HUD.ADD_BLIP_FOR_ENTITY(veh)
		HUD.SET_BLIP_SPRITE(blip, enum.blip_sprite.player_heli)
	end

	local CreateVeh = switch()
		:case(0, spawn_0)
		:case(1, spawn_1)
		:case(2, spawn_2)
		:case(3, spawn_3)
    	:case(4, spawn_4)

	for i = 0, 31
	do
		enemy_vehicles[i] = {}
	end

	local models = {
		[0] = {utils.joaat("ig_dom"), utils.joaat("minitank")},
		{utils.joaat("ig_dom"), utils.joaat("rcbandito")},
		{utils.joaat("ig_dom"), utils.joaat("rhino")},
		{utils.joaat("ig_dom"), utils.joaat("lazer")},
		{utils.joaat("ig_dom"), utils.joaat("buzzard")},
	}

	local types = {HUD._GET_LABEL_TEXT("MINITANK"), HUD._GET_LABEL_TEXT("RCBANDITO"), HUD._GET_LABEL_TEXT("RHINO"), HUD._GET_LABEL_TEXT("LAZER"), HUD._GET_LABEL_TEXT("BUZZARD")}
	__submenus["SendEnemyVehicle"] = ui.add_submenu(TRANSLATION["Send enemy vehicle"])
	__suboptions["SendEnemyVehicle"] = ui.add_sub_option(TRANSLATION["Send enemy vehicle"], __submenus["PlayerList"], __submenus["SendEnemyVehicle"])
	local _amount
	_amount = ui.add_num_option(TRANSLATION["Amount"], __submenus["SendEnemyVehicle"], 1, 15, 1, function(int)
		if utils.show_info("amountofenemies [1 - 15]") then ui.set_value(_amount, amount, true) return end
		utils.hud_sound("YES") amount = int
	end, {"amountofenemies"})
	__options.players["InvincibleEnemyVeh"] = ui.add_bool_option(TRANSLATION['Invincible'], __submenus["SendEnemyVehicle"], function(bool)
		if utils.show_info(("godenemies %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
		utils.hud_sound("TOGGLE_ON")
		local player = online.get_selected_player()
		Global.playerlist[player]["InvincibleEnemyVeh"] = bool
		for _, v in ipairs(enemy_vehicles[player])
		do
			entities.request_control(v, function()
				if ENTITY.IS_ENTITY_A_VEHICLE(v) == 1 then
					vehicles.set_godmode(v,	bool)
				else
					features.set_godmode(v, bool)
				end
			end)
		end
	end, {"godenemies"}, true)
	ui.set_value(_amount, amount, true)
	ui.add_choose(TRANSLATION["Send enemies"], __submenus["SendEnemyVehicle"], false, types, function(int)
		if utils.show_info(("sendenemies %s [choose]"):format(online.get_name(online.get_selected_player()):lower())) then ui.set_value(_amount, amount, true) return end

		pid = online.get_selected_player()
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return utils.hud_sound("ERROR") end
		utils.hud_sound("YES")
		system.thread(true, 'send_enemies_'..system.thread_count(), function()
			local loaded, hash1 = features.request_model(models[int][1])
			if loaded == 0 then return end
			loaded, hash2 = features.request_model(models[int][2])
			if loaded == 0 then return end
			pos = features.get_player_coords2(pid)
			for i = 1, amount
			do
				current = i
				CreateVeh(int)
				VEHICLE.SET_VEHICLE_ENGINE_ON(veh, true, true, false)
				local ped = peds.create_ped(hash1, coords)
				PED.SET_PED_INTO_VEHICLE(ped, veh, -1)
				if ui.get_value(__options.players["InvincibleEnemyVeh"]) then
					vehicles.set_godmode(veh, true)
					peds.set_ped_god(ped)
				end
				insert(enemy_vehicles[pid], ped)
				peds.calm_ped(ped, true)
				for _, v in ipairs({1,2,5,46,52}) do
					PED.SET_PED_COMBAT_ATTRIBUTES(ped, v, true)
				end
				PED.SET_PED_ACCURACY(ped, 100)
				PED.SET_PED_COMBAT_RANGE(ped, 2)
				PED.SET_PED_COMBAT_ABILITY(ped, 2)
				PED.SET_PED_COMBAT_MOVEMENT(ped, 2)
				PED.SET_PED_KEEP_TASK(ped, true)
				if int == 3 then
					TASK.TASK_PLANE_MISSION(ped, veh, 0, features.player_ped(pid), 0, 0, 0, 6, 100, 0, 0, 80, 50, nil)
				elseif int == 4 then
					TASK.TASK_HELI_MISSION(ped, veh, 0, features.player_ped(pid), 0, 0, 0, 23, 40, 40, -1, 0, 10, -1, 0)
				end
				system.thread(true, 'emeny_'..system.thread_count(), function()
					if ENTITY.DOES_ENTITY_EXIST(ped) == 0 or NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then 
						features.delete_entity(veh)
						features.delete_entity(ped)
						return POP_THREAD
					elseif int ~= 3 and PED.IS_PED_IN_COMBAT(ped, features.player_ped(pid)) == 0 and PED.IS_PED_INJURED(features.player_ped(pid)) == 0 then
						entities.request_control(ped, function()
							TASK.CLEAR_PED_TASKS(ped)
							TASK.TASK_COMBAT_PED(ped, features.player_ped(pid), 0, 16)
							PED.SET_PED_KEEP_TASK(ped, true)
						end)
					end
				end)
			end
			features.unload_models(models[int])
			return POP_THREAD
		end)
	end, {"sendenemies"}, true)
	ui.add_click_option(TRANSLATION['Delete enemies'], __submenus["SendEnemyVehicle"], function()
		if utils.show_info(("delenemies %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
		utils.hud_sound("SELECT")
		for _, v in ipairs(enemy_vehicles[online.get_selected_player()])
		do
			features.delete_entity(v)
		end
		enemy_vehicles[online.get_selected_player()] = {}
	end, {"delenemies"}, true)
end

do
	__submenus["CustomExplosion"] = ui.add_submenu(TRANSLATION["Custom explosion"])
	__suboptions["CustomExplosion"] = ui.add_sub_option(TRANSLATION["Custom explosion"], __submenus["PlayerList"], __submenus["CustomExplosion"])
	local explosion_types = {}
	for i = 0, 82
	do
		for k, v in pairs(enum.explosion)
		do
			if v == i then
				insert(explosion_types, k)
				break
			end
		end
	end
	local blamed = false
	local invisible = false
	local silent = false
	__options.bool["ExplodeBlamed"] = ui.add_bool_option(TRANSLATION["Kill as self"], __submenus["CustomExplosion"], function(bool)
		if utils.show_info("explodeasself [on - off]") then ui.set_value(__options.bool["ExplodeBlamed"], blamed, true) return end
		utils.hud_sound("TOGGLE_ON") blamed = bool
	end, {"explodeasself"})
	__options.bool["ExplodeInvisible"] = ui.add_bool_option(TRANSLATION["Invisible"], __submenus["CustomExplosion"], function(bool)
		if utils.show_info("explodeinvisible [on - off]") then ui.set_value(__options.bool["ExplodeInvisible"], invisible, true) return end
		utils.hud_sound("TOGGLE_ON") invisible = bool
	end, {"explodeinvisible"})
	__options.bool["ExplodeSilet"] = ui.add_bool_option(TRANSLATION["Silent"], __submenus["CustomExplosion"], function(bool)
		if utils.show_info("explodesilent [on - off]") then ui.set_value(__options.bool["ExplodeSilet"], silent, true) return end
		utils.hud_sound("TOGGLE_ON") silent = bool 
	end, {"explodesilent"})
	__options.choose["Explode"] = ui.add_choose(TRANSLATION["Explode"], __submenus["CustomExplosion"], false, explosion_types, function(int)
		if utils.show_info(("explode %s [choose]"):format(online.get_name(online.get_selected_player()):lower())) then ui.set_value(__options.bool["ExplodeSilet"], silent, true) return end
		local pid = online.get_selected_player()
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return utils.hud_sound("ERROR") end
		utils.hud_sound("YES")
		local pos = features.get_player_coords2(pid)
		if blamed then
			FIRE.ADD_OWNED_EXPLOSION(features.player_ped(), pos.x, pos.y, pos.z, int, 1, not silent, invisible, 1)
		else
			FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, int, 1, not silent, invisible, 1, false)
		end
	end, {"exclude"}, true)
end

ui.add_click_option(TRANSLATION["Set bounty"], __submenus["PlayerList"], function()
	if utils.show_info(("setbounty %s [0 - 10000]"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return utils.hud_sound("ERROR") end
	local player_name = online.get_name(pid):lower()
	system.open_command_box("> setbounty "..player_name.." 10000", true)
end)

system.register_command({"setbounty"}, {type = "int", min = 0, max = 10000, is_player = true, func = function(amount)
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return utils.hud_sound("ERROR") end
	features.set_bounty(pid, amount)
	utils.hud_sound("SELECT")
end})

ui.add_click_option(TRANSLATION["Oblitarate"], __submenus["PlayerList"], function()
	if utils.show_info(("oblitarate %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local target = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(target) == 0 or not features.can_shoot_player(target) then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	system.thread(true, 'orbital_strike', function(tick)
		utils.set_bit(2657589 + 1 + (PLAYER.PLAYER_ID() * 466) + 427, 0)
		if tick == 2 then
			local pos = features.get_player_coords2(target)
			features.orbital_strike_at_coord(pos, vector3())
		end
		if tick < 100 then return end
		utils.clear_bit(2657589 + 1 + (PLAYER.PLAYER_ID() * 466) + 427, 0)
		return POP_THREAD
	end)
end, {"oblitarate"}, true)

ui.add_click_option(TRANSLATION["Airstrike player"], __submenus["PlayerList"], function()
	if utils.show_info(("airstrike %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local target = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(target) == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	local pos = features.get_player_coords2(target)
	MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 100, pos.x, pos.y, pos.z, 5, true, utils.joaat("weapon_rpg"), features.player_ped(), true, true, 50000)
end, {"airstrike"}, true)

ui.add_click_option(TRANSLATION["Send mugger"], __submenus["PlayerList"], function()
	if utils.show_info(("mugger %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local target = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(target) == 0 or NETWORK.NETWORK_IS_SESSION_STARTED() == 0 or features.is_player_in_interior2(target) or ENTITY.IS_ENTITY_DEAD(features.player_ped(target), false) == 1 or globals.is_script_active("am_gang_call") then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	globals.set_int(1853910 + 1 + (PLAYER.PLAYER_ID() * 862) + 141, target)
	utils.set_bit(1853910 + 1 + (PLAYER.PLAYER_ID() * 862) + 140, 0)
end, {"mugger"}, true)

ui.add_click_option(TRANSLATION["Kidnap player"], __submenus["PlayerList"], function()
	if utils.show_info(("kidnap %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	system.thread(true, 'crush_player_'..system.thread_count(), function()
		local loaded, hash = features.request_model("ig_lestercrest_2")
		if loaded == 0 then return end
		local loaded, hash2 = features.request_model("stockade")
		if loaded == 0 then return end
		TASK.CLEAR_PED_TASKS_IMMEDIATELY(features.player_ped(pid))
		local pos = features.get_offset_from_player_coords(vector3(0, 2, -1), pid)
		local veh = vehicles.spawn_vehicle(hash2, pos, features.get_player_heading(pid))
		vehicles.set_godmode(veh, true)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, pos.x, pos.y, pos.z, false, false, false)
		ENTITY.SET_ENTITY_HEADING(veh, features.get_player_heading(pid))
		local ped = peds.create_ped(hash, pos, true)
		peds.calm_ped(ped)
		PED.SET_PED_INTO_VEHICLE(ped, veh, -1)
		TASK.TASK_VEHICLE_DRIVE_WANDER(ped, veh, 200, 786603)
		VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh, 6)
		VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh, 2)
		features.unload_models(hash, hash2)
		return POP_THREAD
	end)
end, {"kidnap"}, true)

ui.add_click_option(TRANSLATION["Crush player"], __submenus["PlayerList"], function()
	if utils.show_info(("crush %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	system.thread(true, 'crush_player_'..system.thread_count(), function()
		TASK.CLEAR_PED_TASKS_IMMEDIATELY(features.player_ped(pid))
		local loaded, hash = features.request_model("rhino")
		if loaded == 0 then return end
		local pos = features.get_offset_from_player_coords(vector3.up(15), pid)
		local veh = vehicles.spawn_vehicle(hash, pos, features.get_player_heading(pid))
		STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
		entities.request_control(veh, function()
			features.apply_force_to_entity(veh, 1, 0, 0, -20, 0, 0, 0, 0, true, false, true, false, true)
		end)
		local time = clock() + 3
		system.thread(true, 'delete_entity_'..system.thread_count(), function()
			if time > clock() then return end
			features.delete_entity(veh)
			return POP_THREAD
		end)
		return POP_THREAD
	end)
end, {"crush"}, true)

do
	local wait = 0
	ui.add_click_option(TRANSLATION["Send IP in chat"], __submenus["PlayerList"], function()
		if utils.show_info(("sendip %s"):format(online.get_name(online.get_selected_player()):lower())) or wait > clock() then return end
		local pid = online.get_selected_player()
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or pid == PLAYER.PLAYER_ID() then return utils.hud_sound("ERROR") end
		utils.hud_sound("SELECT")
		wait = clock() + .2
		online.send_chat(format("%s's IP adress is: %s", online.get_name(pid), online.get_ip(pid)))
	end, {"sendip"}, true)
end

ui.add_choose(TRANSLATION["Trap"], __submenus["PlayerList"], false, {TRANSLATION["Stunt tube"], TRANSLATION["Invisible tube"], TRANSLATION["Cage"]}, function(int)
	if utils.show_info(("trap %s [choose]"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("YES")
	local type = Cages[int]
	system.thread(true, 'trap_'..system.thread_count(), function()
		local ped = features.player_ped(pid)
		TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
		local result = world_spawner.request(type)
        if result == -1 then return 0 end -- invalid model
        if result == 0 then return end -- not loaded
        local pos = features.get_player_coords2(pid)
        local heading = features.get_entity_rot(ped).z
        type[1].position.x = pos.x
        type[1].position.y = pos.y
        type[1].position.z = pos.z
        type[1].position.yaw = heading
        world_spawner.spawn_map(type, true)
        return POP_THREAD
	end)
end, {"trap"}, true)

ui.add_choose(TRANSLATION["Infinite invite"], __submenus["PlayerList"], false, {TRANSLATION['v1'], TRANSLATION['v2']}, function(int)
	if utils.show_info(("infiniteinvite %s [choose]"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or pid == PLAYER.PLAYER_ID() then return utils.hud_sound("ERROR") end
	utils.hud_sound("YES")
	online.send_script_event(pid, -168599209, PLAYER.PLAYER_ID(), pid, 4294967295, 1, 115, int, int, int)
end, {"infiniteinvite"}, true)

local GetType = switch()
	:case(0, function()
		return 205991906
	end)
	:case(1, function()
		return 911657153
	end)
	:default(function()
		return -1355376991
	end)

do
	local types = {HUD._GET_LABEL_TEXT("WT_SNIP_HVY2"), HUD._GET_LABEL_TEXT("WT_STUN"), HUD._GET_LABEL_TEXT("WT_RAYPISTOL")}
	__options.choose["ShootWithBullet"] = ui.add_choose(TRANSLATION["Shoot with bullet"], __submenus["PlayerList"], false, types, function(int)
		if utils.show_info(("shootbullet %s [choose]"):format(online.get_name(online.get_selected_player()):lower())) then return end
		local pid = online.get_selected_player()
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return utils.hud_sound("ERROR") end
		utils.hud_sound("YES")
		local hash = GetType(int)
		local pos = features.get_player_coords2(pid)
		local pos2 = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(features.player_ped(pid), 0xe0fd)
		if WEAPON.HAS_WEAPON_ASSET_LOADED(hash) == 0 then
			WEAPON.REQUEST_WEAPON_ASSET(hash, 31, 0)
		end
		MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 2, pos.x, pos.y, pos.z - 2, 5, true, hash, features.player_ped(), true, true, 24000)
		MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 2, pos.x, pos.y, pos.z - 2, 5, true, hash, features.player_ped(), true, true, 24000)
	end, {"shootbullet"}, true)
end

__options.players["Freeze"] = ui.add_bool_option(TRANSLATION["Freeze"], __submenus["PlayerList"], function(bool)
	if utils.show_info(("freeze %s [on - off]"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("TOGGLE_ON")
	Global.playerlist[pid]["Freeze"] = bool
end, {"freeze"}, true)

__options.players["AlwaysWanted"] = ui.add_bool_option(TRANSLATION["Always wanted"], __submenus["PlayerList"], function(bool)
	if utils.show_info(("wanted %s [on - off]"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("TOGGLE_ON")
	Global.playerlist[pid]["AlwaysWanted"] = bool
end, {"wanted"}, true)

do
	local vehs = {}
	local god
	local upgrade = 0
	for i, v in ipairs(vehicles.models) do
		vehs[i] = v[3]
	end
	__options.bool["PlayerlistVehicleSpawnGod"] = ui.add_bool_option(TRANSLATION['Spawn with godmode'],  __submenus["SpawnVehicle"], function(bool)
		if utils.show_info("spawnwgod [on - off]") then ui.set_value(__options.bool["PlayerlistVehicleSpawnGod"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") god = bool
	end, {"spawnwgod"})
	__options.choose["PlSpawnPerformancePreset"] = ui.add_choose(TRANSLATION["Upgrade preset"], __submenus["SpawnVehicle"], true, {TRANSLATION["Stock"], TRANSLATION["Max upgrade"], TRANSLATION["Max without livery"], TRANSLATION["Performance"], TRANSLATION["Performance with spoiler"]}, function(int)
		if utils.show_info("spawnupgrade [choose]") then ui.set_value(__options.bool["PlSpawnPerformancePreset"], upgrade, true) return end
		utils.hud_sound("YES") upgrade = int
	end, {"spawnupgrade"})

	local selected_vehicle = 1
	local class = 0
	local classes = {}
	local curr_class
	for i = 0, 62
	do
		insert(classes, enum.vehicle_class[i])
	end

	local function spawn(model, player)
		system.thread(true, 'request_model_'..system.thread_count(), function()
			local loaded, hash = features.request_model(model)
			if not hash then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Something went wrong"], settings.General["HudColorNotifyError"]) return POP_THREAD end
			if loaded == 0 then return end
			local target = ENTITY.IS_ENTITY_VISIBLE(features.player_ped(player)) == 1 and features.get_offset_coords_from_entity_rot(features.player_ped(player), 6, 0, true) or features.get_player_coords2(player)
			local vehicle = vehicles.spawn_vehicle(hash, target, features.get_player_heading(player))
			if vehicle == 0 then return end
			entities.request_control(vehicle, function()
				-- DECORATOR.DECOR_SET_INT(vehicle, "MPBitset", 1024)
				vehicles.repair(vehicle)
				VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, false)
				VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "Nightfal")
				if god then vehicles.set_godmode(vehicle, true) end
				if upgrade == 1 then
					vehicles.upgrade(vehicle)
				elseif upgrade == 2 then
					vehicles.upgrade(vehicle)
					VEHICLE.SET_VEHICLE_MOD(vehicle, 48, -1, false)
				elseif upgrade == 3 then
					vehicles.performance(vehicle)
				elseif upgrade == 4 then
					vehicles.performance(vehicle)
					local num = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, 0) - 1
					VEHICLE.SET_VEHICLE_MOD(vehicle, 0, num, false)
				end
			end)
			STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
			return POP_THREAD
		end)
	end

	ui.add_input_string(TRANSLATION["Input model"], __submenus["SpawnVehicle"], function(text)	
		if utils.show_info(("spawnfor %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
		local pid = online.get_selected_player()
		if not text or text == '' or NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return utils.hud_sound("ERROR") end
		local text = text:lower()
		local hash = utils.joaat(text)
		if STREAMING.IS_MODEL_VALID(hash) == 1 and STREAMING.IS_MODEL_A_VEHICLE(hash) == 1 then
			spawn(hash, pid)
		else
			text = text:escpattern():ensurestart('^')
			for _, v in ipairs(vehicles.data)
			do
				if v.Name:find(text) or (v.DisplayName and v.DisplayName:lower():find(text)) or vehicles.get_label_name(v.Hash):lower():find(text) then
					hash = v.Hash
					break
				end
			end
			if STREAMING.IS_MODEL_VALID(hash) == 1 and STREAMING.IS_MODEL_A_VEHICLE(hash) == 1 then
				spawn(hash, pid)
			else
				system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Sorry I couldn't find any matching model"], settings.General["HudColorNotifyError"])
				utils.hud_sound("ERROR")
			end
		end
	end, {"spawnfor"}, true)

	local sel_class = ui.add_choose(TRANSLATION["Select class"], __submenus["SpawnVehicle"], true, classes, function(int) class = int
		utils.hud_sound("YES")
		if curr_class then 
			ui.remove(curr_class)
			curr_class = nil
		end
	end)
	ui.set_value(sel_class, class, true)
	system.thread(true, 'selected_class_'..system.thread_count(), function()
		if not curr_class then
			curr_class = ui.add_choose(TRANSLATION["Select vehicle"], __submenus["SpawnVehicle"], false, settings.Vehicle["VehManufacturer"] and vehicles.class_manufacturer[class] or vehicles.class[class], function(int)
				local pid = online.get_selected_player()
				if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return utils.hud_sound("ERROR") end
				utils.hud_sound("YES")
				selected_vehicle = int + 1
				spawn(vehicles.models[vehicles.get_veh_index(selected_vehicle, class)][2], pid)
			end)
		end
	end)
end

ui.add_click_option(TRANSLATION["Gift vehicle"], __submenus["PlayerlistVehicle"], function()
	if utils.show_info(("gift %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or not features.is_player_in_veh(pid) or system.is_thread_active("gift_veh_"..pid) then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	local spectate
	local timeout = clock() + 10
	system.thread(true, "gift_veh_"..pid, function(tick)
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or not features.is_player_in_veh(pid) or timeout < clock() then
			if spectate then NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, 0) end
			return POP_THREAD
		end
		local veh = vehicles.get_player_vehicle(pid)
		if veh == 0 then
			NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true, features.player_ped(pid))
			spectate = true
			return
		end
		entities.request_control(veh, function()
			local pl_veh
			DECORATOR.DECOR_REGISTER("Player_Vehicle", 3)
			DECORATOR.DECOR_REGISTER("Previous_Owner", 3)
			DECORATOR.DECOR_REGISTER("Vehicle_Reward", 3)
			DECORATOR.DECOR_REGISTER("MPBitset", 3)
			DECORATOR.DECOR_REGISTER("Veh_Modded_By_Player", 3)
			local net_hash = NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(pid)
			if ENTITY.IS_ENTITY_VISIBLE(veh) == 1 then
				if DECORATOR.DECOR_EXIST_ON(veh, "Player_Vehicle") == 1 then
					DECORATOR.DECOR_SET_INT(veh, "Player_Vehicle", net_hash)
				else
					pl_veh = DECORATOR.DECOR_GET_INT(veh, "Player_Vehicle")
					DECORATOR.DECOR_SET_INT(veh, "Player_Vehicle", net_hash)
				end
				if pl_veh and pl_veh ~= -1 then
					DECORATOR.DECOR_SET_INT(veh, "Previous_Owner", pl_veh)
				end
			end
			if DECORATOR.DECOR_EXIST_ON(veh, "Vehicle_Reward") == 0 then
				DECORATOR.DECOR_SET_BOOL(veh, "Vehicle_Reward", true)
				DECORATOR.DECOR_SET_INT(veh, "Vehicle_Reward", net_hash)
			end
			local veh_modd = DECORATOR.DECOR_GET_INT(veh, "Veh_Modded_By_Player")
			if veh_modd ~= 0 and veh_modd ~= -1 then
				DECORATOR.DECOR_SET_INT(veh, "Veh_Modded_By_Player", -1)
			end
		end)
		if spectate then NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, 0) end
		return POP_THREAD
	end)
end, {"gift"}, true)

ui.add_click_option(TRANSLATION["Hard vehicle sex"], __submenus["PlayerlistVehicle"], function()
	if utils.show_info(("hardsex %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or not features.is_player_in_veh(pid) or system.is_thread_active("lester_takes_the_wheel_"..pid) then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	local spectate
	local timeout = clock() + 10
	system.thread(true, "hard_veh_sex_"..pid, function(tick)
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or not features.is_player_in_veh(pid) or timeout < clock() then
			if spectate then NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, 0) end
			STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(utils.joaat('s_f_y_stripper_02'))
			return POP_THREAD
		end
		local loaded, hash = features.request_model('s_f_y_stripper_02')
		if loaded == 0 then
			timeout = clock() + 10
			return
		end
		if STREAMING.HAS_ANIM_DICT_LOADED("mini@prostitutes@sexnorm_veh") == 0 then
			STREAMING.REQUEST_ANIM_DICT("mini@prostitutes@sexnorm_veh")
			timeout = clock() + 10
			return
		end
		local loaded, hash2 = features.request_model('prop_el_guitar_01')
		if loaded == 0 then
			timeout = clock() + 10
			return
		end
		local veh = vehicles.get_player_vehicle(pid)
		if veh == 0 then
			NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true, features.player_ped(pid))
			spectate = true
			return
		end
		if VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(ENTITY.GET_ENTITY_MODEL(veh)) == 1 then
			system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Vehicle needs to have at least 2 seats"], settings.General["HudColorNotifyError"])
			STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
			if spectate then NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, 0) end
			return POP_THREAD
		end
		local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, 0, true)
		if ped ~= 0 then
			TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
			return
		end
		entities.request_control(veh, function()
			local pos = features.get_player_coords(pid) + vector3.up(10)
			local bitch = peds.create_ped(hash, pos, true)
			STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
			peds.apply_outfit({
				[0] = {0, 0},
				{0, 0},
				{2, 0},
				{0, 2},
				{1, 1},
				{0, 0},
				{0, 0},
				{0, 0},
				{1, 0},
				{1, 0},
			}, {}, bitch)
			PED.SET_PED_INTO_VEHICLE(bitch, veh, 0)
			peds.calm_ped(bitch, true)
			peds.play_anim(bitch, "mini@prostitutes@sexnorm_veh", "sex_loop_prostitute", 8.0, 8.0, -1, enum.anim_flag.Loop, 1.0, false)
			local ob1 = features.create_object(hash2, pos)
			ENTITY.ATTACH_ENTITY_TO_ENTITY(ob1, bitch,  0, 0, 0, 0, 0, 90, 0, false, false, true, false, 5, false)
			ENTITY.SET_ENTITY_VISIBLE(ob1, false, false)
			local ob2 = features.create_object(hash2, pos)
			ENTITY.ATTACH_ENTITY_TO_ENTITY(ob2, ob1,  0, 0, 0, 0, 0, 0, 0, false, false, true, false, 5, false)
			ENTITY.SET_ENTITY_VISIBLE(ob2, false, false)
			vehicles.set_godmode(veh, true)
			VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh, 6)
			VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh, 4)
		end)
		if spectate then NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, 0) end
		STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
		return POP_THREAD
	end)
end, {"hardsex"}, true)

ui.add_click_option(TRANSLATION["Lester takes the wheel"], __submenus["PlayerlistVehicle"], function()
	if utils.show_info(("lestertakeswheel %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or not features.is_player_in_veh(pid) or system.is_thread_active("lester_takes_the_wheel_"..pid) then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	local spectate
	local timeout = clock() + 10
	system.thread(true, "lester_takes_the_wheel_"..pid, function(tick)
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or not features.is_player_in_veh(pid) or timeout < clock() then
			if spectate then NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, 0) end
			STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(utils.joaat('ig_lestercrest_2'))
			return POP_THREAD
		end
		local loaded, hash = features.request_model('ig_lestercrest_2')
		if loaded == 0 then
			timeout = clock() + 10
			return
		end
		local veh = vehicles.get_player_vehicle(pid)
		if veh == 0 then
			NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true, features.player_ped(pid))
			spectate = true
			return
		end
		local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1, true)
		if ped ~= 0 then
			TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
			return
		end
		entities.request_control(veh, function()
			local lester = peds.create_ped(hash, features.get_player_coords(pid) + vector3.up(10), true)
			STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
			PED.SET_PED_INTO_VEHICLE(lester, veh, -1)
			peds.calm_ped(lester, true)
			TASK.TASK_VEHICLE_DRIVE_WANDER(lester, veh, 200, 786603)
			VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh, 6)
			VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh, 2)
		end)
		if spectate then NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, 0) end
		STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(utils.joaat('ig_lestercrest_2'))
		return POP_THREAD
	end)
end, {"lestertakeswheel"}, true)

--- @param name string
--- @param func function()
local function VehAction(name, func)
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or not features.is_player_in_veh(pid) or system.is_thread_active(name..pid) then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	local spectate
	local timeout = clock() + 10
	system.thread(true, name..pid, function(tick)
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or not features.is_player_in_veh(pid) or timeout < clock() then
			if spectate then NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, 0) end
			return POP_THREAD
		end
		local veh = vehicles.get_player_vehicle(pid)
		if veh == 0 then
			NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true, features.player_ped(pid))
			spectate = true
			return
		end
		entities.request_control(veh, function() func(veh, pid) end)
		if spectate then NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, 0) end
		return POP_THREAD
	end)
end

ui.add_click_option(TRANSLATION["Blow up vehicle"], __submenus["PlayerlistVehicle"], function()
	if utils.show_info(("explodeveh %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
	VehAction("blow_up_veh_", function(veh, pid)
		vehicles.set_godmode(veh, false)
		NETWORK.NETWORK_EXPLODE_VEHICLE(veh, true, false, pid)
	end)
end, {"explodeveh"}, true)

ui.add_click_option(TRANSLATION["Pop tires"], __submenus["PlayerlistVehicle"], function()
	if utils.show_info(("poptires %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
	VehAction("poptires_", function(veh)
		vehicles.set_godmode(veh, false)
		for i = 0, 5 do
			VEHICLE.SET_VEHICLE_TYRE_BURST(veh, i, true, 1000.0)
		end
	end)
end, {"poptires"}, true)

ui.add_click_option(TRANSLATION["Rotate vehicle"], __submenus["PlayerlistVehicle"], function()
	if utils.show_info(("rotateveh %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
	VehAction("rotateveh_", function(veh)
		local rot = features.get_entity_rot(veh, 5)
		ENTITY.SET_ENTITY_ROTATION(veh, rot.x, rot.y, rot.z - 180, 5, true)
	end)
end, {"rotateveh"}, true)

ui.add_click_option(TRANSLATION["Flip vehicle"], __submenus["PlayerlistVehicle"], function()
	if utils.show_info(("flipveh %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
	VehAction("filp_veh_", function(veh)
		local rot = features.get_entity_rot(veh, 5)
		ENTITY.SET_ENTITY_ROTATION(veh, rot.x, rot.y - 180, rot.z, 5, true)
	end)
end, {"flipveh"}, true)

ui.add_click_option(TRANSLATION["Boost forward"], __submenus["PlayerlistVehicle"], function()
	if utils.show_info(("boostforward %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
	VehAction("boostforward_", function(veh)
		VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, 500)
	end)
end, {"boostforward"}, true)

ui.add_click_option(TRANSLATION["Boost backward"], __submenus["PlayerlistVehicle"], function()
	if utils.show_info(("boostback %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
	VehAction("boostbackward_", function(veh)
		VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, -500)
	end)
end, {"boostback"}, true)

ui.add_click_option(TRANSLATION["Launch up vehicle"], __submenus["PlayerlistVehicle"], function()
	if utils.show_info(("launchup %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
	VehAction("launchup_", function(veh)
		ENTITY.FREEZE_ENTITY_POSITION(veh, false)
		features.set_entity_velocity(veh, 0, 0, 500)
	end)
end, {"launchup"}, true)

ui.add_click_option(TRANSLATION["Launch down vehicle"], __submenus["PlayerlistVehicle"], function()
	if utils.show_info(("launchdown %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
	VehAction("launchdown_", function(veh)
		ENTITY.FREEZE_ENTITY_POSITION(veh, false)
		features.set_entity_velocity(veh, 0, 0, -500)
	end)
end, {"launchdown"}, true)

ui.add_click_option(TRANSLATION["Hijack vehicle"], __submenus["PlayerlistVehicle"], function()
	if utils.show_info(("hijackveh %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or not features.is_player_in_veh(pid) or system.is_thread_active("hijack_vehicle_"..pid) then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	local spectate
	local timeout = clock() + 10
	system.thread(true, "hijack_vehicle_"..pid, function(tick)
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or not features.is_player_in_veh(pid) or timeout < clock() then
			if spectate then NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, 0) end
			return POP_THREAD
		end
		local veh = vehicles.get_player_vehicle(pid)
		if veh == 0 then
			NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true, features.player_ped(pid))
			spectate = true
			return
		end
		entities.request_control(veh, function()
			local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1, true)
			if ped and ped ~= features.player_ped() then
				online.send_script_event(pid, -513394492, PLAYER.PLAYER_ID(), pid)
				online.send_script_event(pid, -852914485, PLAYER.PLAYER_ID(), 0, 0, 0, 0, 1, pid, random(0, 2147483647))
				TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
			end
			PED.SET_PED_INTO_VEHICLE(features.player_ped(), veh, -1)
		end)
		if VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1, true) ~= features.player_ped() then return end
		if spectate then NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, 0) end
		return POP_THREAD
	end)
end, {"hijackveh"}, true)

ui.add_click_option(TRANSLATION["Disable ability to drive"], __submenus["PlayerlistVehicle"], function()
	if utils.show_info(("nodriving %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	online.send_script_event(pid, -168599209, PLAYER.PLAYER_ID(), 2, 4294967295, 1, 115, 0, 0, 0)
end, {"nodriving"}, true)

__options.players["VehicleGod"] = ui.add_bool_option(TRANSLATION["Set vehicle godmode"], __submenus["PlayerlistVehicle"], function(bool)
	if utils.show_info(("plvehgod %s [on - off]"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or not features.is_player_in_veh(pid) or system.is_thread_active("veh_god_"..pid) then return utils.hud_sound("ERROR") end
	utils.hud_sound("TOGGLE_ON")
	local spectate
	local timeout = clock() + 10
	system.thread(true, "veh_god_"..pid, function(tick)
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or not features.is_player_in_veh(pid) or timeout < clock() then
			if spectate then NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, 0) end
			return POP_THREAD
		end
		local veh = vehicles.get_player_vehicle(pid)
		if veh == 0 then
			NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true, features.player_ped(pid))
			spectate = true
			return
		end
		entities.request_control(veh, function()
			vehicles.set_godmode(veh, bool)
		end)
		if spectate then NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, 0) end
		return POP_THREAD
	end)
end, {"plvehgod"}, true)

__options.players["VehicleHorn"] = ui.add_bool_option(TRANSLATION["Start vehicle horn"], __submenus["PlayerlistVehicle"], function(bool)
	if utils.show_info(("plvehhorn %s [on - off]"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return utils.hud_sound("ERROR") end
	Global.playerlist[pid]["VehicleHorn"] = bool
	utils.hud_sound("TOGGLE_ON")
	system.thread(bool, 'horn_vehicle_'..pid, function(tick)
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return POP_THREAD end
		local veh = vehicles.get_player_vehicle(pid)
		if veh == 0 then return end
		entities.request_control(veh, function()
			VEHICLE.START_VEHICLE_HORN(veh, 3000, 0, false)
		end)
	end)
end, {"plvehhorn"}, true)

__options.players["HonkBoosting"] = ui.add_bool_option(TRANSLATION["Honk boosting"], __submenus["PlayerlistVehicle"], function(bool)
	if utils.show_info(("honkboosting %s [on - off]"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("TOGGLE_ON")
	Global.playerlist[pid]["HonkBoosting"] = bool
end, {"honkboosting"}, true)

__options.players["LockVehicle"] = ui.add_bool_option(TRANSLATION["Lock vehicle"], __submenus["PlayerlistVehicle"], function(bool)
	if utils.show_info(("lockveh %s [on - off]"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or not features.is_player_in_veh(pid) or system.is_thread_active("lockveh_"..pid) then return utils.hud_sound("ERROR") end
	utils.hud_sound("TOGGLE_ON")
	local spectate
	local timeout = clock() + 10
	system.thread(true, "lockveh_"..pid, function(tick)
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or not features.is_player_in_veh(pid) or timeout < clock() then
			if spectate then NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, 0) end
			return POP_THREAD
		end
		local veh = vehicles.get_player_vehicle(pid)
		if veh == 0 then
			NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true, features.player_ped(pid))
			spectate = true
			return
		end
		entities.request_control(veh, function()
			if bool then
				VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh, 6)
				VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh, 2)
			else
				VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh, 1)
			end
		end)
		if spectate then NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, 0) end
		return POP_THREAD
	end)
end, {"lockveh"}, true)

__options.players["ChildLocks"] = ui.add_bool_option(TRANSLATION["Child locks"], __submenus["PlayerlistVehicle"], function(bool)
	if utils.show_info(("lockinveh %s [on - off]"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or not features.is_player_in_veh(pid) or system.is_thread_active("child_locks_"..pid) then return utils.hud_sound("ERROR") end
	utils.hud_sound("TOGGLE_ON")
	local spectate
	local timeout = clock() + 10
	system.thread(true, "child_locks_"..pid, function(tick)
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or not features.is_player_in_veh(pid) or timeout < clock() then
			if spectate then NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, 0) end
			return POP_THREAD
		end
		local veh = vehicles.get_player_vehicle(pid)
		if veh == 0 then
			NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true, features.player_ped(pid))
			spectate = true
			return
		end
		entities.request_control(veh, function()
			if bool then
				VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh, 6)
				VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh, 4)
			else
			VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh, 1)
			end
		end)
		if spectate then NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, 0) end
		return POP_THREAD
	end)
end, {"lockinveh"}, true)

ui.add_click_option(TRANSLATION["Change max speed"], __submenus["PlayerlistVehicle"], function()
	if utils.show_info(("changemaxspeed %s [0 - 1000]"):format(online.get_name(online.get_selected_player()):lower())) then return end
	system.open_command_box(("> changemaxspeed %s 0"):format(online.get_name(online.get_selected_player()):lower()), true)
end)

system.register_command({"changemaxspeed"}, {type = "int", min = 0, max = 1000, step = 1, is_player = true, func = function(int)
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or not features.is_player_in_veh(pid) or system.is_thread_active("change_vmax_"..pid) then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	local spectate
	local timeout = clock() + 10
	system.thread(true, "change_vmax_"..pid, function(tick)
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or not features.is_player_in_veh(pid) or timeout < clock() then
			if spectate then NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, 0) end
			return POP_THREAD
		end
		local veh = vehicles.get_player_vehicle(pid)
		if veh == 0 then
			NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true, features.player_ped(pid))
			spectate = true
			return
		end
		entities.request_control(veh, function()
			ENTITY.SET_ENTITY_MAX_SPEED(veh, int)
		end)
		if spectate then NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, 0) end
		return POP_THREAD
	end)
end})

do
	local change
	ui.add_click_option(TRANSLATION["Copy outfit"], __submenus["PlayerlistOther"], function()
		if utils.show_info(("copyoutfit %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
		local pid = online.get_selected_player()
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return utils.hud_sound("ERROR") end
		utils.hud_sound("SELECT")
		local ped = features.player_ped(pid)
		local model = ENTITY.GET_ENTITY_MODEL(ped)
		local outfit = peds.get_outfit(ped)
		local blend_data = peds.get_head_blend()
		local overlay = peds.get_ped_overlay()
		local weapon = peds.get_weapons()
		local eye_color = PED._GET_PED_EYE_COLOR(features.player_ped())
		if model ~= ENTITY.GET_ENTITY_MODEL(features.player_ped()) then
			if change == pid or not ui.is_sub_open(__submenus["PlayerlistOther"]) then
				system.thread(true, 'change_model', function()
					local loaded, hash = features.request_model(model)
					if loaded == 0 then return end
					PLAYER.SET_PLAYER_MODEL(PLAYER.PLAYER_ID(), model)
					local my_ped = features.player_ped()
					PED._SET_PED_EYE_COLOR(my_ped, PED._GET_PED_EYE_COLOR(ped))
					for i = 0, 12
					do
						PED.SET_PED_HEAD_OVERLAY(my_ped, i, PED._GET_PED_HEAD_OVERLAY_VALUE(ped, i), 1)
					end
					peds.apply_outfit(outfit.components, outfit.props)
					peds.set_ped_head_blend(features.player_ped(), blend_data)
					peds.apply_overlay(features.player_ped(), overlay)
					PED._SET_PED_EYE_COLOR(features.player_ped(), eye_color)
					peds.set_weapons(weapon)
					if settings.Self["ForceOutfit"] then utils.no_sounds_this_frame(); ui.set_value(__options.bool["ForceOutfit"], true, false) end
					return POP_THREAD
				end)
				change = nil
			else
				system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Player has different model, would you like to change?"], settings.General["HudColorNotifyNormal"])
				change = pid
			end
			return
		end
		peds.apply_outfit(outfit.components, outfit.props)
		if settings.Self["ForceOutfit"] then utils.no_sounds_this_frame(); ui.set_value(__options.bool["ForceOutfit"], true, false) end
		change = nil
	end, {"copyoutfit"}, true)

	system.thread(true, 'player_check', function()
		if not ui.is_sub_open(__submenus["PlayerlistOther"]) or (change and NETWORK.NETWORK_IS_PLAYER_CONNECTED(change) == 0) then
			change = nil
		end
	end)
end

ui.add_click_option(TRANSLATION["Clone vehicle"], __submenus["PlayerlistOther"], function()
	if utils.show_info(("cloneveh %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or not features.is_player_in_veh(pid) or system.is_thread_active("clone_veh_"..pid) then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	local spectate
	local timeout = clock() + 10
	system.thread(true, "clone_veh_"..pid, function(tick)
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or not features.is_player_in_veh(pid) or timeout < clock() then
			if spectate then NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, 0) end
			return POP_THREAD
		end
		local veh = vehicles.get_player_vehicle(pid)
		if veh == 0 then
			NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true, features.player_ped(pid))
			spectate = true
			return
		end
		world_spawner.create_vehicle({world_saver.get_properties(veh, true)}, false, veh)
		if spectate then NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, 0) end
		return POP_THREAD
	end)
end, {"cloneveh"}, true)

ui.add_click_option(TRANSLATION["Spectate"], __submenus["PlayerlistOther"], function()
	if utils.show_info(("spectate %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or pid == PLAYER.PLAYER_ID() then return utils.hud_sound("ERROR") end
	NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true, features.player_ped(pid))
	utils.hud_sound("SELECT")
end, {"spectate"}, true)

ui.add_click_option(TRANSLATION["Stop spectating"], __submenus["PlayerlistOther"], function()
	if utils.show_info("stopspectate") then return end
	local pid = online.get_selected_player()
	NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, 0)
	utils.hud_sound("SELECT")
end, {"stopspectate"})

__options.players["ChatMock"] = ui.add_bool_option(TRANSLATION["Chat mOcK"], __submenus["PlayerlistOther"], function(bool)
	if utils.show_info(("mockplayer %s [on - off]"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("TOGGLE_ON")
	Global.playerlist[pid]["ChatMock"] = bool
end, {"mockplayer"}, true)

__options.players["Commands"] = ui.add_bool_option(TRANSLATION["Allow commands"], __submenus["PlayerlistOther"], function(bool)
	if utils.show_info(("allowcommands %s [on - off]"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("TOGGLE_ON")
	Global.playerlist[pid]["Commands"] = bool
end, {"allowcommands"}, true)

__options.players["Exclude"] = ui.add_bool_option(TRANSLATION["Exclude player"], __submenus["PlayerlistOther"], function(bool)
	if utils.show_info(("exclude %s [on - off]"):format(online.get_name(online.get_selected_player()):lower())) then return end
	utils.hud_sound("TOGGLE_ON")
	if bool then
		features.player_excludes[tostring(online.get_rockstar_id(online.get_selected_player()))] = {
			name = online.get_name(online.get_selected_player())
		}
		SaveExcludes()
		system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Player added to excludes"], settings.General["HudColorNotifySuccess"], true)
	else
		features.player_excludes[tostring(online.get_rockstar_id(online.get_selected_player()))] = nil
		SaveExcludes()
		system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Player removed from excludes"], settings.General["HudColorNotifySuccess"], true) 
	end
end, {"exclude"}, true)

__options.players["Waypoint"] = ui.add_bool_option(TRANSLATION["Add waypoint"], __submenus["PlayerlistOther"], function(bool)
	if utils.show_info(("addwaypoint %s [on - off]"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("TOGGLE_ON")
	for i = 0, 31
	do
		Global.playerlist[i]["Waypoint"] = false
	end
	Global.playerlist[pid]["Waypoint"] = bool
	system.thread(bool, 'waypoint_player', function()
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return POP_THREAD end
		local pos = features.get_player_coords(pid)
		HUD.SET_NEW_WAYPOINT(pos.x, pos.y)
	end)
end, {"addwaypoint"}, true)

__options.string["SendCommandAs"] = ui.add_input_string(TRANSLATION["Use chat command"], __submenus["PlayerlistOther"], function(text)
	if utils.show_info(("docommandas %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
	if not text or text == '' then return utils.hud_sound("ERROR") end
	local original = text
	text = text:ensurestart(Global.commad_prefix[settings.Commands['CommandsPrefix']])
	if not utils.is_chat_command(text) then return utils.hud_sound("ERROR") end
  	text = text:lower():gsub(format('^%s', Global.commad_prefix[settings.Commands['CommandsPrefix']]:escpattern()), '')
	local command = text:split('%s+', true)
  	command[1] = SimplifiedCommand(command[1]) or command[1]
  	if not settings.Commands['cmd_'..command[1]] then return utils.hud_sound("ERROR") end
  	local success, err = HandleCommand(command, online.get_selected_player())
  	if success then return end
	utils.hud_sound("ERROR")
	if not err then return end
	system.notify(TRANSLATION["Imagined Menu"], err, settings.General["HudColorNotifyNormal"])
end, {"docommandas"}, true)

do
	local tp
	ui.add_click_option(TRANSLATION["To me"], __submenus["PlayerlistTeleport"], function()
		if utils.show_info(("tptome %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
		local pid = online.get_selected_player()
		if tp or pid == PLAYER.PLAYER_ID() or NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return utils.hud_sound("ERROR") end
		local veh = vehicles.get_player_vehicle(pid)
		local ped = features.player_ped(pid)
		local pos_to = features.get_offset_from_player_coords(vector3.forward(5))
		local my_pos = features.get_player_coords()
		if veh ~= 0 then
			features.teleport(veh, pos_to.x, pos_to.y, pos_to.z)
			return
		end
		tp = true
		local bail = clock() + 30
		local function BailCheck()
			if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or bail < clock() then
				NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, ped)
				features.teleport(features.player_ped(), my_pos.x, my_pos.y, my_pos.z)
				tp = false
				system.notify(TRANSLATION["Imagined Menu"], TRANSLATION['Failed to teleport'], settings.General["HudColorNotifyError"], true)
				return POP_THREAD
			end
		end
		local event_sent
		local wait
		local inveh
		system.thread(true, 'teleport_player', function()
			if BailCheck() == 0 then return POP_THREAD end
			PAD.DISABLE_ALL_CONTROL_ACTIONS(0)
			globals.set_int(2793044 + 6876, 1)
			NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true, ped)
			local pos = features.get_player_coords(pid)
			local veh = vehicles.get_player_vehicle(pid)
			if veh ~= 0 then
				inveh = true
				features.teleport(veh, pos_to.x, pos_to.y, pos_to.z)
				if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(veh) == 1 then
					wait = clock() + .2
				end
				if wait and wait < clock() then
					system.thread(true, 'clear_ent_'..veh, function(tick)
						if not event_sent or tick > 300 then return POP_THREAD end
						if tick == 0 then TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped) end
						entities.request_control(veh, function()
							entities.delete(veh)
						end)
					end)
					NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, ped)
					features.teleport(features.player_ped(), my_pos.x, my_pos.y, my_pos.z)
					tp = false
					return POP_THREAD
				end
			elseif not features.is_player_in_veh(pid) and not event_sent then
				event_sent = true
				online.send_script_event(pid, 879177392, PLAYER.PLAYER_ID(), 1, 32, NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(pid), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1)
			end
			if inveh and veh == 0 then
				inveh = false
				event_sent = false
			end
		end)
	end, {"tptome"}, true)

	ui.add_click_option(TRANSLATION["To waypoint"], __submenus["PlayerlistTeleport"], function()
		if utils.show_info(("tptowp %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
		local pid = online.get_selected_player()
		if tp or pid == PLAYER.PLAYER_ID() or NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return utils.hud_sound("ERROR") end
		if HUD.IS_WAYPOINT_ACTIVE() == 0 then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["No waypoint has been set"], settings.General["HudColorNotifyError"]) utils.hud_sound("ERROR") return end
		utils.hud_sound("SELECT")
		local w_pos = features.get_waypoint_coord()
		local success, groundZ
		local b_pos = features.get_blip_for_coord(w_pos)
		system.thread(true, 'get_waypoint_Z', function(tick)
			if not b_pos then
				system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Preparing teleport"], settings.General["HudColorNotifyNormal"])
				local Z = (tick+1) * 100
				STREAMING.REQUEST_COLLISION_AT_COORD(w_pos.x, w_pos.y, Z)
				success, groundZ = features.get_ground_z(vector3(w_pos.x, w_pos.y, Z))
				if not success and Z < 900 then return end
				if not success then system.reset_thread_tick() return end
			end
			local veh = vehicles.get_player_vehicle(pid)
			local ped = features.player_ped(pid)
			local my_pos = features.get_player_coords()
			local pos_to = b_pos and b_pos or vector3(w_pos.x, w_pos.y, groundZ + 1)
			if veh ~= 0 then
				features.teleport(veh, pos_to.x, pos_to.y, pos_to.z)
				return
			end
			tp = true
			local bail = clock() + 30
			local function BailCheck()
				if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or bail < clock() then
					NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, ped)
					features.teleport(features.player_ped(), my_pos.x, my_pos.y, my_pos.z)
					tp = false
					system.notify(TRANSLATION["Imagined Menu"], TRANSLATION['Failed to teleport'], settings.General["HudColorNotifyError"], true)
					return POP_THREAD
				end
			end
			local event_sent
			local wait
			local inveh
			system.thread(true, 'teleport_player', function()
				if BailCheck() == 0 then return POP_THREAD end
				PAD.DISABLE_ALL_CONTROL_ACTIONS(0)
				globals.set_int(2793044 + 6876, 1)
				NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true, ped)
				local pos = features.get_player_coords(pid)
				local veh = vehicles.get_player_vehicle(pid)
				if veh ~= 0 then
					inveh = true
					features.teleport(veh, pos_to.x, pos_to.y, pos_to.z)
					if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(veh) == 1 then
						wait = clock() + .2
					end
					if wait and wait < clock() then
						system.thread(true, 'clear_ent_'..veh, function(tick)
							if not event_sent or tick > 300 then return POP_THREAD end
							if tick == 0 then TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped) end
							entities.request_control(veh, function()
								entities.delete(veh)
							end)
						end)
						NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, ped)
						features.teleport(features.player_ped(), my_pos.x, my_pos.y, my_pos.z)
						tp = false
						return POP_THREAD
					end
				elseif not features.is_player_in_veh(pid) and not event_sent then
					event_sent = true
					online.send_script_event(pid, 879177392, PLAYER.PLAYER_ID(), 1, 32, NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(pid), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1)
				end
				if inveh and veh == 0 then
					inveh = false
					event_sent = false
				end
			end)
			return POP_THREAD
		end)
	end, {"tptowp"}, true)
end

ui.add_click_option(TRANSLATION["Near me"], __submenus["PlayerlistTeleport"], function() 
	if utils.show_info(("tpnearme %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	local my_pos = features.get_player_coords()
	local apartment = features.get_closest_apartment_to_coord(my_pos)
	if pid == PLAYER.PLAYER_ID() then
		local pos = enum.apartment_coords[apartment]
		features.teleport(features.player_ped(), pos.x, pos.y, pos.z)
		return
	end
	online.send_script_event(pid, -168599209, PLAYER.PLAYER_ID(), pid, 1, 0, apartment, 1, 1, 1)
end, {"tpnearme"}, true)

ui.add_click_option(TRANSLATION["Near waypoint"], __submenus["PlayerlistTeleport"], function()
	if utils.show_info(("tpnearwp %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return utils.hud_sound("ERROR") end
	if HUD.IS_WAYPOINT_ACTIVE() == 0 then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["No waypoint has been set"], settings.General["HudColorNotifyError"]) utils.hud_sound("ERROR") return end
	utils.hud_sound("SELECT")
	local my_pos = features.get_waypoint_coord()
	local apartment = features.get_closest_apartment_to_coord(my_pos)
	if pid == PLAYER.PLAYER_ID() then
		local pos = enum.apartment_coords[apartment]
		features.teleport(features.player_ped(), pos.x, pos.y, pos.z)
		return
	end
	online.send_script_event(pid, -168599209, PLAYER.PLAYER_ID(), pid, 1, 0, apartment, 1, 1, 1)
end, {"tpnearwp"}, true)

ui.add_click_option(TRANSLATION["Send to cutscene"], __submenus["PlayerlistTeleport"], function()
	if utils.show_info(("cutscene %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	local time = clock() + 1.5
	local f_pos = features.get_player_coords()
	local veh = vehicles.get_player_vehicle()
	local teleported
	system.thread(true, 'send_to_cutscene', function()
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then
			if not teleported then return POP_THREAD end
			if veh ~= 0 then
				PED.SET_PED_INTO_VEHICLE(features.player_ped(), veh, -1)
			end
			features.teleport(features.player_ped(), f_pos.x, f_pos.y, f_pos.z)
			return POP_THREAD
		end
		local my_pos = features.get_player_coords()
		local pl_pos = features.get_player_coords2(pid)
		if my_pos:sqrlen(pl_pos) > 2500 then
			features.teleport(features.player_ped(), pl_pos.x, pl_pos.y + 50, pl_pos.z == -50 and 1000 or pl_pos.z)
			teleported = true
		end
		online.send_script_event(pid, 392606458, PLAYER.PLAYER_ID())
		if pl_pos.z == -50 then time = clock() + 1.5 return end
		if time > clock() then return end
		if not teleported then return POP_THREAD end
		if veh ~= 0 then
			PED.SET_PED_INTO_VEHICLE(features.player_ped(), veh, -1)
		end
		features.teleport(features.player_ped(), f_pos.x, f_pos.y, f_pos.z)
		return POP_THREAD
	end)
end, {"cutscene"}, true)

__options.choose["PlayerWarehouse"] = ui.add_choose(TRANSLATION["Send to warehouse"], __submenus["PlayerlistTeleport"], false, {TRANSLATION["Random"], "Pacific Bait Storage", "White Widow Garage", "Celltowa Unit", "Convenience Store Lockup", "Foreclosed Garage", "Xero Gas Factory", "Derriere Lingerie Backlot", "Bilgeco Warehouse", "Pier 400 Utility Building", "GEE Warehouse", "LS Marine Building 3", "Railyard Warehouse", "Fridgit Annexe", "Disused Factory Outlet", "Discount Retail Unit", "Logistics Depot", "Darnel Bros Warehouse", "Wholesale Furniture", "Cypress Warehouses", "West Vinewood Backlot", "Old Power Station", "Walker & Sons Warehouse"}, function(int)
	if utils.show_info(("warehouse %s [choose]"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("YES")
	online.send_script_event(pid, 434937615, PLAYER.PLAYER_ID(), 0, 1, int == 0 and random(1, 22) or int)
end, {"warehouse"}, true)

__options.choose["PlayerTpCayo"] = ui.add_choose(TRANSLATION["Send to island"], __submenus["PlayerlistTeleport"], false, {TRANSLATION["Normal"], TRANSLATION["Instant"], TRANSLATION["LSIA"], TRANSLATION["Beach"]}, function(int)
	if utils.show_info(("island %s [choose]"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local pid = online.get_selected_player()
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("YES")
	if int == 0 then
		online.send_script_event(pid, -910497748, PLAYER.PLAYER_ID(), 1)
	elseif int == 1 then
		online.send_script_event(pid, -93722397, PLAYER.PLAYER_ID(), pid, pid, 4, 1)
	elseif int == 2 then
		online.send_script_event(pid, -93722397, PLAYER.PLAYER_ID(), pid, pid, 3, 0)
	elseif int == 3 then
		online.send_script_event(pid, -93722397, PLAYER.PLAYER_ID(), pid, pid, 4, 0)
	end
end, {"island"}, true)

do
	local types = {TRANSLATION["Severe Weather Patterns"], TRANSLATION["Half-truck Bully"], TRANSLATION["Exit Strategy"], TRANSLATION["Offshore Assets"], TRANSLATION["Cover Blown"], TRANSLATION["Mole Hunt"], TRANSLATION["Data Breach"], TRANSLATION["Work Dispute"]}
	__options.choose["SendMission"] = ui.add_choose(TRANSLATION["Send to job"], __submenus["PlayerlistTeleport"], false, types, function(int)
		if utils.show_info(("mission %s [choose]"):format(online.get_name(online.get_selected_player()):lower())) then return end
		local pid = online.get_selected_player()
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return utils.hud_sound("ERROR") end
		utils.hud_sound("YES")
		online.send_script_event(pid, 1858712297, PLAYER.PLAYER_ID(), int)
	end, {"mission"}, true)

	__options.choose["TpToPlayer"] = ui.add_choose(TRANSLATION["Teleport to"], __submenus["PlayerlistTeleport"], false, {TRANSLATION["Them"], TRANSLATION["Into their vehicle"]}, function(int)
		if utils.show_info(("tpto %s [choose]"):format(online.get_name(online.get_selected_player()):lower())) then return end
		local pid = online.get_selected_player()
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return utils.hud_sound("ERROR") end
		local veh = vehicles.get_player_vehicle(pid)
		if int == 0 then
			features.teleport2(features.player_ped(), features.get_player_coords2(pid):get())
			return utils.hud_sound("YES")
		elseif veh ~= 0 and veh ~= vehicles.get_player_vehicle() and vehicles.get_first_free_seat(veh) then
			PED.SET_PED_INTO_VEHICLE(features.player_ped(), veh, -2)
			return utils.hud_sound("YES")
		elseif features.is_player_in_veh(pid) then
			system.thread(true, "tp_to_player_veh", function(tick)
				local ped = features.player_ped(pid)
				if tick > 1000 or NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or features.is_player_in_interior(pid) or ENTITY.IS_ENTITY_DEAD(ped, false) == 1 then NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, 0) return POP_THREAD end
				NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true, ped)
				local veh = vehicles.get_player_vehicle(pid)
				if veh == 0 then return end
				if veh == vehicles.get_player_vehicle() then NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, 0) return POP_THREAD end
				NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, 0)
				if vehicles.get_first_free_seat(veh) then
					PED.SET_PED_INTO_VEHICLE(features.player_ped(), veh, -2)
				end
				return POP_THREAD
			end)
			return utils.hud_sound("YES")
		end
		utils.hud_sound("ERROR")
	end, {"tpto"}, true)
end

ui.add_separator(TRANSLATION["Kicks and crashes"], __submenus["PlayerList"])

ui.add_click_option(TRANSLATION["Kick"], __submenus["PlayerList"], function()
	if utils.show_info(("kick %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local player = online.get_selected_player()
	if player == PLAYER.PLAYER_ID() or NETWORK.NETWORK_IS_PLAYER_CONNECTED(player) == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	features.kick_player(player)
end, {"kick"}, true)

ui.add_click_option(TRANSLATION["SE Crash"], __submenus["PlayerList"], function()
	if utils.show_info(("crash %s"):format(online.get_name(online.get_selected_player()):lower())) then return end
	local player = online.get_selected_player()
	if player == PLAYER.PLAYER_ID() or NETWORK.NETWORK_IS_PLAYER_CONNECTED(player) == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	features.crash_player(player)
end, {"crash"}, true)

local function Clipboard(option_id)
	if features.to_clipboard(ui.get_name(option_id), true) then utils.hud_sound("SELECT") else utils.hud_sound("ERROR") end
end

__options.click["IsPlayerGodmode"] = ui.add_click_option(TRANSLATION["Is godmode"]..":", __submenus["Info"], function() Clipboard(__options.click["IsPlayerGodmode"]) end)
__options.click["IsPlayerHasNoRagdoll"] = ui.add_click_option(TRANSLATION["Has no ragdoll"]..":", __submenus["Info"], function() Clipboard(__options.click["IsPlayerHasNoRagdoll"]) end)
__options.click["IsPlayerInterior"] = ui.add_click_option(TRANSLATION["Is in interior"]..":", __submenus["Info"], function() Clipboard(__options.click["IsPlayerInterior"]) end)
__options.click["IsPlayerInVeh"] = ui.add_click_option(TRANSLATION["Is in vehicle"]..":", __submenus["Info"], function() Clipboard(__options.click["IsPlayerInVeh"]) end)
__options.click["IsPlayerVehGodmode"] = ui.add_click_option(TRANSLATION["Is vehicle godmode"]..":", __submenus["Info"], function() Clipboard(__options.click["IsPlayerVehGodmode"]) end)
__options.click["IsPlayerDead"] = ui.add_click_option(TRANSLATION["Is dead"]..":", __submenus["Info"], function() Clipboard(__options.click["IsPlayerDead"]) end)
__options.click["IsPlayerTyping"] = ui.add_click_option(TRANSLATION["Is typing"]..":", __submenus["Info"], function() Clipboard(__options.click["IsPlayerTyping"]) end)
__options.click["IsPlayerPause"] = ui.add_click_option(TRANSLATION["Is game paused"]..":", __submenus["Info"], function() Clipboard(__options.click["IsPlayerPause"]) end)
__options.click["IsPlayerOTR"] = ui.add_click_option(TRANSLATION["Is off the radar"]..":", __submenus["Info"], function() Clipboard(__options.click["IsPlayerOTR"]) end)
__options.click["IsPlayerInRCVeh"] = ui.add_click_option(TRANSLATION["Is in RC vehicle"]..":", __submenus["Info"], function() Clipboard(__options.click["IsPlayerInRCVeh"]) end)
__options.click["IsPlayerPassive"] = ui.add_click_option(TRANSLATION["Is in passive"]..":", __submenus["Info"], function() Clipboard(__options.click["IsPlayerPassive"]) end)
__options.click["PlayerHealth"] = ui.add_click_option(TRANSLATION["Health"]..":", __submenus["Info"], function() Clipboard(__options.click["PlayerHealth"]) end)
__options.click["PlayerArmour"] = ui.add_click_option(TRANSLATION["Armour"]..":", __submenus["Info"], function() Clipboard(__options.click["PlayerArmour"]) end)
__options.click["PlayerSpeed"] = ui.add_click_option(TRANSLATION["Speed"]..":", __submenus["Info"], function() Clipboard(__options.click["PlayerSpeed"]) end)
__options.click["PlayerDistance"] = ui.add_click_option(TRANSLATION["Distance"]..":", __submenus["Info"], function() Clipboard(__options.click["PlayerDistance"]) end)
__options.click["PlayerPosition"] = ui.add_click_option(TRANSLATION["Position"]..":", __submenus["Info"], function() Clipboard(__options.click["PlayerPosition"]) end)
__options.click["PlayerStreet"] = ui.add_click_option(TRANSLATION["Street"]..":", __submenus["Info"], function() Clipboard(__options.click["PlayerStreet"]) end)
__options.click["PlayerCrossing"] = ui.add_click_option(TRANSLATION["Crossing"]..":", __submenus["Info"], function() Clipboard(__options.click["PlayerCrossing"]) end)
__options.click["PlayerZone"] = ui.add_click_option(TRANSLATION["Zone"]..":", __submenus["Info"], function() Clipboard(__options.click["PlayerZone"]) end)

ui.add_separator(TRANSLATION["Stats"], __submenus["Info"])

__options.click["PlayerRank"] = ui.add_click_option(TRANSLATION["Rank"]..":", __submenus["Info"], function() Clipboard(__options.click["PlayerRank"]) end)
__options.click["PlayerWallet"] = ui.add_click_option(TRANSLATION["Wallet"]..":", __submenus["Info"], function() Clipboard(__options.click["PlayerWallet"]) end)
__options.click["PlayerBank"] = ui.add_click_option(TRANSLATION["Bank"]..":", __submenus["Info"], function() Clipboard(__options.click["PlayerBank"]) end)
__options.click["PlayerTotal"] = ui.add_click_option(TRANSLATION["Total"]..":", __submenus["Info"], function() Clipboard(__options.click["PlayerTotal"]) end)
__options.click["PlayerKills"] = ui.add_click_option(TRANSLATION["Kills"]..":", __submenus["Info"], function() Clipboard(__options.click["PlayerKills"]) end)
__options.click["PlayerDeaths"] = ui.add_click_option(TRANSLATION["Deaths"]..":", __submenus["Info"], function() Clipboard(__options.click["PlayerDeaths"]) end)
__options.click["PlayerRatio"] = ui.add_click_option(TRANSLATION["Ratio"]..":", __submenus["Info"], function() Clipboard(__options.click["PlayerRatio"])end)
__options.click["PlayerWeaponAcc"] = ui.add_click_option(TRANSLATION["Accuracy"]..":", __submenus["Info"], function() Clipboard(__options.click["Accuracy"])end)
__options.click["PlayerMental"] = ui.add_click_option(TRANSLATION["Mental state"]..":", __submenus["Info"], function() Clipboard(__options.click["Mental state"])end)
__options.click["PlayerRacesW"] = ui.add_click_option(TRANSLATION["Races won"]..":", __submenus["Info"], function() Clipboard(__options.click["PlayerRacesW"]) end)
__options.click["PlayerRacesL"] = ui.add_click_option(TRANSLATION["Races lost"]..":", __submenus["Info"], function() Clipboard(__options.click["PlayerRacesL"]) end)
__options.click["PlayerDeathmatchW"] = ui.add_click_option(TRANSLATION["Deathmatches won"]..":", __submenus["Info"], function() Clipboard(__options.click["PlayerDeathmatchW"]) end)
__options.click["PlayerDeathmatchL"] = ui.add_click_option(TRANSLATION["Deathmatches lost"]..":", __submenus["Info"], function() Clipboard(__options.click["PlayerDeathmatchL"]) end)
__options.click["PlayerSexActs"] = ui.add_click_option(TRANSLATION["Sex acts purchased"]..":", __submenus["Info"], function() Clipboard(__options.click["PlayerSexActs"]) end)
__options.click["PlayerPrivateDance"] = ui.add_click_option(TRANSLATION["Private dances"]..":", __submenus["Info"], function() Clipboard(__options.click["PlayerPrivateDance"]) end)
__options.click["PlayerVehicle"] = ui.add_click_option(TRANSLATION["Favourite vehicle"]..":", __submenus["Info"], function() Clipboard(__options.click["PlayerVehicle"]) end)
__options.click["PlayerWeapo"] = ui.add_click_option(TRANSLATION["Favourite weapon"]..":", __submenus["Info"], function() Clipboard(__options.click["PlayerWeapo"]) end)
__options.click["PlayerRadio"] = ui.add_click_option(TRANSLATION["Favourite radio"]..":", __submenus["Info"], function() Clipboard(__options.click["PlayerRadio"]) end)

ui.add_separator(TRANSLATION["Detections"], __submenus["Info"])

local function is_sus(pid)
	local count = 0
	for _, v in pairs(Global.suspicious[pid])
	do
		if v then
			count = count + 1
		end
	end
	return count > 1
end

do
	local player_id = 0

	system.thread(true, 'player_list', function()
		local pid = online.get_selected_player()
		if ui.is_open() and features.is_excluded(pid) and not ui.get_value(__options.players["Exclude"]) then
			ui.set_value(__options.players["Exclude"], true, true)
		elseif not features.is_excluded(pid) and ui.get_value(__options.players["Exclude"]) then
			ui.set_value(__options.players["Exclude"], false, true)
		end
		if ui.is_sub_open(__submenus["PlayerlistVehicle"]) then
			local veh = vehicles.get_player_vehicle(pid)
			if veh ~= 0 then
				local doorlock = VEHICLE.GET_VEHICLE_DOOR_LOCK_STATUS(veh)
				if doorlock == 2 and not ui.get_value(__options.players["LockVehicle"]) then
					ui.set_value(__options.players["LockVehicle"], true, true)
				elseif doorlock ~= 2 and ui.get_value(__options.players["LockVehicle"]) then
					ui.set_value(__options.players["LockVehicle"], false, true)
				end
				if doorlock == 4 and not ui.get_value(__options.players["ChildLocks"]) then
					ui.set_value(__options.players["ChildLocks"], true, true)
				elseif  doorlock ~= 4 and ui.get_value(__options.players["ChildLocks"]) then
					ui.set_value(__options.players["ChildLocks"], false, true)
				end
				ui.set_value(__options.players["VehicleGod"], features.get_godmode(veh), true)
			else
				if ui.get_value(__options.players["LockVehicle"]) then
					ui.set_value(__options.players["LockVehicle"], false, true)
				end
				if ui.get_value(__options.players["ChildLocks"]) then
					ui.set_value(__options.players["ChildLocks"], false, true)
				end
				if ui.get_value(__options.players["VehicleGod"]) then
					ui.set_value(__options.players["VehicleGod"], false, true)
				end
			end
		end
		for k, v in pairs(Global.playerlist[pid])
		do
			if NETWORK.NETWORK_IS_SESSION_STARTED() == 0 then
				for i = 0, 31
				do
					Global.playerlist[i][k] = false
				end
			end

			if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then
				Global.playerlist[pid][k] = false
			end
			if v and not ui.get_value(__options.players[k]) then
				ui.set_value(__options.players[k], true, true)
			elseif not v and ui.get_value(__options.players[k]) then
				ui.set_value(__options.players[k], false, true)
			end
		end

		if player_id ~= PLAYER.PLAYER_ID() and NETWORK.NETWORK_IS_PLAYER_CONNECTED(player_id) == 1 then
			local player_vehicle = vehicles.get_player_vehicle(player_id)
			local total_mony = features.get_total(player_id)
			local wallet = features.get_wallet(player_id)
			local ped = features.player_ped(player_id)
			local rank = features.get_rank(player_id)

			if player_id ~= PLAYER.PLAYER_ID() and NETWORK.NETWORK_IS_PLAYER_CONNECTED(player_id) == 1 and Global.modder_detection[player_id][14] == false and not Global.detection_info.is_player_dead[player_id] then
				local id = features.has_player_been_damaged(player_id)
				if ENTITY.IS_ENTITY_DEAD(ped, false) == 1 or id ~= -1 then
					Global.detection_info.is_player_dead[player_id] = clock() -- no need to check every time after player is already dead
					ENTITY.CLEAR_ENTITY_LAST_DAMAGE_ENTITY(ped)
					if Global.blame_delay < clock() or id ~= -1 then
						local source = PED.GET_PED_SOURCE_OF_DEATH(ped)
						if source ~= 0 then
							id = features.get_player_from_ped(source)
						end
						if id ~= -1 and id ~= player_id and id ~= PLAYER.PLAYER_ID() and features.is_player_godmode(id) and
							not features.is_player_in_interior(id) and not features.is_rc_veh(id) and
							features.get_player_coords2(player_id):sqrlen(features.get_player_coords2(id)) < 4000000 then
							on_modder_detection_handle(id, 14)
						end
					end
				end
			end

			if Global.detection_info.is_player_dead[player_id] and ENTITY.IS_ENTITY_DEAD(ped, false) == 0 then
				Global.detection_info.is_player_dead[player_id] = false
			end
			if Global.modder_detection[player_id][15] == false and ENTITY.GET_ENTITY_SPEED(ped) > 150 and not (player_vehicle ~= 0 and VEHICLE.GET_PED_IN_VEHICLE_SEAT(player_vehicle, -1, false) == features.player_ped(player_id)) and NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(player_vehicle) == 0 then
				on_modder_detection_handle(player_id, 15)
			end
			if Global.modder_detection[player_id][16] == false and not (player_vehicle ~= 0 and VEHICLE.GET_PED_IN_VEHICLE_SEAT(player_vehicle, -1, false) == features.player_ped(player_id)) then
				local pos = features.get_player_coords2(player_id)
				if pos.z > 2700 or pos.x > 15000 or pos.y > 15000 or pos.x < -15000 or pos.y < - 15000 then
					on_modder_detection_handle(player_id, 16)
				end
			end
			if not Global.modder_detection[player_id][18] and ENTITY.IS_ENTITY_DEAD(features.player_ped(player_id), false) == 0 and
				features.get_kills(player_id) ~= features.get_kills(PLAYER.PLAYER_ID()) --[[spoofing might fuck up smth so we check if it's not the same as spoofed]]
				and features.get_deaths(player_id) ~= features.get_deaths(PLAYER.PLAYER_ID()) and features.get_kd(player_id) ~= features.get_kd(PLAYER.PLAYER_ID())
				and features.get_kills(player_id)/features.get_deaths(player_id) ~= math.huge and (abs(features.get_kd(player_id) - features.get_kills(player_id)/(features.get_deaths(player_id))) >= .5) then
				on_modder_detection_handle(player_id, 18)
			end
			if Global.modder_detection[player_id][19] == false and rank ~= features.get_rank(PLAYER.PLAYER_ID()) and (rank < 0 or rank > 8000) or (features.get_xp(player_id) ~= features.get_xp(PLAYER.PLAYER_ID()) and features.get_xp(player_id) < features.get_xp_for_rank(rank)) then
				on_modder_detection_handle(player_id, 19)
			end
			if not Global.modder_detection[player_id][21] and player_vehicle ~= 0 and vehicles.is_model_non_drivable(ENTITY.GET_ENTITY_MODEL(player_vehicle)) then
				on_modder_detection_handle(player_id, 21)
			end
			if not Global.modder_detection[player_id][22] and is_sus(player_id) then
				on_modder_detection_handle(player_id, 22)
			end
			if not Global.suspicious[player_id][1] and ENTITY.IS_ENTITY_DEAD(features.player_ped(player_id), false) == 0 and PLAYER.IS_PLAYER_PLAYING(player_id) == 1 and total_mony ~= features.get_total(PLAYER.PLAYER_ID()) and wallet ~= features.get_wallet(PLAYER.PLAYER_ID()) and total_mony ~= 0 and (total_mony < 0 or wallet < 0 or wallet > total_mony or total_mony >= 2147483647 or wallet >= 2147483647) then
				Global.detection_info.money[player_id] = Global.detection_info.money[player_id] + 1
				if Global.detection_info.money[player_id] > 100 then -- check many times to reduce false positives
					Global.suspicious[player_id][1] = true
					system.log("debug", "detection 1 "..online.get_name(player_id))
				end
			else
				Global.detection_info.money[player_id] = 0
			end
			if not Global.suspicious[player_id][2] and Global.player_dead_time[player_id] and Global.player_dead_time[player_id] ~= true and Global.player_dead_time[player_id] < clock() - 60  then
				Global.suspicious[player_id][2] = true
				system.log("debug", "detection 2 "..online.get_name(player_id))
			end
			if not Global.suspicious[player_id][3] and ENTITY.IS_ENTITY_DEAD(features.player_ped(player_id), false) == 0 and PED.GET_PED_ARMOUR(ped) > 50 then
				Global.suspicious[player_id][3] = true
				system.log("debug", "detection 3 "..online.get_name(player_id))
			end
			if not Global.suspicious[player_id][4] and ENTITY.IS_ENTITY_DEAD(features.player_ped(player_id), false) == 0 and ENTITY.GET_ENTITY_HEALTH(ped) > 5000 then
				Global.suspicious[player_id][4] = true
				system.log("debug", "detection 4 "..online.get_name(player_id))
			end
		else
			Global.detection_info.is_player_dead[player_id] = false
			Global.detection_info.money[player_id] = 0
		end

		if ui.is_sub_open(__submenus["Info"]) then
			for j = 0, 23
			do
				if not Global.detection_info[j] and Global.modder_detection[pid][j] then
					Global.detection_info[j] = ui.add_click_option(DetectionFlags(j), __submenus["Info"], function()
						utils.hud_sound("SELECT")
						Global.modder_detection[pid][j] = nil
						for e = 0, 23
						do
							if Global.modder_detection[pid][e] then
								return
							end
						end
						Global.modder_detection[pid].triggered = false
					end)
				elseif Global.detection_info[j] and not Global.modder_detection[pid][j] then
					ui.remove(Global.detection_info[j])
					Global.detection_info[j] = nil
				end
			end

			local speed = ENTITY.GET_ENTITY_SPEED(features.player_ped(pid))
			local mult = 3.6
			local unit = 'km/h'
			if MISC.SHOULD_USE_METRIC_MEASUREMENTS() == 0 then
				mult = 2.236936
				unit = 'mph'
			end
			local pos = features.get_player_coords(pid)
			local streetName, crossingRoad = s_memory.alloc(), s_memory.alloc()
			PATHFIND.GET_STREET_NAME_AT_COORD(pos.x, pos.y, pos.z, streetName, crossingRoad)
			streetName, crossingRoad = memory.read_int(streetName), memory.read_int(crossingRoad)

			ui.set_name(__options.click["IsPlayerGodmode"], TRANSLATION["Is godmode"]..': '..(features.is_player_godmode(pid) and TRANSLATION["Yes"] or TRANSLATION["No"]))
			ui.set_name(__options.click["IsPlayerHasNoRagdoll"], TRANSLATION["Has no ragdoll"]..': '..(features.has_noragdoll(pid) and TRANSLATION["Yes"] or (features.is_player_in_veh(pid) or features.get_player_coords(pid):sqrlen(features.get_final_cam_pos()) > 22500) and TRANSLATION["Unknown"] or TRANSLATION["No"]))
			ui.set_name(__options.click["IsPlayerInterior"], TRANSLATION["Is in interior"]..': '..(features.is_player_in_interior2(pid) and TRANSLATION["Yes"] or TRANSLATION["No"]))
			ui.set_name(__options.click["IsPlayerInVeh"], TRANSLATION["Is in vehicle"]..': '..(features.is_player_in_veh(pid) and TRANSLATION["Yes"] or TRANSLATION["No"]))
			ui.set_name(__options.click["IsPlayerVehGodmode"], TRANSLATION["Is vehicle godmode"]..': '..(vehicles.get_player_vehicle(pid) == 0 and TRANSLATION["Unknown"] or features.get_godmode(vehicles.get_player_vehicle(pid)) and TRANSLATION["Yes"] or TRANSLATION["No"]))
			ui.set_name(__options.click["IsPlayerDead"], TRANSLATION["Is dead"]..': '..(type(Global.player_dead_time[pid]) == "boolean" and TRANSLATION["No"] or os.date("!%X", os_time() - Global.player_dead_time[pid])))
			ui.set_name(__options.click["IsPlayerPause"], TRANSLATION["Is game paused"]..': '..(features.is_game_paused(pid) and TRANSLATION["Yes"] or TRANSLATION["No"]))
			ui.set_name(__options.click["IsPlayerTyping"], TRANSLATION["Is typing"]..': '..(features.is_typing(pid) and TRANSLATION["Yes"] or TRANSLATION["No"]))
			ui.set_name(__options.click["IsPlayerOTR"], TRANSLATION["Is off the radar"]..': '..(type(Global.player_otr_time[pid]) == "boolean" and TRANSLATION["No"] or os.date("!%X", os_time() - Global.player_otr_time[pid])))
			ui.set_name(__options.click["IsPlayerInRCVeh"], TRANSLATION["Is in RC vehicle"]..': '..(features.is_rc_veh(pid) and TRANSLATION["Yes"] or TRANSLATION["No"]))
			ui.set_name(__options.click["IsPlayerPassive"], TRANSLATION["Is in passive"]..': '..(features.is_player_passive(pid) and TRANSLATION["Yes"] or TRANSLATION["No"]))
			ui.set_name(__options.click["PlayerHealth"], TRANSLATION["Health"]..': '..("%i / %i"):format(ENTITY.GET_ENTITY_HEALTH(features.player_ped(pid)), ENTITY.GET_ENTITY_MAX_HEALTH(features.player_ped(pid))))
			ui.set_name(__options.click["PlayerArmour"], TRANSLATION["Armour"]..': '..("%i / %i"):format(PED.GET_PED_ARMOUR(features.player_ped(pid)), 50))
			ui.set_name(__options.click["PlayerSpeed"], TRANSLATION["Speed"]..': '..("%.1f %s"):format(speed * mult, unit))
			ui.set_name(__options.click["PlayerDistance"], TRANSLATION["Distance"]..': '..("%.1f"):format(features.get_player_coords2(pid):len(features.get_player_coords())))
			ui.set_name(__options.click["PlayerPosition"], TRANSLATION["Position"]..': '..("%.3f, %.3f, %.3f"):format(features.get_player_coords2(pid):get()))
			ui.set_name(__options.click["PlayerStreet"], TRANSLATION["Street"]..': '..HUD.GET_STREET_NAME_FROM_HASH_KEY(streetName))
			ui.set_name(__options.click["PlayerCrossing"], TRANSLATION["Crossing"]..': '..HUD.GET_STREET_NAME_FROM_HASH_KEY(crossingRoad))
			ui.set_name(__options.click["PlayerZone"], TRANSLATION["Zone"]..': '..features.get_zone_for_coords(features.get_player_coords2(pid)))
			ui.set_name(__options.click["PlayerRank"], TRANSLATION["Rank"]..': '..(features.get_ply_rank_as_str(pid)))
			ui.set_name(__options.click["PlayerWallet"], TRANSLATION["Wallet"]..': $'..features.format_int(features.get_wallet(pid)))
			ui.set_name(__options.click["PlayerBank"], TRANSLATION["Bank"]..': $'..features.format_int(abs(features.get_total(pid) - features.get_wallet(pid))))
			ui.set_name(__options.click["PlayerTotal"], TRANSLATION["Total"]..': $'..features.format_int(features.get_total(pid)))
			ui.set_name(__options.click["PlayerKills"], TRANSLATION["Kills"]..': '..(features.get_kills(pid)))
			ui.set_name(__options.click["PlayerDeaths"], TRANSLATION["Deaths"]..': '..(features.get_deaths(pid)))
			ui.set_name(__options.click["PlayerRatio"], TRANSLATION["Ratio"]..': '..(("%.2f"):format(features.get_kd(pid))))
			ui.set_name(__options.click["PlayerWeaponAcc"], TRANSLATION["Accuracy"]..': '..(("%.2f%%"):format(features.get_weapon_acc(pid))))
			ui.set_name(__options.click["PlayerMental"], TRANSLATION["Mental state"]..': '..(("%.2f%%"):format(features.get_mental_state(pid))))
			ui.set_name(__options.click["PlayerRacesW"], TRANSLATION["Races won"]..': '..(features.get_races_won(pid)))
			ui.set_name(__options.click["PlayerRacesL"], TRANSLATION["Races lost"]..': '..(features.get_races_lost(pid)))
			ui.set_name(__options.click["PlayerDeathmatchW"], TRANSLATION["Deathmatches won"]..': '..(features.get_deathmatch_won(pid)))
			ui.set_name(__options.click["PlayerDeathmatchL"], TRANSLATION["Deathmatches lost"]..': '..(features.get_deathmatch_lost(pid)))
			ui.set_name(__options.click["PlayerSexActs"], TRANSLATION["Sex acts purchased"]..': '..(features.get_sex_acts(pid)))
			ui.set_name(__options.click["PlayerPrivateDance"], TRANSLATION["Private dances"]..': '..(features.get_private_dances(pid)))
			ui.set_name(__options.click["PlayerVehicle"], TRANSLATION["Favourite vehicle"]..': '..(features.get_fav_vehicle(pid)))
			ui.set_name(__options.click["PlayerWeapo"], TRANSLATION["Favourite weapon"]..': '..(features.get_fav_weapon(pid)))
			ui.set_name(__options.click["PlayerRadio"], TRANSLATION["Favourite radio"]..': '..(features.get_fav_radio(pid)))

		end


		for i = 1, #Global.players_by_name
		do
			Global.players_by_name[i] = nil
		end

		for i = 0, 31
		do

			if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 then
				insert(Global.players_by_name, online.get_name(i):lower())
			end

			if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and ENTITY.IS_ENTITY_DEAD(features.player_ped(i), false) == 1 and not Global.player_dead_time[i] then
				Global.player_dead_time[i] = os_time()
			elseif (NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 0 or ENTITY.IS_ENTITY_DEAD(features.player_ped(i), false) == 0) and Global.player_dead_time[i] then
				Global.player_dead_time[i] = false
			end

			if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and features.is_otr(i) and not Global.player_otr_time[i] then
				Global.player_otr_time[i] = os_time()
			elseif (NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 0 or not features.is_otr(i)) and Global.player_otr_time[i] then
				Global.player_otr_time[i] = false
			end

			if Global.playerlist[i]["Freeze"] then
				online.send_script_event(i, 434937615, PLAYER.PLAYER_ID(), 0, 1, 0, globals.get_int(1894573 + (1 + (i * 608) + 510)))
				TASK.CLEAR_PED_TASKS_IMMEDIATELY(features.player_ped(i))
			end
			if Global.playerlist[i]["HonkBoosting"] then
				if Global.hornboost[i] and Global.hornboost[i] > clock() then return end
				local veh = vehicles.get_player_vehicle(pid)
				if veh ~= 0 and AUDIO.IS_HORN_ACTIVE(veh) ~= 0 then
					Global.hornboost[i] = clock() + .5
					entities.request_control(veh, function()
						local speed = ENTITY.GET_ENTITY_SPEED(veh)
						VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, speed + 20)
					end, .5)
				end
			end
		end
		if Global.playerlist[player_id]["AlwaysWanted"] then
			features.set_wanted_level(player_id, 5)
		end
		player_id = player_id + 1 == 32 and 0 or player_id + 1
	end)
end
---------------------------------------------------------------------------------------------------------------------------------
-- Self
---------------------------------------------------------------------------------------------------------------------------------
__submenus["Self"] = ui.add_submenu(TRANSLATION["Self"])
__suboptions["Self"] = ui.add_sub_option(TRANSLATION["Self"], __submenus["MainSub"], __submenus["Self"])

__submenus["GhostRider"] = ui.add_submenu(TRANSLATION["Ghost rider"])
__suboptions["GhostRider"] = ui.add_sub_option(TRANSLATION["Ghost rider"], __submenus["Self"], __submenus["GhostRider"])

do
	local comp = {}
	local props = {}
	local chains = {}
	local flame = {
		vehicle = {}
	}
	local sanctus = 0
	local spawn
	local is_force_outfit
	for i = 1, 8 do
		chains[i] = 0
	end
	local ghostrider_chains = {
	    {0.00999999885, 0.139999986, 0.0299999975, 0, -49.9999962, 0},
	    {-0.119999982, -0.0699999779, -0.0699999928, 9.99999714, -49.9999962, 0},
	    {0.0299999993, -0.0900000036, 0.049999997, 0, -39.9999962, -7.4505806e-08},
	    {0.170000002, -0.0500000007, 0.139999986, 0, -30.9999962, 0},
	    {0.0899999887, 0.0999999717, 0.109999985, 1.86264515e-09, -39.9999924, 0},
	    {-0.0999998376, 0.100000001, -0.0900002569, -9.99999905, -50.0299911, 0},
	    {-0.0699571669, 0.130019873, -0.0500002541, -19.9999981, -54.9999962, 0},
	    {38, 0.139999971, 0.0299999844, 0.139999986, 0, -29.9999962, 0},
	}
	local ghostRider = {
		male = {
			components = {
				[0] = {24, 0},
				{2, 2},
				{22, 3},
				{33, 0},
				{4, 0},
				{0, 0},
				{12, 6},
				{0, 0},
				{2, 2},
				{0, 0},
				{0, 0},
				{64, 0},
			},
		},
		female = {
			components = {
				[0] = {24, 0},
				{2, 2},
				{22, 3},
				{36, 0},
				{27, 0},
				{0, 0},
				{24, 0},
				{0, 0},
				{1, 0},
				{0, 0},
				{0, 0},
				{55, 0},
			},
		}
	}

	local function DeleteGhostRider()
		local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(sanctus, -1, true)
		TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
		features.delete_entity(sanctus)
		for i = 1, 2
		do
			if flame.vehicle[i] then features.delete_entity(flame.vehicle[i]) end
		end
		spawn = nil
	end

	__options.bool["GhostRiderOutfit"] = ui.add_bool_option(TRANSLATION["Become rider"], __submenus["GhostRider"], function(bool)
		if utils.show_info("becomerider [on - off]", "Makes you Ghost Rider") then ui.set_value(__options.bool["GhostRiderOutfit"], not bool, true) return end
		local ped = features.player_ped()
		local model = ENTITY.GET_ENTITY_MODEL(ped)
		if model ~= utils.joaat("mp_f_freemode_01") and model ~= utils.joaat("mp_m_freemode_01") then
			system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Ghost rider outfit works only on mp male and female"], settings.General["HudColorNotifyError"])
			ui.set_value(__options.bool["GhostRiderOutfit"], false, true)
			return utils.hud_sound("ERROR")
		end
		utils.hud_sound("TOGGLE_ON")
		if bool then
			if settings.Self["ForceOutfit"] then
				ui.set_value(__options.bool["ForceOutfit"], false, true)
				system.remove_thread('self_force_outfit')
				is_force_outfit = true
			end
			if filesystem.exists(files['TimeToBurn']) then
				system.play_wav(files['TimeToBurn'])
			end
			local outfit = peds.get_outfit()
			comp = outfit.components
			props = outfit.props
		end
		if not bool then
			peds.apply_outfit(comp, props)
			for _, v in ipairs(chains)
			do
				features.delete_entity(v)
			end
			if is_force_outfit then
				utils.no_sounds_this_frame()
				is_force_outfit = false
				ui.set_value(__options.bool["ForceOutfit"], true, false)
			end
			flame._self = nil
			STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(utils.joaat("prop_cs_leg_chain_01"))
			STREAMING.REMOVE_NAMED_PTFX_ASSET("core")
		end
		system.thread(bool, 'ghost_rider_outfit', function()
			if STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("core") == 0 then
				STREAMING.REQUEST_NAMED_PTFX_ASSET("core")
				return
			end
			local ped = features.player_ped()
			local model = ENTITY.GET_ENTITY_MODEL(ped)
			if model == utils.joaat("mp_f_freemode_01") then
				PED.CLEAR_ALL_PED_PROPS(features.player_ped())
				peds.apply_outfit(ghostRider.female.components, {})
			elseif model == utils.joaat("mp_m_freemode_01") then
				PED.CLEAR_ALL_PED_PROPS(features.player_ped())
				peds.apply_outfit(ghostRider.male.components, {})
			else
				system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Ghost rider outfit works only on mp male and female"], settings.General["HudColorNotifyError"], true)
				ui.set_value(__options.bool["GhostRiderOutfit"], false, true)
				return POP_THREAD
			end
			local ok, hash = features.request_model("prop_cs_leg_chain_01")
			if ok == 0 then return end
			local pos = features.get_player_coords()
			for i, v in ipairs(chains)
			do
				if v == 0 or ENTITY.DOES_ENTITY_EXIST(v) == 0 then
					local obj = features.create_object(hash, pos)
					ENTITY.ATTACH_ENTITY_TO_ENTITY(obj, ped, 38,
						ghostrider_chains[i][1], ghostrider_chains[i][2], ghostrider_chains[i][3],
						ghostrider_chains[i][4], ghostrider_chains[i][5], ghostrider_chains[i][6],
						false, true, false, false, 5, true)
					chains[i] = obj
				end
			end
			if not flame._self then
				GRAPHICS.USE_PARTICLE_FX_ASSET("core")
				flame._self = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY("ent_amb_beach_campfire", chains[1], 0.190000423, -0.0799999833, -0.200000033, 0, 0, 0, 0.7, false, false, false, 0, 0, 0, 1)
        		GRAPHICS.SET_PARTICLE_FX_LOOPED_SCALE(flame._self, 0.7)
			end
		end)
	end, {"becomerider"})

	ui.add_click_option(TRANSLATION["Request bike"], __submenus["GhostRider"], function()
		if utils.show_info("riderbike", "Brings bike to you") then return end
		utils.hud_sound("SELECT")
		if spawn then
			if sanctus == 0 then return end
			DeleteGhostRider()
		end
		spawn = true
		sanctus = 0
		system.thread(true, 'ghostrider_veh_'..system.thread_count(), function()
			local ok, hash = features.request_model("sanctus")
			if ok == 0 then return end
			if STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("core") == 0 then 
				STREAMING.REQUEST_NAMED_PTFX_ASSET("core")
				return
			end
			local loaded, chip = features.request_model("prop_crisp_small")
			if not loaded then return end
			local pos = features.get_offset_from_player_coords(vector3(0, 5, 0))
			sanctus = vehicles.spawn_vehicle(hash, pos, features.get_player_heading())
			vehicles.set_godmode(sanctus, true)
			flame.vehicle[1] = features.create_object(chip, pos)
			flame.vehicle[2] = features.create_object(chip, pos)
			-- ENTITY.SET_ENTITY_ALPHA(flame.vehicle[1], 0, false)
			-- ENTITY.SET_ENTITY_ALPHA(flame.vehicle[2], 0, false)
			ENTITY.ATTACH_ENTITY_TO_ENTITY(flame.vehicle[1], sanctus, 0, 0, 0.8, -0.2, 0, 0, 0, false, true, false, false, 5, true)
      ENTITY.ATTACH_ENTITY_TO_ENTITY(flame.vehicle[2], sanctus, 0, 0, -0.8, -0.2, 0, 0, 0, false, true, false, false, 5, true)
      VEHICLE.SET_VEHICLE_MOD_KIT(sanctus, 0)
      local modindex = {11, 12, 13, 16, 18}
      local modtype = {3, 2, 2, 4, 1}
      for i = 1, #modindex
      do
        if VEHICLE.GET_VEHICLE_MOD(sanctus, modindex[i]) ~= modtype[i] then
          VEHICLE.SET_VEHICLE_MOD(sanctus, modindex[i], modtype[i], false)
        end
      end
      VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(sanctus, false)
      VEHICLE.SET_VEHICLE_COLOURS(sanctus, 126, 126)
      VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(sanctus, 0, 0, 0)
      VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(sanctus, 0, 0, 0)
      VEHICLE.SET_VEHICLE_EXTRA_COLOURS(sanctus, 0, 0)
      VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(sanctus, "RIDER")
      ENTITY.SET_ENTITY_RENDER_SCORCHED(sanctus, true)
			features.unload_models(utils.joaat("prop_crisp_small"), utils.joaat("sanctus"))
			for i = 1, 2
			do
				GRAPHICS.USE_PARTICLE_FX_ASSET("core")
				local ptfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY("ent_amb_beach_campfire", flame.vehicle[i], 0, 0, 0, 0, 0, 0, 1, false, false, false, 0, 0, 0, 1)
				GRAPHICS.SET_PARTICLE_FX_LOOPED_SCALE(ptfx, 1)
	    	end
			STREAMING.REMOVE_NAMED_PTFX_ASSET("core")
			return POP_THREAD
		end)
	end, {"riderbike"})

	ui.add_click_option(TRANSLATION["Return bike"], __submenus["GhostRider"], function()
		if utils.show_info("returnbike", "Returns bike") then return end
		if not spawn then utils.hud_sound("ERROR") return end
		utils.hud_sound("SELECT")
		DeleteGhostRider()
	end, {"returnbike"})

end

do
	for i, v in ipairs(peds.anims)
	do
		insert(Global.anims, TRANSLATION[v[1]])
	end

	local blend_in_speed = 8
	local blend_out_speed = -8
	local duration = -1
	local playback_rate = 0
	local flags = {0,0,0,0,0}
	local lock = false
	local on_peds
	__submenus["PlayAnim"] = ui.add_submenu(TRANSLATION["Play animation"])
	__suboptions["PlayAnim"] = ui.add_sub_option(TRANSLATION["Play animation"], __submenus["Self"], __submenus["PlayAnim"])
	ui.add_click_option(TRANSLATION["Stop animation"], __submenus["PlayAnim"], function()
		if utils.show_info("stopanim", "Stops all animations") then return end
		utils.hud_sound("SELECT") TASK.CLEAR_PED_TASKS_IMMEDIATELY(features.player_ped()) 
	end, {"stopanim"})
	__options.bool["OnNearbyPeds"] = ui.add_bool_option(TRANSLATION["Play only on nearby peds"], __submenus["PlayAnim"], function(bool)
		if utils.show_info("animonpeds [on - off]", "Plays animation on all nearby peds") then ui.set_value(__options.bool["OnNearbyPeds"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") on_peds = bool
	end, {"animonpeds"})
	ui.add_separator(TRANSLATION["Animations"], __submenus["PlayAnim"])

	__options.num["BlendInSpeed"] = ui.add_num_option(TRANSLATION["Blend-In Speed"], __submenus["PlayAnim"], -999999999, 999999999, 1, function(int)
		if utils.show_info("animblendin [-999999999, 999999999]") then ui.set_value(__options.num["BlendInSpeed"], blend_in_speed, true) return end
		utils.hud_sound("YES") blend_in_speed = int
	end, {"animblendin"})
	ui.set_value(__options.num["BlendInSpeed"], blend_in_speed, true)
	__options.num["BlendOutSpeed"] = ui.add_num_option(TRANSLATION["Blend-Out Speed"], __submenus["PlayAnim"], -999999999, 999999999, 1, function(int)
		if utils.show_info("animblendout [-999999999, 999999999]") then ui.set_value(__options.num["BlendOutSpeed"], blend_out_speed, true) return end
		utils.hud_sound("YES") blend_out_speed = int
	end, {"animblendout"})
	ui.set_value(__options.num["BlendOutSpeed"], blend_out_speed, true)
	__options.num["Duration"] = ui.add_num_option(TRANSLATION["Duration (ms)"], __submenus["PlayAnim"], -1, 999999999, 100, function(int)
		if utils.show_info("animduration [-1 - 999999999]") then ui.set_value(__options.num["Duration"], duration, true) return end
		utils.hud_sound("YES") duration = int
	end, {"animduration"})
	ui.set_value(__options.num["Duration"], duration, true)
	__options.num["PlaybackRate"] = ui.add_float_option(TRANSLATION["Playback rate"], __submenus["PlayAnim"], 0, 1, .1, 1, function(float)
		if utils.show_info("animplayback [0.0 - 1.0]") then ui.set_value(__options.num["PlaybackRate"], playback_rate, true) return end
		utils.hud_sound("YES") playback_rate = float
	end, {"animplayback"})
	ui.set_value(__options.num["PlaybackRate"], playback_rate, true)
	__options.bool["Loop"] = ui.add_bool_option(TRANSLATION["Loop"], __submenus["PlayAnim"], function(bool)
		if utils.show_info("animloop [on - off]", "Set from which part anim will play") then ui.set_value(__options.bool["Loop"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON")
		if bool then
			flags[1] = enum.anim_flag.Loop
		else
			flags[1] = 0
		end
	end, {"animloop"})
	__options.bool["StopOnLastFrame"] = ui.add_bool_option(TRANSLATION["Stop on last frame"], __submenus["PlayAnim"], function(bool)
		if utils.show_info("animlastframe [on - off]") then ui.set_value(__options.bool["StopOnLastFrame"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON")
		if bool then
			flags[2] = enum.anim_flag.StopOnLastFrame
		else
			flags[2] = 0
		end
	end, {"animlastframe"})
	__options.bool["OnlyAnimateUpperBody"] = ui.add_bool_option(TRANSLATION["Only animate upper body"], __submenus["PlayAnim"], function(bool)
		if utils.show_info("animupper [on - off]") then ui.set_value(__options.bool["OnlyAnimateUpperBody"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON")
		if bool then
			flags[3] = enum.anim_flag.OnlyAnimateUpperBody
		else
			flags[3] = 0
		end
	end, {"animupper"})
	__options.bool["AllowPlayerControl"] = ui.add_bool_option(TRANSLATION["Allow player control"], __submenus["PlayAnim"], function(bool)
		if utils.show_info("animcontrollable [on - off]") then ui.set_value(__options.bool["AllowPlayerControl"], not bool, true) return end
		 utils.hud_sound("TOGGLE_ON")
		if bool then
			flags[4] = enum.anim_flag.AllowPlayerControl
		else
			flags[4] = 0
		end
	end, {"animcontrollable"})
	__options.bool["Cancellable"] = ui.add_bool_option(TRANSLATION["Cancellable"], __submenus["PlayAnim"], function(bool)
		if utils.show_info("animcancellable [on - off]") then ui.set_value(__options.bool["Cancellable"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON")
		if bool then
		flags[5] = enum.anim_flag.Cancellable
		else
			flags[5] = 0
		end
	end, {"animcancellable"})
	__options.bool["LockPos"] = ui.add_bool_option(TRANSLATION["Lock position"], __submenus["PlayAnim"], function(bool)
		if utils.show_info("animlockpos [on - off]") then ui.set_value(__options.bool["LockPos"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON")
		lock = bool
	end, {"animlockpos"})

	__options.choose["PlayAnim"] = ui.add_choose(TRANSLATION["Play"], __submenus["PlayAnim"], false, Global.anims, function(int)
		if utils.show_info("playanim [choose]") then return end
		utils.hud_sound("YES")
		local anim_dict = peds.anims[int + 1][2]
		local anim_name = peds.anims[int + 1][3]
		local flag = 0
		for _, v in ipairs(flags)
		do
			flag = flag + v
		end
		system.thread(true, 'animation_'..system.thread_count(), function()
			if STREAMING.HAS_ANIM_DICT_LOADED(anim_dict) == 0 then
				STREAMING.REQUEST_ANIM_DICT(anim_dict)
				return
			end
			if on_peds then
				for _, v in ipairs(entities.get_peds())
				do
					if v ~= features.player_ped() then
						entities.request_control(v, function()
							PED.SET_PED_CAN_RAGDOLL(v, false)
							PED.SET_PED_CAN_RAGDOLL_FROM_PLAYER_IMPACT(v, false)
							peds.calm_ped(v, true)
							TASK.CLEAR_PED_TASKS_IMMEDIATELY(v)
							peds.play_anim(v, anim_dict, anim_name, blend_in_speed, blend_out_speed, duration, flag, playback_rate, lock)
						end)
					end
				end
			else
				peds.play_anim(features.player_ped(), anim_dict, anim_name, blend_in_speed, blend_out_speed, duration, flag, playback_rate, lock)
			end
			STREAMING.REMOVE_ANIM_DICT(anim_dict)
			return POP_THREAD
		end)
	end, {"playanim"})

	ui.add_separator(TRANSLATION["Scenarios"], __submenus["PlayAnim"])
	Global.scenarios = {}
	for i = 1, #peds.scenario
	do
		Global.scenarios[i] = TRANSLATION[peds.scenario[i][1]]
	end
	__options.choose["PlayScenario"] = ui.add_choose(TRANSLATION["Play"], __submenus["PlayAnim"], false, Global.scenarios, function(int)
		if utils.show_info("playscenario [choose]") then return end
		utils.hud_sound("YES")
		if on_peds then
			for _, v in ipairs(entities.get_peds())
			do
				if v ~= features.player_ped() then
					entities.request_control(v, function()
						PED.SET_PED_CAN_RAGDOLL(v, false)
						PED.SET_PED_CAN_RAGDOLL_FROM_PLAYER_IMPACT(v, false)
						peds.calm_ped(v, true)
						TASK.CLEAR_PED_TASKS_IMMEDIATELY(v)
						peds.play_scenario(v, peds.scenario[int + 1][2])
					end)
				end
			end
		else
			peds.play_scenario(features.player_ped(), peds.scenario[int + 1][2])
		end
	end, {"playscenario"})
	ui.add_separator(TRANSLATION["Movement styles"], __submenus["PlayAnim"])

	local movements = {}
	for i, v in ipairs(peds.movement_clip_sets)
	do
		insert(movements, TRANSLATION[v[1]])
	end
	local movement
	ui.add_click_option(TRANSLATION["Default"], __submenus["PlayAnim"], function()
		if utils.show_info("movementdef") then return end
		if on_peds then
			for _, v in ipairs(entities.get_peds())
			do
				if v ~= features.player_ped() then
					entities.request_control(v, function()
						PED.RESET_PED_MOVEMENT_CLIPSET(v, 0)
					end)
				end
			end
		else
			PED.RESET_PED_MOVEMENT_CLIPSET(features.player_ped(), 0)
		end
	end, {"movementdef"})

	__options.choose["PlayMovement"] = ui.add_choose(TRANSLATION["Set movement"], __submenus["PlayAnim"], false, movements, function(int) utils.hud_sound("YES")
		if utils.show_info("playmovement [choose]") then return end
		if movement then STREAMING.REMOVE_ANIM_SET(movement) end
		movement = peds.movement_clip_sets[int + 1][2]
		system.thread(true, 'request_movement_clipset_'..system.thread_count(), function()
			if STREAMING.HAS_ANIM_SET_LOADED(movement) == 0 then
				STREAMING.REQUEST_ANIM_SET(movement)
				return
			end
			if on_peds then
				for _, v in ipairs(entities.get_peds())
				do
					if v ~= features.player_ped() then
						entities.request_control(v, function()
							TASK.CLEAR_PED_TASKS_IMMEDIATELY(v)
							PED.SET_PED_MOVEMENT_CLIPSET(v, movement, 1)
						end)
					end
				end
			else
				PED.SET_PED_MOVEMENT_CLIPSET(features.player_ped(), movement, 1)
			end
			return POP_THREAD
		end)
	end, {"playmovement"})
end

do
	__submenus["PlayPTFX"] = ui.add_submenu(TRANSLATION["Play ptfx"])
	__suboptions["PlayPTFX"] = ui.add_sub_option(TRANSLATION["Play ptfx"], __submenus["Self"], __submenus["PlayPTFX"])
	local wait
	local ptfx
	local particle_efects = {}
	local bones = {}
	for i, v in ipairs(enum.ptfx)
	do
		particle_efects[i] = TRANSLATION[v[1]]
	end

	__options.bool["PtfxLooped"] = ui.add_bool_option(TRANSLATION["Looped"], __submenus["PlayPTFX"], function(bool) utils.hud_sound("TOGGLE_ON")
		if utils.show_info("ptfxloop [on - off]") then ui.set_value(__options.bool["PtfxLooped"], not bool, true) return end
		settings.Self["PtfxLooped"] = bool
		if bool then return end
		system.thread(true, 'stop_ptfx', function()
			GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(features.player_ped())
			return POP_THREAD
		end)
	end, {"ptfxloop"})
	__options.bool["PtfxHead"] = ui.add_bool_option(TRANSLATION["Head"], __submenus["PlayPTFX"], function(bool) utils.hud_sound("TOGGLE_ON")
		if utils.show_info("ptfxhead [on - off]") then ui.set_value(__options.bool["PtfxHead"], not bool, true) return end
		settings.Self["PtfxHead"] = bool
		bones[0x796e] = bool
	end, {"ptfxhead"})
	__options.bool["PtfxLeftArm"] = ui.add_bool_option(TRANSLATION["Left arm"], __submenus["PlayPTFX"], function(bool) utils.hud_sound("TOGGLE_ON")
		if utils.show_info("ptfxlarm [on - off]") then ui.set_value(__options.bool["PtfxLeftArm"], not bool, true) return end
		settings.Self["PtfxLeftArm"] = bool
		bones[0x49d9] = bool
	end, {"ptfxlarm"})
	__options.bool["PtfxRightArm"] = ui.add_bool_option(TRANSLATION["Right arm"], __submenus["PlayPTFX"], function(bool) utils.hud_sound("TOGGLE_ON")
		if utils.show_info("ptfxrarm [on - off]") then ui.set_value(__options.bool["PtfxRightArm"], not bool, true) return end
		settings.Self["PtfxRightArm"] = bool
		bones[0xdead] = bool
	end, {"ptfxrarm"})
	__options.bool["PtfxLeftLeg"] = ui.add_bool_option(TRANSLATION["Left leg"], __submenus["PlayPTFX"], function(bool) utils.hud_sound("TOGGLE_ON")
		if utils.show_info("ptfxlleg [on - off]") then ui.set_value(__options.bool["PtfxLeftLeg"], not bool, true) return end
		settings.Self["PtfxLeftLeg"] = bool
		bones[0x3779] = bool
	end, {"ptfxlleg"})
	__options.bool["PtfxRightLeg"] = ui.add_bool_option(TRANSLATION["Right leg"], __submenus["PlayPTFX"], function(bool) utils.hud_sound("TOGGLE_ON")
		if utils.show_info("ptfxrleg [on - off]") then ui.set_value(__options.bool["PtfxRightLeg"], not bool, true) return end
		settings.Self["PtfxRightLeg"] = bool
		bones[0xcc4d] = bool
	end, {"ptfxrleg"})
	__options.num["PtfxDelay"] = ui.add_float_option(TRANSLATION["Delay (seconds)"], __submenus["PlayPTFX"], 0, 1, .01, 3, function(float)
		if utils.show_info("ptfxdelay [0.0 - 1.0]") then ui.set_value(__options.num["PtfxDelay"], settings.Self["PtfxDelay"], true) return end
		utils.hud_sound("YES") settings.Self["PtfxDelay"] = features.round(float, 3)
	end, {"ptfxdelay"})
	__options.num["PtfxScale"] = ui.add_float_option(TRANSLATION["Scale"], __submenus["PlayPTFX"], 0, 10, .05, 2, function(float)
		if utils.show_info("ptfxscale [0.0 - 10.0]") then ui.set_value(__options.num["PtfxScale"], settings.Self["PtfxScale"], true) return end
		utils.hud_sound("YES") settings.Self["PtfxScale"] = features.round(float, 2)
	end, {"ptfxscale"})
	ui.add_choose(TRANSLATION["Particle effects"], __submenus["PlayPTFX"], false, particle_efects, function(int)
		if utils.show_info("playptfx [choose]") then ui.set_value(__options.num["PtfxScale"], settings.Self["PtfxScale"], true) return end
		utils.hud_sound("YES")
		system.thread(true, 'self_play_ptfx', function()
			if ptfx and ptfx ~= enum.ptfx[int+1][2] then
				STREAMING.REMOVE_NAMED_PTFX_ASSET(ptfx)
			end
			ptfx = enum.ptfx[int+1][2]
			if STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(ptfx) == 0 then 
				STREAMING.REQUEST_NAMED_PTFX_ASSET(ptfx)
				return
			end
			if not settings.Self["PtfxLooped"] then wait = nil end
			if wait and wait > clock() - settings.Self["PtfxDelay"] then return end
			wait = clock()
			for k, v in pairs(bones)
			do
				if v then
					GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx)
					GRAPHICS._START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY_BONE(enum.ptfx[int+1][3], features.player_ped(), 0, 0, 0, -90, 0, 0, PED.GET_PED_BONE_INDEX(features.player_ped(), k), settings.Self["PtfxScale"], false, false, false)
				end
			end
			if not settings.Self["PtfxLooped"] then
				return POP_THREAD
			end
		end)
	end, {"playptfx"})
end

do
	__submenus["Wardrobe"] = ui.add_submenu(TRANSLATION["Wardrobe"])
	__suboptions["Wardrobe"] = ui.add_sub_option(TRANSLATION["Wardrobe"], __submenus["Self"], __submenus["Wardrobe"])

	__submenus["SavedOutfits"] = ui.add_submenu(TRANSLATION["Saved outfits"])
	__suboptions["SavedOutfits"] = ui.add_sub_option(TRANSLATION["Saved outfits"], __submenus["Wardrobe"], __submenus["SavedOutfits"])

	local path = [[C:\Users\]]..os.getenv('username')..[[\Documents\Nightfall\wardrobe]]
	local ok, outfit
	local loaded
	local outfit_for_model = {}
	local drawables_names = {}
	local props_names = {}
	local saved = {}
	local options = {}

	local function parse(data)
		local _outfit = {
			components = {},
			props = {}
		}
		for k, v in pairs(data)
		do
			if k:startswith('prop_') then
				_outfit.props[k:gsub('prop_', '')] = {v.texture, v.variation}
			else
				_outfit.components[k] = {v.variation, v.texture}
			end
		end
		return _outfit
	end

	local function ApplyOutfit(data)
		local _outfit = parse(data)
		if settings.Self['ForceOutfit'] then
			_outfit.model = tostring(ENTITY.GET_ENTITY_MODEL(features.player_ped()))
			outfit = _outfit
		else
			peds.apply_outfit(_outfit.components, _outfit.props)
		end
	end

	local last_prev
	local outfit_prev
	local this_outfit
	local function RefreshOutfits()
		saved = {}
		if not filesystem.isdir(path) then return end
		local files = filesystem.scandir(path, 'json')
		for i = 1, #Global.outfits
		do
			Global.outfits[i] = nil
		end
		Global.outfits_keys = {}
		for _, v in ipairs(files)
		do
			local name = v:gsub('%.json$', '')
			saved[name] = true
			insert(Global.outfits, name:lower())
			Global.outfits_keys[name:lower()] = name
			if not options[name] then
				options[name] = ui.add_click_option(name, __submenus["SavedOutfits"], function()
					if utils.show_info("outfit "..name:lower()) then return end
					utils.hud_sound("SELECT")
					system.thread(true, 'apply_outfit_'..system.thread_count(), function()
						local file = path:ensureend('\\')..v
						if not filesystem.exists(file) then utils.hud_sound("ERROR");system.notify(TRANSLATION["Error"], TRANSLATION["File doesn't exist"], settings.General["HudColorNotifyError"]) return POP_THREAD end 
						local ok, tabl = xpcall(function() return json:decode(filesystem.read_all(file)) end, function() system.notify(TRANSLATION["Error"], TRANSLATION["Invalid outfit"], settings.General["HudColorNotifyError"], true) end)
						if not ok then return POP_THREAD end
						if outfit_prev ~= options[name] then
							outfit_prev = options[name]
							this_outfit = parse(tabl)
							return POP_THREAD
						end
						ApplyOutfit(tabl)
						return POP_THREAD
					end)
				end)
			end
		end

		for k, v in pairs(options)
		do
			if not saved[k] then
				ui.remove(options[k])
				options[k] = nil
			end
		end
	end

	local sub_open
	system.thread(true, 'saved_outfits', function()
		if ui.is_sub_open(__submenus["SavedOutfits"]) and not sub_open then
			RefreshOutfits()
			sub_open = true
		elseif not ui.is_sub_open(__submenus["SavedOutfits"]) and sub_open then
			sub_open = false
		end
	end)

	ui.add_input_string(TRANSLATION["Search"], __submenus["SavedOutfits"], function(text)
		text = text:lower():escpattern()
		for k, v in pairs(options)
		do
			if k:lower():find(text) then
				ui.hide(v, false)
			else
				ui.hide(v, true)
			end
		end
	end)

	system.thread(true, 'self_outfit_prev', function()
		if not ui.is_sub_open(__submenus["SavedOutfits"]) then
			if Global.created_preview3 then
				entities.delete(Global.created_preview3)
				Global.created_preview3 = nil
				outfit_prev = nil
			end
			return
		end
		if not this_outfit then return end
		if ui.is_sub_open(__submenus["SavedOutfits"]) and outfit_prev ~= last_prev then
			last_prev = outfit_prev
			if Global.created_preview3 then
				entities.delete(Global.created_preview3)
				Global.created_preview3 = nil
			end
		end
		if not Global.created_preview3 then
			local loaded = features.request_model(ENTITY.GET_ENTITY_MODEL(features.player_ped()))
			if loaded == 0 then return end
			Global.created_preview3 = PED.CLONE_PED(features.player_ped(), false, false, false)
			peds.calm_ped(Global.created_preview3, true)
			peds.set_ped_god(Global.created_preview3)
			peds.set_can_ragdoll(Global.created_preview3, false)
			peds.apply_outfit(this_outfit.components, this_outfit.props, Global.created_preview3)
			ENTITY.SET_ENTITY_ROTATION(Global.created_preview3, 0, 0, features.get_final_cam_rot().z - 180, 2, true)
			ENTITY.SET_ENTITY_ALPHA(Global.created_preview3, 160, false)
			ENTITY.SET_ENTITY_COLLISION(Global.created_preview3, false, false)
		else
			if ENTITY.DOES_ENTITY_EXIST(Global.created_preview3) == 0 then Global.created_preview3 = nil return end
			features.request_control_once(Global.created_preview3)
			vehicles.set_godmode(Global.created_preview3, true)
			local model_dim_max, model_dim_max = features.get_model_dimentions(ENTITY.GET_ENTITY_MODEL(Global.created_preview3))
			local dir = features.get_final_cam_rot():rot_to_direction()
			local camcoord = features.get_final_cam_pos()
			local pos = camcoord + dir * 2
			ENTITY.SET_ENTITY_ALPHA(Global.created_preview3, 160, false)
			ENTITY.SET_ENTITY_COLLISION(Global.created_preview3, false, false)
			ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Global.created_preview3, pos.x, pos.y, pos.z, false, false, false)
			local rot = features.get_entity_rot(Global.created_preview3)
			ENTITY.SET_ENTITY_ROTATION(Global.created_preview3, 0, 0, rot.z - 2, 2, true)
		end
	end)

	__options.bool["ForceOutfit"] = ui.add_bool_option(TRANSLATION["Force outfit"], __submenus["Wardrobe"], function(bool)
		if utils.show_info("forceoutfit [on - off]") then ui.set_value(__options.bool["ForceOutfit"], not bool, true) return end
		if ui.get_value(__options.bool["GhostRiderOutfit"]) then ui.set_value(__options.bool["ForceOutfit"], false, true) return utils.hud_sound("ERROR") end
		utils.hud_sound("TOGGLE_ON")
		settings.Self['ForceOutfit'] = bool
		local model = tostring(ENTITY.GET_ENTITY_MODEL(features.player_ped()))
		if bool then
			if filesystem.exists(files['ForcedOutfit']) and not loaded then
				ok, outfit = xpcall(function() return json:decode(filesystem.read_all(files['ForcedOutfit'])) end, function() system.log('ERROR', 'Failed to load last outfit') end)
				if not ok or outfit.model ~= model then
					if outfit.model then outfit_for_model[outfit.model] = outfit end
					outfit = peds.get_outfit()
				end
			else
				outfit = peds.get_outfit()
			end
			outfit.model = outfit.model or model
			outfit_for_model[outfit.model] = outfit
			if NETWORK.NETWORK_IS_SESSION_STARTED() == 1 then filesystem.write(json:encode_pretty(outfit), files['ForcedOutfit']) end
		end
		system.thread(bool, 'self_force_outfit', function(tick)
			local ped = features.player_ped()
			if ENTITY.DOES_ENTITY_EXIST(ped) == 0 or ENTITY.IS_ENTITY_VISIBLE(features.player_ped()) == 0 or not features.has_loaded_in_session() then return end
			model = tostring(ENTITY.GET_ENTITY_MODEL(ped))
			if outfit.model ~= model then
				if outfit_for_model[model] then
					outfit = outfit_for_model[model]
				else
					outfit = peds.get_outfit()
					outfit.model = model
				end
			end
			if tick % 300 == 0 and NETWORK.NETWORK_IS_SESSION_STARTED() == 1 then filesystem.write(json:encode_pretty(outfit), files['ForcedOutfit']) end
			peds.apply_outfit(outfit.components, outfit.props)
		end)
	end, {"forceoutfit"})

	system.thread(true, system.thread_count(), function()
		loaded = true
		return POP_THREAD
	end)
	local disable_changes
	for i = 1, 12 do
		insert(drawables_names, TRANSLATION[enum.drawables[i]])

		system.register_command({"compvar"..enum.drawables[i]:gsub("%s", ""):lower()}, {
			type = "int",
			max = 1000,
			min = -1,
			step = 1,
			func = function(int)
				utils.hud_sound("YES")
				if settings.Self['ForceOutfit'] then
					outfit.components[tostring(i-1)][1] = int
					outfit.components[tostring(i-1)][2] = 0
				else
					if PED.IS_PED_COMPONENT_VARIATION_VALID(features.player_ped(), i-1, int, 0) == 0 then return end
					PED.SET_PED_COMPONENT_VARIATION(features.player_ped(), i-1, int, 0, 0)
				end
			end
		})
		system.register_command({"comptxt"..enum.drawables[i]:gsub("%s", ""):lower()}, {
			type = "int",
			max = 1000,
			min = -1,
			step = 1,
			func = function(int)
				utils.hud_sound("YES")
				if settings.Self['ForceOutfit'] then
					outfit.components[tostring(i-1)][2] = int
				else
					local drawable = PED.GET_PED_DRAWABLE_VARIATION(features.player_ped(), i-1)
					if PED.IS_PED_COMPONENT_VARIATION_VALID(features.player_ped(), i-1, drawable, int) == 0 then return end
					PED.SET_PED_COMPONENT_VARIATION(features.player_ped(), i-1, drawable, int, 0)
				end
			end
		})
	end
	__options.choose.component_choose = ui.add_choose(TRANSLATION["Component"], __submenus["Wardrobe"], true, drawables_names, function(int)
		disable_changes = false
		utils.hud_sound("YES")
	end)
	__options.num.component_id = ui.add_num_option(TRANSLATION["Variation"], __submenus["Wardrobe"], -1, 0, 1, function(int)
		if utils.show_info("compvar"..enum.drawables[ui.get_value(__options.choose.component_choose)+1]:gsub("%s", ""):lower().." [int]") then return end
		utils.hud_sound("YES")
		disable_changes = clock() + 2
		if settings.Self['ForceOutfit'] then
			local id = tostring(ui.get_value(__options.choose.component_choose))
			outfit.components[id][1] = int
			outfit.components[id][2] = 0
		else
			local id = ui.get_value(__options.choose.component_choose)
			--if PED.IS_PED_COMPONENT_VARIATION_VALID(features.player_ped(), id, int, 0) == 0 then return end
			PED.SET_PED_COMPONENT_VARIATION(features.player_ped(), id, int, 0, 0)
		end
	end)
	__options.num.texture_id = ui.add_num_option(TRANSLATION["Texture"], __submenus["Wardrobe"], -1, 0, 1, function(int)
		if utils.show_info("comptxt"..enum.drawables[ui.get_value(__options.choose.component_choose)+1]:gsub("%s", ""):lower().." [int]") then return end
		utils.hud_sound("YES")
		disable_changes = clock() + 2
		if settings.Self['ForceOutfit'] then
			local id = tostring(ui.get_value(__options.choose.component_choose))
			outfit.components[id][2] = int
		else
			local id =ui.get_value(__options.choose.component_choose)
			local drawable = PED.GET_PED_DRAWABLE_VARIATION(features.player_ped(), id)
			--if PED.IS_PED_COMPONENT_VARIATION_VALID(features.player_ped(), id, drawable, int) == 0 then return end
			PED.SET_PED_COMPONENT_VARIATION(features.player_ped(), id, drawable, int, 0)
		end
	end)
	for i = 1, 10 do
		insert(props_names, TRANSLATION[enum.props[i]] or enum.props[i])

		system.register_command({"propvar"..enum.props[i]:gsub("%s", ""):lower()}, {
			type = "int",
			max = 1000,
			min = -1,
			step = 1,
			func = function(int)
				utils.hud_sound("YES")
				if settings.Self['ForceOutfit'] then
					outfit.props[tostring(i-1)][1] = int
					outfit.props[tostring(i-1)][2] = 0
				else
					if int == - 1 then
						PED.CLEAR_PED_PROP(features.player_ped(), i-1)
					else
						PED.SET_PED_PROP_INDEX(features.player_ped(), i-1, int, 0, true)
					end
				end
			end
		})
		system.register_command({"proptxt"..enum.props[i]:gsub("%s", ""):lower()}, {
			type = "int",
			max = 1000,
			min = -1,
			step = 1,
			func = function(int)
				utils.hud_sound("YES")
				if settings.Self['ForceOutfit'] then
					outfit.props[tostring(i-1)][2] = int
				else
					local prop = PED.GET_PED_PROP_INDEX(features.player_ped(), i-1)
					if prop == -1 then return end
					PED.SET_PED_PROP_INDEX(features.player_ped(), i-1, prop, int, true)
				end
			end
		})
	end
	__options.choose.prop_choose = ui.add_choose(TRANSLATION["Prop"], __submenus["Wardrobe"], true, props_names, function(int)
		disable_changes = false
		utils.hud_sound("YES")
	end)
	__options.num.prop_id = ui.add_num_option(TRANSLATION["Variation"], __submenus["Wardrobe"], -1, 0, 1, function(int)
		if utils.show_info("propvar"..enum.props[ui.get_value(__options.choose.prop_choose)+1]:gsub("%s", ""):lower().." [int]") then return end
		utils.hud_sound("YES")
		disable_changes = clock() + 2
		if settings.Self['ForceOutfit'] then
			local id = tostring(ui.get_value(__options.choose.prop_choose))
			outfit.props[id][1] = int
			outfit.props[id][2] = 0
		else
			local id = ui.get_value(__options.choose.prop_choose)
			if int == - 1 then
				PED.CLEAR_PED_PROP(features.player_ped(), id)
			else
				PED.SET_PED_PROP_INDEX(features.player_ped(), id, int, 0, true)
			end
		end
	end)
	__options.num.proptexture_id = ui.add_num_option(TRANSLATION["Texture"], __submenus["Wardrobe"], 0, 0, 1, function(int)
		if utils.show_info("proptxt"..enum.props[ui.get_value(__options.choose.prop_choose)+1]:gsub("%s", ""):lower().." [int]") then return end
		utils.hud_sound("YES")
		disable_changes = clock() + 2
		if settings.Self['ForceOutfit'] then
			local id = tostring(ui.get_value(__options.choose.prop_choose))
			outfit.props[id][2] = int
		else
			local id = ui.get_value(__options.choose.prop_choose)
			local prop = PED.GET_PED_PROP_INDEX(features.player_ped(), id)
			if prop == -1 then return end
			PED.SET_PED_PROP_INDEX(features.player_ped(), id, prop, int, true)
		end
	end)

	system.thread(true, 'outfit_editor', function()
		if not ui.is_sub_open(__submenus["Wardrobe"]) then return end
		local ped = features.player_ped()
		local component_id = ui.get_value(__options.choose.component_choose)
		if not (disable_changes and disable_changes > clock()) then
			ui.set_value(__options.num.component_id, PED.GET_PED_DRAWABLE_VARIATION(ped, component_id), true)
			ui.set_value(__options.num.texture_id, PED.GET_PED_TEXTURE_VARIATION(ped, component_id), true)
		end
		ui.set_num_max(__options.num.component_id, PED.GET_NUMBER_OF_PED_DRAWABLE_VARIATIONS(ped, component_id) - 1)
		ui.set_num_max(__options.num.texture_id, PED.GET_NUMBER_OF_PED_TEXTURE_VARIATIONS(ped, component_id, PED.GET_PED_DRAWABLE_VARIATION(ped, component_id)) - 1)
		local prop_id = ui.get_value(__options.choose.prop_choose)
		if not (disable_changes and disable_changes > clock()) then
			ui.set_value(__options.num.prop_id, PED.GET_PED_PROP_INDEX(ped, prop_id), true)
			ui.set_value(__options.num.proptexture_id, PED.GET_PED_PROP_TEXTURE_INDEX(ped, prop_id), true)
		end
		ui.set_num_max(__options.num.prop_id, PED.GET_NUMBER_OF_PED_PROP_DRAWABLE_VARIATIONS(ped, prop_id) - 1)
		ui.set_num_max(__options.num.proptexture_id, PED.GET_NUMBER_OF_PED_PROP_TEXTURE_VARIATIONS(ped, prop_id, PED.GET_PED_PROP_INDEX(ped, prop_id)) - 1)
	end)
	RefreshOutfits()

	system.register_command({"outfit"}, {type = "choose", actions = Global.outfits, func = function(i, name)
		if not name then return utils.hud_sound("ERROR") end
		utils.hud_sound("SELECT")
		name = Global.outfits_keys[name]
		RefreshOutfits()
		system.thread(true, 'apply_outfit_'..system.thread_count(), function()
			local file = path:ensureend('\\')..name:ensureend(".json")
			if not filesystem.exists(file) then utils.hud_sound("ERROR");system.notify(TRANSLATION["Error"], TRANSLATION["File doesn't exist"], settings.General["HudColorNotifyError"]) return POP_THREAD end 
			local ok, tabl = xpcall(function() return json:decode(filesystem.read_all(file)) end, function() system.notify(TRANSLATION["Error"], TRANSLATION["Invalid outfit"], settings.General["HudColorNotifyError"], true) end)
			if not ok then return POP_THREAD end
			ApplyOutfit(tabl)
			return POP_THREAD
		end)
	end})
end

ui.add_separator(TRANSLATION["No clip"], __submenus["Self"])

__options.num["NoClipMultiplier"] = ui.add_float_option(TRANSLATION["No clip speed"], __submenus["Self"], 0.1, 20, .1, 1, function(float)
	if utils.show_info("noclipspeed [0.1 - 20.0]") then ui.set_value(__options.num["NoClipMultiplier"], settings.Self["NoClipMultiplier"], true) return end
	utils.hud_sound("YES") settings.Self["NoClipMultiplier"] = features.round(float, 1)
end, {"noclipspeed"})

__options.choose["NoClipType"] = ui.add_choose(TRANSLATION["No clip type"], __submenus["Self"], true, {TRANSLATION["Mouse"], TRANSLATION["Keyboard"], TRANSLATION["Allow control"]}, function(int)
	if utils.show_info("nocliptype [choose]") then ui.set_value(__options.choose["NoClipType"], settings.Self["NoClipType"], true) return end
	if settings.Self["NoClipType"] ~= int and ui.get_value(__options.bool["NoClip"]) and int == 1 and vehicles.get_player_vehicle() == 0 then
		local rot = features.get_entity_rot(features.player_ped())
		ENTITY.SET_ENTITY_ROTATION(features.player_ped(), 0, 0, rot.z + 180, 2, true)
	end
	settings.Self["NoClipType"] = int
	utils.hud_sound("YES")
end, {"nocliptype"})

__options.bool["NoClip"] = ui.add_bool_option(TRANSLATION["No clip"], __submenus["Self"], function(bool)
	if utils.show_info("noclip [on - off]") then ui.set_value(__options.bool["NoClip"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	if not bool then
		if vehicles.get_player_vehicle() ~= 0 then
			local Vehicle = vehicles.get_player_vehicle()
			entities.request_control(Vehicle, function()
				ENTITY.FREEZE_ENTITY_POSITION(features.player_ped(), false)
				ENTITY.FREEZE_ENTITY_POSITION(Vehicle, false)
				ENTITY.SET_ENTITY_COLLISION(Vehicle, true, true)
				features.set_entity_velocity(Vehicle, 0, 0, -0.0001)
			end)
		else
			local ped = features.player_ped()
			ENTITY.FREEZE_ENTITY_POSITION(ped, false)
			ENTITY.SET_ENTITY_COLLISION(ped, true, true)
			if settings.Self["NoClipType"] == 1 then
				local rot = features.get_entity_rot(ped)
				ENTITY.SET_ENTITY_ROTATION(ped, 0, 0, rot.z - 180, 2, true)
			end
			TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
		end
	else
		utils.no_sounds_this_frame()
		if __options.bool["FreeCam"] then
			ui.set_value(__options.bool["FreeCam"], false, false)
		end
		if vehicles.get_player_vehicle() == 0 then
			TASK.CLEAR_PED_TASKS_IMMEDIATELY(features.player_ped())
		end
		if settings.Self["NoClipType"] == 1 then
			local rot = features.get_entity_rot(features.player_ped())
			ENTITY.SET_ENTITY_ROTATION(features.player_ped(), 0, 0, rot.z - 180, 2, true)
		end
	end
	local previous = settings.Self["NoClipType"]
  	system.thread(bool, 'self_no_clip', function()
  		if Global.onscreen_keyboard then return end
	  	PAD.DISABLE_CONTROL_ACTION(0, enum.input.VEH_SUB_ASCEND, true)
		PAD.DISABLE_CONTROL_ACTION(0, enum.input.VEH_FLY_THROTTLE_UP, true)
		PAD.DISABLE_CONTROL_ACTION(0, enum.input.VEH_FLY_THROTTLE_DOWN, true)
		PAD.DISABLE_CONTROL_ACTION(0, enum.input.VEH_FLY_YAW_LEFT, true)
		PAD.DISABLE_CONTROL_ACTION(0, enum.input.VEH_FLY_YAW_RIGHT, true)
		PAD.DISABLE_CONTROL_ACTION(0, enum.input.VEH_PUSHBIKE_SPRINT, true)
		PAD.DISABLE_CONTROL_ACTION(0, enum.input.VEH_SUB_DESCEND, true)
	    local entself = features.player_ped()
	    local is_ped = true
	    if vehicles.get_player_vehicle() ~= 0 then
	    	is_ped = false
	    	entself = vehicles.get_player_vehicle()
	    	features.request_control_once(entself)
	    end 
	    if settings.Self["NoClipType"] == 1 then
	    	if vehicles.get_player_vehicle() == 0 then
	      		TASK.CLEAR_PED_TASKS_IMMEDIATELY(features.player_ped())
	     	end
		    local rot = features.get_entity_rot(entself)
		    ENTITY.SET_ENTITY_ROTATION(entself, 0, 0, rot.z, 2, true)
	    elseif settings.Self["NoClipType"] ~= 1 then
	        local rot = features.gameplay_cam_rot()
	        ENTITY.SET_ENTITY_ROTATION(entself, rot.x, rot.y, rot.z, 2, true)
	    end
	    ENTITY.FREEZE_ENTITY_POSITION(entself, true)
	    ENTITY.SET_ENTITY_COLLISION(entself, false, true)
	    local pos = vector3()
	    local key
	    local multiplier = settings.Self["NoClipMultiplier"]
	    if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.VEH_SUB_ASCEND) == 1 then
	        multiplier = settings.Self["NoClipMultiplier"] * 5
	    end
	    if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.VEH_FLY_THROTTLE_UP) == 1 then
	    	pos = pos + ((settings.Self["NoClipType"] == 1 and is_ped) and vector3.back(multiplier) or vector3.forward(multiplier))
	    	key = true
	    end
	    if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.VEH_FLY_THROTTLE_DOWN) == 1 then
			pos = pos + ((settings.Self["NoClipType"] == 1 and is_ped) and vector3.forward(multiplier) or vector3.back(multiplier))
	    	key = true
	    end
	    if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.VEH_FLY_YAW_LEFT) == 1 then
	    	if settings.Self["NoClipType"] ~= 1 then
		        pos = pos + vector3.left(multiplier)
		    else
		      	local rot = features.get_entity_rot(entself)
		      	ENTITY.SET_ENTITY_ROTATION(entself, 0, 0, rot.z + 2, 2, true)
	      	end
	    	key = true
	    end
	    if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.VEH_FLY_YAW_RIGHT) == 1 then
	    	if settings.Self["NoClipType"] ~= 1 then
		        pos = pos + vector3.right(multiplier)
		    else
		    	local rot = features.get_entity_rot(entself)
		      	ENTITY.SET_ENTITY_ROTATION(entself, 0, 0, rot.z - 2, 2, true)
	      	end
	    	key = true
	    end
	    pos = features.get_offset_from_entity_in_world_coords(entself, pos)
	    if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.VEH_PUSHBIKE_SPRINT) == 1 then
			pos = pos + vector3.up(multiplier)
	    	key = true
	    end
	    if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.VEH_SUB_DESCEND) == 1 then
	      	pos = pos + vector3.down(multiplier)
	    	key = true
	    end
	    if key then
	    	if previous == 0 and settings.Self["NoClipType"] == 1 and is_ped then
		    	local rot = features.get_entity_rot(entself)
			    ENTITY.SET_ENTITY_ROTATION(entself, 0, 0, rot.z - 180, 2, true)
		    end
	    	if settings.Self["NoClipType"] == 0 and is_ped then
	    		local rot = features.gameplay_cam_rot()
	       		ENTITY.SET_ENTITY_ROTATION(entself, -rot.x, rot.y, rot.z - 180, 2, true)
	    	end
	    	if settings.Self["NoClipType"] ~= 2 or not is_ped then
	    		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(entself, pos.x, pos.y, pos.z, false, false, false)
	    	else
	    		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(entself, pos.x, pos.y, pos.z, true, true, true)
	    	end
	    end
	    previous = settings.Self["NoClipType"]
	    if settings.General["ShowControls"] and Instructional:New() then
	    	Instructional.AddButton(enum.input.VEH_SUB_ASCEND, TRANSLATION["Faster"])
	    	Instructional.AddButton(enum.input.VEH_FLY_THROTTLE_UP, TRANSLATION["Forward"])
	    	Instructional.AddButton(enum.input.VEH_FLY_THROTTLE_DOWN, TRANSLATION["Backward"])
	    	Instructional.AddButton(enum.input.VEH_FLY_YAW_LEFT, TRANSLATION["Left"])
	    	Instructional.AddButton(enum.input.VEH_FLY_YAW_RIGHT, TRANSLATION["Right"])
	    	Instructional.AddButton(enum.input.VEH_PUSHBIKE_SPRINT, TRANSLATION["Up"])
	    	Instructional.AddButton(enum.input.VEH_SUB_DESCEND, TRANSLATION["Down"])
	    	Instructional:BackgroundColor(0, 0, 0, 80)
	    	Instructional:Draw()
	    end
  	end)
end, {"noclip"})

ui.add_separator(TRANSLATION["Useful"], __submenus["Self"])

__options.bool["Godmode"] = ui.add_bool_option(TRANSLATION["Godmode"], __submenus["Self"], function(bool)
	if utils.show_info("godmode [on - off]", "Makes you unable to die") then ui.set_value(__options.bool["Godmode"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Self["Godmode"] = bool
	system.thread(bool, 'self_god', function()
		local ped = features.player_ped()
		if ENTITY.IS_ENTITY_DEAD(features.player_ped(), false) == 1 then return end
		local health = PED.GET_PED_MAX_HEALTH(ped)
    	ENTITY.SET_ENTITY_HEALTH(ped, health, 0)
		local addr = s_memory.get_memory_address(s_memory.WorldPtr, s_memory.offsets.godmode)
		if addr == 0 then return end
		memory.write_byte(addr, 1)
	end)
	if not bool then
		features.set_godmode(features.player_ped(), false)
	end
end, {"godmode"})

__options.bool["DemiGod"] = ui.add_bool_option(TRANSLATION["Demi-god"], __submenus["Self"], function(bool)
	if utils.show_info("demigod [on - off]") then ui.set_value(__options.bool["DemiGod"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Self["DemiGod"] = bool
	local maxhealth = 328
	if bool then
		maxhealth = PED.GET_PED_MAX_HEALTH(features.player_ped())
	end
	system.thread(bool, 'self_demi_god', 
	function()
		local ped = features.player_ped()
		PED.SET_PED_MAX_HEALTH(ped, 10000)
	    ENTITY.SET_ENTITY_HEALTH(ped, 10000, 0)
	    ENTITY.SET_ENTITY_PROOFS(ped, true, true, true, true, true, true, true, true)
	    ENTITY.SET_ENTITY_MAX_HEALTH(ped, 10000)
	end)
	if not bool then
		local ped = features.player_ped()
		PED.SET_PED_MAX_HEALTH(ped, maxhealth)
	    ENTITY.SET_ENTITY_HEALTH(ped, maxhealth, 0)
	    ENTITY.SET_ENTITY_PROOFS(ped, false, false, false, false, false, false, false, false)
	end
end, {"demigod"})

__options.bool["NoRagdoll"] = ui.add_bool_option(TRANSLATION["No ragdoll"], __submenus["Self"], function(bool)
	if utils.show_info("noragdoll [on - off]", "Prevents you from ragdoll") then ui.set_value(__options.bool["NoRagdoll"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Self["NoRagdoll"] = bool
	local ped = features.player_ped()
	if not bool then
		PED.SET_PED_CAN_RAGDOLL(ped, true)
		PED.SET_PED_CAN_RAGDOLL_FROM_PLAYER_IMPACT(ped, true)
	end
	system.thread(bool, 'self_no_ragdoll', function()
		ped = features.player_ped()
		PED.SET_PED_CAN_RAGDOLL(ped, false)
		PED.SET_PED_CAN_RAGDOLL_FROM_PLAYER_IMPACT(ped, false)
	end)
end, {"noragdoll"})

__options.bool["AutoClean"] = ui.add_bool_option(TRANSLATION["Auto clean"], __submenus["Self"], function(bool)
	if utils.show_info("clean [on - off]", "Clears your ped damage and blood") then ui.set_value(__options.bool["AutoClean"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Self["AutoClean"] = bool
	system.thread(bool, 'self_auto_clean', function()
		local ped = features.player_ped()
		PED.CLEAR_PED_BLOOD_DAMAGE(ped)
		PED.RESET_PED_VISIBLE_DAMAGE(ped)
		WEAPON.CLEAR_PED_LAST_WEAPON_DAMAGE(ped)
		PED.CLEAR_PED_ENV_DIRT(ped)
		PED.CLEAR_PED_DECORATIONS(ped)
	end)
end, {"clean"})

do
	local onwater
	__options.bool["WalkOnWater"] = ui.add_bool_option(TRANSLATION["Walk on water"], __submenus["Self"], function(bool)
		if utils.show_info("walkonwater [on - off]", "Allows you to walk and drive on water") then ui.set_value(__options.bool["WalkOnWater"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON")
		settings.Self["WalkOnWater"] = bool
		if not bool then
		    features.delete_entity(onwater)
		    onwater = nil
		    features.unload_models(utils.joaat("stt_prop_stunt_bblock_huge_01"))
		    MISC.WATER_OVERRIDE_SET_STRENGTH(0)
		end
		system.thread(bool, 'self_walk_on_water', function()
			MISC.WATER_OVERRIDE_SET_STRENGTH(1)
			local loaded, hash = features.request_model("stt_prop_stunt_bblock_huge_01")
			if loaded == 0 then return end
			local ped = features.player_ped()
		    local veh = vehicles.get_player_vehicle()
		    local pos = features.get_player_coords()
		    local found, Z = features.get_water_z(pos)
		    local vel = ENTITY.GET_ENTITY_VELOCITY(veh)
		    local model = ENTITY.GET_ENTITY_MODEL(veh)
		    if VEHICLE.IS_THIS_MODEL_A_BOAT(model) == 1 or VEHICLE.IS_THIS_MODEL_A_JETSKI(model) == 1 then
		    	found = false
		    elseif found then
		      if not onwater or ENTITY.DOES_ENTITY_EXIST(onwater) == 0 then
		        onwater = features.create_object(hash, vector3(pos.x, pos.y, Z - .2))
		        ENTITY.SET_ENTITY_VISIBLE(onwater, false, false)
		      end
		      if Z > pos.z then
		      	features.teleport2(ped, pos.x, pos.y, Z + 1)
		      else
				features.teleport(onwater, pos.x, pos.y, Z - .2)
		      end
		    end
		    if not found and onwater then
				features.delete_entity(onwater)
				onwater = nil
		    end
		end)
	end, {"walkonwater"})
end

__options.bool["DisableCollision"] = ui.add_bool_option(TRANSLATION["Disable collision"], __submenus["Self"], function(bool)
	if utils.show_info("nocollision [on - off]", "Disables your ped collision") then ui.set_value(__options.bool["DisableCollision"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	system.thread(bool, 'self_no_collision', function(tick)
		ENTITY.SET_ENTITY_COLLISION(features.player_ped(), false, true)
	end)
	if not bool then ENTITY.SET_ENTITY_COLLISION(features.player_ped(), true, true) end
end, {"nocollision"})

__options.bool["PedsIgnorePlayer"] = ui.add_bool_option(TRANSLATION["Peds ignore player"], __submenus["Self"], function(bool)
	if utils.show_info("pedsignore [on - off]", "All peds will ignore you") then ui.set_value(__options.bool["PedsIgnorePlayer"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Self['PedsIgnorePlayer'] = bool
	system.thread(bool, 'self_peds_ignore', function(tick)
		if tick%10~=0 then return end
		for _, ped in ipairs(entities.get_peds())
		do
			peds.calm_ped(ped, true)
		end
		PLAYER.SET_POLICE_IGNORE_PLAYER(PLAYER.PLAYER_ID(), true)
		PLAYER.SET_EVERYONE_IGNORE_PLAYER(PLAYER.PLAYER_ID(), true)
		PLAYER.SET_PLAYER_CAN_BE_HASSLED_BY_GANGS(PLAYER.PLAYER_ID(), false)
		PLAYER.SET_IGNORE_LOW_PRIORITY_SHOCKING_EVENTS(PLAYER.PLAYER_ID(), true)
	end)

	if not bool then
		PLAYER.SET_POLICE_IGNORE_PLAYER(PLAYER.PLAYER_ID(), false)
		PLAYER.SET_EVERYONE_IGNORE_PLAYER(PLAYER.PLAYER_ID(), false)
		PLAYER.SET_PLAYER_CAN_BE_HASSLED_BY_GANGS(PLAYER.PLAYER_ID(), true)
		PLAYER.SET_IGNORE_LOW_PRIORITY_SHOCKING_EVENTS(PLAYER.PLAYER_ID(), false)
		for _, ped in ipairs(entities.get_peds())
		do
			peds.calm_ped(ped, false)
		end
	end
end, {"pedsignore"})

__options.bool["LinkHeading"] = ui.add_bool_option(TRANSLATION["Link heading with camera"], __submenus["Self"], function(bool)
	if utils.show_info("linkheading [on - off]", "Your ped will always face\nwhere you point the camera") then ui.set_value(__options.bool["LinkHeading"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Self['LinkHeading'] = bool
	system.thread(bool, 'self_link_heading', function()
		if vehicles.get_player_vehicle() ~= 0 then return end
		ENTITY.SET_ENTITY_HEADING(features.player_ped(), features.gameplay_cam_rot().z)
	end)
end, {"linkheading"})

__options.bool["PlayerVisibleLocaly"] = ui.add_bool_option(TRANSLATION["Player visible locally"], __submenus["Self"], function(bool)
	if utils.show_info("localvisible [on - off]", "Makes your ped invisible for other players") then ui.set_value(__options.bool["PlayerVisibleLocaly"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Self['PlayerVisibleLocaly'] = bool
	if not bool then ENTITY.SET_ENTITY_VISIBLE(features.player_ped(), true, false) end
	system.thread(bool, 'self_visible_local', function()
		if NETWORK.NETWORK_IS_SESSION_STARTED() == 0 then return end
		ENTITY.SET_ENTITY_VISIBLE(features.player_ped(), false, false)
		NETWORK.SET_PLAYER_VISIBLE_LOCALLY(PLAYER.PLAYER_ID(), true)
	end)
end, {"localvisible"})

__options.bool["AlwaysDry"] = ui.add_bool_option(TRANSLATION["Always dry"], __submenus["Self"], function(bool)
	if utils.show_info("alwatsdry [on - off]", "Makes your ped dry") then ui.set_value(__options.bool["AlwaysDry"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Self['AlwaysDry'] = bool
	if bool and settings.Self['MakeMeWet'] then utils.no_sounds_this_frame();ui.set_value(__options.bool["MakeMeWet"], false, false)  end
	system.thread(bool, 'self_dry', function()
		PED.CLEAR_PED_WETNESS(features.player_ped())
	end)
end, {"alwatsdry"})

__options.bool["MakeMeWet"] = ui.add_bool_option(TRANSLATION["Make me wet"], __submenus["Self"], function(bool)
	if utils.show_info("makemewet [on - off]", "Makes your ped wet") then ui.set_value(__options.bool["MakeMeWet"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Self['MakeMeWet'] = bool
	if bool and settings.Self['AlwaysDry'] then utils.no_sounds_this_frame();ui.set_value(__options.bool["AlwaysDry"], false, false) end
	if not bool then PED.CLEAR_PED_WETNESS(features.player_ped()) end
	system.thread(bool, 'self_make_me_wet', function()
		PED.SET_PED_WETNESS_HEIGHT(features.player_ped(), 1)
		PED.SET_PED_WETNESS_ENABLED_THIS_FRAME(features.player_ped())
	end)
end, {"makemewet"})

ui.add_separator(TRANSLATION["Fun"], __submenus["Self"])

__options.bool["SuperPunch"] = ui.add_bool_option(TRANSLATION["Super punch"], __submenus["Self"], function(bool)
	if utils.show_info("superpunch [on - off]", "Gives abillity to punch vehicles, peds, etc.") then ui.set_value(__options.bool["SuperPunch"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Weapons["SuperPunch"] = bool
	Global.super_punch = nil
	local result
	local wait
	local playing
	local anim_dict = "melee@thrown@streamed_core"
	local anim_name = "plyr_takedown_rear"
	local anim_dict_2 = "melee@unarmed@streamed_core_psycho"
	local anim_name_air = "plyr_psycho_rear_takedown_b"
	local anim_name_kick = "ground_attack_0_long_psycho"
	local anim_name_backhand = "plyr_psycho_front_takedown_b"
	if not bool then
		peds.set_can_ragdoll(features.player_ped(), true)
		STREAMING.REMOVE_ANIM_DICT(anim_dict)
		STREAMING.REMOVE_ANIM_DICT(anim_dict_2)
		STREAMING.REMOVE_NAMED_PTFX_ASSET("scr_trevor1")
	end
	system.thread(bool, 'weapons_super_punch', function()
		peds.set_can_ragdoll(features.player_ped(), false)
		if STREAMING.HAS_ANIM_DICT_LOADED(anim_dict) == 0 then
			STREAMING.REQUEST_ANIM_DICT(anim_dict)
			return
		end
		if STREAMING.HAS_ANIM_DICT_LOADED(anim_dict_2) == 0 then
			STREAMING.REQUEST_ANIM_DICT(anim_dict_2)
			return
		end
		if STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_trevor1") == 0 then
			STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_trevor1")
			return
		end
		local addr = s_memory.get_memory_address(s_memory.WorldPtr, s_memory.offsets.run_speed_mult)
		if addr ~= 0 then
			memory.write_float(addr, ui.get_value(__options.num["RunSpeed"]))
		end
		if wait and wait > clock() then features.set_entity_velocity(features.player_ped(), 0, 0, -0.001) return end
		wait = nil
		if PAD.IS_DISABLED_CONTROL_RELEASED(0, enum.input.ATTACK2) == 1 then Global.super_punch = nil end
		if vehicles.get_player_vehicle() ~= 0 or features.get_ped_weapon() ~= -1569615261 or Global.mind_controll or Global.free_cam then return end
		PAD.DISABLE_CONTROL_ACTION(0, enum.input.ATTACK, true)
		if result and not playing and PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.ATTACK) == 1 and features.get_entity_coords(result.hitEntity):sqrlen(features.get_player_coords()) < 27 + select(2, features.get_model_dimentions(ENTITY.GET_ENTITY_MODEL(result.hitEntity))).y ^ 2 then
			local is_in_air = ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(result.hitEntity) > 5 + select(2, features.get_model_dimentions(ENTITY.GET_ENTITY_MODEL(result.hitEntity))).z
			local _wait = clock() + .6
			local bone = 0xdead
			local back_hand
			local is_ped = ENTITY.IS_ENTITY_A_PED(result.hitEntity) == 1
			PED.SET_PED_CAN_RAGDOLL_FROM_PLAYER_IMPACT(result.hitEntity, false)
			if not is_ped and features.get_player_coords().z > features.get_entity_coords(result.hitEntity).z + select(2, features.get_model_dimentions(ENTITY.GET_ENTITY_MODEL(result.hitEntity))).z / 2 then
				bone = 0xcc4d
				_wait = clock() + .9
				peds.play_anim(features.player_ped(), anim_dict_2, anim_name_kick, 8, -8, 1600, enum.anim_flag.AllowPlayerControl, 0, false)			
			elseif not is_ped and is_in_air then
				peds.play_anim(features.player_ped(), anim_dict_2, anim_name_air, 8, -8, 1000, enum.anim_flag.AllowPlayerControl, 0, false)
			elseif not is_ped and features.get_player_coords().z < features.get_entity_coords(result.hitEntity).z then
				_wait = clock() + 1
				back_hand = true
				peds.play_anim(features.player_ped(), anim_dict_2, anim_name_backhand, 8, -8, 1800, enum.anim_flag.AllowPlayerControl, 0, false)
			else
				peds.play_anim(features.player_ped(), anim_dict, anim_name, 8, -8, 1000, 0, 0, false)
			end
			playing = true
			system.thread(true, 'hit_entity', function(tick)
				if not Global.super_punch then
					TASK.CLEAR_PED_TASKS_IMMEDIATELY(features.player_ped())
					playing = nil
					result = nil
					return POP_THREAD
				end
				if tick%10 == 0 then
					GRAPHICS.USE_PARTICLE_FX_ASSET("scr_trevor1")
					GRAPHICS._START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY_BONE("scr_trev1_trailer_boosh", features.player_ped(), 0, 0, 0, 0, 0, 0, PED.GET_PED_BONE_INDEX(features.player_ped(), bone), .3, false, false, false)
				end
				if _wait > clock() then return end
				local force_mul = 200
				if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.AIM) == 0 then
					if is_in_air then
						features.set_entity_velocity(features.player_ped(), 0, 0, -10)
					else
						wait = clock() + .5
					end
					if is_ped then
						PED.SET_PED_CAN_RAGDOLL(result.hitEntity, true)
						PED.SET_PED_TO_RAGDOLL(result.hitEntity, 5000, 5000, 0, true, true, false)
					end
					Global.super_punch = nil
				else
					force_mul = 100
					wait = clock() + .2
				end
				playing = nil
				entities.request_control(result.hitEntity, function()
					local rot = features.get_entity_rot(features.player_ped())
					local force = is_in_air and vector3(0, 0, -force_mul) or back_hand and rot:rot_to_direction() * force_mul + vector3.up(50) or rot:rot_to_direction() * force_mul
					ENTITY.FREEZE_ENTITY_POSITION(result.hitEntity, false)
					features.set_entity_velocity(result.hitEntity, force.x, force.y, force.z)
				end)
				return POP_THREAD
			end)
			return
		end

		local impact = features.get_bullet_impact()
		if impact ~= vector3.zero() then
			local ent = features.get_closest_entity_to_coord(impact, 49)
			entities.request_control(ent, function()
				if ENTITY.IS_ENTITY_A_PED(ent) == 1 then
					PED.SET_PED_CAN_RAGDOLL(ent, true)
					PED.SET_PED_TO_RAGDOLL(ent, 5000, 5000, 0, true, true, false)
				end
				local rot = features.get_entity_rot(features.player_ped())
				local force = rot:rot_to_direction() * 50
				ENTITY.FREEZE_ENTITY_POSITION(ent, false)
				features.set_entity_velocity(ent, force.x, force.y, force.z)
			end)
		end

		if not Global.super_punch then
			local start = features.gameplay_cam_pos()
			local end_pos = start + features.gameplay_cam_rot():rot_to_direction() * 300
			result = features.get_raycast_result(start, end_pos, features.player_ped(), 2+4+8)
			if not result.didHit then return end
			local pos = features.get_entity_coords(result.hitEntity)
			if pos == vector3.zero() or pos:sqrlen(features.get_player_coords()) > 90000 then return end
			local my_pos = features.get_player_coords()
			GRAPHICS.DRAW_LINE(my_pos.x, my_pos.y, my_pos.z, pos.x, pos.y, pos.z, 0, 100, 255, 255)
			features.draw_box_on_entity(result.hitEntity, 0, 100, 255, 255)
			if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.ATTACK) == 0 then return end
			Global.super_punch = true
		else
			local my_pos = features.get_player_coords()
			local pos = features.get_entity_coords(result.hitEntity)
			GRAPHICS.DRAW_LINE(my_pos.x, my_pos.y, my_pos.z, pos.x, pos.y, pos.z, 255, 0, 0, 255)
			features.draw_box_on_entity(result.hitEntity, 255, 0, 0, 255)
			if addr ~= 0 then
				memory.write_float(addr, 5)
			end
			local speed = 16
			features.set_entity_face_entity(features.player_ped(), result.hitEntity)
			features.oscillate_to_coord(features.player_ped(), pos + vector3.down(.4), speed)
		end
	end)
end, {"superpunch"})

__options.bool["BeastMode"] = ui.add_bool_option(TRANSLATION["Beast mode"], __submenus["Self"], function(bool)
	if utils.show_info("beastmode [on - off]", "Gives you super jump and applies beast movement") then ui.set_value(__options.bool["BeastMode"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Self["BeastMode"] = bool
	system.thread(bool, 'self_beast', function()
		MISC._SET_BEAST_MODE_ACTIVE(PLAYER.PLAYER_ID())
		MISC.SET_SUPER_JUMP_THIS_FRAME(PLAYER.PLAYER_ID())
	end)
end, {"beastmode"})

do
	local anim_dict = "rcmbarry"
	local anim_name_idle = "bar_1_attack_idle_aln"
	local anim_name_intro = "bar_1_attack_intro_aln"
	local anim_name_finish = "bar_1_attack_alien_wins_aln"
	local delay = 0
	local entry_time
	local idle
	local controlled_entities = {}
	__options.bool["MindControl"] = ui.add_bool_option(TRANSLATION["Mind control"], __submenus["Self"], function(bool)
		if utils.show_info("mindcontrol [on - off]", "Allows you to control entities with your mind") then ui.set_value(__options.bool["MindControl"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON")
		settings.Self["MindControl"] = bool
		if not bool then
			Global.mind_controll = false
			if idle then
				TASK.CLEAR_PED_TASKS_IMMEDIATELY(features.player_ped())
				ENTITY.FREEZE_ENTITY_POSITION(features.player_ped(), false)
				STREAMING.REMOVE_ANIM_DICT(anim_dict)
				idle = nil
				entry_time = nil
				controlled_entities = {}
			end
		else
			delay = 0
			entry_time = nil
			idle = nil
		end
		system.thread(bool, 'self_mind_control', function()
  			if Global.onscreen_keyboard then return end

			if STREAMING.HAS_ANIM_DICT_LOADED(anim_dict) == 0 then
				STREAMING.REQUEST_ANIM_DICT(anim_dict)
				return
			end
			if delay > clock() or ENTITY.DOES_ENTITY_EXIST(features.player_ped()) == 0 or vehicles.get_player_vehicle() ~= 0 or ENTITY.IS_ENTITY_IN_AIR(features.player_ped()) == 1 or Global.super_punch or Global.free_cam then idle = nil;entry_time = nil;return end
			PAD.DISABLE_CONTROL_ACTION(0, enum.input.SPECIAL_ABILITY_SECONDARY, true)
			if not entry_time and PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, enum.input.SPECIAL_ABILITY_SECONDARY) == 1 then
				peds.play_anim(features.player_ped(), anim_dict, anim_name_intro, 8, -8, -1, enum.anim_flag.AllowPlayerControl, 0, false)
				entry_time = clock() + ENTITY.GET_ANIM_DURATION(anim_dict, anim_name_intro) - .25 -- for smooth transition
			elseif entry_time and entry_time < clock() then
				if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.SPECIAL_ABILITY_SECONDARY) == 1 then
					peds.play_anim(features.player_ped(), anim_dict, anim_name_idle, 8, -8, -1, enum.anim_flag.Loop, 0, false)
					idle = true
				end
				entry_time = nil
			elseif idle and PAD.IS_DISABLED_CONTROL_JUST_RELEASED(0, enum.input.SPECIAL_ABILITY_SECONDARY) == 1 then
				if controlled_entities then
					for v in pairs(controlled_entities)
					do
						entities.request_control(v, function()
							if ENTITY.IS_ENTITY_A_PED(v) == 1 then
								PED.SET_PED_CAN_RAGDOLL(v, true)
								PED.SET_PED_TO_RAGDOLL(v, 5000, 5000, 0, true, true, false)
							end
							features.apply_force_to_entity(v, 1, 0, 0, -500, 0, 0, 0, 0, true, false, true, false, true)
						end)
					end
					controlled_entities = {}
				end
				TASK.STOP_ANIM_TASK(features.player_ped(),  anim_dict, anim_name_idle, -2)
				idle = nil
				delay = clock() + .5
			end
			if idle or entry_time then
				if idle and ENTITY.IS_ENTITY_PLAYING_ANIM(features.player_ped(), anim_dict, anim_name_idle, 3) == 0 then
					peds.play_anim(features.player_ped(), anim_dict, anim_name_idle, 8, -8, -1, enum.anim_flag.Loop, 1, false)
				end
				ENTITY.FREEZE_ENTITY_POSITION(features.player_ped(), true)
				Global.mind_controll = true
				ENTITY.SET_ENTITY_HEADING(features.player_ped(), features.gameplay_cam_rot().z)
				local pos_to = features.gameplay_cam_pos() + features.gameplay_cam_rot():rot_to_direction() * 30
				local pos = features.get_player_coords()
				controlled_entities = {}
				for _, v in ipairs(features.get_entities(true))
				do
					if ENTITY.IS_ENTITY_ON_SCREEN(v) == 1 and features.get_entity_coords(v):sqrlen(pos) < 25000 then
						controlled_entities[v] = true
						entities.request_control(v, function()
							if ENTITY.IS_ENTITY_A_PED(v) == 1 then
								PED.SET_PED_CAN_RAGDOLL(v, true)
								PED.SET_PED_TO_RAGDOLL(v, 5000, 5000, 0, true, true, false)
							end
							features.oscillate_to_coord(v, pos_to, .3)
						end)
					end
				end
			else
				ENTITY.FREEZE_ENTITY_POSITION(features.player_ped(), false)
				Global.mind_controll = false
				controlled_entities = {}
			end
			if settings.General["ShowControls"] and Instructional:New() then
				Instructional.AddButton(enum.input.SPECIAL_ABILITY_SECONDARY, TRANSLATION["Mind control"])
				Instructional:BackgroundColor(0, 0, 0, 80)
				Instructional:Draw()
			end
		end)
	end, {"mindcontrol"})
end

__options.bool["FlyMode"] = ui.add_bool_option(TRANSLATION["Fly-mode"], __submenus["Self"], function(bool)
	if utils.show_info("flymode [on - off]", "Allows you to fly like superman") then ui.set_value(__options.bool["FlyMode"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Self["FlyMode"] = bool
	local in_air
	local started
	local wait_time
	local force
	if not bool then
		STREAMING.REMOVE_ANIM_DICT('missheistfbi3b_ig6_v2')
		STREAMING.REMOVE_ANIM_DICT('missexile1_cargoplanejumpout')
		PED.SET_PED_CAN_RAGDOLL(features.player_ped(), true)
	end

	system.thread(bool, 'self_flymode', function()
  		if Global.onscreen_keyboard then return end

		if STREAMING.HAS_ANIM_DICT_LOADED('missheistfbi3b_ig6_v2') == 0 then
			STREAMING.REQUEST_ANIM_DICT('missheistfbi3b_ig6_v2')
			return
		end
		if STREAMING.HAS_ANIM_DICT_LOADED('missexile1_cargoplanejumpout') == 0 then
			STREAMING.REQUEST_ANIM_DICT('missexile1_cargoplanejumpout')
			return
		end
		if vehicles.get_player_vehicle() ~= 0 or Global.super_punch or Global.free_cam or Global.mind_controll then return end
		PED.SET_PED_CAN_RAGDOLL(features.player_ped(), false)
		PAD.DISABLE_CONTROL_ACTION(0, enum.input.JUMP, true)
		local ped = features.player_ped()
		if ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(ped) == 1 or ENTITY.IS_ENTITY_IN_AIR(ped) == 0 then
			if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.JUMP) == 1 and not wait_time then
				peds.play_anim(ped, 'missexile1_cargoplanejumpout', 'jump_launch_l_to_skydive', 4, -4, -1, 0, 0, false)
				wait_time = clock() + .7
				started = nil
				force = true
			end
			if in_air and ENTITY.IS_ENTITY_IN_AIR(ped) ~= 0 and started then
				local vel = vector3(ENTITY.GET_ENTITY_VELOCITY(ped))
				TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
				if vel:abs() > vector3.right(8) or vel:abs() > vector3.forward(8) then
					peds.play_anim(ped, 'missheistfbi3b_ig6_v2', 'rubble_slide_alt_franklin', 4, -4, 1000, 0, 0, false)
					local vel = vector3.zero():direction_to(vel) * 70
					features.set_entity_velocity(ped, vel.x, vel.y, 0)
					in_air = nil
				end
			end
			if started then return end
		end
		if wait_time and wait_time < clock() and force then
			features.apply_force_to_entity(ped, 1, 0, 0, 20, 0, 0, 0, 0, true, false, true, false, true)
			force = nil
			return
		elseif wait_time and wait_time + .2 > clock() then
			return
		elseif not started and wait_time then
			TASK.TASK_SKY_DIVE(ped, true)
			started = true
			wait_time = nil
		end
		if not started then return end
		if PED.IS_PED_IN_PARACHUTE_FREE_FALL(ped) == 0 then TASK.TASK_SKY_DIVE(ped, true) end
		in_air = true
		if PAD.IS_CONTROL_PRESSED(0, enum.input.VEH_FLY_THROTTLE_UP) == 1 then
      features.apply_force_to_entity(ped, 1, 0, 1, 0, 0, 0, 0, 0, true, false, true, false, true)
    end
    if PAD.IS_CONTROL_PRESSED(0, enum.input.VEH_FLY_THROTTLE_DOWN) == 1 then
      features.apply_force_to_entity(ped, 1, 0, 10, 0, 0, 0, 0, 0, true, false, true, false, true)
    end
    if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.JUMP) == 1 then
      features.apply_force_to_entity(ped, 1, 0, 0, 10, 0, 0, 0, 0, true, false, true, false, true)
    end
    if PAD.IS_CONTROL_PRESSED(0, enum.input.VEH_MOVE_UD) == 1 then
      features.apply_force_to_entity(ped, 1, 0, 0, -10, 0, 0, 0, 0, true, false, true, false, true)
    end
    if PAD.IS_CONTROL_PRESSED(0, enum.input.VEH_MOVE_UP_ONLY) == 1 then
      local vel = vector3(ENTITY.GET_ENTITY_VELOCITY(ped))
      local final = (vector3.zero():direction_to(vel) * 10)
      features.set_entity_velocity(ped, final.x, final.y, final.z)
    end
	  if settings.General["ShowControls"] and Instructional:New() then
    	Instructional.AddButton(enum.input.VEH_FLY_THROTTLE_UP, TRANSLATION["Forwards & down"])
    	Instructional.AddButton(enum.input.VEH_FLY_THROTTLE_DOWN, TRANSLATION["Forward"])
    	Instructional.AddButton(enum.input.JUMP, TRANSLATION["Up"])
    	Instructional.AddButton(enum.input.VEH_MOVE_UD, TRANSLATION["Down"])
    	Instructional.AddButton(enum.input.VEH_MOVE_UP_ONLY, TRANSLATION["Slow down"])
    	Instructional:BackgroundColor(0, 0, 0, 80)
    	Instructional:Draw()
    end
	end)
end, {"flymode"})

__options.num["WantedLevel"] = ui.add_num_option(TRANSLATION["Wanted level"], __submenus["Self"], 0, 5, 1, function(int)
	if utils.show_info("setwanted [0 - 5]", "Set your wanted level") then ui.set_value(__options.num["WantedLevel"], settings.Self["WantedLevel"], true) return end
	utils.hud_sound("YES")
	settings.Self["WantedLevel"] = int
	local addr = s_memory.get_memory_address(s_memory.WorldPtr, s_memory.offsets.wanted_level)
	if addr == 0 then return end
	memory.write_int(addr, int)
end, {"setwanted"})

__options.bool["LockWantedLevel"] = ui.add_bool_option(TRANSLATION["Lock wanted level"], __submenus["Self"], function(bool)
	if utils.show_info("lockwanted [on - off]", "Prevents your wanted level from change") then ui.set_value(__options.bool["LockWantedLevel"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Self["LockWantedLevel"] = bool
	if not bool then
		PLAYER.SET_MAX_WANTED_LEVEL(5)
	end
	system.thread(bool, 'lockwanted', function()
		local addr = s_memory.get_memory_address(s_memory.WorldPtr, s_memory.offsets.wanted_level)
		if addr == 0 then return end
		memory.write_int(addr, settings.Self["WantedLevel"])
		PLAYER.SET_MAX_WANTED_LEVEL(settings.Self["WantedLevel"])
	end)
end, {"lockwanted"})

__options.num["FakeWantedLevel"] = ui.add_num_option(TRANSLATION["Fake wanted level"], __submenus["Self"], 0, 6, 1, function(int)
	if utils.show_info("fakewanted [0 - 6]", "Shows wanted stars and flashes on the minimap") then ui.set_value(__options.num["FakeWantedLevel"], settings.Self["FakeWantedLevel"], true) return end
	utils.hud_sound("YES")
	settings.Self["FakeWantedLevel"] = int
	system.thread(true, "fake_wanted_level", function()
		local addr = s_memory.get_memory_address(s_memory.WorldPtr, s_memory.offsets.wanted_level_display)
		if addr == 0 then return end
		memory.write_int(addr, settings.Self["FakeWantedLevel"])
		-- if int == 0 then return POP_THREAD end
		-- if MISC.GET_FAKE_WANTED_LEVEL() == int then return end
		-- MISC.SET_FAKE_WANTED_LEVEL(int)
	end)
end, {"fakewanted"})

__options.bool["PoliceMode"] = ui.add_bool_option(TRANSLATION["Police mode"], __submenus["Self"], function(bool)
	if utils.show_info("policemode [on - off]", "All nearby vehicles will pullover") then ui.set_value(__options.bool["PoliceMode"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Self['PoliceMode'] = bool
	system.thread(bool, 'self_police_mode', function()
		local veh = vehicles.get_player_vehicle()
		for _, v in ipairs(entities.get_vehs())
		do
			if v ~= veh and features.get_entity_coords(v):sqrlen(features.get_player_coords()) <= 2500 then
				local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(v, -1, true)
				if ped ~= 0 then
					TASK.TASK_VEHICLE_TEMP_ACTION(ped, v, 26, 500)
				end
			end
		end
	end)
end, {"policemode"})

__options.num["RunSpeed"] = ui.add_float_option(TRANSLATION["Run speed multiplier"], __submenus["Self"], -10000, 10000, 0.1, 3, function(float)
	if utils.show_info("runspeed [-10000.0 - 10000.0]", "Allows you to run faster or slower") then ui.set_value(__options.num["RunSpeed"], 1, true) return end
	settings.Self["RunSpeed"] = float
	utils.hud_sound("YES")
	if float == 10000 then
		system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["I don't think you need to be faster"], settings.General["HudColorNotifyNormal"], true)
	end
	system.thread(true, 'self_run_speed', function()
		local addr = s_memory.get_memory_address(s_memory.WorldPtr, s_memory.offsets.run_speed_mult)
		if addr == 0 then return end
		memory.write_float(addr, float)
		if float == 1 then return POP_THREAD end
	end)
end, {"runspeed"})

__options.num["SwimSpeed"] = ui.add_float_option(TRANSLATION["Swim speed multiplier"], __submenus["Self"], -10000, 10000, 0.1, 3, function(float)
	if utils.show_info("swimspeed [-10000.0 - 10000.0]", "Allows you to swim faster or slower") then ui.set_value(__options.num["SwimSpeed"], 1, true) return end
	settings.Self["SwimSpeed"] = float
	utils.hud_sound("YES")
	system.thread(true, 'self_swim_speed', function()
		local addr = s_memory.get_memory_address(s_memory.WorldPtr, s_memory.offsets.swim_speed_mult)
		if addr == 0 then return end
		memory.write_float(addr, float)
	end)
end, {"swimspeed"})

__options.num["Set Alpha"] = ui.add_num_option(TRANSLATION["Set alpha"], __submenus["Self"], 0, 255, 50, function(int)
	if utils.show_info("selfalpha [0 - 255]", "Sets you ped alpha") then ui.set_value(__options.num["Alpha"], ENTITY.GET_ENTITY_ALPHA(features.player_ped()), true) return end
	utils.hud_sound("YES") 
	ENTITY.SET_ENTITY_ALPHA(features.player_ped(), int, false)
end, {"selfalpha"})

__options.num["ForceField"] = ui.add_num_option(TRANSLATION["Force field"], __submenus["Self"], 0, 100, 1, function(int)
	if utils.show_info("forcefield [0 - 100]", "All nearby entities will be pushed away") then ui.set_value(__options.num["ForceField"], settings.Self["ForceField"], true) return end
	utils.hud_sound("YES") settings.Self["ForceField"] = int
end, {"forcefield"})

system.thread(true, 'self_force_field', function()
	if settings.Self["ForceField"] == 0 then return end
	local me, veh1, veh2 = features.player_ped(), vehicles.get_player_vehicle(), vehicles.get_personal_vehicle()
	local pos = features.get_player_coords()
	local distance = settings.Self["ForceField"] * settings.Self["ForceField"]
	for _, v in ipairs(features.get_entities(true))
	do
		local pos2 = features.get_entity_coords(v)
		if (v ~= me and v ~= veh1 and v ~= veh2) and (pos:sqrlen(pos2) <= distance) then
			features.request_control_once(v)
			if ENTITY.IS_ENTITY_A_PED(v) == 1 then
				PED.SET_PED_CAN_RAGDOLL(v, true)
				PED.SET_PED_TO_RAGDOLL(v, 5000, 5000, 0, true, true, false)
			end
			local force = pos2 - pos
			features.apply_force_to_entity(v, 1, force.x, force.y, force.z, 0, 0, 0, 0, false, true, true, false, true)
		end
	end
end)


---------------------------------------------------------------------------------------------------------------------------------
-- Session
---------------------------------------------------------------------------------------------------------------------------------
__submenus["Session"] = ui.add_submenu(TRANSLATION["Session"])
__suboptions["Session"] = ui.add_sub_option(TRANSLATION["Session"], __submenus["MainSub"], __submenus["Session"])

__submenus["ExcludedPlayers"] = ui.add_submenu(TRANSLATION["Excluded players"])
__suboptions["ExcludedPlayers"] = ui.add_sub_option(TRANSLATION["Excluded players"], __submenus["Session"], __submenus["ExcludedPlayers"])

__options.bool["Exclude Self"] = ui.add_bool_option(TRANSLATION["Exclude self"], __submenus["ExcludedPlayers"], function(bool)
	if utils.show_info("excludeself [on - off]") then ui.set_value(__options.bool["Exclude Self"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON") settings.General["Exclude Self"] = bool
end, {"excludeself"})
__options.bool["Exclude Friends"] = ui.add_bool_option(TRANSLATION["Exclude friends"], __submenus["ExcludedPlayers"], function(bool)
	if utils.show_info("excludefriends [on - off]") then ui.set_value(__options.bool["Exclude Friends"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON") settings.General["Exclude Friends"] = bool
end, {"excludefriends"})

ui.add_separator(TRANSLATION["Click to delete"], __submenus["ExcludedPlayers"])

system.thread(true, 'misc_excluded_players', function()
	if not __options.excludes then __options.excludes = {} end
	for k, v in pairs(__options.excludes)
	do
		if not features.player_excludes[k] then
			ui.remove(v)
			__options.excludes[k] = nil
		end
	end
	for k, v in pairs(features.player_excludes)
	do
		if not __options.excludes[k] then
			__options.excludes[k] = ui.add_click_option(v.name, __submenus["ExcludedPlayers"], function() utils.hud_sound("SELECT") features.player_excludes[k] = nil;SaveExcludes();system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Player removed from excludes"], settings.General["HudColorNotifySuccess"], true) end)
		end
	end
end)

__submenus["SessionFind"] = ui.add_submenu(TRANSLATION["Go session"])
__suboptions["SessionFind"] = ui.add_sub_option(TRANSLATION["Go session"], __submenus["Session"], __submenus["SessionFind"])

ui.add_click_option(TRANSLATION["Story mode"], __submenus["SessionFind"], function()
	if utils.show_info("gostory") then return end
	utils.hud_sound("SELECT")
	NETWORK._SHUTDOWN_AND_LOAD_MOST_RECENT_SAVE()
end, {"gostory"})
ui.add_click_option(TRANSLATION["Find public session"], __submenus["SessionFind"], function()
	if utils.show_info("gopublic") then return end
	utils.hud_sound("SELECT")
	online.change_session(1)
end, {"gopublic"})
ui.add_click_option(TRANSLATION["New public session"], __submenus["SessionFind"], function()
	if utils.show_info("gonewpublic") then return end
	utils.hud_sound("SELECT")
	online.change_session(2)
end, {"gonewpublic"})
ui.add_click_option(TRANSLATION["Closed crew session"], __submenus["SessionFind"], function()
	if utils.show_info("goclosedcrew") then return end
	utils.hud_sound("SELECT")
	online.change_session(3)
end, {"goclosedcrew"})
ui.add_click_option(TRANSLATION["Crew session"], __submenus["SessionFind"], function()
	if utils.show_info("gonewcrew") then return end
	utils.hud_sound("SELECT")
	online.change_session(4)
end, {"gonewcrew"})
ui.add_click_option(TRANSLATION["Find crew session"], __submenus["SessionFind"], function()
	if utils.show_info("gocrew") then return end
	utils.hud_sound("SELECT")
	online.change_session(5)
end, {"gocrew"})
ui.add_click_option(TRANSLATION["Closed friends session"], __submenus["SessionFind"], function()
	if utils.show_info("goclosedfriend") then return end
	utils.hud_sound("SELECT")
	online.change_session(6)
end, {"goclosedfriend"})
ui.add_click_option(TRANSLATION["Find friend session"], __submenus["SessionFind"], function()
	if utils.show_info("gofriend") then return end
	utils.hud_sound("SELECT")
	online.change_session(7)
end, {"gofriend"})
ui.add_click_option(TRANSLATION["Invite only"], __submenus["SessionFind"], function()
	if utils.show_info("goinvite") then return end
	utils.hud_sound("SELECT")
	online.change_session(8)
end, {"goinvite"})
ui.add_click_option(TRANSLATION["Solo"], __submenus["SessionFind"], function()
	if utils.show_info("gosolo") then return end
	utils.hud_sound("SELECT")
	online.change_session(9)
end, {"gosolo"})

__submenus["TargetMode"] = ui.add_submenu(TRANSLATION["Targetting mode"])
__suboptions["TargetMode"] = ui.add_sub_option(TRANSLATION["Targetting mode"], __submenus["Session"], __submenus["TargetMode"])

ui.add_click_option(TRANSLATION["Assisted Aim - Full"], __submenus["TargetMode"], function()
	if utils.show_info("targassistful") then return end
	utils.hud_sound("SELECT")
	PLAYER.SET_PLAYER_TARGETING_MODE(0)
end, {"targassistful"})
ui.add_click_option(TRANSLATION["Assisted Aim - Partial"], __submenus["TargetMode"], function()
	if utils.show_info("targassistpart") then return end
	utils.hud_sound("SELECT")
	PLAYER.SET_PLAYER_TARGETING_MODE(1)
end, {"targassistpart"})
ui.add_click_option(TRANSLATION["Free Aim - Assisted"], __submenus["TargetMode"], function()
	if utils.show_info("freeaimassist") then return end
	utils.hud_sound("SELECT")
	PLAYER.SET_PLAYER_TARGETING_MODE(2)
end, {"freeaimassist"})
ui.add_click_option(TRANSLATION["Free Aim"], __submenus["TargetMode"], function()
	if utils.show_info("freeaim") then return end
	utils.hud_sound("SELECT")
	PLAYER.SET_PLAYER_TARGETING_MODE(3)
end, {"freeaim"})

__submenus["SessionChat"] = ui.add_submenu(TRANSLATION["Chat"])
__suboptions["SessionChat"] = ui.add_sub_option(TRANSLATION["Chat"], __submenus["Session"], __submenus["SessionChat"])

---------------------------------------------------------------------------------------------------------------------------------
-- Commands
---------------------------------------------------------------------------------------------------------------------------------

__submenus["Commands"] = ui.add_submenu(TRANSLATION["Commands"])
__suboptions["Commands"] = ui.add_sub_option(TRANSLATION["Commands"], __submenus["SessionChat"], __submenus["Commands"])

__options.bool["cmd_spawn"] = ui.add_bool_option("spawn/sp <Vehicle>", __submenus["Commands"], function(bool)
	if utils.show_info("cmdspawn [on - off]") then ui.set_value(__options.bool["cmd_spawn"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Commands["cmd_spawn"] = bool
end, {"cmdspawn"})
__options.bool["cmd_freeze"] = ui.add_bool_option("freeze/nomove <Player/ID> <on/off>", __submenus["Commands"], function(bool)
	if utils.show_info("cmdfreeze [on - off]") then ui.set_value(__options.bool["cmd_freeze"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
  	settings.Commands["cmd_freeze"] = bool
end, {"cmdfreeze"})
__options.bool["cmd_wanted"] = ui.add_bool_option("wanted <Player/ID> <on/off>", __submenus["Commands"], function(bool)
	if utils.show_info("cmdwanted [on - off]") then ui.set_value(__options.bool["cmd_wanted"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
  	settings.Commands["cmd_wanted"] = bool
end, {"cmdwanted"})
__options.bool["cmd_island"] = ui.add_bool_option("island/vaca <Player/ID>", __submenus["Commands"], function(bool)
	if utils.show_info("cmdisland [on - off]") then ui.set_value(__options.bool["cmd_island"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
 	 settings.Commands["cmd_island"] = bool
end, {"cmdisland"})
__options.bool["cmd_kick"] = ui.add_bool_option("kick/leave <Player/ID>", __submenus["Commands"], function(bool)
	if utils.show_info("cmdkick [on - off]") then ui.set_value(__options.bool["cmd_kick"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
 	settings.Commands["cmd_kick"] = bool
end, {"cmdkick"})
__options.bool["cmd_crash"] = ui.add_bool_option("crash/bye <Player/ID>", __submenus["Commands"], function(bool)
	if utils.show_info("cmdcrash [on - off]") then ui.set_value(__options.bool["cmd_crash"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
 	 settings.Commands["cmd_crash"] = bool
end, {"cmdcrash"})
__options.bool["cmd_explode"] = ui.add_bool_option("explode/kill <Player/ID>", __submenus["Commands"], function(bool)
	if utils.show_info("cmdexplode [on - off]") then ui.set_value(__options.bool["cmd_explode"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
  	settings.Commands["cmd_explode"] = bool
end, {"cmdexplode"})
__options.bool["cmd_kickall"] = ui.add_bool_option("kickall/plsleave", __submenus["Commands"], function(bool)
	if utils.show_info("cmdkickall [on - off]") then ui.set_value(__options.bool["cmd_kickall"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
  	settings.Commands["cmd_kickall"] = bool
end, {"cmdkickall"})
__options.bool["cmd_crashall"] = ui.add_bool_option("crashall/byea", __submenus["Commands"], function(bool)
	if utils.show_info("cmdcrashall [on - off]") then ui.set_value(__options.bool["cmd_crashall"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
  	settings.Commands["cmd_crashall"] = bool
end, {"cmdcrashall"})
__options.bool["cmd_explodeall"] = ui.add_bool_option("explodeall/killa", __submenus["Commands"], function(bool)
	if utils.show_info("cmdexplodeall [on - off]") then ui.set_value(__options.bool["cmd_explodeall"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
  	settings.Commands["cmd_explodeall"] = bool
end, {"cmdexplodeall"})
__options.bool["cmd_clearwanted"] = ui.add_bool_option("clearwanted/nocop <on/off>", __submenus["Commands"], function(bool)
	if utils.show_info("cmdclearwanted [on - off]") then ui.set_value(__options.bool["cmd_clearwanted"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Commands["cmd_clearwanted"] = bool
	if not bool then
		for i = 0, 31 do
			system.remove_thread("cmd_clearwanted_"..i)
		end
	end
end, {"cmdclearwanted"})
__options.bool["cmd_offradar"] = ui.add_bool_option("offradar/ghost <on/off>", __submenus["Commands"], function(bool)
	if utils.show_info("cmdoffradar [on - off]") then ui.set_value(__options.bool["cmd_offradar"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Commands["cmd_offradar"] = bool
	if not bool then
		for i = 0, 31 do
			system.remove_thread("cmd_offradar_"..i)
		end
	end
end, {"cmdoffradar"})
__options.bool["cmd_vehiclegod"] = ui.add_bool_option("vehiclegod/god <on/off>", __submenus["Commands"], function(bool)
	if utils.show_info("cmdvehgod [on - off]") then ui.set_value(__options.bool["cmd_vehiclegod"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
    settings.Commands["cmd_vehiclegod"] = bool
end, {"cmdvehgod"})
__options.bool["cmd_upgrade"] = ui.add_bool_option("upgrade/upg", __submenus["Commands"], function(bool)
	if utils.show_info("cmdupgrade [on - off]") then ui.set_value(__options.bool["cmd_upgrade"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
    settings.Commands["cmd_upgrade"] = bool
end, {"cmdupgrade"})
__options.bool["cmd_repair"] = ui.add_bool_option("repair/rep/fix", __submenus["Commands"], function(bool)
	if utils.show_info("cmdrepair [on - off]") then ui.set_value(__options.bool["cmd_repair"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
    settings.Commands["cmd_repair"] = bool
end, {"cmdrepair"})
__options.bool["cmd_freezeall"] = ui.add_bool_option("freezeall/nomovea <on/off>", __submenus["Commands"], function(bool)
	if utils.show_info("cmdfreezeall [on - off]") then ui.set_value(__options.bool["cmd_freezeall"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
    settings.Commands["cmd_freezeall"] = bool
end, {"cmdfreezeall"})
__options.bool["cmd_bounty"] = ui.add_bool_option("bounty/hunt <Player/ID> <amount>", __submenus["Commands"], function(bool)
	if utils.show_info("cmdbounty [on - off]") then ui.set_value(__options.bool["cmd_bounty"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
    settings.Commands["cmd_bounty"] = bool
end, {"cmdbounty"})
__options.bool["cmd_bountyall"] = ui.add_bool_option("bountyall/hunta <amount>", __submenus["Commands"], function(bool)
	if utils.show_info("cmdbountyall [on - off]") then ui.set_value(__options.bool["cmd_bountyall"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
    settings.Commands["cmd_bountyall"] = bool
end, {"cmdbountyall"})
__options.bool["cmd_apartment"] = ui.add_bool_option("apartment/apa <Player/ID> <1-114>", __submenus["Commands"], function(bool)
	if utils.show_info("cmdapartment [on - off]") then ui.set_value(__options.bool["cmd_apartment"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
    settings.Commands["cmd_apartment"] = bool
end, {"cmdapartment"})
__options.bool["cmd_killaliens"] = ui.add_bool_option("killaliens/nogay <on/off>", __submenus["Commands"], function(bool)
	if utils.show_info("cmdkillaliens [on - off]") then ui.set_value(__options.bool["cmd_killaliens"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
    settings.Commands["cmd_killaliens"] = bool
end, {"cmdkillaliens"})
__options.bool["cmd_kickbarcodes"] = ui.add_bool_option("kickbarcodes/lz <on/off>", __submenus["Commands"], function(bool)
	if utils.show_info("cmdkickbarcode [on - off]") then ui.set_value(__options.bool["cmd_kickbarcodes"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
    settings.Commands["cmd_kickbarcodes"] = bool
end, {"cmdkickbarcode"})
__options.bool["cmd_gift"] = ui.add_bool_option("gift", __submenus["Commands"], function(bool)
	if utils.show_info("cmdgift [on - off]") then ui.set_value(__options.bool["cmd_gift"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
    settings.Commands["cmd_gift"] = bool
end, {"cmdgift"})
__options.bool["cmd_giveweapons"] = ui.add_bool_option("giveweapons/weapo", __submenus["Commands"], function(bool)
	if utils.show_info("cmdweapons [on - off]") then ui.set_value(__options.bool["cmd_giveweapons"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
    settings.Commands["cmd_giveweapons"] = bool
end, {"cmdweapons"})

ui.add_separator(TRANSLATION['Chat commands settings'], __submenus["Commands"])

do
	local prefixes = {'nf!','/', '\\','!','$','%','&','-','+','?','*',',','.','#','€','@'}
	__options.choose["CommandsPrefix"] = ui.add_choose(TRANSLATION["Prefix"], __submenus["Commands"], true, prefixes, function(int)
		if utils.show_info("commandprefix [choose]") then ui.set_value(__options.choose["CommandsPrefix"], settings.Commands["CommandsPrefix"], true) return end
		utils.hud_sound("YES")
		settings.Commands["CommandsPrefix"] = int
	end, {"commandprefix"})
end

__options.bool["ChatCommandResponse"] = ui.add_bool_option(TRANSLATION["Response in chat"], __submenus["Commands"], function(bool)
	if utils.show_info("cmdresponse [on - off]") then ui.set_value(__options.bool["ChatCommandResponse"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Commands["ChatCommandResponse"] = bool
end, {"cmdresponse"})

__options.bool["Friends Only"] = ui.add_bool_option(TRANSLATION["Friends only"], __submenus["Commands"], function(bool)
	if utils.show_info("cmdfriendonly [on - off]") then ui.set_value(__options.bool["Friends Only"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Commands["Friends Only"] = bool
end, {"cmdfriendonly"})
__options.bool["Don't Affect Friends"] = ui.add_bool_option(TRANSLATION["Don't affect friends"], __submenus["Commands"], function(bool)
	if utils.show_info("cmdnoaffectfriends [on - off]") then ui.set_value(__options.bool["Don't Affect Friends"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Commands["Don't Affect Friends"] = bool
end, {"cmdnoaffectfriends"})

__options.bool["LogChat"] = ui.add_bool_option(TRANSLATION["Log chat"], __submenus["SessionChat"], function(bool)
	if utils.show_info("logchat [on - off]") then ui.set_value(__options.bool["LogChat"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Misc["LogChat"] = bool
end, {"logchat"})

__options.bool["DisableChat"] = ui.add_bool_option(TRANSLATION['Disable chat'], __submenus["SessionChat"], function(bool)
	if utils.show_info("disablechat [on - off]") then ui.set_value(__options.bool["DisableChat"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Session["DisableChat"] = bool
	local spam_mes = '\n' * 200
	system.thread(bool, 'session_disable_chat', function()
		online.send_chat(spam_mes, true) -- doesn't work for local
		system.thread_pause(150)
	end)
end, {"disablechat"})

ui.add_separator(TRANSLATION["Chat mOcKEr"], __submenus["SessionChat"])

__options.bool["ChatMocker"] = ui.add_bool_option(TRANSLATION["Mock chat"], __submenus["SessionChat"], function(bool)
	if utils.show_info("mockchat [on - off]") then ui.set_value(__options.bool["ChatMocker"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Session["ChatMocker"] = bool
end, {"mockchat"})

__options.bool["ReverseMessages"] = ui.add_bool_option(TRANSLATION["Inverse messages"], __submenus["SessionChat"], function(bool)
	if utils.show_info("reversemessages [on - off]") then ui.set_value(__options.bool["ReverseMessages"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Session["ReverseMessages"] = bool
end, {"reversemessages"})

__options.bool["OwoifyChat"] = ui.add_bool_option(TRANSLATION["OwO-ify messages"], __submenus["SessionChat"], function(bool)
	if utils.show_info("owoifychat [on - off]") then ui.set_value(__options.bool["OwoifyChat"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Session["OwoifyChat"] = bool
end, {"owoifychat"})

ui.add_separator(TRANSLATION['Trolling'], __submenus["Session"])

---------------------------------------------------------------------------------------------------------------------------------
-- Soundpad
---------------------------------------------------------------------------------------------------------------------------------
__submenus["PlaySound"] = ui.add_submenu(TRANSLATION["Soundpad"])
__suboptions["PlaySound"] = ui.add_sub_option(TRANSLATION["Soundpad"], __submenus["Session"], __submenus["PlaySound"])

ui.add_click_option(TRANSLATION["Stop all sounds"], __submenus["PlaySound"], function()
	if utils.show_info("stopsounds") then return end
	utils.stop_sounds()
	utils.hud_sound("SELECT")
end, {"stopsounds"})

__options.num["GameVolume"] = ui.add_num_option(TRANSLATION["Game volume"], __submenus["PlaySound"], 0, 10, 1, function(int)
	if utils.show_info("gamevolume [0 - 10]") then return end
	utils.hud_sound("YES")
	memory.write_int(s_memory.GameVolume, int)
end, {"gamevolume"})

do
	local warning

	Global.sounds = {
		{
			separator = "Sounds",
			sounds = {
				{
					is_toggle = true,
					on_all = true,
				   	show_warning = true,
					option_name = "Camera switch character",
					command = "camswer",
					sounds = {
						{
							audio_ref = "PLAYER_SWITCH_CUSTOM_SOUNDSET",
							audio_name = "1st_Person_Transition"
						}
					}
				},
				{
					is_toggle = true,
					on_all = true,
				   	show_warning = true,
					option_name = "Bass ear rape",
					command = "bassrape",
					sounds = {
						{
							audio_ref = "PLAYER_SWITCH_CUSTOM_SOUNDSET",
							audio_name = "Hit_out"
						}, {
							audio_ref = "SHORT_PLAYER_SWITCH_SOUND_SET",
							audio_name = "All"
						}, {
							audio_ref = "PLAYER_SWITCH_CUSTOM_SOUNDSET",
							audio_name = "Short_Transition_In"
						}
					}
				},
				{
					is_toggle = true,
					on_all = true,
				   	show_warning = true,
					option_name = "Beat rape",
					command = "beatrape",
					sounds = {
						{
							audio_ref = "HintCamSounds",
							audio_name = "FocusOut"
						}
					}
				},
				{
					is_toggle = true,
					on_all = true,
				   	show_warning = true,
					option_name = "Checkpoint",
					command = "checkfin",
					sounds = {
						{
							audio_ref = "DLC_Stunt_Race_Frontend_Sounds",
							audio_name = "Checkpoint_Finish"
						}
					}
				},
				{
					is_toggle = true,
				   	show_warning = true,
				   	option_name = "Menu accept",
					command = "acceptphone",
					sounds = {
						{
							audio_ref = "Phone_SoundSet_Default",
						   	audio_name = "Menu_Accept"
						}
					}
				},
				{
					is_toggle = true,
				   	show_warning = true,
					option_name = "Camera shoot",
					command = "pphone1",
					sounds = {
						{
							audio_ref = "Phone_Soundset_Franklin",
							audio_name = "Camera_Shoot"
						}
					}
				},
				{
					is_toggle = true,
				   	show_warning = true,
					option_name = "Phone hang up",
					command = "presc",
					sounds = {
						{
							audio_ref = "Phone_Soundset_Default",
							audio_name = "Hang_Up"
						}
					}
				},
				{
					is_toggle = true,
				   	show_warning = true,
					option_name = "Beeps",
					command = "beeps",
					sounds = {
						{
							audio_ref = "GTAO_FM_Events_Soundset",
							audio_name = "OOB_Cancel"
						}, {
							audio_ref = "GTAO_FM_Events_Soundset",
							audio_name = "OOB_Start"
						}
					}
				}, {
					is_toggle = true,
		   	        show_warning = true,
					option_name = "Freemode events",
					command = "fmevents",
					sounds = {
					  	{
							audio_ref = "GTAO_FM_Events_Soundset",
							audio_name = "Near_Miss_Counter"
					   	}, {
							audio_ref = "GTAO_FM_Events_Soundset",
							audio_name = "Near_Miss_Counter_Reset"
						}, {
							audio_ref = "GTAO_FM_Events_Soundset",
							audio_name = "Event_Start_Text"
						}, {
							audio_ref = "GTAO_FM_Events_Soundset",
							audio_name = "Checkpoint_Cash_Hit"
						}, {
							audio_ref = "GTAO_FM_Events_Soundset",
							audio_name = "Criminal_Damage_Low_Value"
						}, {
							audio_ref = "GTAO_FM_Events_Soundset",
							audio_name = "Criminal_Damage_Kill_Player"
						}, {
							audio_ref = "GTAO_FM_Events_Soundset",
							audio_name = "Criminal_Damage_High_Value"
						}
					}
				}, {
					is_toggle = true,
					on_all = true,
				   	show_warning = true,
					option_name = "ANTI-BOMB SIREN",
					command = "bombsiren",
					sounds = {
						{
							audio_ref = "DLC_sum20_Business_Battle_AC_Sounds",
							audio_name = "Air_Defences_Activated"
						}
					}
			   	}, {
					is_toggle = true,
					on_all = true,
				   	show_warning = true,
					option_name = "Radio station",
					command = "radiostat",
					sounds = {
						{
							audio_ref = "Radio_Soundset",
							audio_name = "Change_Station_Loud"
						}
					}
				}, {
					is_toggle = true,
					on_all = true,
				   	show_warning = true,
					option_name = "Garage door",
					command = "opg",
					sounds = {
						{
							audio_ref = "GTAO_Script_Doors_Faded_Screen_Sounds",
							audio_name = "Garage_Door_Open"
						}, {
							audio_ref = "GTAO_Script_Doors_Faded_Screen_Sounds",
							audio_name = "Garage_Door_Close"
						},
					}
				}, {
					is_toggle = true,
					on_all = true,
				   	show_warning = true,
				   	option_name = "Bet table",
					command = "bettb",
					sounds = {
						{
							audio_ref = "dlc_vw_table_games_frontend_sounds",
						   	audio_name = "DLC_VW_BET_UP"
						}, {
							audio_ref = "dlc_vw_table_games_frontend_sounds",
							audio_name = "DLC_VW_ERROR_MAX"
						}, {
							audio_ref = "dlc_vw_table_games_frontend_sounds",
						   	audio_name = "DLC_VW_BET_UP"
						}
					}
				}, {
					is_toggle = true,
					on_all = true,
				   	show_warning = true,
					option_name = "Ear rape v1",
					command = "rape1",
					sounds = {
						{
							audio_ref = "DLC_GR_CS2_Sounds",
							audio_name = "07"
						}
					}
				}, {
					is_toggle = false,
					on_all = true,
				   	show_warning = true,
					option_name = "Ear rape v2",
					command = "rape2",
					sounds = {
						{
							audio_ref = "WastedSounds",
							audio_name = "Bed"
						}
					}
				}, {
					is_toggle = false,
					on_all = true,
				   	show_warning = true,
					option_name = "Ear rape v3",
					command = "rape21",
					sounds = {
						{
							audio_ref = "DLC_IE_VV_General_Sounds",
							audio_name = "Wasted"
						}, {
							audio_ref = "WastedSounds",
							audio_name = "MP_Flash"
						}
					}
				}, {
					is_toggle = false,
					on_all = true,
				   	show_warning = true,
					option_name = "Arcade insert coin",
					command = "arinco",
					sounds = {
						{
							audio_ref = "DLC_EXEC_ARC_MAC_SOUNDS",
							audio_name = "Insert_Coin"
						}
					}
				}, {
					is_toggle = false,
					on_all = true,
				   	show_warning = true,
					option_name = "Weapon upgrade",
					command = "weaupg",
					sounds = {
						{
							audio_ref = "DLC_GR_Weapon_Upgrade_Soundset",
							audio_name = "Weapon_Upgrade"
						}
					}
				}, {
					is_toggle = false,
					on_all = true,
				   	show_warning = true,
					option_name = "Wasted flash screen",
					command = "wfs",
					sounds = {
						{
							audio_ref = "WastedSounds",
							audio_name = "ScreenFlash"
						}
					}
				}, {
					is_toggle = false,
					on_all = true,
				   	show_warning = true,
					option_name = "Mission failed",
					command = "missfail",
					sounds = {
						{
							audio_ref = "MissionFailedSounds",
							audio_name = "ScreenFlash"
						}
					}
				}, {
					is_toggle = false,
					on_all = true,
				   	show_warning = true,
					option_name = "Collect figures/money errape",
					command = "collectear",
					sounds = {
						{
							audio_ref = "GTAO_FM_Events_Soundset",
							audio_name = "Object_Collect_Remote"
						}, {
							audio_ref = "GTAO_FM_Events_Soundset",
							audio_name = "Object_Dropped_Remote"
						}, {
							audio_ref = "GTAO_FM_Events_Soundset",
							audio_name = "Object_Collect_Player"
						}
					}
				},
				{
					is_toggle = false,
					on_all = true,
				   	show_warning = true,
					option_name = "MOC",
					command = "moc",
					sounds = {
						{
							audio_ref = "DLC_GR_MOC_Enter_Exit_Sounds",
							audio_name = "Enter_Car_Ramp_Deploy"
						}, {
							audio_ref = "DLC_GR_MOC_Enter_Exit_Sounds",
							audio_name = "Enter_Car_Ramp_Hits_Ground"
						}
					}
				},
				{
					is_toggle = false,
					on_all = true,
				   	show_warning = true,
					option_name = "Open elevator door",
					command = "elevator",
					sounds = {
						{
							audio_ref = "GTAO_ImpExp_Enter_Exit_Garage_Sounds",
							audio_name = "Enter_On_Foot"
						}
					}
				}, {
					is_toggle = false,
					on_all = true,
				   	show_warning = true,
					option_name = "Car fall",
					command = "carfall",
					sounds = {
						{
							audio_ref = "DLC_BTL_Collector_Sounds",
							audio_name = "car_fall"
						}
					}
				}, {
					is_toggle = false,
				   	show_warning = true,
					option_name = "Yaht horn",
					command = "yahthorn",
					sounds = {
						{
							audio_ref = "DLC_Apt_Yacht_Ambient_Soundset",
							audio_name = "HORN"
						}
					}
				},
				{
					is_toggle = false,
					on_all = true,
				   	show_warning = true,
					option_name = "Delivery success",
					command = "delsecc",
					sounds = {
						{
							audio_ref = "DLC_GR_Generic_Mission_Sounds",
							audio_name = "package_delivered_success_remote"
						}
					}
				},
				{
					is_toggle = false,
					on_all = true,
				   	show_warning = true,
					option_name = "Zone captured",
					command = "zone1",
					sounds = {
						{
							audio_ref = "dlc_vw_koth_Sounds",
							audio_name = "Zone_Captured_Remote"
						}, {
							audio_ref = "dlc_vw_koth_Sounds",
							audio_name = "Zone_Captured"
						}
					}
				},
				{
					is_toggle = false,
					on_all = true,
				   	show_warning = true,
					option_name = "Whistle",
					command = "whistle",
					sounds = {
						{
							audio_ref = "DLC_TG_Running_Back_Sounds",
							audio_name = "Whistle"
						}
					}
				},
				{
					is_toggle = false,
					on_all = true,
				   	show_warning = true,
					option_name = "Arcade game beep ",
					command = "argabe",
					sounds = {
						{
							audio_ref = "DLC_EXEC_ARC_MAC_SOUNDS",
							audio_name = "Cancel"
						}
					}
				},
				{
					is_toggle = false,
					on_all = true,
				   	show_warning = true,
					option_name = "Jet explosion",
					command = "jetexp",
					sounds = {
						{
							audio_ref = "exile_1",
							audio_name = "Jet_Explosions"
						}
					}
				}
			}
		},
		{
			separator = "Sounds - infinity",
			sounds = {
				{
					is_toggle = false,
					on_all = true,
				   	show_warning = true,
					option_name = "Phone ringing",
					command = "bananaphone",
					sounds = {
						{
							audio_ref = "Phone_SoundSet_Michael",
							audio_name = "Remote_Ring"
						}
					}
				},
				{
					is_toggle = false,
					on_all = true,
				   	show_warning = true,
					option_name = "Avanger fly",
					command = "avngrfly",
					sounds = {
						{
							audio_ref = "dlc_xm_avngr_sounds",
							audio_name = "Fly_Loop"
						}
					}
				},
				{
					is_toggle = false,
					on_all = true,
				   	show_warning = true,
					option_name = "Beeping",
					command = "beep",
					sounds = {
						{
							audio_ref = "DLC_PILOT_ENGINE_FAILURE_SOUNDS",
							audio_name = "Warning_Tones"
						}
					}
				},
				{
					is_toggle = false,
					on_all = true,
				   	show_warning = true,
					option_name = "Arcade game music",
					command = "argamu",
					sounds = {
					  	{
							audio_ref = "DLC_EXEC_ARC_MAC_SOUNDS",
							audio_name = "Background"
					   	}
					}
				}
			}
		}				
	}

	local function play_sound(sound, on_all)
		for i = 0, 31
		do
			for _, j in ipairs(sound)
			do
				utils.play_sound(j.audio_name, j.audio_ref, on_all and features.player_ped(i))
			end
		end
	end

	local function add_toggle_sound(parent)
		__options.bool[parent.option_name] = ui.add_bool_option(TRANSLATION[parent.option_name], __submenus["PlaySound"], function(bool)
			if utils.show_info("sound"..parent.command.." [on - off]") then ui.set_value(__options.bool[parent.option_name], not bool, true) return end
			utils.hud_sound("TOGGLE_ON")

			if bool and parent.show_warning and not warning and ui.is_sub_open(__submenus["PlaySound"]) then
				ui.set_value(__options.bool[parent.option_name], false, true)
				system.notify(TRANSLATION["Warning"], TRANSLATION["Turn your headphones down"], settings.General["HudColorNotifyWarning"], true)
				warning = true
				return
			end

			if not bool then utils.stop_sounds() end
			system.thread(bool, "play_sound_"..parent.option_name, function()
				play_sound(parent.sounds, parent.on_all)
			end)
		end, {"sound"..parent.command})
	end

	local function add_button_sound(parent)
		ui.add_click_option(TRANSLATION[parent.option_name], __submenus["PlaySound"], function()
			if utils.show_info("sound"..parent.command) then return end
			utils.hud_sound("SELECT")
			play_sound(parent.sounds)
		end, {"sound"..parent.command})
	end

	for _, v in ipairs(Global.sounds)
	do
		ui.add_separator(TRANSLATION[v.separator], __submenus["PlaySound"])
		for _, e in ipairs(v.sounds)
		do
			if e.is_toggle then
				add_toggle_sound(e)
			else
				add_button_sound(e)
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------
-- Session teleport
---------------------------------------------------------------------------------------------------------------------------------
__submenus["SessionTeleport"] = ui.add_submenu(TRANSLATION["Teleport"])
__suboptions["SessionTeleport"] = ui.add_sub_option(TRANSLATION["Teleport"], __submenus["Session"], __submenus["SessionTeleport"])

do
	local tp
	ui.add_click_option(TRANSLATION["To me"], __submenus["SessionTeleport"], function()
		if utils.show_info("tpalltome") then return end
		if tp then return utils.hud_sound("ERROR") end
		local found
		for i = 0, 31
		do
			if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and (i ~= PLAYER.PLAYER_ID()) and not (settings.Commands["Don't Affect Friends"] and features.is_friend(i)) and not features.is_excluded(i) then
				found = true
			end
		end
		if found then utils.hud_sound("YES") else return utils.hud_sound("ERROR") end
		tp = true
		local pos_to = features.get_offset_from_player_coords(vector3.forward(5))
		local my_pos = features.get_player_coords()
		local pid = 0
		local prev = -1
		local ped
		local se
		local wait
		local inveh
		local bail
		system.thread(true, 'session_teleport_to_me', function()
			if pid == 32 then NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, ped);tp = false;features.teleport(features.player_ped(), my_pos.x, my_pos.y, my_pos.z) return POP_THREAD end
			PAD.DISABLE_ALL_CONTROL_ACTIONS(0)
			if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or (pid == PLAYER.PLAYER_ID()) or (settings.Commands["Don't Affect Friends"] and features.is_friend(pid)) or features.is_excluded(pid) then
				pid = pid + 1
				return
			end
			if pid ~= prev then
				prev = pid
				NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, ped)
				local veh = vehicles.get_player_vehicle(pid)
				if veh ~= 0 then
					features.teleport(veh, pos_to.x, pos_to.y, pos_to.z)
					pid = pid + 1
					return
				end
				ped = features.player_ped(pid)
				bail = clock() + 15
				se = nil
				wait = nil
				inveh = nil
			end
			if bail < clock() then
				pid = pid + 1
				return
			end
			globals.set_int(2793044 + 6876, 1)
			NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true, ped)
			local pos = features.get_player_coords(pid)
			local veh = vehicles.get_player_vehicle(pid)
			if veh ~= 0 then
				inveh = true
				features.teleport(veh, pos_to.x, pos_to.y, pos_to.z)
				if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(veh) == 1 then
					wait = clock() + .2
				end
				if wait and wait < clock() then
					system.thread(true, 'clear_ent_'..veh, function(tick)
						if not se or tick > 300 then return POP_THREAD end
						if tick == 0 then TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped) end
						entities.request_control(veh, function()
							entities.delete(veh)
						end)
					end)
					NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, ped)
					tp = false
					pid = pid + 1
					return
				end
			elseif not features.is_player_in_veh(pid) and not se then
				se = true
				online.send_script_event(pid, 879177392, PLAYER.PLAYER_ID(), 1, 32, NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(pid), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1)
			end
			if inveh and veh == 0 then
				inveh = false
				se = false
			end
		end)
	end, {"tpalltome"})

	ui.add_click_option(TRANSLATION["To waypoint"], __submenus["SessionTeleport"], function()
		if utils.show_info("tpalltowp") then return end
		if tp then return utils.hud_sound("ERROR") end
		if HUD.IS_WAYPOINT_ACTIVE() == 0 then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["No waypoint has been set"], settings.General["HudColorNotifyError"]) utils.hud_sound("ERROR") return end
		local found
		for i = 0, 31
		do
			if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and (i ~= PLAYER.PLAYER_ID()) and not (settings.Commands["Don't Affect Friends"] and features.is_friend(i)) and not features.is_excluded(i) then
				found = true
			end
		end
		if found then utils.hud_sound("YES") else return utils.hud_sound("ERROR") end
		tp = true
		local w_pos = features.get_waypoint_coord()
		local pos_to
		local my_pos
		local pid = 0
		local prev = -1
		local ped
		local se
		local wait
		local inveh
		local bail
		local waypoint
		local b_pos = features.get_blip_for_coord(w_pos)
		system.thread(true, 'session_teleport_to_waypoint', function(tick)
			if not waypoint then
				if b_pos then
					my_pos = features.get_player_coords()
					pos_to = b_pos
					waypoint = true
					return
				end
				system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Preparing teleport"], settings.General["HudColorNotifyNormal"])
				local Z = (tick+1) * 100
				local success, groundZ = features.get_water_z(vector3(w_pos.x, w_pos.y, 500))
				if not success then
					STREAMING.REQUEST_COLLISION_AT_COORD(w_pos.x, w_pos.y, Z)
					success, groundZ = features.get_ground_z(vector3(w_pos.x, w_pos.y, Z))
					if not success and Z < 900 then return end
					if not success then system.reset_thread_tick() return end
				end
				my_pos = features.get_player_coords()
				pos_to = vector3(w_pos.x, w_pos.y, groundZ + 1)
				waypoint = true
			end
			if pid == 32 then NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, ped);tp = false;features.teleport(features.player_ped(), my_pos.x, my_pos.y, my_pos.z) return POP_THREAD end
			PAD.DISABLE_ALL_CONTROL_ACTIONS(0)
			if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or (pid == PLAYER.PLAYER_ID()) or (settings.Commands["Don't Affect Friends"] and features.is_friend(pid)) or features.is_excluded(pid) then
				pid = pid + 1
				return
			end
			if pid ~= prev then
				prev = pid
				NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, ped)
				local veh = vehicles.get_player_vehicle(pid)
				if veh ~= 0 then
					features.teleport(veh, pos_to.x, pos_to.y, pos_to.z)
					pid = pid + 1
					return
				end
				ped = features.player_ped(pid)
				bail = clock() + 15
				se = nil
				wait = nil
				inveh = nil
			end
			if bail < clock() then
				pid = pid + 1
				return
			end
			globals.set_int(2793044 + 6876, 1)
			NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true, ped)
			local pos = features.get_player_coords(pid)
			local veh = vehicles.get_player_vehicle(pid)
			if veh ~= 0 then
				inveh = true
				features.teleport(veh, pos_to.x, pos_to.y, pos_to.z)
				if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(veh) == 1 then
					wait = clock() + .2
				end
				if wait and wait < clock() then
					system.thread(true, 'clear_ent_'..veh, function(tick)
						if not se or tick > 300 then return POP_THREAD end
						if tick == 0 then TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped) end
						entities.request_control(veh, function()
							entities.delete(veh)
						end)
					end)
					NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, ped)
					tp = false
					pid = pid + 1
					return
				end
			elseif not features.is_player_in_veh(pid) and not se then
				se = true
				online.send_script_event(pid, 879177392, PLAYER.PLAYER_ID(), 1, 32, NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(pid), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1)
			end
			if inveh and veh == 0 then
				inveh = false
				se = false
			end
		end)
	end, {"tpalltowp"})
end

ui.add_click_option(TRANSLATION["Near me"], __submenus["SessionTeleport"], function()
	if utils.show_info("tpallnearme") then return end
	local found
	local my_pos = features.get_player_coords()
	local apartment = features.get_closest_apartment_to_coord(my_pos)
	for i = 0, 31
	do
		if not (i == PLAYER.PLAYER_ID() and settings.General["Exclude Self"]) and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and not (settings.General['Exclude Friends'] and features.is_friend(i)) and not features.is_excluded(i) then
			found = true
			online.send_script_event(i, -168599209, PLAYER.PLAYER_ID(), i, 1, 0, apartment, 1, 1, 1)
		end
	end
	if found then utils.hud_sound("YES") else utils.hud_sound("ERROR") end
end, {"tpallnearme"})

ui.add_click_option(TRANSLATION["Near waypoint"], __submenus["SessionTeleport"], function()
	if utils.show_info("tpallnearwp") then return end
	if HUD.IS_WAYPOINT_ACTIVE() == 0 then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["No waypoint has been set"], settings.General["HudColorNotifyError"]) utils.hud_sound("ERROR") return end
	local found
	local my_pos = features.get_waypoint_coord()
	local apartment = features.get_closest_apartment_to_coord(my_pos)
	for i = 0, 31
	do
		if not (i == PLAYER.PLAYER_ID() and settings.General["Exclude Self"]) and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and not (settings.General['Exclude Friends'] and features.is_friend(i)) and not features.is_excluded(i) then
			found = true
			online.send_script_event(i, -168599209, PLAYER.PLAYER_ID(), i, 1, 0, apartment, 1, 1, 1)
		end
	end
	if found then utils.hud_sound("YES") else utils.hud_sound("ERROR") end
end, {"tpallnearwp"})

do
	local active
	local pid
	local f_pos
	local veh
	local teleported
	local time
	ui.add_click_option(TRANSLATION["Send to cutscene"], __submenus["SessionTeleport"], function()
		if utils.show_info("cutsceneall") then return end
		local found
		for i = 0, 31
		do
			if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and (i ~= PLAYER.PLAYER_ID()) and not (settings.Commands["Don't Affect Friends"] and features.is_friend(i)) and not features.is_excluded(i) then
				found = true
			end
		end
		if found then utils.hud_sound("YES") else return utils.hud_sound("ERROR") end
		if not active then
			pid = 0
			f_pos = features.get_player_coords()
			veh = vehicles.get_player_vehicle()
			teleported = false
			time = clock() + 1.5
		end
		active = not active
		system.thread(true, 'send_to_cutscene', function()
			if not active then
				if teleported then
					if veh ~= 0 then
						PED.SET_PED_INTO_VEHICLE(features.player_ped(), veh, -1)
					end
					features.teleport(features.player_ped(), f_pos.x, f_pos.y, f_pos.z)
				end
				active = false 
				return POP_THREAD 
			end
			if pid == 32 then active = false return POP_THREAD end
			if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 or (pid == PLAYER.PLAYER_ID()) or (settings.Commands["Don't Affect Friends"] and features.is_friend(pid)) or features.is_excluded(pid) or features.is_player_in_interior(pid) then
				if not teleported then time = clock() + 1.5; pid = pid + 1 return end
				if veh ~= 0 then
					PED.SET_PED_INTO_VEHICLE(features.player_ped(), veh, -1)
				end
				features.teleport(features.player_ped(), f_pos.x, f_pos.y, f_pos.z)
				time = clock() + 1.5
				pid = pid + 1
				return
			end
			local my_pos = features.get_player_coords()
			local pl_pos = features.get_player_coords2(pid)
			if my_pos:sqrlen(pl_pos) > 2500 then
				features.teleport(features.player_ped(), pl_pos.x, pl_pos.y + 50, pl_pos.z == -50 and 1000 or pl_pos.z)
				teleported = true
			end
			online.send_script_event(pid, 392606458, PLAYER.PLAYER_ID())
			if pl_pos.z == -50 then time = clock() + 1.5 return end 
			if time > clock() then return end
			if not teleported then time = clock() + 5; pid = pid + 1 return end
			if veh ~= 0 then
				PED.SET_PED_INTO_VEHICLE(features.player_ped(), veh, -1)
			end
			features.teleport(features.player_ped(), f_pos.x, f_pos.y, f_pos.z)
			time = clock() + 1.5
			pid = pid + 1
		end)
	end, {"cutsceneall"})
end

__options.choose["SessionWarehouse"] = ui.add_choose(TRANSLATION["Send to warehouse"], __submenus["SessionTeleport"], false, {TRANSLATION["Random"], "Pacific Bait Storage", "White Widow Garage", "Celltowa Unit", "Convenience Store Lockup", "Foreclosed Garage", "Xero Gas Factory", "Derriere Lingerie Backlot", "Bilgeco Warehouse", "Pier 400 Utility Building", "GEE Warehouse", "LS Marine Building 3", "Railyard Warehouse", "Fridgit Annexe", "Disused Factory Outlet", "Discount Retail Unit", "Logistics Depot", "Darnel Bros Warehouse", "Wholesale Furniture", "Cypress Warehouses", "West Vinewood Backlot", "Old Power Station", "Walker & Sons Warehouse"}, function(int)
	if utils.show_info("warehouseall [choose]") then return end
	utils.hud_sound("YES")
	local pid = online.get_selected_player()
	local id = int == 0 and random(1, 22) or int
	local found
	for i = 0, 31
	do
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and not (i == PLAYER.PLAYER_ID() and settings.General["Exclude Self"]) and not (settings.Commands["Don't Affect Friends"] and features.is_friend(i)) and not features.is_excluded(i) then
			online.send_script_event(i, 434937615, PLAYER.PLAYER_ID(), 0, 1, id)
			found = true
		end
	end
	if found then utils.hud_sound("YES") else return utils.hud_sound("ERROR") end
end, {"warehouseall"})


__options.choose["SessionTpCayo"] = ui.add_choose(TRANSLATION["Send to island"], __submenus["SessionTeleport"], false, {TRANSLATION["Normal"], TRANSLATION["Instant"], TRANSLATION["LSIA"], TRANSLATION["Beach"]}, function(int)
	if utils.show_info("islandall [choose]") then return end
	local found
	for i = 0, 31
	do
		if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and not (i == PLAYER.PLAYER_ID() and settings.General["Exclude Self"]) and not (settings.Commands["Don't Affect Friends"] and features.is_friend(i)) and not features.is_excluded(i) then
			if int == 0 then
				online.send_script_event(i, -910497748, PLAYER.PLAYER_ID(), 1)
			elseif int == 1 then
				online.send_script_event(i, -93722397, PLAYER.PLAYER_ID(), i, i, 4, 1)
			elseif int == 2 then
				online.send_script_event(i, -93722397, PLAYER.PLAYER_ID(), i, i, 3, 0)
			elseif int == 3 then
				online.send_script_event(i, -93722397, PLAYER.PLAYER_ID(), i, i, 4, 0)
			end
			found = true
		end
	end
	if found then utils.hud_sound("YES") else return utils.hud_sound("ERROR") end
end, {"islandall"})

do
	local types = {TRANSLATION["Severe Weather Patterns"], TRANSLATION["Half-truck Bully"], TRANSLATION["Exit Strategy"], TRANSLATION["Offshore Assets"], TRANSLATION["Cover Blown"], TRANSLATION["Mole Hunt"], TRANSLATION["Data Breach"], TRANSLATION["Work Dispute"]}
	__options.choose["SendAllMission"] = ui.add_choose(TRANSLATION["Send to job"], __submenus["SessionTeleport"], false, types, function(int)
		if utils.show_info("joball [choose]") then return end
		local found
		for i = 0, 31
		do
			if not (i == PLAYER.PLAYER_ID() and settings.General["Exclude Self"]) and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and not (settings.General['Exclude Friends'] and features.is_friend(i)) and not features.is_excluded(i) then
				online.send_script_event(i, 1858712297, PLAYER.PLAYER_ID(), int)
				found = true
			end
		end
		if found then utils.hud_sound("YES") else utils.hud_sound("ERROR") end
	end, {"joball"})
end

do
	local explosion_types = {}
	__submenus["SessionCustomExplosion"] = ui.add_submenu(TRANSLATION["Custom explosion"])
	__suboptions["SessionCustomExplosion"] = ui.add_sub_option(TRANSLATION["Custom explosion"], __submenus["Session"], __submenus["SessionCustomExplosion"])
	for i = 0, 82
	do
		for k, v in pairs(enum.explosion)
		do
			if v == i then
				insert(explosion_types, k)
				break
			end
		end
	end
	local blamed
	local invisible = false
	local silent = false
	__options.bool["SessionExplodeBlamed"] = ui.add_bool_option(TRANSLATION["Kill as self"], __submenus["SessionCustomExplosion"], function(bool)
		if utils.show_info("explodeasselfall [on - off]") then ui.set_value(__options.bool["SessionExplodeBlamed"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") blamed = bool
	end, {"explodeasselfall"})
	__options.bool["SessionExplodeInvisible"] = ui.add_bool_option(TRANSLATION["Invisible"], __submenus["SessionCustomExplosion"], function(bool)
		if utils.show_info("explodeinvisibleall [on - off]") then ui.set_value(__options.bool["SessionExplodeInvisible"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") invisible = bool
	end, {"explodeinvisibleall"})
	__options.bool["SessionExplodeSilet"] = ui.add_bool_option(TRANSLATION["Silent"], __submenus["SessionCustomExplosion"], function(bool) utils.hud_sound("TOGGLE_ON")
		if utils.show_info("addexplodesilent [on - off]") then ui.set_value(__options.bool["SessionExplodeSilet"], not bool, true) return end
		silent = bool
	end, {"explodesilentall"})
	__options.choose["SessionExplode"] = ui.add_choose(TRANSLATION["Explode"], __submenus["SessionCustomExplosion"], false, explosion_types, function(int)
		if utils.show_info("explodeall [choose]") then return end
		local found
		for i = 0, 31
		do
			if not (i == PLAYER.PLAYER_ID() and settings.General["Exclude Self"]) and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and not (settings.General['Exclude Friends'] and features.is_friend(i)) and not features.is_excluded(i) then
				found = true
				local pos = features.get_player_coords2(i)
				if blamed then
					FIRE.ADD_OWNED_EXPLOSION(features.player_ped(), pos.x, pos.y, pos.z, int, 1, not silent, invisible, 1)
				else
					FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, int, 1, not silent, invisible, 1, false)
				end
			end
		end
		if found then utils.hud_sound("YES") else utils.hud_sound("ERROR") end
	end, {"explodeall"})
	__options.bool["SessionExplodeSpam"] = ui.add_bool_option(TRANSLATION["Spam"], __submenus["SessionCustomExplosion"], function(bool) utils.hud_sound("TOGGLE_ON")
		if utils.show_info("explodespamall [on - off]") then ui.set_value(__options.bool["SessionExplodeSpam"], not bool, true) return end
		system.thread(bool, 'session_explode', function(tick)
			if tick%5~=0 then return end
			for i = 0, 31
			do
				if not (i == PLAYER.PLAYER_ID() and settings.General["Exclude Self"]) and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and not (settings.General['Exclude Friends'] and features.is_friend(i)) and not features.is_excluded(i) then
					local pos = features.get_player_coords2(i)
					if blamed then
						FIRE.ADD_OWNED_EXPLOSION(features.player_ped(), pos.x, pos.y, pos.z, ui.get_value(__options.choose["SessionExplode"]), 1, not silent, invisible, 1)
					else
						FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, ui.get_value(__options.choose["SessionExplode"]), 1, not silent, invisible, 1, false)
					end
				end
			end
		end)
	end, {"explodespamall"})
end

ui.add_click_option(TRANSLATION["Oblitarate"], __submenus["Session"], function()
	if utils.show_info("oblitarateall") then return end
	utils.hud_sound("SELECT")
	system.thread(true, 'orbital_strike', function(tick)
		utils.set_bit(2657589 + 1 + (PLAYER.PLAYER_ID() * 466) + 427, 0)
		if tick == 2 then
			for i = 0, 31
			do
				if not (i == PLAYER.PLAYER_ID() and settings.General["Exclude Self"]) and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and not (settings.General['Exclude Friends'] and features.is_friend(i)) and not features.is_excluded(i) and features.can_shoot_player(i) then
					local pos = features.get_player_coords2(i)
					features.orbital_strike_at_coord(pos, vector3())
				end
			end
		end
		if tick < 100 then return end
		utils.clear_bit(2657589 + 1 + (PLAYER.PLAYER_ID() * 466) + 427, 0)
		return POP_THREAD
	end)
end, {"oblitarateall"})

__options.click["LobbyBounty"] = ui.add_click_option(TRANSLATION['Bounty all'], __submenus["Session"], function()
	if utils.show_info("bountyall") then return end
	system.open_command_box("> bountyall 10000", true)
end)

system.register_command({"bountyall"}, {type = "int", min = 0, max = 10000, step = 1000, func = function(amount)
	local found
	for i = 0, 31
	do
		if not (i == PLAYER.PLAYER_ID() and settings.General["Exclude Self"]) and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and not (settings.General['Exclude Friends'] and features.is_friend(i)) and not features.is_excluded(i) then
			features.set_bounty(i, amount)
			found = true
		end
	end
	if found then utils.hud_sound("SELECT") else utils.hud_sound("ERROR") end
end})

__options.click["NoDrivingAll"] = ui.add_click_option(TRANSLATION['Disable ability to drive'], __submenus["Session"], function() 
	if utils.show_info("nodrivingall") then return end
	local found
	for i = 0, 31
	do
		if not (i == PLAYER.PLAYER_ID() and settings.General["Exclude Self"]) and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and not (settings.General['Exclude Friends'] and features.is_friend(i)) and not features.is_excluded(i) then
			online.send_script_event(i, -168599209, PLAYER.PLAYER_ID(), 2, 4294967295, 1, 115, 0, 0, 0)
			found = true
		end
	end
	if found then utils.hud_sound("YES") else utils.hud_sound("ERROR") end
end, {"nodrivingall"})

__options.bool["FreezeAll"] = ui.add_bool_option(TRANSLATION['Freeze all'], __submenus["Session"], function(bool)
	if utils.show_info("freezeall [on - off]") then ui.set_value(__options.bool["FreezeAll"], not bool, true)return end
	utils.hud_sound("TOGGLE_ON")
	if not bool then
		for i = 0, 31
		do
			Global.playerlist[i]["Freeze"] = false
		end
	end
	system.thread(bool, 'session_freeze', function()
		for i = 0, 31
		do
			if i ~= PLAYER.PLAYER_ID() and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and not (settings.General['Exclude Friends'] and features.is_friend(i)) and not features.is_excluded(i) then
				Global.playerlist[i]["Freeze"] = true
			end
		end
	end)
end, {"freezeall"})

__options.bool["CamForwardAll"] = ui.add_bool_option(TRANSLATION['Force cam forward'], __submenus["Session"], function(bool)
	if utils.show_info("forcecamall [on - off]") then ui.set_value(__options.bool["CamForwardAll"], not bool, true)return end
	utils.hud_sound("TOGGLE_ON")
	system.thread(bool, 'session_cam_forward', function(tick)
		for i = 0, 31
		do
			if i ~= PLAYER.PLAYER_ID() and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and not (settings.General['Exclude Friends'] and features.is_friend(i)) and not features.is_excluded(i) then
				features.remove_god(i)
			end
		end
	end)
end, {"forcecamall"})

__options.bool["SessionAlwaysWanted"] = ui.add_bool_option(TRANSLATION['Always wanted'], __submenus["Session"], function(bool)
	if utils.show_info("wantedall [on - off]") then ui.set_value(__options.bool["SessionAlwaysWanted"], not bool, true)return end
	utils.hud_sound("TOGGLE_ON")
	if not bool then
		for i = 0, 31
		do
			Global.playerlist[i]["AlwaysWanted"] = false
		end
	end
	system.thread(bool, 'session_always_wanted', function()
		for i = 0, 31
		do
			if not (i == PLAYER.PLAYER_ID() and settings.General["Exclude Self"]) and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and not (settings.General['Exclude Friends'] and features.is_friend(i)) and not features.is_excluded(i) then
				Global.playerlist[i]["AlwaysWanted"] = true
			end
		end
	end)
end, {"wantedall"})

__options.bool["SoundSpam"] = ui.add_bool_option(TRANSLATION['Sound spam'], __submenus["Session"], function(bool)
	if utils.show_info("soundspamall [on - off]") then ui.set_value(__options.bool["SoundSpam"], not bool, true)return end
	utils.hud_sound("TOGGLE_ON")
	local i = 0
	system.thread(bool, 'session_sound_spam', function()
		if i ~= PLAYER.PLAYER_ID() and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and not (settings.General['Exclude Friends'] and features.is_friend(i)) and not features.is_excluded(i) then
			online.send_script_event(i, -1891171016, PLAYER.PLAYER_ID(), random(1, 6))
		end
	    i = i + 1 == 32 and 0 or i + 1
	end)
end, {"soundspamall"})

__options.bool["BlockPassive"] = ui.add_bool_option(TRANSLATION['Block passive'], __submenus["Session"], function(bool)
	if utils.show_info("blockpassiveall [on - off]") then ui.set_value(__options.bool["BlockPassive"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Session["BlockPassive"] = bool
	system.thread(bool, 'session_block_passive', function(tick)
		if tick%10~=0 then return end
		utils.block_passive(1)
	end)
	if not bool then utils.block_passive(0) end
end, {"blockpassiveall"})

__options.bool["TransactionError"] = ui.add_bool_option(TRANSLATION['Transaction error'], __submenus["Session"], function(bool)
	if utils.show_info("transactionall [on - off]") then ui.set_value(__options.bool["TransactionError"], not bool, true)return end
	utils.hud_sound("TOGGLE_ON")
	local i = 0
	system.thread(bool, 'session_transaction_error', function()
		if i ~= PLAYER.PLAYER_ID() and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and not (settings.General['Exclude Friends'] and features.is_friend(i)) and not features.is_excluded(i) then
			online.send_script_event(i, -492741651, PLAYER.PLAYER_ID(), 50000, 0, 1, globals.get_int(1893573 + (1 + (i * 608) + 510)), globals.get_int(1923597 + 9), globals.get_int(1923597 + 10), 1)
		end
		i = i + 1 == 32 and 0 or i + 1
	end)
end, {"transactionall"})

do
	__options.choose["RandomPlayer"] = ui.add_choose(TRANSLATION['Random player'], __submenus["Session"], false, {TRANSLATION["Kill"], TRANSLATION["Blame"], TRANSLATION['Kick'], TRANSLATION['Crash']}, function(int) 
		if utils.show_info("randomplayer [choose]") then return end
		local target = features.get_random_player(settings.General["Exclude Friends"])
		if target == PLAYER.PLAYER_ID() then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["No players found"], settings.General["HudColorNotifyError"]) return utils.hud_sound("ERROR") end
		utils.hud_sound("YES")
		if int == 0 then
			local pos = features.get_player_coords2(target)
			FIRE.ADD_OWNED_EXPLOSION(features.player_ped(), pos.x, pos.y, pos.z, 4, 1, false, false, 1)
		elseif int == 1 then
			if Global.blame_delay > clock() then return end
			features.patch_blame(true)
			local ped = features.player_ped(target)
			for i = 0, 31 do
				if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and i ~= PLAYER.PLAYER_ID() and not (settings.General["Exclude Friends"] and features.is_friend(i)) and not features.is_excluded(i) then
					local pos = features.get_player_coords2(i)
					FIRE.ADD_OWNED_EXPLOSION(ped, pos.x, pos.y, pos.z, 4, 1, true, false, 1.0)
				end
			end
			features.patch_blame(false)
			Global.blame_delay = clock() + .2
		elseif int == 2 then
			features.kick_player(target)
		elseif int == 3 then
			features.crash_player(target)
		end
	end, {"randomplayer"})
end

__options.choose["InfiniteInviteAll"] = ui.add_choose(TRANSLATION['Infinite invite'], __submenus["Session"], false, {TRANSLATION['v1'], TRANSLATION['v2']}, function(int) 
	if utils.show_info("infiniteinviteall [choose]") then return end
	if utils.inf_invite(int) then
		utils.hud_sound("YES")
	else
		utils.hud_sound("ERROR") 
	end
end, {"infiniteinviteall"})

__options.choose["TrapSession"] = ui.add_choose(TRANSLATION["Trap"], __submenus["Session"], false, {TRANSLATION["Stunt tube"], TRANSLATION["Invisible tube"], TRANSLATION["Cage"]}, function(int)
	if utils.show_info("trapall [choose]") then return end
	if NETWORK.NETWORK_IS_SESSION_STARTED() == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("YES")
	local type = Cages[int] 
 	system.thread(true, 'trap_'..system.thread_count(), function()
 		local result = world_spawner.request(type)
        if result == -1 then return 0 end -- invalid model
        if result == 0 then return end -- not loaded
		for i = 0, 31
		do
			if not (i == PLAYER.PLAYER_ID() and settings.General["Exclude Self"]) and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and not (settings.General['Exclude Friends'] and features.is_friend(i)) and not features.is_excluded(i) then
				local pos = features.get_player_coords2(i)
		        local heading = features.get_player_heading(i)
		        type[1].position.x = pos.x
		        type[1].position.y = pos.y
		        type[1].position.z = pos.z
		        type[1].position.yaw = heading
		        world_spawner.spawn_map(type, true)
			end
		end
		return POP_THREAD
	end)
end, {"trapall"})

ui.add_separator(TRANSLATION['Anti shit'], __submenus["Session"])

__submenus["VehicleBlacklist"] = ui.add_submenu(TRANSLATION["Vehicle blacklist"])
__suboptions["VehicleBlacklist"] = ui.add_sub_option(TRANSLATION["Vehicle blacklist"], __submenus["Session"], __submenus["VehicleBlacklist"])

__options.bool["VehicleBlacklist"] = ui.add_bool_option(TRANSLATION["Vehicle blacklist"], __submenus["VehicleBlacklist"], function(bool)
	if utils.show_info("vehblacklist [on - off]") then ui.set_value(__options.bool["VehicleBlacklist"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Session["VehicleBlacklist"] = bool
	system.thread(bool, 'session_vehicle_blacklist', function()
		for i = 0, 31 do
			if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and i ~= PLAYER.PLAYER_ID() and not (settings.General["Exclude Friends"] and features.is_friend(i)) and not features.is_excluded(i) and vehicles.get_player_vehicle(i) ~= 0 and vehicles.get_player_vehicle(i) ~= vehicles.get_player_vehicle() then
				local ped = features.player_ped(i)
				local veh = vehicles.get_player_vehicle(i)
				local hash = tostring(ENTITY.GET_ENTITY_MODEL(veh))
				local tabl = vehicle_blacklist.vehicles[hash]
				if tabl then
					if tabl.set_max_speed then
						entities.request_control(veh, function()
							ENTITY.SET_ENTITY_MAX_SPEED(veh, 0)
							VEHICLE.MODIFY_VEHICLE_TOP_SPEED(veh, 0)
						end)
					end
					if tabl.vehicle_kick then
						online.send_script_event(i, -513394492, PLAYER.PLAYER_ID(), i)

        				online.send_script_event(i, -852914485, PLAYER.PLAYER_ID(), 0, 0, 0, 0, 1, i, random(0, 2147483647))
						TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
					end
					if tabl.vehicle_explode then
						features.remove_god(i)
						local pos = features.get_entity_coords(veh)
						FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, enum.explosion.ROCKET, 10, false, false, 1.0, false)
						entities.request_control(veh, function()
							vehicles.set_godmode(veh, false)
							NETWORK.NETWORK_EXPLODE_VEHICLE(veh, true, false, i)
						end)
					end
					if tabl.vehicle_launch then
						entities.request_control(veh, function()
							features.set_entity_velocity(veh, 0, 0, 1000)
						end)
					end
					if tabl.vehicle_delete then
						features.delete_entity(veh)
					end
					if tabl.tp_killzone then
						entities.request_control(veh, function()
							ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, -1396.040, -605, 31.313, false, false, false)
						end)
					end
					if tabl.crash then
						features.crash_player(i)
					end
					if tabl.kick then
						features.kick_player(i)
					end
				end
			end
		end
	end)
end, {"vehblacklist"})

__submenus["BlacklistedVehicles"] = ui.add_submenu(TRANSLATION["Blacklisted vehicles"])
__suboptions["BlacklistedVehicles"] = ui.add_sub_option(TRANSLATION["Blacklisted vehicles"], __submenus["VehicleBlacklist"], __submenus["BlacklistedVehicles"])

__submenus["AddVehToBl"] = ui.add_submenu(TRANSLATION["Add vehicles"])
__suboptions["AddVehToBl"] = ui.add_sub_option(TRANSLATION["Add vehicles"], __submenus["VehicleBlacklist"], __submenus["AddVehToBl"])

do
	local selected_vehicle = 1
	local class = 0
	local classes = {}
	local curr_class
	for i = 0, 62
	do
		insert(classes, enum.vehicle_class[i])
	end
	ui.add_separator(TRANSLATION["Reactions"], __submenus["AddVehToBl"])

	__options.bool["VehBlVehicleKick"] = ui.add_bool_option(TRANSLATION["Kick from vehicle"], __submenus["AddVehToBl"], function(bool)
		if utils.show_info("vehblkickfromveh") then ui.set_value(__options.bool["VehBlVehicleKick"], settings.Session["VehBlVehicleKick"], true) return end
		utils.hud_sound("TOGGLE_ON") settings.Session["VehBlVehicleKick"] = bool
	end, {"vehblkickfromveh"})
	__options.bool["VehBlSetMaxSpeed"] = ui.add_bool_option(TRANSLATION["Limit max speed"], __submenus["AddVehToBl"], function(bool)
		if utils.show_info("vehbllimitspeed") then ui.set_value(__options.bool["VehBlSetMaxSpeed"], settings.Session["VehBlSetMaxSpeed"], true) return end
		utils.hud_sound("TOGGLE_ON") settings.Session["VehBlSetMaxSpeed"] = bool
	end, {"vehbllimitspeed"})
	__options.bool["VehBlVehicleExplode"] = ui.add_bool_option(TRANSLATION["Explode vehicle"], __submenus["AddVehToBl"], function(bool)
		if utils.show_info("vehblexplode") then ui.set_value(__options.bool["VehBlVehicleExplode"], settings.Session["VehBlVehicleExplode"], true) return end
		utils.hud_sound("TOGGLE_ON") settings.Session["VehBlVehicleExplode"] = bool
	end, {"vehblexplode"})
	__options.bool["VehBlVehicleDelete"] = ui.add_bool_option(TRANSLATION["Delete vehicle"], __submenus["AddVehToBl"], function(bool)
		if utils.show_info("vehbldel") then ui.set_value(__options.bool["VehBlVehicleDelete"], settings.Session["VehBlVehicleDelete"], true) return end
		utils.hud_sound("TOGGLE_ON") settings.Session["VehBlVehicleDelete"] = bool
	end, {"vehbldel"})
	__options.bool["VehBlVehicleLaunch"] = ui.add_bool_option(TRANSLATION["Launch vehicle"], __submenus["AddVehToBl"], function(bool)
		if utils.show_info("vehblkicklaunch") then ui.set_value(__options.bool["VehBlVehicleLaunch"], settings.Session["VehBlVehicleLaunch"], true) return end
		utils.hud_sound("TOGGLE_ON") settings.Session["VehBlVehicleLaunch"] = bool
	end, {"vehblkicklaunch"})
	__options.bool["VehBlKillZone"] = ui.add_bool_option(TRANSLATION["Teleport to kill zone"], __submenus["AddVehToBl"], function(bool)
		if utils.show_info("vehblkillzone") then ui.set_value(__options.bool["VehBlKillZone"], settings.Session["VehBlKillZone"], true) return end
		utils.hud_sound("TOGGLE_ON") settings.Session["VehBlKillZone"] = bool
	end, {"vehblkillzone"})
	__options.bool["VehBlKick"] = ui.add_bool_option(TRANSLATION["Kick player"], __submenus["AddVehToBl"], function(bool)
		if utils.show_info("vehblkickpl") then ui.set_value(__options.bool["VehBlKick"], settings.Session["VehBlKick"], true) return end
		utils.hud_sound("TOGGLE_ON") settings.Session["VehBlKick"] = bool
	end, {"vehblkickpl"})
	__options.bool["VehBlCrash"] = ui.add_bool_option(TRANSLATION["Crash player"], __submenus["AddVehToBl"], function(bool)
		if utils.show_info("vehblcrash") then ui.set_value(__options.bool["VehBlCrash"], settings.Session["VehBlCrash"], true) return end
		utils.hud_sound("TOGGLE_ON") settings.Session["VehBlCrash"] = bool
	end, {"vehblcrash"})

	ui.add_separator(TRANSLATION["Add"], __submenus["AddVehToBl"])

	__options.string["VehBlInput"] = ui.add_input_string(TRANSLATION["Input model"], __submenus["AddVehToBl"], function(text)
		if utils.show_info("vehbladd") then ui.set_value(__options.string["VehBlInput"], "", true) return end
		if not text or text:isblank() then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Please enter name"], settings.General["HudColorNotifyError"]) return utils.hud_sound("ERROR") end
		for i, v in ipairs(vehicles.models)
		do
			if text == v[1] then
				vehicle_blacklist.add(i)
				return utils.hud_sound("SELECT")
			end
		end
		return utils.hud_sound("ERROR")
	end, {"vehbladd"})

	-- ui.add_click_option(TRANSLATION["Add and save"], __submenus["AddVehToBl"], function() 
	local function add_and_save()
		local veh_index = vehicles.get_veh_index(selected_vehicle, class)
		vehicle_blacklist.add(veh_index)
	end

	local sel_class = ui.add_choose(TRANSLATION["Select class"], __submenus["AddVehToBl"], true, classes, function(int) class = int
		utils.hud_sound("YES")
		if curr_class then 
			ui.remove(curr_class)
			curr_class = nil
		end
	end)
	ui.set_value(sel_class, class, true)
	system.thread(true, 'selected_class_'..system.thread_count(), function()
		if not curr_class then
			curr_class = ui.add_choose(TRANSLATION["Select vehicle"], __submenus["AddVehToBl"], false, settings.Vehicle["VehManufacturer"] and vehicles.class_manufacturer[class] or vehicles.class[class], function(int) utils.hud_sound("YES") selected_vehicle = int + 1;add_and_save() end)
		end
	end)
end

__options.bool["AutoCrashFurry"] = ui.add_bool_option(TRANSLATION['Auto crash furry'], __submenus["Session"], function(bool)
	if utils.show_info("crashfurry [on - off]") then ui.set_value(__options.bool["AutoCrashFurry"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Session["AutoCrashFurry"] = bool
	local furry_names = {'fox','furry','wolf','owo','uwu','woof', 'anime'}
	local i = 0
	system.thread(bool, 'crash_furry',
	function(tick)
		if tick%100 ~= 0 then return end
		if not (i == PLAYER.PLAYER_ID() and settings.General["Exclude Self"]) and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and not (settings.General['Exclude Friends'] and features.is_friend(i)) and not features.is_excluded(i) then
			local triggered
			for _, v in ipairs(furry_names)
			do
				if online.get_name(i):lower():find(v) then
					triggered = true
					break
				end
			end
			if not triggered then
				local outfit = peds.get_outfit(features.player_ped(i))
				for v = 17, 26
				do
					if outfit.components["1"][1] == v then
						triggered = true
						break
					end
				end
			end
			if triggered then
				features.crash_player(i)
			end
		end
		i = i + 1 == 32 and 0 or i + 1
	end)
end, {"crashfurry"})

do
	local IsTexture = switch()
		:case(8, function()
			return true
		end)
		:case(9, function()
			return true
		end)
		:default(function()
			return false
		end)

	__options.bool["KillAliens"] = ui.add_bool_option(TRANSLATION['Kill aliens'], __submenus["Session"], function(bool)
		if utils.show_info("killaliens [on - off]") then ui.set_value(__options.bool["KillAliens"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON")
		settings.Session["KillAliens"] = bool
		local i = 0
		system.thread(bool, 'kill_aliens', 
		function(tick)
			if tick%10 ~= 0 then return end
			if not (i == PLAYER.PLAYER_ID() and settings.General["Exclude Self"]) and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and not (settings.General['Exclude Friends'] and features.is_friend(i)) and not features.is_excluded(i) and ENTITY.IS_ENTITY_DEAD(features.player_ped(i), false) == 0 then
				local ped = features.player_ped(i)
				local outfit = peds.get_outfit(ped)
				local model = ENTITY.GET_ENTITY_MODEL(ped)
				local triggered
				if model == utils.joaat("mp_f_freemode_01") then
					if (outfit.components["1"][1] == 134 and IsTexture(outfit.components["1"][2])) and (outfit.components["4"][1] == 113 and IsTexture(outfit.components["4"][2])) and (outfit.components["6"][1] == 87 and IsTexture(outfit.components["6"][2])) and (outfit.components["11"][1] == 287 and IsTexture(outfit.components["11"][2])) then
						triggered = true
					end
				elseif model == utils.joaat("mp_m_freemode_01") then
					if (outfit.components["1"][1] == 134 and IsTexture(outfit.components["1"][2])) and (outfit.components["4"][1] == 106 and IsTexture(outfit.components["4"][2])) and (outfit.components["6"][1] == 83 and IsTexture(outfit.components["6"][2])) and (outfit.components["11"][1] == 274 and IsTexture(outfit.components["11"][2])) then
						triggered = true
					end
				end
				if triggered then
					local pos = features.get_player_coords2(i)
					if pos.z == -50 then
						TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
					else
						features.remove_god(i)
						if vehicles.get_player_vehicle(i) ~= 0 then
							local veh = vehicles.get_player_vehicle(i)
							entities.request_control(veh, function()
								vehicles.set_godmode(veh, false)
								NETWORK.NETWORK_EXPLODE_VEHICLE(veh, true, false, i)
							end)
						end
						FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, enum.explosion.ROCKET, 10, false, false, 1.0, false)
					end
				end
			end
			i = i + 1 == 32 and 0 or i + 1
		end)
	end, {"killaliens"})
end

__options.bool["KickBarcodes"] = ui.add_bool_option(TRANSLATION['Kick barcodes'], __submenus["Session"], function(bool)
	if utils.show_info("kickbarcodes [on - off]") then ui.set_value(__options.bool["KickBarcodes"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Session["KickBarcodes"] = bool
	local i = 0
	system.thread(bool, 'kick_barcodes',
	function(tick)
		if tick%5 ~= 0 then return end
		if not (i == PLAYER.PLAYER_ID() and settings.General["Exclude Self"]) and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and not (settings.General['Exclude Friends'] and features.is_friend(i)) and not features.is_excluded(i) then
			local name = online.get_name(i)
			local name = name:lower()
			local chars = #gsub(name, "[^il]", "")
			local percent = chars / #name
			if percent > .5 then
		    features.kick_player(i)
			end
		end
		i = i + 1 == 32 and 0 or i + 1
	end)
end, {"kickbarcodes"})

do
	local types = {TRANSLATION['None'], TRANSLATION["Explode"], TRANSLATION["Freeze"], TRANSLATION["Kick"], TRANSLATION["Crash"], TRANSLATION["Send to island"]}
	__options.choose["PunishBeggers"] = ui.add_choose(TRANSLATION["Punish beggers"], __submenus["Session"], true, types, function(int)
		if utils.show_info("punishbegger [choose]") then ui.set_value(__options.bool["PunishBeggers"], settings.Session["PunishBeggers"], true) return end
		utils.hud_sound("YES") settings.Session["PunishBeggers"] = int
	end, {"punishbegger"})
end

ui.add_separator(TRANSLATION["Friendly"], __submenus["Session"])

__options.bool["OffRadarAll"] = ui.add_bool_option(TRANSLATION['Off radar'], __submenus["Session"], function(bool)
	if utils.show_info("offradarall [on - off]") then ui.set_value(__options.bool["OffRadarAll"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	local i = 0
	system.thread(bool, 'session_off_radar', function(tick)
		if not (i == PLAYER.PLAYER_ID() and settings.General["Exclude Self"]) and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and not (settings.General['Exclude Friends'] and features.is_friend(i)) and not features.is_excluded(i) then
			online.send_script_event(i, -162943635, PLAYER.PLAYER_ID(), NETWORK.GET_NETWORK_TIME() - 60, NETWORK.GET_NETWORK_TIME(), 1, 1, globals.get_int((1893573 + (1 + (i * 608) + 510))))
		end
		i = i + 1 == 32 and 0 or i + 1
	end)
end, {"offradarall"})

__options.bool["RemoveWantedAll"] = ui.add_bool_option(TRANSLATION['Remove wanted'], __submenus["Session"], function(bool)
	if utils.show_info("nowantedall [on - off]") then ui.set_value(__options.bool["RemoveWantedAll"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	system.thread(bool, 'session_remove_wanted', function()
		for i = 0, 31
		do
			if not (i == PLAYER.PLAYER_ID() and settings.General["Exclude Self"]) and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and PLAYER.GET_PLAYER_WANTED_LEVEL(i) ~= 0 and not (settings.General['Exclude Friends'] and features.is_friend(i)) and not features.is_excluded(i) then
				online.send_script_event(i, 2080651008, PLAYER.PLAYER_ID(), globals.get_int(1893573 + (1 + (i * 608) + 510)))
			end
		end
	end)
end, {"nowantedall"})

__options.bool["BribeAuthoritiesAll"] = ui.add_bool_option(TRANSLATION['Bribe authorities'], __submenus["Session"], function(bool)
	if utils.show_info("bribeauthall [on - off]") then ui.set_value(__options.bool["BribeAuthoritiesAll"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	system.thread(bool, 'session_bribe_authorities', function(tick)
		for i = 0, 31
		do
			if not (i == PLAYER.PLAYER_ID() and settings.General["Exclude Self"]) and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and PLAYER.GET_PLAYER_WANTED_LEVEL(i) ~= 0 and not (settings.General['Exclude Friends'] and features.is_friend(i)) and not features.is_excluded(i) then
				online.send_script_event(i, 1071490035, PLAYER.PLAYER_ID(), 0, 0, NETWORK.GET_NETWORK_TIME(), 0, globals.get_int(1893573 + (1 + (i * 608) + 510)))
			end
		end
	end)
end, {"bribeauthall"})

ui.add_separator(TRANSLATION['Useful'], __submenus["Session"])

__options.bool["ShowTypingIndicators"] = ui.add_bool_option(TRANSLATION["Show typing indicators"], __submenus["Session"], function(bool)
	if utils.show_info("showtyping [on - off]") then ui.set_value(__options.bool["ShowTypingIndicators"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.General["ShowTypingIndicators"] = bool
	system.thread(bool, 'show_typing_indicator', function()
		for i = 0, 31
		do
			if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) and i ~= PLAYER.PLAYER_ID() and features.is_typing(i) then
				system.notify(TRANSLATION['Chat'], format(TRANSLATION["Player %s is typing..."], PLAYER.GET_PLAYER_NAME(i)), settings.General["HudColorNotifyNormal"])
			end
		end
	end)
end, {"showtyping"})

__options.bool["ShowPlayers3DPosition"] = ui.add_bool_option(TRANSLATION["Show 3D markers on players"], __submenus["Session"], function(bool)
	if utils.show_info("3dmarkers [on - off]") then ui.set_value(__options.bool["ShowPlayers3DPosition"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.General["ShowPlayers3DPosition"] = bool
	local session_sub
	local player_sub
	system.thread(bool, 'show_players_position', function()
		if GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED("darts") == 0 then
			GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT("darts", false)
		end
		local res = features.get_screen_resolution()
		local my_coord = features.get_final_cam_pos()
		my_coord.z = 0
		if ui.get_value(__options.bool["FreeCam"]) then return end
		if (not ui.is_open() and session_sub) or (ui.is_sub_open(__submenus["Session"]) or ui.is_sub_open(__submenus["Commands"]) or ui.is_sub_open(__submenus["VehicleBlacklist"]) or ui.is_sub_open(__submenus["BlacklistedVehicles"]) or ui.is_sub_open(__submenus["AddVehToBl"]) or ui.is_sub_open(__submenus["PlaySound"]) or ui.is_sub_open(__submenus["SessionChat"]) or ui.is_sub_open(__submenus["SessionTeleport"]) or ui.is_sub_open(__submenus["ExcludedPlayers"]) or ui.is_sub_open(__submenus["SessionCustomExplosion"])) then
			session_sub = true
			for i = 0, 31
			do
				if i ~= PLAYER.PLAYER_ID() and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 then
					local pos = features.get_player_coords2(i)
					local color = settings.General["HudColorStranger"]
					if features.is_friend(i) then
						color = settings.General["HudColorFriend"]
					elseif i == PLAYER.PLAYER_ID() then
						color = settings.General["HudColorSelf"]
					elseif Global.modder_detection[i].triggered then
						color = settings.General["HudColorModder"]
					end
					--GRAPHICS.DRAW_LINE(pos.x, pos.y, -1000, pos.x, pos.y, 6000, color.r, color.g, color.b, 255)
					local screen = features.world_to_screen(pos)
					pos.z = 0
					local scale = pos:len(my_coord) / 200
					GRAPHICS.DRAW_MARKER(1, pos.x, pos.y, -1000, 0, 0, 0, 0, 0, 0, .2 + scale, .2 + scale, 10000, color.r, color.g, color.b, 180, false, true, 1, false, 0, 0, false)
					--features.draw_crosshair(6, 6, 6, 2, color.r, color.g, color.b, 180, true, true, true, true, 2, 0, 0, 0, 100, false, screen)
					if GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED("darts") == 1 and (screen.x ~= -1 and screen.y ~= -1) then
						GRAPHICS.DRAW_SPRITE("darts", "dart_reticules", screen.x, screen.y, .0156, .0156 * (res.x / res.y), 45,  color.r, color.g, color.b, 180, false)
					end
				end
			end
		elseif (not ui.is_open() and player_sub) or (ui.is_sub_open(__submenus["PlayerList"]) or ui.is_sub_open(__submenus["Info"]) or ui.is_sub_open(__submenus["PlayerlistVehicle"]) or ui.is_sub_open(__submenus["SpawnVehicle"]) or ui.is_sub_open(__submenus["PlayerlistTeleport"]) or ui.is_sub_open(__submenus["PlayerlistOther"]) or ui.is_sub_open(__submenus["Blame"]) or ui.is_sub_open(__submenus["SendEnemyVehicle"]) or ui.is_sub_open(__submenus["CustomExplosion"])) then
			player_sub = true
			local pid = online.get_selected_player()
			if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) == 0 then return end
			local pos = features.get_player_coords2(pid)
			local my_pos = features.get_player_coords()
			local color = settings.General["HudColorStranger"]
			if features.is_friend(pid) then
				color = settings.General["HudColorFriend"]
			elseif pid == PLAYER.PLAYER_ID() then
				color = settings.General["HudColorSelf"]
			elseif Global.modder_detection[pid].triggered then
				color = settings.General["HudColorModder"]
			end
			local screen = features.world_to_screen(pos)
			if GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED("darts") == 1 and (screen.x ~= -1 and screen.y ~= -1) then
				--GRAPHICS.DRAW_LINE(pos.x, pos.y, -1000, pos.x, pos.y, 6000, color.r, color.g, color.b, 255)
				-- features.draw_crosshair(6, 6, 6, 2, color.r, color.g, color.b, 180, true, true, true, true, 2, 0, 0, 0, 100, false, screen)
				GRAPHICS.DRAW_SPRITE("darts", "dart_reticules", screen.x, screen.y, .0156, .0156 * (res.x / res.y), 45,  color.r, color.g, color.b, 180, false)
			else
				GRAPHICS.DRAW_LINE(my_pos.x, my_pos.y, my_pos.z, pos.x, pos.y, pos.z, color.r, color.g, color.b, 255)
			end
			pos.z = 0
			local scale = pos:len(my_coord) / 200
			GRAPHICS.DRAW_MARKER(1, pos.x, pos.y, -1000, 0, 0, 0, 0, 0, 0, .2 + scale, .2 + scale, 10000, color.r, color.g, color.b, 180, false, true, 1, false, 0, 0, false)
		else
			session_sub = nil
			player_sub = nil
		end
	end)
end, {"3dmarkers"})

__options.bool["ShowInvisiblePlayers"] = ui.add_bool_option(TRANSLATION["Show invisible players"], __submenus["Session"], function(bool)
	if utils.show_info("showinvisible [on - off]") then ui.set_value(__options.bool["ShowInvisiblePlayers"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Session["ShowInvisiblePlayers"] = bool
	system.thread(bool, 'show_invisible_players', function()
		for i = 0, 31
		do
			if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and i ~= PLAYER.PLAYER_ID() and features.get_player_coords2(i):sqrlen(features.get_player_coords()) < 2250000 and ENTITY.IS_ENTITY_ON_SCREEN(features.player_ped(i)) then
				NETWORK.SET_PLAYER_VISIBLE_LOCALLY(i, true)
			end
		end
	end)
end, {"showinvisible"})

do
	local player_blips = {}
	for i = 0, 31
	do
		player_blips[i] = 0
	end
	local function AddBlipForPlayer(i)
		local ped = features.player_ped(i)
		features.remove_blip(HUD.GET_BLIP_FROM_ENTITY(ped))
		player_blips[i] = HUD.ADD_BLIP_FOR_ENTITY(ped)
		HUD.SET_BLIP_CATEGORY(player_blips[i], 7)
		HUD.SET_BLIP_SPRITE(player_blips[i], enum.blip_sprite.level)
		HUD.SET_BLIP_NAME_TO_PLAYER_NAME(player_blips[i], i)
		HUD.SET_BLIP_ALPHA(player_blips[i], 255)
		HUD._SET_BLIP_SHRINK(player_blips[i], true)
	end

	__options.bool["AddBlipForOtr"] = ui.add_bool_option(TRANSLATION["Add blip for otr players"], __submenus["Session"], function(bool)
		if utils.show_info("addblipotr [on - off]") then ui.set_value(__options.bool["AddBlipForOtr"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON")
		settings.Session["AddBlipForOtr"] = bool
		if not bool then
			for i = 0, 31
			do
				features.remove_blip(player_blips[i])
				player_blips[i] = 0
			end
		end
		local i = 0
		system.thread(bool, 'session_blip_otr', function()
			if i ~= PLAYER.PLAYER_ID() then
				if ENTITY.IS_ENTITY_DEAD(features.player_ped(i), false) == 1 and player_blips[i] ~= 0 then
					features.remove_blip(player_blips[i])
					player_blips[i] = 0
				end	
				if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 1 and player_blips[i] == 0 and ENTITY.IS_ENTITY_DEAD(features.player_ped(i), false) == 0 and features.is_otr(i) then
					AddBlipForPlayer(i)
				elseif player_blips[i] ~= 0 and (NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) == 0 or not features.is_otr(i)) then
					features.remove_blip(player_blips[i])
					player_blips[i] = 0
				end
			end
			i = i + 1 == 32 and 0 or i + 1
		end)
	end, {"addblipotr"})
end

---------------------------------------------------------------------------------------------------------------------------------
-- Vehicle
---------------------------------------------------------------------------------------------------------------------------------
__submenus["Vehicle"] = ui.add_submenu(TRANSLATION["Vehicle"])
__suboptions["Vehicle"] = ui.add_sub_option(TRANSLATION["Vehicle"], __submenus["MainSub"], __submenus["Vehicle"])

__submenus["SpawnVeh"] = ui.add_submenu(TRANSLATION["Spawn vehicle"])
__suboptions["SpawnVeh"] = ui.add_sub_option(TRANSLATION["Spawn vehicle"], __submenus["Vehicle"], __submenus["SpawnVeh"])

__submenus["RealFuel"] = ui.add_submenu(TRANSLATION["Real fuel"])
__suboptions["RealFuel"] = ui.add_sub_option(TRANSLATION["Real fuel"], __submenus["Vehicle"], __submenus["RealFuel"])

__submenus["SpawnSettings"] = ui.add_submenu(TRANSLATION["Spawn settings"])
__suboptions["SpawnSettings"] = ui.add_sub_option(TRANSLATION["Spawn settings"], __submenus["SpawnVeh"], __submenus["SpawnSettings"])

__submenus["SavedVehicles"] = ui.add_submenu(TRANSLATION["Saved vehicles"])
__suboptions["SavedVehicles"] = ui.add_sub_option(TRANSLATION["Saved vehicles"], __submenus["SpawnVeh"], __submenus["SavedVehicles"])

do
	local saved = {}
	local options = {}
	local vehicle_name
	local delete_mode
	local clicked = 0
	local function RefreshSavedVehicles()
		saved = {}
		if not filesystem.isdir(paths['SavedVehicles']) then
			filesystem.make_dir(paths['SavedVehicles'])
		end
		local files = filesystem.scandir(paths['SavedVehicles'])
		for _, v in ipairs(files)
		do
			if v:find('.json$') or v:find('.xml$') then
				local name = ""
				if v:find('.json$') then
					name = v
					saved[name] = "json"
				elseif v:find('.xml$') then
					name = v
					saved[name] = "xml"
				end
				if not options[name] then
					options[name] = ui.add_click_option(name:gsub('.json$', ''):gsub('.xml$', ''), __submenus["SavedVehicles"], function()
						utils.hud_sound("SELECT")
						system.thread(true, 'spawn_vehicle_'..system.thread_count(), function()
							if delete_mode then
								if clicked ~= options[name] then
									system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Click again to remove"], settings.General["HudColorNotifyNormal"])
									clicked = options[name]
								else
									ui.remove(options[name])
									options[name] = nil
									os.remove(paths['SavedVehicles']:ensureend('\\')..name..'.json')
								end
							else
								clicked = 0
								local file = paths['SavedVehicles']:ensureend('\\')..v
								if not filesystem.exists(file) then utils.hud_sound("ERROR");system.notify(TRANSLATION["Error"], TRANSLATION["File doesn't exist"], settings.General["HudColorNotifyError"]) return POP_THREAD end 
								local tabl = saved[name] == "json" and json:decode(filesystem.read_all(file)) or world_spawner.xml_to_entity(file)
								world_spawner.create_vehicle(tabl, true)
							end
							return POP_THREAD
						end)
					end)
				end
			end
		end

		for k, v in pairs(options)
		do
			if not saved[k] then
				ui.remove(options[k])
				options[k] = nil
			end
		end
	end

	__options.string["SaveVehicleName"] = ui.add_input_string(TRANSLATION["Name"], __submenus["SavedVehicles"], function(text)
		if utils.show_info("vehname") then ui.set_value(__options.string["SaveVehicleName"], vehicle_name and vehicle_name or "", true) return end
		vehicle_name = text
	end, {"vehname"})
	ui.add_click_option(TRANSLATION["Save current vehicle"], __submenus["SavedVehicles"], function()
		if utils.show_info("saveveh") then return end
		local veh = vehicles.get_player_vehicle()
		if veh == 0 then return utils.hud_sound("ERROR") end
		utils.hud_sound("SELECT")
		cache:delete("Save Veh")
		system.thread(true, 'save_vehicle_'..system.thread_count(), function(tick)
			if not world_saver.save_vehicle(veh, tick) then return end
			local vehicle = cache:get("Save Veh")
			local name = (vehicle_name and vehicle_name ~= '') and vehicle_name or vehicles.get_label_name(ENTITY.GET_ENTITY_MODEL(veh))
			ui.set_value(__options.string["SaveVehicleName"], '', true)
			vehicle_name = nil
			local repeats = 0
			local found
			for k in pairs(saved)
			do
				if k == name then
					found = true
				end
				local n = k:match("[^%s]*$"):gsub('%D', '')
				if k:gsub(' %('..n..'%)', '') == name and k:sub(-len(' ('..n..')'), -1) == ' ('..n..')' then
					repeats = tonumber(n) and tonumber(n) + 1 or repeats
				end
			end
			if found then
				local repeats = repeats > 0 and repeats or 1
				name = format("%s (%d)", name, repeats)
			end
			-- vehicle.version = '1.0'
			filesystem.write(json:encode_pretty(vehicle), paths['SavedVehicles']:ensureend('\\')..name..[[.json]])
			system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Vehicle saved, you can rename the file later"], settings.General["HudColorNotifySuccess"], true)
			RefreshSavedVehicles()
			return POP_THREAD
		end)
	end, {"saveveh"})
	ui.add_click_option(TRANSLATION['Open folder'], __submenus["SavedVehicles"], function()
		if utils.show_info("openvehfolder") then return end
		utils.hud_sound("SELECT")
		if not filesystem.isdir(paths['SavedVehicles']) then filesystem.make_dir(paths['SavedVehicles']) end
		filesystem.open(paths['SavedVehicles'])
	end, {"openvehfolder"})
	__options.bool["SavedVehiclesDelMod"] = ui.add_bool_option(TRANSLATION['Delete mode'], __submenus["SavedVehicles"], function(bool)
		if utils.show_info("vehsdeletemode [on - off]") then ui.set_value(__options.bool["SavedVehiclesDelMod"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") delete_mode = bool
	end, {"vehsdeletemode"})
	__options.bool["AddToDb"] = ui.add_bool_option(TRANSLATION["Add to database"], __submenus["SavedVehicles"], function(bool)
		if utils.show_info("vehsaddtodb [on - off]") then ui.set_value(__options.bool["AddToDb"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") settings.Vehicle["AddToDb"] = bool
	end, {"vehsaddtodb"})
	ui.add_separator(TRANSLATION["Saved vehicles"], __submenus["SavedVehicles"])

	ui.add_input_string(TRANSLATION["Search"], __submenus["SavedVehicles"], function(text)
		text = text:lower():escpattern()
		for k, v in pairs(options)
		do
			if k:lower():find(text) then
				ui.hide(v, false)
			else
				ui.hide(v, true)
			end
		end
	end)

	local sub_open
	system.thread(true, 'saved_vehicles', function()
		if ui.is_sub_open(__submenus["SavedVehicles"]) and not sub_open then
			RefreshSavedVehicles()
			if delete_mode then
				system.notify(TRANSLATION["Warning"], TRANSLATION["Delete mode is enabled!"], settings.General["HudColorNotifyWarning"], true)
			end
			sub_open = true
		elseif not ui.is_sub_open(__submenus["SavedVehicles"]) and sub_open then
			sub_open = false
		end
	end)
end

__options.bool["RealFuelUsage"] = ui.add_bool_option(TRANSLATION["Realistic fuel usage"], __submenus["RealFuel"], function(bool)
	if utils.show_info("fuelusage [on - off]") then ui.set_value(__options.bool["RealFuelUsage"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Vehicle["RealFuelUsage"] = bool
	system.thread(bool, 'vehicle_fuel_usage', function()
		local veh = vehicles.get_player_vehicle()
		if veh == 0 then return end
		fuelConsumption.DoTick()
		local fuel = fuelConsumption.GetFuel(veh)
		if not fuel then return end
		local pos = features.get_entity_coords(veh)
		for _, v in ipairs(fuelConsumption.gas_pumps)
		do
			if pos:sqrlen(v) <= 25 then
				PAD.DISABLE_CONTROL_ACTION(0, enum.input.FRONTEND_ACCEPT, true)
				if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.FRONTEND_ACCEPT) == 1 then
					local add = fuelConsumption.tankVolume[veh].fill + (fuelConsumption.IsElectric(veh) and .1 or 1)
					fuelConsumption.tankVolume[veh].fill = add < fuelConsumption.tankVolume[veh].capacity and add or fuelConsumption.tankVolume[veh].capacity
				end
				if Instructional:New() then
					Instructional.AddButton(enum.input.FRONTEND_ACCEPT, TRANSLATION["Refuel"])
					Instructional:BackgroundColor(0, 0, 0, 80)
					Instructional:Draw()
				end
				break
			end
		end
		fuelConsumption.Draw(fuel)
	end)
end, {"fuelusage"})

__options.bool["ShowGasStations"] = ui.add_bool_option(TRANSLATION["Show gas stations"], __submenus["RealFuel"], function(bool)
	if utils.show_info("showgasstations [on - off]") then ui.set_value(__options.bool["ShowGasStations"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Vehicle["ShowGasStations"] = bool
	fuelConsumption.AddBlips(bool)
end, {"showgasstations"})
ui.add_click_option(TRANSLATION["Navigate to closest gas station"], __submenus["RealFuel"], function()
	if utils.show_info("findgasstation") then return end
	utils.hud_sound("SELECT")
	local pos = fuelConsumption.GetClosestGasStation(features.get_player_coords())
	HUD.SET_NEW_WAYPOINT(pos.x, pos.y)
end, {"findgasstation"})

__options.num["FuelOffsetX"] = ui.add_num_option(TRANSLATION["Offset x"], __submenus["RealFuel"], -10000, 10000, 1, function(int)
	if utils.show_info("fueloffsetx [-10000 - 10000]") then ui.set_value(__options.num["FuelOffsetX"], settings.Vehicle["FuelOffsetX"], true) return end
	utils.hud_sound("YES")
	settings.Vehicle["FuelOffsetX"] = int
end, {"fueloffsetx"})

__options.num["FuelOffsetY"] = ui.add_num_option(TRANSLATION["Offset y"], __submenus["RealFuel"], -10000, 10000, 1, function(int)
	if utils.show_info("fueloffsety [-10000 - 10000]") then ui.set_value(__options.num["FuelOffsetY"], settings.Vehicle["FuelOffsetY"], true) return end
	utils.hud_sound("YES")
	settings.Vehicle["FuelOffsetY"] = int
end, {"fueloffsety"})

do
	local selected_vehicle = 1
	local class = 0
	local classes = {}
	local curr_class
	local display_preview
	for i = 0, 62
	do
		insert(classes, enum.vehicle_class[i])
	end

	system.thread(true, 'request_ptfx', function()
		if STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_rcbarry2") == 0 then 
			STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_rcbarry2")
			return
		end
		return POP_THREAD
	end)

	local function spawn(hash)
		system.thread(true, "spawn_vehicle_"..system.thread_count(), function()
			if features.request_model(hash) == 0 then return end
			local prev_veh = vehicles.get_player_vehicle()
			local velocity
			if settings.Vehicle["SpawnerKeepSpeed"] and settings.Vehicle["SpawnerInside"] and prev_veh ~= 0 then
				velocity = ENTITY.GET_ENTITY_VELOCITY(prev_veh)
			end
			if settings.Vehicle["SpawnerDeleteOld"] and prev_veh ~= 0 then
				TASK.CLEAR_PED_TASKS_IMMEDIATELY(features.player_ped())
				features.delete_entity(prev_veh)
			end
			local pos = features.get_offset_from_player_coords(vector3(0, 5, 0))
			local veh = vehicles.spawn_vehicle(hash, pos, features.get_player_heading())
			if settings.Vehicle["SpawnWithEffect"] then
				GRAPHICS.USE_PARTICLE_FX_ASSET("scr_rcbarry2")
				GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY("scr_clown_appears", veh, 0, 0, 0, 0, 0, 0, 1.5, false, false, false, 0, 0, 0, 1)
				-- local alpha_table = {255, 204, 153, 102, 51, 0}
				-- local curr = 1
				local dir = true
				system.thread(true, 'spawn_anim_'..system.thread_count(), function(tick)
					if tick > 200 and ENTITY.GET_ENTITY_ALPHA(veh) ~= 255 then
						entities.request_control(veh, function()
							ENTITY.RESET_ENTITY_ALPHA(veh)
						end)
						return POP_THREAD
					elseif ENTITY.GET_ENTITY_ALPHA(veh) == 255 then
						entities.request_control(veh, function()
							ENTITY.SET_ENTITY_ALPHA(veh, 0, false)
						end)
					elseif ENTITY.GET_ENTITY_ALPHA(veh) == 0 then
						entities.request_control(veh, function()
							ENTITY.RESET_ENTITY_ALPHA(veh)
						end)
					end
				end)
			end
			entities.request_control(veh, function()
				vehicles.set_godmode(veh, settings.Vehicle["SpawnerGod"])
				vehicles.repair(veh)
				VEHICLE.SET_VEHICLE_ENGINE_ON(veh, true, true, false)
				VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(veh, settings.Vehicle["SpawnerLicenceText"])
				if settings.Vehicle["SpawnerPerformancePreset"] == 1 then
					vehicles.upgrade(veh)
				elseif settings.Vehicle["SpawnerPerformancePreset"] == 2 then
					vehicles.upgrade(veh)
					VEHICLE.SET_VEHICLE_MOD(veh, 48, -1, false)
				elseif settings.Vehicle["SpawnerPerformancePreset"] == 3 then
					vehicles.performance(veh)
				elseif settings.Vehicle["SpawnerPerformancePreset"] == 4 then
					vehicles.performance(veh)
					local num = VEHICLE.GET_NUM_VEHICLE_MODS(veh, 0) - 1
					VEHICLE.SET_VEHICLE_MOD(veh, 0, num, false)
				end
				local class = VEHICLE.GET_VEHICLE_CLASS(veh)
				VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(veh, settings.Vehicle["SpawnerLicence"])
				if velocity then
					features.set_entity_velocity(veh, velocity.x, velocity.y, velocity.z)
				end
				if settings.Vehicle["SpawnerInAir"] and features.compare(class, 15, 16) then
					VEHICLE.CONTROL_LANDING_GEAR(veh, 3)
					VEHICLE.SET_HELI_BLADES_FULL_SPEED(veh)
					local success, Z = features.get_ground_z(vector3(pos.x, pos.y, 900))
					if success and Z + 50 > pos.z then
						ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, pos.x, pos.y, Z + 50, false, false, false)
						if class == 16 then
							VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, 50)
						end
					end
				end
				if settings.Vehicle["SpawnerInside"] then
					PED.SET_PED_INTO_VEHICLE(features.player_ped(), veh, -1)
				end
				STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
			end)
			return POP_THREAD
		end)
	end

	__options.bool["SpawnerGod"] = ui.add_bool_option(TRANSLATION["Spawn in godmode"], __submenus["SpawnSettings"], function(bool)
		if utils.show_info("spawnergod [on - off]") then ui.set_value(__options.bool["SpawnerGod"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") settings.Vehicle["SpawnerGod"] = bool
	end, {"spawnergod"})
	__options.choose["SpawnerPerformancePreset"] = ui.add_choose(TRANSLATION["Upgrade preset"], __submenus["SpawnSettings"], true, {TRANSLATION["Stock"], TRANSLATION["Max upgrade"], TRANSLATION["Max without livery"], TRANSLATION["Performance"], TRANSLATION["Performance with spoiler"]}, function(int)
		if utils.show_info("spawnerpreset [choose]") then ui.set_value(__options.choose["SpawnerGod"], settings.Vehicle["SpawnerPerformancePreset"], true) return end
		utils.hud_sound("YES") settings.Vehicle["SpawnerPerformancePreset"] = int
	end, {"spawnerpreset"})
	__options.choose["SpawnerLicence"] = ui.add_choose(TRANSLATION["Licence plate"], __submenus["SpawnSettings"], true, enum.plate_index, function(int)
		utils.hud_sound("YES")
		settings.Vehicle["SpawnerLicence"] = int
	end, {"spawnerlicence"})
	__options.string["SpawnerLicenceText"] = ui.add_input_string(TRANSLATION["Plate text"], __submenus["SpawnSettings"], function(text)
		if utils.show_info("spawnerlicencetext") then ui.set_value(__options.string["SpawnerLicenceText"], settings.Vehicle["SpawnerLicenceText"], true) return end
		settings.Vehicle["SpawnerLicenceText"] = text:truncate(8):upper() ui.set_value(__options.string["SpawnerLicenceText"], settings.Vehicle["SpawnerLicenceText"], true)
	end, {"spawnerlicencetext"})
	__options.bool["SpawnerKeepSpeed"] = ui.add_bool_option(TRANSLATION["Keep speed"], __submenus["SpawnSettings"], function(bool)
		if utils.show_info("spawnerkeepspeed [on - off]") then ui.set_value(__options.bool["SpawnerKeepSpeed"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") settings.Vehicle["SpawnerKeepSpeed"] = bool
	end, {"spawnerkeepspeed"})
	__options.bool["SpawnerInside"] = ui.add_bool_option(TRANSLATION["Spawn inside"], __submenus["SpawnSettings"], function(bool)
		if utils.show_info("spawnerinside [on - off]") then ui.set_value(__options.bool["SpawnerInside"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") settings.Vehicle["SpawnerInside"] = bool
	end, {"spawnerinside"})
	__options.bool["SpawnerInAir"] = ui.add_bool_option(TRANSLATION["Spawn in air"], __submenus["SpawnSettings"], function(bool)
		if utils.show_info("spawnerinair [on - off]") then ui.set_value(__options.bool["SpawnerInAir"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") settings.Vehicle["SpawnerInAir"] = bool
	end, {"spawnerinair"})
	__options.bool["SpawnerDeleteOld"] = ui.add_bool_option(TRANSLATION["Delete old vehicle"], __submenus["SpawnSettings"], function(bool)
		if utils.show_info("spawnerdelete [on - off]") then ui.set_value(__options.bool["SpawnerDeleteOld"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") settings.Vehicle["SpawnerDeleteOld"] = bool
	end, {"spawnerdelete"})
	__options.bool["SpawnWithEffect"] = ui.add_bool_option(TRANSLATION["Spawn with effect"], __submenus["SpawnSettings"], function(bool)
		if utils.show_info("spawnereffect [on - off]") then ui.set_value(__options.bool["SpawnWithEffect"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") settings.Vehicle["SpawnWithEffect"] = bool
	end, {"spawnereffect"})

	ui.add_separator(TRANSLATION["Spawn"], __submenus["SpawnVeh"])

	__options.bool["VehPreview"] = ui.add_bool_option(TRANSLATION["Display preview"], __submenus["SpawnVeh"], function(bool)
		if utils.show_info("vehpreview [on - off]") then ui.set_value(__options.bool["VehPreview"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON")
		settings.Vehicle["VehPreview"] = bool
	end, {"vehpreview"})

	local value
	__options.bool["VehManufacturer"] = ui.add_bool_option(TRANSLATION["Show manufacturer"], __submenus["SpawnVeh"], function(bool)
		if utils.show_info("vehmanufacturer [on - off]") then ui.set_value(__options.bool["VehManufacturer"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON")
		settings.Vehicle["VehManufacturer"] = bool 
		if curr_class then
			value = ui.get_value(curr_class)
			ui.remove(curr_class)
			curr_class = nil
		end
	end, {"vehmanufacturer"})

	__options.string["SpawnVehicle"] = ui.add_input_string(TRANSLATION["Input model"], __submenus["SpawnVeh"], function(text)
		if utils.show_info("spawn") then ui.set_value(__options.string["SpawnVehicle"], "", true) return end
		if not text or text == '' then return utils.hud_sound("ERROR") end
		local text = text:lower()
		local hash = utils.joaat(text)
		if STREAMING.IS_MODEL_VALID(hash) == 1 and STREAMING.IS_MODEL_A_VEHICLE(hash) == 1 then
			spawn(hash)
		else
			text = text:escpattern():ensurestart('^')
			for _, v in ipairs(vehicles.data)
			do
				if v.Name:find(text) or (v.DisplayName and v.DisplayName:lower():find(text)) or vehicles.get_label_name(v.Hash):lower():find(text) then
					hash = v.Hash
					break
				end
			end
			if STREAMING.IS_MODEL_VALID(hash) == 1 and STREAMING.IS_MODEL_A_VEHICLE(hash) == 1 then
				spawn(hash)
			else
				system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Sorry I couldn't find any matching model"], settings.General["HudColorNotifyError"], true)
				utils.hud_sound("ERROR")
			end
		end
	end, {"spawn"})
	local search_vehicle
	local veh_preview
	local hash
	local results = {}
	__submenus["SearchVehicles"] = ui.add_submenu(TRANSLATION["Search"])
	__suboptions["SearchVehicles"] = ui.add_sub_option(TRANSLATION["Search"], __submenus["SpawnVeh"], __submenus["SearchVehicles"])

	__options.string["SearchVeh"] = ui.add_input_string(TRANSLATION["Name"], __submenus["SearchVehicles"], function(text)
		search_vehicle = nil
		for i = 1, #results
		do
			ui.remove(results[i])
			results[i] = nil
		end
		text = text:lower()
		if #text < 3 then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Please enter name with at least 3 characters"], settings.General["HudColorNotifyError"]) utils.hud_sound("ERROR") return POP_THREAD end
		local count = 0
		text = text:escpattern():ensurestart('^')
		for i, v in ipairs(vehicles.data)
		do
			if v.Name:find(text) or (v.DisplayName and v.DisplayName:lower():find(text)) or vehicles.get_label_name(v.Name):lower():find(text) then
				insert(results, ui.add_click_option(vehicles.get_label_name(v.Name), __submenus["SearchVehicles"], function()
					utils.hud_sound("SELECT")
					if i == veh_preview or not settings.Vehicle["VehPreview"] then
						spawn(utils.joaat(v.Name))
					elseif i ~= veh_preview then
						search_vehicle = i
					end
				end))
				count = count + 1
			end
		end
		if count == 0 then
			system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Sorry I couldn't find any matching model"], settings.General["HudColorNotifyError"])
			utils.hud_sound("ERROR")
		end
	end)

	local sel_class = ui.add_choose(TRANSLATION["Select class"], __submenus["SpawnVeh"], true, classes, function(int) class = int
		utils.hud_sound("YES")
		if curr_class then 
			ui.remove(curr_class)
			curr_class = nil
		end
	end)
	ui.set_value(sel_class, class, true)
	system.thread(true, 'selected_class_'..system.thread_count(), function()
		if not curr_class then
			curr_class = ui.add_choose(TRANSLATION["Select vehicle"], __submenus["SpawnVeh"], false, settings.Vehicle["VehManufacturer"] and vehicles.class_manufacturer[class] or vehicles.class[class], function(int) utils.hud_sound("YES")
				selected_vehicle = int + 1
				spawn(vehicles.models[vehicles.get_veh_index(ui.get_value(curr_class) + 1, class)][2])
			end)
			if value then
				ui.set_value(curr_class, value, true)
				value = nil
			end
		end
	end)

	system.thread(true, 'display_vehicle_preview', function()
		if not settings.Vehicle["VehPreview"] or not (ui.is_sub_open(__submenus["SpawnVeh"]) or ui.is_sub_open(__submenus["SearchVehicles"])) then 
			if Global.created_preview then
				entities.delete(Global.created_preview)
				Global.created_preview = nil
				veh_preview = nil
			end
			return
		end
		if not curr_class then return end
		local selected = ui.get_value(curr_class) + 1
		if (ui.is_sub_open(__submenus["SpawnVeh"]) and veh_preview ~= vehicles.get_veh_index(selected, class)) or (search_vehicle and ui.is_sub_open(__submenus["SearchVehicles"]) and veh_preview ~= search_vehicle) then
			if hash then
				STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
			end
			veh_preview = ui.is_sub_open(__submenus["SearchVehicles"]) and search_vehicle or vehicles.get_veh_index(selected, class)
			hash = vehicles.models[veh_preview][2]
			if Global.created_preview then
				entities.delete(Global.created_preview)
				Global.created_preview = nil
			end
		end
		if not Global.created_preview then
			if features.request_model(hash) == 0 then return end
			local pos = features.get_offset_coords_from_entity_rot(features.player_ped(), 5, 0, true) + vector3.up(1.5)
			Global.created_preview = vehicles.spawn_vehicle(hash, pos)
			NETWORK._NETWORK_SET_ENTITY_INVISIBLE_TO_NETWORK(Global.created_preview, true)
			NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(Global.created_preview), false)
			ENTITY.SET_ENTITY_COLLISION(Global.created_preview, false, false)
			ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Global.created_preview, pos.x, pos.y, pos.z, false, false, false)
			ENTITY.SET_ENTITY_ALPHA(Global.created_preview, 160, false)
			VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(Global.created_preview, "Nightfal")
			if settings.Vehicle["SpawnerPerformancePreset"] == 1 then
				vehicles.upgrade(Global.created_preview)
			elseif settings.Vehicle["SpawnerPerformancePreset"] == 2 then
				vehicles.upgrade(Global.created_preview)
				VEHICLE.SET_VEHICLE_MOD(Global.created_preview, 48, -1, false)
			elseif settings.Vehicle["SpawnerPerformancePreset"] == 3 then
				vehicles.performance(Global.created_preview)
			elseif settings.Vehicle["SpawnerPerformancePreset"] == 4 then
				vehicles.performance(Global.created_preview)
				local num = VEHICLE.GET_NUM_VEHICLE_MODS(Global.created_preview, 0) - 1
				VEHICLE.SET_VEHICLE_MOD(Global.created_preview, 0, num, false)
			end
			STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
		else
			if ENTITY.DOES_ENTITY_EXIST(Global.created_preview) == 0 then Global.created_preview = nil return end
			local max = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(hash) - 2
		    for i = -1, max do
		    	local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(Global.created_preview, i, true)
		    	if ped ~= 0 then
		    		TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
		    	end
		    end
			features.request_control_once(Global.created_preview)
			vehicles.set_godmode(Global.created_preview, true)
			local model_dim_max, model_dim_max = features.get_model_dimentions(ENTITY.GET_ENTITY_MODEL(Global.created_preview))
			local pos = features.get_offset_coords_from_entity_rot(features.player_ped(), 3 + model_dim_max.y, 0, true) + vector3.up(model_dim_max.z)
			features.draw_box_on_entity2(Global.created_preview, pos)
			ENTITY.SET_ENTITY_COLLISION(Global.created_preview, false, false)
			ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Global.created_preview, pos.x, pos.y, pos.z, false, false, false)
			ENTITY.SET_ENTITY_ALPHA(Global.created_preview, 160, false)
			local rot = features.get_entity_rot(Global.created_preview)
			ENTITY.SET_ENTITY_ROTATION(Global.created_preview, 0, 0, rot.z - 1, 2, true)
		end
	end)
end

local function LastVehicleAction(last_veh, int)
	if int == 0 then
		system.thread(true, 'seat_change_'..system.thread_count(), function(tick)
			if tick == 100 then return POP_THREAD end
			features.request_control_once(last_veh)
			local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(last_veh, -1, true)
			if ped and ped ~= features.player_ped() then
				TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
			end
			PED.SET_PED_INTO_VEHICLE(features.player_ped(), last_veh, -1)
			if VEHICLE.GET_PED_IN_VEHICLE_SEAT(last_veh, -1, true) ~= features.player_ped() then return end
			return POP_THREAD
		end)
	elseif int == 1 then
		local dim_max = select(2, features.get_model_dimentions(ENTITY.GET_ENTITY_MODEL(last_veh))).x
		local pos = features.get_offset_from_entity_in_world_coords(last_veh, vector3.left(dim_max + 1))
		features.teleport_entity(features.player_ped(), pos.x, pos.y, pos.z)
		ENTITY.SET_ENTITY_HEADING(features.player_ped(), ENTITY.GET_ENTITY_HEADING(last_veh) - 90)
	elseif int == 2 then
		entities.request_control(last_veh, function()
			local dim_max = select(2, features.get_model_dimentions(ENTITY.GET_ENTITY_MODEL(last_veh))).y
			local pos = features.get_offset_from_player_coords(vector3.forward(dim_max + 3))
			features.teleport(last_veh, pos.x, pos.y, pos.z, features.get_player_heading())
			VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(last_veh, 0)
		end)
	elseif int == 3 then
		entities.request_control(last_veh, function()
			local dim_max = select(2, features.get_model_dimentions(ENTITY.GET_ENTITY_MODEL(last_veh))).y
			local pos = features.get_offset_from_player_coords(vector3.forward(dim_max + 3))
			features.teleport(last_veh, pos.x, pos.y, pos.z, features.get_player_heading())
			VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(last_veh, 0)
			system.thread(true, 'seat_change_'..system.thread_count(), function(tick)
				if tick == 100 then return POP_THREAD end
				features.request_control_once(last_veh)
				local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(last_veh, -1, true)
				if ped and ped ~= features.player_ped() then
					TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
				end
				PED.SET_PED_INTO_VEHICLE(features.player_ped(), last_veh, -1)
				if VEHICLE.GET_PED_IN_VEHICLE_SEAT(last_veh, -1, true) ~= features.player_ped() then return end
				return POP_THREAD
			end)
		end)
	end
end

ui.add_separator(TRANSLATION["Quick actions"], __submenus["Vehicle"])

__options.choose["PersonalVehicle"] = ui.add_choose(TRANSLATION["Personal vehicle"], __submenus["Vehicle"], false, {TRANSLATION["Drive"], TRANSLATION["Teleport me to..."], TRANSLATION["Teleport to me"], TRANSLATION["Teleport to me and drive"]}, function(int)
	if utils.show_info("personal [choose]") then return end
	local last_veh = vehicles.get_personal_vehicle()
	if last_veh ~= 0 and last_veh == vehicles.get_player_vehicle() then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Aren't you already in?"], settings.General["HudColorNotifyError"]) return utils.hud_sound("ERROR") end
	if last_veh == 0 or HUD.GET_BLIP_FROM_ENTITY(last_veh) == 0 then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Personal vehicle not found"], settings.General["HudColorNotifyError"]) return utils.hud_sound("ERROR") end
	utils.hud_sound("YES")
	LastVehicleAction(last_veh, int)
end, {"personal"})

__options.choose["LasetVehicle"] = ui.add_choose(TRANSLATION["Last vehicle"], __submenus["Vehicle"], false, {TRANSLATION["Drive"], TRANSLATION["Teleport me to..."], TRANSLATION["Teleport to me"], TRANSLATION["Teleport to me and drive"]}, function(int)
	if utils.show_info("lastveh [choose]") then return end
	local last_veh = vehicles.get_player_last_vehicle()
	if last_veh == 0 then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Last vehicle not found"], settings.General["HudColorNotifyError"]) return utils.hud_sound("ERROR") end
	if last_veh == vehicles.get_player_vehicle() then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Aren't you already in?"], settings.General["HudColorNotifyError"]) return utils.hud_sound("ERROR") end
	utils.hud_sound("YES")
	LastVehicleAction(last_veh, int)
end, {"lastveh"})


ui.add_click_option(TRANSLATION["Repair vehicle"], __submenus["Vehicle"], function()
	if utils.show_info("fixveh, repair") then return end
	local veh = vehicles.get_player_vehicle()
	if veh == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	entities.request_control(veh, function()
		vehicles.repair(veh)
	end)
end, {"fixveh", "repair"})

ui.add_click_option(TRANSLATION["Clean vehicle"], __submenus["Vehicle"], function()
	if utils.show_info("cleanveh, repair") then return end
	local veh = vehicles.get_player_vehicle()
	if veh == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	entities.request_control(veh, function()
		VEHICLE.SET_VEHICLE_DIRT_LEVEL(veh, 0)
		VEHICLE.SET_VEHICLE_ENVEFF_SCALE(veh, 0)
	end)
end, {"cleanveh"})

do
	ui.add_click_option(TRANSLATION["Add blip to vehicle"], __submenus["Vehicle"], function()
		if utils.show_info("addvehblip") then return end
		local veh = vehicles.get_player_vehicle()
		if veh == 0 then return utils.hud_sound("ERROR") end
		if veh == vehicles.get_personal_vehicle() then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["You can't do this on personal vehicle"], settings.General["HudColorNotifyError"]) return utils.hud_sound("ERROR") end
		utils.hud_sound("SELECT")
		if HUD.GET_BLIP_FROM_ENTITY(veh) ~= 0 then
			features.remove_blip(HUD.GET_BLIP_FROM_ENTITY(veh))
			return
		end
		local blip = HUD.ADD_BLIP_FOR_ENTITY(veh)
		insert(Global.vehicle_blips, {veh, blip})
		HUD.SET_BLIP_SPRITE(blip, enum.blip_sprite.gang_vehicle)
		HUD.SET_BLIP_COLOUR(blip, enum.blip_color.Yellow)
		HUD.SET_BLIP_NAME_FROM_TEXT_FILE(blip, VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(ENTITY.GET_ENTITY_MODEL(veh)))
	end, {"addvehblip"})

	system.thread(true, 'vehicle_blips', function()
		for i, v in pairs(Global.vehicle_blips)
		do
			if ENTITY.DOES_ENTITY_EXIST(v[1]) == 0 or ENTITY.GET_ENTITY_HEALTH(v[1]) == 0 or HUD.DOES_BLIP_EXIST(v[2]) == 0 then
				features.remove_blip(v[2])
				table.remove(Global.vehicle_blips, i)
				break
			end
		end
	end)
end

ui.add_separator(TRANSLATION["Mods"], __submenus["Vehicle"])

local veh_customs = {}
veh_customs.sub_mods = ui.add_submenu(TRANSLATION["Vehicle customs"])
veh_customs.subopt_mods = ui.add_sub_option(TRANSLATION["Vehicle customs"], __submenus["Vehicle"], veh_customs.sub_mods)
--ui.hide(veh_customs.subopt_mods, true)

__submenus["ChangeSound"] = ui.add_submenu(TRANSLATION["Change sound"])
__suboptions["ChangeSound"] = ui.add_sub_option(TRANSLATION["Change sound"], __submenus["Vehicle"], __submenus["ChangeSound"])

do
	local selected_vehicle = 1
	local class = 0
	local classes = {}
	local curr_class
	for i = 0, 62
	do
		insert(classes, enum.vehicle_class[i])
	end
	local function change_sound()
		local veh = vehicles.get_player_vehicle()
		if veh == 0 then return end
		AUDIO._FORCE_VEHICLE_ENGINE_AUDIO(veh, vehicles.models[vehicles.get_veh_index(ui.get_value(curr_class) + 1, class)][1])
	end
	local sel_class = ui.add_choose(TRANSLATION["Select class"], __submenus["ChangeSound"], true, classes, function(int) class = int
		utils.hud_sound("YES")
		if curr_class then 
			ui.remove(curr_class)
			curr_class = nil
		end
	end)
	ui.set_value(sel_class, class, true)
	system.thread(true, 'selected_class_'..system.thread_count(), function()
		if not curr_class then
			curr_class = ui.add_choose(TRANSLATION["Select vehicle"], __submenus["ChangeSound"], false, settings.Vehicle["VehManufacturer"] and vehicles.class_manufacturer[class] or vehicles.class[class], function(int)
				utils.hud_sound("YES")
				selected_vehicle = int + 1
				change_sound()
			end)
		end
	end)
end

__options.bool["VehInvincibility"] = ui.add_bool_option(TRANSLATION["Invincibility"], __submenus["Vehicle"], function(bool)
	if utils.show_info("vehgod [on - off]") then ui.set_value(__options.bool["VehInvincibility"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Vehicle["VehInvincibility"] = bool
	system.thread(bool, 'vehicle_invincibility', function()
		if vehicles.get_player_vehicle() == 0 or vehicles.get_ped_seat(features.player_ped()) ~= -1 then return end
		vehicles.set_godmode(vehicles.get_player_vehicle(), true, true)
	end)
	if not bool then
		vehicles.set_godmode(vehicles.get_player_vehicle(), false, true)
	else
		vehicles.repair(vehicles.get_player_vehicle())
	end
end, {"vehgod"})

__options.bool["InvisibleVehicle"] = ui.add_bool_option(TRANSLATION["Invisible"], __submenus["Vehicle"], function(bool)
	if utils.show_info("vehinvisible [on - off]") then ui.set_value(__options.bool["InvisibleVehicle"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	system.thread(bool, 'vehicle_invisible', function()
		if vehicles.get_player_vehicle() == 0 then return end
		features.request_control_once(vehicles.get_player_vehicle())
		ENTITY.SET_ENTITY_VISIBLE(vehicles.get_player_vehicle(), false, false)
		NETWORK._NETWORK_SET_ENTITY_INVISIBLE_TO_NETWORK(vehicles.get_player_vehicle(), false)
		ENTITY.SET_ENTITY_VISIBLE(features.player_ped(), true, false)
	end)
	if not bool then
		NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicles.get_player_vehicle())
		NETWORK._NETWORK_SET_ENTITY_INVISIBLE_TO_NETWORK(vehicles.get_player_vehicle(), true)
		ENTITY.SET_ENTITY_VISIBLE(vehicles.get_player_vehicle(), true, false) 
	end
end, {"vehinvisible"})

__options.bool["ScorchedVehicle"] = ui.add_bool_option(TRANSLATION["Scorched vehicle"], __submenus["Vehicle"], function(bool)
	if utils.show_info("scorchedveh [on - off]") then ui.set_value(__options.bool["ScorchedVehicle"], not bool, true) return end
	if vehicles.get_player_vehicle() == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("TOGGLE_ON")
	ENTITY.SET_ENTITY_RENDER_SCORCHED(vehicles.get_player_vehicle(), bool)
end, {"scorchedveh"})

__options.bool["SlidyVehicle"] = ui.add_bool_option(TRANSLATION["Slidy vehicle"], __submenus["Vehicle"], function(bool)
	if utils.show_info("slidyveh [on - off]") then ui.set_value(__options.bool["SlidyVehicle"], not bool, true) return end
	if vehicles.get_player_vehicle() == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("TOGGLE_ON")
	VEHICLE.SET_VEHICLE_REDUCE_GRIP(vehicles.get_player_vehicle(), bool)
end, {"slidyveh"})

__options.bool["LicenceSpeedo"] = ui.add_bool_option(TRANSLATION["Licence plate speedo"], __submenus["Vehicle"], function(bool)
	if utils.show_info("licencespeedo [on - off]") then ui.set_value(__options.bool["LicenceSpeedo"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Vehicle['LicenceSpeedo'] = bool
	local mult
	local unit
	system.thread(bool, 'vehicle_licence_speedo', function()
		if vehicles.get_player_vehicle() == 0 then return end
		if MISC.SHOULD_USE_METRIC_MEASUREMENTS() == 1 then
			mult = 3.6
			unit = 'kmph'
		else
			mult = 2.236936
			unit = 'mph'
		end
		local speed = ENTITY.GET_ENTITY_SPEED(vehicles.get_player_vehicle())
		VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicles.get_player_vehicle(), tostring(floor(speed * mult))..' '..unit)
	end)
end, {"licencespeedo"})

__options.bool["ScrollingLicence"] = ui.add_bool_option(TRANSLATION["Scrolling licence plate"], __submenus["Vehicle"], function(bool)
	if utils.show_info("scrollplate") then ui.set_value(__options.bool["ScrollingLicence"], not bool, true) return end
	settings.Vehicle["ScrollingLicence"] = bool
	utils.hud_sound("TOGGLE_ON")
	local text = tostring(settings.Vehicle["ScrollingLicenceText"])
	Global.scroll_text = (" " * 8)..text
	local pos = 0
	local wait = clock() + .2
	system.thread(bool, 'scrollplate', function(tick)
		if text ~= tostring(settings.Vehicle["ScrollingLicenceText"]) then
			text = tostring(settings.Vehicle["ScrollingLicenceText"])
			Global.scroll_text = (" " * 8)..text
			pos = 1
		end
		local veh = vehicles.get_player_vehicle()
		if veh == 0 then pos = 0 return end
		if wait > clock() then return end
		wait = clock() + .2
		pos = pos + 1
		VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(veh, Global.scroll_text:sub(pos, pos + 8):lpad(8, " "))
		if pos == Global.scroll_text:len() then pos = 0 end
	end)
end, {"scrollplate"})

__options.string["ScrollingLicenceText"] = ui.add_input_string(TRANSLATION["Text"], __submenus["Vehicle"], function(text)
	if utils.show_info("scrollplatetxt") then ui.set_value(__options.string["ScrollingLicenceText"], tostring(settings.Vehicle["ScrollingLicenceText"]), true) return end
	settings.Vehicle["ScrollingLicenceText"] = text:upper()
end, {"scrollplatetxt"})

__options.num["VehicleAlpha"] = ui.add_num_option(TRANSLATION["Set alpha"], __submenus["Vehicle"], 0, 255, 1, function(int)
	if utils.show_info("vehalpha [0 - 255]") then return end
	local veh = vehicles.get_player_vehicle()
	if veh == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("YES")
	entities.request_control(veh, function()
		ENTITY.SET_ENTITY_ALPHA(veh, int, false)
		if int == 255 then
			ENTITY.RESET_ENTITY_ALPHA(veh)
		end
	end)
end, {"vehalpha"})

ui.add_separator(TRANSLATION["Control"], __submenus["Vehicle"])

__submenus["HornBoost"] = ui.add_submenu(TRANSLATION["Horn boost"])
__suboptions["HornBoost"] = ui.add_sub_option(TRANSLATION["Horn boost"], __submenus["Vehicle"], __submenus["HornBoost"])

__submenus["VehMultipliers"] = ui.add_submenu(TRANSLATION["Multipliers"])
__suboptions["VehMultipliers"] = ui.add_sub_option(TRANSLATION["Multipliers"], __submenus["Vehicle"], __submenus["VehMultipliers"])

__submenus["VehicleDoors"] = ui.add_submenu(HUD._GET_LABEL_TEXT("PIM_TDPV"))
__suboptions["VehicleDoors"] = ui.add_sub_option(HUD._GET_LABEL_TEXT("PIM_TDPV"), __submenus["Vehicle"],__submenus["VehicleDoors"])

__submenus["VehFly"] = ui.add_submenu(TRANSLATION["Vehicle fly"])
__suboptions["VehFly"] = ui.add_sub_option(TRANSLATION["Vehicle fly"], __submenus["Vehicle"], __submenus["VehFly"])

__submenus["EnterExitVeh"] = ui.add_submenu(TRANSLATION["Enter/exit"])
__suboptions["EnterExitVeh"] = ui.add_sub_option(TRANSLATION["Enter/exit"], __submenus["Vehicle"], __submenus["EnterExitVeh"])

__options.bool["VehicleRapidFire"] = ui.add_bool_option(TRANSLATION["Vehicle rapid fire"], __submenus["Vehicle"], function(bool)
	if utils.show_info("vehrapid [on - off]") then ui.set_value(__options.bool["VehicleRapidFire"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Vehicle["VehicleRapidFire"] = bool
	system.thread(bool, 'vehicle_rapid_fire',
	function()
		local veh = vehicles.get_player_vehicle()
		if veh == 0 then return end
		VEHICLE.SET_VEHICLE_FIXED(veh)
		VEHICLE.SET_VEHICLE_DEFORMATION_FIXED(veh)
	end)
end, {"vehrapid"})

__options.bool["SuperHandbrake"] = ui.add_bool_option(TRANSLATION["Super handbrake"], __submenus["Vehicle"], function(bool)
	if utils.show_info("superhandbrake [on - off]") then ui.set_value(__options.bool["SuperHandbrake"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Vehicle['SuperHandbrake'] = bool
	system.thread(bool, 'vehicle_handbrake', function()
		local veh = vehicles.get_player_vehicle()
		if veh == 0 or PAD.IS_CONTROL_PRESSED(0, enum.input.VEH_HANDBRAKE) == 0 then return end
		entities.request_control(veh, function()
			features.set_entity_velocity(veh, 0, 0, 0)
		end)
	end)
end, {"superhandbrake"})

__options.bool["AutoFlip"] = ui.add_bool_option(TRANSLATION["Auto flip"], __submenus["Vehicle"], function(bool)
	if utils.show_info("autoflip [on - off]") then ui.set_value(__options.bool["AutoFlip"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Vehicle['AutoFlip'] = bool
	system.thread(bool, 'vehicle_auto_flip', function()
		if vehicles.get_player_vehicle() == 0 then return end
		local veh = vehicles.get_player_vehicle()
		local rot = features.get_entity_rot(veh)
		if ENTITY.IS_ENTITY_IN_AIR(veh) == 0 and (rot.y < -110 or rot.y > 110) then
			if VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(veh) == 0 then
				features.request_control_once(veh)
				ENTITY.SET_ENTITY_ROTATION(veh, 0, 0, rot.z, 5, true)
				VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(veh, 0)
			end
		end
	end)
end, {"autoflip"})

__options.bool["EngineAlwaysOn"] = ui.add_bool_option(TRANSLATION["Engine always on"], __submenus["Vehicle"], function(bool)
	if utils.show_info("enginealwayson [on - off]") then ui.set_value(__options.bool["EngineAlwaysOn"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Vehicle['EngineAlwaysOn'] = bool
	system.thread(bool, 'vehicle_always_on_engine', function()
		if vehicles.get_player_vehicle() == 0 then return end
		VEHICLE.SET_VEHICLE_ENGINE_ON(vehicles.get_player_vehicle(), true, true, false)
		system.reset_thread_tick()
	end)
end, {"enginealwayson"})

__options.bool["MaxSpeedBypass"] = ui.add_bool_option(TRANSLATION["Max speed bypass"], __submenus["Vehicle"], function(bool)
	if utils.show_info("speedbypass [on - off]") then ui.set_value(__options.bool["MaxSpeedBypass"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Vehicle["MaxSpeedBypass"] = bool
	system.thread(bool, 'vehicle_speed_bypass', function()
		local veh = vehicles.get_player_vehicle()
		if veh == 0 then return end
		ENTITY.SET_ENTITY_MAX_SPEED(veh, 10000000)
	end)
	if not bool then
		ENTITY.SET_ENTITY_MAX_SPEED(vehicles.get_player_vehicle(), 164.592)
	end
end, {"speedbypass"})

__options.bool["NoTurbulence"] = ui.add_bool_option(TRANSLATION["No turbulence"], __submenus["Vehicle"], function(bool)
	if utils.show_info("noturbulence [on - off]") then ui.set_value(__options.bool["NoTurbulence"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Vehicle["NoTurbulence"] = bool
	system.thread(bool, 'vehicle_no_turbulence', function()
		local veh = vehicles.get_player_vehicle()
		if veh == 0 then return end
		VEHICLE.SET_PLANE_TURBULENCE_MULTIPLIER(veh, 0)
	end)
end, {"noturbulence"})

__options.bool["StickToGround"] = ui.add_bool_option(TRANSLATION["Stick to ground"], __submenus["Vehicle"], function(bool)
	if utils.show_info("sticktoground [on - off]") then ui.set_value(__options.bool["StickToGround"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Vehicle["StickToGround"] = bool
	local fails = 0
	system.thread(bool, 'vehicle_stick_to_ground', function()
		local veh = vehicles.get_player_vehicle()
		if veh == 0 or ENTITY.IS_ENTITY_IN_AIR(veh) == 0 then return end
		if VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(veh, 5) == 0 then
			fails = fails + 1
		end
		if fails < 10 then return end
		fails = 0
		local pos = features.get_player_coords()
		local success, Z = features.get_ground_z(pos)
		if not success or Z + 5 > pos.z then return end
		features.teleport(veh, pos.x, pos.y, Z)
	end)
end, {"sticktoground"})

__options.bool["DisableVehicleCollision"] = ui.add_bool_option(TRANSLATION["Disable collision"], __submenus["Vehicle"], function(bool)
	if utils.show_info("vehnocollision [on - off]") then ui.set_value(__options.bool["DisableVehicleCollision"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	system.thread(bool, 'vehicle_invisible', function()
		if vehicles.get_player_vehicle() == 0 then return end
		features.request_control_once(vehicles.get_player_vehicle())
		ENTITY.SET_ENTITY_COLLISION(vehicles.get_player_vehicle(), false, true)
	end)
	if not bool then
		entities.request_control(vehicles.get_player_vehicle(), function()
			ENTITY.SET_ENTITY_COLLISION(vehicles.get_player_vehicle(), true, true)
		end)
	end
end, {"vehnocollision"})

do
	local pressed
	__options.choose["VehicleJumping"] = ui.add_choose(TRANSLATION["Vehicle jump"], __submenus["Vehicle"], true, {TRANSLATION['None'], TRANSLATION["Press"], TRANSLATION['Hold']}, function(int)
		if utils.show_info("vehjump [choose]") then ui.set_value(__options.choose["VehicleJumping"],settings.Vehicle["VehicleJumping"], true) return end
		utils.hud_sound("YES") settings.Vehicle["VehicleJumping"] = int
	end, {"vehjump"})

	system.thread(true, 'vehicle_jump', function()
  		if Global.onscreen_keyboard then return end

		if settings.Vehicle["VehicleJumping"] == 0 then return end
		local veh = vehicles.get_player_vehicle()
		if veh == 0 then return end
		PAD.DISABLE_CONTROL_ACTION(0, enum.input.VEH_HANDBRAKE, true)
		if settings.Vehicle["VehicleJumping"] == 1 then
			if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.VEH_HANDBRAKE) == 1 and ENTITY.IS_ENTITY_IN_AIR(veh) == 0 then
				if pressed then return end
				local vel = ENTITY.GET_ENTITY_VELOCITY(veh)
	      features.set_entity_velocity(veh, vel.x, vel.y, vel.z + 10)
	      pressed = true
	    elseif pressed then
	    	pressed = nil
	    end
	    return
		end
		if settings.Vehicle["VehicleJumping"] == 2 then
			if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.VEH_HANDBRAKE) == 1 then
				local vel = ENTITY.GET_ENTITY_VELOCITY(veh)
	      features.set_entity_velocity(veh, vel.x, vel.y, vel.z + 2)
	    end
	  end
	end)
end

ui.add_separator(TRANSLATION["Other"], __submenus["Vehicle"])

__submenus["VehicleWeapons"] = ui.add_submenu(TRANSLATION["Vehicle weapons"])
__suboptions["VehicleWeapons"] = ui.add_sub_option(TRANSLATION["Vehicle weapons"], __submenus["Vehicle"],__submenus["VehicleWeapons"])

do
	local types = {TRANSLATION['Constant'] ,TRANSLATION['Non constant']}
	__options.bool["BoostEffect"] = ui.add_bool_option(TRANSLATION["With effect"], __submenus["HornBoost"], function(bool)
		if utils.show_info("boosteffect [on - off]") then ui.set_value(__options.bool["BoostEffect"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") settings.Vehicle["BoostEffect"] = bool
	end, {"boosteffect"})
	__options.choose["AccelerationType"] = ui.add_choose(TRANSLATION["Acceleration type"], __submenus["HornBoost"], true, types, function(int)
		if utils.show_info("boosttype [choose]") then ui.set_value(__options.choose["BoostEffect"], settings.Vehicle["AccelerationType"], true) return end
		utils.hud_sound("YES") settings.Vehicle["AccelerationType"] = int
	end, {"boosttype"})
	__options.num["HornBoostPower"] = ui.add_num_option(TRANSLATION["Horn boost power"], __submenus["HornBoost"], 1, 20, 1, function(int)
		if utils.show_info("boostpower [1 - 20]") then ui.set_value(__options.num["HornBoostPower"], settings.Vehicle["HornBoostPower"], true) return end
		utils.hud_sound("YES") settings.Vehicle["HornBoostPower"] = int
	end, {"boostpower"})
end

__options.bool["HornBoost"] = ui.add_bool_option(TRANSLATION["Horn boost"], __submenus["HornBoost"], function(bool)
	if utils.show_info("hornboost [on - off]") then ui.set_value(__options.bool["HornBoost"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Vehicle['HornBoost'] = bool
	system.thread(bool, 'vehicle_horn_boost', function()
		if vehicles.get_player_vehicle() == 0 or PAD.IS_CONTROL_PRESSED(0, enum.input.VEH_HORN) == 0 then return end
		local veh = vehicles.get_player_vehicle()
		features.request_control_once(veh)
		ENTITY.SET_ENTITY_MAX_SPEED(veh, 10000000)
		local speed = ENTITY.GET_ENTITY_SPEED(veh)
		if settings.Vehicle["BoostEffect"] then AUDIO.SET_VEHICLE_BOOST_ACTIVE(veh, true) GRAPHICS.ANIMPOSTFX_PLAY("DrivingFocusOut", 0, false) end
		if settings.Vehicle["AccelerationType"] == 0 then
			speed = speed + settings.Vehicle["HornBoostPower"]
		elseif settings.Vehicle["AccelerationType"] == 1 then
			if speed < 1 then speed = 1 end
			speed = speed + speed * settings.Vehicle["HornBoostPower"] / 100
		end
		VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, speed)
		if settings.Vehicle["BoostEffect"] then AUDIO.SET_VEHICLE_BOOST_ACTIVE(veh, false) GRAPHICS.ANIMPOSTFX_STOP("DrivingFocusOut") end
	end)
	
end, {"hornboost"})

__options.bool["InstaEnter/ExitVehicle"] = ui.add_bool_option(TRANSLATION["Instant enter/exit vehicle"], __submenus["EnterExitVeh"], function(bool)
	if utils.show_info("vehinstaenter [on - off]") then ui.set_value(__options.bool["InstaEnter/ExitVehicle"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Vehicle['InstaEnter/ExitVehicle'] = bool
	system.thread(bool, 'vehicle_insta_exit', function()
  		if Global.onscreen_keyboard then return end

		PAD.DISABLE_CONTROL_ACTION(0, enum.input.VEH_EXIT, true)
		if ENTITY.IS_ENTITY_DEAD(features.player_ped(), false) == 1 then return end
		if vehicles.get_player_vehicle() == 0 and PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, enum.input.VEH_EXIT) == 1 then
			local veh, dist = vehicles.get_closest_vehicle(features.get_player_coords())
			if features.compare(veh, Global.created_preview, Global.created_preview2) then return end
			local _veh = features.get_parent_attachment(veh)
			if ENTITY.IS_ENTITY_A_VEHICLE(_veh) then
				veh = _veh
			end
			local seat = vehicles.get_first_free_seat(veh)
			if settings.Vehicle["InstaEnter/ExitVehicleForceDriver"] then seat = -1 end
			if not seat or dist > 400 then return end
			system.thread(true, 'seat_change_'..system.thread_count(), function(tick)
				if tick == 100 then return POP_THREAD end
				features.request_control_once(veh)
				local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, seat, true)
				if ped and ped ~= features.player_ped() then
					TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
				end
				PED.SET_PED_INTO_VEHICLE(features.player_ped(), veh, seat)
				if VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, seat, true) ~= features.player_ped() then return end
				return POP_THREAD
			end)
		elseif PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, enum.input.VEH_EXIT) == 1 then
			local pos = features.get_space_near_vehicle(vehicles.get_player_vehicle())
			features.teleport_entity(features.player_ped(), pos.x, pos.y, pos.z)
		end
	end)
end, {"vehinstaenter", "instaenter"})

__options.bool["InstaEnter/ExitVehicleForceDriver"] = ui.add_bool_option(TRANSLATION["Force driver seat"], __submenus["EnterExitVeh"], function(bool)
	if utils.show_info("vehforcedriver [on - off]") then ui.set_value(__options.bool["InstaEnter/ExitVehicleForceDriver"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON") settings.Vehicle["InstaEnter/ExitVehicleForceDriver"] = bool
end, {"vehforcedriver"})
__options.bool["StopVehWhenExit"] = ui.add_bool_option(TRANSLATION["Stop vehicle when exiting"], __submenus["EnterExitVeh"], function(bool)
	if utils.show_info("vehstoponexit [on - off]") then ui.set_value(__options.bool["StopVehWhenExit"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Vehicle["StopVehWhenExit"] = bool
	local veh
	system.thread(bool, 'veh_stop', function()
  		if Global.onscreen_keyboard then return end
		if vehicles.get_player_vehicle() ~= veh then
			veh = vehicles.get_player_vehicle()
		end
		if PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, enum.input.VEH_EXIT) == 1 and vehicles.get_player_vehicle() ~= 0 then
			features.request_control_once(veh)
			VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, 0)
			veh = nil
		end
	end)
end, {"vehstoponexit"})

do
	ui.add_separator(TRANSLATION["Open/close"], __submenus["VehicleDoors"])
	ui.add_click_option(TRANSLATION["Open all"], __submenus["VehicleDoors"], function()
		if utils.show_info("opendoors") then return end
		local veh = vehicles.get_player_vehicle()
		if veh == 0 then return utils.hud_sound("ERROR") end
		utils.hud_sound("SELECT")
		entities.request_control(veh, function()
			for i = 0, 5
			do
			VEHICLE.SET_VEHICLE_DOOR_OPEN(veh, i, false, false)
			end
		end)
	end, {"opendoors"})
	ui.add_click_option(TRANSLATION["Close all"], __submenus["VehicleDoors"], function()
		if utils.show_info("closedoors") then return end
		local veh = vehicles.get_player_vehicle()
		if veh == 0 then return utils.hud_sound("ERROR") end
		utils.hud_sound("SELECT")
		entities.request_control(veh, function()
			for i = 0, 5
			do
				VEHICLE.SET_VEHICLE_DOOR_SHUT(veh, i, false)
			end
		end)
	end, {"closedoors"})
	for i, v in ipairs(vehicles.door_index())
	do
		ui.add_click_option(v, __submenus["VehicleDoors"], function()
			if utils.show_info("vehdoors"..i) then return end
			local veh = vehicles.get_player_vehicle()
			if veh == 0 then return utils.hud_sound("ERROR") end
			utils.hud_sound("SELECT")
			entities.request_control(veh, function()
				if VEHICLE.GET_VEHICLE_DOOR_ANGLE_RATIO(veh, i) == 0 then
					VEHICLE.SET_VEHICLE_DOOR_OPEN(veh, i, false, false)
				else
					VEHICLE.SET_VEHICLE_DOOR_SHUT(veh, i, false)
				end
			end)
		end, {"vehdoors"..i})
	end
	ui.add_separator(TRANSLATION["Break"], __submenus["VehicleDoors"])
	ui.add_click_option(TRANSLATION["Break all"], __submenus["VehicleDoors"], function()
		if utils.show_info("breakvehdoors") then return end
		local veh = vehicles.get_player_vehicle()
		if veh == 0 then return utils.hud_sound("ERROR") end
		utils.hud_sound("SELECT")
		entities.request_control(veh, function()
			for i = 0, 5
			do
				VEHICLE._SET_VEHICLE_DOOR_CAN_BREAK(veh, i, true)
				VEHICLE.SET_VEHICLE_DOOR_BROKEN(veh, i, false)
			end
		end)
	end, {"breakvehdoors"})
	for i, v in ipairs(vehicles.door_index())
	do
		ui.add_click_option(v, __submenus["VehicleDoors"], function()
			if utils.show_info("breakvehdoors"..i) then return end
			local veh = vehicles.get_player_vehicle()
			if veh == 0 then return utils.hud_sound("ERROR") end
			utils.hud_sound("SELECT")
			entities.request_control(veh, function()
				VEHICLE._SET_VEHICLE_DOOR_CAN_BREAK(veh, i, true)
				VEHICLE.SET_VEHICLE_DOOR_BROKEN(veh, i, false)
			end)
		end, {"breakvehdoors"..i})
	end
end

ui.add_click_option(TRANSLATION["Allow saving"], __submenus["Vehicle"], function()
	if utils.show_info("allowvehsave") then return end
	local veh = vehicles.get_player_vehicle()
	if veh == 0 or not vehicles.is_player_driving_vehicle() then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	local net_hash = NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(PLAYER.PLAYER_ID())
	entities.request_control(veh, function()
		local pl_veh
		DECORATOR.DECOR_REGISTER("Player_Vehicle", 3)
		DECORATOR.DECOR_REGISTER("Previous_Owner", 3)
		DECORATOR.DECOR_REGISTER("Vehicle_Reward", 3)
		DECORATOR.DECOR_REGISTER("MPBitset", 3)
		DECORATOR.DECOR_REGISTER("Veh_Modded_By_Player", 3)
		if ENTITY.IS_ENTITY_VISIBLE(veh) == 1 then
			if DECORATOR.DECOR_EXIST_ON(veh, "Player_Vehicle") == 1 then
				DECORATOR.DECOR_SET_INT(veh, "Player_Vehicle", net_hash)
			else
				pl_veh = DECORATOR.DECOR_GET_INT(veh, "Player_Vehicle")
				DECORATOR.DECOR_SET_INT(veh, "Player_Vehicle", net_hash)
			end
			if pl_veh and pl_veh ~= -1 then
				DECORATOR.DECOR_SET_INT(veh, "Previous_Owner", pl_veh)
			end
		end
		if DECORATOR.DECOR_EXIST_ON(veh, "Vehicle_Reward") == 0 then
			DECORATOR.DECOR_SET_BOOL(veh, "Vehicle_Reward", true)
			DECORATOR.DECOR_SET_INT(veh, "Vehicle_Reward", net_hash)
		end
		local veh_modd = DECORATOR.DECOR_GET_INT(veh, "Veh_Modded_By_Player")
		if veh_modd ~= 0 and veh_modd ~= -1 then
			DECORATOR.DECOR_SET_INT(veh, "Veh_Modded_By_Player", -1)
		end
	end)
end, {"allowvehsave"})

__options.bool["ARSpeedo"] = ui.add_bool_option(TRANSLATION["AR speedo"], __submenus["Vehicle"], function(bool)
	if utils.show_info("arspeedo [on - off]") then ui.set_value(__options.bool["ARSpeedo"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Vehicle['ARSpeedo'] = bool
	local mult
	system.thread(bool, 'speedometer', function()
		local veh = vehicles.get_player_vehicle()
		if veh == 0 then return end
		if MISC.SHOULD_USE_METRIC_MEASUREMENTS() == 1 then
			mult = 3.6
		else
			mult = 2.236936
		end
		local speed = ENTITY.GET_ENTITY_SPEED(vehicles.get_player_vehicle())
		local dim = select(2, features.get_model_dimentions(ENTITY.GET_ENTITY_MODEL(veh)))
		local speed = floor(ENTITY.GET_ENTITY_SPEED(veh) * mult)
		local scale = features.get_ar_speedo_scale(dim.y + 1)
		local color = features.fix_color(ui.get_value(__options.color["HudColorARspeedo"]))
		local offset = features.get_ar_speedo_pos(veh, dim.y + 1, -10)
		local rot = features.get_final_cam_rot()
		local pos = features.get_next_speedo_num(offset, scale)
		local success, groundZ = features.get_ground_z(vector3(pos.x, pos.y, pos.z + 2))
		for i, v in ipairs(tostring(speed):totable())
		do
			pos = features.get_next_speedo_num(offset, i * scale)
			GRAPHICS.DRAW_MARKER(tonumber(v) + 10, pos.x, pos.y, (success and groundZ > pos.z) and groundZ + 1 or pos.z + .5, 0, 0, 0, 0, 0, rot.z, scale + .15, scale + .15, scale + .15, color.r, color.g, color.b, color.a, false, false, 1, false, 0, 0, false)
		end
	end)
end, {"arspeedo"})

do
	local last
	__options.num["VehicleAccelMult"] = ui.add_float_option(TRANSLATION["Acceleration multiplier"], __submenus["VehMultipliers"], 0, 500, .1, 2, function(float)
		if utils.show_info("vehaccel [0.0 - 500.0]") then ui.set_value(__options.num["VehicleAccelMult"], settings.Vehicle["VehicleAccelMult"], true) return end
		utils.hud_sound("YES")
		settings.Vehicle["VehicleAccelMult"] = features.round(float, 1)
	end, {"vehaccel"})
	__options.num["VehicleBrakeMult"] = ui.add_float_option(TRANSLATION["Brake multiplier"], __submenus["VehMultipliers"], 0, 500, .1, 2, function(float)
		if utils.show_info("vehbrake [0.0 - 500.0]") then ui.set_value(__options.num["VehicleBrakeMult"], settings.Vehicle["VehicleBrakeMult"], true) return end
		utils.hud_sound("YES") settings.Vehicle["VehicleBrakeMult"] = features.round(float, 1)
	end, {"vehbrake"})
	__options.num["VehicleHandlingMult"] = ui.add_float_option(TRANSLATION["Handling multiplier"], __submenus["VehMultipliers"], 0, 100, .1, 2, function(float)
		if utils.show_info("vehhandling [0.0 - 100.0]") then ui.set_value(__options.num["VehicleHandlingMult"], settings.Vehicle["VehicleHandlingMult"], true) return end
		utils.hud_sound("YES") settings.Vehicle["VehicleHandlingMult"] = features.round(float, 1)
	end, {"vehhandling"})
	__options.choose["SlamVehicle"] = ui.add_choose(TRANSLATION["Slam it"], __submenus["VehMultipliers"], true, {TRANSLATION["None"], "1","2","3","4","5"}, function(int)
		if utils.show_info("slamveh [choose]") then ui.set_value(__options.choose["SlamVehicle"], settings.Vehicle["SlamVehicle"], true) return end
		utils.hud_sound("YES") settings.Vehicle["SlamVehicle"] = int
	end, {"slamveh"})
	system.thread(true, 'veh_multipliers', function()
		local veh = vehicles.get_player_vehicle()
		if last and veh ~= last then
			vehicles.set_gravity(last, 9.8)
			last = nil
		end
		if veh == 0 or not vehicles.is_player_driving_vehicle() then return end
		last = veh
		local model = ENTITY.GET_ENTITY_MODEL(veh)
		if VEHICLE.IS_THIS_MODEL_A_HELI(model) == 0 and (VEHICLE.IS_THIS_MODEL_A_PLANE(model) == 1 or VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(veh) == 1) then 
			if settings.Vehicle["VehicleAccelMult"] ~= 0 and PAD.IS_CONTROL_PRESSED(0, enum.input.VEH_ACCELERATE) == 1 then
				features.apply_force_to_entity(veh, 1, 0, settings.Vehicle["VehicleAccelMult"] / 69, 0, 0, 0, 0, 0, true, true, true, false, true)
			end
			if settings.Vehicle["VehicleBrakeMult"] ~= 0 and PAD.IS_CONTROL_PRESSED(0, enum.input.VEH_BRAKE) == 1 then
				features.apply_force_to_entity(veh, 0, 0, 0 - settings.Vehicle["VehicleBrakeMult"], 0, 0, 0, 0, 0, true, true, true, false, true)
			end
			vehicles.set_gravity(veh, 9.8 + settings.Vehicle["VehicleHandlingMult"] * 0.402)
			if settings.Vehicle["VehicleHandlingMult"] ~= 0 and ENTITY.GET_ENTITY_SPEED_VECTOR(veh, true).y > 2 then
				local mult = settings.Vehicle["VehicleHandlingMult"]
				mult = mult == 100 and mult + ENTITY.GET_ENTITY_SPEED(veh) or mult
				if PAD._IS_USING_KEYBOARD(0) == 1 then
					if PAD.IS_CONTROL_PRESSED(0, enum.input.SCRIPT_PAD_RIGHT) == 1 then
						features.apply_force_to_entity(veh, 1, mult / 44, 0, 0, 0, 0, 0, 0, true, true, true, false, true)
					end
					if PAD.IS_CONTROL_PRESSED(0, enum.input.SCRIPT_PAD_LEFT) == 1 then
						features.apply_force_to_entity(veh, 1, (0 - mult) / 44, 0, 0, 0, 0, 0, 0, true, true, true, false, true)
					end
				else
					local normal = PAD.GET_CONTROL_NORMAL(2, enum.input.SCRIPT_LEFT_AXIS_X)
					if normal > .5 or normal < -0.5 then
						features.apply_force_to_entity(veh, 1, (mult * normal) / 44, 0, 0, 0, 0, 0, 0, true, true, true, false, true)
					end
				end
			end
			if settings.Vehicle["SlamVehicle"] ~= 0 then
				features.apply_force_to_entity(veh, 0, 0, 0, -settings.Vehicle["SlamVehicle"] * 30, 0, 0, 0, 0, true, false, true, false, true)
			end
		end
	end)
end

do
	local types = {TRANSLATION['Keyboard'], TRANSLATION['Cam fly'], TRANSLATION['Glide fly']}
	__options.choose["VehicleFlyType"] = ui.add_choose(TRANSLATION["Fly type"], __submenus["VehFly"], true, types, function(int)
		if utils.show_info("vehflytype [choose]") then ui.set_value(__options.choose["VehicleFlyType"], settings.Vehicle["VehicleFlyType"], true) return end
		utils.hud_sound("YES") 
		settings.Vehicle["VehicleFlyType"] = int
	end, {"vehflytype"})
	__options.num["VehicleFlySpeed"] = ui.add_float_option(TRANSLATION["Fly speed"], __submenus["VehFly"], 0, 50, .1, 1, function(float)
		if utils.show_info("vehflyspeed [0 - 50]") then ui.set_value(__options.num["VehicleFlySpeed"], settings.Vehicle["VehicleFlySpeed"], true) return end
		utils.hud_sound("YES")
		settings.Vehicle["VehicleFlySpeed"] = float
	end, {"vehflyspeed"})

	local function f_1()
		local rot = cache:get('Veh fly rot')
		local veh = cache:get('Veh fly vehicle')
		ENTITY.SET_ENTITY_ROTATION(veh, rot.x, rot.y, rot.z, 2, true)
	    local pad
	    local force = settings.Vehicle["VehicleFlySpeed"]
	  	if PAD.IS_CONTROL_PRESSED(0, enum.input.VEH_FLY_THROTTLE_UP) == 1 then
	      features.apply_force_to_entity(veh, 1, 0, force, 0, 0, 0, 0, 0, true, false, true, false, true)
	      pad = true
	    end
	    if PAD.IS_CONTROL_PRESSED(0, enum.input.VEH_FLY_THROTTLE_DOWN) == 1 then
	      features.apply_force_to_entity(veh, 1, 0, -force, 0, 0, 0, 0, 0, true, false, true, false, true)
	      pad = true
	    end
	    if PAD.IS_CONTROL_PRESSED(0, enum.input.VEH_FLY_YAW_LEFT) == 1 then
	      features.apply_force_to_entity(veh, 1, -force, 0, 0, 0, 0, 0, 0, true, false, true, false, true)
	      pad = true
	    end
	    if PAD.IS_CONTROL_PRESSED(0, enum.input.VEH_FLY_YAW_RIGHT) == 1 then
	      features.apply_force_to_entity(veh, 1, force, 0, 0, 0, 0, 0, 0, true, false, true, false, true)
	      pad = true
	    end
	    if PAD.IS_CONTROL_PRESSED(0, enum.input.VEH_MOVE_UP_ONLY) == 1 then
	      features.apply_force_to_entity(veh, 1, 0, 0, force, 0, 0, 0, 0, true, false, true, false, true)
	      pad = true
	    end
	    if PAD.IS_CONTROL_PRESSED(0, enum.input.VEH_MOVE_UD) == 1 then
	      features.apply_force_to_entity(veh, 1, 0, 0, -force, 0, 0, 0, 0, true, false, true, false, true)
	      pad = true
	    end
	    if not pad then
	    	features.set_entity_velocity(veh, 0, 0, 0)
	    end
	    if settings.General["ShowControls"] and Instructional:New() then
	    	Instructional.AddButton(enum.input.VEH_FLY_THROTTLE_UP, TRANSLATION["Forward"])
	    	Instructional.AddButton(enum.input.VEH_FLY_THROTTLE_DOWN, TRANSLATION["Backward"])
	    	Instructional.AddButton(enum.input.VEH_FLY_YAW_LEFT, TRANSLATION["Left"])
	    	Instructional.AddButton(enum.input.VEH_FLY_YAW_RIGHT, TRANSLATION["Right"])
	    	Instructional.AddButton(enum.input.VEH_MOVE_UP_ONLY, TRANSLATION["Up"])
	    	Instructional.AddButton(enum.input.VEH_MOVE_UD, TRANSLATION["Down"])
	    	Instructional:BackgroundColor(0, 0, 0, 80)
	    	Instructional:Draw()
	    end
	end

	local function f_2()
		local rot = vector3(cache:get('Veh fly rot'))
		local veh = cache:get('Veh fly vehicle')
		if PAD.IS_CONTROL_PRESSED(0, enum.input.VEH_FLY_THROTTLE_UP) == 1 then
			local force = settings.Vehicle["VehicleFlySpeed"]
			if PAD.IS_CONTROL_PRESSED(0, enum.input.VEH_MOVE_UP_ONLY) == 1 then force = force * 2 end
			local dir = rot:rot_to_direction() * force / 4
			features.apply_force_to_entity(veh, 1, dir.x, dir.y, dir.z, 0, 0, 0, 0, false, false, true, false, true)
		end
		if settings.General["ShowControls"] and Instructional:New() then
	    	Instructional.AddButton(enum.input.VEH_FLY_THROTTLE_UP, TRANSLATION["Fly"])
	    	Instructional.AddButton(enum.input.VEH_MOVE_UP_ONLY, TRANSLATION["Faster"])
	    	Instructional:BackgroundColor(0, 0, 0, 80)
	    	Instructional:Draw()
	    end
	end

	local function f_3()
		local rot = cache:get('Veh fly rot')
		local veh = cache:get('Veh fly vehicle')
		ENTITY.SET_ENTITY_ROTATION(veh, rot.x, rot.y, rot.z, 2, true)
		local force = settings.Vehicle["VehicleFlySpeed"] / 10
	    if PAD.IS_CONTROL_PRESSED(0, enum.input.VEH_FLY_THROTTLE_UP) == 1 then
	      features.apply_force_to_entity(veh, 1, 0, force, 0, 0, 0, 0, 0, true, false, true, false, true)
	    end
	    if PAD.IS_CONTROL_PRESSED(0, enum.input.VEH_FLY_THROTTLE_DOWN) == 1 then
	      features.apply_force_to_entity(veh, 1, 0, -force, 0, 0, 0, 0, 0, true, false, true, false, true)
	    end
	    if PAD.IS_CONTROL_PRESSED(0, enum.input.VEH_FLY_YAW_LEFT) == 1 then
	      features.apply_force_to_entity(veh, 1, -force, 0, 0, 0, 0, 0, 0, true, false, true, false, true)
	    end
	    if PAD.IS_CONTROL_PRESSED(0, enum.input.VEH_FLY_YAW_RIGHT) == 1 then
	      features.apply_force_to_entity(veh, 1, force, 0, 0, 0, 0, 0, 0, true, false, true, false, true)
	    end
	    if PAD.IS_CONTROL_PRESSED(0, enum.input.VEH_MOVE_UP_ONLY) == 1 then
	      features.apply_force_to_entity(veh, 1, 0, 0, force, 0, 0, 0, 0, true, false, true, false, true)
	    end
	    if PAD.IS_CONTROL_PRESSED(0, enum.input.VEH_MOVE_UD) == 1 then
	      features.apply_force_to_entity(veh, 1, 0, 0, -force, 0, 0, 0, 0, true, false, true, false, true)
	    end
	    if settings.General["ShowControls"] and Instructional:New() then
	    	Instructional.AddButton(enum.input.VEH_FLY_THROTTLE_UP, TRANSLATION["Forward"])
	    	Instructional.AddButton(enum.input.VEH_FLY_THROTTLE_DOWN, TRANSLATION["Backward"])
	    	Instructional.AddButton(enum.input.VEH_FLY_YAW_LEFT, TRANSLATION["Left"])
	    	Instructional.AddButton(enum.input.VEH_FLY_YAW_RIGHT, TRANSLATION["Right"])
	    	Instructional.AddButton(enum.input.VEH_MOVE_UP_ONLY, TRANSLATION["Up"])
	    	Instructional.AddButton(enum.input.VEH_MOVE_UD, TRANSLATION["Down"])
	    	Instructional:BackgroundColor(0, 0, 0, 80)
	    	Instructional:Draw()
	    end
	end

	local f = switch()
		:case(0, f_1)
		:case(1, f_2)
		:case(2, f_3)

	__options.bool["VehicleFly"] = ui.add_bool_option(TRANSLATION["Vehicle fly"], __submenus["VehFly"], function(bool)
		if utils.show_info("vehfly [on - off]") then ui.set_value(__options.bool["VehicleFly"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON")
		system.thread(bool, 'vehicle_fly', function()
			local veh = vehicles.get_player_vehicle()
			cache:set('Veh fly vehicle', veh)
			cache:set('Veh fly rot', features.gameplay_cam_rot())
			features.request_control_once(veh)
			f(settings.Vehicle["VehicleFlyType"])
		end)
	end, {"vehfly"})
end

do
	__options.bool["VehicleWeaponsShowLasers"] = ui.add_bool_option(TRANSLATION["Show lasers"], __submenus["VehicleWeapons"], function(bool)
		if utils.show_info("vehlasers [on - off]") then ui.set_value(__options.bool["VehicleWeaponsShowLasers"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") settings.Vehicle["VehicleWeaponsShowLasers"] = bool
	end, {"vehlasers"})
	__options.bool["VehicleWeaponsAimCamera"] = ui.add_bool_option(TRANSLATION["Aim with camera"], __submenus["VehicleWeapons"], function(bool)
		if utils.show_info("vehaimcamera [on - off]") then ui.set_value(__options.bool["VehicleWeaponsAimCamera"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") settings.Vehicle["VehicleWeaponsAimCamera"] = bool
	end, {"vehaimcamera"})
	__options.num["VehicleWeaponsDelay"] = ui.add_float_option(TRANSLATION["Delay between shots"], __submenus["VehicleWeapons"], 0, 5, .1, 3, function(float)
		if utils.show_info("vehweapodelay [0.0 - 5.0]") then ui.set_value(__options.num["VehicleWeaponsDelay"], settings.Vehicle["VehicleWeaponsDelay"], true) return end
		utils.hud_sound("YES") settings.Vehicle["VehicleWeaponsDelay"] = features.round(float, 3)
	end, {"vehweapodelay"})
	local types = {
		TRANSLATION['None'],
		HUD._GET_LABEL_TEXT("WT_SNIP_HVY2"),
		HUD._GET_LABEL_TEXT("WT_RPG"),
		HUD._GET_LABEL_TEXT("WT_MOLOTOV"),
		HUD._GET_LABEL_TEXT("WT_SNWBALL"),
		HUD._GET_LABEL_TEXT("WT_RAYPISTOL"),
		HUD._GET_LABEL_TEXT("WT_FIREWRK"),
		HUD._GET_LABEL_TEXT("WT_EMPL"),
		HUD._GET_LABEL_TEXT("WT_V_KHA_CA"),
		HUD._GET_LABEL_TEXT("LAZER")
	}
	local weapons = {
		177293209,
		-1312131151,
		615608432,
		126349499,
		-1355376991,
		2138347493,
		3676729658,
		1945616459,
		3800181289,
	}
	local type = 0
	__options.choose["VehicleWeapons"] = ui.add_choose(TRANSLATION["Vehicle weapons"], __submenus["VehicleWeapons"], false, types, function(int)
		if utils.show_info("vehweapon [choose]") then return end
		utils.hud_sound("YES") type = int
		settings.Vehicle["VehicleWeapons"] = int
	end, {"vehweapon"})
	local delay
	system.thread(true, 'vehicle_weapons', function()
  		if Global.onscreen_keyboard then return end

		local veh = vehicles.get_player_vehicle()
		if veh == 0 or settings.Vehicle["VehicleWeapons"] == 0 then return end
		if WEAPON.HAS_WEAPON_ASSET_LOADED(weapons[type]) == 0 then
			WEAPON.REQUEST_WEAPON_ASSET(weapons[type], 31, 0)
			return
		end
		local v_min, v_max = features.get_model_dimentions(ENTITY.GET_ENTITY_MODEL(veh))
		local offset_right1 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(veh, v_max.x, v_max.y + .1, .35)
		local offset_left1 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(veh, v_min.x, v_max.y + .1, .35)
		local offset_right2 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(veh, v_max.x, v_max.y + 1500, .35)
		local offset_left2 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(veh, v_min.x, v_max.y + 1500, .35)
		if settings.Vehicle["VehicleWeaponsAimCamera"] then
			local dir = features.gameplay_cam_rot():rot_to_direction()
			local camcoord = features.gameplay_cam_pos()
			local target_pos = camcoord + dir * 1500
			local offset = ENTITY.GET_OFFSET_FROM_ENTITY_GIVEN_WORLD_COORDS(veh, target_pos.x, target_pos.y, target_pos.z)
			offset_right2 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(veh, offset.x, offset.y, offset.z)
			offset_left2 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(veh, offset.x, offset.y, offset.z)
		end
		if settings.Vehicle["VehicleWeaponsShowLasers"] then
			GRAPHICS.DRAW_LINE(offset_right1.x, offset_right1.y, offset_right1.z, offset_right2.x, offset_right2.y, offset_right2.z, 0, 255, 0, 100)
			GRAPHICS.DRAW_LINE(offset_left1.x, offset_left1.y, offset_left1.z, offset_left2.x, offset_left2.y, offset_left2.z, 0, 255, 0, 100)
		end
		if settings.General["ShowControls"] and Instructional:New() then
			Instructional.AddButton(enum.input.ATTACK2, TRANSLATION["Shoot"])
			Instructional:BackgroundColor(0, 0, 0, 80)
			Instructional:Draw()
		end
		PAD.DISABLE_CONTROL_ACTION(0, enum.input.ATTACK2, true)
		if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.ATTACK2) == 0 or (delay and delay > clock() - ui.get_value(__options.num["VehicleWeaponsDelay"])) then return end
		delay = clock()
		MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(offset_right1.x, offset_right1.y, offset_right1.z, offset_right2.x, offset_right2.y, offset_right2.z, 50, true, weapons[type], features.player_ped(), true, true, 24000)
		MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(offset_left1.x, offset_left1.y, offset_left1.z, offset_left2.x, offset_left2.y, offset_left2.z, 50, true, weapons[type], features.player_ped(), true, true, 24000)
	end)
end

__options.num["VehicleLightMultiplier"] = ui.add_float_option(TRANSLATION["Lights intensity"], __submenus["VehMultipliers"], 0, 1000, .1, 1, function(float)
	if utils.show_info("vehlightsintensity [0 - 1000]") then return end
	utils.hud_sound("YES")
	local veh = vehicles.get_player_vehicle()
	if veh == 0 then return end
	VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(veh, float)
end, {"vehlightsintensity"})

do
	local num_seat
	local is_custom
	local del_veh
	local _seat = -1
	local previous
	local get_seat_name = switch()
		:case(1, function()
			return TRANSLATION["Driver's seat"]
		end)
		:case(2, function()
			return TRANSLATION["Passenger's seat"]
		end)
		:case(3, function()
			return TRANSLATION["Driver's back seat"]
		end)
		:case(4, function()
			return TRANSLATION["Passenger's back seat"]
		end)

	local function GetVehSeats(veh)
		local hash = ENTITY.GET_ENTITY_MODEL(veh)
		local max = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(hash)
		local seats = {}
		for i = 1, max
		do
			insert(seats, get_seat_name(i) or tostring(i))
		end
		return seats
	end

	system.thread(true, 'vehicle_handle', function()
		local veh = vehicles.get_player_vehicle()
		if previous and veh ~= previous and not (ui.is_sub_open(veh_customs.sub_mods) or
			ui.is_sub_open(veh_customs.paint_primary_sub) or
			ui.is_sub_open(veh_customs.paint_primary_classic_sub) or
			ui.is_sub_open(veh_customs.paint_primary_worn_sub) or
			ui.is_sub_open(veh_customs.paint_primary_util_sub) or
			ui.is_sub_open(veh_customs.paint_primary_matte_sub) or
			ui.is_sub_open(veh_customs.paint_primary_metal_sub) or
			ui.is_sub_open(veh_customs.paint_secondary_sub) or
			ui.is_sub_open(veh_customs.paint_secondary_classic_sub) or
			ui.is_sub_open(veh_customs.paint_secondary_worn_sub) or
			ui.is_sub_open(veh_customs.paint_secondary_util_sub) or
			ui.is_sub_open(veh_customs.paint_secondary_matte_sub) or
			ui.is_sub_open(veh_customs.paint_secondary_metal_sub) or
			ui.is_sub_open(veh_customs.paint_pearlescent_sub) or
			ui.is_sub_open(veh_customs.paint_pearlescent_classic_sub) or
			ui.is_sub_open(veh_customs.paint_pearlescent_worn_sub) or
			ui.is_sub_open(veh_customs.paint_pearlescent_util_sub) or
			ui.is_sub_open(veh_customs.paint_pearlescent_matte_sub) or
			ui.is_sub_open(veh_customs.paint_pearlescent_metal_sub) or
			ui.is_sub_open(veh_customs.neon_sub) or
			ui.is_sub_open(veh_customs.wheel_sub) or
			ui.is_sub_open(veh_customs.paint_wheel_classic_sub) or
			ui.is_sub_open(veh_customs.paint_wheel_worn_sub) or
			ui.is_sub_open(veh_customs.paint_wheel_util_sub) or
			ui.is_sub_open(veh_customs.paint_wheel_matte_sub) or
			ui.is_sub_open(veh_customs.paint_wheel_metal_sub)) then

			if num_seat then
				ui.remove(num_seat)
				num_seat = nil
			end
			if del_veh then
				ui.remove(del_veh)
				del_veh = nil
			end
			if is_custom then
				local count = 0
				for k, v in pairs(veh_customs)
				do
					if k == 'subopt_mods' then
						-- ui.hide(v, true)
					elseif k ~= 'sub_mods' then
						ui.remove(v)
					end
					count = count + 1
				end
				is_custom = nil
			end
			previous = nil
		elseif vehicles.get_player_vehicle() ~= 0 then
			if not is_custom then
				vehicles.tuning_menu(veh, __submenus["Vehicle"], veh_customs, veh_customs.sub_mods and true or false)
				previous = veh
				is_custom = true
			end
			if not num_seat then
				num_seat = ui.add_choose(TRANSLATION["Change seat"], __submenus["Vehicle"], false, GetVehSeats(veh), function(seat)
					if utils.show_info("changeseat [choose]") then return end
					if vehicles.get_player_vehicle() == 0 then return utils.hud_sound("ERROR") end
					utils.hud_sound("YES")
					system.thread(true, 'seat_change_'..system.thread_count(), function(tick)
						if tick == 100 then return POP_THREAD end
						local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, seat - 1, true)
						if ped and ped ~= features.player_ped() then
							TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
						end
						features.request_control_once(veh)
						PED.SET_PED_INTO_VEHICLE(features.player_ped(), veh, seat - 1)
						if VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, seat - 1, true) ~= features.player_ped() then return end
						return POP_THREAD
					end)
				end, {"changeseat"})
			end
			if not del_veh then
				del_veh = ui.add_click_option(TRANSLATION["Delete current vehicle"], __submenus["Vehicle"], function()
					if utils.show_info("delveh") then return end
					local veh = vehicles.get_player_vehicle()
					if veh == 0 then return utils.hud_sound("ERROR") end
					utils.hud_sound("SELECT")
					TASK.CLEAR_PED_TASKS_IMMEDIATELY(features.player_ped())
					features.delete_entity(veh)
				end, {"delveh"})
			end
			local _seat = vehicles.get_ped_seat(features.player_ped()) + 1
			if not ui.is_sub_open(__submenus["Vehicle"]) and _seat ~= ui.get_value(num_seat) then
				ui.set_value(num_seat, _seat, true)
			end
			if ui.is_sub_open(__submenus["VehMultipliers"]) then
				ui.set_value(__options.num["VehicleLightMultiplier"], vehicles.get_lights_intensity(veh), true)
			end

			if ui.is_sub_open(veh_customs.sub_mods) and ENTITY.DOES_ENTITY_EXIST(veh) == 1 then
				local primary, secondary = s_memory.alloc_get(2)
	            VEHICLE.GET_VEHICLE_COLOURS(veh, primary, secondary)
	            ui.set_value(veh_customs.paint_primary_select, memory.read_int(primary), true)
	            ui.set_value(veh_customs.paint_secondary_select, memory.read_int(secondary), true)
	            local r, g, b = s_memory.alloc_get(3)
	            VEHICLE.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(veh, r, g, b)
	            ui.set_value(veh_customs.paint_primary_rgb, memory.read_int(r), memory.read_int(g), memory.read_int(b), 255, true)
	            VEHICLE.GET_VEHICLE_CUSTOM_SECONDARY_COLOUR(veh, r, g, b)
	            ui.set_value(veh_customs.paint_secondary_rgb, memory.read_int(r), memory.read_int(g), memory.read_int(b), 255, true)
	            local pearl, wheel = s_memory.alloc_get(2)
	            VEHICLE.GET_VEHICLE_EXTRA_COLOURS(veh, pearl, wheel)
	            ui.set_value(veh_customs.paint_pearlescent_select, memory.read_int(pearl), true)
	            for i = 0, 48
	            do
	                if i < 17 or i > 24 and veh_customs["veh_mod_"..i] then
	                    ui.set_value(veh_customs["veh_mod_"..i], VEHICLE.GET_VEHICLE_MOD(veh, i) + 1, true)
			        end
	            end
	            ui.set_value(veh_customs.turbo, VEHICLE.IS_TOGGLE_MOD_ON(veh, 18) == 1, true)
	            ui.set_value(veh_customs.xenons, VEHICLE.IS_TOGGLE_MOD_ON(veh, 22) == 1, true)
	            ui.set_value(veh_customs.licence_index, VEHICLE.GET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(veh), true)
	            ui.set_value(veh_customs.licence_text, VEHICLE.GET_VEHICLE_NUMBER_PLATE_TEXT(veh), true)
	            for i = 0, 20
	            do
	                if VEHICLE.DOES_EXTRA_EXIST(veh, i) == 1 then
	                    ui.set_value(veh_customs["extra_"..i], VEHICLE.IS_VEHICLE_EXTRA_TURNED_ON(veh, i) == 1, true)
	                end
	            end
	            ui.set_value(veh_customs.window_tint, VEHICLE.GET_VEHICLE_WINDOW_TINT(veh), true)
	            local xenon_color = VEHICLE._GET_VEHICLE_XENON_LIGHTS_COLOR(veh)
	            ui.set_value(veh_customs.xenon_color, xenon_color == 255 and 0 or xenon_color + 1, true)
	            local interior, dashboard = s_memory.alloc_get(2)
	            VEHICLE._GET_VEHICLE_INTERIOR_COLOR(veh, interior)
	            ui.set_value(veh_customs.interior_color, memory.read_int(interior), true)
	            VEHICLE._GET_VEHICLE_DASHBOARD_COLOR(veh, dashboard)
	            ui.set_value(veh_customs.dashboard_color, memory.read_int(dashboard), true)
	            for i = 0, 3
	            do
	                ui.set_value(veh_customs["neon_"..i], VEHICLE._IS_VEHICLE_NEON_LIGHT_ENABLED(veh, i) == 1, true)
	            end
	            VEHICLE._GET_VEHICLE_NEON_LIGHTS_COLOUR(veh, r, g, b)
	            ui.set_value(veh_customs.neon_rgb, memory.read_int(r), memory.read_int(g), memory.read_int(b), 255, true)
	            VEHICLE.GET_VEHICLE_TYRE_SMOKE_COLOR(veh, r, g, b)
				ui.set_value(veh_customs.tyre_smoke_color, memory.read_int(r), memory.read_int(g), memory.read_int(b), 255, true)
				ui.set_value(veh_customs.torque_mult, vehicles.get_torque_mult(veh), true)
				ui.set_value(veh_customs.rpm_mult, vehicles.get_rpm_mult(veh), true)
	        elseif ui.is_sub_open(veh_customs.wheel_sub) and ENTITY.DOES_ENTITY_EXIST(veh) == 1 then
	            ui.set_value(veh_customs.bulletproof_tires, VEHICLE.GET_VEHICLE_TYRES_CAN_BURST(veh) == 0, true)
	            ui.set_value(veh_customs.drift_tires, VEHICLE._GET_DRIFT_TYRES_ENABLED(veh) == 1, true)
	            ui.set_value(veh_customs.tyre_smoke, VEHICLE.IS_TOGGLE_MOD_ON(veh, 20) == 1, true)
	        	local pearl, wheel = s_memory.alloc_get(2)
	            VEHICLE.GET_VEHICLE_EXTRA_COLOURS(veh, pearl, wheel)
	        	ui.set_num_max(veh_customs.wheels, VEHICLE.GET_NUM_VEHICLE_MODS(veh, 23))
	            ui.set_value(veh_customs.custom_wheels, VEHICLE.GET_VEHICLE_MOD_VARIATION(veh, 23) == 1 or VEHICLE.GET_VEHICLE_MOD_VARIATION(veh, 24) == 1, true)
	            if VEHICLE.IS_THIS_MODEL_A_BIKE(ENTITY.GET_ENTITY_MODEL(veh)) == 1 then
	                ui.set_value(veh_customs.wheels_front, VEHICLE.GET_VEHICLE_MOD(veh, 23), true)
	                ui.set_value(veh_customs.wheels_back, VEHICLE.GET_VEHICLE_MOD(veh, 24) + 1, true)
	            else
	            	local wheel_type = VEHICLE.GET_VEHICLE_WHEEL_TYPE(veh)
	                ui.set_value(veh_customs.wheel_type, wheel_type < 6 and wheel_type or wheel_type - 1, true)
	                ui.set_value(veh_customs.wheels, VEHICLE.GET_VEHICLE_MOD(veh, 23) + 1, true)
	            end
	            ui.set_value(veh_customs.wheel_color, memory.read_int(wheel), true)
	        end
		end
	end)
end

---------------------------------------------------------------------------------------------------------------------------------
-- World
---------------------------------------------------------------------------------------------------------------------------------
__submenus["World"] = ui.add_submenu(TRANSLATION["World"])
__suboptions["World"] = ui.add_sub_option(TRANSLATION["World"], __submenus["MainSub"], __submenus["World"])

__submenus["WorldEditor"] = ui.add_submenu(TRANSLATION["Editor"])
__suboptions["WorldEditor"] = ui.add_sub_option(TRANSLATION["Editor"], __submenus["World"] , __submenus["WorldEditor"])

__submenus["WorldEditorSpawned"] = ui.add_submenu(TRANSLATION["Spawned"])
__suboptions["WorldEditorSpawned"] = ui.add_sub_option(TRANSLATION["Spawned"], __submenus["WorldEditor"] , __submenus["WorldEditorSpawned"])

__submenus["WorldEditorMaps"] = ui.add_submenu(TRANSLATION["Maps"])
__suboptions["WorldEditorMaps"] = ui.add_sub_option(TRANSLATION["Maps"], __submenus["WorldEditor"] , __submenus["WorldEditorMaps"])

__submenus["WorldEditorSettings"] = ui.add_submenu(TRANSLATION["Settings"])
__suboptions["WorldEditorSettings"] = ui.add_sub_option(TRANSLATION["Settings"], __submenus["WorldEditor"] , __submenus["WorldEditorSettings"])

__submenus["WorldEditorSaveMap"] = ui.add_submenu(TRANSLATION["Save"])
__suboptions["WorldEditorSaveMap"] = ui.add_sub_option(TRANSLATION["Save"], __submenus["WorldEditorMaps"] , __submenus["WorldEditorSaveMap"])
ui.add_click_option(TRANSLATION["Open folder"], __submenus["WorldEditorMaps"], function(bool)
	if utils.show_info("openmapsfolder") then return end
	utils.hud_sound("SELECT") if not filesystem.isdir(paths["SavedMaps"]) then filesystem.make_dir(paths["SavedMaps"]) end filesystem.open(paths["SavedMaps"])
end, {"openmapsfolder"})
ui.add_separator(TRANSLATION["Saved"], __submenus["WorldEditorMaps"])

do
	local name
	local is_open
	local maps = {}
	local saved

	ui.add_input_string(TRANSLATION["Search"], __submenus["WorldEditorMaps"], function(text)
		text = text:lower():escpattern()
		for k, v in pairs(maps)
		do
			if k:lower():find(text) then
				ui.hide(v.sub_opt, false)
			else
				ui.hide(v.sub_opt, true)
			end
		end
	end)

	__options.string["SaveMapName"] = ui.add_input_string(TRANSLATION["Name"], __submenus["WorldEditorSaveMap"], function(text)
		if utils.show_info("savemapname") then ui.set_value(__options.string["SaveMapName"], "", true) return end
		name = text
	end, {"savemapname"})

	ui.add_separator(TRANSLATION["Reference position"], __submenus["WorldEditorSaveMap"])

	local x = ui.add_float_option("X", __submenus["WorldEditorSaveMap"], -10000, 10000, 1, 3, function() if utils.show_info("savemapx [-10000.0 - 10000.0]") then return end utils.hud_sound("YES") end, {"savemapx"})
	local y = ui.add_float_option("Y", __submenus["WorldEditorSaveMap"], -10000, 10000, 1, 3, function() if utils.show_info("savemapy [-10000.0 - 10000.0]") then return end utils.hud_sound("YES") end, {"savemapy"})
	local z = ui.add_float_option("Z", __submenus["WorldEditorSaveMap"], -10000, 10000, 1, 3, function() if utils.show_info("savemapz [-10000.0 - 10000.0]") then return end utils.hud_sound("YES") end, {"savemapz"})

	ui.add_separator(TRANSLATION["Database"], __submenus["WorldEditorSaveMap"])

	ui.add_click_option(TRANSLATION["Save entities in database"], __submenus["WorldEditorSaveMap"], function()
		if utils.show_info("savedatabase") then return end
		if not name or name:isblank() then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Please enter name"], settings.General["HudColorNotifyError"]) return utils.hud_sound("ERROR") end
		local entities = EntityDb.GetEntitiesInDb()
		if #entities == 0 then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["No entities in database"], settings.General["HudColorNotifyError"]) return utils.hud_sound("ERROR") end
		utils.hud_sound("SELECT")
		if not filesystem.isdir(paths["SavedMaps"]) then
			filesystem.make_dir(paths["SavedMaps"])
		end
		local refernce_pos = vector3(ui.get_value(x), ui.get_value(y), ui.get_value(z))
		world_saver.save_map(entities, paths["SavedMaps"]:ensureend('\\')..name..[[.json]], refernce_pos)
	end, {"savedatabase"})

	ui.add_separator(TRANSLATION["Nearby"], __submenus["WorldEditorSaveMap"])

	__options.num["EntitySaveDistance"] = ui.add_num_option(TRANSLATION["Radius"], __submenus["WorldEditorSaveMap"], 0, 10000, 1, function(int)
		if utils.show_info("savedist [0 - 10000]") then return end
		utils.hud_sound("YES")
		system.thread(true, 'draw_prev_shere', function(tick)
			if tick > 100 then return POP_THREAD end
			local pos = features.get_player_coords()
			GRAPHICS._DRAW_SPHERE(pos.x, pos.y, pos.z, int, 0, 255, 255, .5)
		end)
	end, {"savedist"})

	ui.add_click_option(TRANSLATION["Save nearby entities"], __submenus["WorldEditorSaveMap"], function()
		if utils.show_info("savenearby") then return end
		if not name or name:isblank() then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Please enter name"], settings.General["HudColorNotifyError"]) return utils.hud_sound("ERROR") end
		local entities = {}
		local distance = ui.get_value(__options.num["EntitySaveDistance"]) ^ 2
		local pos = features.get_player_coords()
		for _, v in ipairs(features.get_entities())
		do
			if distance >= features.get_entity_coords(v):sqrlen(pos) then
				insert(entities, v)
			end
		end
		if #entities == 0 then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["No entities to save"], settings.General["HudColorNotifyError"]) return utils.hud_sound("ERROR") end
		utils.hud_sound("SELECT")
		if not filesystem.isdir(paths["SavedMaps"]) then
			filesystem.make_dir(paths["SavedMaps"])
		end
		local refernce_pos = vector3(ui.get_value(x), ui.get_value(y), ui.get_value(z))
		world_saver.save_map(entities, paths["SavedMaps"]:ensureend('\\')..name..[[.json]], refernce_pos)
	end, {"savenearby"})

	local repeats = 0
	local function RefreshMaps()
		saved = {}
		if not filesystem.isdir(paths['SavedMaps']) then
			filesystem.make_dir(paths['SavedMaps'])
		end
		local files = filesystem.scandir(paths['SavedMaps'])
		local found
		repeats = 0
		for _, v in ipairs(files)
		do
			if v:find('.json$') or v:find('.xml$') then
				local name = ""
				if v:find('.json$') then
					name = v
					saved[name] = "json"
				elseif v:find('.xml$') then
					name = v
					saved[name] = "xml"
				end

				local n = name:match("[^%s]*$"):gsub('%D', '')
				if name:gsub(' %('..n..'%)', '') == TRANSLATION["My new map"] and name:sub(-len(' ('..n..')'), -1) == ' ('..n..')' then
					repeats = tonumber(n) and tonumber(n) + 1 or repeats
				end

				if not maps[name] then
					local sub = ui.add_submenu(name)
					maps[name] = {
						sub = sub,
						sub_opt = ui.add_sub_option(name:gsub('.json$', ''):gsub('.xml$', ''), __submenus["WorldEditorMaps"], sub),
						spawn = ui.add_click_option(TRANSLATION["Spawn"], sub, function()
							system.thread(true, 'spawn_map', function()
								local file = paths['SavedMaps']:ensureend('\\')..v
								if not filesystem.exists(file) then utils.hud_sound("ERROR");system.notify(TRANSLATION["Error"], TRANSLATION["File doesn't exist"],settings.General["HudColorNotifyError"]) return POP_THREAD end 
								local data = saved[name] == "json" and json:decode(filesystem.read_all(file)) or world_spawner.xml_to_entity(file)
								world_spawner.spawn_map(data)
								if settings.World["WorldEditorTpToReference"] then
									for _, v in ipairs(data)
									do
										if v.reference then
											features.teleport(features.player_ped(), v.reference.x, v.reference.y, v.reference.z)
											break
										end
									end
								end
								return POP_THREAD
							end)
						end),
						teleport_to = ui.add_click_option(TRANSLATION["Teleport to reference"], sub, function()
							system.thread(true, 'tp_to_reference', function()
								local file = paths['SavedMaps']:ensureend('\\')..v
								if not filesystem.exists(file) then utils.hud_sound("ERROR");system.notify(TRANSLATION["Error"], TRANSLATION["File doesn't exist"], settings.General["HudColorNotifyError"]) return POP_THREAD end 
								local data = saved[name] == "json" and json:decode(filesystem.read_all(file)) or world_spawner.xml_to_entity(file)
								local found
								for _, v in ipairs(data)
								do
									if v.reference then
										features.teleport(features.player_ped(), v.reference.x, v.reference.y, v.reference.z)
										found = true
										utils.hud_sound("SELECT")
										break
									end
								end
								if not found then utils.hud_sound("ERROR") end
								return POP_THREAD
							end)
						end),
						rename = ui.add_input_string(TRANSLATION["Rename"], sub, function(text)
							if text:isblank() then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Please enter name"], settings.General["HudColorNotifyError"]) return utils.hud_sound("ERROR") end
							if maps[text] then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Name already taken"], settings.General["HudColorNotifyError"]) return utils.hud_sound("ERROR") end
							os.rename(paths['SavedMaps']:ensureend('\\')..v, paths['SavedMaps']:ensureend('\\')..text..[[.]]..saved[name])
							RefreshMaps()
						end),
						delete = ui.add_click_option(TRANSLATION["Delete"], sub, function()
							utils.hud_sound("SELECT")
							os.remove(paths['SavedMaps']:ensureend('\\')..v)
							for _, e in pairs(maps[name])
							do
								ui.remove(e)
							end
							maps[name] = nil
							RefreshMaps()
						end)
					}
				end
			end
		end

		for k, v in pairs(maps)
		do
			if not saved[k] then
				for _, e in pairs(v)
				do
					ui.remove(e)
				end
				maps[k] = nil
			end
		end
	end

	local maps_open
	system.thread(true, 'map_saver', function()
		if ui.is_sub_open(__submenus["WorldEditorSaveMap"]) and not is_open then
			is_open = true
			local pos = features.get_player_coords()
			ui.set_value(x, pos.x, true)
			ui.set_value(y, pos.y, true)
			ui.set_value(z, pos.z, true)
		elseif not ui.is_sub_open(__submenus["WorldEditorSaveMap"]) and is_open then
			is_open = false
		end

		if ui.is_sub_open(__submenus["WorldEditorMaps"]) and not maps_open then
			RefreshMaps()
			ui.set_value(__options.string["SaveMapName"], TRANSLATION["My new map"]..string.format(' (%i)', repeats), false)
			maps_open = true
		elseif not ui.is_sub_open(__submenus["WorldEditorMaps"]) and maps_open then
			maps_open = false
		end
	end)
end

ui.add_click_option(TRANSLATION["Remove invalid entities"], __submenus["WorldEditorSpawned"], function()
	if utils.show_info("removeinvalid") then return end
	if EntityDb.IsEmpty(true) then utils.hud_sound("ERROR") return end
	utils.hud_sound("SELECT")
	EntityDb.RemoveInvalidEntities()
end, {"removeinvalid"})

ui.add_click_option(TRANSLATION["Remove all entities from db"], __submenus["WorldEditorSpawned"], function()
	if utils.show_info("removedb") then return end
	if EntityDb.IsEmpty() then utils.hud_sound("ERROR") return end
	utils.hud_sound("SELECT")
	for k, v in pairs(EntityDb.entity_data)
	do
		EntityDb.RemoveFromDatabase(k)
	end
end, {"removedb"})

ui.add_click_option(TRANSLATION["Delete all entities"], __submenus["WorldEditorSpawned"], function()
	if utils.show_info("deletedb") then return end
	if EntityDb.IsEmpty() then utils.hud_sound("ERROR") return end
	utils.hud_sound("SELECT")
	local veh = vehicles.get_player_vehicle()
	for k, v in pairs(EntityDb.entity_data)
	do
		EntityDb.RemoveFromDatabase(k)
		if veh ~= 0 and k == veh then TASK.CLEAR_PED_TASKS_IMMEDIATELY(features.player_ped()) end
		features.delete_entity(k)
	end
end, {"deletedb"})

do
	local selected = {}
	local options = {}

	__submenus["WorldEditorEditEntities"] = ui.add_submenu(TRANSLATION["Edit entities"])
	__suboptions["WorldEditorEditEntities"] = ui.add_sub_option(TRANSLATION["Edit entities"], __submenus["WorldEditorSpawned"], __submenus["WorldEditorEditEntities"])

	__submenus["WorldEditorSelectEntities"] = ui.add_submenu(TRANSLATION["Select"])
	__suboptions["WorldEditorSelectEntities"] = ui.add_sub_option(TRANSLATION["Select"], __submenus["WorldEditorEditEntities"], __submenus["WorldEditorSelectEntities"])

	ui.add_click_option(TRANSLATION["Select all"],  __submenus["WorldEditorSelectEntities"], function()
		local found
		utils.no_sounds_this_frame()
		for _, v in pairs(options)
		do
			ui.set_value(v, true, false)
			found = true
		end
		if found then utils.hud_sound("SELECT") else utils.hud_sound("ERROR") end
	end)
	ui.add_click_option(TRANSLATION["Unselect all"],  __submenus["WorldEditorSelectEntities"], function()
		local found
		utils.no_sounds_this_frame()
		for _, v in pairs(options)
		do
			ui.set_value(v, false, false)
			found = true
		end
		if found then utils.hud_sound("SELECT") else utils.hud_sound("ERROR") end
	end)
	ui.add_separator(TRANSLATION["Entities"], __submenus["WorldEditorSelectEntities"])
	system.thread(true, 'entities_in_db', function()
		if ui.is_sub_open(__submenus["WorldEditorEditEntities"]) or ui.is_sub_open(__submenus["WorldEditorSelectEntities"]) then
			for k, v in pairs(EntityDb.entity_data)
			do
				if not options[k] and EntityDb.IsValid(k) then
					options[k] = ui.add_bool_option(v.name, __submenus["WorldEditorSelectEntities"], function(bool)
						utils.hud_sound("TOGGLE_ON")
						selected[k] = bool or nil
						system.thread(true, 'highlight_entity_'..k, function(tick)
							if tick == 50 or not EntityDb.IsValid(k) then return POP_THREAD end
							features.draw_box_on_entity(k, 0, 255, 0)
						end)
					end)
				end
			end
			for k, v in pairs(options)
			do
				if not EntityDb.entity_data[k] or not EntityDb.IsValid(k) then
					ui.remove(v)
					selected[k] = nil
					options[k] = nil
				end
			end
		else
			for _, v in pairs(options)
			do
				ui.remove(v)
			end
			selected = {}
			options = {}
		end
	end)

	local position = {}
	local step_val = {'0.0001','0.001', '0.01', '0.1', '1.0', '10.0', '100.0'}
	local step = ui.add_choose(TRANSLATION["Step"], __submenus["WorldEditorEditEntities"], true, step_val, function(type)
		utils.hud_sound("YES")
		local value = tonumber(step_val[type + 1])
		for _, v in pairs(position)
		do
			ui.set_step(v, value)
		end
	end)
	utils.no_sounds_this_frame()
	ui.set_value(step, 3, false)
	ui.add_separator(TRANSLATION["Position"], __submenus["WorldEditorEditEntities"])
	position.x = ui.add_float_option("X", __submenus["WorldEditorEditEntities"], -10000, 10000, .1, 4, function(float)
		local found
		for k in pairs(selected)
		do
			local pos = features.get_entity_coords(k)
			features.teleport(k, pos.x + float, pos.y, pos.z)
			found = true
		end
		if found then utils.hud_sound("SELECT") else utils.hud_sound("ERROR") end
		ui.set_value(position.x, 0, true)
	end)
	position.y = ui.add_float_option("Y", __submenus["WorldEditorEditEntities"], -10000, 10000, .1, 4, function(float)
		local found
		for k in pairs(selected)
		do
			local pos = features.get_entity_coords(k)
			features.teleport(k, pos.x, pos.y + float, pos.z)
			found = true
		end
		if found then utils.hud_sound("SELECT") else utils.hud_sound("ERROR") end
		ui.set_value(position.y, 0, true)
	end)
	position.z = ui.add_float_option("Z", __submenus["WorldEditorEditEntities"], -10000, 10000, .1, 4, function(float)
		local found
		for k in pairs(selected)
		do
			local pos = features.get_entity_coords(k)
			features.teleport(k, pos.x, pos.y, pos.z + float)
			found = true
		end
		if found then utils.hud_sound("SELECT") else utils.hud_sound("ERROR") end
		ui.set_value(position.z, 0, true)
	end)
	ui.add_separator(TRANSLATION["Rotation"], __submenus["WorldEditorEditEntities"])

	position.pitch = ui.add_float_option(TRANSLATION["Pitch"], __submenus["WorldEditorEditEntities"], -10000, 10000, .1, 4, function(float)
		local found
		for k in pairs(selected)
		do
			local rot = features.get_entity_rot(k)
			ENTITY.SET_ENTITY_ROTATION(k, rot.x + float, rot.y, rot.z, 2, true)
			found = true
		end
		if found then utils.hud_sound("SELECT") else utils.hud_sound("ERROR") end
		ui.set_value(position.pitch, 0, true)
	end)
	position.roll = ui.add_float_option(TRANSLATION["Roll"], __submenus["WorldEditorEditEntities"], -10000, 10000, .1, 4, function(float)
		local found
		for k in pairs(selected)
		do
			local rot = features.get_entity_rot(k)
			ENTITY.SET_ENTITY_ROTATION(k, rot.x, rot.y + float, rot.z, 2, true)
			found = true
		end
		if found then utils.hud_sound("SELECT") else utils.hud_sound("ERROR") end
		ui.set_value(position.roll, 0, true)
	end)
	position.yaw = ui.add_float_option(TRANSLATION["Yaw"], __submenus["WorldEditorEditEntities"], -10000, 10000, .1, 4, function(float)
		local found
		for k in pairs(selected)
		do
			local rot = features.get_entity_rot(k)
			ENTITY.SET_ENTITY_ROTATION(k, rot.x, rot.y, rot.z + float, 2, true)
			found = true
		end
		if found then utils.hud_sound("SELECT") else utils.hud_sound("ERROR") end
		ui.set_value(position.yaw, 0, true)
	end)

	ui.add_separator(TRANSLATION["Other"], __submenus["WorldEditorEditEntities"])

	ui.add_bool_option(TRANSLATION["Invincibility"], __submenus["WorldEditorEditEntities"], function(bool)
		local found
		utils.no_sounds_this_frame()
		for k in pairs(selected)
		do
			ui.set_value(EntityDb.spawned_options[k].godmode, bool, false)
			found = true
		end
		if found then utils.hud_sound("SELECT") else utils.hud_sound("ERROR") end
	end)

	ui.add_bool_option(TRANSLATION["Freeze"], __submenus["WorldEditorEditEntities"], function(bool)
		local found
		utils.no_sounds_this_frame()
		for k in pairs(selected)
		do
			entities.request_control(k, function()
				ENTITY.FREEZE_ENTITY_POSITION(k, bool)
			end)
			found = true
		end
		if found then utils.hud_sound("SELECT") else utils.hud_sound("ERROR") end
	end)

	ui.add_click_option(TRANSLATION["Copy"], __submenus["WorldEditorEditEntities"], function()
		local found
		for k in pairs(selected)
		do
			world_spawner.copy_entity(k, false)
			found = true
		end
		if found then utils.hud_sound("SELECT") else utils.hud_sound("ERROR") end
	end)

	ui.add_click_option(TRANSLATION["Delete"], __submenus["WorldEditorEditEntities"], function()
		local found
		for k in pairs(selected)
		do
			features.delete_entity(k)
			EntityDb.RemoveFromDatabase(k)
			found = true
		end
		if found then utils.hud_sound("SELECT") else utils.hud_sound("ERROR") end
	end)
end

ui.add_separator(TRANSLATION["Entities"], __submenus["WorldEditorSpawned"])
do
	local wait = 0
	local cam = 0
	local cam_pos
	local cam_rot
	local DrawInstructions = switch()
	  	:case(1, function(IsPointingAtEntity)
			if IsPointingAtEntity then
				Instructional.AddButton(enum.input.ATTACK2, TRANSLATION["Grab entity"])
				Instructional.AddButton(enum.input.FRONTEND_DELETE, TRANSLATION["Delete"])
				Instructional.AddButton(enum.input.VEH_LOOK_BEHIND, TRANSLATION["Copy"])
			end
		  	Instructional.AddButton(enum.input.VEH_SUB_ASCEND, TRANSLATION["Faster"])
		  	Instructional.AddButton(enum.input.VEH_FLY_THROTTLE_UP, TRANSLATION["Forward"])
		  	Instructional.AddButton(enum.input.VEH_FLY_THROTTLE_DOWN, TRANSLATION["Backward"])
		  	Instructional.AddButton(enum.input.VEH_FLY_YAW_LEFT, TRANSLATION["Left"])
		  	Instructional.AddButton(enum.input.VEH_FLY_YAW_RIGHT, TRANSLATION["Right"])
		  	Instructional.AddButton(enum.input.VEH_PUSHBIKE_SPRINT, TRANSLATION["Up"])
		  	Instructional.AddButton(enum.input.VEH_SUB_DESCEND, TRANSLATION["Down"])
			end)
	    :case(2, function()
			Instructional.AddButton(enum.input.VEH_SUB_ASCEND, TRANSLATION["Precision"])
		  	Instructional.AddButton(enum.input.CELLPHONE_UP, "")
		  	Instructional.AddButton(enum.input.CELLPHONE_DOWN, TRANSLATION["Pitch"])
		  	Instructional.AddButton(enum.input.VEH_LOOK_BEHIND, "")
		  	Instructional.AddButton(enum.input.MULTIPLAYER_INFO, TRANSLATION["Roll"])
		  	Instructional.AddButton(enum.input.VEH_HORN, "")
		  	Instructional.AddButton(enum.input.VEH_RADIO_WHEEL, TRANSLATION["Yaw"])
		end)

	__options.num["FreeCamSens"] = ui.add_num_option(TRANSLATION["Free cam sensitivity"], __submenus["WorldEditorSettings"], 1, 100, 5, function(int)
		if utils.show_info("freecamsens [1 - 100]") then ui.set_value(__options.num["FreeCamSens"], settings.World["FreeCamSens"], true) return end
		utils.hud_sound("YES") settings.World["FreeCamSens"] = int
	end, {"freecamsens"})
	__options.num["FreeCamMovement"] = ui.add_float_option(TRANSLATION["Free cam movement speed"], __submenus["WorldEditorSettings"], 0, 10, .1, 1, function(float)
		if utils.show_info("freecamspeed [0.0 - 10.0]") then ui.set_value(__options.num["FreeCamMovement"], settings.World["FreeCamMovement"], true) return end
		utils.hud_sound("YES") settings.World["FreeCamMovement"] = features.round(float, 1)
	end, {"freecamspeed"})
	ui.add_separator(TRANSLATION["Spawning"], __submenus["WorldEditor"])
	features.request_model('trash')
	__options.bool["FreeCam"] = ui.add_bool_option(TRANSLATION["Free cam"], __submenus["WorldEditor"], function(bool) utils.hud_sound("TOGGLE_ON")
		if utils.show_info("freecam [on - off]") then ui.set_value(__options.bool["FreeCam"], not bool, true) return end
		HUD.DISPLAY_RADAR(not bool)
		Global.free_cam = bool
		if not bool then
			CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, false, 0)
			CAM.SET_CAM_ACTIVE(cam, false)
			CAM.DESTROY_CAM(cam, false)
			STREAMING.CLEAR_FOCUS()
			features.disable_phone(false)
			cam = 0
		elseif ui.get_value(__options.bool["NoClip"]) then
			utils.no_sounds_this_frame()
			ui.set_value(__options.bool["NoClip"], false, false)
		end
		ENTITY.FREEZE_ENTITY_POSITION(features.player_ped(), bool)
		local Entity
		local distance_from_cam = 20
		system.thread(bool, 'free_cam', function(tick)
  			if Global.onscreen_keyboard then return end

			ENTITY.FREEZE_ENTITY_POSITION(features.player_ped(), true)

			local add_to_db = nil
			if CAM.DOES_CAM_EXIST(cam) == 0 then
				CAM.DESTROY_ALL_CAMS(true)
				cam = CAM.CREATE_CAM("DEFAULT_SCRIPTED_CAMERA", false)
				cam_pos = features.gameplay_cam_pos()
				cam_rot = features.gameplay_cam_rot()
				CAM.SET_CAM_FOV(cam, 50)
				CAM.SET_CAM_ROT(cam, cam_rot.x, cam_rot.y, cam_rot.z, 2)
				CAM.SET_CAM_COORD(cam, cam_pos.x, cam_pos.y, cam_pos.z)
				CAM.SET_CAM_ACTIVE(cam, true)
				CAM.RENDER_SCRIPT_CAMS(true, false, 0, true, false, 0)
			else
				local entity
				local IsPointingAtEntity
				local instructional_type = 1
				PAD.DISABLE_ALL_CONTROL_ACTIONS(0)
				PAD.ENABLE_CONTROL_ACTION(0, enum.input.FRONTEND_PAUSE, true)
				PAD.ENABLE_CONTROL_ACTION(0, enum.input.FRONTEND_PAUSE_ALTERNATE, true)
				features.disable_phone(true)
				local color = {r = 255, g = 255, b = 255}
				local rot = cam_rot
				local end_pos = cam_pos + (rot:rot_to_direction() * 50)
				local result = features.get_raycast_result(cam_pos, end_pos, 0, 2+4+8+16)
				if result.hitEntity ~= 0 and not Entity then
					entity = result.hitEntity
					color = {r = 0, g = 255, b = 0}
					IsPointingAtEntity = true
					if not EntityDb.IsEntityInDatabase(entity) then
						add_to_db = true
						if PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, enum.input.SPECIAL_ABILITY_SECONDARY) == 1 then
							EntityDb.AddEntityToDatabase(entity)
						end
					else
						add_to_db = false
						if PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, enum.input.SPECIAL_ABILITY_SECONDARY) == 1 then
							EntityDb.RemoveFromDatabase(entity, true)
						end
					end
					if PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, enum.input.FRONTEND_DELETE) == 1 then
						features.delete_entity(entity)
						EntityDb.RemoveFromDatabase(entity, true)
					end
					if PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, enum.input.VEH_LOOK_BEHIND) == 1 then
						system.thread(true, 'copy_entity', function(tick)
							if tick < 2 then return end
							world_spawner.copy_entity(entity, false)
							return POP_THREAD
						end)
					end
				end
				local X = -PAD.GET_DISABLED_CONTROL_NORMAL(0, enum.input.LOOK_LR) * (settings.World["FreeCamSens"] / 10)
				local Y = -PAD.GET_DISABLED_CONTROL_NORMAL(0, enum.input.LOOK_UD) * (settings.World["FreeCamSens"] / 10)
				cam_rot = vector3((rot.x + Y > -89 and rot.x + Y < 89) and rot.x + Y or rot.x, 0, rot.z + X)
				CAM.SET_CAM_ROT(cam, cam_rot.x, cam_rot.y, cam_rot.z, 2)
				local mult = .3 * settings.World["FreeCamMovement"]
				if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.VEH_SUB_ASCEND) == 1 then
			    	mult = 1 * settings.World["FreeCamMovement"]
			    end
				local pos = vector3.zero()
			    if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.VEH_FLY_THROTTLE_UP) == 1 then
			    	pos = pos + vector3.forward(mult)
			    end
			    if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.VEH_FLY_THROTTLE_DOWN) == 1 then
			      pos = pos + vector3.back(mult)
			    end
			    if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.VEH_FLY_YAW_LEFT) == 1 then
			      pos = pos + vector3.left(mult)
			    end
			    if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.VEH_FLY_YAW_RIGHT) == 1 then
			       pos = pos + vector3.right(mult)
			    end
			    if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.VEH_PUSHBIKE_SPRINT) == 1 then
			      pos = pos + vector3.up(mult)
			    end
			    if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.VEH_SUB_DESCEND) == 1 then
			      pos = pos + vector3.down(mult)
			    end
			    if wait < clock() then
					cam_pos = features.get_offset_cam_coords(cam, pos)
					local my_coord = features.get_player_coords()
					-- if vector3(CAM.GET_CAM_COORD(cam)):sqrlen(my_coord) > 2500000 then
					-- 	cam_pos = features.get_player_coords()
					-- elseif vector3(CAM.GET_CAM_COORD(cam)):sqrlen(my_coord) > 2250000 then
					-- 	cam_pos = vector3(CAM.GET_CAM_COORD(cam)):move_towards(features.get_player_coords(), vector3(CAM.GET_CAM_COORD(cam)):len(my_coord) - 395)
					-- elseif _cam_pos:sqrlen(my_coord) > 2250000 then
					-- 	if tick%20==0 then AUDIO.PLAY_SOUND_FRONTEND(-1, "ERROR", "HUD_FRONTEND_TATTOO_SHOP_SOUNDSET", true) end
					-- 	GRAPHICS._DRAW_SPHERE(my_coord.x, my_coord.y, my_coord.z, 1500, 255, 0, 0, .2)
					-- else

					--end

					if cam_pos:sqrlen(my_coord) > 2500 then
						my_coord.z = 0
						local scale = vector3(cam_pos.x, cam_pos.y):len(my_coord) / 200
						GRAPHICS.DRAW_MARKER(1, my_coord.x, my_coord.y, -1000, 0, 0, 0, 0, 0, 0, .2 + scale, .2 + scale, 10000, settings.General["HudColorSelf"].r, settings.General["HudColorSelf"].g, settings.General["HudColorSelf"].b, 255, false, true, 1, false, 0, 0, false)
					end
				end
				CAM.SET_CAM_COORD(cam, cam_pos.x, cam_pos.y, cam_pos.z)
				STREAMING.SET_FOCUS_POS_AND_VEL(cam_pos.x, cam_pos.y, cam_pos.z, 0, 0, 0)
				if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.ATTACK2) == 1 then
					if not Entity and entity then
						Entity = entity
						distance_from_cam = 20
					elseif Entity then
						instructional_type = 2
						features.request_control_once(Entity)

						if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.WEAPON_WHEEL_PREV) == 1 then
							distance_from_cam = distance_from_cam + 1 < 100 and distance_from_cam + 1 or 100
						end
						if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.WEAPON_WHEEL_NEXT) == 1 then
							distance_from_cam = distance_from_cam - 1 > 10 and distance_from_cam - 1 or 10
						end

						local pos = cam_pos + (cam_rot:rot_to_direction() * distance_from_cam)
						local erot = features.get_entity_rot(Entity)
						local mult = 1
						if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.VEH_SUB_ASCEND) == 1 then
							mult = 10
				    	end
						if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.CELLPHONE_UP) == 1 then
							erot = erot + vector3.right() / mult
						end
						if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.CELLPHONE_DOWN) == 1 then
							erot = erot + vector3.left() / mult
						end
						if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.VEH_LOOK_BEHIND) == 1 then
							erot = erot + vector3.forward() / mult
						end
						if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.MULTIPLAYER_INFO) == 1 then
							erot = erot + vector3.back() / mult
						end
						if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.VEH_HORN) == 1 then
							erot = erot + vector3.up() / mult
						end
						if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.VEH_RADIO_WHEEL) == 1 then
							erot = erot + vector3.down() / mult
						end
						rot = erot
						ENTITY.SET_ENTITY_ROTATION(Entity, erot.x, erot.y, erot.z, 2, true)
						local endCoords = cam_pos + (cam_rot:rot_to_direction() * 100)
						local result2 = features.get_raycast_result(cam_pos, endCoords, Entity, -1)
						if result2.didHit and settings.World["WorldEditorPlacementAssist"] then
							local dim = features.get_model_dimentions(ENTITY.GET_ENTITY_MODEL(Entity))
							pos = vector3(result2.endCoords.x, result2.endCoords.y, result2.endCoords.z + abs(dim.z))
						end
						ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Entity, pos.x, pos.y, pos.z, false, false, false)
						color = {r = 255, g = 100, b = 0}
					end
				else
					Entity = nil
				end
				features.draw_crosshair(20, 20, 0, 2, color.r, color.g, color.b, 255, true, true, true, true, 0, 0, 0, 0, 0, false)
				if settings.General["ShowControls"] and Instructional:New() then
					DrawInstructions(instructional_type, IsPointingAtEntity)
				    if add_to_db then
				    	Instructional.AddButton(enum.input.SPECIAL_ABILITY_SECONDARY, TRANSLATION["Add to database"])
				    elseif add_to_db == false then
				    	Instructional.AddButton(enum.input.SPECIAL_ABILITY_SECONDARY, TRANSLATION["Remove from db"])
				    end
				    Instructional:BackgroundColor(0, 0, 0, 80)
			    	Instructional:Draw()
		    	end
		  	end
		end)
	end, {"freecam"})
	__options.bool["WorldEditorPlacementAssist"] = ui.add_bool_option(TRANSLATION["Easy placement"], __submenus["WorldEditorSettings"], function(bool)
		if utils.show_info("editorplacement [on - off]") then ui.set_value(__options.bool["WorldEditorPlacementAssist"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") settings.World["WorldEditorPlacementAssist"] = bool
	end, {"editorplacement"})
	__options.bool["WorldEditorTpToReference"] = ui.add_bool_option(TRANSLATION["Auto teleport to reference"], __submenus["WorldEditorSettings"], function(bool)
		if utils.show_info("editortpreference [on - off]") then ui.set_value(__options.bool["WorldEditorTpToReference"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") settings.World["WorldEditorTpToReference"] = bool
	end, {"editortpreference"})
	ui.add_separator(TRANSLATION["Spawn settings"], __submenus["WorldEditorSettings"])
	__options.bool["WorldEditorSpawnInvincible"] = ui.add_bool_option(TRANSLATION["Spawn invincible"], __submenus["WorldEditorSettings"], function(bool)
		if utils.show_info("editorinvincible [on - off]") then ui.set_value(__options.bool["WorldEditorSpawnInvincible"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") settings.World["WorldEditorSpawnInvincible"] = bool
	end, {"editorinvincible"})
	__options.bool["WorldEditorBlockFleeing"] = ui.add_bool_option(TRANSLATION["Block fleeing"], __submenus["WorldEditorSettings"], function(bool)
		if utils.show_info("editorblockflee [on - off]") then ui.set_value(__options.bool["WorldEditorBlockFleeing"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") settings.World["WorldEditorBlockFleeing"] = bool
	end, {"editorblockflee"})
	__options.bool["WorldEditorSpawnFrozen"] = ui.add_bool_option(TRANSLATION["Spawn frozen in place"], __submenus["WorldEditorSettings"], function(bool)
		if utils.show_info("editorfreeze [on - off]") then ui.set_value(__options.bool["WorldEditorSpawnFrozen"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") settings.World["WorldEditorSpawnFrozen"] = bool
	end, {"editorfreeze"})

	local preview_obj = 1
	local preview_ped = 1
	local preview_veh = 1
	local rot = vector3.zero()
	local function Spawn(model)
		system.thread(true, 'spawn_object_'..system.thread_count(), function()
			local loaded, ihash = features.request_model(model)
			if not ihash then return POP_THREAD end
			if loaded == 0 then return end
			local pos = CAM.DOES_CAM_EXIST(cam) == 1 and cam_pos or features.gameplay_cam_pos()
			local crot = CAM.DOES_CAM_EXIST(cam) == 1 and cam_rot or features.gameplay_cam_rot()
			local endCoords = pos + (crot:rot_to_direction() * 100)
			local result = features.get_raycast_result(pos, endCoords, Global.created_preview2, -1)
			if result.didHit and settings.World["WorldEditorPlacementAssist"] then
				local dim = features.get_model_dimentions(ENTITY.GET_ENTITY_MODEL(Global.created_preview2))
				pos = vector3(result.endCoords.x, result.endCoords.y, result.endCoords.z + abs(dim.z))
			else
				pos = pos + crot:rot_to_direction() * 10
			end
			local entity
			if STREAMING.IS_MODEL_A_PED(ihash) == 1 then
				entity = peds.create_ped(ihash, pos)
			elseif STREAMING.IS_MODEL_A_VEHICLE(ihash) == 1 then
				entity = vehicles.spawn_vehicle(ihash, pos)
				model = vehicles.get_label_name(model)
			else
				entity = features.create_object(ihash, pos)
			end
			STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(ihash)
			if settings.World["WorldEditorSpawnInvincible"] then
				if ENTITY.IS_ENTITY_A_VEHICLE(entity) == 1 then
					vehicles.set_godmode(entity, true)
				else
					features.set_godmode(entity, true)
				end
			end
			if Global.created_preview2 then
				ENTITY.SET_ENTITY_ROTATION(entity, rot.x, rot.y, rot.z, 2, true)
			end
			ENTITY.SET_ENTITY_COORDS(entity, pos.x, pos.y, pos.z, false, false, false, false)
			EntityDb.AddEntityToDatabase(entity)
			if settings.World["WorldEditorBlockFleeing"] then
				EntityDb.entity_data[entity].noflee = true
				peds.calm_ped(entity, true)
			end
			if settings.World["WorldEditorSpawnFrozen"] then
				ENTITY.FREEZE_ENTITY_POSITION(entity, true)
			end
			return POP_THREAD
		end)
	end
	local step_val = {'0.0001','0.001', '0.01', '0.1', '1.0', '10.0', '100.0'}
	__options.string["WorldEditorInput"] = ui.add_input_string(TRANSLATION["Input model"], __submenus["WorldEditor"], function(text)
		if utils.show_info("create") then ui.set_value(__options.string["WorldEditorInput"], "", true) return end
		if not text or text == '' then return utils.hud_sound("ERROR") end
		text = text:lower()
		local data = cache:get("Input: "..text)
		if data then
			if data == 'none' then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Sorry I couldn't find any matching model"], settings.General["HudColorNotifyError"]) return utils.hud_sound("ERROR") end
			Spawn(data)
			return
		end
		local hash = tonumber(text) and tonumber(text) or utils.joaat(text)
		if STREAMING.IS_MODEL_VALID(hash) == 1 then
			cache:set("Input: "..text, hash, 100000)
			Spawn(hash)
			return
		end
		local _text = text:escpattern():ensurestart('^')
		for _, v in ipairs(vehicles.data)
		do
			if v.Name:find(_text) or (v.DisplayName and v.DisplayName:lower():find(_text)) or vehicles.get_label_name(v.Hash):lower():find(_text) then
				hash = v.Hash
				break
			end
		end
		if STREAMING.IS_MODEL_VALID(hash) == 1 and STREAMING.IS_MODEL_A_VEHICLE(hash) == 1 then
			cache:set("Input: "..text, hash, 100000)
			Spawn(hash)
			return
		end
		local _text = text:escpattern()
		for _, v in ipairs(peds.models)
		do
			local name = peds.GetPedName(v)
			if v:find("[^%s]?".._text) or (name and name:lower():find("[^%s]?".._text)) then
				cache:set("Input: "..text, v, 100000)
				Spawn(v)
				return
			end
		end
		cache:set("Input: "..text, 'none', 100000)
		system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Sorry I couldn't find any matching model"], settings.General["HudColorNotifyError"])
		utils.hud_sound("ERROR")
	end, {"create"})

	__submenus["WorldPeds"] = ui.add_submenu(TRANSLATION["Spawn ped"])
	__suboptions["WorldPeds"] = ui.add_sub_option(TRANSLATION["Spawn ped"], __submenus["WorldEditor"] , __submenus["WorldPeds"])
	local ped_type = 1
	local selectedped = 0
	local curr_type
	local pedtypes = {
	    "Ambient female",
	    "Ambient male",
	    "Animals",
	    "Cutscene",
	    "Gang female",
	    "Gang male",
	    "Multiplayer",
	    "Scenario female",
	    "Scenario male",
	    "Story",
	    "Story scenario female",
	    "Story scenario male",
	    "Other",
	}

	local peds_results = {}
	local peds_search_model
	__submenus["WorldPedsSearch"] = ui.add_submenu(TRANSLATION["Search"])
	__suboptions["WorldPedsSearch"] = ui.add_sub_option(TRANSLATION["Search"], __submenus["WorldPeds"] , __submenus["WorldPedsSearch"])

	__options.string["PedsSearch"] = ui.add_input_string(TRANSLATION["Name"], __submenus["WorldPedsSearch"], function(text)
		local len = #peds_results
		peds_search_model = nil
		for i = 1, len
		do
			ui.remove(peds_results[i])
			peds_results[i] = nil
		end
		peds_results = {}
		text = text:lower()
		if #text < 3 then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Please enter name with at least 3 characters"], settings.General["HudColorNotifyError"]) utils.hud_sound("ERROR") return POP_THREAD end
		local count = 0
		text = text:escpattern()
		for i, v in ipairs(peds.models)
		do
			if v:find(text) or (peds.GetPedName(v) and peds.GetPedName(v):lower():find(text)) then
				insert(peds_results, ui.add_click_option(peds.GetPedName(v) or v, __submenus["WorldPedsSearch"], function()
					utils.hud_sound("SELECT")
					local hash = utils.joaat(v)
					if hash == peds_search_model then
						Spawn(hash)
					elseif hash ~= peds_search_model then
						peds_search_model = hash
					end
				end))
				count = count + 1
			end
		end
		if count == 0 then
			system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Sorry I couldn't find any matching model"], settings.General["HudColorNotifyError"])
			utils.hud_sound("ERROR")
		end
	end)

	local sel_ped = ui.add_choose(TRANSLATION["Select type"], __submenus["WorldPeds"], true, pedtypes, function(int) utils.hud_sound("YES") ped_type = int + 1
		if curr_type then 
			ui.remove(curr_type)
			curr_type = nil
		end
	end)
	ui.set_value(sel_ped, ped_type, true)
	system.thread(true, 'selected_ped_'..system.thread_count(), function()
		if not curr_type then
			curr_type = ui.add_choose(TRANSLATION["Select ped"], __submenus["WorldPeds"], false, peds.get_table_names(peds.sorted[ped_type]), function(int) utils.hud_sound("YES") Spawn(peds.sorted[ped_type][int + 1]) end)
		end
	end)

	__submenus["WorldVehicles"] = ui.add_submenu(TRANSLATION["Spawn vehicle"])
	__suboptions["WorldVehicles"] = ui.add_sub_option(TRANSLATION["Spawn vehicle"], __submenus["WorldEditor"] , __submenus["WorldVehicles"])

	local vehicle_results = {}
	local vehicle_search_model
	__submenus["WorldVehicleSearch"] = ui.add_submenu(TRANSLATION["Search"])
	__suboptions["WorldVehicleSearch"] = ui.add_sub_option(TRANSLATION["Search"], __submenus["WorldVehicles"] , __submenus["WorldVehicleSearch"])

	__options.string["VehiclesSearch"] = ui.add_input_string(TRANSLATION["Name"], __submenus["WorldVehicleSearch"], function(text)
		local len = #vehicle_results
		vehicle_search_model = nil
		for i = 1, len
		do
			ui.remove(vehicle_results[1])
			table.remove(vehicle_results, 1)
		end
		vehicle_results = {}
		text = text:lower()
		if #text < 3 then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Please enter name with at least 3 characters"], settings.General["HudColorNotifyError"]) utils.hud_sound("ERROR") return POP_THREAD end
		local count = 0
		text = text:escpattern()
		for i, v in ipairs(vehicles.data)
		do
			if v.Name:find(text) or (v.DisplayName and v.DisplayName:lower():find(text)) or vehicles.get_label_name(v.Name):lower():find(text) then
				insert(vehicle_results, ui.add_click_option(vehicles.get_label_name(v.Name), __submenus["WorldVehicleSearch"], function()
					utils.hud_sound("SELECT")
					local hash = utils.joaat(v.Name)
					if hash == vehicle_search_model then
						Spawn(hash)
					elseif hash ~= vehicle_search_model then
						vehicle_search_model = hash
					end
				end))
				count = count + 1
			end
		end
		if count == 0 then
			system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Sorry I couldn't find any matching model"], settings.General["HudColorNotifyError"])
			utils.hud_sound("ERROR")
		end
	end)

	local class = 0
	local selected = 0
	local classes = {}
	local curr_class
	for i = 0, 62
	do
		insert(classes, enum.vehicle_class[i])
	end
	local sel_class = ui.add_choose(TRANSLATION["Select class"], __submenus["WorldVehicles"], true, classes, function(int) utils.hud_sound("YES") class = int
		if curr_class then 
			ui.remove(curr_class)
			curr_class = nil
		end
	end)
	ui.set_value(sel_class, class, true)
	system.thread(true, 'selected_class_'..system.thread_count(), function()
		if not curr_class then
			curr_class = ui.add_choose(TRANSLATION["Select vehicle"], __submenus["WorldVehicles"], false, settings.Vehicle["VehManufacturer"] and vehicles.class_manufacturer[class] or vehicles.class[class], function(int)
				utils.hud_sound("YES")
				Spawn(vehicles.models[vehicles.get_veh_index(int + 1, class)][2])
			end)
		end
	end)

	__submenus["WorldObjects"] = ui.add_submenu(TRANSLATION["Spawn object"])
	__suboptions["WorldObjects"] = ui.add_sub_option(TRANSLATION["Spawn object"], __submenus["WorldEditor"] , __submenus["WorldObjects"])
	local object_results = {}
	local object_search_model
	__submenus["WorldObjectsSearch"] = ui.add_submenu(TRANSLATION["Search"])
	__suboptions["WorldObjectsSearch"] = ui.add_sub_option(TRANSLATION["Search"], __submenus["WorldObjects"] , __submenus["WorldObjectsSearch"])

	__options.string["ObjectsSearch"] = ui.add_input_string(TRANSLATION["Name"], __submenus["WorldObjectsSearch"], function(text)
		object_search_model = nil
		system.thread(true, 'search_objects', function()
			local time = clock() + .01
			for i = 1, #object_results
			do
				ui.remove(object_results[1])
				table.remove(object_results, 1)
				if time < clock() then return end
			end
			object_results = {}
			text = text:lower()
			if #text < 3 then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Please enter name with at least 3 characters"], settings.General["HudColorNotifyError"]) utils.hud_sound("ERROR") return POP_THREAD end
			local count = 0
			text = text:escpattern()
			for i, v in ipairs(objects)
			do
				if v:find(text) then
					insert(object_results, ui.add_click_option(v, __submenus["WorldObjectsSearch"], function()
						utils.hud_sound("SELECT")
						local hash = utils.joaat(v)
						if hash == object_search_model then
							Spawn(hash)
						elseif hash ~= object_search_model then
							object_search_model = hash
						end
					end))
					count = count + 1
					if count == 5000 then
						system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["You reached limit of 5000 results"], settings.General["HudColorNotifyError"], true)
						return POP_THREAD
					end
				end
			end
			if count == 0 then
				system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Sorry I couldn't find any matching model"], settings.General["HudColorNotifyError"])
				utils.hud_sound("ERROR")
			end
			return POP_THREAD
		end)
	end)

	__options.choose["Objects"] = ui.add_choose(TRANSLATION["Objects"], __submenus["WorldObjects"], false, objects, function(int) utils.hud_sound("YES") Spawn(objects[int+1]) end)

	ui.add_separator(TRANSLATION["Useful links"], __submenus["WorldEditor"])
	ui.add_click_option(TRANSLATION["Peds"]..' »', __submenus["WorldEditor"], function()
		if utils.show_info("linkpeds", 'Opens https://wiki.rage.mp/index.php?title=Peds') then return end
		utils.hud_sound("SELECT") filesystem.open('https://wiki.rage.mp/index.php?title=Peds')
	end, {"linkpeds"})
	ui.add_click_option(TRANSLATION["Vehicles"]..' »', __submenus["WorldEditor"], function()
		if utils.show_info("linkvehicles", 'Opens https://wiki.rage.mp/index.php?title=Vehicles') then return end
		utils.hud_sound("SELECT") filesystem.open('https://wiki.rage.mp/index.php?title=Vehicles')
	end, {"linkvehicles"}) 
	ui.add_click_option(TRANSLATION["Objects"]..' »', __submenus["WorldEditor"], function()
		if utils.show_info("linkobjects", 'Opens https://gta-objects.xyz/objects') then return end
		utils.hud_sound("SELECT") filesystem.open('https://gta-objects.xyz/objects')
	end, {"linkobjects"})

	local current_sub = 0
	local function GetSubSpawn()
		if ui.is_sub_open(__submenus["WorldPeds"]) then
			return 1
		elseif ui.is_sub_open(__submenus["WorldVehicles"]) then
			return 2
		elseif ui.is_sub_open(__submenus["WorldObjects"]) then
			return 3
		elseif ui.is_sub_open(__submenus["WorldPedsSearch"]) then
			return 4
		elseif ui.is_sub_open(__submenus["WorldVehicleSearch"]) then
			return 5
		elseif ui.is_sub_open(__submenus["WorldObjectsSearch"]) then
			return 6
		else
			return 0
		end
	end
	local model_prev
	system.thread(true, 'world_editor_obj_spawner', function()
		local sub_open = GetSubSpawn()
		if sub_open == 0 then 
			if Global.created_preview2 then
				entities.delete(Global.created_preview2)
				Global.created_preview2 = nil
				rot = vector3.zero()
			end
			current_sub = 0
			return
		end

		if (current_sub ~= sub_open and sub_open == 3) or (preview_obj ~= ui.get_value(__options.choose["Objects"]) + 1) then
			STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(model_prev)
			if Global.created_preview2 then
				entities.delete(Global.created_preview2)
				Global.created_preview2 = nil
				rot = vector3.zero()
			end
			preview_obj = ui.get_value(__options.choose["Objects"]) + 1
			current_sub = 3
			model_prev = objects[preview_obj]
		elseif (current_sub ~= sub_open and sub_open == 2) or (curr_class and preview_veh ~= ui.get_value(curr_class) + 1) or selected ~= ui.get_value(sel_class) then
			STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(model_prev)
			if Global.created_preview2 then
				entities.delete(Global.created_preview2)
				Global.created_preview2 = nil
				rot = vector3.zero()
			end
			preview_veh = ui.get_value(curr_class) + 1
			current_sub = 2
			selected = ui.get_value(sel_class)
			model_prev = vehicles.models[vehicles.get_veh_index(ui.get_value(curr_class) + 1, class)][2]
		elseif (current_sub ~= sub_open and sub_open == 1) or (curr_type and preview_ped ~= ui.get_value(curr_type) + 1) or selectedped ~= ui.get_value(sel_ped) then
			STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(model_prev)
			if Global.created_preview2 then
				entities.delete(Global.created_preview2)
				Global.created_preview2 = nil
				rot = vector3.zero()
			end
			preview_ped = ui.get_value(curr_type) + 1
			current_sub = 1
			selectedped = ui.get_value(sel_ped)
			model_prev = peds.sorted[ped_type][ui.get_value(curr_type) + 1]
		elseif (current_sub ~= sub_open and sub_open == 4) or sub_open == 4 and (peds_search_model and model_prev ~= peds_search_model) then
			STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(model_prev)
			if Global.created_preview2 then
				entities.delete(Global.created_preview2)
				Global.created_preview2 = nil
				rot = vector3.zero()
			end
			current_sub = 4
			model_prev = peds_search_model
		elseif (current_sub ~= sub_open and sub_open == 5) or sub_open == 5 and (vehicle_search_model and model_prev ~= vehicle_search_model) then
			STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(model_prev)
			if Global.created_preview2 then
				entities.delete(Global.created_preview2)
				Global.created_preview2 = nil
				rot = vector3.zero()
			end
			current_sub = 5
			model_prev = vehicle_search_model
		elseif (current_sub ~= sub_open and sub_open == 6) or sub_open == 6 and (object_search_model and model_prev ~= object_search_model) then
			STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(model_prev)
			if Global.created_preview2 then
				entities.delete(Global.created_preview2)
				Global.created_preview2 = nil
				rot = vector3.zero()
			end
			current_sub = 6
			model_prev = object_search_model
		end
		if not Global.created_preview2 and model_prev then
			local loaded, hash = features.request_model(model_prev)
			if not hash or loaded == 0 then return end
			local pos = CAM.DOES_CAM_EXIST(cam) == 1 and cam_pos or features.gameplay_cam_pos()
			local rot = CAM.DOES_CAM_EXIST(cam) == 1 and cam_rot or features.gameplay_cam_rot()
			local dir = rot:rot_to_direction() * 10
			pos = pos + dir
			if STREAMING.IS_MODEL_A_PED(hash) == 1 then
				Global.created_preview2 = peds.create_ped(hash, pos)
			elseif STREAMING.IS_MODEL_A_VEHICLE(hash) == 1 then
				Global.created_preview2 = vehicles.spawn_vehicle(hash, pos)
			else
				Global.created_preview2 = entities.create_object(hash, pos)
			end
			NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(Global.created_preview2), false)
			NETWORK._NETWORK_SET_ENTITY_INVISIBLE_TO_NETWORK(Global.created_preview2, true)
			STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
			ENTITY.FREEZE_ENTITY_POSITION(Global.created_preview2, true)
			ENTITY.SET_ENTITY_COLLISION(Global.created_preview2, false, false)
			ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Global.created_preview2, pos.x, pos.y, pos.z, false, false, false)
			ENTITY.SET_ENTITY_ROTATION(Global.created_preview2, 0, 0, 0, 2, true)
			ENTITY.SET_ENTITY_ALPHA(Global.created_preview2, 160, false)
			rot = vector3.zero()
		else
			if ENTITY.DOES_ENTITY_EXIST(Global.created_preview2) == 0 then Global.created_preview2 = nil return end
			peds.calm_ped(Global.created_preview2, true)
			features.set_godmode(Global.created_preview2, true)
			ENTITY.FREEZE_ENTITY_POSITION(Global.created_preview2, true)
			local pos = CAM.DOES_CAM_EXIST(cam) == 1 and cam_pos or features.gameplay_cam_pos()
			local crot = CAM.DOES_CAM_EXIST(cam) == 1 and cam_rot or features.gameplay_cam_rot()
			local endCoords = pos + (crot:rot_to_direction() * 100)
			local result = features.get_raycast_result(pos, endCoords, Global.created_preview2, -1)
			if result.didHit and settings.World["WorldEditorPlacementAssist"] then
				local dim = features.get_model_dimentions(ENTITY.GET_ENTITY_MODEL(Global.created_preview2))
				pos = vector3(result.endCoords.x, result.endCoords.y, result.endCoords.z + abs(dim.z))
			else
				pos = pos + crot:rot_to_direction() * 10
			end
			ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Global.created_preview2, pos.x, pos.y, pos.z, false, false, false)
			features.draw_box_on_entity2(Global.created_preview2, pos)
			ENTITY.SET_ENTITY_ALPHA(Global.created_preview2, 160, false)
			ENTITY.SET_ENTITY_COLLISION(Global.created_preview2, false, false)
			local erot = features.get_entity_rot(Global.created_preview2)
			PAD.DISABLE_CONTROL_ACTION(0, enum.input.VEH_SUB_ASCEND, true)
			PAD.DISABLE_CONTROL_ACTION(0, enum.input.CELLPHONE_UP, true)
			PAD.DISABLE_CONTROL_ACTION(0, enum.input.CELLPHONE_DOWN, true)
			PAD.DISABLE_CONTROL_ACTION(0, enum.input.VEH_LOOK_BEHIND, true)
			PAD.DISABLE_CONTROL_ACTION(0, enum.input.MULTIPLAYER_INFO, true)
			PAD.DISABLE_CONTROL_ACTION(0, enum.input.VEH_HORN, true)
			PAD.DISABLE_CONTROL_ACTION(0, enum.input.VEH_RADIO_WHEEL, true)
			local model = ENTITY.GET_ENTITY_MODEL(Global.created_preview2)
			if STREAMING.IS_MODEL_A_VEHICLE(model) == 1 then
				local max = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(model) - 2
			    for i = -1, max do
			    	local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(Global.created_preview2, i, true)
			    	if ped ~= 0 then
			    		TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
			    	end
			    end
			end
			local mult = 1
			if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.VEH_SUB_ASCEND) == 1 then
				mult = 10
	    	end
			if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.CELLPHONE_UP) == 1 then
				erot = erot + vector3.right() / mult
			end
			if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.CELLPHONE_DOWN) == 1 then
				erot = erot + vector3.left() / mult
			end
			if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.VEH_LOOK_BEHIND) == 1 then
				erot = erot + vector3.forward() / mult
			end
			if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.MULTIPLAYER_INFO) == 1 then
				erot = erot + vector3.back() / mult
			end
			if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.VEH_HORN) == 1 then
				erot = erot + vector3.up() / mult
			end
			if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.VEH_RADIO_WHEEL) == 1 then
				erot = erot + vector3.down() / mult
			end
			rot = erot
			ENTITY.SET_ENTITY_ROTATION(Global.created_preview2, erot.x, erot.y, erot.z, 2, true)
			if settings.General["ShowControls"] and Instructional:New() then
				Instructional.AddButton(enum.input.VEH_SUB_ASCEND, TRANSLATION["Precision"])
		    	Instructional.AddButton(enum.input.CELLPHONE_UP, "")
		    	Instructional.AddButton(enum.input.CELLPHONE_DOWN, TRANSLATION["Pitch"])
		    	Instructional.AddButton(enum.input.VEH_LOOK_BEHIND, "")
		    	Instructional.AddButton(enum.input.MULTIPLAYER_INFO, TRANSLATION["Roll"])
		    	Instructional.AddButton(enum.input.VEH_HORN, "")
		    	Instructional.AddButton(enum.input.VEH_RADIO_WHEEL, TRANSLATION["Yaw"])
		    	Instructional:BackgroundColor(0, 0, 0, 80)
		    	Instructional:Draw()
		    end
		end
	end, true)
	local attachment_entities = {}
	local function RemoveAttachmentOptions()
		for _, v in pairs(attachment_entities)
		do
			ui.remove(v)
		end
		attachment_entities = {}
	end
	local function ChangeAttachParams(entity)
		if ENTITY.IS_ENTITY_ATTACHED(entity) == 0 or not EntityDb.IsValid(entity) then return end
		local attachment = ENTITY.GET_ENTITY_ATTACHED_TO(entity)
		local tabl = EntityDb.spawned_options[entity]
		EntityDb.entity_data[entity].attach_bone = ui.get_value(tabl.attach_bone)
		EntityDb.entity_data[entity].attachx = ui.get_value(tabl.attachx)
		EntityDb.entity_data[entity].attachy = ui.get_value(tabl.attachy)
		EntityDb.entity_data[entity].attachz = ui.get_value(tabl.attachz)
		EntityDb.entity_data[entity].pitch = ui.get_value(tabl.pitch)
		EntityDb.entity_data[entity].roll = ui.get_value(tabl.roll)
		EntityDb.entity_data[entity].yaw = ui.get_value(tabl.yaw)
		entities.request_control(entity, function()
			ENTITY.ATTACH_ENTITY_TO_ENTITY(entity, attachment, ui.get_value(tabl.attach_bone),
				ui.get_value(tabl.attachx), ui.get_value(tabl.attachy), ui.get_value(tabl.attachz),
				ui.get_value(tabl.pitch), ui.get_value(tabl.roll), ui.get_value(tabl.yaw),
				false, true, EntityDb.entity_data[entity].collision, EntityDb.entity_data[entity].type == 1, 2, true
			)
		end)
	end

	local classes = {}
	for i = 0, 62
	do
		insert(classes, enum.vehicle_class[i])
	end

	local function change_sound(v, veh, class, parent)
		if not EntityDb.IsValid(veh) then return utils.hud_sound("ERROR") end
		utils.hud_sound("YES")
		local model = vehicles.models[vehicles.get_veh_index(ui.get_value(parent.curr_class) + 1, class)][1]
		AUDIO._FORCE_VEHICLE_ENGINE_AUDIO(veh, model)
		v.engine_sound = model
	end

	local function AddMenuPed(ped, sub, parent, v)
		parent.block_flee = ui.add_bool_option(TRANSLATION["Block fleeing"], sub, function(bool)
			if not EntityDb.IsValid(ped) then return utils.hud_sound("ERROR") end
			utils.hud_sound("TOGGLE_ON")
			peds.calm_ped(ped, bool)
			v.noflee = bool
		end)
		parent.can_ragdoll = ui.add_bool_option(TRANSLATION["Can ragdoll"], sub, function(bool)
			if not EntityDb.IsValid(ped) then return utils.hud_sound("ERROR") end
			utils.hud_sound("TOGGLE_ON")
			entities.request_control(ped, function()
				PED.SET_PED_CAN_RAGDOLL(ped, bool)
				PED.SET_PED_CAN_RAGDOLL_FROM_PLAYER_IMPACT(ped, bool)
			end)
		end)
		parent.is_tiny = ui.add_bool_option(TRANSLATION["Tiny"], sub, function(bool)
			if not EntityDb.IsValid(ped) then return utils.hud_sound("ERROR") end
			utils.hud_sound("TOGGLE_ON")
			entities.request_control(ped, function()
				PED.SET_PED_CONFIG_FLAG(ped, 223, bool)
			end)
		end)
		parent.ped_health = ui.add_num_option(TRANSLATION["Health"], sub, 0, PED.GET_PED_MAX_HEALTH(ped), 1, function(int)
			if not EntityDb.IsValid(ped) then return utils.hud_sound("ERROR") end
			utils.hud_sound("YES")
			entities.request_control(ped, function()
				ENTITY.SET_ENTITY_HEALTH(ped, int, 0)
			end)
		end)
		parent.ped_armor = ui.add_num_option(TRANSLATION["Armour"], sub, 0, 100, 1, function(int)
			if not EntityDb.IsValid(ped) then return utils.hud_sound("ERROR") end
			utils.hud_sound("YES")
			entities.request_control(ped, function()
				PED.SET_PED_ARMOUR(ped, int)
			end)
		end)
		parent.weapons_choose = ui.add_choose(TRANSLATION["Give weapon"], sub, false, weapons.names, function(int)
			if not EntityDb.IsValid(ped) then return utils.hud_sound("ERROR") end
			utils.hud_sound("YES")
			if WEAPON.HAS_PED_GOT_WEAPON(ped, weapons.hashes[int+1], false) == 0 then
				WEAPON.GIVE_WEAPON_TO_PED(ped, weapons.hashes[int+1], 9999, false, true)
			end
			WEAPON.SET_CURRENT_PED_WEAPON(ped, weapons.hashes[int+1], true)
		end)
		parent.wardobe_sub = ui.add_submenu(TRANSLATION["Wardrobe"])
		parent.wardobe_subopt = ui.add_sub_option(TRANSLATION["Wardrobe"], sub, parent.wardobe_sub)
		parent.wardobe_default = ui.add_click_option(TRANSLATION["Default"], parent.wardobe_sub, function()
			if not EntityDb.IsValid(ped) then return utils.hud_sound("ERROR") end
			utils.hud_sound("SELECT")
			entities.request_control(ped, function()
				PED.SET_PED_DEFAULT_COMPONENT_VARIATION(ped)
				PED.CLEAR_ALL_PED_PROPS(ped)
			end)
		end)
		parent.wardobe_random = ui.add_click_option(TRANSLATION["Random"], parent.wardobe_sub, function()
			if not EntityDb.IsValid(ped) then return utils.hud_sound("ERROR") end
			utils.hud_sound("SELECT")
			entities.request_control(ped, function()
				PED.SET_PED_RANDOM_COMPONENT_VARIATION(ped, 0)
				PED.SET_PED_RANDOM_PROPS(ped)
			end)
		end)
		EntityDb.entity_data[ped].drawables = {}
		local drawables_names = {}
		for i = 0, 11 do
			if PED.GET_NUMBER_OF_PED_DRAWABLE_VARIATIONS(ped, i) ~= 0 then
				insert(EntityDb.entity_data[ped].drawables, i)
				insert(drawables_names, TRANSLATION[enum.drawables[i+1]])
			end
		end
		if #drawables_names ~= 0 then
			parent.component_choose = ui.add_choose(TRANSLATION["Component"], parent.wardobe_sub, true, drawables_names, function(int)
				if not EntityDb.IsValid(ped) then return utils.hud_sound("ERROR") end
				utils.hud_sound("YES")
				ui.set_num_max(parent.component_id, PED.GET_NUMBER_OF_PED_DRAWABLE_VARIATIONS(ped, EntityDb.entity_data[ped].drawables[int+1]) - 1)
			end)
			parent.component_id = ui.add_num_option(TRANSLATION["Variation"], parent.wardobe_sub, -1, 0, 1, function(int)
				if not EntityDb.IsValid(ped) then return utils.hud_sound("ERROR") end
				utils.hud_sound("YES")
				entities.request_control(ped, function()
					local id = EntityDb.entity_data[ped].drawables[ui.get_value(parent.component_choose)+1]
					--if PED.IS_PED_COMPONENT_VARIATION_VALID(ped, id, int, 0) == 0 then return end
					PED.SET_PED_COMPONENT_VARIATION(ped, id, int, 0, 0)
				end)
			end)
			parent.texture_id = ui.add_num_option(TRANSLATION["Texture"], parent.wardobe_sub, -1, 0, 1, function(int)
				if not EntityDb.IsValid(ped) then return utils.hud_sound("ERROR") end
				utils.hud_sound("YES")
				entities.request_control(ped, function()
					local id = EntityDb.entity_data[ped].drawables[ui.get_value(parent.component_choose)+1]
					local drawable = PED.GET_PED_DRAWABLE_VARIATION(ped, id)
					--if PED.IS_PED_COMPONENT_VARIATION_VALID(ped, id, drawable, int) == 0 then return end
					PED.SET_PED_COMPONENT_VARIATION(ped, id, drawable, int, 0)
				end)
			end)
			ui.set_num_max(parent.component_id, PED.GET_NUMBER_OF_PED_DRAWABLE_VARIATIONS(ped, EntityDb.entity_data[ped].drawables[1]) - 1)
		end
		EntityDb.entity_data[ped].props = {}
		local props_names = {}
		for i = 0, 9 do
			if PED.GET_NUMBER_OF_PED_PROP_DRAWABLE_VARIATIONS(ped, i) ~= 0 then
				insert(EntityDb.entity_data[ped].props, i)
				insert(props_names, TRANSLATION[enum.props[i+1]] or enum.props[i+1])
			end
		end
		if #props_names ~= 0 then
			parent.prop_choose = ui.add_choose(TRANSLATION["Prop"], parent.wardobe_sub, true, props_names, function(int)
				if not EntityDb.IsValid(ped) then return utils.hud_sound("ERROR") end
				utils.hud_sound("YES")
				ui.set_num_max(parent.prop_id, PED.GET_NUMBER_OF_PED_PROP_DRAWABLE_VARIATIONS(ped, EntityDb.entity_data[ped].props[int+1]) - 1)
			end)
			parent.prop_id = ui.add_num_option(TRANSLATION["Variation"], parent.wardobe_sub, -1, 0, 1, function(int)
				if not EntityDb.IsValid(ped) then return utils.hud_sound("ERROR") end
				utils.hud_sound("YES")
				entities.request_control(ped, function()
					local id = EntityDb.entity_data[ped].props[ui.get_value(parent.prop_choose)+1]
					if int == - 1 then
						PED.CLEAR_PED_PROP(ped, id)
					else
						PED.SET_PED_PROP_INDEX(ped, id, int, 0, true)
					end
				end)
			end)
			parent.proptexture_id = ui.add_num_option(TRANSLATION["Texture"], parent.wardobe_sub, 0, 0, 1, function(int)
				if not EntityDb.IsValid(ped) then return utils.hud_sound("ERROR") end
				utils.hud_sound("YES")
				entities.request_control(ped, function()
					local id = EntityDb.entity_data[ped].props[ui.get_value(parent.prop_choose)+1]
					local prop = PED.GET_PED_PROP_INDEX(ped, id)
					if prop == -1 then return end
					PED.SET_PED_PROP_INDEX(ped, id, prop, int, true)
				end)
			end)
			ui.set_num_max(parent.prop_id, PED.GET_NUMBER_OF_PED_PROP_DRAWABLE_VARIATIONS(ped, EntityDb.entity_data[ped].props[1]) - 1)
		end
		parent.ped_task_anim = ui.add_submenu(TRANSLATION["Play animation"])
		parent.ped_task_anim_subopt = ui.add_sub_option(TRANSLATION["Play animation"], sub, parent.ped_task_anim)
		parent.stop_anim = ui.add_click_option(TRANSLATION["Stop animation"], parent.ped_task_anim, function()
			if not EntityDb.IsValid(ped) then return utils.hud_sound("ERROR") end
			utils.hud_sound("SELECT")
			TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped) 
			EntityDb.entity_data[ped].task_anim = nil
		end)
		parent.anim_blendin = ui.add_num_option(TRANSLATION["Blend-In Speed"], parent.ped_task_anim, -999999999, 999999999, 1, function()
			utils.hud_sound("YES")
		end)
		ui.set_value(parent.anim_blendin, 8, true)
		parent.anim_blendout = ui.add_num_option(TRANSLATION["Blend-Out Speed"], parent.ped_task_anim, -999999999, 999999999, 1, function()
			utils.hud_sound("YES")
		end)
		ui.set_value(parent.anim_blendout, -8, true)
		parent.anim_duration = ui.add_num_option(TRANSLATION["Duration (ms)"], parent.ped_task_anim, -1, 999999999, 100, function()
			utils.hud_sound("YES")
		end)
		ui.set_value(parent.anim_duration, -1, true)
		parent.anim_playback = ui.add_float_option(TRANSLATION["Playback rate"],parent.ped_task_anim, 0, 1, .1, 1, function()
			utils.hud_sound("YES")
		end)
		ui.set_value(parent.anim_playback, 0, true)
		parent.anim_loop = ui.add_bool_option(TRANSLATION["Loop"],parent.ped_task_anim, function()
			utils.hud_sound("TOGGLE_ON")
		end)
		ui.set_value(parent.anim_loop, true, true)
		parent.anim_stop_last_frame = ui.add_bool_option(TRANSLATION["Stop on last frame"],parent.ped_task_anim, function()
			utils.hud_sound("TOGGLE_ON")
		end)
		parent.anim_upperbody = ui.add_bool_option(TRANSLATION["Only animate upper body"], parent.ped_task_anim, function()
			utils.hud_sound("TOGGLE_ON")
		end)
		parent.anim_allow_control = ui.add_bool_option(TRANSLATION["Allow player control"], parent.ped_task_anim, function()
			utils.hud_sound("TOGGLE_ON")
		end)
		parent.anim_choose = ui.add_choose(TRANSLATION["Animations"], parent.ped_task_anim, false, Global.anims, function(int)
			utils.hud_sound("YES")
			ui.set_value(parent.anim_input_name, peds.anims[int + 1][3], true)
			ui.set_value(parent.anim_input_dict, peds.anims[int + 1][2], true)
		end)
		parent.anim_input_dict = ui.add_input_string(TRANSLATION["Anim dictionary"], parent.ped_task_anim, function()
			utils.hud_sound("YES")
		end)
		parent.anim_input_name = ui.add_input_string(TRANSLATION["Anim name"], parent.ped_task_anim, function()
			utils.hud_sound("YES")
		end)
		local anim_name = (EntityDb.entity_data[ped] and EntityDb.entity_data[ped].task_anim) and EntityDb.entity_data[ped].task_anim.name or nil
		local anim_dict = (EntityDb.entity_data[ped] and EntityDb.entity_data[ped].task_anim) and EntityDb.entity_data[ped].task_anim.dict or nil
		ui.set_value(parent.anim_input_name, anim_name and tostring(anim_name) or peds.anims[ui.get_value(parent.anim_choose) + 1][3], true)
		ui.set_value(parent.anim_input_dict, anim_dict and tostring(anim_dict) or peds.anims[ui.get_value(parent.anim_choose) + 1][2], true)
		ui.add_click_option(TRANSLATION["Play"], parent.ped_task_anim, function()
			if not EntityDb.IsValid(ped) then return utils.hud_sound("ERROR") end
			local dict = ui.get_value(parent.anim_input_dict)
			if STREAMING.DOES_ANIM_DICT_EXIST(dict) == 0 then system.notify(TRANSLATION["Error"], TRANSLATION["Seems like this dictionary doesn't exist"]) return utils.hud_sound("ERROR") end
			utils.hud_sound("SELECT")
			local flags = 0
			flags = ui.get_value(parent.anim_loop) and (flags + enum.anim_flag.Loop) or flags
			flags = ui.get_value(parent.anim_stop_last_frame) and (flags + enum.anim_flag.StopOnLastFrame) or flags
			flags = ui.get_value(parent.anim_upperbody) and (flags + enum.anim_flag.OnlyAnimateUpperBody) or flags
			flags = ui.get_value(parent.anim_allow_control) and (flags + enum.anim_flag.AllowPlayerControl) or flags
			EntityDb.entity_data[ped].task_anim = {
				dict = dict,
				name = ui.get_value(parent.anim_input_name),
				blend_in = ui.get_value(parent.anim_blendin),
				blend_out = ui.get_value(parent.anim_blendout),
				playback = ui.get_value(parent.anim_playback),
				duration = ui.get_value(parent.anim_duration),
				flags = flags
			}
			EntityDb.TaskAnim(ped)
		end)

		parent.anim_separator = ui.add_separator(TRANSLATION["Scenarios"], parent.ped_task_anim)

		parent.ped_stop_scenario = ui.add_click_option(TRANSLATION["Stop scenario"], parent.ped_task_anim, function()
			if not EntityDb.IsValid(ped) then return utils.hud_sound("ERROR") end
			EntityDb.entity_data[ped].task_scenario = nil
			TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
		end)
		parent.ped_scenario_choose = ui.add_choose(TRANSLATION["Play"], parent.ped_task_anim, false, Global.scenarios, function(int)
			if not EntityDb.IsValid(ped) then return utils.hud_sound("ERROR") end
			utils.hud_sound("YES")
			EntityDb.entity_data[ped].task_scenario = peds.scenario[int + 1][2]
			peds.play_scenario(ped, peds.scenario[int + 1][2])
		end)

		parent.ped_veh_sub = ui.add_submenu(TRANSLATION["Set into vehicle"])
		parent.ped_veh_subopt = ui.add_sub_option(TRANSLATION["Set into vehicle"], sub, parent.ped_veh_sub)
		local ped_vehs = {}
		local function RemoveVehicles()
			for _, v in pairs(ped_vehs)
			do
				ui.remove(v)
			end
			ped_vehs = {}
		end

		parent.enter_veh = ui.add_click_option(TRANSLATION["Enter vehicle"], parent.ped_veh_sub, function()
			if not EntityDb.IsValid(ped) then return utils.hud_sound("ERROR") end
			RemoveVehicles()
			system.thread(true, 'world_editor_enter_veh', function(tick)
				local _entities = 0
				for k in pairs(EntityDb.entity_data)
				do
					if ENTITY.IS_ENTITY_A_VEHICLE(k) == 1 then
						_entities = _entities + 1
						if _entities > 1 then break end
					end
				end

				if _entities < 1 then
					system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["No vehicles"], settings.General["HudColorNotifyError"])
					RemoveVehicles()
					if tick == 0 then utils.hud_sound("ERROR") end
					return POP_THREAD
				end
				if not ui.is_sub_open(parent.ped_veh_sub) then
					RemoveVehicles()
					return POP_THREAD
				end
				features.draw_box_on_entity(ped, 255, 128, 0)
				if tick == 0 then
					utils.hud_sound("SELECT")
					ped_vehs[0] = ui.add_separator(TRANSLATION["Vehicles"], parent.ped_veh_sub)
					for i, e in pairs(EntityDb.entity_data)
					do
						if EntityDb.IsValid(i) and ENTITY.IS_ENTITY_A_VEHICLE(i) == 1 then
							ped_vehs[i] = ui.add_num_option(format(e.name..' (%i)', i), parent.ped_veh_sub, -1, VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(ENTITY.GET_ENTITY_MODEL(i)) - 2, 1, function(int)
								if not EntityDb.IsValid(i) then return utils.hud_sound("ERROR") end
								utils.hud_sound("YES")
								entities.request_control(ped, function()
									PED.SET_PED_INTO_VEHICLE(ped, i, int)
								end)
							end)
						end
					end
				end
			end)
		end)
	end

	local function AddMenuVehicle(veh, sub, parent, v)
		vehicles.tuning_menu(veh, sub, parent)

		parent.repair = ui.add_click_option(TRANSLATION["Repair vehicle"], sub, function()
			if not EntityDb.IsValid(veh) then return utils.hud_sound("ERROR") end
			utils.hud_sound("SELECT")
			entities.request_control(veh, function()
				vehicles.repair(veh)
			end)
		end)
		parent.change_sound_sub = ui.add_submenu(TRANSLATION["Change sound"])
		parent.change_sound_subopt = ui.add_sub_option(TRANSLATION["Change sound"], sub, parent.change_sound_sub)
		local selected_vehicle = 1
		local class = 0
		parent.sel_class = ui.add_choose(TRANSLATION["Select class"], parent.change_sound_sub, true, classes, function(int) class = int
			if not EntityDb.IsValid(veh) then return utils.hud_sound("ERROR") end
			utils.hud_sound("YES")
			if parent.curr_class then
				ui.remove(parent.curr_class)
				parent.curr_class = nil
			end
		end)
		ui.set_value(parent.sel_class, class, true)
		system.thread(true, 'selected_class_'..system.thread_count(), function()
			if not EntityDb.IsValid(veh) then return POP_THREAD end
			if not ui.is_sub_open(parent.change_sound_sub) or parent.curr_class then return end
			parent.curr_class = ui.add_choose(TRANSLATION["Select vehicle"], parent.change_sound_sub, false, settings.Vehicle["VehManufacturer"] and vehicles.class_manufacturer[class] or vehicles.class[class], function(int)
				selected_vehicle = int + 1;change_sound(v, veh, class, parent)
			end)
		end)

		parent.door_control_sub = ui.add_submenu(HUD._GET_LABEL_TEXT("PIM_TDPV"))
		parent.door_control_subopt = ui.add_sub_option(HUD._GET_LABEL_TEXT("PIM_TDPV"), sub, parent.door_control_sub)
		parent.doorsepar = ui.add_separator(TRANSLATION["Open/close"], parent.door_control_sub)
		parent.door_open = ui.add_click_option(TRANSLATION["Open all"], parent.door_control_sub, function()
			if not EntityDb.IsValid(veh) then return utils.hud_sound("ERROR") end
			utils.hud_sound("SELECT")
			for i = 0, 5
			do
				entities.request_control(veh, function()
					VEHICLE.SET_VEHICLE_DOOR_OPEN(veh, i, false, false)
				end)
			end
		end)
		parent.door_close = ui.add_click_option(TRANSLATION["Close all"], parent.door_control_sub, function()
			if not EntityDb.IsValid(veh) then return utils.hud_sound("ERROR") end
			utils.hud_sound("SELECT")
			for i = 0, 5
			do
				entities.request_control(veh, function()
					VEHICLE.SET_VEHICLE_DOOR_SHUT(veh, i, false)
				end)
			end
		end)
		for i, e in ipairs(vehicles.door_index())
		do
			parent['door_'..i] = ui.add_click_option(e, parent.door_control_sub, function()
				if not EntityDb.IsValid(veh) then return utils.hud_sound("ERROR") end
				utils.hud_sound("SELECT")
				entities.request_control(veh, function()
					if VEHICLE.GET_VEHICLE_DOOR_ANGLE_RATIO(veh, i) == 0 then
						VEHICLE.SET_VEHICLE_DOOR_OPEN(veh, i, false, false)
					else
						VEHICLE.SET_VEHICLE_DOOR_SHUT(veh, i, false)
					end
				end)
			end)
		end
		parent.doorsepar_break = ui.add_separator(TRANSLATION["Break"], parent.door_control_sub)
		parent.door_break = ui.add_click_option(TRANSLATION["Break all"], parent.door_control_sub, function()
			if not EntityDb.IsValid(veh) then return utils.hud_sound("ERROR") end
			utils.hud_sound("SELECT")
			for i = 0, 5
			do
				entities.request_control(veh, function()
					VEHICLE._SET_VEHICLE_DOOR_CAN_BREAK(veh, i, true)
					VEHICLE.SET_VEHICLE_DOOR_BROKEN(veh, i, false)
				end)
			end
		end)
		parent.pop_tire = ui.add_choose(TRANSLATION["Pop tires"], sub, false, {TRANSLATION["All"], TRANSLATION["Front left"], TRANSLATION["Front right"], "2", "3", TRANSLATION["Rear left"], TRANSLATION["Rear right"], "45", "47"}, function(int)
			if not EntityDb.IsValid(veh) then return utils.hud_sound("ERROR") end
			utils.hud_sound("YES")
			entities.request_control(veh, function()
				VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(veh, true)
				if int == 0 then
					for i = 0, 5
					do
						VEHICLE.SET_VEHICLE_TYRE_BURST(veh, i, true, 1000)
					end
					VEHICLE.SET_VEHICLE_TYRE_BURST(veh, 45, true, 1000)
					VEHICLE.SET_VEHICLE_TYRE_BURST(veh, 47, true, 1000)
				elseif int < 7 then
					VEHICLE.SET_VEHICLE_TYRE_BURST(veh, int - 1, true, 1000)
				elseif int == 7 then
					VEHICLE.SET_VEHICLE_TYRE_BURST(veh, 45, true, 1000)
				elseif int == 8 then
					VEHICLE.SET_VEHICLE_TYRE_BURST(veh, 47, true, 1000)
				end
			end)
		end)
		for i, e in ipairs(vehicles.door_index())
		do
			parent["break_"..i] = ui.add_click_option(e, parent.door_control_sub, function()
				if not EntityDb.IsValid(veh) then return utils.hud_sound("ERROR") end
				utils.hud_sound("SELECT")
				entities.request_control(veh, function()
					VEHICLE._SET_VEHICLE_DOOR_CAN_BREAK(veh, i, true)
					VEHICLE.SET_VEHICLE_DOOR_BROKEN(veh, i, false)
				end)
			end)
		end
		parent.light_mult = ui.add_float_option(TRANSLATION["Lights intensity"], sub, 0, 1000, .1, 1, function(float)
			if not EntityDb.IsValid(veh) then return utils.hud_sound("ERROR") end
			utils.hud_sound("YES")
			entities.request_control(veh, function()
				VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(veh, float)
			end)
		end)
		parent.paint_fade = ui.add_float_option(TRANSLATION["Paint fade"], sub, 0, 1, .1, 1, function(float)
			if not EntityDb.IsValid(veh) then return utils.hud_sound("ERROR") end
			utils.hud_sound("YES")
			entities.request_control(veh, function()
				VEHICLE.SET_VEHICLE_ENVEFF_SCALE(veh, float)
			end)
		end)
		parent.dirt_level = ui.add_float_option(TRANSLATION["Dirt level"], sub, 0, 15, .1, 1, function(float)
			if not EntityDb.IsValid(veh) then return utils.hud_sound("ERROR") end
			utils.hud_sound("YES")
			entities.request_control(veh, function()
				VEHICLE.SET_VEHICLE_DIRT_LEVEL(veh, float)
			end)
		end)
		parent.engine_on = ui.add_bool_option(TRANSLATION["Engine on"], sub, function(bool)
			if not EntityDb.IsValid(veh) then return utils.hud_sound("ERROR") end
			utils.hud_sound("TOGGLE_ON")
			entities.request_control(veh, function()
				VEHICLE.SET_VEHICLE_ENGINE_ON(veh, bool, true, false)
			end)
		end)
		parent.lock_vehicle = ui.add_bool_option(TRANSLATION["Lock vehicle"], sub, function(bool)
			if not EntityDb.IsValid(veh) then return utils.hud_sound("ERROR") end
			utils.hud_sound("TOGGLE_ON")
			entities.request_control(veh, function()
				if bool then
					VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh, 6)
				 	VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh, 2)
				else
				 	VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh, 1)
				end
			end)
		end)
		parent.child_locks = ui.add_bool_option(TRANSLATION["Child locks"], sub, function(bool)
			if not EntityDb.IsValid(veh) then return utils.hud_sound("ERROR") end
			utils.hud_sound("TOGGLE_ON")
			entities.request_control(veh, function()
				if bool then
					VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh, 6)
				 	VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh, 4)
				else
				 	VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh, 1)
				end
			end)
		end)
		parent.siren = ui.add_bool_option(TRANSLATION["Siren"], sub, function(bool)
			if not EntityDb.IsValid(veh) then return utils.hud_sound("ERROR") end
			utils.hud_sound("TOGGLE_ON")
			entities.request_control(veh, function()
				VEHICLE.SET_VEHICLE_SIREN(veh, bool)
			end)
		end)
		parent.render_scorched = ui.add_bool_option(TRANSLATION["Scorched vehicle"], sub, function(bool)
			if not EntityDb.IsValid(veh) then return utils.hud_sound("ERROR") end
			utils.hud_sound("TOGGLE_ON")
			entities.request_control(veh, function()
				ENTITY.SET_ENTITY_RENDER_SCORCHED(veh, bool)
			end)
		end)
		parent.reduce_grip = ui.add_bool_option(TRANSLATION["Reduce grip"], sub, function(bool)
			if not EntityDb.IsValid(veh) then return utils.hud_sound("ERROR") end
			utils.hud_sound("TOGGLE_ON")
			entities.request_control(veh, function()
				VEHICLE.SET_VEHICLE_REDUCE_GRIP(veh, bool)
			end)
		end)
	end

	system.thread(true, 'world_editor_spawned_entities', function(tick)
		for k, v in pairs(EntityDb.entity_data)
		do
			if (ui.is_open() and EntityDb.spawned_options[k] and ui.is_sub_open(EntityDb.spawned_options[k].submenu) and EntityDb.IsValid(k)) or not v.pos then
				v.pos = features.get_entity_coords(k)
				v.rot = features.get_entity_rot(k)
				v.god = features.get_godmode(k)
				v.alpha = ENTITY.GET_ENTITY_ALPHA(k)
				v.lod_dist = ENTITY.GET_ENTITY_LOD_DIST(k)
				v.collision = ENTITY.GET_ENTITY_COLLISION_DISABLED(k) == 0
				v.freeze_position = features.is_frozen(k)
				v.visible = ENTITY.IS_ENTITY_VISIBLE(k) == 1
				v.is_attached = ENTITY.IS_ENTITY_ATTACHED(k) == 1
				local attpos = vector3.zero()
				local pitch, roll, yaw = vector3.zero():get()
				if v.is_attached and not v.attach_bone then
					local offset = vector3(ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(k, 0, 0, VEHICLE._GET_VEHICLE_SUSPENSION_HEIGHT(k) ~= -1 and VEHICLE._GET_VEHICLE_SUSPENSION_HEIGHT(k) or 0))
					local offpos1 = vector3(ENTITY.GET_OFFSET_FROM_ENTITY_GIVEN_WORLD_COORDS(k, offset.x, offset.y, offset.z))
					offset = vector3(ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ENTITY.GET_ENTITY_ATTACHED_TO(k), 0, 0, VEHICLE._GET_VEHICLE_SUSPENSION_HEIGHT(ENTITY.GET_ENTITY_ATTACHED_TO(k)) ~= -1 and VEHICLE._GET_VEHICLE_SUSPENSION_HEIGHT(ENTITY.GET_ENTITY_ATTACHED_TO(k)) or 0))
					local offpos2 = vector3(ENTITY.GET_OFFSET_FROM_ENTITY_GIVEN_WORLD_COORDS(ENTITY.GET_ENTITY_ATTACHED_TO(k), offset.x, offset.y, offset.z))
					local pos = features.get_entity_coords(k) + offpos1 + offpos2
					attpos.x = ENTITY.GET_OFFSET_FROM_ENTITY_GIVEN_WORLD_COORDS(ENTITY.GET_ENTITY_ATTACHED_TO(k), pos.x, pos.y, pos.z).x
					attpos.y = ENTITY.GET_OFFSET_FROM_ENTITY_GIVEN_WORLD_COORDS(ENTITY.GET_ENTITY_ATTACHED_TO(k), pos.x, pos.y, pos.z).y
					attpos.z = ENTITY.GET_OFFSET_FROM_ENTITY_GIVEN_WORLD_COORDS(ENTITY.GET_ENTITY_ATTACHED_TO(k), pos.x, pos.y, pos.z).z
					local rot1 = features.get_entity_rot(ENTITY.GET_ENTITY_ATTACHED_TO(k))
					local rot2 = features.get_entity_rot(k)
					pitch, roll, yaw = (rot2 - rot1):get()
				end
				if not v.is_attached then
					v.roll = nil
					v.pitch = nil
					v.yaw = nil
					v.attachx = nil
					v.attachy = nil
					v.attachz = nil
					v.attach_bone = nil
				else
					v.attach_bone = (not v.attach_bone) and 0 or v.attach_bone
					v.attachx = (not v.attachx) and attpos.x or v.attachx
					v.attachy = (not v.attachy) and attpos.y or v.attachy
					v.attachz = (not v.attachz) and attpos.z or v.attachz
					v.pitch = (not v.pitch) and pitch or v.pitch
					v.roll = (not v.roll) and roll or v.roll
					v.yaw = (not v.yaw) and yaw or v.yaw
				end
				v.noflee = v.noflee ~= nil and v.noflee or false
				if v.type == 3 then
					v.texture = OBJECT._GET_OBJECT_TEXTURE_VARIATION(k)
				end
			end
			if not EntityDb.spawned_options[k] then
				local update_attachment = function() utils.hud_sound("YES") ChangeAttachParams(k) end
				local sub = ui.add_submenu(v.name)
				local sub_attach = ui.add_submenu(TRANSLATION["Attach to something"])
				local sub_attached = ui.add_submenu(TRANSLATION["Attachment options"])
				local ped_properties = ui.add_submenu(TRANSLATION["Ped properties"])
				local vehicle_properties = ui.add_submenu(TRANSLATION["Vehicle properties"])
				EntityDb.spawned_options[k] = {
					submenu = sub,
					sub_option = ui.add_sub_option(v.name, __submenus["WorldEditorSpawned"], sub),
					step = ui.add_choose(TRANSLATION["Step"], sub, true, step_val, function(type)
						if not EntityDb.IsValid(k) then return utils.hud_sound("ERROR") end
						utils.hud_sound("YES")
						local value = tonumber(step_val[type + 1])
						ui.set_step(EntityDb.spawned_options[k].posx, value)
						ui.set_step(EntityDb.spawned_options[k].posy, value)
						ui.set_step(EntityDb.spawned_options[k].posz, value)
						ui.set_step(EntityDb.spawned_options[k].rotx, value)
						ui.set_step(EntityDb.spawned_options[k].roty, value)
						ui.set_step(EntityDb.spawned_options[k].rotz, value)
					end),
					separator_pos = ui.add_separator(TRANSLATION["Position"], sub),
					posx = ui.add_float_option("X", sub, -10000, 10000, .1, 4, function(float)
						if not EntityDb.IsValid(k) then return utils.hud_sound("ERROR") end
						utils.hud_sound("YES")
						entities.request_control(k, function()
							local pos = features.get_entity_coords(k)
							ENTITY.SET_ENTITY_COORDS_NO_OFFSET(k, float, pos.y, pos.z, false, false, false)
						end)
					end),
					posy = ui.add_float_option("Y", sub, -10000, 10000, .1, 4, function(float)
						if not EntityDb.IsValid(k) then return utils.hud_sound("ERROR") end
						utils.hud_sound("YES")
						entities.request_control(k, function()
							local pos = features.get_entity_coords(k)
							ENTITY.SET_ENTITY_COORDS_NO_OFFSET(k, pos.x, float, pos.z, false, false, false)
						end)
					end),
					posz = ui.add_float_option("Z", sub, -10000, 10000, .1, 4, function(float)
						if not EntityDb.IsValid(k) then return utils.hud_sound("ERROR") end
						utils.hud_sound("YES")
						entities.request_control(k, function()
							local pos = features.get_entity_coords(k)
							ENTITY.SET_ENTITY_COORDS_NO_OFFSET(k, pos.x, pos.y, float, false, false, false)
						end)
					end),
					separator_rot = ui.add_separator(TRANSLATION["Rotation"], sub),
					rotx = ui.add_float_option(TRANSLATION["Pitch"], sub, -90, 90, .1, 4, function(float)
						if not EntityDb.IsValid(k) then return utils.hud_sound("ERROR") end
						utils.hud_sound("YES")
						entities.request_control(k, function()
							local rot = features.get_entity_rot(k)
							ENTITY.SET_ENTITY_ROTATION(k, float, rot.y, rot.z, 2, true)
						end)
					end),
					roty = ui.add_float_option(TRANSLATION["Roll"], sub, -180, 180, .1, 4, function(float)
						if not EntityDb.IsValid(k) then return utils.hud_sound("ERROR") end
						utils.hud_sound("YES")
						entities.request_control(k, function()
							local rot = features.get_entity_rot(k)
							ENTITY.SET_ENTITY_ROTATION(k, rot.x, float, rot.z, 2, true)
						end)
					end),
					rotz = ui.add_float_option(TRANSLATION["Yaw"], sub, -180, 180, .1, 4, function(float)
						if not EntityDb.IsValid(k) then return utils.hud_sound("ERROR") end
						utils.hud_sound("YES")
						entities.request_control(k, function()
							local rot = features.get_entity_rot(k)
							ENTITY.SET_ENTITY_ROTATION(k, rot.x, rot.y, float, 2, true)
						end)
					end),
					reset_rot = ui.add_click_option(TRANSLATION["Reset rotation"], sub, function()
						if not EntityDb.IsValid(k) then return utils.hud_sound("ERROR") end
						utils.hud_sound("SELECT")
						entities.request_control(k, function()
							ENTITY.SET_ENTITY_ROTATION(k, 0, 0, 0, 2, true)
						end)
					end),
					separator_other = ui.add_separator(TRANSLATION["Other"], sub),
					godmode = ui.add_bool_option(TRANSLATION["Set entity godmode"], sub, function(bool)
						if not EntityDb.IsValid(k) then return utils.hud_sound("ERROR") end
						utils.hud_sound("TOGGLE_ON")
						entities.request_control(k, function()
							if ENTITY.IS_ENTITY_A_VEHICLE(k) == 1 then
								vehicles.set_godmode(k, bool)
							else
								features.set_godmode(k, bool)
							end
						end)
					end),
					freeze_position = ui.add_bool_option(TRANSLATION["Freeze entity position"], sub, function(bool)
						if not EntityDb.IsValid(k) then return utils.hud_sound("ERROR") end
						utils.hud_sound("TOGGLE_ON")
						entities.request_control(k, function()
							ENTITY.FREEZE_ENTITY_POSITION(k, bool)
						end)
					end),
					has_gravity = ui.add_bool_option(TRANSLATION["Gravity"], sub, function(bool)
						if not EntityDb.IsValid(k) then return utils.hud_sound("ERROR") end
						utils.hud_sound("TOGGLE_ON")
						entities.request_control(k, function()
							ENTITY.SET_ENTITY_HAS_GRAVITY(k, bool)
						end)
						v.gravity = bool
					end),
					dynamic = ui.add_bool_option(TRANSLATION["Dynamic"], sub, function(bool)
						if not EntityDb.IsValid(k) then return utils.hud_sound("ERROR") end
						utils.hud_sound("TOGGLE_ON")
						entities.request_control(k, function()
							ENTITY.SET_ENTITY_DYNAMIC(k, bool)
							if bool then
								features.set_entity_velocity(k, 0, 0, 0)
							end
						end)
					end),
					collision = ui.add_bool_option(TRANSLATION["Collision"], sub, function(bool)
						if not EntityDb.IsValid(k) then return utils.hud_sound("ERROR") end
						utils.hud_sound("TOGGLE_ON")
						entities.request_control(k, function()
							ENTITY.SET_ENTITY_COLLISION(k, bool, true)
						end)
					end),
					visible = ui.add_bool_option(TRANSLATION["Visible"], sub, function(bool)
						if not EntityDb.IsValid(k) then return utils.hud_sound("ERROR") end
						utils.hud_sound("TOGGLE_ON")
						entities.request_control(k, function()
							ENTITY.SET_ENTITY_VISIBLE(k, bool, false)
						end)
					end),
					alpha = ui.add_num_option(TRANSLATION["Alpha (local)"], sub, 0, 255, 1, function(int)
						if not EntityDb.IsValid(k) then return utils.hud_sound("ERROR") end
						utils.hud_sound("YES")
						entities.request_control(k, function()
							ENTITY.SET_ENTITY_ALPHA(k, int, false)
							if int == 255 then
								ENTITY.RESET_ENTITY_ALPHA(k)
							end
						end)
					end),
					lod_dist = ui.add_num_option(TRANSLATION["Lod distance"], sub, 0, 0xffff, 1, function(int)
						if not EntityDb.IsValid(k) then return utils.hud_sound("ERROR") end
						utils.hud_sound("YES")
						entities.request_control(k, function()
							ENTITY.SET_ENTITY_LOD_DIST(k, int)
						end)
					end),
					place_on_ground = ui.add_click_option(TRANSLATION["Place on ground"], sub, function()
						if not EntityDb.IsValid(k) then return utils.hud_sound("ERROR") end
						utils.hud_sound("SELECT")
						local pos = features.get_entity_coords(k)
						local success, z = features.get_ground_z(pos)
						if not success then return end
						local min = features.get_model_dimentions(ENTITY.GET_ENTITY_MODEL(k))
						entities.request_control(k, function()
							ENTITY.SET_ENTITY_COORDS_NO_OFFSET(k, pos.x, pos.y, z + abs(min.z), false, false, false)
							if v.type == 2 then
								VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(k, v)
							end
						end)
					end),
					tp_to = ui.add_click_option(TRANSLATION["Teleport to entity"], sub, function()
						if not EntityDb.IsValid(k) then return utils.hud_sound("ERROR") end
						utils.hud_sound("SELECT")
						local pos = v.pos
						if CAM.DOES_CAM_EXIST(cam) ~= 0 then
							CAM.SET_CAM_COORD(cam, pos.x, pos.y, pos.z)
							wait = clock() + 0.1
						else
							features.teleport(features.player_ped(), pos.x, pos.y, pos.z)
						end
					end),
					tp_toself = ui.add_click_option(TRANSLATION["Teleport to self"], sub, function()
						if not EntityDb.IsValid(k) then return utils.hud_sound("ERROR") end
						utils.hud_sound("SELECT")
						entities.request_control(k, function()
							local pos
							if CAM.DOES_CAM_EXIST(cam) ~= 0 then
								pos = CAM.GET_CAM_COORD(cam)
							else
								pos = features.get_player_coords()
							end
							ENTITY.SET_ENTITY_COORDS_NO_OFFSET(k, pos.x, pos.y, pos.z, false, false, false)
						end)
					end),
					sub_ped_prop = ped_properties,
					subopt_ped_prop = ui.add_sub_option(TRANSLATION["Ped properties"], sub, ped_properties),
					sub_veh_prop = vehicle_properties,
					subopt_veh_prop = ui.add_sub_option(TRANSLATION["Vehicle properties"], sub, vehicle_properties),
					sub_attach = sub_attach,
					sub_attached = sub_attached,
					subopt_attach = ui.add_sub_option(TRANSLATION["Attach to something"], sub, sub_attach),
					attachto = ui.add_click_option(TRANSLATION["Attach"], sub_attach, function()
						if not EntityDb.IsValid(k) then return utils.hud_sound("ERROR") end
						RemoveAttachmentOptions()
						system.thread(true, 'world_editor_attach', function(tick)
							local _entities = 0
							for _ in pairs(EntityDb.entity_data)
							do
								_entities = _entities + 1
								if _entities > 1 then break end
							end

							if _entities < 2 then
								system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["No entities to attach"], settings.General["HudColorNotifyError"])
								RemoveAttachmentOptions()
								if tick == 0 then utils.hud_sound("ERROR") end
								return POP_THREAD
							end
							if not ui.is_sub_open(sub_attach) then
								RemoveAttachmentOptions()
								return POP_THREAD
							end
							features.draw_box_on_entity(k, 255, 128, 0)
							if tick == 0 then
								utils.hud_sound("SELECT")
								attachment_entities[0] = ui.add_separator(TRANSLATION["Entities"], sub_attach)
								for i, e in pairs(EntityDb.entity_data)
								do
									if EntityDb.IsValid(i) and k ~= i then
										attachment_entities[i] = ui.add_choose(format(e.name..' (%i)', i), sub_attach, false, {TRANSLATION["Attach"], TRANSLATION["Highlight"]}, function(int)
											utils.hud_sound("YES")
											if int == 0 then
												if EntityDb.IsValid(k) then
													entities.request_control(k, function()
														if ENTITY.IS_ENTITY_ATTACHED(k) == 1 then
															ENTITY.DETACH_ENTITY(k, ui.get_value(EntityDb.spawned_options[k].dynamic), v.collision)
														end
														local tabl = EntityDb.spawned_options[k]
														ENTITY.ATTACH_ENTITY_TO_ENTITY(k, i, 0,
															0, 0, 0,
															0, 0, 0,
															false, true, v.collision, v.type == 1, 2, true
														)
														v.attach_bone = 0
														v.attachx = 0
														v.attachy = 0
														v.attachz = 0
														v.pitch = 0
														v.roll = 0
														v.yaw = 0
													end)
												end
												RemoveAttachmentOptions()
												system.remove_thread('world_editor_attach')
											else
												system.thread(true, 'highlight_entity_'..system.thread_count(), function(tick)
													if GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED("basejumping") == 0 then
														GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT("basejumping", false)
													end
													if ENTITY.IS_ENTITY_ON_SCREEN(i) == 1 then
														features.draw_box_on_entity(i, 0, 255, 0, 255)
														local pos = features.get_entity_coords(i) + vector3.up(2)
														GRAPHICS.DRAW_MARKER(2, pos.x, pos.y, pos.z + 2, 0, 0, 0, 0, 180, 0, 1, 1, 1, 0, 255, 0, 168, false, true, 1, false, 0, 0, false)
													end
													if tick == 30 then return POP_THREAD end
												end)
											end
										end)
									end
								end
							end
						end)
					end),
					attached_opt = ui.add_sub_option(TRANSLATION["Attachment options"], sub, sub_attached),
					attachstep = ui.add_choose(TRANSLATION["Step"], sub_attached, true, step_val, function(type)
						utils.hud_sound("YES")
						local value = tonumber(step_val[type + 1])
						ui.set_step(EntityDb.spawned_options[k].attachx, value)
						ui.set_step(EntityDb.spawned_options[k].attachy, value)
						ui.set_step(EntityDb.spawned_options[k].attachz, value)
						ui.set_step(EntityDb.spawned_options[k].pitch, value)
						ui.set_step(EntityDb.spawned_options[k].roll, value)
						ui.set_step(EntityDb.spawned_options[k].yaw, value)
					end),
					attachx = ui.add_float_option(TRANSLATION["Offset x"], sub_attached, -10000, 10000, .1, 4, update_attachment),
					attachy = ui.add_float_option(TRANSLATION["Offset y"], sub_attached, -10000, 10000, .1, 4, update_attachment),
					attachz = ui.add_float_option(TRANSLATION["Offset z"], sub_attached, -10000, 10000, .1, 4, update_attachment),
					pitch = ui.add_float_option(TRANSLATION["Pitch"], sub_attached, -10000, 10000, .1, 4, update_attachment),
					roll = ui.add_float_option(TRANSLATION["Roll"], sub_attached, -10000, 10000, .1, 4, update_attachment),
					yaw = ui.add_float_option(TRANSLATION["Yaw"], sub_attached, -10000, 10000, .1, 4, update_attachment),
					attach_bone = ui.add_num_option(TRANSLATION["Bone"], sub_attached, 0, 100, 1,  update_attachment),
					detach = ui.add_click_option(TRANSLATION["Detach"], sub_attached, function()
						utils.hud_sound("SELECT")
						entities.request_control(k, function()
							ENTITY.DETACH_ENTITY(k, ui.get_value(EntityDb.spawned_options[k].dynamic), v.collision)
						end)
					end),
					copy = ui.add_choose(TRANSLATION["Copy"], sub, false, {TRANSLATION["Only entity"], TRANSLATION["With attachments"]}, function(int)
						if not EntityDb.IsValid(k) then return utils.hud_sound("ERROR") end
						utils.hud_sound("YES")
						world_spawner.copy_entity(k, int == 1, ENTITY.IS_ENTITY_ATTACHED(k) == 1)
					end),
					delete = ui.add_click_option(TRANSLATION["Delete"], sub, function()
						if not EntityDb.entity_data[k] then return utils.hud_sound("ERROR") end
						utils.hud_sound("SELECT")
						if v.type == 2 and vehicles.get_player_vehicle() ~= 0 and k == vehicles.get_player_vehicle() then
							TASK.CLEAR_PED_TASKS_IMMEDIATELY(features.player_ped())
						end
						features.delete_entity(k)
						EntityDb.RemoveFromDatabase(k, true)
						EntityDb.RemoveInvalidEntities()
					end),
					remove = ui.add_click_option(TRANSLATION["Remove from db"], sub, function()
						if not EntityDb.entity_data[k] then return utils.hud_sound("ERROR") end
						utils.hud_sound("SELECT")
						EntityDb.RemoveFromDatabase(k, true)
						EntityDb.RemoveInvalidEntities()
					end),
				}
				if v.type == 1 then
					AddMenuPed(k, ped_properties, EntityDb.spawned_options[k], v)
				else
					ui.hide(EntityDb.spawned_options[k].subopt_ped_prop, true)
				end
				if v.type == 2 then
					AddMenuVehicle(k, vehicle_properties, EntityDb.spawned_options[k], v)
				else
					ui.hide(EntityDb.spawned_options[k].subopt_veh_prop, true)
				end
				if v.type == 3 then
					EntityDb.spawned_options[k].texture = ui.add_num_option(TRANSLATION["Texture"], sub, 1, 255, 1, function(int)
						if not EntityDb.IsValid(k) then return utils.hud_sound("ERROR") end
						utils.hud_sound("YES")
						entities.request_control(k, function()
							OBJECT._SET_OBJECT_TEXTURE_VARIATION(k, int)
						end)
					end)
				end
				ui.set_value(EntityDb.spawned_options[k].step, 3, true)
				ui.set_value(EntityDb.spawned_options[k].attachstep, 2, true)
				ui.set_value(EntityDb.spawned_options[k].dynamic, v.dynamic or true, true)
				ui.set_value(EntityDb.spawned_options[k].has_gravity, v.gravity or true, true)
				utils.no_sounds_this_frame()
			elseif ui.is_open() then
				local parent = EntityDb.spawned_options[k]
				if not EntityDb.IsValid(k) then
					-- ui.set_name(EntityDb.spawned_options[k].submenu, v.name..' **INVALID**')
					ui.set_name(parent.sub_option, v.name..' '..TRANSLATION["**INVALID**"])
				elseif ui.is_sub_open(parent.submenu) then
					if ENTITY.IS_ENTITY_ON_SCREEN(k) == 1 then
						features.draw_box_on_entity(k, 0, 255, 0, 255)
						if GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED("basejumping") == 0 then
							GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT("basejumping", false)
						else
							local world_pos = features.get_entity_coords(k)
							world_pos.z = features.get_entity_top_pos(k) + 1.5
							local screen = features.world_to_screen(world_pos)
							local res = features.get_screen_resolution()
							GRAPHICS.DRAW_SPRITE("basejumping", "arrow_pointer", screen.x, screen.y, .0117, .0117 * (res.x / res.y), 180, 0, 255, 0, 180, false)
						end

						--GRAPHICS.DRAW_MARKER(2, pos.x, pos.y, pos.z + 2, 0, 0, 0, 0, 180, 0, 1, 1, 1, 0, 255, 0, 168, false, true, 1, false, 0, 0, false)
					end
                    if not ui.is_hidden(parent.attached_opt) and ENTITY.IS_ENTITY_ATTACHED(k) == 0 then
                        ui.hide(parent.attached_opt, true)
                    elseif ui.is_hidden(parent.attached_opt) and ENTITY.IS_ENTITY_ATTACHED(k) == 1 then
                        ui.hide(parent.attached_opt, false)
                    end
                    ui.set_value(parent.godmode, v.god, true)
                    ui.set_value(parent.alpha, v.alpha, true)
                    ui.set_value(parent.lod_dist, v.lod_dist, true)
                    ui.set_value(parent.visible, v.visible, true)
                    ui.set_value(parent.collision, v.collision, true)
					ui.set_value(parent.freeze_position, v.freeze_position, true)
                    ui.set_value(parent.posx, v.pos.x, true)
                    ui.set_value(parent.posy, v.pos.y, true)
                    ui.set_value(parent.posz, v.pos.z, true)
                    ui.set_value(parent.rotx, v.rot.x, true)
                    ui.set_value(parent.roty, v.rot.y, true)
                    ui.set_value(parent.rotz, v.rot.z, true)
                    ui.set_value(parent.attach_bone, v.attach_bone, true)
                    ui.set_value(parent.attachx, v.attachx, true)
                    ui.set_value(parent.attachy, v.attachy, true)
                    ui.set_value(parent.attachz, v.attachz, true)
                    ui.set_value(parent.pitch, v.pitch, true)
                    ui.set_value(parent.roll, v.roll, true)
                    ui.set_value(parent.yaw, v.yaw, true)
                    if v.type == 3 then
                        ui.set_value(parent.texture, v.texture, true)
                    end
                elseif v.type == 2 and ui.is_sub_open(parent.sub_mods) then
                    local primary, secondary = s_memory.alloc_get(2)
                    VEHICLE.GET_VEHICLE_COLOURS(k, primary, secondary)
                    ui.set_value(parent.paint_primary_select, memory.read_int(primary), true)
                    ui.set_value(parent.paint_secondary_select, memory.read_int(secondary), true)
                    local r, g, b = s_memory.alloc_get(3)
                    VEHICLE.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(k, r, g, b)
                    ui.set_value(parent.paint_primary_rgb, memory.read_int(r), memory.read_int(g), memory.read_int(b), 255, true)
                    VEHICLE.GET_VEHICLE_CUSTOM_SECONDARY_COLOUR(k, r, g, b)
                    ui.set_value(parent.paint_secondary_rgb, memory.read_int(r), memory.read_int(g), memory.read_int(b), 255, true)
                    local pearl, wheel = s_memory.alloc_get(2)
                    VEHICLE.GET_VEHICLE_EXTRA_COLOURS(k, pearl, wheel)
                    ui.set_value(parent.paint_pearlescent_select, memory.read_int(pearl), true)
                    for i = 0, 48
				    do
				        if i < 17 or i > 24 and parent["veh_mod_"..i] then
				        	ui.set_value(parent["veh_mod_"..i], VEHICLE.GET_VEHICLE_MOD(k, i) + 1, true)
                    	end
                    end
                    ui.set_value(parent.turbo, VEHICLE.IS_TOGGLE_MOD_ON(k, 18) == 1, true)
                    ui.set_value(parent.xenons, VEHICLE.IS_TOGGLE_MOD_ON(k, 22) == 1, true)
                    ui.set_value(parent.licence_index, VEHICLE.GET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(k), true)
                    ui.set_value(parent.licence_text, VEHICLE.GET_VEHICLE_NUMBER_PLATE_TEXT(k), true)
                    for i = 0, 20
				    do
				        if VEHICLE.DOES_EXTRA_EXIST(k, i) == 1 then
				        	ui.set_value(parent["extra_"..i], VEHICLE.IS_VEHICLE_EXTRA_TURNED_ON(k, i) == 1, true)
				        end
				    end
				    ui.set_value(parent.window_tint, VEHICLE.GET_VEHICLE_WINDOW_TINT(k), true)
				    local xenon_color = VEHICLE._GET_VEHICLE_XENON_LIGHTS_COLOR(k)
				    ui.set_value(parent.xenon_color, xenon_color == 255 and 0 or xenon_color + 1, true)
				    local interior, dashboard = s_memory.alloc_get(2)
				    VEHICLE._GET_VEHICLE_INTERIOR_COLOR(k, interior)
				    ui.set_value(parent.interior_color, memory.read_int(interior), true)
				    VEHICLE._GET_VEHICLE_DASHBOARD_COLOR(k, dashboard)
				    ui.set_value(parent.dashboard_color, memory.read_int(dashboard), true)
				    for i = 0, 3
				    do
				    	ui.set_value(parent["neon_"..i], VEHICLE._IS_VEHICLE_NEON_LIGHT_ENABLED(k, i) == 1, true)		    	
				    end
				    VEHICLE._GET_VEHICLE_NEON_LIGHTS_COLOUR(k, r, g, b)
				    ui.set_value(parent.neon_rgb, memory.read_int(r), memory.read_int(g), memory.read_int(b), 255, true)
				    VEHICLE.GET_VEHICLE_TYRE_SMOKE_COLOR(k, r, g, b)
				    ui.set_value(parent.tyre_smoke_color, memory.read_int(r), memory.read_int(g), memory.read_int(b), 255, true)
				    ui.set_value(parent.torque_mult, vehicles.get_torque_mult(k), true)
					ui.set_value(parent.rpm_mult, vehicles.get_rpm_mult(k), true)
				elseif v.type == 2 and ui.is_sub_open(parent.wheel_sub) then
					ui.set_value(parent.bulletproof_tires, VEHICLE.GET_VEHICLE_TYRES_CAN_BURST(k) == 0, true)
					ui.set_value(parent.drift_tires, VEHICLE._GET_DRIFT_TYRES_ENABLED(k) == 1, true)
                    ui.set_value(parent.tyre_smoke, VEHICLE.IS_TOGGLE_MOD_ON(k, 20) == 1, true)
					local pearl, wheel = s_memory.alloc_get(2)
	            	VEHICLE.GET_VEHICLE_EXTRA_COLOURS(k, pearl, wheel)
					ui.set_num_max(parent.wheels, VEHICLE.GET_NUM_VEHICLE_MODS(k, 23))
				    ui.set_value(parent.custom_wheels, VEHICLE.GET_VEHICLE_MOD_VARIATION(k, 23) == 1 or VEHICLE.GET_VEHICLE_MOD_VARIATION(k, 24) == 1, true)
				    if VEHICLE.IS_THIS_MODEL_A_BIKE(ENTITY.GET_ENTITY_MODEL(k)) == 1 then
				    	ui.set_value(parent.wheels_front, VEHICLE.GET_VEHICLE_MOD(k, 23), true)
				    	ui.set_value(parent.wheels_back, VEHICLE.GET_VEHICLE_MOD(k, 24) + 1, true)
				    else
				    	local wheel_type = VEHICLE.GET_VEHICLE_WHEEL_TYPE(k)
	               		ui.set_value(parent.wheel_type, wheel_type < 6 and wheel_type or wheel_type - 1, true)
				    	ui.set_value(parent.wheels, VEHICLE.GET_VEHICLE_MOD(k, 23) + 1, true)
				    end
				    ui.set_value(parent.wheel_color, memory.read_int(wheel), true)
				elseif v.type == 2 and ui.is_sub_open(parent.sub_veh_prop) then
					ui.set_value(parent.light_mult, vehicles.get_lights_intensity(k), true)
				    ui.set_value(parent.paint_fade, VEHICLE.GET_VEHICLE_ENVEFF_SCALE(k), true)
				    ui.set_value(parent.dirt_level, VEHICLE.GET_VEHICLE_DIRT_LEVEL(k), true)
				    ui.set_value(parent.engine_on, VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(k) == 1, true)
				   	ui.set_value(parent.lock_vehicle, VEHICLE.GET_VEHICLE_DOOR_LOCK_STATUS(k) == 2, true)
				   	ui.set_value(parent.child_locks, VEHICLE.GET_VEHICLE_DOOR_LOCK_STATUS(k) == 4, true)
				    ui.set_value(parent.siren, VEHICLE.IS_VEHICLE_SIREN_ON(k) == 1, true)
					ui.set_value(parent.reduce_grip, vehicles.has_reduced_grip(k), true)
					ui.set_value(parent.render_scorched, features.is_render_scorched(k), true)
				elseif v.type == 1 and ui.is_sub_open(parent.sub_ped_prop) then
					ui.set_value(parent.block_flee, v.noflee, true)
					ui.set_value(parent.can_ragdoll, PED.CAN_PED_RAGDOLL(k) == 1, true)
					ui.set_value(parent.is_tiny, PED.GET_PED_CONFIG_FLAG(k, 223, false) == 1, true)
					ui.set_value(parent.ped_health, ENTITY.GET_ENTITY_HEALTH(k), true)
					ui.set_value(parent.ped_armor, PED.GET_PED_ARMOUR(k), true)
				elseif v.type == 1 and ui.is_sub_open(parent.wardobe_sub) then
					local component_id = EntityDb.entity_data[k].drawables[ui.get_value(parent.component_choose)+1]
					ui.set_value(parent.component_id, PED.GET_PED_DRAWABLE_VARIATION(k, component_id), true)
					ui.set_value(parent.texture_id, PED.GET_PED_TEXTURE_VARIATION(k, component_id), true)
					ui.set_num_max(parent.texture_id, PED.GET_NUMBER_OF_PED_TEXTURE_VARIATIONS(k, component_id, PED.GET_PED_DRAWABLE_VARIATION(k, component_id))-1)
					local prop_id = EntityDb.entity_data[k].props[ui.get_value(parent.prop_choose)+1]
					ui.set_value(parent.prop_id, PED.GET_PED_PROP_INDEX(k, prop_id), true)
					ui.set_value(parent.proptexture_id, PED.GET_PED_PROP_TEXTURE_INDEX(k, prop_id), true)
					ui.set_num_max(parent.proptexture_id, PED.GET_NUMBER_OF_PED_PROP_TEXTURE_VARIATIONS(k, prop_id, PED.GET_PED_PROP_INDEX(k, prop_id))-1)
				elseif ui.is_sub_open(parent.sub_attached) then
					local num = ENTITY._GET_ENTITY_BONE_COUNT(ENTITY.GET_ENTITY_ATTACHED_TO(k))
					ui.set_num_max(parent.attach_bone, num < 0 and 0 or num)
				end
			end
		end
	end, true)
end

__submenus["BlockAreas"] = ui.add_submenu(TRANSLATION["Block areas"])
__suboptions["BlockAreas"] = ui.add_sub_option(TRANSLATION["Block areas"], __submenus["World"] , __submenus["BlockAreas"])

ui.add_click_option(TRANSLATION["Block Orbital Room"], __submenus["BlockAreas"], function() 
	if utils.show_info("blockorbital") then return end
	utils.hud_sound("SELECT")
    utils.block_area(-1003748966, 328.337, 4828.734, -58.553, 0.0, 90.0, 0.0, true) 
end, {"blockorbital"})

ui.add_click_option(TRANSLATION["Block all LSC"], __submenus["BlockAreas"], function()
	if utils.show_info("blocklsc") then return end
	utils.hud_sound("SELECT")
    utils.block_area(-1003748966, -1145.897, -1991.144, 14.1836, 0.0, 90.0, 0.0, true)
    utils.block_area(-1003748966, 723.1160, -1088.831, 23.2320, 0.0, 90.0, 0.0, true)
    utils.block_area(-1003748966, -356.0905, -134.7714, 40.0130, 0.0, 90.0, 0.0, true)
    utils.block_area(-1003748966, 1174.6543, 2645.2222, 38.6396, 0.0, 90.0, 0.0, true)
    utils.block_area(-1003748966, 1182.3055, 2645.2324, 38.6396, 0.0, 90.0, 0.0, true)
    utils.block_area(-1003748966, 114.3135, 6623.2334, 32.6731, 0.0, 90.0, 0.0, true)
    utils.block_area(-1003748966, 108.8502, 6617.8770, 32.6731, 0.0, 90.0, 0.0, true)
    utils.block_area(-1003748966, -205.6828, -1310.682, 30.2957, 0.0, 90.0, 0.0, true)
end, {"blocklsc"})

ui.add_click_option(TRANSLATION["Block all Ammu-Nation"], __submenus["BlockAreas"], function()
	if utils.show_info("blockgunstore") then return end
	utils.hud_sound("SELECT")
    utils.block_area(-1003748966, 1699.9373, 3753.4202, 34.8553, 0.0, 90.0, 0.0, true)
    utils.block_area(-1003748966, 243.8379, -46.5232, 70.0910, 0.0, 90.0, 0.0, true)
    utils.block_area(-1003748966, 842.7685, -1024.539, 28.3448, 0.0, 90.0, 0.0, true)
    utils.block_area(-1003748966, -324.2730, 6077.1094, 31.6047, 0.0, 90.0, 0.0, true)
    utils.block_area(-1003748966, -662.6415, -944.3256, 21.9792, 0.0, 90.0, 0.0, true)
    utils.block_area(-1003748966, -1314.465, -391.6472, 36.8457, 0.0, 90.0, 0.0, true)
    utils.block_area(-1003748966, -1120.070, 2691.5046, 18.7041, 0.0, 90.0, 0.0, true)
    utils.block_area(-1003748966, -3163.811, 1083.7786, 20.9887, 0.0, 90.0, 0.0, true)
    utils.block_area(-1003748966, 2568.3037, 303.3556, 108.8848, 0.0, 90.0, 0.0, true)
    utils.block_area(-1003748966, 17.729, -1114.047, 29.809, 0.0, 90.0, 0.0, true)
    utils.block_area(-1003748966, 811.496, -2149.082, 29.631, 0.0, 90.0, 0.0, true)
end, {"blockgunstore"})

ui.add_click_option(TRANSLATION["Block Casino"], __submenus["BlockAreas"], function()
	if utils.show_info("blockcasino") then return end
	utils.hud_sound("SELECT")
    utils.block_area(-1003748966, 924.796, 46.537, 82.332, 0.0, 90.0, 0.0, true)
    utils.block_area(-1003748966, 936.130, 0.807, 79.608, 0.0, 90.0, 0.0, true)
    utils.block_area(-1003748966, 987.713, 80.519, 81.877, 0.0, 90.0, 0.0, true)
    utils.block_area(-1003748966, 966.303, 61.289, 112.845, 0.0, 90.0, 0.0, true)
end, {"blockcasino"})

ui.add_click_option(TRANSLATION["Block Eclipse Towers"], __submenus["BlockAreas"], function()
	if utils.show_info("blockeclipse") then return end
	utils.hud_sound("SELECT")
    utils.block_area(-1003748966, -773.986, 313.359, 85.677, 0.0, 90.0, 0.0, true)
    utils.block_area(-1003748966, -796.079, 308.323, 85.677, 0.0, 90.0, 0.0, true)
    utils.block_area(-1003748966, -796.079, 308.323, 87.677, 0.0, 90.0, 0.0, true)
end, {"blockeclipse"})

ui.add_click_option(TRANSLATION["Windmill main LSC"], __submenus["BlockAreas"], function()
	if utils.show_info("windmilllsc") then return end
	utils.hud_sound("SELECT")
    utils.block_area(1952396163, -405.3579, -142.0034, 36.3176, -90.0, 60.0, 0.0, false)
end, {"windmilllsc"})

ui.add_click_option(TRANSLATION["Garage fucker"], __submenus["BlockAreas"], function()
	if utils.show_info("windmillgarages") then return end
	utils.hud_sound("SELECT")
    utils.block_area(1952396163, 228.3203, -1031.5253, -96.3672, 90.0, -180, 0.0, false)
    utils.block_area(1952396163, 228.3203, -1031.5253, -101.3671, -90.0, 0.0, 0.0, false)
end, {"windmillgarages"})

ui.add_click_option(TRANSLATION["Block Strip Club"], __submenus["BlockAreas"], function()
	if utils.show_info("blockstripclub") then return end
	utils.hud_sound("SELECT")
    utils.block_area(-1003748966, 127.9552, -1298.503, 29.4196, 0.0, 90.0, 0.0, true)
end, {"blockstripclub"})

ui.add_separator(TRANSLATION['Delete'], __submenus["BlockAreas"])

ui.add_click_option(TRANSLATION["Delete all blocking objects"], __submenus["BlockAreas"], function()
	if utils.show_info("deleteblocks") then return end
	utils.hud_sound("SELECT")
	for _, v in ipairs(Global.blockobjects) do
		features.delete_entity(v)
	end
	Global.blockobjects = {}
end, {"deleteblocks"})

__submenus["ClearArea"] = ui.add_submenu(TRANSLATION["Clear area"])
__suboptions["ClearArea"] = ui.add_sub_option(TRANSLATION["Clear area"], __submenus["World"] , __submenus["ClearArea"])

__options.click["ClearArea"] = ui.add_click_option(TRANSLATION["Clear area"], __submenus["ClearArea"], function()
	if utils.show_info("cleararea") then return end
	if ui.get_value(__options.num["ClearAreaDistance"]) > 100 then settings.World["ClearAreaDistance"] = 100; ui.set_value(__options.num["ClearAreaDistance"], 100, true) end
	if system.is_thread_active('world_clear_area') then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	local veh1, veh2 = vehicles.get_player_vehicle(), vehicles.get_personal_vehicle()
	local entit = {}
	local dist = settings.World["ClearAreaDistance"] * settings.World["ClearAreaDistance"]
	local pos = features.get_player_coords()
	local _ents = {
		{settings.World["ClearAreaPeds"], entities.get_peds},
		{settings.World["ClearAreaVehicles"], entities.get_vehs},
		{settings.World["ClearAreaProps"], entities.get_objects},
		{settings.World["ClearAreaPickups"], entities.get_pickups}
	}
	local function InsertEntities(ents)
		for _, v in ipairs(ents)
		do
			if v ~= veh1 and v ~= veh2 and PED.IS_PED_A_PLAYER(v) == 0 and not (settings.World["ClearAreaIgnoreMission"] and ENTITY.IS_ENTITY_A_MISSION_ENTITY(v) == 1) and pos:sqrlen(features.get_entity_coords(v)) <= dist then
				insert(entit, v)
			end
		end
	end
	for _, e in ipairs(_ents)
	do
		if e[1] then
			InsertEntities(e[2]())
		end
	end
	system.thread(true, 'world_clear_area', function(tick)
		local i = tick + 1
		features.delete_entity(entit[i])
		if i < #entit then return end
		system.notify(TRANSLATION["Imagined Menu"], TRANSLATION['Clear area finished'], settings.General["HudColorNotifySuccess"])
		return POP_THREAD
	end)
end, {"cleararea"})

__options.bool["ClearAreaPeds"] = ui.add_bool_option(TRANSLATION["Peds"], __submenus["ClearArea"], function(bool)
	if utils.show_info("clareapeds [on - off]") then ui.set_value(__options.bool["ClearAreaPeds"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.World["ClearAreaPeds"] = bool
end, {"clareapeds"})
__options.bool["ClearAreaVehicles"] = ui.add_bool_option(TRANSLATION["Vehicles"], __submenus["ClearArea"], function(bool)
	if utils.show_info("clareavehs [on - off]") then ui.set_value(__options.bool["ClearAreaVehicles"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.World["ClearAreaVehicles"] = bool
end, {"clareavehs"})
__options.bool["ClearAreaProps"] = ui.add_bool_option(TRANSLATION["Props"], __submenus["ClearArea"], function(bool)
	if utils.show_info("clareaprop [on - off]") then ui.set_value(__options.bool["ClearAreaProps"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.World["ClearAreaProps"] = bool
end, {"clareaprop"})
__options.bool["ClearAreaPickups"] = ui.add_bool_option(TRANSLATION["Pickups"], __submenus["ClearArea"], function(bool)
	if utils.show_info("clareapickups [on - off]") then ui.set_value(__options.bool["ClearAreaPickups"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.World["ClearAreaPickups"] = bool
end, {"clareapickups"})

__options.bool["ClearAreaIgnoreMission"] = ui.add_bool_option(TRANSLATION["Ignore mission entities"], __submenus["ClearArea"], function(bool)
	if utils.show_info("clareaignore [on - off]") then ui.set_value(__options.bool["ClearAreaIgnoreMission"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.World["ClearAreaIgnoreMission"] = bool
end, {"clareaignore"})

__options.num["ClearAreaDistance"] = ui.add_num_option(TRANSLATION["Distance"], __submenus["ClearArea"], 0, 100, 10, function(int)
	if utils.show_info("clearareadist [0 - 100]") then ui.set_value(__options.num["ClearAreaDistance"], settings.World["ClearAreaDistance"], true) return end
	utils.hud_sound("YES") settings.World["ClearAreaDistance"] = int
end, {"clearareadist"})

system.thread(true, 'clear_area_prev', function()
	if not ui.is_sub_open(__submenus["ClearArea"]) then return end
	local color = settings.General["HudColorClearArea"]
	local pos = features.get_player_coords()
	GRAPHICS._DRAW_SPHERE(pos.x, pos.y, pos.z, settings.World["ClearAreaDistance"], color.r, color.g, color.b, color.a/255)
end)

__submenus["BlackHole"] = ui.add_submenu(TRANSLATION["Black hole"])
__suboptions["BlackHole"] = ui.add_sub_option(TRANSLATION["Black hole"], __submenus["World"] , __submenus["BlackHole"])

do
	local blackhole_pos = vector3.zero()
	local blackhole_dist = 1000
	local on_vehs
	local on_peds
	local force_types = {TRANSLATION['Low'], TRANSLATION['Medium'], TRANSLATION['High']}
	local force = {
		[0] = 10,
		50,
		1000,
	}
	local blackhole_force = force[1]

	__options.bool["BlackHoleOnVehicles"] = ui.add_bool_option(TRANSLATION['On vehicles'], __submenus["BlackHole"], function(bool)
		if utils.show_info("blholevehs [on - off]") then ui.set_value(__options.bool["BlackHoleOnVehicles"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") on_vehs = bool
		settings.World["BlackHoleOnVehicles"] = bool
	end, {"blholevehs"})
	__options.bool["BlackHoleOnPeds"] = ui.add_bool_option(TRANSLATION['On peds'], __submenus["BlackHole"], function(bool)
		if utils.show_info("blholepeds [on - off]") then ui.set_value(__options.bool["BlackHoleOnPeds"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") on_peds = bool
		settings.World["BlackHoleOnPeds"] = bool
	end, {"blholepeds"})

	__options.choose["BlackHoleForce"] = ui.add_choose(TRANSLATION['Force'], __submenus["BlackHole"], true, force_types, function(int)
		if utils.show_info("blholeforce [choose]") then ui.set_value(__options.choose["BlackHoleForce"], settings.World["BlackHoleForce"], true) return end
		blackhole_force = force[int]
		utils.hud_sound("YES")
		settings.World["BlackHoleForce"] = int
	end, {"blholeforce"})

	ui.add_click_option(TRANSLATION['Bring to self'], __submenus["BlackHole"], function()
		if utils.show_info("blholeself") then return end
		utils.hud_sound("SELECT") blackhole_pos = features.get_player_coords() + vector3.up(10)
	end, {"blholeself"})

	__options.bool['AttackBlHole'] = ui.add_bool_option(TRANSLATION['Attach to self'], __submenus["BlackHole"], function(bool)
		if utils.show_info("blholeattach [on - off]") then ui.set_value(__options.bool["AttackBlHole"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON")
		system.thread(bool, 'world_attach_blackhole', function()
			blackhole_pos = features.get_player_coords()
		end)
	end, {"blholeattach"})
	local x
	local y
	local z
	x = ui.add_float_option('X', __submenus["BlackHole"], -10000, 10000, 10, 3, function(float)
		if utils.show_info("blholex [-10000.0 - 10000.0]") then ui.set_value(x, blackhole_pos.x, true) return end
		utils.hud_sound("YES") blackhole_pos.x = float
	end, {"blholex"})
	y = ui.add_float_option('Y', __submenus["BlackHole"], -10000, 10000, 10, 3, function(float)
		if utils.show_info("blholey [-10000.0 - 10000.0]") then ui.set_value(y, blackhole_pos.y, true) return end
		utils.hud_sound("YES") blackhole_pos.y = float
	end, {"blholey"})
	z = ui.add_float_option('Z', __submenus["BlackHole"], -10000, 10000, 10, 3, function(float)
		if utils.show_info("blholez [-10000.0 - 10000.0]") then ui.set_value(z, blackhole_pos.z, true) return end
		utils.hud_sound("YES") blackhole_pos.z = float
	end, {"blholez"})

	__options.num["BlackHoleDistance"] = ui.add_num_option(TRANSLATION['Distance'], __submenus["BlackHole"], 0, 100000, 10, function(int)
		if utils.show_info("blholedist [0 - 100000]") then ui.set_value(__options.num["BlackHoleDistance"], settings.World["BlackHoleDistance"], true) return end
		utils.hud_sound("YES") blackhole_dist = int
		settings.World["BlackHoleDistance"] = int
	end, {"blholedist"})

	system.thread(true, 'world_black_hole_position', function(tick)
		if not ui.is_sub_open( __submenus["BlackHole"]) then return end
		ui.set_value(x, blackhole_pos.x, true)
		ui.set_value(y, blackhole_pos.y, true)
		ui.set_value(z, blackhole_pos.z, true)
	end)

	__options.bool['BlackHoleSuckIn'] = ui.add_bool_option(TRANSLATION['Suck in'], __submenus["BlackHole"], function(bool)
		if utils.show_info("blholesuck [on - off]") then ui.set_value(__options.bool["BlackHoleSuckIn"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") settings.World["BlackHoleSuckIn"] = bool
	end, {"blholesuck"})
	__options.bool['ShowBlackHole'] = ui.add_bool_option(TRANSLATION['Show blackhole'], __submenus["BlackHole"], function(bool)
		if utils.show_info("showblhole [on - off]") then ui.set_value(__options.bool["ShowBlackHole"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") settings.World["ShowBlackHole"] = bool
	end, {"showblhole"})

	__options.bool['BlackHole'] = ui.add_bool_option(TRANSLATION['Enable blackhole'], __submenus["BlackHole"], function(bool)
		if utils.show_info("blhole [on - off]") then ui.set_value(__options.bool["BlackHole"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON")
		system.thread(bool, 'world_black_hole', function()
			local veh1, veh2 = vehicles.get_player_vehicle(), vehicles.get_personal_vehicle()
			if settings.World["ShowBlackHole"] then
				GRAPHICS._DRAW_SPHERE(blackhole_pos.x, blackhole_pos.y, blackhole_pos.z, 6, 0, 0, 0, 1)
			end
			for _, v in ipairs(features.get_entities(true))
			do
				if ((ENTITY.IS_ENTITY_A_PED(v) == 1 and on_peds) or (ENTITY.IS_ENTITY_A_VEHICLE(v) == 1 and on_vehs)) and PED.IS_PED_A_PLAYER(v) == 0 then
					local pos = features.get_entity_coords(v)
					local distance = pos:sqrlen(blackhole_pos)
					if distance <= blackhole_dist * blackhole_dist then
						if not (features.compare(v, veh1, veh2) and ENTITY.IS_ENTITY_A_VEHICLE(v) == 1) then
							features.request_control_once(v)
							if distance > 36 then
								if ENTITY.IS_ENTITY_A_PED(v) == 1 and PED.IS_PED_A_PLAYER(v) == 0 then
									PED.SET_PED_CAN_RAGDOLL(v, true)
									PED.SET_PED_TO_RAGDOLL(v, 5000, 5000, 0, true, true, false)
								end
								pos = features.get_entity_coords(v)
								local dir = pos:direction_to(blackhole_pos) * blackhole_force
								ENTITY.FREEZE_ENTITY_POSITION(v, false)
								features.set_entity_velocity(v, dir.x, dir.y, dir.z)
							else
								ENTITY.FREEZE_ENTITY_POSITION(v, true)
								if settings.World["BlackHoleSuckIn"] then
									features.delete_entity(v)
								end
							end
						end
					end
				end
			end
		end)
		if not bool then
			local veh1, veh2 = vehicles.get_player_vehicle(), vehicles.get_personal_vehicle()
			for _, v in ipairs(features.get_entities())
			do
				local pos = features.get_entity_coords(v)
				local distance = pos:sqrlen(blackhole_pos)
				if (distance <= blackhole_dist * blackhole_dist) and (ENTITY.IS_ENTITY_A_VEHICLE(v) == 1 and v ~= veh1 and v ~= veh2 and v ~= features.player_ped()) then
					features.request_control_once(v)
					if distance <= 100 then
						ENTITY.FREEZE_ENTITY_POSITION(v, false)
						local pos = features.get_entity_coords(v)
						local dir = blackhole_pos:direction_to(pos) * 100
						features.set_entity_velocity(v, dir.x, dir.y, dir.z)
					end
				end
			end
		end
	end, {"blhole"})
end

__submenus["Peds"] = ui.add_submenu(TRANSLATION["Peds"])
__suboptions["Peds"] = ui.add_sub_option(TRANSLATION["Peds"], __submenus["World"] , __submenus["Peds"])

__options.num["WorldPedsRadius"] = ui.add_num_option(TRANSLATION["Radius"], __submenus["Peds"], 0, 10000, 50, function(int)
	if utils.show_info("pedsrad [0 - 10000]") then ui.set_value(__options.num["WorldPedsRadius"], settings.World["WorldPedsRadius"], true) end
	settings.World["WorldPedsRadius"] = int
	utils.hud_sound("YES")
end, {"pedsrad"})

ui.add_click_option(TRANSLATION["Resurrect peds"], __submenus["Peds"], function()
	if utils.show_info("revivepeds") then return end
	utils.hud_sound("SELECT")
	for _, v in ipairs(entities.get_peds())
	do
		if ENTITY.IS_ENTITY_DEAD(v, false) == 1 and v ~= features.player_ped() and PED.IS_PED_A_PLAYER(v) == 0 and features.get_entity_coords(v):sqrlen(features.get_player_coords()) <= settings.World["WorldPedsRadius"] * settings.World["WorldPedsRadius"] then
			peds.revive(v)
		end
	end
end, {"revivepeds"})

ui.add_click_option(TRANSLATION["Explode peds"], __submenus["Peds"], function()
	if utils.show_info("explodepeds") then return end
	utils.hud_sound("SELECT")
	for _, v in ipairs(entities.get_peds())
	do
		if ENTITY.IS_ENTITY_DEAD(v, false) == 0 and v ~= features.player_ped() and PED.IS_PED_A_PLAYER(v) == 0 and features.get_entity_coords(v):sqrlen(features.get_player_coords()) <= settings.World["WorldPedsRadius"] * settings.World["WorldPedsRadius"] then
			local pos = features.get_entity_coords(v)
			FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, enum.explosion.ROCKET, 10, true, false, 1.0, false)
		end
	end
end, {"explodepeds"})

ui.add_click_option(TRANSLATION["Kill enemy peds"], __submenus["Peds"], function()
	if utils.show_info("killenemies") then return end
	utils.hud_sound("SELECT")
	for _, v in ipairs(entities.get_peds())
	do
		if ENTITY.IS_ENTITY_DEAD(v, false) == 0 and v ~= features.player_ped() and PED.IS_PED_A_PLAYER(v) == 0 and peds.is_ped_an_enemy(v) and features.get_entity_coords(v):sqrlen(features.get_player_coords()) <= settings.World["WorldPedsRadius"] * settings.World["WorldPedsRadius"] then
			entities.request_control(v, function()
				ENTITY.SET_ENTITY_HEALTH(v, 0, 0)
			end)
		end
	end
end, {"killenemies"})

ui.add_click_option(TRANSLATION["Kill peds"], __submenus["Peds"], function()
	if utils.show_info("killpeds") then return end
	utils.hud_sound("SELECT")
	for _, v in ipairs(entities.get_peds())
	do
		if ENTITY.IS_ENTITY_DEAD(v, false) == 0 and v ~= features.player_ped() and PED.IS_PED_A_PLAYER(v) == 0 and features.get_entity_coords(v):sqrlen(features.get_player_coords()) <= settings.World["WorldPedsRadius"] * settings.World["WorldPedsRadius"] then
			entities.request_control(v, function()
				ENTITY.SET_ENTITY_HEALTH(v, 0, 0)
			end)
		end
	end
end, {"killpeds"})

__options.bool["FreezePeds"] = ui.add_bool_option(TRANSLATION["Freeze peds"], __submenus["Peds"], function(bool) utils.hud_sound("TOGGLE_ON")
	if utils.show_info("freezepeds [on - off]") then ui.set_value(__options.bool["FreezePeds"], not bool, true) return end
	system.thread(bool, 'freeze_peds', function()
		for _, v in ipairs(entities.get_peds())
		do
			if v ~= features.player_ped() and PED.IS_PED_A_PLAYER(v) == 0 and features.get_entity_coords(v):sqrlen(features.get_player_coords()) <= settings.World["WorldPedsRadius"] * settings.World["WorldPedsRadius"] then
				TASK.CLEAR_PED_TASKS_IMMEDIATELY(v)
			end
		end
	end)
end, {"freezepeds"})

__submenus["Vehicles"] = ui.add_submenu(TRANSLATION["Vehicles"])
__suboptions["Vehicles"] = ui.add_sub_option(TRANSLATION["Vehicles"], __submenus["World"] , __submenus["Vehicles"])

__options.num["WorldVehiclesRadius"] = ui.add_num_option(TRANSLATION["Radius"], __submenus["Vehicles"], 0, 10000, 50, function(int)
	if utils.show_info("vehiclesrad [0 - 10000]") then ui.set_value(__options.num["WorldVehiclesRadius"], settings.World["WorldVehiclesRadius"], true) end
	settings.World["WorldVehiclesRadius"] = int
	utils.hud_sound("YES")
end, {"vehiclesrad"})

ui.add_click_option(TRANSLATION["Repair vehicles"], __submenus["Vehicles"], function()
	if utils.show_info("fixvehs") then return end
	utils.hud_sound("SELECT")
	local veh1, veh2 = vehicles.get_player_vehicle(), vehicles.get_personal_vehicle()
	for _, v in ipairs(entities.get_vehs())
	do
		if v ~= veh1 and v ~= veh2 then
			entities.request_control(v, function()
				vehicles.repair(v)
			end)
		end
	end
end, {"fixvehs"})

ui.add_click_option(TRANSLATION["Boost vehicles"], __submenus["Vehicles"], function()
	if utils.show_info("boostvehs") then return end
	utils.hud_sound("SELECT")
	local veh1, veh2 = vehicles.get_player_vehicle(), vehicles.get_personal_vehicle()
	for _, v in ipairs(entities.get_vehs())
	do
		if v ~= veh1 and v ~= veh2 and features.get_entity_coords(v):sqrlen(features.get_player_coords()) <= settings.World["WorldVehiclesRadius"] * settings.World["WorldVehiclesRadius"] then
			entities.request_control(v, function()
				VEHICLE.SET_VEHICLE_FORWARD_SPEED(v, 200)
			end)
		end
	end
end, {"boostvehs"})

ui.add_click_option(TRANSLATION["Pop tires"], __submenus["Vehicles"], function()
	if utils.show_info("popvehstires") then return end
	utils.hud_sound("SELECT")
	local veh1, veh2 = vehicles.get_player_vehicle(), vehicles.get_personal_vehicle()
	for _, v in ipairs(entities.get_vehs())
	do
		if v ~= veh1 and v ~= veh2 and features.get_entity_coords(v):sqrlen(features.get_player_coords()) <= settings.World["WorldVehiclesRadius"] * settings.World["WorldVehiclesRadius"] then
			entities.request_control(v, function()
				vehicles.set_godmode(v, false)
				for i = 0, 5 do
		     		VEHICLE.SET_VEHICLE_TYRE_BURST(v, i, true, 1000.0)
		    	end
			end)
		end
	end
end, {"popvehstires"})

ui.add_click_option(TRANSLATION["Lock vehicles"], __submenus["Vehicles"], function()
	if utils.show_info("lockvehicles") then return end
	utils.hud_sound("SELECT")
	local veh1, veh2 = vehicles.get_player_vehicle(), vehicles.get_personal_vehicle()
	for _, v in ipairs(entities.get_vehs())
	do
		if v ~= veh1 and v ~= veh2 and features.get_entity_coords(v):sqrlen(features.get_player_coords()) <= settings.World["WorldVehiclesRadius"] * settings.World["WorldVehiclesRadius"] then
			entities.request_control(v, function()
				VEHICLE.SET_VEHICLE_DOORS_LOCKED(v, 6)
				VEHICLE.SET_VEHICLE_DOORS_LOCKED(v, 2)
			end)
		end
	end
end, {"lockvehicles"})

ui.add_click_option(TRANSLATION["Unlock vehicles"], __submenus["Vehicles"], function()
	if utils.show_info("unlockvehicles") then return end
	utils.hud_sound("SELECT")
	local veh1, veh2 = vehicles.get_player_vehicle(), vehicles.get_personal_vehicle()
	for _, v in ipairs(entities.get_vehs())
	do
		if v ~= veh1 and v ~= veh2 and features.get_entity_coords(v):sqrlen(features.get_player_coords()) <= settings.World["WorldVehiclesRadius"] * settings.World["WorldVehiclesRadius"] then
			entities.request_control(v, function()
				VEHICLE.SET_VEHICLE_DOORS_LOCKED(v, 1)
			end)
		end
	end
end, {"unlockvehicles"})

ui.add_color_picker(TRANSLATION["Paint vehicles"], __submenus["Vehicles"], function(color)
	color = features.fix_color(color)
	local veh1, veh2 = vehicles.get_player_vehicle(), vehicles.get_personal_vehicle()
	for _, v in ipairs(entities.get_vehs())
	do
		if v ~= veh1 and v ~= veh2 and features.get_entity_coords(v):sqrlen(features.get_player_coords()) <= settings.World["WorldVehiclesRadius"] * settings.World["WorldVehiclesRadius"] then
			entities.request_control(v, function()
				VEHICLE.SET_VEHICLE_MOD_KIT(v, 0)
				VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(v, color.r, color.g, color.b)
				VEHICLE._SET_VEHICLE_NEON_LIGHTS_COLOUR(v, color.r, color.g, color.b)
				VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(v, color.r, color.g, color.b)
				VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(v, color.r, color.g, color.b)
			end)
		end
	end
end)

__options.bool['Beyblades'] = ui.add_bool_option(TRANSLATION["Beyblades"], __submenus["Vehicles"], function(bool)
	if utils.show_info("beyblades [on - off]") then ui.set_value(__options.bool["Beyblades"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	system.thread(bool, 'world_beyblades', function()
		local veh1, veh2 = vehicles.get_player_vehicle(), vehicles.get_personal_vehicle()
		for _, v in ipairs(entities.get_vehs())
		do
			if v ~= veh1 and v ~= veh2 and features.get_entity_coords(v):sqrlen(features.get_player_coords()) <= settings.World["WorldVehiclesRadius"] * settings.World["WorldVehiclesRadius"] then
				features.request_control_once(v)
				VEHICLE.SET_VEHICLE_REDUCE_GRIP(v, true)
				features.apply_force_to_entity(v, 1, 1, 0, 0, 100, 100, 0, 0, true, true, true, false, true)
			end
		end
	end)
	if not bool then
		local veh1, veh2 = vehicles.get_player_vehicle(), vehicles.get_personal_vehicle()
		for _, v in ipairs(entities.get_vehs())
		do
			if v ~= veh1 and v ~= veh2 then
				entities.request_control(v, function()
					VEHICLE.SET_VEHICLE_REDUCE_GRIP(v, false)
				end)
			end
		end
	end
end, {"beyblades"})

do
	local ApplyForce = switch()
		:case(1, function(veh)
			features.apply_force_to_entity(veh, 1, 0, 0, 1, 3, 0, 0, 0, true, true, true, false, true)
		end)
		:case(2, function(veh)
			features.apply_force_to_entity(veh, 1, 0, 0, 1, -3, 0, 0, 0, true, true, true, false, true)
		end)
		:case(3, function(veh)
			features.apply_force_to_entity(veh, 1, 0, 0, 1, 0, -7, 0, 0, true, true, true, false, true)
		end)
		:case(4, function(veh)
			features.apply_force_to_entity(veh, 1, 0, 0, 1, 0, 7, 0, 0, true, true, true, false, true)
		end)
		:case(5, function(veh)
			features.apply_force_to_entity(veh, 1, 0, 0, 5, 0, 0, 0, 0, true, true, true, false, true)
		end)

	__options.bool['JumpyVehicles'] = ui.add_bool_option(TRANSLATION["Jumpy vehicles"], __submenus["Vehicles"], function(bool)
		if utils.show_info("jumpyvehs [on - off]") then ui.set_value(__options.bool["JumpyVehicles"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON")
		system.thread(bool, 'world_jumpy_vehicles', function(tick)
			if tick%100 ~= 0 then return end
			local veh1, veh2 = vehicles.get_player_vehicle(), vehicles.get_personal_vehicle()
			for _, v in ipairs(entities.get_vehs())
			do
				if ENTITY.IS_ENTITY_IN_AIR(v) == 0 and v ~= veh1 and v ~= veh2 and features.get_entity_coords(v):sqrlen(features.get_player_coords()) <= settings.World["WorldVehiclesRadius"] * settings.World["WorldVehiclesRadius"] then
					features.request_control_once(v)
					ApplyForce(random(1, 5), v)
				end
			end
		end)
	end, {"jumpyvehs"})
end

__options.bool['VehiclesExplodeOnImpact'] = ui.add_bool_option(TRANSLATION["Vehicles explode on impact"], __submenus["Vehicles"], function(bool)
	if utils.show_info("eplodeonimpact [on - off]") then ui.set_value(__options.bool["VehiclesExplodeOnImpact"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	system.thread(bool, 'vehicles_explode_on_impact', function(tick)
		local veh1, veh2 = vehicles.get_player_vehicle(), vehicles.get_personal_vehicle()
		for _, v in ipairs(entities.get_vehs())
		do
			if v ~= veh1 and v ~= veh2 and ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(v) ~= 0 and features.get_entity_coords(v):sqrlen(features.get_player_coords()) <= settings.World["WorldVehiclesRadius"] * settings.World["WorldVehiclesRadius"] then
				entities.request_control(v, function()
					vehicles.set_godmode(v, false)
					NETWORK.NETWORK_EXPLODE_VEHICLE(v, true, false, PLAYER.PLAYER_ID())
				end)
			end
		end
	end, {"eplodeonimpact"})
end)

__options.bool['LaunchVehicles'] = ui.add_bool_option(TRANSLATION["Launch vehicles"], __submenus["Vehicles"], function(bool)
	if utils.show_info("launchvehs [on - off]") then ui.set_value(__options.bool["LaunchVehicles"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	system.thread(bool, 'world_launch_vehicles', function(tick)
		local veh1, veh2 = vehicles.get_player_vehicle(), vehicles.get_personal_vehicle()
		for _, v in ipairs(entities.get_vehs())
		do
			if v ~= veh1 and v ~= veh2 and features.get_entity_coords(v):sqrlen(features.get_player_coords()) <= settings.World["WorldVehiclesRadius"] * settings.World["WorldVehiclesRadius"] then
				features.request_control_once(v)
				ENTITY.FREEZE_ENTITY_POSITION(v, false)
				features.set_entity_velocity(v, 0, 0, 100)
			end
		end
	end, {"launchvehs"})
end)

__options.bool['HornHavoc'] = ui.add_bool_option(TRANSLATION["Horn havoc"], __submenus["Vehicles"], function(bool)
	if utils.show_info("hornhavoc [on - off]") then ui.set_value(__options.bool["HornHavoc"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	system.thread(bool, 'world_horn_havoc', function(tick)
		local veh1, veh2 = vehicles.get_player_vehicle(), vehicles.get_personal_vehicle()
		for _, v in ipairs(entities.get_vehs())
		do
			if v ~= veh1 and v ~= veh2 and features.get_entity_coords(v):sqrlen(features.get_player_coords()) <= settings.World["WorldVehiclesRadius"] * settings.World["WorldVehiclesRadius"] then
				features.request_control_once(v)
				VEHICLE.START_VEHICLE_HORN(v, 3000, 0, false)
			end
		end
	end, {"hornhavoc"})
end)

__options.bool['HornBoosting'] = ui.add_bool_option(TRANSLATION["Horn boosting"], __submenus["Vehicles"], function(bool)
	if utils.show_info("hornboosting [on - off]") then ui.set_value(__options.bool["HornBoosting"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	system.thread(bool, 'world_horn_boosting', function(tick)
		local veh1, veh2 = vehicles.get_player_vehicle(), vehicles.get_personal_vehicle()
		for _, v in ipairs(entities.get_vehs())
		do
			if v ~= veh1 and v ~= veh2 and AUDIO.IS_HORN_ACTIVE(v) == 1 and features.get_entity_coords(v):sqrlen(features.get_player_coords()) <= settings.World["WorldVehiclesRadius"] * settings.World["WorldVehiclesRadius"] then
				entities.request_control(v, function()
					local speed = ENTITY.GET_ENTITY_SPEED(v)
					VEHICLE.SET_VEHICLE_FORWARD_SPEED(v, speed + speed * .05 + 1)
				end)
			end
		end
	end)
end, {"hornboosting"})

do
	local spawned
	local ufo
	local ufo_position = vector3.zero()
	__options.bool["UFO"] = ui.add_bool_option(TRANSLATION["UFO invasion"], __submenus["World"], function(bool)
		if utils.show_info("ufo [on - off]") then ui.set_value(__options.bool["UFO"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON")
		if not spawned then
			ufo_position = features.get_offset_from_player_coords(vector3(0, 300, 0)) + vector3.up(200)
			local success, Z = features.get_ground_z(ufo_position)
			ufo_position.z = success and Z + 200 or ufo_position.z
		end

		if not bool and ufo then
			local out_pos = vector3(ufo_position.x + 1000, ufo_position.y, ufo_position.z + 1000)
			system.thread(true, 'world_ufo_delete', function()
				if ENTITY.DOES_ENTITY_EXIST(ufo) == 0 then ufo = nil spawned = nil return POP_THREAD end
				local pos = features.get_entity_coords(ufo)
				if pos:sqrlen(out_pos) > 100 then
					local move = pos:move_towards(out_pos, 50)
					entities.request_control(ufo, function()
						ENTITY.SET_ENTITY_COORDS_NO_OFFSET(ufo, move.x, move.y, move.z, false, false, false)
					end)
					utils.no_sounds_this_frame()
					ui.set_value(__options.bool["UFO"], false, false)
					return
				else
					features.delete_entity(ufo)
					STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(utils.joaat('p_spinning_anus_s'))
					ufo = nil
					spawned = nil
				end
			end)
		end

		system.thread(bool, 'world_ufo', function()
			local pos = features.get_offset_from_player_coords(vector3(0, 200, 0))
			if not ufo then 
				local loaded, hash = features.request_model('p_spinning_anus_s')
				if loaded == 0 then return end
				if not spawned then 
					pos = vector3(pos.x + 1000, pos.y, pos.z + 1000) 
				else
					pos = ufo_position
				end
				ufo = features.create_object(hash, pos)
				spawned = true
			end
			if ENTITY.DOES_ENTITY_EXIST(ufo) == 0 then ufo = nil return end
			ENTITY.SET_ENTITY_LOD_DIST(ufo, 0xFFFF)
			local pos2 = features.get_entity_coords(ufo)
			if pos2:sqrlen(ufo_position) > 100 then 
				local move = pos2:move_towards(ufo_position, 50)
				entities.request_control(ufo, function()
					ENTITY.SET_ENTITY_COORDS_NO_OFFSET(ufo, move.x, move.y, move.z, false, false, false)
				end)
				return
			else
				entities.request_control(ufo, function()
					ENTITY.SET_ENTITY_COORDS_NO_OFFSET(ufo, ufo_position.x, ufo_position.y, ufo_position.z, false, false, false)
				end)
			end
			pos = features.get_player_coords()
			local me, veh1, veh2 = features.player_ped(), vehicles.get_player_vehicle(), vehicles.get_personal_vehicle()
			GRAPHICS.DRAW_MARKER(1, ufo_position.x, ufo_position.y, ufo_position.z, 0, 0, 0, 0, 180, 0, 10, 10, 200, 0, 128, 128, 50, false, true, 1, false, 0, 0, false)
			for _, v in ipairs(features.get_entities(true))
			do
				if v ~= me and v ~= veh1 and v ~= veh2 and v ~= ufo and PED.IS_PED_A_PLAYER(v) == 0 and features.get_entity_coords(v):sqrlen(pos) < 4000000 then
					features.request_control_once(v)
					local ent_pos = features.get_entity_coords(v)
					local diff = ufo_position - ent_pos
					local dist_no_z = diff.x ^ 2 + diff.y ^ 2
					if ENTITY.IS_ENTITY_A_PED(v) == 1 then
						PED.SET_PED_CAN_RAGDOLL(v, true)
						PED.SET_PED_TO_RAGDOLL(v, 5000, 5000, 0, true, true, false)
					end
					if ENTITY.IS_ENTITY_A_VEHICLE(v) == 1 and ent_pos:sqrlen(ufo_position) <= 40000 then
						VEHICLE.SET_VEHICLE_ENGINE_ON(v, false, true, true)
					end
					if dist_no_z <= 27 then
						ENTITY.FREEZE_ENTITY_POSITION(v, false)
						features.set_entity_velocity(v, 0, 0, 40)
						if ent_pos.z < ufo_position.z and ent_pos.z >= ufo_position.z - 10 then
							features.delete_entity(v)
						end
					elseif ent_pos.z < ufo_position.z - 30 then
						local pos_to = ent_pos:direction_to(ufo_position) * 100
						ENTITY.FREEZE_ENTITY_POSITION(v, false)
						features.set_entity_velocity(v, pos_to.x, pos_to.y, 10)
					end
				end
			end

			entities.request_control(ufo, function()
				local rot = features.get_entity_rot(ufo)
				ENTITY.SET_ENTITY_ROTATION(ufo, rot.x, rot.y, rot.z + 1, 2, true)
				ENTITY.FREEZE_ENTITY_POSITION(ufo, true)
				ENTITY.SET_ENTITY_COLLISION(ufo, false, true)
			end)

		end)
	end, {"ufo"})
end

do
	local distance, force, angle = 100, 30, -80
	local GetSize = switch()
		:case(2, function()
			return 300, 50, -83
		end)
		:case(3, function()
			return 500, 70, -85
		end)
		:case(4, function()
			return 1000, 90, -90
		end)
		:case(5, function()
			return 2000, 100, -100
		end)
		:case(6, function()
			return 10000, 1000, -150
		end)
		:default(function()
			return 100, 30, -80
		end)

	__options.num["TornadoSize"] = ui.add_num_option(TRANSLATION["Tornado size"], __submenus["World"], 1, 6, 1, function(int)
		if utils.show_info("ufo [1 - 6]") then ui.set_value(__options.num["TornadoSize"], settings.World["TornadoSize"], true) return end
		utils.hud_sound("YES") settings.World["TornadoSize"] = int 
		distance, force, angle = GetSize(int)
	end, {"tornadosize"})

	__options.bool['Tornado'] = ui.add_bool_option(TRANSLATION["Tornado"], __submenus["World"], function(bool)
		if utils.show_info("tornado [on - off]") then ui.set_value(__options.bool["Tornado"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON")
		local tornado_pos = features.get_offset_from_player_coords(vector3.forward(20))
		system.thread(bool, 'world_tornado', function()
			local veh1, veh2 = vehicles.get_player_vehicle(), vehicles.get_personal_vehicle()
			local sqrdistance = distance * distance
			for _, v in ipairs(features.get_entities(true))
			do
				if v ~= veh1 and v ~= veh2 and PED.IS_PED_A_PLAYER(v) == 0 then
					local pos = features.get_entity_coords(v)
					if pos:sqrlen(tornado_pos) <= sqrdistance then
						features.request_control_once(v)
						if ENTITY.IS_ENTITY_A_PED(v) == 1 then
							PED.SET_PED_CAN_RAGDOLL(v, true)
							PED.SET_PED_TO_RAGDOLL(v, 5000, 5000, 0, true, true, false)
						end
						local final_pos = pos:direction_to(tornado_pos:point_on_circle(pos:direction_to(tornado_pos):angle() + rad(angle), 100)) * force
						ENTITY.FREEZE_ENTITY_POSITION(v, false)
						features.set_entity_velocity(v, final_pos.x, final_pos.y, .3)
					end
				end
			end
		end)
	end, {"tornado"})
end

__options.bool["Earthquake"] = ui.add_bool_option(TRANSLATION["Earthquake"], __submenus["World"], function(bool)
	if utils.show_info("earthquake [on - off]") then ui.set_value(__options.bool["Earthquake"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	system.thread(bool, 'world_earthquake', function(tick)
		if tick%5 ~= 0 then return end
		CAM.SHAKE_GAMEPLAY_CAM("LARGE_EXPLOSION_SHAKE", .05)
		local force = MISC.GET_RANDOM_FLOAT_IN_RANGE(-9, -7)
		local veh1, veh2 = vehicles.get_player_vehicle(), vehicles.get_personal_vehicle()
		local pos = features.get_player_coords()
		for _, v in ipairs(features.get_entities(true))
		do
			local model = ENTITY.GET_ENTITY_MODEL(v)
			if v ~= veh1 and v ~= veh2 and VEHICLE.IS_THIS_MODEL_A_PLANE(model) == 0 and VEHICLE.IS_THIS_MODEL_A_HELI(model) == 0 and features.get_entity_coords(v):sqrlen(pos) < 1000000 then
				features.request_control_once(v)
				if ENTITY.IS_ENTITY_A_PED(v) == 1 then
					PED.SET_PED_CAN_RAGDOLL(v, true)
					PED.SET_PED_TO_RAGDOLL(v, 5000, 5000, 0, true, true, false)
				end
				features.apply_force_to_entity(v, 1, 0, 0, force, 0, 0, 0, 0, true, true, true, false, true)
			end
		end
	end)
	if not bool then
		CAM.STOP_GAMEPLAY_CAM_SHAKING(true)
	end
end, {"earthquake"})

__options.bool['DisablePedSpawn'] = ui.add_bool_option(TRANSLATION["Disable ped spawn"], __submenus["World"], function(bool)
	if utils.show_info("disablepeds [on - off]") then ui.set_value(__options.bool["DisablePedSpawn"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.World['DisablePedSpawn'] = bool
	system.thread(bool, 'world_disable_peds', function(tick)
		PED.SET_PED_DENSITY_MULTIPLIER_THIS_FRAME(0)
	end)
end, {"disablepeds"})

__options.bool['DisableVehicleSpawn'] = ui.add_bool_option(TRANSLATION["Disable vehicle spawn"], __submenus["World"], function(bool)
	if utils.show_info("disablevehs [on - off]") then ui.set_value(__options.bool["DisableVehicleSpawn"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.World['DisableVehicleSpawn'] = bool
	system.thread(bool, 'world_disable_vehicles', function(tick)
	 	VEHICLE.SET_VEHICLE_DENSITY_MULTIPLIER_THIS_FRAME(0)
		VEHICLE.SET_PARKED_VEHICLE_DENSITY_MULTIPLIER_THIS_FRAME(0)
		VEHICLE.SET_RANDOM_VEHICLE_DENSITY_MULTIPLIER_THIS_FRAME(0)
		VEHICLE.SET_AMBIENT_VEHICLE_RANGE_MULTIPLIER_THIS_FRAME(0)
	end)
end, {"disablevehs"})

do
	local opt = ui.add_float_option(TRANSLATION["Set waves height"], __submenus["World"], -100, 100, .1, 1, function(float)
		if utils.show_info("waveheight [-100.0 - 100.0]") then return end
		utils.hud_sound("YES")
		WATER.SET_DEEP_OCEAN_SCALER(float)
	end, {"waveheight"})
	system.thread(true, 'world_get_waves_intensity', function()
		ui.set_value(opt, WATER.GET_DEEP_OCEAN_SCALER(), true)
	end)
end

do
	local opt = ui.add_float_option(TRANSLATION["Set rain level"], __submenus["World"], 0, 5, .1, 1, function(float)
		if utils.show_info("rainlevel [0.0 - 5.0]") then return end
		utils.hud_sound("YES")
		MISC._SET_RAIN_LEVEL(float)
	end, {"rainlevel"})
	system.thread(true, 'world_get_rain_intensity', function()
		ui.set_value(opt, MISC.GET_RAIN_LEVEL(), true)
	end)
end

do
	local scaler = 0
	local opt = ui.add_float_option(TRANSLATION["Set wind speed"], __submenus["World"], -10, 10, .1, 1, function(float)
		if utils.show_info("rainlevel [-10.0 - 10.0]") then return end
		utils.hud_sound("YES")
		MISC.SET_WIND_SPEED(float)
	end, {"windspeed"})
	system.thread(true, 'world_get_wind_intensity', function()
		ui.set_value(opt, MISC.GET_WIND_SPEED(), true)
	end)
end

---------------------------------------------------------------------------------------------------------------------------------
-- Teleport
---------------------------------------------------------------------------------------------------------------------------------

__submenus["Teleport"] = ui.add_submenu(TRANSLATION["Teleport"])
__suboptions["Teleport"] = ui.add_sub_option(TRANSLATION["Teleport"], __submenus["MainSub"], __submenus["Teleport"])

ui.add_click_option(TRANSLATION['Teleport to objective'], __submenus["Teleport"], function()
	if utils.show_info("tpmission, tpobjective") then return end
	local pos = features.get_blip_objective()
	if not pos then
		system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Blip not found"], settings.General["HudColorNotifyError"])
		utils.hud_sound("ERROR")
		return
	end
	insert(Global.last_teleports, features.get_player_coords())
	utils.hud_sound("SELECT")
	features.teleport(features.player_ped(), pos.x, pos.y, pos.z)
end, {"tpmission", "tpobjective"})

ui.add_click_option(TRANSLATION['Teleport to waypoint'], __submenus["Teleport"], function()
	if utils.show_info("tpwp, tpwaypoint") then return end
	if HUD.IS_WAYPOINT_ACTIVE() == 0 then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["No waypoint has been set"], settings.General["HudColorNotifyError"]) return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	insert(Global.last_teleports, features.get_player_coords())
	local coords = features.get_waypoint_coord()
	local entity = features.player_ped()
	local result = cache:get(tostring(coords))
	if result then
		local pos = vector3(result)
		features.teleport(entity, pos.x, pos.y, pos.z)
		HUD.SET_WAYPOINT_OFF()
		return
	end
	local b_pos = features.get_blip_for_coord(coords)
	if b_pos then
		features.teleport(entity, b_pos.x, b_pos.y, b_pos.z)
		cache:set(tostring(coords), b_pos, 1000)
		HUD.SET_WAYPOINT_OFF()
		return
	end
	system.thread(true, 'teleport_'..system.thread_count(), function(tick)
		system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Preparing teleport"], settings.General["HudColorNotifyNormal"])
		local Z = (tick+1) * 100
		if settings.Teleport["TeleportMethod"] == 0 then
			STREAMING.REQUEST_COLLISION_AT_COORD(coords.x, coords.y, Z)
		else
			features.teleport(features.player_ped(), coords.x, coords.y, Z)
		end
		local water, groundZ = features.get_water_z(vector3(coords.x, coords.y, 500))
		local success
		if not water or settings.Teleport["TeleportMethod"] == 1 then
			success, groundZ = features.get_ground_z(vector3(coords.x, coords.y, Z))
			if not success and Z < 900 then return end
			if not success and settings.Teleport["TeleportMethod"] == 0 then system.reset_thread_tick() return end
		end
		HUD.SET_WAYPOINT_OFF()
		features.teleport(entity, coords.x, coords.y, groundZ + 1)
		if water or groundZ <= 10 then
			utils.fix_tp(groundZ)
		else
			cache:set(tostring(coords), vector3(coords.x, coords.y, groundZ + 1), 1000)
		end
		return POP_THREAD
	end)
end, {"tpwp", "tpwaypoint"})

__submenus["SavedLocations"] = ui.add_submenu(TRANSLATION["Saved locations"])
__suboptions["SavedLocations"] = ui.add_sub_option(TRANSLATION["Saved locations"], __submenus["Teleport"], __submenus["SavedLocations"])

__submenus["PreMadeLocations"] = ui.add_submenu(TRANSLATION["Pre-made locations"])
__suboptions["PreMadeLocations"] = ui.add_sub_option(TRANSLATION["Pre-made locations"], __submenus["Teleport"], __submenus["PreMadeLocations"])

__submenus["IPLs"] = ui.add_submenu(TRANSLATION["IPLs"])
__suboptions["IPLs"] = ui.add_sub_option(TRANSLATION["IPLs"], __submenus["Teleport"], __submenus["IPLs"])

__submenus["SaveLocation"] = ui.add_submenu(TRANSLATION["Save location"])
__suboptions["SaveLocation"] = ui.add_sub_option(TRANSLATION["Save location"], __submenus["SavedLocations"], __submenus["SaveLocation"])

do
	local folders = {}
	local separator
	local function RefreshLocations()
		for _, v in ipairs(Global.locations)
		do
			for _, e in pairs(v)
			do
				ui.remove(e)
			end
		end
		for _, v in pairs(folders)
		do
			ui.remove(v.choose)
			ui.remove(v.sub_option)
		end
		folders = {}

		if separator then
			ui.remove(separator)
		end

		for i = 1, #Global.command_locations
		do
			Global.command_locations[i] = nil
		end

		for i, v in pairs(Global.saved_locations)
		do
			insert(Global.command_locations, v.name:lower())
			if v.folder and not folders[v.folder] then
				local sub = ui.add_submenu(v.folder)
				folders[v.folder] = {
					choose = ui.add_choose(TRANSLATION["Delete"], sub, false, {TRANSLATION["Only folder"], TRANSLATION["Folder & locations"]}, function(int)
						utils.hud_sound("YES")
						system.thread(true, 'ui_refresh_'..system.thread_count(), function()
							local i = 1
							while i <= #Global.saved_locations
							do
								if Global.saved_locations[i].folder == v.folder then
									if int == 0 then
										Global.saved_locations[i].folder = nil
									else
										table.remove(Global.saved_locations, i)
									end
								else
									i = i + 1
								end
							end
							RefreshLocations()
							SaveLocations()
							return POP_THREAD
						end)
					end),
					sub = sub,
					sub_option = ui.add_sub_option( v.folder, __submenus["SavedLocations"], sub)
				}
			end
		end
		separator = ui.add_separator(TRANSLATION["Saved"], __submenus["SavedLocations"])

		for i, v in ipairs(Global.saved_locations)
		do
			local sub = ui.add_submenu(v.name)
			Global.locations[i] = {
				submenu = sub,
				sub_option = ui.add_sub_option(v.name, v.folder and folders[v.folder].sub or __submenus["SavedLocations"], sub),
				teleport = ui.add_click_option(TRANSLATION["Teleport to"], sub, function()
					if utils.show_info("goto "..v.name:lower()) then return end
					utils.hud_sound("SELECT")
					insert(Global.last_teleports, features.get_player_coords())
					features.teleport(features.player_ped(), v.x, v.y, v.z, v.heading)
				end),
				rename = ui.add_input_string(TRANSLATION["Rename"], sub, function(text) 
					if not text or text:isblank() then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Please enter name"], settings.General["HudColorNotifyError"]) return utils.hud_sound("ERROR") end
					Global.saved_locations[i].name = text
					ui.set_name(Global.locations[i].submenu, text)
					ui.set_name(Global.locations[i].sub_option, text)
					SaveLocations()
				end),
				delete = ui.add_click_option(TRANSLATION["Delete"], sub, function()
					utils.hud_sound("SELECT")
					system.thread(true, 'ui_refresh_'..system.thread_count(), function()
						table.remove(Global.saved_locations, i)
						RefreshLocations()
						SaveLocations()
						return POP_THREAD
					end)
				end)
			}
			if not v.folder then
				Global.locations[i].add_to_folder = ui.add_submenu(TRANSLATION["Add to folder"])
				Global.locations[i].add_to_folder_s = ui.add_sub_option(TRANSLATION["Add to folder"], Global.locations[i].submenu, Global.locations[i].add_to_folder) 
				Global.locations[i].string = ui.add_input_string(TRANSLATION["Create folder"], Global.locations[i].add_to_folder, function(text)
					if not text or text:isblank() or folders[text] then return end
					system.thread(true, 'ui_refresh_'..system.thread_count(), function()
						Global.saved_locations[i].folder = text
						RefreshLocations()
						SaveLocations()
						return POP_THREAD
					end)
				end)
				for k in pairs(folders)
				do
					Global.locations[i][k] = ui.add_click_option(k, Global.locations[i].add_to_folder, function()
						utils.hud_sound("SELECT")
						system.thread(true, 'ui_refresh_'..system.thread_count(), function()
							Global.saved_locations[i].folder = k
							RefreshLocations()
							SaveLocations()
							return POP_THREAD
						end)
					end)
				end
			end
		end
	end

	local folder
	__options.click["TeleportSelectedFolder"] = ui.add_click_option('', __submenus["SaveLocation"], function() utils.hud_sound("SELECT") folder = nil end)
	__submenus["TeleportFolders"] = ui.add_submenu(TRANSLATION["Select folder"])
	__suboptions["TeleportFolders"] = ui.add_sub_option(TRANSLATION["Select folder"], __submenus["SaveLocation"], __submenus["TeleportFolders"])
	ui.add_input_string(TRANSLATION["Create folder"], __submenus["TeleportFolders"], function(text)
		system.thread(true, 'ui_refresh_'..system.thread_count(), function()
			if text:isblank() then folder = nil return POP_THREAD end
			if text and not folders[text] then
				folder = text
			end
			return POP_THREAD
		end)
	end)

	ui.add_separator(TRANSLATION["Folders"], __submenus["SavedLocations"])
	local created_folders = {}
	system.thread(true, 'ui_teleport_folders', function()
		ui.set_name(__options.click["TeleportSelectedFolder"], format(TRANSLATION["Folder: %s"], folder or TRANSLATION["None"]))
		for k, v in pairs(created_folders)
		do
			if not folders[k] then
				ui.remove(v)
			end
		end
		for k in pairs(folders)
		do
			if not created_folders[k] then
				created_folders[k] = ui.add_click_option(k, __submenus["TeleportFolders"], function()
					utils.hud_sound("SELECT")
					folder = k
				end)
			end
		end
	end)

	ui.add_input_string(TRANSLATION["Save"], __submenus["SaveLocation"], function(name)
		if utils.show_info("savelocation") then return end
		if not name or name:isblank() then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Please enter name"], settings.General["HudColorNotifyError"]) return utils.hud_sound("ERROR") end
		utils.hud_sound("SELECT")
		system.thread(true, 'ui_refresh_'..system.thread_count(), function()
			local pos = features.get_player_coords()
			local heading = features.get_player_heading()
			insert(Global.saved_locations, {
				folder = folder,
				name = name,
				x = pos.x,
				y = pos.y,
				z = pos.z,
				heading = heading
			})
			RefreshLocations()
			SaveLocations()
			return POP_THREAD
		end)
	end, {"savelocation"})

	RefreshLocations()

	system.register_command({"goto"}, {type = "choose", actions = Global.command_locations, func = function(i)
		local v = Global.saved_locations[i]
		if not v then return utils.hud_sound("ERROR") end
		utils.hud_sound("SELECT")
		insert(Global.last_teleports, features.get_player_coords())
		features.teleport(features.player_ped(), v.x, v.y, v.z, v.heading)
	end})
end

__submenus["Interiors"] = ui.add_submenu(TRANSLATION["Interiors"])
__suboptions["Interiors"] = ui.add_sub_option(TRANSLATION["Interiors"], __submenus["PreMadeLocations"], __submenus["Interiors"])

__submenus["Landmarks"] = ui.add_submenu(TRANSLATION["Landmarks"])
__suboptions["Landmarks"] = ui.add_sub_option(TRANSLATION["Landmarks"], __submenus["PreMadeLocations"], __submenus["Landmarks"])

__submenus["HighUp"] = ui.add_submenu(TRANSLATION["High up"])
__suboptions["HighUp"] = ui.add_sub_option(TRANSLATION["High up"], __submenus["PreMadeLocations"], __submenus["HighUp"])

__submenus["Underwater"] = ui.add_submenu(TRANSLATION["Underwater"])
__suboptions["Underwater"] = ui.add_sub_option(TRANSLATION["Underwater"], __submenus["PreMadeLocations"], __submenus["Underwater"])

Global.teleports = {
	{enum.interiors, "Interiors"},
	{enum.landmarks, "Landmarks"},
	{enum.highup, "HighUp"},
	{enum.underwater, "Underwater"}
}

for _, e in ipairs(Global.teleports)
do
	for _, v in ipairs(e[1])
	do
		v[3] = v[3] or v[1]:gsub("[%s%p]+", ""):lower()
		ui.add_click_option(TRANSLATION[v[1]] ,__submenus[e[2]], function()
			if utils.show_info("move"..v[3]) then return end
			insert(Global.last_teleports, features.get_player_coords())
			features.teleport(features.player_ped(), v[2]:get())
			utils.hud_sound("SELECT")
		end, {"move"..v[3]})
	end
end

__options.bool["TPtoIPL"] = ui.add_bool_option(TRANSLATION["Teleport to IPLs"], __submenus["IPLs"], function(bool)
	if utils.show_info("tpipls [on - off]") then ui.set_value(__options.bool["TPtoIPL"], not bool, true) return end
	settings.Teleport["TPtoIPL"] = bool
	utils.hud_sound("TOGGLE_ON")
end, {"tpipls"})

__options.bool["YanktonMap"] = ui.add_bool_option(TRANSLATION["Set minimap in prologue"], __submenus["IPLs"], function(bool)
	if utils.show_info("yanktonmap [on - off]") then ui.set_value(__options.bool["YanktonMap"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	HUD.SET_MINIMAP_IN_PROLOGUE(bool)
end, {"yanktonmap"})

__options.bool["CayoMap"] = ui.add_bool_option(TRANSLATION["Set minimap in Cayo Perico"], __submenus["IPLs"], function(bool)
	if utils.show_info("cayomap [on - off]") then ui.set_value(__options.bool["CayoMap"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	HUD._SET_TOGGLE_MINIMAP_HEIST_ISLAND(bool)
end, {"cayomap"})

__options.bool["CayoPerico"] = ui.add_bool_option(TRANSLATION["Cayo Perico"], __submenus["IPLs"], function(bool)
	if utils.show_info("cayo [on - off]") then ui.set_value(__options.bool["CayoPerico"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	if bool then
		MISC.SET_INSTANCE_PRIORITY_MODE(true)
		DLC.ON_ENTER_MP()
	end
	STREAMING._SET_ISLAND_HOPPER_ENABLED("HeistIsland", bool)
	if bool and settings.Teleport["TPtoIPL"] then
		insert(Global.last_teleports, features.get_player_coords())
		features.teleport(features.player_ped(), 4895.28, -5744.58, 26.351)
	end
end, {"cayo"})
for _, v in ipairs(ipls)
do
	v.Command = v.Name:gsub("[%s%p]+", ""):lower()
	v.Option = ui.add_bool_option(TRANSLATION[v.Name], __submenus["IPLs"], function(bool)
		if utils.show_info(v.Command.." [on - off]") then ui.set_value(v.Option, not bool, true) return end
		utils.hud_sound("TOGGLE_ON")
		system.thread(true, "load_ipl_"..v.Option, function()
			if bool then
				if v.LoadOnline then
					MISC.SET_INSTANCE_PRIORITY_MODE(true)
					DLC.ON_ENTER_MP()
				end
				if not ui.get_value(v.Option) then return POP_THREAD end
				for _, e in ipairs(v.IPLs)
				do
					if STREAMING.IS_IPL_ACTIVE(e) == 0 then
						return STREAMING.REQUEST_IPL(e)
					end
				end
				if settings.Teleport["TPtoIPL"] then
					insert(Global.last_teleports, features.get_player_coords())
					features.teleport(features.player_ped(), v.Pos:get())
				end
			else
				for _, e in ipairs(v.IPLs)
				do
					STREAMING.REMOVE_IPL(e)
				end
			end
			return POP_THREAD
		end)
	end, {v.Command})
end

__options.choose["TeleportMethod"] = ui.add_choose(TRANSLATION["Teleport method"], __submenus["Teleport"], true, {TRANSLATION["Load collision"], TRANSLATION["Fake teleport"]}, function(int)
	if utils.show_info("tpmethod [choose]") then ui.set_value(__options.choose["TeleportMethod"], settings.Teleport["TeleportMethod"], true) return end
	utils.hud_sound("YES")
	settings.Teleport["TeleportMethod"] = int
end, {"tpmethod"})

function utils.undo_tp()
	local len = #Global.last_teleports
	local pos = Global.last_teleports[len]
	Global.last_teleports[len] = nil
	features.teleport(features.player_ped(), pos:get())
end

function utils.fix_tp(Z, undo)
	system.thread(true, 'fix_teleport', function(tick)
		if tick < 5 then return end
		local pos = features.get_player_coords()
		if tick > 20 then
			if undo then
				utils.undo_tp();system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Land not found"], settings.General["HudColorNotifyError"])
			else
				features.teleport(features.player_ped(), pos.x, pos.y, Z + 2)
			end
			return POP_THREAD
		end
		local success, groundZ = features.get_ground_z(pos + vector3.up(20))
		local water, waterZ = features.get_water_z(pos + vector3.up(20))
		if not success then
			features.teleport(features.player_ped(), pos.x, pos.y, pos.z + 30)
			return
		elseif success and groundZ >= Z and groundZ >= waterZ then
			features.teleport(features.player_ped(), pos.x, pos.y, groundZ + 1)
			return POP_THREAD
		end
	end)
end

__options.bool["AutoTpToWp"] = ui.add_bool_option(TRANSLATION['Auto teleport to waypoint'], __submenus["Teleport"], function(bool)
	if utils.show_info("autotp [on - off]") then ui.set_value(__options.bool["AutoTpToWp"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Teleport["AutoTpToWp"] = bool
	local tp
	system.thread(bool, 'teleport_auto_to_wp', function()
		if HUD.IS_WAYPOINT_ACTIVE() == 0 or tp then return end
		local coords = features.get_waypoint_coord()
		if cache:get('bad'..tostring(coords)) then return end
		tp = true
		local coords_mem = features.get_player_coords()
		local entity = features.player_ped()
		local result = cache:get(tostring(coords))
		if result then
			local pos = vector3(result)
			features.teleport(entity, pos.x, pos.y, pos.z)
			insert(Global.last_teleports, coords_mem)
			HUD.SET_WAYPOINT_OFF()
			tp = false
			return
		end
		local b_pos = features.get_blip_for_coord(coords)
		if b_pos then
			features.teleport(entity, b_pos.x, b_pos.y, b_pos.z)
			cache:set(tostring(coords), b_pos, 1000)
			insert(Global.last_teleports, coords_mem)
			HUD.SET_WAYPOINT_OFF()
			tp = false
			return
		end
		local water, groundZ = features.get_water_z(vector3(coords.x, coords.y, 500))
		system.thread(true, 'teleport_'..system.thread_count(), function(tick)
			local Z = (tick+1) * 100
			local rot = features.get_entity_rot(entity, 5)
			ENTITY.SET_ENTITY_ROTATION(entity, 0, 0, rot.z, 5, true)
			if settings.Teleport["TeleportMethod"] == 0 and vehicles.get_player_vehicle() ~= 0 and VEHICLE.GET_VEHICLE_CLASS(vehicles.get_player_vehicle()) ~= 14 and not settings.Self["WalkOnWater"] and water then
				tp = false
				cache:set('bad'..tostring(coords), true, 10000)
				system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["I won't teleport you into water"]..' :(', settings.General["HudColorNotifyError"], true)
				return POP_THREAD
			end
			system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Preparing teleport"], settings.General["HudColorNotifyNormal"])
			if settings.Teleport["TeleportMethod"] == 0 then
				STREAMING.REQUEST_COLLISION_AT_COORD(coords.x, coords.y, Z)
			else
				features.teleport(features.player_ped(), coords.x, coords.y, Z > groundZ and Z or groundZ + 5)
			end
			if not water or settings.Teleport["TeleportMethod"] == 1 then
				local success, testZ = features.get_ground_z(vector3(coords.x, coords.y, Z))
				if (not success or testZ < groundZ) and (water and Z < 200 or Z < 900) then return end
				if not success and settings.Teleport["TeleportMethod"] == 0 then system.reset_thread_tick() return end
				groundZ = testZ > groundZ and testZ or groundZ
			end
			features.teleport(entity, coords.x, coords.y, groundZ + 1)
			insert(Global.last_teleports, coords_mem)
			HUD.SET_WAYPOINT_OFF()
			tp = false
			if water or groundZ <= 10 then utils.fix_tp(groundZ, vehicles.get_player_vehicle() ~= 0 and VEHICLE.GET_VEHICLE_CLASS(vehicles.get_player_vehicle()) ~= 14 and not settings.Self["WalkOnWater"]) end
			return POP_THREAD
		end)
	end)
end, {"autotp"})

__options.bool["MarkerOnWaypoint"] = ui.add_bool_option(TRANSLATION["Marker on waypoint"], __submenus["Teleport"], function(bool)
	if utils.show_info("markerwp [on - off]") then ui.set_value(__options.bool["MarkerOnWaypoint"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Teleport["MarkerOnWaypoint"] = bool
	system.thread(bool, 'marker_wp', function()
		if HUD.IS_WAYPOINT_ACTIVE() == 0 then return end
		local color = settings.General["HudColorSelf"]
		local my_coord = features.get_final_cam_pos()
		my_coord.z = 0
		local pos = features.get_waypoint_coord()
		pos.z = 0
		local scale = pos:len(my_coord) / 200
		GRAPHICS.DRAW_MARKER(1, pos.x, pos.y, -1000, 0, 0, 0, 0, 0, 0, .2 + scale, .2 + scale, 10000, color.r, color.g, color.b, 180, false, true, 1, false, 0, 0, false)
	end)
end)

ui.add_click_option(TRANSLATION['Undo teleport'], __submenus["Teleport"], function()
	if utils.show_info("undotp, tpback") then return end
	if #Global.last_teleports == 0 then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["No teleport to undo"], settings.General["HudColorNotifyError"]) return utils.hud_sound("ERROR") end 
	utils.hud_sound("SELECT")
	utils.undo_tp()
end, {"undotp", "tpback"})

ui.add_separator(TRANSLATION["Forward"], __submenus["Teleport"])

__options.num['TpForwardDist'] = ui.add_num_option(TRANSLATION["Distance"], __submenus["Teleport"], 1, 50, 1, function(int)
	if utils.show_info("tpforwarddist [1 - 50]") then ui.set_value(__options.num['TpForwardDist'], settings.Teleport['TpForwardDist'], true) return end
	utils.hud_sound("YES") settings.Teleport['TpForwardDist'] = int
end, {"tpforwarddist"})
ui.add_click_option(TRANSLATION['Teleport Forward'], __submenus["Teleport"], function()
	if utils.show_info("tpforward") then return end
	utils.hud_sound("SELECT")
	insert(Global.last_teleports, features.get_player_coords())
	local pos = features.get_offset_from_player_coords(vector3(0, settings.Teleport['TpForwardDist'], 0))
	features.teleport2(features.player_ped(), pos.x, pos.y, pos.z)
end, {"tpforward"})

ui.add_separator(TRANSLATION["Clipboard"], __submenus["Teleport"])

ui.add_click_option(TRANSLATION['Copy position'], __submenus["Teleport"], function()
	if utils.show_info("copypos") then return end
	system.log('My position', tostring(features.get_player_coords()))
	if system.is_safe_mode_enabled() then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["This feature requires Safe mode to be disabled"], settings.General["HudColorNotifyError"]) return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	features.to_clipboard(tostring(features.get_player_coords()), true)
end, {"copypos"})

ui.add_click_option(TRANSLATION['Teleport from clipboard'], __submenus["Teleport"], function()
	if utils.show_info("tpclip") then return end
	if system.is_safe_mode_enabled() then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["This feature requires Safe mode to be disabled"], settings.General["HudColorNotifyError"]) return utils.hud_sound("ERROR") end
	local data = system.from_clipboard():split('%,', true)
	for i, v in ipairs(data)
	do
		local num = v:gsub('[^%-%d%.]', '')
		data[i] = num and tonumber(num) or nil
	end
	if not data[1] or not data[2] then
		system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["I can't find any Vector3 or Vector2 data in clipboard, expected format (x, y, z)"], settings.General["HudColorNotifyError"])
		return utils.hud_sound("ERROR")
	end
	utils.hud_sound("SELECT")
	insert(Global.last_teleports, features.get_player_coords())
	if not data[3] then
		local pos = cache:get(tostring(data[1]..', '..data[2]))
		if pos then
			features.teleport(features.player_ped(), pos.x, pos.y, pos.z)
			return
		end
		local water, groundZ = features.get_water_z(vector3(data[1], data[2], 500))
		system.thread(true, 'teleport_'..system.thread_count(), function(tick)
			system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Preparing teleport"], settings.General["HudColorNotifyNormal"])
			local Z = (tick+1) * 100
			if settings.Teleport["TeleportMethod"] == 0 then
				STREAMING.REQUEST_COLLISION_AT_COORD(data[1], data[2], Z)
			else
				features.teleport(features.player_ped(), data[1], data[2], Z > groundZ and Z or groundZ + 5)
			end
			if not water or settings.Teleport["TeleportMethod"] == 1 then
				local success, testZ = features.get_ground_z(vector3(data[1], data[2], Z))
				if (not success or testZ < groundZ) and (water and Z < 200 or Z < 900) then return end
				if not success and settings.Teleport["TeleportMethod"] == 0 then system.reset_thread_tick() return end
				groundZ = testZ > groundZ and testZ or groundZ
			end
			features.teleport(features.player_ped(), data[1], data[2], groundZ + 1)
			if water or groundZ <= 10 then utils.fix_tp(groundZ) return POP_THREAD end
			cache:set(tostring(data[1]..', '..data[2]), vector3(data[1], data[2], groundZ + 1), 1000)
			return POP_THREAD
		end)
	else
		features.teleport(features.player_ped(), data[1], data[2], data[3])
	end
end, {"tpclip"})

ui.add_separator(TRANSLATION['Input coords'], __submenus["Teleport"])



do
	local tp = vector3.zero()
	ui.add_click_option(TRANSLATION["Get current position"], __submenus["Teleport"], function()
		if utils.show_info("getpos") then return end
		utils.hud_sound("SELECT")
		local pos = features.get_player_coords()
		utils.no_sounds_this_frame()
		ui.set_value(__options.num["InputCoordX"], pos.x, false)
		ui.set_value(__options.num["InputCoordY"], pos.y, false)
		ui.set_value(__options.num["InputCoordZ"], pos.z, false)
	end, {"getpos"})
	__options.num["InputCoordX"] = ui.add_float_option('X', __submenus["Teleport"], -10000, 10000, 1, 3, function(float)
		if utils.show_info("inputcoordx") then ui.set_value(__options.num["InputCoordX"], tp.x, true) return end utils.hud_sound("YES") tp.x = float
	end, {"inputcoordx"})
	__options.num["InputCoordY"] = ui.add_float_option('Y', __submenus["Teleport"], -10000, 10000, 1, 3, function(float)
		if utils.show_info("inputcoordy") then ui.set_value(__options.num["InputCoordY"], tp.y, true) return end utils.hud_sound("YES") tp.y = float
	end, {"inputcoordy"})
	__options.num["InputCoordZ"] = ui.add_float_option('Z', __submenus["Teleport"], -10000, 10000, 1, 3, function(float)
		if utils.show_info("inputcoordz") then ui.set_value(__options.num["InputCoordZ"], tp.z, true) return end utils.hud_sound("YES") tp.z = float
	end, {"inputcoordz"})
	ui.add_click_option(TRANSLATION['Teleport'], __submenus["Teleport"], function()
		if utils.show_info("tppos") then return end
		utils.hud_sound("SELECT")
		insert(Global.last_teleports, features.get_player_coords())
		features.teleport(features.player_ped(), tp.x, tp.y, tp.z)
	end, {"tppos"})
end

---------------------------------------------------------------------------------------------------------------------------------
-- Weapons
---------------------------------------------------------------------------------------------------------------------------------
__submenus["Weapons"] = ui.add_submenu(TRANSLATION["Weapons"])
__suboptions["Weapons"] = ui.add_sub_option(TRANSLATION["Weapons"], __submenus["MainSub"], __submenus["Weapons"])

__submenus["AimAssist"] = ui.add_submenu(TRANSLATION["Aim assist"])
__suboptions["AimAssist"] = ui.add_sub_option(TRANSLATION["Aim assist"], __submenus["Weapons"], __submenus["AimAssist"])

ui.add_separator(TRANSLATION["Targets"], __submenus["AimAssist"])

__options.bool["TargetPeds"] = ui.add_bool_option(TRANSLATION['Target NPCs'], __submenus["AimAssist"], function(bool)
	if utils.show_info("targetnpc [on - off]") then ui.set_value(__options.bool["TargetPeds"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON") settings.Weapons["TargetPeds"] = bool
end, {"targetnpc"})
__options.bool["TargetPlayers"] = ui.add_bool_option(TRANSLATION['Target players'], __submenus["AimAssist"], function(bool)
	if utils.show_info("targetplayers [on - off]") then ui.set_value(__options.bool["TargetPlayers"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON") settings.Weapons["TargetPlayers"] = bool
end, {"targetplayers"})
__options.bool["TargetEnemies"] = ui.add_bool_option(TRANSLATION['Target enemies'], __submenus["AimAssist"], function(bool)
	if utils.show_info("targetenemies [on - off]") then ui.set_value(__options.bool["TargetEnemies"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON") settings.Weapons["TargetEnemies"] = bool
end, {"targetenemies"})
__options.bool["TargetCops"] = ui.add_bool_option(TRANSLATION['Target cops'], __submenus["AimAssist"], function(bool)
	if utils.show_info("targetcops [on - off]") then ui.set_value(__options.bool["TargetCops"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON") settings.Weapons["TargetCops"] = bool
end, {"targetcops"})

do
	local bone_id = {
		[0] = 0x796e,
		0x9995,
		0xe0fd,
		0x3fcf
	}
	__options.choose["AimBone"] = ui.add_choose(TRANSLATION['Bone'], __submenus["AimAssist"], true, {TRANSLATION["Head"], TRANSLATION["Neck"], TRANSLATION["Spine"], TRANSLATION["Knee"]}, function(int)
		if utils.show_info("aimbone [choose]") then ui.set_value(__options.choose["AimBone"], settings.Weapons["AimBone"], true) return end
		utils.hud_sound("YES") settings.Weapons["AimBone"] = int
	end, {"aimbone"})

	ui.add_separator(TRANSLATION["Assistance"], __submenus["AimAssist"])

	__options.bool["Triggerbot"] = ui.add_bool_option(TRANSLATION['Triggerbot'], __submenus["AimAssist"], function(bool)
		if utils.show_info("triggerbot") then ui.set_value(__options.bool["Triggerbot"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON")
		settings.Weapons["Triggerbot"] = bool 
		system.thread(bool, "weapons_trigger", function()	
			if PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) == 1 and ENTITY.IS_ENTITY_DEAD(features.player_ped(), false) == 0 then
				local entity = features.get_aimed_ped()
				if entity == 0 then return end
				if ENTITY.IS_ENTITY_A_PED(entity) == 1 and ENTITY.IS_ENTITY_DEAD(entity, false) == 0 and not (settings.General['Exclude Friends'] and features.is_friend(features.get_player_from_ped(entity)))
					and not features.is_excluded(features.get_player_from_ped(entity)) then
					local triggered
					if settings.Weapons["TargetPlayers"] and PED.IS_PED_A_PLAYER(entity) == 1 then
						triggered = true
					elseif settings.Weapons["TargetEnemies"] and peds.is_ped_an_enemy(entity) then
						triggered = true
					elseif settings.Weapons["TargetCops"] and (PED.GET_PED_TYPE(entity) == 6 or PED.GET_PED_TYPE(entity) == 27) then
						triggered = true
					end
					if triggered or settings.Weapons["TargetPeds"] then
						-- PAD._SET_CONTROL_NORMAL(0, enum.input.ATTACK, 1)

						local coord = vector3(ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(entity, PED.GET_PED_BONE_INDEX(entity, bone_id[settings.Weapons["AimBone"]])))
						if not (coord == vector3.zero()) then
							if PED.IS_PED_IN_ANY_VEHICLE(entity, false) == 1 then
								coord.z = coord.z + .08
							end
							PED.SET_PED_SHOOTS_AT_COORD(features.player_ped(), coord.x, coord.y, coord.z, true)
						end
					end
				end
			end
		end)
	end, {"triggerbot"})

	ui.add_separator(TRANSLATION["Aimbot"], __submenus["AimAssist"])
	__options.bool["AimbotWallCheck"] = ui.add_bool_option(TRANSLATION["Wall check"], __submenus["AimAssist"], function(bool)
		if utils.show_info("aimwallcheck [on - off]") then ui.set_value(__options.bool["AimbotWallCheck"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") settings.Weapons["AimbotWallCheck"] = bool
	end, {"aimwallcheck"})
	__options.bool["AimbotFollowTarget"] = ui.add_bool_option(TRANSLATION["Follow target"], __submenus["AimAssist"], function(bool)
		if utils.show_info("aimfollow [on - off]") then ui.set_value(__options.bool["AimbotFollowTarget"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") settings.Weapons["AimbotFollowTarget"] = bool
	end, {"aimfollow"})
	__options.bool["AimbotShowBox"] = ui.add_bool_option(TRANSLATION["Show box"], __submenus["AimAssist"], function(bool)
		if utils.show_info("aimbox [on - off]") then ui.set_value(__options.bool["AimbotShowBox"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") settings.Weapons["AimbotShowBox"] = bool
	end, {"aimbox"})
	__options.num["AimbotDistance"] = ui.add_float_option(TRANSLATION["Distance"], __submenus["AimAssist"], 10, 1500, 10, 3, function(float)
		if utils.show_info("aimdist [10.0 - 1500.0]") then ui.set_value(__options.num["AimbotDistance"], settings.Weapons["AimbotDistance"], true) return end
		utils.hud_sound("YES") settings.Weapons["AimbotDistance"] = features.round(float, 3)
	end, {"aimdist"})
	__options.num["AimbotFov"] = ui.add_num_option(TRANSLATION["FOV"], __submenus["AimAssist"], 10, 360, 10, function(int)
		if utils.show_info("aimfov [10 - 360]") then ui.set_value(__options.num["AimbotFov"], settings.Weapons["AimbotFov"], true) return end
		utils.hud_sound("YES") settings.Weapons["AimbotFov"] = int
	end, {"aimfov"})
	__options.choose["AimbotPrioritize"] = ui.add_choose(TRANSLATION["Prioritize"], __submenus["AimAssist"], true, {TRANSLATION["Distance"], TRANSLATION["Screen center"]}, function(int)
		if utils.show_info("aimpriority [choose]") then ui.set_value(__options.bool["AimbotPrioritize"], settings.Weapons["AimbotPrioritize"], true) return end
		utils.hud_sound("YES") settings.Weapons["AimbotPrioritize"] = int
	end, {"aimpriority"})
	__options.bool["AimbotDrawFov"] = ui.add_bool_option(TRANSLATION['Draw FOV'], __submenus["AimAssist"], function(bool)
		if utils.show_info("aimdrawfov [on - off]") then ui.set_value(__options.bool["AimbotDrawFov"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") settings.Weapons["AimbotDrawFov"] = bool
	end, {"aimdrawfov"})

	__options.bool["Aimbot"] = ui.add_bool_option(TRANSLATION['Aimbot'], __submenus["AimAssist"], function(bool)
		if utils.show_info("aimbot [on - off]") then ui.set_value(__options.bool["Aimbot"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON")
		settings.Weapons["Aimbot"] = bool
		local entity
		system.thread(bool, "weapons_aimbot", function()
			if WEAPON.GET_WEAPONTYPE_GROUP(features.get_ped_weapon()) == enum.weapon_group.Melee then return end
			if ENTITY.IS_ENTITY_DEAD(features.player_ped(), false) == 0 then
				local fov = (settings.Weapons["AimbotFov"]) ^ 2
				local pos = features.get_player_coords()
				local move_to
				local distance = settings.Weapons["AimbotDistance"] * settings.Weapons["AimbotDistance"]
				local cent = features.get_screen_center()
				local res = features.get_screen_resolution()
				if settings.Weapons["AimbotDrawFov"] then
					local to = res:inverse()
					local points = vector3(cent.x, cent.y):points_on_circle(settings.Weapons["AimbotFov"], settings.Weapons["AimbotFov"])
					for _, v in ipairs(points)
					do
						GRAPHICS.DRAW_RECT(v.x * to.x, v.y * to.y, 2 * to.x, 2 * to.y, 255, 255, 255, 100, false)
					end
				end
				if not settings.Weapons["AimbotFollowTarget"] then
					entity = nil
				end
				if not entity then
					for _, v in ipairs(entities.get_peds())
					do
						if v ~= features.player_ped() and ENTITY.IS_ENTITY_DEAD(v, false) == 0 and ENTITY.IS_ENTITY_ON_SCREEN(v) == 1 and not (settings.General['Exclude Friends'] and
							features.is_friend(features.get_player_from_ped(v))) and not features.is_excluded(features.get_player_from_ped(v)) then
							local triggered
							if settings.Weapons["TargetPlayers"] and PED.IS_PED_A_PLAYER(v) == 1 then
								triggered = true
							elseif settings.Weapons["TargetEnemies"] and peds.is_ped_an_enemy(v) then
								triggered = true
							elseif settings.Weapons["TargetCops"] and features.compare(PED.GET_PED_TYPE(v), 6, 27) then
								triggered = true
							end
							local dist = features.get_entity_coords(v):sqrlen(pos)
							-- local dir = pos:direction_to(vector3(ENTITY.GET_ENTITY_COORDS(v, false)))
							local screen_pos = features.world_to_screen(ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(v, PED.GET_PED_BONE_INDEX(v, bone_id[settings.Weapons["AimBone"]])))
							local dist_to_sc = cent:sqrlen(vector3(res.x * screen_pos.x, res.y * screen_pos.y))
							if (triggered or settings.Weapons["TargetPeds"]) and dist < distance and dist_to_sc <= fov then
								entity = v
								if settings.Weapons["AimbotPrioritize"] == 0 then
									distance = dist
								else
									fov = dist_to_sc
								end
							end
						end
					end
				elseif entity and (ENTITY.IS_ENTITY_DEAD(entity, false) == 1 or ENTITY.DOES_ENTITY_EXIST(entity) == 0 or ENTITY.IS_ENTITY_ON_SCREEN(entity) == 0) then
					entity = nil
				end

				if entity then
					if settings.Weapons["AimbotWallCheck"] then
						local result = features.get_raycast_result(features.get_player_coords(), features.get_entity_coords(entity), features.player_ped(), 1)
						if result.didHit then entity = nil return end
					end
					local screen_pos = features.world_to_screen(ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(entity, PED.GET_PED_BONE_INDEX(entity, bone_id[settings.Weapons["AimBone"]])))
					if settings.Weapons["AimbotFollowTarget"] and PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) == 1 --[[and ENTITY.IS_ENTITY_ON_SCREEN(entity) == 1]] then
						local pos_on_screen = vector3(res.x * screen_pos.x, res.y * screen_pos.y)
						if pos_on_screen ~= vector3.zero() then
							local dist = pos_on_screen:len(cent)
							move_to = -(cent:direction_to(pos_on_screen) * dist) / 50
						end
					end
					if move_to then
						CAM.SET_GAMEPLAY_CAM_RELATIVE_HEADING(move_to.x)
						CAM.SET_GAMEPLAY_CAM_RELATIVE_PITCH(CAM.GET_GAMEPLAY_CAM_RELATIVE_PITCH() + move_to.y, 1)
					end
					local coord = vector3(ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(entity, PED.GET_PED_BONE_INDEX(entity, bone_id[settings.Weapons["AimBone"]])))
					if settings.Weapons["AimbotShowBox"] then
						features.draw_box_on_entity(entity, 0, 0, 255, 100)
					end
					PAD.DISABLE_CONTROL_ACTION(0, enum.input.ATTACK, true)
					PAD.DISABLE_CONTROL_ACTION(0, enum.input.ATTACK2, true)
					if not (PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.ATTACK) == 1 or PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.ATTACK2) == 1) then return end
					if not (coord == vector3.zero()) then
						if PED.IS_PED_IN_ANY_VEHICLE(entity, false) == 1 then
							coord.z = coord.z + .08
						end
						PED.SET_PED_SHOOTS_AT_COORD(features.player_ped(), coord.x, coord.y, coord.z, true)
					end
				end
			end
		end)
	end, {"aimbot"})

	__options.bool["AutoShoot"] = ui.add_bool_option(TRANSLATION['Auto shoot'], __submenus["AimAssist"], function(bool)
		if utils.show_info("autoshoot [on - off]") then ui.set_value(__options.bool["AutoShoot"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON")
		settings.Weapons["AutoShoot"] = bool 
		system.thread(bool, "weapons_auto_shoot",
		function()	
			if ENTITY.IS_ENTITY_DEAD(features.player_ped(), false) == 0 then
				local pos = features.get_player_coords()
				local entity
				local distance = settings.Weapons["AimbotDistance"] * settings.Weapons["AimbotDistance"]
				for _, v in ipairs(entities.get_peds())
				do
					if v ~= features.player_ped() and ENTITY.IS_ENTITY_DEAD(v, false) == 0 and not (settings.General['Exclude Friends'] and features.is_friend(features.get_player_from_ped(v)))
						and not features.is_excluded(features.get_player_from_ped(v)) then
						local triggered
						if settings.Weapons["TargetPlayers"] and PED.IS_PED_A_PLAYER(v) == 1 then
							triggered = true
						end
						if settings.Weapons["TargetEnemies"] and peds.is_ped_an_enemy(v) then
							triggered = true
						end
						if settings.Weapons["TargetCops"] and features.compare(PED.GET_PED_TYPE(v), 6, 27) then
							triggered = true
						end
						local dist = features.get_entity_coords(v):sqrlen(pos)
						if (triggered or settings.Weapons["TargetPeds"]) and dist < distance then
							entity = v
							distance = dist
						end
					end
				end
				if entity then
					local coord = vector3(ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(entity, PED.GET_PED_BONE_INDEX(entity, bone_id[settings.Weapons["AimBone"]])))
					if settings.Weapons["AimbotWallCheck"] then
						local result = features.get_raycast_result(features.get_player_coords(), coord, features.player_ped(), 1)
						if result.didHit then return end
					end
					if not (coord == vector3.zero()) then
						if PED.IS_PED_IN_ANY_VEHICLE(entity, false) == 1 then
							coord.z = coord.z + .08
						end
						if settings.Weapons["AimbotShowBox"] then
							features.draw_box_on_entity(entity, 0, 0, 255, 100)
						end
						PED.SET_PED_SHOOTS_AT_COORD(features.player_ped(), coord.x, coord.y, coord.z, true)
					end
				end
			end
		end)
	end, {"autoshoot"})
end

ui.add_separator(TRANSLATION["Modifiers"], __submenus["Weapons"])

__options.bool["RapidFire"] = ui.add_bool_option(TRANSLATION['Rapid fire'], __submenus["Weapons"], function(bool)
	if utils.show_info("rapidfire [on - off]") then ui.set_value(__options.bool["RapidFire"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Weapons['RapidFire'] = bool
	system.thread(bool, 'rapid_fire', function()
  		if Global.onscreen_keyboard then return end

		local weaponhash = features.get_ped_weapon()
		if WEAPON.GET_WEAPONTYPE_GROUP(weaponhash) == enum.weapon_group.Melee then
			return
		end
		WEAPON.REQUEST_WEAPON_ASSET(weaponhash, 31, 0)
		if WEAPON.HAS_WEAPON_ASSET_LOADED(weaponhash) == 0 then return end
		PAD.DISABLE_CONTROL_ACTION(0, enum.input.ATTACK, true)
		PAD.DISABLE_CONTROL_ACTION(0, enum.input.ATTACK2, true)
		if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.ATTACK) == 1 then
			local ped = features.player_ped()
			local weapo = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(ped, 1)
			local cam_dir = features.gameplay_cam_rot():rot_to_direction()
			local cam_pos = features.gameplay_cam_pos()
			local pos1 = cam_pos + (cam_dir * (cam_pos:len(features.get_entity_coords(weapo)) + 0.4))
			local pos2 = cam_pos + (cam_dir * 200)
			-- MISC.CLEAR_AREA_OF_PROJECTILES(pos1.x, pos1.y, pos1.z, 6, 0)
			MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos1.x, pos1.y, pos1.z, pos2.x, pos2.y, pos2.z, 5, true, weaponhash, ped, true, true, 24000)
			MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos1.x, pos1.y, pos1.z, pos2.x, pos2.y, pos2.z, 5, true, weaponhash, ped, true, true, 24000)
		end
	end)
end, {"rapidfire"})

__options.bool["PTFXGun"] = ui.add_bool_option(TRANSLATION["Particle FX gun"], __submenus["Weapons"], function(bool)
	if utils.show_info("ptfxgun [on - off]") then ui.set_value(__options.bool["PTFXGun"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Weapons["PTFXGun"] = bool
	system.thread(bool, 'weapons_ptfx_gun', function()
		if STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_rcbarry2") == 0 then
			STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_rcbarry2")
			return
		end
		if PED.IS_PED_SHOOTING(features.player_ped()) == 0 then return end
		local weapon = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(features.player_ped(), false)
		GRAPHICS.USE_PARTICLE_FX_ASSET("scr_rcbarry2")
		GRAPHICS._START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY_BONE("muz_clown", weapon, 0, 0, 0, 90, 0, 0, ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(weapon, "gun_muzzle"), .5, false, false, false)
	end)
end, {"ptfxgun"})

__options.bool["WeaponLaser"] = ui.add_bool_option(TRANSLATION["Aim laser"], __submenus["Weapons"], function(bool)
	if utils.show_info("aimlaser [on - off]") then ui.set_value(__options.bool["WeaponLaser"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Weapons["WeaponLaser"] = bool
	system.thread(bool, 'weapons_laser', function()
		if PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) == 1 then
			local weaponhash = features.get_ped_weapon()
			if WEAPON.GET_WEAPONTYPE_GROUP(weaponhash) == enum.weapon_group.Melee or WEAPON.GET_WEAPONTYPE_GROUP(weaponhash) == enum.weapon_group.Throwables then
				return
			end
			local weapon = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(features.player_ped(), false)
			local muzz_pos = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(weapon, ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(weapon, "gun_muzzle"))
			local start = features.gameplay_cam_pos()
			local end_pos = start + features.gameplay_cam_rot():rot_to_direction() * 1500
			local result = features.get_raycast_result(start, end_pos, weapon, -1)
			end_pos = result.didHit and result.endCoords or end_pos
			local color = settings.General["HudColorAimLaser"]
			GRAPHICS.DRAW_LINE(muzz_pos.x, muzz_pos.y, muzz_pos.z - .01, end_pos.x, end_pos.y, end_pos.z, color.r, color.g, color.b, color.a)
		end
	end)
end, {"aimlaser"})

__options.bool["WeaponsAlwaysHeatVision"] = ui.add_bool_option(TRANSLATION["Heat vision"], __submenus["Weapons"], function(bool)
	if utils.show_info("heatvision [on - off]") then ui.set_value(__options.bool["WeaponsAlwaysHeatVision"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Weapons["WeaponsAlwaysHeatVision"] = bool
	system.thread(bool, 'weapons_always_heat_vision', function()
		features.bypass_heat_vision(true)
		GRAPHICS.SET_SEETHROUGH(true)
		GRAPHICS._SEETHROUGH_SET_MAX_THICKNESS(10000)
	end)
	if not bool then
		features.bypass_heat_vision(false)
		GRAPHICS.SET_SEETHROUGH(false)
	end
end, {"heatvision"})

__options.bool["WeaponsHeatVision"] = ui.add_bool_option(TRANSLATION["Heat vision on aim"], __submenus["Weapons"], function(bool)
	if utils.show_info("heataim [on - off]") then ui.set_value(__options.bool["WeaponsHeatVision"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Weapons["WeaponsHeatVision"] = bool
	local is_on
	system.thread(bool, 'weapons_heat_vision', function()
		if system.is_thread_active('weapons_always_heat_vision') then return end
		if PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) == 1 then
			local weaponhash = features.get_ped_weapon()
			if WEAPON.GET_WEAPONTYPE_GROUP(weaponhash) == enum.weapon_group.Melee then
				return
			end
			GRAPHICS.SET_SEETHROUGH(true)
			GRAPHICS._SEETHROUGH_SET_MAX_THICKNESS(10000)
			features.bypass_heat_vision(true)
			is_on = true
		elseif is_on then
			GRAPHICS.SET_SEETHROUGH(false)
			is_on = false
		end
	end)
	if not bool and not system.is_thread_active('weapons_always_heat_vision') then
		features.bypass_heat_vision(false)
		GRAPHICS.SET_SEETHROUGH(false)
	end
end, {"heataim"})

__options.bool["WeaponsNightVision"] = ui.add_bool_option(TRANSLATION["Night vision on aim"], __submenus["Weapons"], function(bool)
	if utils.show_info("nightaim [on - off]") then ui.set_value(__options.bool["WeaponsNightVision"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Weapons["WeaponsNightVision"] = bool
	local is_on
	system.thread(bool, 'weapons_night_vision', function()
		if PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) == 1 then
			local weaponhash = features.get_ped_weapon()
			if WEAPON.GET_WEAPONTYPE_GROUP(weaponhash) == enum.weapon_group.Melee then
				return
			end
			GRAPHICS.SET_NIGHTVISION(true)
			features.bypass_heat_vision(true)
			if not is_on and GRAPHICS.GET_USINGNIGHTVISION() == 0 then
				AUDIO.PLAY_SOUND_FRONTEND(-1, "On", "GTAO_Vision_Modes_SoundSet", true)
			end
			is_on = true
		elseif is_on then
			GRAPHICS.SET_NIGHTVISION(false)
			if is_on and GRAPHICS.GET_USINGNIGHTVISION() == 1 then
				AUDIO.PLAY_SOUND_FRONTEND(-1, "Off", "GTAO_Vision_Modes_SoundSet", true)
			end
			is_on = false
		end
	end)
	if not bool then
		if GRAPHICS.GET_USINGNIGHTVISION() == 1 then
			AUDIO.PLAY_SOUND_FRONTEND(-1, "Off", "GTAO_Vision_Modes_SoundSet", true)
		end
		features.bypass_heat_vision(false)
		GRAPHICS.SET_NIGHTVISION(false)
	end
end, {"nightaim"})

do
	local types = {
		TRANSLATION["None"],
		HUD._GET_LABEL_TEXT("WT_SNIP_HVY2"),
		HUD._GET_LABEL_TEXT("WT_RPG"),
		HUD._GET_LABEL_TEXT("WT_MOLOTOV"),
		HUD._GET_LABEL_TEXT("WT_SNWBALL"),
		HUD._GET_LABEL_TEXT("WT_RAYPISTOL"),
		HUD._GET_LABEL_TEXT("WT_FIREWRK"),
		HUD._GET_LABEL_TEXT("WT_EMPL"),
		HUD._GET_LABEL_TEXT("WT_V_KHA_CA"),
		HUD._GET_LABEL_TEXT("LAZER")
	}
	local type = settings.Weapons["BulletChanger"]
	local hases = {
		177293209,
		-1312131151,
		615608432,
		126349499,
		-1355376991,
		2138347493,
		3676729658,
		1945616459,
		3800181289,
	}
	local wait = 0
	local ammo
	local selected
	__options.choose["BulletChanger"] = ui.add_choose(TRANSLATION["Bullet changer"], __submenus["Weapons"], false, types, function(int)
		if utils.show_info("bulletchange [choose]") then ui.set_value(__options.bool["BulletChanger"], settings.Weapons["BulletChanger"], true) return end
		utils.hud_sound("YES")
		settings.Weapons["BulletChanger"] = int
	end, {"bulletchange"})

	local function GetTime()
		local handle = memory.handle_to_pointer(features.player_ped())
		local addr = s_memory.get_memory_address(handle, s_memory.offsets.shoot_delay)
		return addr == 0 and .1 or memory.read_float(addr)
	end

	system.thread(true, 'bullet_changer', function()
  		if Global.onscreen_keyboard then return end

		if settings.Weapons["BulletChanger"] == 0 then
			if ammo then
				WEAPON.REMOVE_WEAPON_ASSET(ammo)
				ammo = nil
			end
			return
		end
		if selected ~= settings.Weapons["BulletChanger"] and ammo then
			WEAPON.REMOVE_WEAPON_ASSET(ammo)
		end
		selected = settings.Weapons["BulletChanger"]
		ammo = hases[settings.Weapons["BulletChanger"]]
		if WEAPON.HAS_WEAPON_ASSET_LOADED(ammo) == 0 then
			WEAPON.REQUEST_WEAPON_ASSET(ammo, 31, 0)
			return
		end
		PLAYER.DISABLE_PLAYER_FIRING(PLAYER.PLAYER_ID(), true)
		if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.ATTACK2) == 1 and PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) == 1 and wait < os.clock() then
			local ped = features.player_ped()
			local weapo = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(ped, 1)
			local cam_dir = features.gameplay_cam_rot():rot_to_direction()
			local cam_pos = features.gameplay_cam_pos()
			local pos1 = cam_pos + (cam_dir * (cam_pos:len(features.get_entity_coords(weapo)) + 0.4))
			local pos2 = cam_pos + (cam_dir * 200)
			MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos1.x, pos1.y, pos1.z, pos2.x, pos2.y, pos2.z, 5, true, ammo, ped, true, true, 24000)
			wait = os.clock() + GetTime()
		end

	end)
end

ui.add_separator(TRANSLATION["Flamethrower"], __submenus["Weapons"])

do
	__options.num["FlamethrowerScale"] = ui.add_num_option(TRANSLATION["Flamethrower scale"], __submenus["Weapons"], 1, 25, 1, function(int)
		if utils.show_info("flamethrowerscale [1 - 25]") then ui.set_value(__options.num["FlamethrowerScale"], settings.Weapons["FlamethrowerScale"], true) return end
		utils.hud_sound("YES") settings.Weapons["FlamethrowerScale"] = int
	end, {"flamethrowerscale"})
	__options.choose["Flamethrower"] = ui.add_choose(TRANSLATION["Flamethrower"], __submenus["Weapons"], true, {TRANSLATION["None"], TRANSLATION["Orange"], TRANSLATION["Green"]}, function(int)
		if utils.show_info("flamethrower [choose]") then ui.set_value(__options.choose["Flamethrower"], settings.Weapons["Flamethrower"], true) return end
		utils.hud_sound("YES") settings.Weapons["Flamethrower"] = int
	end, {"flamethrower"})
	local type = settings.Weapons["Flamethrower"]
	local flame
	local chip
	system.thread(true, 'weapons_flamethrower', function() 
		if settings.Weapons["FlamethrowerScale"] == 0 then
			if flame then
				GRAPHICS.REMOVE_PARTICLE_FX(flame, true)
				features.delete_entity(chip)
				STREAMING.REMOVE_NAMED_PTFX_ASSET("weap_xs_vehicle_weapons")
				flame = nil
				chip = nil
		    end
		  	return
		end
		if PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) == 1 then
			if STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("weap_xs_vehicle_weapons") == 0 then
			    STREAMING.REQUEST_NAMED_PTFX_ASSET("weap_xs_vehicle_weapons")
			    return
		  	end
			if not chip then
				local loaded, hash = features.request_model("prop_crisp_small")
				local pos = features.get_player_coords()
				chip = features.create_object(hash, pos)
				ENTITY.SET_ENTITY_COLLISION(chip, false, true)
				ENTITY.SET_ENTITY_ALPHA(chip, 0, false)
				STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
			end
			local pos_h = PED.GET_PED_BONE_COORDS(features.player_ped(), 57005, 0, 0, 0)
			ENTITY.SET_ENTITY_COORDS_NO_OFFSET(chip, pos_h.x, pos_h.y, pos_h.z, false, false, false)
			local rot = CAM.GET_GAMEPLAY_CAM_ROT(5)
			ENTITY.SET_ENTITY_ROTATION(chip, rot.x, rot.y, rot.z, 5, true)
			if flame == nil then
				GRAPHICS.USE_PARTICLE_FX_ASSET("weap_xs_vehicle_weapons")
				if settings.Weapons["Flamethrower"] == 1 then
					flame = GRAPHICS.START_PARTICLE_FX_LOOPED_ON_ENTITY("muz_xs_turret_flamethrower_looping", chip, 0, 0, 0, 0, 0, 0, settings.Weapons["FlamethrowerScale"], false, false, false)
				elseif settings.Weapons["Flamethrower"] == 2 then
					flame = GRAPHICS.START_PARTICLE_FX_LOOPED_ON_ENTITY("muz_xs_turret_flamethrower_looping_sf", chip, 0, 0, 0, 0, 0, 0, settings.Weapons["FlamethrowerScale"], false, false, false)
				end
				type = settings.Weapons["Flamethrower"]
			end
			if flame then
				GRAPHICS.SET_PARTICLE_FX_LOOPED_SCALE(flame, settings.Weapons["FlamethrowerScale"])
			end
    	end
	    if (flame and PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) == 0) or (flame and type ~= settings.Weapons["Flamethrower"] and PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) == 1) then
			GRAPHICS.REMOVE_PARTICLE_FX(flame, true)
			flame = nil
			features.delete_entity(chip)
			chip = nil
	    end
	end)
end

ui.add_separator(TRANSLATION["Guns"], __submenus["Weapons"])

__options.bool["DriveGun"] = ui.add_bool_option(TRANSLATION['Drive gun'], __submenus["Weapons"], function(bool)
	if utils.show_info("drivegun [on - off]") then ui.set_value(__options.bool["DriveGun"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Weapons['DriveGun'] = bool
	system.thread(bool, 'weapons_drivegun', function()
		if PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) == 1 and PED.IS_PED_SHOOTING(features.player_ped()) == 1 then
			local entity = features.get_aimed_entity()
			if entity == 0 then return end
			local veh
			local ped
			if ENTITY.IS_ENTITY_A_PED(entity) == 1 then
				veh = PED.GET_VEHICLE_PED_IS_IN(entity, false)
				ped = entity
			elseif ENTITY.IS_ENTITY_A_VEHICLE(entity) == 1 then
				veh = entity
			end
			if veh and not features.compare(veh, Global.created_preview, Global.created_preview2) then
				system.thread(true, 'seat_change_'..system.thread_count(), function(tick)
					if tick == 100 then return POP_THREAD end
					if ped and ped ~= features.player_ped() and veh ~= 0 then
						TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
					end
					features.request_control_once(veh) 
					PED.SET_PED_INTO_VEHICLE(features.player_ped(), veh, -1)
					if VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1, true) ~= features.player_ped() then return end
					return POP_THREAD
				end)
			end
		end
	end)
end, {"drivegun"})

do
	local entity
	local gunactive
	local distance
	__options.bool["PickUpGun"] = ui.add_bool_option(TRANSLATION['Pick up gun'], __submenus["Weapons"], function(bool)
		if utils.show_info("pickupgun [on - off]") then ui.set_value(__options.bool["PickUpGun"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON")
		settings.Weapons['PickUpGun'] = bool
		system.thread(bool, 'weapons_pickup_gun', function()
  			if Global.onscreen_keyboard then return end

			if PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) == 1 or (entity and PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.AIM) == 1) then
				if gunactive then return end
				if not entity then
					entity = features.get_aimed_entity()
					if entity == 0 then entity = nil return end
					if ENTITY.IS_ENTITY_A_PED(entity) == 1 and PED.IS_PED_IN_ANY_VEHICLE(entity, true) == 1 then
						entity = PED.GET_VEHICLE_PED_IS_IN(entity, false)
					end
					local pos = features.gameplay_cam_pos()
					distance = pos:len(features.get_entity_coords(entity))
				end
				PAD.DISABLE_CONTROL_ACTION(0, enum.input.WEAPON_WHEEL_NEXT, true)
				PAD.DISABLE_CONTROL_ACTION(0, enum.input.WEAPON_WHEEL_PREV, true)
				PAD.DISABLE_CONTROL_ACTION(0, enum.input.MULTIPLAYER_INFO, true)
				PAD.DISABLE_CONTROL_ACTION(0, enum.input.SPRINT, true)
				PAD.DISABLE_CONTROL_ACTION(0, enum.input.JUMP, true)
				PAD.DISABLE_CONTROL_ACTION(0, enum.input.FRONTEND_RS, true)
				features.request_control_once(entity)
				local radmult = 10
				if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.SPRINT) == 1 then
					radmult = 1
				end
				local rot = features.get_entity_rot(entity)
				if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.WEAPON_WHEEL_NEXT) == 1 then
					if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.FRONTEND_RS) == 1 then
						ENTITY.SET_ENTITY_ROTATION(entity, rot.x-1*radmult, rot.y, rot.z, 2, true)
					elseif PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.JUMP) == 1 then
						ENTITY.SET_ENTITY_ROTATION(entity, rot.x, rot.y-1*radmult, rot.z, 2, true)
					elseif PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.MULTIPLAYER_INFO) == 1 then
						ENTITY.SET_ENTITY_ROTATION(entity, rot.x, rot.y, rot.z-1*radmult, 2, true)
					else
						distance = (distance - radmult) < 5 and 5 or distance - radmult
					end
				elseif PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.WEAPON_WHEEL_PREV) == 1 then
					if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.FRONTEND_RS) == 1 then
						ENTITY.SET_ENTITY_ROTATION(entity, rot.x+1*radmult, rot.y, rot.z, 2, true)
					elseif PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.JUMP) == 1 then
						ENTITY.SET_ENTITY_ROTATION(entity, rot.x, rot.y+1*radmult, rot.z, 2, true)
					elseif PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.MULTIPLAYER_INFO) == 1 then
						ENTITY.SET_ENTITY_ROTATION(entity, rot.x, rot.y, rot.z+1*radmult, 2, true)
					else
						distance = distance + radmult
					end
				end
		        if settings.General["ShowControls"] and Instructional:New() then
			    	Instructional.AddButton(enum.input.WEAPON_WHEEL_NEXT, TRANSLATION["Towards me"])
			    	Instructional.AddButton(enum.input.WEAPON_WHEEL_PREV, TRANSLATION["Outwards me"])
			    	Instructional.AddButton(enum.input.FRONTEND_RS, TRANSLATION["Pitch"])
			    	Instructional.AddButton(enum.input.JUMP, TRANSLATION["Roll"])
			    	Instructional.AddButton(enum.input.MULTIPLAYER_INFO, TRANSLATION["Yaw"])
			    	Instructional.AddButton(enum.input.JUMP, TRANSLATION["Precision"])
			    	Instructional:BackgroundColor(0, 0, 0, 80)
			    	Instructional:Draw()
			    end
				local dir = features.gameplay_cam_rot():rot_to_direction()
				local camcoord = features.gameplay_cam_pos()
				local target_pos = camcoord + dir * distance
				ENTITY.SET_ENTITY_COORDS_NO_OFFSET(entity, target_pos.x, target_pos.y, target_pos.z, false, false, false)
				if PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, enum.input.ATTACK2) == 1 then
					if ENTITY.IS_ENTITY_A_PED(entity) == 1 then
						PED.SET_PED_CAN_RAGDOLL(entity, true)
						PED.SET_PED_TO_RAGDOLL(entity, 5000, 5000, 0, true, true, false)
					end
					local force = dir * 500
					ENTITY.FREEZE_ENTITY_POSITION(entity, false)
					features.set_entity_velocity(entity, force.x, force.y, force.z)
					gunactive = true
				end
				return
			elseif entity then
				entity = nil
				return
			end
			gunactive = false
		end)
	end, {"pickupgun"})
end

do
	local entity
	local gunactive
	local distance
	__options.bool["GravityGun"] = ui.add_bool_option(TRANSLATION['Gravity gun'], __submenus["Weapons"], function(bool)
		if utils.show_info("gravitygun [on - off]") then ui.set_value(__options.bool["GravityGun"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON")
		settings.Weapons['GravityGun'] = bool
		system.thread(bool, 'weapons_gravity_gun', function()
  			if Global.onscreen_keyboard then return end

			if PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) == 1 or (entity and PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.AIM) == 1) then
				if not entity then
					entity = features.get_aimed_entity()
					if entity == 0 then entity = nil return end
					if ENTITY.IS_ENTITY_A_PED(entity) == 1 and PED.IS_PED_IN_ANY_VEHICLE(entity, true) == 1 then
						entity = PED.GET_VEHICLE_PED_IS_IN(entity, false)
					end
					distance = 10
				end
				if gunactive then return end
				PAD.DISABLE_CONTROL_ACTION(0, enum.input.WEAPON_WHEEL_NEXT, true)
		        PAD.DISABLE_CONTROL_ACTION(0, enum.input.WEAPON_WHEEL_PREV, true)
		        PAD.DISABLE_CONTROL_ACTION(0, enum.input.SPRINT, true)
		      	local radmult = 10
		        if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.SPRINT) == 1 then
		            radmult = 1
		        end
		        if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.WEAPON_WHEEL_NEXT) == 1 then
		          	distance = distance - radmult
		          	if distance < 5 then distance = 5 end
		        elseif PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.WEAPON_WHEEL_PREV) == 1 then
		          	distance = distance + radmult
		        end
		        local dir = features.gameplay_cam_rot():rot_to_direction()
				local camcoord = features.gameplay_cam_pos()
				local target_pos = camcoord + dir * distance
				GRAPHICS._DRAW_SPHERE(target_pos.x, target_pos.y, target_pos.z, 0.2, 255, 0, 255, 0.5)
				local pos = features.get_entity_coords(entity)
				local force_to = (target_pos - pos) * 3
				ENTITY.FREEZE_ENTITY_POSITION(entity, false)
				features.request_control_once(entity)
				features.set_entity_velocity(entity, force_to.x, force_to.y, force_to.z)
				if PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, enum.input.ATTACK2) == 1 then
					if ENTITY.IS_ENTITY_A_PED(entity) == 1 then
						PED.SET_PED_CAN_RAGDOLL(entity, true)
						PED.SET_PED_TO_RAGDOLL(entity, 5000, 5000, 0, true, true, false)
					end
					local force = dir * 500
					entities.request_control(entity, function()
						ENTITY.FREEZE_ENTITY_POSITION(entity, false)
		          		features.set_entity_velocity(entity, force.x, force.y, force.z)
			         end)
		          gunactive = true
		        end
        		return
			elseif entity then
				entity = nil
				return
			end
			gunactive = false
		end)
	end, {"gravitygun"})
end

__options.bool["GrappleHookGun"] = ui.add_bool_option(TRANSLATION["Grapple hook gun"], __submenus["Weapons"], function(bool)
	if utils.show_info("grapplehook [on - off]") then ui.set_value(__options.bool["GrappleHookGun"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Weapons["GrappleHookGun"] = bool
	system.thread(bool, 'weapons_grapple_hook', function()
		if vehicles.get_player_vehicle() ~= 0 or PED.IS_PED_SHOOTING(features.player_ped()) == 0 then return end
		local start = features.gameplay_cam_pos()
		local end_pos = start + features.gameplay_cam_rot():rot_to_direction() * 1500
		local result = features.get_raycast_result(start, end_pos, features.player_ped(), 1+2+4+8+16)
		local pos = result.endCoords
		if pos == vector3.zero() then return end
		if ENTITY.DOES_ENTITY_EXIST(result.hitEntity) and not (ENTITY.IS_ENTITY_A_VEHICLE(result.hitEntity) == 1 or ENTITY.IS_ENTITY_A_PED(result.hitEntity) == 1) then
			result.hitEntity = 0
		end
		features.teleport2(features.player_ped(), (features.get_player_coords() + vector3.up(1.5)):get())
		system.thread(true, 'hook_gun', function()
  		if Global.onscreen_keyboard then return end

			if vehicles.get_player_vehicle() ~= 0 or not settings.Weapons["GrappleHookGun"] or PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, enum.input.VEH_EXIT) == 1 then return POP_THREAD end
			TASK.TASK_SKY_DIVE(features.player_ped(), true)
			if ENTITY.DOES_ENTITY_EXIST(result.hitEntity) == 1 then
				features.oscillate_to_entity(features.player_ped(), result.hitEntity, 10)
			else
				features.oscillate_to_coord(features.player_ped(), pos, 5)
			end
			if not (result.hitEntity ~= 0 and ENTITY.DOES_ENTITY_EXIST(result.hitEntity) == 0) and (ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(features.player_ped()) == 0 and
				((ENTITY.DOES_ENTITY_EXIST(result.hitEntity) == 1 and features.get_player_coords():sqrlen(features.get_entity_coords(result.hitEntity)) > 4) or features.get_player_coords():sqrlen(pos) > 4)) then return end
			TASK.CLEAR_PED_TASKS_IMMEDIATELY(features.player_ped())
			features.set_entity_velocity(features.player_ped(), 0, 0, 0)
			return POP_THREAD
		end)
	end)
end, {"grapplehook"})

do
	local vehs = {}
	for i, v in ipairs(vehicles.models) do
		insert(vehs, v[3])
	end

	local curr_model
	local spawned_vehs = {}
	__options.choose["VehicleGun"] = ui.add_choose(TRANSLATION["Vehicle gun"], __submenus["Weapons"], true, vehs, function(int)
		if utils.show_info("vehgun [choose]") then ui.set_value(__options.choose["VehicleGun"], settings.Weapons["VehicleGun"], true) return end
		utils.hud_sound("YES") settings.Weapons["VehicleGun"] = int
	end, {"vehgun"})
	__options.bool["VehicleGunEnabled"] = ui.add_bool_option(TRANSLATION["Enable vehicle gun"], __submenus["Weapons"], function(bool)
		if utils.show_info("vehiclegun [on - off]") then ui.set_value(__options.bool["VehicleGunEnabled"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") settings.Weapons["VehicleGunEnabled"] = bool
	end, {"vehiclegun"})

	system.thread(true, 'weapons_vehicle_gun', function()
		if not settings.Weapons["VehicleGunEnabled"]then return end
		local model = settings.Weapons["VehicleGun"] + 1
		if not curr_model then
			if features.request_model(vehicles.models[model][2]) == 0 then return end
			curr_model = model
		elseif curr_model ~= model then
			STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(vehicles.models[curr_model][2])
			curr_model = nil
			return
		end
		if PED.IS_PED_SHOOTING(features.player_ped()) == 0 then return end
		local pos = features.get_offset_from_player_coords(vector3(0, 2, 1))
		local rot = features.gameplay_cam_rot()
		local dir = rot:rot_to_direction() * 500
		local veh = vehicles.spawn_vehicle(vehicles.models[model][2], pos + vector3.up(10))
		entities.request_control(veh, function()
			--vehicles.set_godmode(veh, true)
			ENTITY.SET_ENTITY_ALPHA(veh, 50, false)
			ENTITY.SET_ENTITY_COLLISION(veh, false, true)
			ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, pos.x, pos.y, pos.z, false, false, false)
			ENTITY.SET_ENTITY_ROTATION(veh, rot.x, rot.y, rot.z, 2, true)
			features.set_entity_velocity(veh, dir.x, dir.y, dir.z)
		end)
		spawned_vehs[veh] = clock()
	end)

	system.thread(true, 'weapons_vehicle_tracker', function()
		for k, v in pairs(spawned_vehs) do
			local waittime = .1
			local class = VEHICLE.GET_VEHICLE_CLASS(k)
			if class == 16 then
				waittime = .3
			end
			if v + 5 < clock() then
				features.delete_entity(k)
				spawned_vehs[k] = nil
				return
			end
			entities.request_control(k, function()
				if v + waittime < clock() then
					ENTITY.SET_ENTITY_COLLISION(k, true, true)
				end
				if v + .3 < clock() then
					ENTITY.SET_ENTITY_ALPHA(k, 255, false)
				elseif v + .2 < clock() then
					ENTITY.SET_ENTITY_ALPHA(k, 160, false)
				elseif v + .1 < clock() then
					ENTITY.SET_ENTITY_ALPHA(k, 89, false)
				end
			end)
		end
	end)
end

do
	local guns = {}
	function guns.delete(ent)
		if ENTITY.DOES_ENTITY_EXIST(ent) == 0 then return end
		features.delete_entity(ent)
	end
	function guns.push(ent, force)
		if ENTITY.DOES_ENTITY_EXIST(ent) == 0 then return end
		entities.request_control(ent, function()
			if ENTITY.IS_ENTITY_A_PED(ent) == 1 then
				PED.SET_PED_CAN_RAGDOLL(ent, true)
				PED.SET_PED_TO_RAGDOLL(ent, 5000, 5000, 0, true, true, false)
			end
			ENTITY.FREEZE_ENTITY_POSITION(ent, false)
			features.set_entity_velocity(ent, force.x, force.y, force.z)
		end)
	end
	function guns.explode(ent)
		if ENTITY.DOES_ENTITY_EXIST(ent) == 0 then
			local start = features.gameplay_cam_pos()
			local end_pos = start + features.gameplay_cam_rot():rot_to_direction() * 1500
			local result = features.get_raycast_result(start, end_pos, features.player_ped())
			local pos = result.endCoords
			if pos == vector3.zero() then return end
			FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, enum.explosion.ROCKET, 10, true, false, 1.0, false)
			return
		end
		local pos = features.get_entity_coords(ent)
		if pos == vector3.zero() then return end
		FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, enum.explosion.ROCKET, 10, true, false, 1.0, false)
		if ENTITY.IS_ENTITY_A_VEHICLE(ent) == 1 then
			entities.request_control(ent, function()
				vehicles.set_godmode(ent, false)
				NETWORK.NETWORK_EXPLODE_VEHICLE(ent, true, false, PLAYER.PLAYER_ID())
			end)
		end
	end
	function guns.paint(ent)
		if ENTITY.DOES_ENTITY_EXIST(ent) == 0 then return end
		if ENTITY.IS_ENTITY_A_VEHICLE(ent) == 1 then
			entities.request_control(ent, function()
				local p = random(1, #vehicles.colors)
				VEHICLE.SET_VEHICLE_MOD_KIT(ent, 0)
				VEHICLE.SET_VEHICLE_COLOURS(ent, 160, 160)
				VEHICLE.SET_VEHICLE_EXTRA_COLOURS(ent, 160, 160)
				VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(ent, vehicles.colors[p][1], vehicles.colors[p][2], vehicles.colors[p][3])
				VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(ent, vehicles.colors[p][1], vehicles.colors[p][2], vehicles.colors[p][3])
			    VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(ent, vehicles.colors[p][1], vehicles.colors[p][2], vehicles.colors[p][3])
			    VEHICLE._SET_VEHICLE_NEON_LIGHTS_COLOUR(ent, vehicles.colors[p][1], vehicles.colors[p][2], vehicles.colors[p][3])
			end)
		end
	end
	function guns.revive(ent)
		if ENTITY.DOES_ENTITY_EXIST(ent) == 0 then return end
		if ENTITY.IS_ENTITY_A_PED(ent) == 1 and ENTITY.IS_ENTITY_DEAD(ent, false) == 1 then
			peds.revive(ent)
		end
	end
	function guns.soul_switch(ent)
		if ENTITY.DOES_ENTITY_EXIST(ent) == 0 then return end
		if ENTITY.IS_ENTITY_A_PED(ent) == 1 and PED.IS_PED_A_PLAYER(ent) == 0 then
			local weapon = peds.get_weapons()
			ENTITY.SET_ENTITY_HEALTH(ent, 200, 0)
            ENTITY.SET_ENTITY_MAX_HEALTH(ent, 400)
            PED.RESURRECT_PED(ent)
            PED.REVIVE_INJURED_PED(ent)
            ENTITY.SET_ENTITY_HEALTH(ent, 200, 0)
            PED.SET_PED_GENERATES_DEAD_BODY_EVENTS(ent, false)
            if PED.IS_PED_IN_ANY_VEHICLE(ent, false) == 0 then
            	TASK.CLEAR_PED_TASKS_IMMEDIATELY(ent)
            end
			PLAYER.CHANGE_PLAYER_PED(PLAYER.PLAYER_ID(), ent, true, true)
			peds.set_weapons(weapon)
		end
	end
	-- function guns.teleport()
	-- 	local pos = features.get_bullet_impact()
	-- 	if pos == vector3.zero() then return end
	-- 	features.teleport(features.player_ped(), pos.x, pos.y, pos.z)
	-- end
	function guns.teleport_aim()
		local start = features.gameplay_cam_pos()
		local end_pos = start + features.gameplay_cam_rot():rot_to_direction() * 1500
		local result = features.get_raycast_result(start, end_pos, features.player_ped())
		local pos = result.endCoords
		if pos == vector3.zero() then return end
		features.teleport2(features.player_ped(), pos.x, pos.y, pos.z)
	end
	function guns.airstrike()
		local start = features.gameplay_cam_pos()
		local end_pos = start + features.gameplay_cam_rot():rot_to_direction() * 1500
		local result = features.get_raycast_result(start, end_pos, features.player_ped())
		local pos = result.endCoords
		if pos == vector3.zero() then return end
		pos = pos:move_towards(features.get_player_coords(), 1) + vector3.up(1)
		MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 100, pos.x, pos.y, pos.z, 5, true, utils.joaat("weapon_rpg"), features.player_ped(), true, true, 5000)
	end

	local action = {TRANSLATION["None"], TRANSLATION["On aim"], TRANSLATION["On shoot"]}

	ui.add_separator(TRANSLATION["Choose action"], __submenus["Weapons"])
	__options.choose["DeleteGun"] = ui.add_choose(TRANSLATION["Delete gun"], __submenus["Weapons"], true, action, function(int)
		if utils.show_info("vehiclegun [choose]") then ui.set_value(__options.choose["DeleteGun"], settings.Weapons["DeleteGun"], true) return end
		utils.hud_sound("YES") settings.Weapons["DeleteGun"] = int
	end, {"delgun"})
	__options.choose["PushGun"] = ui.add_choose(TRANSLATION["Push gun"], __submenus["Weapons"], true, action, function(int)
		if utils.show_info("pushgun [choose]") then ui.set_value(__options.choose["PushGun"], settings.Weapons["PushGun"], true) return end
		utils.hud_sound("YES") settings.Weapons["PushGun"] = int
	end, {"pushgun"})
	__options.choose["ExplodeGun"] = ui.add_choose(TRANSLATION["Explode gun"], __submenus["Weapons"], true, action, function(int)
		if utils.show_info("explodegun [choose]") then ui.set_value(__options.choose["ExplodeGun"], settings.Weapons["ExplodeGun"], true) return end
		utils.hud_sound("YES") settings.Weapons["ExplodeGun"] = int
	end, {"explodegun"})
	__options.choose["PaintGun"] = ui.add_choose(TRANSLATION["Paint gun"], __submenus["Weapons"], true, action, function(int)
		if utils.show_info("paintgun [choose]") then ui.set_value(__options.choose["PaintGun"], settings.Weapons["PaintGun"], true) return end
		utils.hud_sound("YES") settings.Weapons["PaintGun"] = int
	end, {"paintgun"})
	__options.choose["ReviveGun"] = ui.add_choose(TRANSLATION["Revive gun"], __submenus["Weapons"], true, action, function(int)
		if utils.show_info("revivegun [choose]") then ui.set_value(__options.choose["ReviveGun"], settings.Weapons["ReviveGun"], true) return end
		utils.hud_sound("YES") settings.Weapons["ReviveGun"] = int
	end, {"revivegun"})
	__options.choose["SoulSwitchGun"] = ui.add_choose(TRANSLATION["Soul switch gun"], __submenus["Weapons"], true, action, function(int)
		if utils.show_info("soulgun [choose]") then ui.set_value(__options.choose["SoulSwitchGun"], settings.Weapons["SoulSwitchGun"], true) return end
		utils.hud_sound("YES") settings.Weapons["SoulSwitchGun"] = int
	end, {"soulgun"})
	__options.choose["TeleportGun"] = ui.add_choose(TRANSLATION["Teleport gun"], __submenus["Weapons"], true, action, function(int)
		if utils.show_info("tpgun [choose]") then ui.set_value(__options.choose["TeleportGun"], settings.Weapons["TeleportGun"], true) return end
		utils.hud_sound("YES") settings.Weapons["TeleportGun"] = int
	end, {"tpgun"})
	__options.choose["AirstrikeGun"] = ui.add_choose(TRANSLATION["Airstrike gun"], __submenus["Weapons"], true, action, function(int)
		if utils.show_info("strikegun [choose]") then ui.set_value(__options.choose["AirstrikeGun"], settings.Weapons["AirstrikeGun"], true) return end
		utils.hud_sound("YES") settings.Weapons["AirstrikeGun"] = int
	end, {"strikegun"})

	system.thread(true, 'weapons_guns', function()
		if STREAMING.IS_PLAYER_SWITCH_IN_PROGRESS() == 1 then return end

		if WEAPON.HAS_WEAPON_ASSET_LOADED(-1312131151) == 0 then
			WEAPON.REQUEST_WEAPON_ASSET(-1312131151, 31, 0)
		end
		if PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) == 0 and PED.IS_PED_SHOOTING(features.player_ped()) == 0 then return end

		if settings.Weapons["TeleportGun"] == 1 then
			guns.teleport_aim()
		elseif settings.Weapons["TeleportGun"] == 2 and PED.IS_PED_SHOOTING(features.player_ped()) == 1 then
			guns.teleport_aim()
		end

		if settings.Weapons["AirstrikeGun"] == 1 then
			guns.airstrike()
		elseif settings.Weapons["AirstrikeGun"] == 2 and PED.IS_PED_SHOOTING(features.player_ped()) == 1 then
			guns.airstrike()
		end

		local ent = features.get_aimed_entity()
		local ped = ent
		local cam_dir = features.gameplay_cam_rot():rot_to_direction()
		if ENTITY.DOES_ENTITY_EXIST(ent) == 1 and ENTITY.IS_ENTITY_A_PED(ent) == 1 and PED.IS_PED_IN_ANY_VEHICLE(ent, true) == 1 then
			ent = PED.GET_VEHICLE_PED_IS_IN(ent, false)
		end

		if settings.Weapons["ReviveGun"] == 1 then
			guns.revive(ped)
		end
		if settings.Weapons["SoulSwitchGun"] == 1 then
			guns.soul_switch(ped)
		end
		if settings.Weapons["PaintGun"] == 1 then
			guns.paint(ent)
		end
		if settings.Weapons["ExplodeGun"] == 1 then
			guns.explode(ent)
		end
		if settings.Weapons["PushGun"] == 1 then
			guns.push(ent, cam_dir * 200)
		end
		if settings.Weapons["DeleteGun"] == 1 then
			guns.delete(ent)
		end

		if PED.IS_PED_SHOOTING(features.player_ped()) == 0 then return end

		if settings.Weapons["ReviveGun"] == 2 then
			guns.revive(ped)
		end
		if settings.Weapons["SoulSwitchGun"] == 2 then
			guns.soul_switch(ped)
		end
		if settings.Weapons["PaintGun"] == 2 then
			guns.paint(ent)
		end
		if settings.Weapons["ExplodeGun"] == 2 then
			guns.explode(ent)
		end
		if settings.Weapons["PushGun"] == 2 then
			guns.push(ent, cam_dir * 200)
		end
		if settings.Weapons["DeleteGun"] == 2 then
			guns.delete(ent)
		end
	end)
end

---------------------------------------------------------------------------------------------------------------------------------
-- Misc
---------------------------------------------------------------------------------------------------------------------------------
__submenus["Misc"] = ui.add_submenu(TRANSLATION["Misc"])
__suboptions["Misc"] = ui.add_sub_option(TRANSLATION["Misc"], __submenus["MainSub"], __submenus["Misc"])

-- local train_models = {
--     utils.joaat("metrotrain"), utils.joaat("freight"), utils.joaat("freightcar"), utils.joaat("freightcar2"), utils.joaat("freightcont1"), utils.joaat("freightcont2"), utils.joaat("freightgrain"), utils.joaat("tankercar")
-- }
-- system.log('Imagined Menu', 'Loading trains')
-- system.thread(true, 'load_trains', function()
-- 	for _, v in ipairs(train_models)
-- 	do
-- 		if features.request_model(v) == 0 then
-- 			return
-- 		end
-- 	end
-- 	system.log('Imagined Menu', 'Trains loaded')
-- 	return POP_THREAD
-- end)

__submenus["TrainDriver"] = ui.add_submenu(TRANSLATION["Train driver"])
__suboptions["TrainDriver"] = ui.add_sub_option(TRANSLATION["Train driver"], __submenus["Misc"], __submenus["TrainDriver"])

-- do
-- 	local function create_train(variation, pos, direction, inside)
-- 		local train = VEHICLE.CREATE_MISSION_TRAIN(variation, pos.x, pos.y, pos.z, false)
-- 		local carriages = {}
--     for i = 1, 100 do
--         local cart = VEHICLE.GET_TRAIN_CARRIAGE(train, i)
--         if cart == 0 then
--             break
--         end
--         insert(carriages, cart)
--     end
--     VEHICLE.SET_TRAIN_CRUISE_SPEED(train, 10)
--     VEHICLE.SET_TRAIN_SPEED(train, 10)
--     if inside then
--     	PED.SET_PED_INTO_VEHICLE(features.player_ped(), train, -1)
--     end
-- 	end

-- 	local trains = {"Long train"}
-- 	local train_types = {
-- 		[0] = 23,
-- 	}

-- 	__options.choose["CreateTrain"] = ui.add_choose(TRANSLATION["Create train"], __submenus["TrainDriver"], false, trains, function(type)  
-- 		create_train(type, features.get_player_coords(), nil, true)
-- 	end)
-- end

do
	local opt
	local opt2
	local train
	__options.bool["TrainsAlot"] = ui.add_bool_option(TRANSLATION["Trains alot"], __submenus["TrainDriver"], function(bool)
		if utils.show_info("trainsalot [on - off]") then ui.set_value(__options.bool["TrainsAlot"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON")
		settings.Misc['TrainsAlot'] = bool
		if not bool then
			VEHICLE.SET_RANDOM_TRAINS(false)
		end
		system.thread(bool, 'misc_trains', function()
			VEHICLE.SET_RANDOM_TRAINS(true)
		end)
	end, {"trainsalot"})

	__options.click["Drive nearby train"] = ui.add_click_option(TRANSLATION["Drive nearby train"], __submenus["TrainDriver"], function()
		if utils.show_info("drivetrain") then return end
		local dist
		local veh
		for _, v in ipairs(entities.get_vehs())
		do
			local model = ENTITY.GET_ENTITY_MODEL(v)
			if (model == utils.joaat("freight") or model == utils.joaat("metrotrain")) and VEHICLE.GET_TRAIN_CARRIAGE(v, 1) ~= 0 then
				local distance = features.get_entity_coords(v):sqrlen(features.get_player_coords())
				if dist and dist > distance or not dist then
					veh = v
					dist = distance
				end
			end
		end
		if not veh then system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["No nearby trains found"], settings.General["HudColorNotifyError"]) return utils.hud_sound("ERROR") end
		system.thread(true, 'seat_change_'..system.thread_count(), function(tick)
			if tick == 100 then return POP_THREAD end
			features.request_control_once(veh)
			local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1, true)
			if ped and ped ~= features.player_ped() then
				TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
			end
			PED.SET_PED_INTO_VEHICLE(features.player_ped(), veh, -1)
			if VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1, true) ~= features.player_ped() then return end
			return POP_THREAD
		end)
	end, {"drivetrain"})

	__options.bool["TrainControl"] = ui.add_bool_option(TRANSLATION["Train control"], __submenus["TrainDriver"], function(bool)
		if utils.show_info("traincontrol [on - off]") then ui.set_value(__options.bool["TrainControl"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON")
		settings.Misc['TrainControl'] = bool
		if not bool then
			train = nil
		end
		system.thread(bool, 'misc_train_driver', function()
			train = vehicles.get_player_vehicle()
			if VEHICLE.IS_THIS_MODEL_A_TRAIN(ENTITY.GET_ENTITY_MODEL(train)) == 0 or VEHICLE.GET_TRAIN_CARRIAGE(train, 1) == 0 then train = nil return end
			if not __options.num["TrainSpeed"] then return end
			entities.request_control(train, function()
				local speed = ui.get_value(__options.num["TrainSpeed"])
				speed = MISC.SHOULD_USE_METRIC_MEASUREMENTS() == 1 and speed * 0.2777778 or speed * 0.44704
		    	if speed ~= 0 or ENTITY.GET_ENTITY_SPEED(train) > 0 then VEHICLE.SET_TRAIN_SPEED(train, speed) end
				VEHICLE.SET_TRAIN_CRUISE_SPEED(train, speed)
		    end)
		end)
	end, {"traincontrol"})

	system.thread(true, 'misc_train_speed', function()
		if settings.Misc['TrainControl'] and not __options.num["TrainSpeed"] and train then
			__options.num["TrainSpeed"] = ui.add_float_option(TRANSLATION["Set speed"]..' '..(MISC.SHOULD_USE_METRIC_MEASUREMENTS() == 1 and "km/h" or "mph"), __submenus["TrainDriver"], -9999999999, 9999999999, 1, 2, function()
				if utils.show_info("trainspeed [-9999999999.0 - 9999999999.0]") then return end
				if train then
					utils.hud_sound("YES")
			    else
			    	utils.hud_sound("ERROR")
				end
			end, {"trainspeed"})
			__options.bool["TrainDerail"] = ui.add_bool_option(TRANSLATION["Derail"], __submenus["TrainDriver"], function(bool)
				if utils.show_info("trainspeed [on - off]") then ui.set_value(__options.bool["TrainDerail"], not bool, true) return end
				utils.hud_sound("TOGGLE_ON")
				if train then
					VEHICLE.SET_RENDER_TRAIN_AS_DERAILED(train, bool)
				end
			end, {"derailtrain"})
			__options.click["ExitTrain"] = ui.add_click_option(TRANSLATION["Exit train"], __submenus["TrainDriver"], function()
				if utils.show_info("exittrain") then return end
				utils.hud_sound("SELECT") TASK.CLEAR_PED_TASKS_IMMEDIATELY(features.player_ped())
			end, {"exittrain"})
		elseif __options.num["TrainSpeed"] and (not settings.Misc['TrainControl'] or not train) then
			ui.remove(__options.num["TrainSpeed"])
			ui.remove(__options.bool["TrainDerail"])
			ui.remove(__options.click["ExitTrain"])
			__options.bool["TrainDerail"] = nil
			__options.num["TrainSpeed"] = nil
			__options.click["ExitTrain"] = nil
		end
	end)
end

__submenus["ModderDetectionNotify"] = ui.add_submenu(TRANSLATION["Notify on modder detection"])
__suboptions["ModderDetectionNotify"] = ui.add_sub_option(TRANSLATION["Notify on modder detection"], __submenus["Misc"], __submenus["ModderDetectionNotify"])

for i = 0, 23
do
	if i == 13 then ui.add_separator(TRANSLATION["Script detections"], __submenus["ModderDetectionNotify"]) end
	__options.choose["ModderDetection"..i] = ui.add_choose(DetectionFlags(i), __submenus["ModderDetectionNotify"], true, {TRANSLATION["None"], TRANSLATION["Notify"], TRANSLATION["Announce in chat"], concat({TRANSLATION["Notify"], TRANSLATION["and"], TRANSLATION["Announce in chat"]}, ' ')}, function(int)
		if utils.show_info("modderdetect"..i) then ui.set_value(__options.choose["ModderDetection"..i], settings.General["ModderDetection"..i], true) return end
		utils.hud_sound("YES")
		settings.General["ModderDetection"..i] = int
	end, {"modderdetect"..i})
end

__submenus["Reactions"] = ui.add_submenu(TRANSLATION["Reactions"])
__suboptions["Reactions"] = ui.add_sub_option(TRANSLATION["Reactions"], __submenus["Misc"], __submenus["Reactions"])

ui.add_separator(TRANSLATION["On report"] ,__submenus["Reactions"])

__options.bool["OnReportKick"] = ui.add_bool_option(TRANSLATION["Kick"], __submenus["Reactions"], function(bool)
	if utils.show_info("onreportkick [on - off]") then ui.set_value(__options.bool["OnReportKick"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Misc['OnReportKick'] = bool
end, {"onreportkick"})
__options.bool["OnReportCrash"] = ui.add_bool_option(TRANSLATION["Crash"], __submenus["Reactions"], function(bool)
	if utils.show_info("onreportcrash [on - off]") then ui.set_value(__options.bool["OnReportCrash"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Misc['OnReportCrash'] = bool
end, {"onreportcrash"})
__options.bool["OnReportSendChat"] = ui.add_bool_option(TRANSLATION["Send chat"], __submenus["Reactions"], function(bool)
	if utils.show_info("onreportchat [on - off]") then ui.set_value(__options.bool["OnReportSendChat"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Misc['OnReportSendChat'] = bool
end, {"onreportchat"})

ui.add_separator(TRANSLATION["On votekick"] ,__submenus["Reactions"])

__options.bool["OnVotekickKick"] = ui.add_bool_option(TRANSLATION["Kick"], __submenus["Reactions"], function(bool)
	if utils.show_info("onvotekick [on - off]") then ui.set_value(__options.bool["OnVotekickKick"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Misc['OnVotekickKick'] = bool
end, {"onvotekick"})
__options.bool["OnVotekickCrash"] = ui.add_bool_option(TRANSLATION["Crash"], __submenus["Reactions"], function(bool)
	if utils.show_info("onvotecrash [on - off]") then ui.set_value(__options.bool["OnVotekickCrash"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Misc['OnVotekickCrash'] = bool
end, {"onvotecrash"})
__options.bool["OnVotekickSendChat"] = ui.add_bool_option(TRANSLATION["Send chat"], __submenus["Reactions"], function(bool)
	if utils.show_info("onvotechat [on - off]") then ui.set_value(__options.bool["OnVotekickSendChat"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Misc['OnVotekickSendChat'] = bool
end, {"onvotechat"})

__submenus["CommandSequence"] = ui.add_submenu(TRANSLATION["Custom commands"])
__suboptions["CommandSequence"] = ui.add_sub_option(TRANSLATION["Custom commands"], __submenus["Misc"], __submenus["CommandSequence"])

do
	local saved = {}
	local options = {}

	local function get_command_data(name)
		local data = {
			desc = "",
			commands = {}
		}
		for line in lines(paths["CustomCommands"]:ensureend("\\")..name:ensureend('.txt'))
		do
			if line:startswith("Desc: ") then
				data.desc = line:gsub("^Desc: ", "")
			elseif not line:isblank() then
				insert(data.commands, line)
			end
		end
		return data
	end

	local function RefreshCommands()
		for k, v in pairs(options)
		do
			ui.remove(options[k])
			local command = "exec"..k:gsub("[%p%s]+", ""):lower()
			Global.custom_commands[command] = nil
			system.unregister_command(command)
			options[k] = nil
		end
		if not filesystem.isdir(paths["CustomCommands"]) then return end
		local files = filesystem.scandir(paths["CustomCommands"], 'txt')
		for _, v in ipairs(files)
		do
			local name = v:gsub('.txt$', '')
			if not options[name] then
				local cmd_name = "exec"..name:gsub("[%p%s]+", ""):lower()
				local success, data = xpcall(function() return get_command_data(name) end, function(e) system.log("ERROR", e) end)
				if success then
					Global.custom_commands[cmd_name] = data
					options[name] = ui.add_click_option(name, __submenus["CommandSequence"], function()
						if not Global.custom_commands[cmd_name] then return utils.hud_sound("ERROR") end
						if utils.show_info(cmd_name, Global.custom_commands[cmd_name].desc) then return end
						utils.hud_sound("SELECT")
						local command = Global.custom_commands[cmd_name].commands
						local i = 0
						local len = #command
						system.thread(true, 'do_command_'..system.thread_count(), function()
							i = i + 1
							if command[i]:find("^wait") then
								return system.thread_pause(command[i]:match("%d+"))
							else
								on_menu_command("> "..command[i])
							end
							if i == len then return POP_THREAD end
						end)
					end, {cmd_name})
				end
			end
		end

	end

	__options.click["CommandFolder"] = ui.add_click_option(TRANSLATION["Open folder"], __submenus["CommandSequence"], function()
		if utils.show_info("opencommandfolder") then return end
		utils.hud_sound("SELECT") if not filesystem.isdir(paths["CustomCommands"]) then filesystem.make_dir(paths["CustomCommands"]) end filesystem.open(paths["CustomCommands"])
	end, {"opencommandfolder"})
	__options.click["CommandReload"] = ui.add_click_option(TRANSLATION["Refresh"], __submenus["CommandSequence"], function()
		if utils.show_info("refreshcommands") then return end
		utils.hud_sound("SELECT")
		RefreshCommands()
	end, {"refreshcommands"})
	ui.add_separator(TRANSLATION["Commands"], __submenus["CommandSequence"])

	RefreshCommands()
end

__submenus["Crosshair"] = ui.add_submenu(TRANSLATION["Crosshair"])
__suboptions["Crosshair"] = ui.add_sub_option(TRANSLATION["Crosshair"], __submenus["Misc"], __submenus["Crosshair"])

__options.choose["CrosshairPresets"] = ui.add_choose(TRANSLATION["Presets"], __submenus["Crosshair"], false, {TRANSLATION["Default"], TRANSLATION["Dot"], TRANSLATION["Cross"], TRANSLATION["Saved"]}, function(int)
	if utils.show_info("crosshairpreset [choose]") then return end
	utils.no_sounds_this_frame()
	utils.hud_sound("YES")
	system.thread(true, 'apply_crosshair', function()
		for _, v in ipairs(Global.crosshair_presets)
		do
			if type(v.value[int+1]) == 'table' then
				ui.set_value(v.option, v.value[int+1].r, v.value[int+1].g, v.value[int+1].b, v.value[int+1].a, true)
				if v.option == __options.color["CrosshairColor"] then
					settings.Misc["CrosshairColor"] = v.value[int+1]
				elseif v.option == __options.color["CrosshairBorderColor"] then
					settings.Misc["CrosshairBorderColor"] = v.value[int+1]
				end
			else
				ui.set_value(v.option, v.value[int+1], false)
			end
		end
		return POP_THREAD
	end)
end, {"crosshairpreset"})

do
	local add = switch()
		:case(enum.weapon_group.Throwables, function()
			return 0
		end)
		:case(enum.weapon_group.Shotgun, function()
			return 15
		end)
		:case(enum.weapon_group.Sniper, function()
			return 20
		end)
		:case(enum.weapon_group.Heavy_Weapon, function()
			return 8
		end)
		:default(function()
			return 4
		end)

	__options.bool["CrosshairEnable"] = ui.add_bool_option(TRANSLATION["Enable"], __submenus["Crosshair"], function(bool)
		if utils.show_info("crosshair [on - off]") then ui.set_value(__options.bool["CrosshairEnable"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON")
		settings.Misc["CrosshairEnable"] = bool
		local dynamic_spacing = 0
		local cooldown
		local delay = 0
		system.thread(bool, 'misc_custom_crosshair', function()
			if ui.get_value(__options.bool["FreeCam"]) then return end
			delay = PED.IS_PED_SHOOTING(features.player_ped()) == 1 and clock() + 1.35 or delay
			if PED.IS_PED_SHOOTING(features.player_ped()) == 1 and settings.Misc["CrosshairDynamic"] then
				local wreapon_group = WEAPON.GET_WEAPONTYPE_GROUP(weapons.get_current_weaponhash())
				dynamic_spacing = dynamic_spacing < 20 and dynamic_spacing + add(wreapon_group) or dynamic_spacing
				cooldown = clock() + .5
			elseif cooldown and cooldown < clock() then
				dynamic_spacing = dynamic_spacing > 0 and dynamic_spacing - 1 or dynamic_spacing
			end
			if settings.Misc["CrosshairDisableIngame"] then
				HUD.HIDE_HUD_COMPONENT_THIS_FRAME(14)
			end
			if (PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) == 0 and PED.IS_PED_SHOOTING(features.player_ped()) == 0) and not settings.Misc["CrosshairShowAllTime"] and (delay <= clock()) then return end
			delay = delay <= clock() and 0 or delay
			features.draw_crosshair(settings.Misc["CrosshairWidth"], settings.Misc["CrosshairHeight"],
				settings.Misc["CrosshairSpacing"] + dynamic_spacing, settings.Misc["CrosshairThickness"],
				settings.Misc["CrosshairColor"].r, settings.Misc["CrosshairColor"].g, settings.Misc["CrosshairColor"].b, settings.Misc["CrosshairColor"].a,
				settings.Misc["CrosshairLeft"], settings.Misc["CrosshairRight"], settings.Misc["CrosshairUp"], settings.Misc["CrosshairDown"], 
				settings.Misc["CrosshairBorderThickness"], settings.Misc["CrosshairBorderColor"].r, settings.Misc["CrosshairBorderColor"].g, settings.Misc["CrosshairBorderColor"].b, settings.Misc["CrosshairBorderColor"].a,
				settings.Misc["CrosshairDot"])
		end)
	end, {"crosshair"})
end

__options.bool["CrosshairLink"] = ui.add_bool_option(TRANSLATION["Link width & height"], __submenus["Crosshair"], function(bool)
	if utils.show_info("crosshairlink [on - off]") then ui.set_value(__options.bool["CrosshairLink"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON") settings.Misc["CrosshairLink"] = bool
end, {"crosshairlink"})
__options.num["CrosshairWidth"] = ui.add_num_option(TRANSLATION["Width"], __submenus["Crosshair"], 0, 500, 1, function(int)
	if utils.show_info("crosshairwidth [0 - 500]") then ui.set_value(__options.num["CrosshairWidth"], settings.Misc["CrosshairWidth"], true) return end
	utils.hud_sound("YES") settings.Misc["CrosshairWidth"] = int
end, {"crosshairwidth"})
__options.num["CrosshairHeight"] = ui.add_num_option(TRANSLATION["Height"], __submenus["Crosshair"], 0, 500, 1, function(int)
	if utils.show_info("crosshairheight [0 - 500]") then ui.set_value(__options.num["CrosshairHeight"], settings.Misc["CrosshairHeight"], true) return end
	utils.hud_sound("YES")settings.Misc["CrosshairHeight"] = int
end, {"crosshairheight"})
__options.num["CrosshairSpacing"] = ui.add_num_option(TRANSLATION["Spacing"], __submenus["Crosshair"], 0, 500, 1, function(int)
	if utils.show_info("crosshairspacing [0 - 500]") then ui.set_value(__options.num["CrosshairSpacing"], settings.Misc["CrosshairSpacing"], true) return end
	utils.hud_sound("YES") settings.Misc["CrosshairSpacing"] = int
end, {"crosshairspacing"})
__options.num["CrosshairThickness"] = ui.add_num_option(TRANSLATION["Thickness"], __submenus["Crosshair"], 0, 300, 2, function(int)
	if utils.show_info("crosshairthick [0 - 300]") then ui.set_value(__options.num["CrosshairThickness"], settings.Misc["CrosshairThickness"], true) return end
	utils.hud_sound("YES") settings.Misc["CrosshairThickness"] = int
end, {"crosshairthick"})
__options.color["CrosshairColor"] = ui.add_color_picker(TRANSLATION["Color"], __submenus["Crosshair"], function(color) settings.Misc["CrosshairColor"] = features.fix_color(color) end)
__options.bool["CrosshairLeft"] = ui.add_bool_option(TRANSLATION["Left"], __submenus["Crosshair"], function(bool)
	if utils.show_info("crossharileft [on - off]") then ui.set_value(__options.bool["CrosshairLeft"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON") settings.Misc["CrosshairLeft"] = bool
end, {"crossharileft"})
__options.bool["CrosshairRight"] = ui.add_bool_option(TRANSLATION["Right"], __submenus["Crosshair"], function(bool)
	if utils.show_info("crosshairright [on - off]") then ui.set_value(__options.bool["CrosshairRight"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON") settings.Misc["CrosshairRight"] = bool
end, {"crosshairright"})
__options.bool["CrosshairUp"] = ui.add_bool_option(TRANSLATION["Up"], __submenus["Crosshair"], function(bool)
	if utils.show_info("crosshairup [on - off]") then ui.set_value(__options.bool["CrosshairUp"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON") settings.Misc["CrosshairUp"] = bool
end, {"crosshairup"})
__options.bool["CrosshairDown"] = ui.add_bool_option(TRANSLATION["Down"], __submenus["Crosshair"], function(bool)
	if utils.show_info("crosshairdown [on - off]") then ui.set_value(__options.bool["CrosshairDown"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON") settings.Misc["CrosshairDown"] = bool
end, {"crosshairdown"})
__options.bool["CrosshairDot"] = ui.add_bool_option(TRANSLATION["Dot"], __submenus["Crosshair"], function(bool)
	if utils.show_info("crosshairdot [on - off]") then ui.set_value(__options.bool["CrosshairDot"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON") settings.Misc["CrosshairDot"] = bool
end, {"crosshairdot"})
__options.bool["CrosshairDynamic"] = ui.add_bool_option(TRANSLATION["Dynamic"], __submenus["Crosshair"], function(bool)
	if utils.show_info("crosshairdynamic [on - off]") then ui.set_value(__options.bool["CrosshairDynamic"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON") settings.Misc["CrosshairDynamic"] = bool
end, {"crosshairdynamic"})
__options.bool["CrosshairShowAllTime"] = ui.add_bool_option(TRANSLATION["Show all time"], __submenus["Crosshair"], function(bool)
	if utils.show_info("crosshairshow [on - off]") then ui.set_value(__options.bool["CrosshairShowAllTime"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON") settings.Misc["CrosshairShowAllTime"] = bool
end, {"crosshairshow"})
__options.bool["CrosshairDisableIngame"] = ui.add_bool_option(TRANSLATION["Disable in-game crosshair"], __submenus["Crosshair"], function(bool)
	if utils.show_info("disablegamecrosshair [on - off]") then ui.set_value(__options.bool["CrosshairDisableIngame"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON") settings.Misc["CrosshairDisableIngame"] = bool
end, {"disablegamecrosshair"})
ui.add_separator(TRANSLATION["Borders"], __submenus["Crosshair"])
__options.num["CrosshairBorderThickness"] = ui.add_num_option(TRANSLATION["Thickness"], __submenus["Crosshair"], 0, 100, 1, function(int)
	if utils.show_info("crosshairborderthick [0 - 100]") then ui.set_value(__options.num["CrosshairBorderThickness"], settings.Misc["CrosshairBorderThickness"], true) return end
	utils.hud_sound("YES") settings.Misc["CrosshairBorderThickness"] = int
end, {"crosshairborderthick"})
__options.color["CrosshairBorderColor"] = ui.add_color_picker(TRANSLATION["Color"], __submenus["Crosshair"], function(color) settings.Misc["CrosshairBorderColor"] = features.fix_color(color) end)

Global.crosshair_presets = {
	{option = __options.bool["CrosshairEnable"],
	value = {true, true, true, settings.Misc["CrosshairEnable"]}},
	{option = __options.num["CrosshairWidth"],
	value = {5, 2, 3, settings.Misc["CrosshairWidth"]}},
	{option = __options.num["CrosshairHeight"],
	value = {5, 2, 3, settings.Misc["CrosshairHeight"]}},
	{option = __options.num["CrosshairSpacing"],
	value = {2, 0, 2, settings.Misc["CrosshairSpacing"]}},
	{option = __options.num["CrosshairThickness"],
	value = {2, 2, 2, settings.Misc["CrosshairThickness"]}},
	{option = __options.color["CrosshairColor"],
	value = {{r=255,g=0,b=255,a=255}, {r=255,g=255,b=255,a=120}, {r=180,g=255,b=0,a=255}, settings.Misc["CrosshairColor"]}},
	{option = __options.bool["CrosshairLeft"],
	value = {true, true, true, settings.Misc["CrosshairLeft"]}},
	{option = __options.bool["CrosshairRight"],
	value = {true, true, true, settings.Misc["CrosshairRight"]}},
	{option = __options.bool["CrosshairUp"],
	value = {true, true, true, settings.Misc["CrosshairUp"]}},
	{option = __options.bool["CrosshairDown"],
	value = {true, true, true, settings.Misc["CrosshairDown"]}},
	{option = __options.bool["CrosshairDot"],
	value = {true, true, false, settings.Misc["CrosshairDot"]}},
	{option = __options.bool["CrosshairDynamic"],
	value = {true, false, false, settings.Misc["CrosshairDynamic"]}},
	{option = __options.num["CrosshairBorderThickness"],
	value = {1, 1, 1, settings.Misc["CrosshairBorderThickness"]}},
	{option = __options.color["CrosshairBorderColor"],
	value = {{r=0,g=0,b=0,a=255}, {r=0,g=0,b=0,a=70}, {r=0,g=0,b=0,a=255}, settings.Misc["CrosshairBorderColor"]}},
	{option = __options.bool["CrosshairDisableIngame"],
	value = {true, true, true, settings.Misc["CrosshairDisableIngame"]}},
	{option = __options.bool["CrosshairShowAllTime"],
	value = {false, true, false, settings.Misc["CrosshairShowAllTime"]}}
}

system.thread(true, 'crosshair_link', function()
	if not ui.is_sub_open(__submenus["Crosshair"]) then return end
	if settings.Misc["CrosshairLink"] and ui.get_value(__options.num["CrosshairWidth"]) ~= ui.get_value(__options.num["CrosshairHeight"]) then utils.no_sounds_this_frame() ui.set_value(__options.num["CrosshairHeight"], ui.get_value(__options.num["CrosshairWidth"]), false) end
	if settings.Misc["CrosshairLink"] and ui.get_value(__options.num["CrosshairWidth"]) ~= ui.get_value(__options.num["CrosshairHeight"]) then utils.no_sounds_this_frame() ui.set_value(__options.num["CrosshairWidth"], ui.get_value(__options.num["CrosshairHeight"]), false) end
end)

__submenus["RequestActions"] = ui.add_submenu(TRANSLATION["Request services"])
__suboptions["RequestActions"] = ui.add_sub_option(TRANSLATION["Request services"], __submenus["Misc"], __submenus["RequestActions"])

ui.add_click_option(TRANSLATION["Request RC tank"], __submenus["RequestActions"], function()
	if utils.show_info("requestrctank") then return end
	if NETWORK.NETWORK_IS_SESSION_STARTED() == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	features.request_rc_tank()
end, {"requestrctank"})
ui.add_click_option(TRANSLATION["Request RC bandito"], __submenus["RequestActions"], function()
	if utils.show_info("requestrccar") then return end
	if NETWORK.NETWORK_IS_SESSION_STARTED() == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	features.request_rc_car()
end, {"requestrccar"})
ui.add_click_option(TRANSLATION["Request MOC"], __submenus["RequestActions"], function()
	if utils.show_info("requestmoc") then return end
	if NETWORK.NETWORK_IS_SESSION_STARTED() == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	features.request_moc()
end, {"requestmoc"})
ui.add_click_option(TRANSLATION["Request avenger"], __submenus["RequestActions"], function()
	if utils.show_info("requestavenger") then return end
	if NETWORK.NETWORK_IS_SESSION_STARTED() == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	features.request_avenger()
end, {"requestavenger"})
ui.add_click_option(TRANSLATION["Request terrorbyte"], __submenus["RequestActions"], function()
	if utils.show_info("requestterrorbyte") then return end
	if NETWORK.NETWORK_IS_SESSION_STARTED() == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	features.request_terrorbyte()
end, {"requestterrorbyte"})
ui.add_click_option(TRANSLATION["Request kosatka"], __submenus["RequestActions"], function()
	if utils.show_info("requestkosatka") then return end
	if NETWORK.NETWORK_IS_SESSION_STARTED() == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	features.request_kosatka()
end, {"requestkosatka"})
ui.add_click_option(TRANSLATION["Request dinghy"], __submenus["RequestActions"], function()
	if utils.show_info("requestdinghy") then return end
	if NETWORK.NETWORK_IS_SESSION_STARTED() == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	features.request_dinghy()
end, {"requestdinghy"})
ui.add_click_option(TRANSLATION["Request ballistic armor"], __submenus["RequestActions"], function()
	if utils.show_info("requestballistic") then return end
	if NETWORK.NETWORK_IS_SESSION_STARTED() == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	features.request_ballistic_armor()
end, {"requestballistic"})
ui.add_click_option(TRANSLATION["Request airstrike"], __submenus["RequestActions"], function()
	if utils.show_info("requestairstrike") then return end
	if NETWORK.NETWORK_IS_SESSION_STARTED() == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	features.request_airstrike()
end, {"requestairstrike"})
ui.add_click_option(TRANSLATION["Request backup heli"], __submenus["RequestActions"], function()
	if utils.show_info("requestsupheli") then return end
	if NETWORK.NETWORK_IS_SESSION_STARTED() == 0 then return utils.hud_sound("ERROR") end
	utils.hud_sound("SELECT")
	features.request_support_heli()
end, {"requestsupheli"})

__submenus["ReportStats"] = ui.add_submenu(TRANSLATION["Reports"])
__suboptions["ReportStats"] = ui.add_sub_option(TRANSLATION["Reports"], __submenus["Misc"], __submenus["ReportStats"])

__options.click["ReportGriefing"] = ui.add_click_option("", __submenus["ReportStats"], function() Clipboard(__options.click["ReportGriefing"]) end)
__options.click["ReportHelpful"] = ui.add_click_option("", __submenus["ReportStats"], function() Clipboard(__options.click["ReportHelpful"]) end)
__options.click["ReportFriendly"] = ui.add_click_option("", __submenus["ReportStats"], function() Clipboard(__options.click["ReportFriendly"]) end)
__options.click["ReportExploits"] = ui.add_click_option("", __submenus["ReportStats"], function() Clipboard(__options.click["ReportExploits"]) end)
__options.click["ReportGameExploits"] = ui.add_click_option("", __submenus["ReportStats"], function() Clipboard(__options.click["ReportGameExploits"]) end)
__options.click["ReportTCAnnoy"] = ui.add_click_option("", __submenus["ReportStats"], function() Clipboard(__options.click["ReportTCAnnoy"]) end)
__options.click["ReportTCHate"] = ui.add_click_option("", __submenus["ReportStats"], function() Clipboard(__options.click["ReportTCHate"]) end)
__options.click["ReportVCAnnoy"] = ui.add_click_option("", __submenus["ReportStats"], function() Clipboard(__options.click["ReportVCAnnoy"]) end)
__options.click["ReportVCHate"] = ui.add_click_option("", __submenus["ReportStats"], function() Clipboard(__options.click["ReportVCHate"]) end)
__options.click["ReportOffensiveLang"] = ui.add_click_option("", __submenus["ReportStats"], function() Clipboard(__options.click["ReportOffensiveLang"]) end)
__options.click["ReportOffensiveTagPlate"] = ui.add_click_option("", __submenus["ReportStats"], function() Clipboard(__options.click["ReportOffensiveTagPlate"]) end)
__options.click["ReportOffensiveContent"] = ui.add_click_option("", __submenus["ReportStats"], function() Clipboard(__options.click["ReportOffensiveContent"]) end)
__options.click["ReportBCEmb"] = ui.add_click_option("", __submenus["ReportStats"], function() Clipboard(__options.click["ReportBCEmb"]) end)
__options.click["ReportBCMt"] = ui.add_click_option("", __submenus["ReportStats"], function() Clipboard(__options.click["ReportBCMt"]) end)
__options.click["ReportBCNm"] = ui.add_click_option("", __submenus["ReportStats"], function() Clipboard(__options.click["ReportBCNm"]) end)
__options.click["ReportBCSt"] = ui.add_click_option("", __submenus["ReportStats"], function() Clipboard(__options.click["ReportBCSt"]) end)

system.thread(true, "report_stats_watch", function()
	if not ui.is_sub_open(__submenus["ReportStats"]) then return end
	ui.set_name(__options.click["ReportGriefing"], TRANSLATION["Griefing"]..(": %i"):format(stat.get_int(utils.joaat("MPPLY_GRIEFING"))))
	ui.set_name(__options.click["ReportHelpful"], TRANSLATION["Helpful"]..(": %i"):format(stat.get_int(utils.joaat("MPPLY_HELPFUL"))))
	ui.set_name(__options.click["ReportFriendly"], TRANSLATION["Friendly"]..(": %i"):format(stat.get_int(utils.joaat("MPPLY_FRIENDLY"))))
	ui.set_name(__options.click["ReportExploits"], TRANSLATION["Exploits"]..(": %i"):format(stat.get_int(utils.joaat("MPPLY_EXPLOITS"))))
	ui.set_name(__options.click["ReportGameExploits"], TRANSLATION["Game Exploits"]..(": %i"):format(stat.get_int(utils.joaat("MPPLY_GAME_EXPLOITS"))))
	ui.set_name(__options.click["ReportTCAnnoy"], TRANSLATION["Text Chat: Annoying Me"]..(": %i"):format(stat.get_int(utils.joaat("MPPLY_TC_ANNOYINGME"))))
	ui.set_name(__options.click["ReportTCHate"], TRANSLATION["Text Chat: Using Hate"]..(": %i"):format(stat.get_int(utils.joaat("MPPLY_TC_HATE"))))
	ui.set_name(__options.click["ReportVCAnnoy"], TRANSLATION["Voice Chat: Annoying Me"]..(": %i"):format(stat.get_int(utils.joaat("MPPLY_VC_ANNOYINGME"))))
	ui.set_name(__options.click["ReportVCHate"], TRANSLATION["Voice Chat: Using Hate"]..(": %i"):format(stat.get_int(utils.joaat("MPPLY_VC_HATE"))))
	ui.set_name(__options.click["ReportOffensiveLang"], TRANSLATION["Offensive Language"]..(": %i"):format(stat.get_int(utils.joaat("MPPLY_OFFENSIVE_LANGUAGE"))))
	ui.set_name(__options.click["ReportOffensiveTagPlate"], TRANSLATION["Offensive Tagplate"]..(": %i"):format(stat.get_int(utils.joaat("MPPLY_OFFENSIVE_TAGPLATE"))))
	ui.set_name(__options.click["ReportOffensiveContent"], TRANSLATION["Offensive Content"]..(": %i"):format(stat.get_int(utils.joaat("MPPLY_OFFENSIVE_UGC"))))
	ui.set_name(__options.click["ReportBCEmb"], TRANSLATION["Bad Crew Emblem"]..(": %i"):format(stat.get_int(utils.joaat("MPPLY_BAD_CREW_EMBLEM"))))
	ui.set_name(__options.click["ReportBCMt"], TRANSLATION["Bad Crew Motto"]..(": %i"):format(stat.get_int(utils.joaat("MPPLY_BAD_CREW_MOTTO"))))
	ui.set_name(__options.click["ReportBCNm"], TRANSLATION["Bad Crew Name"]..(": %i"):format(stat.get_int(utils.joaat("MPPLY_BAD_CREW_NAME"))))
	ui.set_name(__options.click["ReportBCSt"], TRANSLATION["Bad Crew Status"]..(": %i"):format(stat.get_int(utils.joaat("MPPLY_BAD_CREW_STATUS"))))
end)

ui.add_click_option(TRANSLATION["Force cloud save"], __submenus["Misc"], function()
	if utils.show_info("forcesave") then return end
	utils.hud_sound("SELECT")
	STATS.STAT_SAVE(0, false, 3, 0)
end, {"forcesave"})

ui.add_click_option(TRANSLATION["Skip cutscene"], __submenus["Misc"], function()
	if utils.show_info("skipcutscene") then return end
	if CUTSCENE.IS_CUTSCENE_PLAYING() == 0 then return utils.hud_sound("ERROR") end
	CUTSCENE.STOP_CUTSCENE_IMMEDIATELY()
	utils.hud_sound("SELECT")
end, {"skipcutscene"})

__options.bool["LockGameplayCam"] = ui.add_bool_option(TRANSLATION["Lock gameplay cam"], __submenus["Misc"], function(bool)
	if utils.show_info("lockcam [on - off]") then ui.set_value(__options.bool["LockGameplayCam"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Misc['LockGameplayCam'] = bool
	system.thread(bool, 'misc_lock_camera', function()
		if ui.get_value(__options.bool["NoClip"]) or PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) == 1 or PAD.GET_CONTROL_NORMAL(0, enum.input.LOOK_LR) ~= 0 or PAD.GET_CONTROL_NORMAL(0, enum.input.LOOK_UD) ~= 0 then return end
		CAM.SET_GAMEPLAY_CAM_RELATIVE_HEADING(0)
	end)
end, {"lockcam"})

__options.bool["DisableCamCenter"] = ui.add_bool_option(TRANSLATION["Disable cam centering"], __submenus["Misc"], function(bool)
	if utils.show_info("disablecamcenter [on - off]") then ui.set_value(__options.bool["DisableCamCenter"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Misc['DisableCamCenter'] = bool
	local h = CAM.GET_GAMEPLAY_CAM_RELATIVE_HEADING()
	local p = CAM.GET_GAMEPLAY_CAM_RELATIVE_PITCH()
	system.thread(bool, 'misc_disable_cam_center', function()
		if ui.get_value(__options.bool["NoClip"]) then return end
		if PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) == 1 or PAD.GET_CONTROL_NORMAL(0, enum.input.LOOK_LR) ~= 0 or PAD.GET_CONTROL_NORMAL(0, enum.input.LOOK_UD) ~= 0 then 
			h = CAM.GET_GAMEPLAY_CAM_RELATIVE_HEADING()
			p = CAM.GET_GAMEPLAY_CAM_RELATIVE_PITCH()
		else
			CAM.SET_GAMEPLAY_CAM_RELATIVE_HEADING(h)
			CAM.SET_GAMEPLAY_CAM_RELATIVE_PITCH(p, 0)
		end
	end)
end, {"disablecamcenter"})

__options.bool["DisableRecording"] = ui.add_bool_option(TRANSLATION["Disable recording"], __submenus["Misc"], function(bool)
	if utils.show_info("disablerecording [on - off]") then ui.set_value(__options.bool["DisableRecording"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Misc['DisableRecording'] = bool
	system.thread(bool, 'misc_disable_recording', function(tick)
		RECORDING._STOP_RECORDING_THIS_FRAME()
	end)
end, {"disablerecording"})

__options.bool["ShootGodmodePlayers"] = ui.add_bool_option(TRANSLATION["Shoot godmode players"], __submenus["Misc"], function(bool)
	if utils.show_info("shootgodmode [on - off]") then ui.set_value(__options.bool["ShootGodmodePlayers"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Misc['ShootGodmodePlayers'] = bool
	system.thread(bool, 'misc_disable_god_on_aimed', function()
		if PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) == 0 then return end
		local player = features.get_player_from_ped(features.get_aimed_ped())
		if player == -1 then return end
		if not (settings.General["Exclude Friends"] and features.is_friend(player)) and not features.is_excluded(player) then
			features.remove_god(player)
		end
	end)
end, {"shootgodmode"})

__options.bool["BlameProtect"] = ui.add_bool_option(TRANSLATION["Anti-Blame"], __submenus["Misc"], function(bool)
	if utils.show_info("antiblame [on - off]", "You won't be able to kill other players with this enabled!") then ui.set_value(__options.bool["BlameProtect"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Misc['BlameProtect'] = bool
	NETWORK.NETWORK_SET_FRIENDLY_FIRE_OPTION(not bool)
	system.thread(bool, 'misc_anti_blame', function()
		NETWORK.NETWORK_SET_FRIENDLY_FIRE_OPTION(false)
	end)
end, {"antiblame"})

__options.num["LodScale"] = ui.add_float_option(TRANSLATION["Distance scaling"], __submenus["Misc"], 0, 200, .1, 2, function(float)
	if utils.show_info("lodscale [0.0 - 200.0]") then ui.set_value(__options.num["LodScale"], settings.Misc['LodScale'], true) return end
	utils.hud_sound("YES")
	settings.Misc['LodScale'] = features.round(float, 2)
	system.thread(true, 'lod_scale', function()
		if settings.Misc['LodScale'] == 1 then return POP_THREAD end
		STREAMING.OVERRIDE_LODSCALE_THIS_FRAME(settings.Misc['LodScale'])
	end)
end, {"lodscale"})

__options.num["SetCamDistance"] = ui.add_float_option(TRANSLATION["Set cam distance"], __submenus["Misc"], 0, 10000, .1, 2, function(float)
	if utils.show_info("camdist [0.0 - 10000.0]") then ui.set_value(__options.num["SetCamDistance"], settings.Misc['SetCamDistance'], true) return end
	utils.hud_sound("YES")
	settings.Misc['SetCamDistance'] = features.round(float, 2)
end, {"camdist"})

do
	local defZoom = 83
	__options.num["SetMapZoom"] = ui.add_num_option(TRANSLATION["Set map zoom"], __submenus["Misc"], 1, 100, 1, function(int)
		if utils.show_info("mapzoom [0 - 100]") then ui.set_value(__options.num["SetMapZoom"], settings.Misc['SetMapZoom'], true) return end
		utils.hud_sound("YES")
		defZoom = int
		system.thread(true, 'map_zoom', function()
			HUD.SET_RADAR_ZOOM_PRECISE(defZoom)
			if defZoom == 83 then return POP_THREAD end
		end)
	end, {"mapzoom"})
	ui.set_value(__options.num["SetMapZoom"], defZoom, true)
end

do
	local unload
	local was_open
	local open_time
	ui.add_click_option(TRANSLATION["Panic button"], __submenus["Misc"], function()
		if utils.show_info("killgta5") then return end
		if open_time and open_time > clock() then utils.hud_sound("ERROR") return end
		utils.hud_sound("SELECT")
		if not unload and ui.is_sub_open(__submenus["Misc"]) then
			system.notify(TRANSLATION["Warning"], TRANSLATION["This will close your game, continue?"], settings.General["HudColorNotifyWarning"], true)
			unload = true
			return
		end
		os.exit()
	end, {"killgta5"})

	system.thread(true, 'is_misc_open', function()
		if not was_open and ui.is_sub_open(__submenus["Misc"]) then
			was_open = true
			open_time = clock() + .5
		elseif was_open and not ui.is_sub_open(__submenus["Misc"]) then
			was_open = false
		end
		if unload and not ui.is_sub_open(__submenus["Misc"]) then
			unload = false
		end
	end)
end

system.thread(true, 'set_cam_dist', function()
	if settings.Misc['SetCamDistance'] <= 0 or settings.Misc['SetCamDistance'] > 10000 then return end
	CAM._ANIMATE_GAMEPLAY_CAM_ZOOM(1, settings.Misc['SetCamDistance'])
end)

---------------------------------------------------------------------------------------------------------------------------------
-- Recovery
---------------------------------------------------------------------------------------------------------------------------------
__submenus["Recovery"] = ui.add_submenu(TRANSLATION["Recovery"])
__suboptions["Recovery"] = ui.add_sub_option(TRANSLATION["Recovery"], __submenus["MainSub"], __submenus["Recovery"])

do
	__submenus["StatEditor"] = ui.add_submenu(TRANSLATION["Stat editor"])
	__suboptions["StatEditor"] = ui.add_sub_option(TRANSLATION["Stat editor"], __submenus["Recovery"], __submenus["StatEditor"])

	__submenus["StatEditorManual"] = ui.add_submenu(TRANSLATION["Manual edit"])
	__suboptions["StatEditorManual"] = ui.add_sub_option(TRANSLATION["Manual edit"], __submenus["StatEditor"], __submenus["StatEditorManual"])

	local stat = 1
	-- local _bool
	-- local _int
	-- local _float
	local value = 0
	local stats = {}
	-- local values = {'0.001', '0.01', '0.1', '1', '100', '10000', '1000000'}
	local mult = 1

	for i, v in ipairs(enum.stats)
	do
		stats[i] = v.name
	end

	__options.choose["StatName"] = ui.add_choose(TRANSLATION["Stat"], __submenus["StatEditor"], true, stats, function(int)
		if utils.show_info("statname [choose]") then ui.set_value(__options.choose["StatName"], stat - 1, true) return end
		stat = int + 1 
		utils.hud_sound("YES")
	end, {"statname"})

	-- __options.bool["Bool"] = ui.add_bool_option(TRANSLATION["Bool"], __submenus["StatEditor"], function(bool) _bool = bool end)
	-- __options.bool["Int"] = ui.add_bool_option(TRANSLATION["Int"], __submenus["StatEditor"], function(bool) _int = bool end)
	-- __options.bool["Float"] = ui.add_bool_option(TRANSLATION["Float"], __submenus["StatEditor"], function(bool) _float = bool end)
	__options.num["StatValue"] = ui.add_float_option(TRANSLATION["Value"], __submenus["StatEditor"], -999999999, 999999999, 1, 4, function(float)
		if utils.show_info("statvaluefloat [-999999999.0 - 999999999.0]") then ui.set_value(__options.num["StatValue"], value, true) return end
		utils.hud_sound("YES") value = float
	end, {"statvaluefloat"})

	ui.add_click_option(TRANSLATION["Change stat"], __submenus["StatEditor"], function()
		if utils.show_info("changestat") then return end
		utils.hud_sound("SELECT")
		local type = enum.stats[stat].type
		local charstat = enum.stats[stat].characterStat
		local GetHash = switch()
			:case(true, function()
				local char = features.get_last_char()
				return utils.joaat('MP'..char..'_'..enum.stats[stat].name)
			end)
			:default(function()
				return utils.joaat(enum.stats[stat].name)
			end)

		if type == 'bool' then
			STATS.STAT_SET_BOOL(GetHash(charstat), features.to_bool(value), true)
			return
		elseif type == 'float' then
			STATS.STAT_SET_FLOAT(GetHash(charstat), value, true)
			return
		elseif features.compare(type, 'int', 'u32', 'u64') then
			STATS.STAT_SET_INT(GetHash(charstat), floor(value), true)
			return
		end
	end, {"changestat"})

	local stat_input
	local prefix
	local GetStatHash = switch()
		:case(true, function()
			local char = features.get_last_char()
			return utils.joaat('MP'..char..'_'..stat_input)
		end)
		:default(function()
			return utils.joaat(stat_input)
		end)

	__options.string["StatInput"] = ui.add_input_string(TRANSLATION["Stat name"], __submenus["StatEditorManual"], function(text)
		if utils.show_info("statinput") then ui.set_value(__options.string["StatInput"], stat_input or "", true) return end
		stat_input = text
	end, {"statinput"})
	__options.bool["UseMPPrefix"] = ui.add_bool_option(TRANSLATION["Use \"MP\" prefix"], __submenus["StatEditorManual"], function(bool)
		if utils.show_info("statusemp") then ui.set_value(__options.bool["UseMPPrefix"], not bool, true) return end
		utils.hud_sound("TOGGLE_ON") prefix = bool
	end, {"statusemp"})
	ui.add_num_option(TRANSLATION["Set int"], __submenus["StatEditorManual"], -999999999, 999999999, 1, function(int)
		if utils.show_info("statvalue [-999999999 - 999999999]") then return end
		if not stat_input or stat_input:isblank() then return utils.hud_sound("ERROR") end
		local hash = GetStatHash(prefix)
		if not hash or hash == 0 then return utils.hud_sound("ERROR") end
		if STATS.STAT_SET_INT(hash, int, true) == 1 then
			utils.hud_sound("YES")
		else
			system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Something went wrong"], settings.General["HudColorNotifyError"])
			utils.hud_sound("ERROR")
		end
	end, {"statvalue"})
	ui.add_float_option(TRANSLATION["Set float"], __submenus["StatEditorManual"], -999999999, 999999999, .1, 4, function(float)
		if utils.show_info("statsetfloat [-999999999.0 - 999999999.0]") then return end
		if not stat_input or stat_input:isblank() then return utils.hud_sound("ERROR") end
		local hash = GetStatHash(prefix)
		if not hash or hash == 0 then return utils.hud_sound("ERROR") end
		if STATS.STAT_SET_FLOAT(hash, float, true) == 1 then
			utils.hud_sound("YES")
		else
			system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Something went wrong"], settings.General["HudColorNotifyError"])
			utils.hud_sound("ERROR")
		end
	end, {"statsetfloat"})
	ui.add_bool_option(TRANSLATION["Set bool"], __submenus["StatEditorManual"], function(bool)
		if utils.show_info("statsetbool [on - off]") then return end
		if not stat_input or stat_input:isblank() then return utils.hud_sound("ERROR") end
		local hash = GetStatHash(prefix)
		if not hash or hash == 0 then return utils.hud_sound("ERROR") end
		if STATS.STAT_SET_BOOL(hash, bool, true) == 1 then
			utils.hud_sound("YES")
		else
			system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Something went wrong"], settings.General["HudColorNotifyError"])
			utils.hud_sound("ERROR")
		end
	end, {"statsetbool"})
	ui.add_input_string(TRANSLATION["Set user ID"], __submenus["StatEditorManual"], function(text)
		if utils.show_info("statsetsuserid") then return end
		if not stat_input or stat_input:isblank() then return utils.hud_sound("ERROR") end
		local hash = GetStatHash(prefix)
		if not hash or hash == 0 then return utils.hud_sound("ERROR") end
		if STATS.STAT_SET_USER_ID(hash, text, true) == 1 then
			utils.hud_sound("YES")
		else
			system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["Something went wrong"], settings.General["HudColorNotifyError"])
			utils.hud_sound("ERROR")
		end
	end, {"statsetsuserid"})
end

do
	local snacks = {
		{'NO_BOUGHT_YUM_SNACKS', 30},
		{'NO_BOUGHT_HEALTH_SNACKS', 15},
		{'NO_BOUGHT_EPIC_SNACKS', 5},
		{'NUMBER_OF_ORANGE_BOUGHT', 10},
		{'NUMBER_OF_BOURGE_BOUGHT', 10},
		{'NUMBER_OF_CHAMP_BOUGHT', 5},
		{'CIGARETTES_BOUGHT', 20}
	}
	local armor = {
		{'MP_CHAR_ARMOUR_1_COUNT', 10},
		{'MP_CHAR_ARMOUR_2_COUNT', 10},
		{'MP_CHAR_ARMOUR_3_COUNT', 10},
		{'MP_CHAR_ARMOUR_4_COUNT', 10},
		{'MP_CHAR_ARMOUR_5_COUNT', 10}
	}
	local fast_run = {
		'CHAR_FM_ABILITY_1_UNLCK',
		'CHAR_FM_ABILITY_2_UNLCK',
		'CHAR_FM_ABILITY_3_UNLCK',
		'CHAR_ABILITY_1_UNLCK',
		'CHAR_ABILITY_2_UNLCK',
		'CHAR_ABILITY_3_UNLCK'
	}

	__submenus["StatUnlocks"] = ui.add_submenu(TRANSLATION["Unlocks"])
	__suboptions["StatUnlocks"] = ui.add_sub_option(TRANSLATION["Unlocks"], __submenus["Recovery"], __submenus["StatUnlocks"])

	ui.add_click_option(TRANSLATION["Unlock fast-run"], __submenus["StatUnlocks"], function()
		if utils.show_info("unlockfastrun") then return end
		utils.hud_sound("SELECT")
		local char = features.get_last_char()
		for _, v in ipairs(fast_run)
		do
			STATS.STAT_SET_INT(utils.joaat('MP'..char..'_'..v), -1, true)
		end
	end, {"unlockfastrun"})

	ui.add_click_option(TRANSLATION["Unlock alien tattoo"], __submenus["StatUnlocks"], function()
		if utils.show_info("unlockalientat") then return end
		utils.hud_sound("SELECT")
		local char = features.get_last_char()
		STATS.STAT_SET_INT(utils.joaat("MP"..char.."_TATTOO_FM_CURRENT_32"), -1, true)
	end, {"unlockalientat"})

	local kills = 0
	local deaths = 0
	__options.num["PlayersKills"] = ui.add_num_option(TRANSLATION["Player kills"], __submenus["Recovery"], -999999999, 999999999, 1, function(int)
		if utils.show_info("statkills [-999999999 - 999999999]") then return end
		utils.hud_sound("YES")
		STATS.STAT_SET_INT(utils.joaat("MPPLY_KILLS_PLAYERS"), int, true)
	end, {"statkills"})
	__options.num["PlayersDeaths"] = ui.add_num_option(TRANSLATION["Player deaths"], __submenus["Recovery"], -999999999, 999999999, 1, function(int) utils.hud_sound("YES")
		if utils.show_info("statdeaths [-999999999 - 999999999]") then return end
    		STATS.STAT_SET_INT(utils.joaat("MPPLY_DEATHS_PLAYER"), int, true)
	end, {"statdeaths"})
	__options.num["PlayerMental"] = ui.add_float_option(TRANSLATION["Mental state"], __submenus["Recovery"], 0, 100, .1, 2, function(float) utils.hud_sound("YES")
		if utils.show_info("statmental [0.0 - 100.0]") then return end
    		STATS.STAT_SET_FLOAT(utils.joaat("MP"..features.get_last_char().."_PLAYER_MENTAL_STATE"), float, true)
	end, {"statmental"})

	system.thread(true, 'get_stats', function()
		if not ui.is_sub_open(__submenus["Recovery"]) then return end
		ui.set_value(__options.num["PlayersKills"], stat.get_int(utils.joaat("MPPLY_KILLS_PLAYERS")), true)
		ui.set_value(__options.num["PlayersDeaths"], stat.get_int(utils.joaat("MPPLY_DEATHS_PLAYER")), true)
		ui.set_value(__options.num["PlayerMental"], stat.get_float(utils.joaat("MP"..features.get_last_char().."_PLAYER_MENTAL_STATE")), true)
	end)

	ui.add_click_option(TRANSLATION["Fill snacks"], __submenus["Recovery"], function()
		if utils.show_info("fillsnack") then return end
		utils.hud_sound("SELECT")
		for _, v in ipairs(snacks)
		do
			local char = features.get_last_char()
			STATS.STAT_SET_INT(utils.joaat('MP'..char..'_'..v[1]), v[2], true)
		end
	end, {"fillsnack"})

	ui.add_click_option(TRANSLATION["Fill armour"], __submenus["Recovery"], function()
		if utils.show_info("fillarmour") then return end
		utils.hud_sound("SELECT")
		for _, v in ipairs(armor)
		do
			local char = features.get_last_char()
			STATS.STAT_SET_INT(utils.joaat('MP'..char..'_'..v[1]), v[2], true)
		end
	end, {"fillarmour"})
end

---------------------------------------------------------------------------------------------------------------------------------
-- Settings
---------------------------------------------------------------------------------------------------------------------------------
__submenus["Settings"] = ui.add_submenu(TRANSLATION["Settings"])
__suboptions["Settings"] = ui.add_sub_option(TRANSLATION["Settings"], __submenus["MainSub"], __submenus["Settings"])

Global.translation_files = filesystem.scandir(paths['Translations'], 'json')
for i, v in ipairs(Global.translation_files)
do
	rename(paths['Translations']:ensureend('\\')..v, paths['Translations']:ensureend('\\')..v:lower())
end

do
	local text
	local lang = switch()
		:case('English', function()
			return 'English (US)'
		end)
		:case('French', function()
			return 'French (Français)'
		end)
		:case('German', function()
			return 'German (Deutsch)'
		end)
		:case('Italian', function()
			return 'Italian (Italiano)'
		end)
		:case('Spanish', function()
			return 'Spanish (Español)'
		end)
		:case('Polish', function()
			return 'Polish (Polski)'
		end)
		:case('Russian', function()
			return 'Russian (Русский)'
		end)
		:case('Korean', function()
			return 'Korean (한국인)'
		end)
		:case('Chinese', function()
			return 'Chinese (中國人)'
		end)
		:case('Japanese', function()
			return 'Japanese (日本)'
		end)
		:case('Simplified_chinese', function()
			return 'Simplified Chinese (简体中文)'
		end)
		:default(function()
			return text
		end)

	for i = 1, #Global.translation_files do
		text = Global.translation_files[i]:gsub('.json$', ''):capitalize()
		Global.langs[i] = lang(text)
	end
end

__options.choose["Translation"] = ui.add_choose(TRANSLATION['Default language'], __submenus["Settings"], true, Global.langs, function(i)
	local value = 0
	for e, v in pairs(Global.translation_files) do
		if v == settings.General['Translation'] then
			value = e - 1
			break
		end
	end
	if utils.show_info("lang [choose]") then ui.set_value(__options.choose["Translation"], value, true) return end
	utils.hud_sound("YES")
	system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["You need to reload the script to apply changes"])
	settings.General['Translation'] = Global.translation_files[i + 1]:ensureend('.json')
end, {"lang"})

ui.add_separator(TRANSLATION['Menu'], __submenus["Settings"])

__submenus["HudColors"] = ui.add_submenu(TRANSLATION["Hud colors"])
__suboptions["HudColors"] = ui.add_sub_option(TRANSLATION["Hud colors"], __submenus["Settings"], __submenus["HudColors"])

ui.add_separator(TRANSLATION["Players"], __submenus["HudColors"])
__options.color["HudColorSelf"] = ui.add_color_picker(TRANSLATION["Self"], __submenus["HudColors"], function(color) settings.General["HudColorSelf"] = features.fix_color(color) end)
__options.color["HudColorFriend"] = ui.add_color_picker(TRANSLATION["Friend"], __submenus["HudColors"], function(color) settings.General["HudColorFriend"] = features.fix_color(color) end)
__options.color["HudColorStranger"] = ui.add_color_picker(TRANSLATION["Stranger"], __submenus["HudColors"], function(color) settings.General["HudColorStranger"] = features.fix_color(color) end)
__options.color["HudColorModder"] = ui.add_color_picker(TRANSLATION["Modder"], __submenus["HudColors"], function(color) settings.General["HudColorModder"] = features.fix_color(color) end)
ui.add_separator(TRANSLATION["Notifications"], __submenus["HudColors"])
__options.color["HudColorNotifyNormal"] = ui.add_color_picker(TRANSLATION["Notification"], __submenus["HudColors"], function(color) settings.General["HudColorNotifyNormal"] = features.fix_color(color) end)
__options.color["HudColorNotifySuccess"] = ui.add_color_picker(TRANSLATION["Notification success"], __submenus["HudColors"], function(color) settings.General["HudColorNotifySuccess"] = features.fix_color(color) end)
__options.color["HudColorNotifyWarning"] = ui.add_color_picker(TRANSLATION["Notification warning"], __submenus["HudColors"], function(color) settings.General["HudColorNotifyWarning"] = features.fix_color(color) end)
__options.color["HudColorNotifyError"] = ui.add_color_picker(TRANSLATION["Notification error"], __submenus["HudColors"], function(color) settings.General["HudColorNotifyError"] = features.fix_color(color) end)
__options.color["HudColorOptionInfo"] = ui.add_color_picker(TRANSLATION["Option info"], __submenus["HudColors"], function(color) settings.General["HudColorOptionInfo"] = features.fix_color(color) end)
ui.add_separator(TRANSLATION["Other"], __submenus["HudColors"])
__options.color["HudColorARspeedo"] = ui.add_color_picker(TRANSLATION["AR speedo"], __submenus["HudColors"], function(color) settings.General["HudColorARspeedo"] = features.fix_color(color) end)
__options.color["HudColorClearArea"] = ui.add_color_picker(TRANSLATION["Clear area"], __submenus["HudColors"], function(color) settings.General["HudColorClearArea"] = features.fix_color(color) end)
__options.color["HudColorAimLaser"] = ui.add_color_picker(TRANSLATION["Aim laser"], __submenus["HudColors"], function(color) settings.General["HudColorAimLaser"] = features.fix_color(color) end)

__submenus["DisableControls"] = ui.add_submenu(TRANSLATION["Disable controls"])
__suboptions["DisableControls"] = ui.add_sub_option(TRANSLATION["Disable controls"], __submenus["Settings"], __submenus["DisableControls"])

__options.bool["DisableControls"] = ui.add_bool_option(TRANSLATION["Disable controls when menu is active"], __submenus["DisableControls"], function(bool)
	if utils.show_info("disablecontrols [on - off]") then ui.set_value(__options.bool["DisableControls"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.Controls["DisableControls"] = bool
	system.thread(bool, 'disable_controls', function()
		for _, v in ipairs(settings.Controls['BlockInput'])
		do
			if ui.is_open() then
				PAD.DISABLE_CONTROL_ACTION(0, v, true)
			end
		end
	end)
end, {"disablecontrols"})

do
	local l = 0
	local inputs = {}
	local arrow_keys = {27, 172, 173, 174, 175, 187, 188, 189, 190, 299, 300, 307, 308, 18, 176, 191, 201, 215, 177, 194, 202, 344, 200, 322}
	local numpad = {60, 96, 97, 107, 108, 109, 110, 111, 112, 117, 118, 123, 124, 125, 126, 127, 128, 201, 314, 315, 200, 322}
	for line in lines(files["Inputs"])
	do
		inputs[l] = line
		l = l + 1
	end

	local InputPreset = switch()
		:case(1, function()
			utils.no_sounds_this_frame()
			for _, i in ipairs(arrow_keys)
			do
				ui.set_value(__options.bool["INPUT_"..i], true, false)
			end
		end)
		:case(2, function()
			utils.no_sounds_this_frame()
			for _, i in ipairs(numpad)
			do
				ui.set_value(__options.bool["INPUT_"..i], true, false)
			end
		end)
		:case(3, function()
			for i = 0, 360
			do
				ui.set_value(__options.bool["INPUT_"..i], true, true)
				insert(settings.Controls['BlockInput'], i)
			end
		end)

	local presets = {TRANSLATION["None"], TRANSLATION["Arrow keys"], TRANSLATION["Numpad"], TRANSLATION["All"]}
	ui.add_choose(TRANSLATION["Presets"], __submenus["DisableControls"], false, presets, function(int)
		if utils.show_info("disablecontrolpreset [choose]") then return end
		utils.hud_sound("YES")
		settings.Controls['BlockInput'] = {}
		for i = 0, 360 do
			ui.set_value(__options.bool["INPUT_"..i], false, true)
		end

		InputPreset(int)
	end, {"disablecontrolpreset"})
	ui.add_separator(TRANSLATION["Controls"], __submenus["DisableControls"])

	for i, v in pairs(inputs)
	do
		__options.bool["INPUT_"..i] = ui.add_bool_option(v, __submenus["DisableControls"], function(bool)
			if utils.show_info("disablecontrol"..i.." [on - off]") then ui.set_value(__options.bool["INPUT_"..i], not bool, true) return end
			utils.hud_sound("TOGGLE_ON")
			if bool then
				insert(settings.Controls['BlockInput'], i)
			else
				for j, e in ipairs(settings.Controls['BlockInput'])
				do
					if e == i then
						table.remove(settings.Controls['BlockInput'], j)
						break
					end
				end
			end
		end, {"disablecontrol"..i})
	end
end

__options.bool["HideInPauseMenu"] = ui.add_bool_option(TRANSLATION["Hide menu when pause"], __submenus["Settings"], function(bool)
	if utils.show_info("hideinpause [on - off]") then ui.set_value(__options.bool["HideInPauseMenu"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.General["HideInPauseMenu"] = bool
	local paused
	system.thread(bool, 'hide_menu_when_pause', function()
		if not paused and HUD.IS_PAUSE_MENU_ACTIVE() == 1 and not features.is_in_transition() and ui.is_open() then
			paused = true
			ui.close()
		elseif HUD.IS_PAUSE_MENU_ACTIVE() == 0 and paused then
			ui.open()
			paused = false
		end
	end)
end, {"hideinpause"})

__options.bool["HideOnActiveChat"] = ui.add_bool_option(TRANSLATION["Hide menu when chat is active"], __submenus["Settings"], function(bool)
	if utils.show_info("hideinchat [on - off]") then ui.set_value(__options.bool["HideOnActiveChat"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.General["HideOnActiveChat"] = bool
	local chat_active
	system.thread(bool, 'hide_menu_when_chat', function()
		if not chat_active and HUD._IS_MULTIPLAYER_CHAT_ACTIVE() == 1 and ui.is_open() then
			chat_active = true
		elseif HUD._IS_MULTIPLAYER_CHAT_ACTIVE() == 0 and chat_active then
			ui.open()
			chat_active = false
		elseif chat_active then
			ui.close()
		end
	end)
end, {"hideinchat"})

__options.bool["HudSounds"] = ui.add_bool_option(TRANSLATION["Hud sounds"], __submenus["Settings"], function(bool)
	if utils.show_info("hudsounds [on - off]") then ui.set_value(__options.bool["HudSounds"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.General["HudSounds"] = bool
end, {"hudsounds"})

__options.bool["DisableNotifications"] = ui.add_bool_option(TRANSLATION["Disable notifications"], __submenus["Settings"], function(bool)
	if utils.show_info("disablenotifications [on - off]") then ui.set_value(__options.bool["DisableNotifications"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.General["DisableNotifications"] = bool
end, {"disablenotifications"})

__options.bool["NotificationSound"] = ui.add_bool_option(TRANSLATION["Notification sound"], __submenus["Settings"], function(bool)
	if utils.show_info("notifysound [on - off]") then ui.set_value(__options.bool["NotificationSound"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.General["NotificationSound"] = bool
end, {"notifysound"})

__options.bool["ShowSaveIcon"] = ui.add_bool_option(TRANSLATION["Saving icon"], __submenus["Settings"], function(bool)
	if utils.show_info("saveicon [on - off]") then ui.set_value(__options.bool["ShowSaveIcon"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.General["ShowSaveIcon"] = bool
end, {"saveicon"})

ui.add_separator(TRANSLATION['Configs'], __submenus["Settings"])

do
	local save_delay = 0
	local load_delay = 0
	__options.click["Save Config"] = ui.add_click_option(TRANSLATION["Save config"], __submenus["Settings"], function()
		if utils.show_info("saveconf") then return end
		if save_delay > clock() then return utils.hud_sound("ERROR") end utils.hud_sound("SELECT") system.save_conf();save_delay = clock() + 2
	end, {"saveconf"})
	__options.click["Load Config"] = ui.add_click_option(TRANSLATION["Load config"], __submenus["Settings"], function()
		if utils.show_info("loadconf") then return end
		if load_delay > clock() then return utils.hud_sound("ERROR") end utils.hud_sound("SELECT") system.load_conf();system.apply_config(settings);load_delay = clock() + 2
	end, {"loadconf"})
end

ui.add_separator(TRANSLATION['Other'], __submenus["Settings"])

__options.bool["ShowControls"] = ui.add_bool_option(TRANSLATION["Show controls"], __submenus["Settings"], function(bool)
	if utils.show_info("showcontrols [on - off]") then ui.set_value(__options.bool["ShowControls"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.General["ShowControls"] = bool
end, {"showcontrols"})

__options.bool["AutoUpdate"] = ui.add_bool_option(TRANSLATION["Auto update"], __submenus["Settings"], function(bool)
	if utils.show_info("autoupdate [on - off]") then ui.set_value(__options.bool["AutoUpdate"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.General["AutoUpdate"] = bool
end, {"autoupdate"})

__options.bool["AutoSave"] = ui.add_bool_option(TRANSLATION["Auto save settings"], __submenus["Settings"], function(bool)
	if utils.show_info("autosave [on - off]") then ui.set_value(__options.bool["AutoSave"], not bool, true) return end
	utils.hud_sound("TOGGLE_ON")
	settings.General["AutoSave"] = bool
end, {"autosave"})

__options.choose["AutoSaveWait"] = ui.add_choose(TRANSLATION["Save every"], __submenus["Settings"], true, {TRANSLATION["15s"], TRANSLATION["30s"], TRANSLATION["45s"], TRANSLATION["1 minute"], TRANSLATION["2 minutes"], TRANSLATION["5 minutes"]}, function(int)
	if utils.show_info("autosavewait [choose]") then ui.set_value(__options.choose["AutoSaveWait"], settings.General["AutoSaveWait"], true) return end
	utils.hud_sound("YES")
	settings.General["AutoSaveWait"] = int
end, {"autosavewait"})

ui.add_click_option(TRANSLATION["Repeat tutorial"], __submenus["Settings"], start_tutorial)

ui.add_click_option(TRANSLATION["Reset to default"], __submenus["Settings"], function()
	if utils.show_info("reset") then return end
	utils.hud_sound("SELECT")
	system.apply_config(cache:get('Default config'))
end, {"reset"})

__submenus["Help"] = ui.add_submenu(TRANSLATION["Help"])
__suboptions["Help"] = ui.add_sub_option(TRANSLATION["Help"], __submenus["Settings"], __submenus["Help"])

ui.add_click_option('(») '..TRANSLATION["means hyperlink"], __submenus["Help"], function() utils.hud_sound("Error") end)
ui.add_click_option(format(TRANSLATION["Press %s to use free cam"], 'F8'), __submenus["Help"], function() utils.hud_sound("Error") end)
ui.add_click_option(format(TRANSLATION["Press %s to use commands"], 'F2'), __submenus["Help"], function() utils.hud_sound("Error") end)

---------------------------------------------------------------------------------------------------------------------------------
-- Credits
---------------------------------------------------------------------------------------------------------------------------------

__submenus["Credits"] = ui.add_submenu(TRANSLATION["Credits"])
__suboptions["Credits"] = ui.add_sub_option(TRANSLATION["Credits"], __submenus["MainSub"], __submenus["Credits"])

ui.add_click_option(format(TRANSLATION['%s for scripting'], 'SATTY'), __submenus["Credits"], function() Global.debug_click = Global.debug_click + 1 if system.is_safe_mode_enabled() then return utils.hud_sound("ERROR") end utils.hud_sound("SELECT") features.to_clipboard("SATTY", true) end)
ui.add_click_option(format(TRANSLATION['%s for bug finding'], 'Dr Donger'), __submenus["Credits"], function() if system.is_safe_mode_enabled() then return utils.hud_sound("ERROR") end utils.hud_sound("SELECT") features.to_clipboard("Dr Donger", true) end)
ui.add_click_option(format(TRANSLATION['%s for improving lua API'], 'ItsPxel'), __submenus["Credits"], function() if system.is_safe_mode_enabled() then return utils.hud_sound("ERROR") end utils.hud_sound("SELECT") features.to_clipboard("ItsPxel", true) end)
if not TRANSLATION[1]['Credits']:isblank() then ui.add_click_option(format(TRANSLATION['%s for translation'], TRANSLATION[1]['Credits']), __submenus["Credits"], function() if system.is_safe_mode_enabled() then return utils.hud_sound("ERROR") end utils.hud_sound("SELECT") features.to_clipboard(TRANSLATION[1]['Credits'], true) end) end
ui.add_click_option("MAFINS", __submenus["Credits"], function() if utils.show_info("", "Menyoo dev") then return end if system.is_safe_mode_enabled() then return utils.hud_sound("ERROR") end utils.hud_sound("SELECT") features.to_clipboard("MAFINS", true) end)
ui.add_click_option("DurtyFree »", __submenus["Credits"], function() if utils.show_info("", "Opens https://github.com/DurtyFree") then return end utils.hud_sound("SELECT") filesystem.open("https://github.com/DurtyFree") end)
ui.add_click_option("Sainan »", __submenus["Credits"], function() if utils.show_info("", "Opens https://github.com/Sainan") then return end utils.hud_sound("SELECT") filesystem.open("https://github.com/Sainan") end)
ui.add_click_option("Stack Overflow »", __submenus["Credits"], function() if utils.show_info("", "Opens https://stackoverflow.com") then return end utils.hud_sound("SELECT") filesystem.open("https://stackoverflow.com") end)
ui.add_click_option("alloc8or »", __submenus["Credits"], function() if utils.show_info("", "Opens https://alloc8or.re/gta5/nativedb/") then return end utils.hud_sound("SELECT") filesystem.open("https://alloc8or.re/gta5/nativedb/") end)
ui.add_click_option("Parik27 »", __submenus["Credits"], function() if utils.show_info("", "Opens https://github.com/Parik27") then return end utils.hud_sound("SELECT") filesystem.open("https://github.com/Parik27") end)

ui.add_click_option("‹"..TRANSLATION["Command box"].."›", __submenus["MainSub"], function()
	utils.hud_sound("SELECT")
	system.open_command_box("> ", true)
end)

---------------------------------------------------------------------------------------------------------------------------------
-- Apply config
---------------------------------------------------------------------------------------------------------------------------------

for _, v in pairs(__options.bool) do
	ui.set_value(v, false, true)
end

system.apply_config(settings)
vehicle_blacklist.load()

---------------------------------------------------------------------------------------------------------------------------------
-- Debug
---------------------------------------------------------------------------------------------------------------------------------

system.thread(true, 'debug_menu', function()
	if Global.debug_click > 20 or settings.Dev.Enable then
		local sub = ui.add_submenu("Debug")
		ui.add_sub_option("Debug", __submenus["MainSub"], sub)

		__options.bool["DebugSELog"] = ui.add_bool_option('Log script events', sub, function() utils.hud_sound("TOGGLE_ON") end, {"devselog"})
		__options.bool["LogColliderUsage"] = ui.add_bool_option('Log collider usage', sub, function(bool) utils.hud_sound("TOGGLE_ON")
			system.thread(bool, 'collider_usage', function()
				system.log('collider usage', format('%i', features.get_collider_usage()))
			end)
		end, {"devcollidedrusage"})
		local dev_set = ui.add_bool_option("Enable dev settings", sub, function(bool) settings.Dev.Enable = bool end, {"devenable"})
		ui.set_value(dev_set, settings.Dev.Enable, true)
		ui.add_separator('Print', sub)

		ui.add_click_option("Print empty translation", sub, function()
			utils.hud_sound("SELECT")
			cache:set("TRANSLATION", TRANSLATION)
			local translation = cache:get("TRANSLATION")
			translation[1].Credits = ""
			translation[1].Language = ""
			for k in pairs(translation)
			do
				if k ~= 1 then
					translation[k] = ""
				end
			end
			filesystem.write(json:encode_pretty(translation), paths['Lua']..[[\translation.txt]])
		end, {"devprinttranslation"})

		ui.add_click_option("Print untranslated text", sub, function()
			utils.hud_sound("SELECT")
			local text = {}
			for k, v in pairs(TRANSLATION)
			do
				if k == v then
					insert(text, k)
				end
			end
			table.sort(text)
			filesystem.write(concat(text, "\n"), paths['Lua']..[[\untranslated.txt]])
		end, {"devprintuntranslated"})

		ui.add_click_option("Print active threads", sub, function()
			utils.hud_sound("SELECT")
			local active_threads = 0
			for k, v in pairs(Global.threads) do
				active_threads = active_threads + 1
				system.log('Imagined Menu', format('Thread: %s, run time: %.3fs', k, clock() - v.time))
			end
			system.log('Imagined Menu', 'Active Threads: '..active_threads)
			system.log('Imagined Menu', format('Last tick time: %.3fs', Global.ticktime))
		end, {"devprintthreads"})

		ui.add_click_option("Print avarage tick time", sub, function()
			utils.hud_sound("SELECT")
			system.log('Imagined Menu', format('Avarage tick time: %.3fs', Global.avgticktime))
		end, {"devticktime"})

		ui.add_click_option("Print thread time", sub, function()
			utils.hud_sound("SELECT")
			system.log('Imagined Menu', format('Thread time: %.3fs', Global.thread_time))
		end, {"devthreadtime"})

		ui.add_click_option("Print while loop pos", sub, function()
			utils.hud_sound("SELECT")
			system.log('Imagined Menu', format('Pos where main loop pos: %i', Global.main_loop_pos))
		end, {"devwhilelooppos"})

		ui.add_click_option("Print current thread", sub, function()
			utils.hud_sound("SELECT")
			system.log('Imagined Menu', format('Current thread: %s', Global.this_name))
		end, {"devcurrthread"})

		ui.add_separator("Memory", sub)

		ui.add_click_option("Print memory usage", sub, function()
			utils.hud_sound("SELECT")
			system.log('Imagined Menu', format('Memory usage: %i kB', gcinfo()))
		end, {"devprintmemory"})

		ui.add_click_option("Clear memory", sub, function()
			utils.hud_sound("SELECT")
			local memory = collectgarbage("count")
			collectgarbage("collect")
			system.log('Imagined Menu', format("Cleared %i kB of memory", memory - collectgarbage("count")))
		end, {"devclearmemory"})

		return POP_THREAD
	end
end)

---------------------------------------------------------------------------------------------------------------------------------
-- Commandbox
---------------------------------------------------------------------------------------------------------------------------------

function system.on_command_error(message)
	utils.hud_sound("ERROR")
	if not message then return end
	system.notify(TRANSLATION["Imagined Menu"], message, settings.General["HudColorNotifyError"])
end

function system.on_command_off()
	MISC._CANCEL_ONSCREEN_KEYBOARD()
	Global.onscreen_keyboard = false
	features.disable_phone(false)
	utils.hud_sound("BACK")
end

function system.on_command_success()
	local result = MISC.GET_ONSCREEN_KEYBOARD_RESULT():lower()
	if Global.command_paste then
		local text = (result..Global.command_paste):sub(1, 60):lower()
		system.open_command_box(text)
		Global.command_paste = nil
		Global.command_results = {}
		return
	end

	local success, message = on_menu_command(result)
	if success == -1 then
		system.on_command_off()
	elseif success == 0 then
		if not utils.get_command_results() then
			Global.onscreen_keyboard = false
			system.on_command_error(message)
		else
			system.open_command_box(Global.command_results[1])
			Global.result_com_pos = 1
		end
	elseif success == 1 then
		Global.onscreen_keyboard = false
		if Global.last_commands[1] ~= result then
			insert(Global.last_commands, 1, result)
		end
	elseif success == 2 then
		system.open_command_box(result)
		system.on_command_error(message)
	end
	features.disable_phone(false)
end

function system.on_command_cancel()
	features.disable_phone(false)
	Global.onscreen_keyboard = false
	utils.hud_sound("BACK")
end

system.thread(true, "commandbox", function()
	if Global.onscreen_keyboard then
		if PAD.IS_DISABLED_CONTROL_JUST_RELEASED(0, enum.input.FRONTEND_PAUSE_ALTERNATE) == 1 then
			system.on_command_off()
			return
		end
		if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.FRONTEND_RS) == 1 and PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, enum.input.NEXT_CAMERA) == 1 then
			if not system.is_safe_mode_enabled() then
				Global.command_paste = system.from_clipboard()
				PAD._SET_CONTROL_NORMAL(0, enum.input.FRONTEND_ACCEPT, 1)
			else
				system.notify(TRANSLATION["Imagined Menu"], TRANSLATION["This feature requires Safe mode to be disabled"], settings.General["HudColorNotifyError"])
				utils.hud_sound("ERROR")
			end
		end

		if PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, enum.input.FRONTEND_RRIGHT) == 1 then
			Global.command_results = {}
		end

		ui.close()
		features.disable_phone(true)
		local value = MISC.UPDATE_ONSCREEN_KEYBOARD()
		if value == -1 then
			system.on_command_off()
		elseif value == 1 then
			xpcall(function() system.on_command_success() end, function(e) system.on_command_off() utils.hud_sound("ERROR") system.notify(TRANSLATION["Error"], TRANSLATION["Something went wrong"], settings.General["HudColorNotifyError"]);system.log("ERROR", e) end)
		elseif value == 2 then
			system.on_command_cancel()
		end
	elseif Global.is_menu_open then
		Global.is_menu_open = nil
		ui.open()
	end

	if Global.onscreen_keyboard and #Global.last_commands > 0 then
		if PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, enum.input.CELLPHONE_UP) == 1 then
			command_move.last_up()
		elseif PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, enum.input.CELLPHONE_DOWN) == 1 then
			command_move.last_down()
		end
	end

	if not (Global.command_scroll_wait and Global.command_scroll_wait > clock()) and  Global.onscreen_keyboard and utils.get_command_results() then
		if PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.SPRINT) == 1 and PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.SELECT_WEAPON) == 1 then
			command_move.result_down()
		elseif PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.SELECT_WEAPON) == 1 then
			command_move.result_up()
		else
			Global.command_scroll_wait = nil
		end
	elseif Global.command_scroll_wait and PAD.IS_DISABLED_CONTROL_PRESSED(0, enum.input.SELECT_WEAPON) == 0 then
		Global.command_scroll_wait = nil
	end

	if not Global.onscreen_keyboard and PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, enum.input.REPLAY_START_STOP_RECORDING_SECONDARY) == 1 then
		system.open_command_box("> ", true)
		utils.hud_sound("CONTINUE")
	end
end)

if not settings.General["IsTutorialCompleted"] then
	start_tutorial()
end

---------------------------------------------------------------------------------------------------------------------------------
-- Main Loop
---------------------------------------------------------------------------------------------------------------------------------

Global.open = ui.is_open()

do
	local memory_warn
	local GetWaitTime = switch()
		:default(function()
			return 45
		end)
		:case(0, function()
			return 15
		end)
		:case(1, function()
			return 30
		end)
		:case(3, function()
			return 60
		end)
		:case(4, function()
			return 120
		end)
		:case(5, function()
			return 300
		end)


	system.thread(true, 'main', function(tick)
		if ENTITY.GET_ENTITY_ALPHA(features.player_ped()) ~= ui.get_value(__options.num["Set Alpha"]) then
			ui.set_value(__options.num["Set Alpha"], ENTITY.GET_ENTITY_ALPHA(features.player_ped()), true)
		end
		if ui.get_value(__options.bool["DisableCollision"]) ~= (ENTITY.GET_ENTITY_COLLISION_DISABLED(features.player_ped()) == 1) then
			ui.set_value(__options.bool["DisableCollision"], ENTITY.GET_ENTITY_COLLISION_DISABLED(features.player_ped()) == 1, true)
		end
		if ui.is_sub_open(__submenus["Vehicle"]) and vehicles.get_player_vehicle() ~= 0 then
			if ui.get_value(__options.bool["InvisibleVehicle"]) ~= (ENTITY.IS_ENTITY_VISIBLE(vehicles.get_player_vehicle()) == 0) then
				ui.set_value(__options.bool["InvisibleVehicle"], ENTITY.IS_ENTITY_VISIBLE(vehicles.get_player_vehicle()) == 0, true)
			end
			if ui.get_value(__options.bool["ScorchedVehicle"]) ~= features.is_render_scorched(vehicles.get_player_vehicle()) then
				ui.set_value(__options.bool["ScorchedVehicle"], features.is_render_scorched(vehicles.get_player_vehicle()), true)
			end
			if ui.get_value(__options.bool["SlidyVehicle"]) ~= vehicles.has_reduced_grip(vehicles.get_player_vehicle()) then
				ui.set_value(__options.bool["SlidyVehicle"], vehicles.has_reduced_grip(vehicles.get_player_vehicle()), true)
			end
			if ui.get_value(__options.bool["DisableVehicleCollision"]) ~= (ENTITY.GET_ENTITY_COLLISION_DISABLED(vehicles.get_player_vehicle()) ~= 0) then
				ui.set_value(__options.bool["DisableVehicleCollision"], ENTITY.GET_ENTITY_COLLISION_DISABLED(vehicles.get_player_vehicle()) ~= 0, true)
			end
			if ui.get_value(__options.num["VehicleAlpha"]) ~= ENTITY.GET_ENTITY_ALPHA(vehicles.get_player_vehicle()) then
				ui.set_value(__options.num["VehicleAlpha"], ENTITY.GET_ENTITY_ALPHA(vehicles.get_player_vehicle()), true)
			end
		end
		if ui.is_sub_open(__submenus["PlaySound"]) then
			ui.set_value(__options.num["GameVolume"], memory.read_int(s_memory.GameVolume), true)
		end
		if settings.General["AutoSave"] and clock() - GetWaitTime(settings.General["AutoSaveWait"]) > Global.AutosaveTimer then
			system.save_conf()
		end
		if settings.General["HudSounds"] then
			local found
			if ui.is_open() then
				if ui.is_sub_open(Global.prev_sub) then
					found = true
				else
					local sub
					if ui.is_sub_open(Global.sub_parent[Global.prev_sub]) then
						sub = Global.sub_parent[Global.prev_sub]
					elseif ui.is_sub_open(__submenus["MainSub"]) then
						sub = __submenus["MainSub"]
					elseif ui.is_sub_open(__submenus["PlayerList"]) then
						sub = __submenus["PlayerList"]
					end

					for k in pairs(Global.sub_kids[Global.prev_sub] or Global.subs) -- no need to check every submenu
					do
						if sub then k = sub end
						if ui.is_sub_open(k) then
							found = true
							Global.is_open = true
							if Global.sub_parent[Global.prev_sub] == k then
								utils.hud_sound("Back")
							else
								utils.hud_sound("continue")
							end
							Global.prev_sub = k
							break
						end
					end
					if not found then
						for i = 0, 1000
						do
							if ui.is_sub_open(i) then
								found = true
								Global.is_open = true
								if Global.prev_sub ~= -1 then utils.hud_sound("continue") end
								Global.prev_sub = i
								break
							end
						end
					end
				end
			end

			if Global.is_open and not found then
				Global.is_open = false
				utils.hud_sound("Back")
			elseif not Global.is_open and found then
				Global.is_open = true
				utils.hud_sound("continue")
			end

			if not Global.open and ui.is_open() then
				utils.hud_sound("continue")
				Global.open = true
			elseif Global.open and not ui.is_open() then
				utils.hud_sound("Back")
				Global.open = false
			end
		end

		if tick % 1000 == 0 and not memory_warn and collectgarbage("count") > 500000 then
			memory_warn = true
			system.notify(TRANSLATION["Warning"], TRANSLATION["Script is using to much memory!"], settings.General["HudColorNotifyWarning"], true, true)
		end
	end, true)
end

local foo = function()
	return Global.this_thread(Global.ticks[Global.this_name])
end
local err = function(e)
	system.notify(TRANSLATION["Error"], TRANSLATION["Caught an exception"], settings.General["HudColorNotifyError"], true)
	system.log("ERROR", "Caught an exception, thread: "..Global.this_name)
	system.log("ERROR", e)
	return 0
end

local function request_control_tick()
	local patch
	for k, v in pairs(Global.to_request_control)
	do
		if not patch then
			patch = true
			features.patch_rqctrl(true)
		end
		if ENTITY.DOES_ENTITY_EXIST(v.entity) == 0 or v.timeout < clock() then
			Global.to_request_control[k] = nil
		elseif features.request_control_once(v.entity) then
			xpcall(v.func, function(e) system.log('debug', e) end)
			Global.to_request_control[k] = nil
		end
	end
	if not patch then return end
	features.patch_rqctrl(false)
end

local function call_thread(key, thread)
	if Global.threads[key].pause and Global.threads[key].pause > clock() then return end
	Global.threads[key].pause = nil
	local time = clock()
	if not Global.ticks[key] then
		Global.ticks[key] = 0
	else
		Global.ticks[key] = Global.ticks[key] + 1
	end
	Global.this_thread = thread.f
	Global.this_name = key
	local ok, value = xpcall(foo, err)
	if not ok or value == 0 then
		system.remove_thread()
		system.log('debug', format('thread %s finished', key))
	end
	if clock() - time > .0011 then system.log('debug', format('Expensive thread: %s | time: %.3f', key, clock() - time)) end
end
s_memory.write_byte_array(s_memory.OrbitalBypass, {0xB0, 0x01, 0xC3}) -- bypass explosionType 59

system.log(("Loaded in %i ms"):format((clock()-TIME) * 1000))
welcome_screen()

while Global.gRunning
do
	Global.time = clock()
	if Global.dont_play_tog then
		Global.dont_play_tog = false
	end
	if Global.disable_menu_sound then
		Global.disable_menu_sound = nil
	end

	globals.set_int(4540726, 1) -- bypass for vehicle despawn

	PAD.DISABLE_CONTROL_ACTION(0, enum.input.SELECT_CHARACTER_MULTIPLAYER, true)

	if PAD.IS_DISABLED_CONTROL_JUST_RELEASED(0, enum.input.SELECT_CHARACTER_MULTIPLAYER) == 1 then
		ui.set_value(__options.bool["FreeCam"], not ui.get_value(__options.bool["FreeCam"]), false)
	end

	Global.main_loop_pos = 2
	Global.thread_queue = {}
	for k, v in pairs(Global.threads)
	do
		if v.priority then
			Global.thread_queue[k] = v
		else
			call_thread(k, v)
		end
	end

	for k, v in pairs(Global.thread_queue)
	do
		call_thread(k, v)
	end

	Global.main_loop_pos = 3

	request_control_tick()

	vehicles.do_torque_tick()
	s_memory.free()
	if Global.selected_player then Global.selected_player = nil end
	Global.thread_time = clock() - Global.time
	Global.main_loop_pos = 4
	ui.ignore_rgb_callback = {}

	system.yield(0)

	Global.main_loop_pos = 1
	Global.ticktime = clock() - Global.time

	if Global.memoized or #Global.last_ticks == 10 then
		Global.memoized = true
		table.remove(Global.last_ticks, 1)
	end

	insert(Global.last_ticks, Global.ticktime)
	Global.avgticktime = features.sum_table(Global.last_ticks) / (Global.memoized and 10 or #Global.last_ticks)
end
