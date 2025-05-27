local callbacks = {}

function callbacks.requestModel(hash, onSuccess)
	if STREAMING.IS_MODEL_VALID(hash) == 0 then return end
	local tries = 0
	while tries < 50 and STREAMING.HAS_MODEL_LOADED(hash) == 0 do
		STREAMING.REQUEST_MODEL(hash);
		tries = tries + 1
		system.yield(100)
	end
	if STREAMING.HAS_MODEL_LOADED(hash) == 1 then onSuccess() return end
end

function callbacks.requestAnimDict(dict, onSuccess)
	if STREAMING.DOES_ANIM_DICT_EXIST(dict) == 0 then return end
	local tries = 0
	while tries < 50 and STREAMING.HAS_ANIM_DICT_LOADED(dict) == 0 do
		STREAMING.REQUEST_ANIM_DICT(dict)
		tries = tries + 1
		system.yield()
	end
	if STREAMING.HAS_ANIM_DICT_LOADED(dict) == 1 then onSuccess() return end
end

function callbacks.requestWepAsset(asset, onSuccess)
	local ticks = 0
	while ticks < 50 and WEAPON.HAS_WEAPON_ASSET_LOADED(asset) == 0 do
		WEAPON.REQUEST_WEAPON_ASSET(asset, 31, 0)
		ticks = ticks + 1
		system.yield()
	end
	if WEAPON.HAS_WEAPON_ASSET_LOADED(asset) == 1 then onSuccess() return end
end

function callbacks.requestPtfxAsset(asset, onSuccess)
	local ticks = 0
	while ticks < 50 and STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) == 0 do 
		STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
		ticks = ticks + 1
		system.yield()
	end
	if STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) == 1 then onSuccess() return end
end

return callbacks