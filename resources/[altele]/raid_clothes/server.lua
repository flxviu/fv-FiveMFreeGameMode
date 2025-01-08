
local Proxy = module("lib/Proxy")
local Tunnel = module("lib/Tunnel")

local vRP = Proxy.getInterface("vRP")
local vRPclient = Tunnel.getInterface("vRP", "vRP_skins")

RegisterServerEvent("raid_clothes:insert_character_current")
AddEventHandler("raid_clothes:insert_character_current",function(data)
    if not data then return end
    local player = source
    local user_id = vRP.getUserId({player})
    if not user_id then return end
    local values = {
        user_id = user_id,
        model = data.model,
        drawables = data.drawables,
        props = data.props,
        drawtextures = data.drawtextures,
        proptextures = data.proptextures,
        eyeColor = data.eyeColor
    }

    vRP.setUData({user_id, "ped:clothes", json.encode(values)})
end)

RegisterServerEvent("raid_clothes:insert_character_face")
AddEventHandler("raid_clothes:insert_character_face",function(data)
    if not data then return end
    local player = source
    local user_id = vRP.getUserId({player})

    if not user_id then return end
    if data.headBlend == "null" or data.headBlend == nil then
        data.headBlend = {}
    else
        data.headBlend = data.headBlend
    end

    local values = {
        user_id = user_id,
        hairColor = data.hairColor,
        headBlend = data.headBlend,
        headOverlay = data.headOverlay,
        headStructure = data.headStructure
    }

    vRP.setUData({user_id, "ped:face", json.encode(values)})
end)

RegisterServerEvent("raid_clothes:get_character_face")
AddEventHandler("raid_clothes:get_character_face",function(pSrc)
    local player = (not pSrc and source or pSrc)
    local user_id = vRP.getUserId({player})
    if not user_id then return end
    
    vRP.getUData({user_id, "ped:face", function(preFace)
        local result = json.decode(preFace or "[]") or {}
        vRP.getUData({user_id, "ped:clothes", function(preClothes)
            local cc = json.decode(preClothes or "[]") or {}
            for k, v in pairs(cc) do result[k] = v end

            if #result > 0 then
                local temp_data = {
                    hairColor = result.hairColor,
                    headBlend = result.headBlend,
                    headOverlay = result.headOverlay,
                    headStructure = result.headStructure,
                }
                local model = tonumber(result.model)
                if model == 1885233650 or model == -1667301416 then
                    TriggerClientEvent("raid_clothes:setpedfeatures", player, temp_data)
                end
            else
                TriggerClientEvent("raid_clothes:setpedfeatures", player, false)
            end
        end})
    end})
end)

RegisterServerEvent("raid_clothes:load_ped")
AddEventHandler("raid_clothes:load_ped", function(pSrc)
    local player = pSrc
    if not pSrc and source then player = source end

    if player then
        local user_id = vRP.getUserId({player})
        vRP.getUData({user_id, "ped:face", function(preFace)
            local result = json.decode(preFace or "[]") or {}
            vRP.getUData({user_id, "ped:clothes", function(preClothes)
                local cc = json.decode(preClothes or "[]") or {}
                -- if vRP.isUserInFaction({user_id, "Hitman"}) then
                --     local startSkin = module(GetCurrentResourceName(), "startSkins")
                --     cc = json.decode(startSkin.hitman)
                -- end
                for k, v in pairs(cc) do result[k] = v end

                local cnt = 0
    			for k, v in pairs(result) do cnt = cnt + 1 end

                if cnt > 0 then
                    local temp_data = {
                        model = result.model,
                        drawables = result.drawables or {},
                        props = result.props or {},
                        drawtextures = result.drawtextures or {},
                        proptextures = result.proptextures or {},
                        hairColor = result.hairColor or {1, 1},
                        headBlend = result.headBlend or {},
                        headOverlay = result.headOverlay or {},
                        headStructure = result.headStructure or {},
                        eyeColor = result.eyeColor or 0
                    }

                    TriggerClientEvent("raid_clothes:load", player, temp_data)
                else
                	vRP.getUserIdentity({user_id, function(identity)
                		local temp_data = pickStartSkin(identity.sex)
                        TriggerClientEvent("raid_clothes:load", player, temp_data)
                	end})
                end
            end})
        end})
    end
end)

