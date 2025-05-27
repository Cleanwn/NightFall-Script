--
-- made by SATTY
--
-- Copyright © 2022 Imagined Menu
--

local insert = table.insert
local memory = memory
local unpack = unpack

local vector3 = require "vector3"

local s_memory = {
	offsets = {}
}
local to_free = {}
local fail_scan = {}

function s_memory.add(key, address, pointer)
	local address = memory.find_pattern(address)
	if address == 0 and key == "RQControl" then
		return
	end
	if address == 0 then insert(fail_scan, "Failed to find pattern: "..key) return end
	s_memory[key] = pointer(address)
end

local function offset_new(key, offsets)
	s_memory.offsets[key] = offsets
end

system.log('Imagined Menu', "Initializing pointers...")

s_memory.add("WorldPtr", "48 8B 05 ? ? ? ? 45 ? ? ? ? 48 8B 48 08 48 85 C9 74 07", function(addr)
	return memory.read_int64(memory.rip(addr + 3))
end)
s_memory.add("BlameExp", "0F 85 ? ? ? ? 48 8B 05 ? ? ? ? 48 8B 48 08 E8", function(addr)
	return addr
end)
s_memory.add("RPM", "76 03 0F 28 F0 F3 44 0F 10 93", function(addr)
	return memory.read_int(addr + 10)
end)
s_memory.add("Throttle", "76 03 0F 28 F0 F3 44 0F 10 93", function(addr)
	return memory.read_int(addr + 10) + 0x10
end)
s_memory.add("FuelOffset", "74 26 0F 57 C9", function(addr)
	return memory.read_int(addr + 8)
end)
s_memory.add("CurrentGear", "48 8D 8F ? ? ? ? 4C 8B C3 F3 0F 11 7C 24", function(addr)
	return memory.read_int(addr + 3) + 2
end)
s_memory.add("phInstance", "? 8B 0D ? ? ? ? ? 83 64 ? ? 00 ? 0F B7 D1 ? 33 C9 E8", function(addr)
	return memory.rip(addr + 3)
end)
s_memory.add("ColliderOffset", "? 63 ? ? ? ? ? 3B ? ? ? ? ? 0F 8D ? ? ? ? ? 8B C8", function(addr)
	return addr
end)
s_memory.add("GravityOffset", "F3 0F 59 BF ? ? ? ? 4D 85 E4 0F 8E ? ? ? ?", function(addr)
	return memory.read_int(addr + 4)
end)
s_memory.add("RQControl", "48 89 5C 24 ? 57 48 83 EC 20 8B D9 E8 ? ? ? ? ? ? ? ? 8B CB", function(addr)
	return addr + 0x13
end)
s_memory.add("OrbitalBypass", "FF 52 ? 48 8B F8 83 FB 3B 75 ?", function(addr)
	return addr - 0x17
end)
s_memory.add("GameVolume", "66 0F 6E 05 ? ? ? ? 0F 5B F6", function(addr)
	return memory.rip(addr + 4)
end)

if #fail_scan > 0 then error(table.concat(fail_scan, "\n"), 0) end

offset_new("godmode", {0x08, 0x189})
offset_new("run_speed_mult", {0x08, 0x10A8, 0xCF0})
offset_new("swim_speed_mult", {0x08, 0x10A8, 0x170})
offset_new("shoot_delay", {0x10B8, 0x20, 0x013C})
offset_new("wanted_level", {0x08, 0x10A8, 0x0888})
offset_new("wanted_level_display", {0x08, 0x10A8, 0x088C})

--- @param count? int
--- @return int ... pointer
function s_memory.alloc_get(count)
	count = count or 1
	local output = {}
	for i = 1, count do
		insert(output, s_memory.alloc())
	end
	return unpack(output)
end

--- @param size? int
--- @return int pointer
function s_memory.alloc(size)
	local ptr = memory.malloc(size or 4)
	insert(to_free, ptr)
	return ptr
end

--- @return int pointer
function s_memory.allocv3()
	local ptr = memory.malloc(24)
	insert(to_free, ptr)
	return ptr
end

--- @param pointer int
--- @return vector3
function s_memory.readv3(pointer)
	return vector3(memory.read_vector3(pointer))
end

function s_memory.free()
	for _, v in ipairs(to_free)
	do
		memory.free(v)
	end
	to_free = {}
end

--- @param address int
--- @param offset int
--- @return bool
function s_memory.is_bit_set(address, offset)
	return bit.band(memory.read_int(address), bit.lshift(1, offset)) ~= 0
end

--- @param address int
--- @param args table
function s_memory.write_byte_array(address, args)
	if not address or address == 0 then return end
	for i = 1, #args
	do
		memory.write_byte(address + (i-1), args[i])
	end
end

--- @param pointer int
--- @param offsets table
--- @return int address
function s_memory.get_memory_address(pointer, offsets)
	for i = 1, #offsets - 1
	do
		pointer = memory.read_int64(pointer + offsets[i])
		if not pointer or pointer == 0 then return 0 end
	end
	return pointer + offsets[#offsets]
end

return s_memory