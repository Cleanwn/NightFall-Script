--
-- made by FoxxDash/aka Ðr ÐºήgΣr & SATTY
--
-- Copyright © 2022 Imagined Menu
--

local Global = {}

local function InitGlobals()
    Global.gRunning = true
    Global.translation_files = {}
    Global.thread_count = 0
    Global.threads = {}
    Global.ticks = {}
    Global.AutosaveTimer = 0
    Global.ticktime = 0
    Global.avgticktime = 0
    Global.blame_delay = 0
    Global.playerlist = {}
    Global.modder_detection = {}
    Global.suspicious = {}
    Global.players_history = {}
    Global.saved_locations = {}
    Global.locations = {}
    Global.command_locations = {}
    Global.outfits = {}
    Global.outfits_keys = {}
    Global.vehicle_blips = {}
    Global.hornboost = {}
    Global.chat_queue = {}
    Global.commands = {}
    Global.command_list = {}
    Global.player_dead_time = {}
    Global.player_otr_time = {}
    Global.this_name = ""
    Global.subs = {}
    Global.sub_parent = {}
    Global.sub_kids = {}
    Global.blockobjects = {}
    Global.veh_spawn_timeout = {}
    Global.veh_spawn = {}
    Global.log_repeats = 0
    Global.debug_click = 0
    Global.command_results = {}
    Global.last_commands = {}
    Global.to_request_control = {}
    Global.players_by_name = {}
    Global.to_request_count = 0
    Global.sound_name = ""
    Global.main_loop_pos = 0
    Global.prev_sub = -1
    Global.last_ticks = {}
    Global.anims = {}
    Global.detection_info = {}
    Global.detection_info.is_player_dead = {}
    Global.detection_info.money = {}
    Global.langs = {}
    Global.last_teleports = {}
    Global.custom_commands = {}
    Global.OrbitalCannon = {}
    Global.OrbitalCannon.charge = 0
    Global.valid_objects = {}
    Global.languages = {
        [0] = 'english.json',
        'french.json',
        'german.json',
        'italian.json',
        'spanish.json',
        'brazilian.json',
        'polish.json',
        'russian.json',
        'korean.json',
        'chinese.json',
        'japanese.json',
        'mexican.json',
        'simplified_chinese.json'
    }
    Global.commad_prefix = {[0]='nf!','/','\\','!','$','%','&','-','+','?','*',',','.','#','€','@'}
    for i = 0, 31
    do
        Global.veh_spawn[i] = 0
        Global.detection_info.money[i] = 0
        Global.detection_info.is_player_dead[i] = true
        Global.player_dead_time[i] = true
        Global.player_otr_time[i] = true
        Global.playerlist[i] = {
            SendJets = false,
            HonkBoosting = false,
            VehicleHorn = false,
            Commands = false,
            ChatMock = false,
            Freeze = false,
            AlwaysWanted = false,
            InvincibleEnemyVeh = true
        }
        Global.modder_detection[i] = {}
        Global.suspicious[i] = {}
        for j = 0, 23
        do
            Global.modder_detection[i][j] = false
        end
        for j = 1, 4
        do
            Global.suspicious[i][j] = false
        end
    end
end

InitGlobals()

return Global