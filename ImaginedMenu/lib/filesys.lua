--
-- made by FoxxDash/aka Ðr ÐºήgΣr & SATTY
--
-- Copyright © 2022 Imagined Menu
--

local execute = os.execute
local rename = os.rename
local popen = io.popen
local open = io.open
local insert = table.insert

local filesystem = {}

--- @param dir string
function filesystem.make_dir(dir)
    execute('mkdir "" "'..dir:ensureend('\\')..'"')
end

--- @param path string
function filesystem.open(path)
    execute('start "" "'..path..'"')
end

--- @param directory string
--- @param extension? string
--- @return table
function filesystem.scandir(directory, extension)
    local t = {}
    local pfile = popen('dir "'..directory..'" /b')
    for filename in pfile:lines() do
        if not extension or (extension and filename:endswith(extension:ensurestart('.'))) then
            insert(t, filename)
        end
    end
    pfile:close()
    return t
end

--- @param file string
--- @return bool
--- @return string? error
function filesystem.exists(file)
    if not file then return false end
    local ok, err, code = rename(file, file)
    if not ok and code == 13 then
        -- Permission denied, but it exists
        return true
    end
    return ok, err
end

--- @param file string
--- @return int
function filesystem.get_size(file)
    local f = open(file, 'r')
    local current = f:seek()
    local size = f:seek("end")
    f:seek("set", current)
    f:close()
    return size
end

-- Check if a directory exists in this path
--- @param path string
--- @return bool
function filesystem.isdir(path)
    if not path then return false end
    return filesystem.exists(path:ensureend('\\'))
end

--- @param file string
--- @return string
function filesystem.read_all(file)
    local f = assert(open(file, "r"))
    local content = f:read("*all")
    f:close()
    return content
end

--- @param content string
--- @param path string
function filesystem.write_file(file, data)
    local file = file:gsub("\\", "/")
    local path = file:sub(1, file:find("[^/]*%.%l+")-1)
    if not filesystem.isdir(path) then filesystem.make_dir(path) end
    local f = assert(open(file, 'wb'))
    f:write(data)
    f:close()
end

--- @param content string
--- @param path string
function filesystem.write(content, path)
    local f = assert(open(path, 'w'))
    f:write(content)
    f:close()
end

return filesystem