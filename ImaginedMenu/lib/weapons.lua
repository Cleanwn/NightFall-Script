--
-- made by FoxxDash/aka Ðr ÐºήgΣr & SATTY
--
-- Copyright © 2022 Imagined Menu
--

local insert = table.insert
local ipairs = ipairs

local json = require "JSON"
local filesystem = require "filesys"
local s_memory = require "script_memory"

local weapons = {}

weapons.data = json:decode(filesystem.read_all(files['WeaponData']))
weapons.names = {}
weapons.components = {}
weapons.hashes = {}
weapons.name_form_hash = {}

--- @param hash int
--- @return string name
weapons.get_label = function(hash)
    return HUD._GET_LABEL_TEXT(weapons.name_form_hash[hash])
end

function weapons.get_current_weaponhash()
    local hash = s_memory.alloc()
    WEAPON.GET_CURRENT_PED_WEAPON(PLAYER.PLAYER_PED_ID(), hash, true)
    return memory.read_int(hash)
end

for _, v in ipairs(weapons.data) do
    if v.Category and v.TranslatedLabel and v.TranslatedLabel.English ~= "Invalid" then
        local name = HUD._GET_LABEL_TEXT(v.TranslatedLabel.Name)
        if v.Name == "WEAPON_DIGISCANNER" then
            name = "Digiscanner"
        end
        weapons.components[v.Hash] = {}
        for _, e in ipairs(v.Components)
        do
            insert(weapons.components[v.Hash], e.Hash)
        end
        insert(weapons.names, name)
        insert(weapons.hashes, v.Hash)
        weapons.name_form_hash[v.IntHash] = v.TranslatedLabel.Name
        weapons.name_form_hash[v.Hash] = v.TranslatedLabel.Name
    end
end

return weapons