local packed_funs = {}

local mpx = "MP" .. globals.get_int("MPPLY_LAST_MP_CHAR") .. "_"

local function get_packed_bool_date(index)
    local statName = nil
    local i = 0
    -- 0-198
    if (index >= 0 and index < 192) then
        i = (index - 0) / 64
        index = (index - 0) % 64
        statName = mpx .. "PSTAT_BOOL" .. i
    end
    -- --513-705
    if (index >= 513 and index < 705) then
        i = (index - 513) / 64
        index = (index - 513) % 64
        statName = "MP_PSTAT_BOOL" .. i
    end
    -- 2919-3111
    if (index >= 2919 and index < 3111) then
        i = (index - 2919) / 64
        index = (index - 2919) % 64
        statName = "MP_TUPSTAT_BOOL" .. i
    end
    ----3111-3879
    if (index >= 3111 and index < 3879) then
        i = (index - 3111) / 64
        index = (index - 3111) % 64
        statName = mpx .. "TUPSTAT_BOOL" .. i
    end
    -- --4207--4335
    if (index >= 4207 and index < 4335) then
        i = (index - 4207) / 64
        index = (index - 4207) % 64
        statName = mpx .. "NGPSTAT_BOOL" .. i
    end
    -- 4335-4399
    if (index >= 4335 and index < 4399) then
        i = (index - 4335) / 64
        index = (index - 4335) % 64
        statName = "MP_NGPSTAT_BOOL" .. i
    end
    -- 6029-6413
    if (index >= 6029 and index < 6413) then
        i = (index - 6029) / 64
        index = (index - 6029) % 64
        statName = mpx .. "NGTATPSTAT_BOOL" .. i
    end
    -- 7321-7385
    if (index >= 7321 and index < 7385) then
        i = (index - 7321) / 64
        index = (index - 7321) % 64
        statName = "MP_NGDLCPSTAT_BOOL" .. i
    end
    -- 7385--7641
    if (index >= 7385 and index < 7641) then
        i = (index - 7385) / 64
        index = (index - 7385) % 64
        statName = mpx .. "NGDLCPSTAT_BOOL" .. i
    end
    -- 9361-9553
    if (index >= 9361 and index < 9553) then
        i = (index - 9361) / 64
        index = (index - 9361) % 64
        statName = mpx .. "DLCBIKEPSTAT_BOOL" .. i
    end
    -- 15369-15561
    if (index >= 15369 and index < 15561) then
        i = (index - 15369) / 64
        index = (index - 15369) % 64
        statName = mpx .. "DLCGUNPSTAT_BOOL" .. i
    end
    ----15562-15946
    if (index >= 15562 and index < 15946) then
        i = (index - 15562) / 64
        index = (index - 15562) % 64
        statName = mpx .. "GUNTATPSTAT_BOOL" .. i
    end
    -- 15946-16010
    if (index >= 15946 and index < 16010) then
        i = (index - 15946) / 64
        index = (index - 15946) % 64
        statName = mpx .. "DLCSMUGCHARPSTAT_BOOL" .. i
    end
    -- 18098-18162
    if (index >= 18098 and index < 18162) then
        i = (index - 18098) / 64
        index = (index - 18098) % 64
        statName = mpx .. "GANGOPSPSTAT_BOOL" .. i
    end
    ----22066-22194
    if (index >= 22066 and index < 22194) then
        i = (index - 22066) / 64
        index = (index - 22066) % 64
        statName = mpx .. "BUSINESSBATPSTAT_BOOL" .. i
    end
    -- 24962-25538
    if (index >= 24962 and index < 25538) then
        i = (index - 24962) / 64
        index = (index - 24962) % 64
        statName = mpx .. "ARENAWARSPSTAT_BOOL" .. i
    end
    -- 26810-27258
    if (index >= 26810 and index < 27258) then
        i = (index - 26810) / 64
        index = (index - 26810) % 64
        statName = mpx .. "CASINOPSTAT_BOOL" .. i
    end
    -- 28098-28354
    if (index >= 28098 and index < 28354) then
        i = (index - 28098) / 64
        index = (index - 28098) % 64
        statName = mpx .. "CASINOHSTPSTAT_BOOL" .. i
    end
    -- 28355-28483
    if (index >= 28355 and index < 28483) then
        i = (index - 28355) / 64
        index = (index - 28355) % 64
        statName = mpx .. "HEIST3TATTOOSTAT_BOOL" .. i
    end
    -- 30227-30355
    if (index >= 30227 and index < 30355) then
        i = (index - 30227) / 64
        index = (index - 30227) % 64
        statName = mpx .. "SU20PSTAT_BOOL" .. i
    end
    -- 30355-30483
    if (index >= 30355 and index < 30483) then
        i = (index - 30355) / 64
        index = (index - 30355) % 64
        statName = mpx .. "SU20TATTOOSTAT_BOOL" .. i
    end
    -- 30515-30707
    if (index >= 30515 and index < 30707) then
        i = (index - 30515) / 64
        index = (index - 30515) % 64
        statName = mpx .. "HISLANDPSTAT_BOOL" .. i
    end
    -- 31707-32283
    if (index >= 31707 and index < 32283) then
        i = (index - 31707) / 64
        index = (index - 31707) % 64
        statName = mpx .. "TUNERPSTAT_BOOL" .. i
    end
    -- 32283-32411
    if (index >= 32283 and index < 32411) then
        i = (index - 32283) / 64
        index = (index - 32283) % 64
        statName = mpx .. "FIXERPSTAT_BOOL" .. i
    end
    -- 32411-32475
    if (index >= 32411 and index < 32475) then
        i = (index - 32411) / 64
        index = (index - 32411) % 64
        statName = mpx .. "FIXERTATTOOSTAT_BOOL" .. i
    end
    -- 34123-34241 阿浩?？
    --if (index >= 34123 and index < 34241) then
    --    i = (index - 34123) // 64
    --    index = (index - 34123) % 64
    --    statName = mpx .. "" .. i
    -- end
    -- 34251-34763
    if (index >= 34251 and index < 34763) then
        i = (index - 34251) / 64
        index = (index - 34251) % 64
        statName = mpx .. "DLC12022PSTAT_BOOL" .. i
    end
    return statName, index
