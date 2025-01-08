local Drops = {}
local lastId = 1

function getDropId(user_id)
    local id = openInventories[user_id]
    if id ~= nil then
        local split = splitString(id, ":")
        if split[1] == 'drop' then
            if Drops[tonumber(split[2])] ~= nil then
                return tonumber(split[2])
            end
        end
    end

    local newDrop = createNewDrop(GetEntityCoords(GetPlayerPed(vRP.getUserSource({user_id}))))
    openInventories[user_id] = "drop:" .. newDrop
    return newDrop
end

function getNearestDrop(pos)
    local nearestId = nil

    for id, drop in pairs(Drops) do
        if #(pos - drop.position) < 5 then
            nearestId = id
        end
    end

    -- if nearestId == nil then
    --     nearestId = createNewDrop(pos)
    -- end

    return nearestId
end

function createNewDrop(pos)
    local id = lastId

    while Drops[id] ~= nil do
        id = id + 1
    end

    lastId = id

    Drops[id] = {
        position = pos,
        items = {}
    }

    return id
end

function loadDropItems(player, dropId)
    local items = {}

    if dropId ~= nil then
        for k,v in pairs(Drops[dropId].items) do
            local item_name,description,weight = vRP.getItemDefinition({k})
            table.insert(items, {
                label = item_name,
                count = v.amount,
                description = description,
                name = k,
                weight = weight
            })
        end
    end

    INclient.setSecondInventoryItems(player, {items, 0, 0, "Drop"})
end

function refreshDropItems(dropId)
    for user_id, inv in pairs(openInventories) do
        if string.find(inv, "drop") then
            local actualDropId = getDropId(user_id)
            if actualDropId == dropId then
                local player = vRP.getUserSource({user_id})
                loadDropItems(player, dropId)
            end
        end
    end
    
    if next(Drops[dropId].items) == nil then
        Drops[dropId] = nil
    end

    INclient.setDrops(-1, {Drops})
end

function vRPin.openDrop(player, user_id)
    local pos = GetEntityCoords(GetPlayerPed(player))
    local dropId = getNearestDrop(pos)

    if dropId ~= nil then
        openInventories[user_id] = "drop:" .. dropId
    end
    
    loadDropItems(player, dropId)
    INclient.openInventory(player, {"drop"})
end

function vRPin.putIntoDrop(idname, amount)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local dropId = getDropId(user_id)
    if dropId ~= nil then
        local greutate = true															--[[Adaugate]]--
        if idname == "rucsac" or idname == "rucsac2" or idname == "rucsac3" then	--[[Adaugate]]--
            greutate = vRP.setRucsac({user_id,0})										--[[Adaugate]]--
        end																			--[[Adaugate]]--
        if greutate then 																--[[Adaugate]]--
            if amount >= 0 then
                if string.find(idname,"WEAPON_") then
                    local hotbarItems = vRPin.getHotbarItems(player)
                    print("amount ",amount,vRP.getInventoryItemAmount{user_id,idname})
                    if amount == vRP.getInventoryItemAmount{user_id,idname} then
                        print("hbitems",json.encode(hotbarItems))
                        for k, v in pairs(hotbarItems) do
                            if v.name == idname then
                                TriggerClientEvent("axr:takeWeaponFromHotbar",player,idname)
                                TriggerClientEvent("axr:removeWeaponTBL", player, idname)
                                Hotbars[user_id][v.slot] = nil
                                print("eliminat ",idname)
                            end
                        end
                    end
                end
                vRP.tryGetInventoryItem({user_id, idname, amount, true})
            end
            vRPclient.playAnim(player, {true, {{"pickup_object", "pickup_low", 1}}, false})
            refreshDropItems(dropId)
            INclient.loadPlayerInventory(player)
        else 																		--[[Adaugate]]--
            vRPclient.notify(player,{"~r~Goliti mai intai rucsacul."})				--[[Adaugate]]--
        end																			--[[Adaugate]]--
    end
end

function vRPin.takeFromDrop(idname, amount)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local dropId = getDropId(user_id)
    if dropId ~= nil then
        local items = Drops[dropId].items or {}
        local citem = items[idname]
        if amount >= 0 and amount <= citem.amount then
            vRP.giveInventoryItem({user_id, idname, amount, true})
            citem.amount = citem.amount-amount

            if citem.amount <= 0 then
                items[idname] = nil -- remove item entry
            end

            Drops[dropId].items = items
        end

        refreshDropItems(dropId)
        INclient.loadPlayerInventory(player)
    end
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
    if first_spawn then
        INclient.setDrops(source, {Drops})
    end
end)


function vRPin.removeItem(tipo, nome, count)
	local _source = source
	local user_id = vRP.getUserId({_source})
	vRP.trash({user_id,nome,count})
	INclient.loadPlayerInventory(_source)
end