RegisterServerEvent("raid_clothes:get_character_current")
AddEventHandler("raid_clothes:get_character_current",function(pSrc)
    local player = (not pSrc and source or pSrc)
    local user_id = vRP.getUserId({player})

    if not user_id then return end
    vRP.getUData({user_id, "ped:clothes", function(preClothes)
        local result = json.decode(preClothes or "[]") or {}
        if #result > 0 then
            local temp_data = {
                model = result.model,
                drawables = result.drawables,
                props = result.props,
                drawtextures = result.drawtextures,
                proptextures = result.proptextures
            }
            TriggerClientEvent("raid_clothes:setclothes", player, temp_data)
        end
    end})
end)

RegisterServerEvent("raid_clothes:retrieve_tats")
AddEventHandler("raid_clothes:retrieve_tats", function(pSrc)
    local player = (not pSrc and source or pSrc)
    local user_id = vRP.getUserId({player})
    if vRP.getUserSource({user_id}) then
        vRP.getUData({user_id, "ped:Tatoos", function(preData)
            local data = json.decode(preData or "[]") or {}
            TriggerClientEvent("raid_clothes:settattoos", player, data)
        end})
    end
end)

RegisterServerEvent("raid_clothes:set_tats")
AddEventHandler("raid_clothes:set_tats", function(tattoosList)
    local player = source
    local user_id = vRP.getUserId({player})
    vRP.setUData({user_id, "ped:Tatoos", json.encode(tattoosList)})
end)

RegisterServerEvent("clothing:checkMoney")
AddEventHandler("clothing:checkMoney", function(menu, askingPrice)
    local player = source
    local user_id = vRP.getUserId({player})

    if not askingPrice then
        askingPrice = 0
    end

    if vRP.tryPayment({user_id, askingPrice, true, "Clothing Store"}) then
        TriggerClientEvent("raid_clothes:hasEnough",player,menu)
    end
end)

function pickStartSkin(sex)
	local startSkin = module(GetCurrentResourceName(), "startSkins")
    local data = {
        model = startSkin.model,
        drawables = startSkin.drawables,
        props = startSkin.props,
        drawtextures = startSkin.drawtextures,
        proptextures = startSkin.proptextures,
        hairColor = startSkin.hairColor,
        headBlend = startSkin.headBlend,
        headOverlay = startSkin.headOverlay,
        headStructure = startSkin.headStructure
    }
	if sex == "F" then -- feminin
	    data = json.decode(startSkin.feminin)
	end

    return data
end

local fixSkinCooldown = {}

local function updatePlayerClothes(user_id, byPassCooldown)
    local player = vRP.getUserSource({user_id})
    if player then
        if byPassCooldown or (fixSkinCooldown[user_id] or 0) <= os.time() then
            fixSkinCooldown[user_id] = os.time() + 30
            TriggerEvent("raid_clothes:load_ped", player)
            Citizen.CreateThread(function()
                Citizen.Wait(5000)
                TriggerEvent("raid_clothes:retrieve_tats", player)
            end)
        else
            vRPclient.notify(player, {"Cooldown "..(fixSkinCooldown[user_id] - os.time()).." secunde"})
        end
    end
end

RegisterCommand("fixskin2", function(player)
    local user_id = vRP.getUserId({player})
    
    if user_id then
        updatePlayerClothes(user_id)
    end
end)

RegisterServerEvent("raid-clothing:requestSkin")
AddEventHandler("raid-clothing:requestSkin", function(user_id)
    updatePlayerClothes(user_id, true)
end)


RegisterServerEvent("raid-clothing:requestCSkin")
AddEventHandler("raid-clothing:requestCSkin", function()
    local player = source
    local user_id = vRP.getUserId({player})
    updatePlayerClothes(user_id)
end)

AddEventHandler("vRP:playerSpawn", function(user_id, player, first_spawn)
    Citizen.Wait(500)
    updatePlayerClothes(user_id, true)
end)

AddEventHandler("onResourceStart", function(res)
    if res == GetCurrentResourceName() then
        local users = vRP.getUsers({})
        for user_id, source in pairs(users) do
            updatePlayerClothes(user_id, true)
        end
    end
end)