end

function packed_funs.set_packed_bool(index, value)
    local statname, bitindex = get_packed_bool_date(index)
    if (statname ~= nil) then
        stats.set_bool_masked(statname, value, bitindex)
    end
end

function packed_funs.get_packed_bool(index)
    local statname, bitindex = get_packed_bool_date(index)
    if (statname ~= nil) then
        return stats.get_bool_masked(statname, bitindex)
    end
end

local function get_packed_int_date(index)
    local statName = nil
    local i = 0
    if (index >= 384 and index < 457) then
        i = (index - 384) / 8
        index = (index - 384) % 8 * 8
        statName = mpx .. "PSTAT_INT" .. i
    end
    if (index >= 1281 and index < 1305) then
        i = (index - 1281) / 8
        index = (index - 1281) % 8 * 8
        statName = "MP_PSTAT_INT" .. i
    end
    if (index >= 1361 and index < 1393) then
        i = (index - 1361) / 8
        index = (index - 1361) % 8 * 8
        statName = "MP_TUPSTAT_INT" .. i
    end
    if (index >= 1393 and index < 2919) then
        i = (index - 1393) / 8
        index = (index - 1393) % 8 * 8
        statName = mpx .. "TUPSTAT_INT" .. i
    end
    if (index >= 4143 and index < 4207) then
        i = (index - 4143) / 8
        index = (index - 4143) % 8 * 8
        statName = "MP_NGPSTAT_INT" .. i
    end
    if (index >= 3879 and index < 4143) then
        i = (index - 3879) / 8
        index = (index - 3879) % 8 * 8
        statName = mpx .. "NGPSTAT_INT" .. i
    end
    if (index >= 4399 and index < 6028) then
        i = (index - 4399) / 8
        index = (index - 4399) % 8 * 8
        statName = mpx .. "LRPSTAT_INT" .. i
    end
    if (index >= 6413 and index < 7262) then
        i = (index - 6413) / 8
        index = (index - 6413) % 8 * 8
        statName = mpx .. "APAPSTAT_INT" .. i
    end
    if (index >= 7262 and index < 7313) then
        i = (index - 7262) / 8
        index = (index - 7262) % 8 * 8
        statName = mpx .. "LR2PSTAT_INT" .. i
    end
    if (index >= 7313 and index < 7321) then
        i = (index - 7313) / 8
        index = (index - 7313) % 8 * 8
        statName = "MP_NGDLCPSTAT_INT" .. i
    end
    if (index >= 7641 and index < 7681) then
        i = (index - 7641) / 8
        index = (index - 7641) % 8 * 8
        statName = mpx .. "NGDLCPSTAT_INT" .. i
    end
    if (index >= 7681 and index < 9361) then
        i = (index - 7681) / 8
        index = (index - 7681) % 8 * 8
        statName = mpx .. "BIKEPSTAT_INT" .. i
    end
    if (index >= 9553 and index < 15265) then
        i = (index - 9553)/ 8
        index = (index - 9553) % 8 * 8
        statName = mpx .. "IMPEXPPSTAT_INT" .. i
    end
    if (index >= 15265 and index < 15369) then
        i = (index - 15265) / 8
        index = ((index - 15265) % 8) * 8
        statName = mpx .. "GUNRPSTAT_INT" .. i
    end
    if (index >= 16010 and index < 18098) then
        i = (index - 16010) / 8
        index = (index - 16010) % 8 * 8
        statName = mpx .. "DLCSMUGCHARPSTAT_INT" .. i
    end
    if (index >= 18162 and index < 19018) then
        i = (index - 18162) / 8
        index = (index - 18162) % 8 * 8
        statName = mpx .. "GANGOPSPSTAT_INT" .. i
    end
    if (index >= 19018 and index < 22066) then
        i = (index - 19018) / 8
        index = ((index - 19018) % 8) * 8
        statName = mpx .. "BUSINESSBATPSTAT_INT" .. i
    end
    if (index >= 22194 and index < 24962) then
        i = (index - 22194) / 8
        index = (index - 22194) % 8 * 8
        statName = mpx .. "ARENAWARSPSTAT_INT" .. i
    end
    if (index >= 25538 and index < 26810) then
        i = (index - 25538) / 8
        index = (index - 25538) % 8 * 8
        statName = mpx .. "CASINOPSTAT_INT" .. i
    end
    if (index >= 27258 and index < 28098) then
        i = (index - 27258) / 8
        index = (index - 27258) % 8 * 8
        statName = mpx .. "CASINOHSTPSTAT_INT" .. i
    end
    if (index >= 28483 and index < 30227) then
        i = (index - 28483) / 8
        index = (index - 28483) % 8 * 8
        statName = mpx .. "SU20PSTAT_INT" .. i
    end
    if (index >= 30483 and index < 30515) then
        i = (index - 30483) / 8
        index = (index - 30483) % 8 * 8
        statName = mpx .. "HISLANDPSTAT_INT" .. i
    end
    if (index >= 30707 and index < 31707) then
        i = (index - 30707) / 8
        index = (index - 30707) % 8 * 8
        statName = mpx .. "TUNERPSTAT_INT" .. i
    end
    if (index >= 32475 and index < 34123) then
        i = (index - 32475) / 8
        index = (index - 32475) % 8 * 8
        statName = mpx .. "FIXERPSTAT_INT" .. i
    end
    if (index >= 34763 and index < 36627) then
        i = (index - 34763) / 8
        index = (index - 34763) % 8 * 8
        statName = mpx .. "DLC12022PSTAT_INT" .. i
    end
    return statName, index
end

function packed_funs.set_packed_int(index, value)
    local statname, bitStart = get_packed_int_date(index)
    if (statname ~= nil) then
        stats.set_masked_int(statname, value, bitStart, 8)
    end
end

function packed_funs.get_packed_int(index)
    local statname, bitStart = get_packed_int_date(index)
    if (statname ~= nil) then
        return stats.get_masked_int(statname, bitStart, 8)
    end
end

return packed_funs
