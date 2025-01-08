local Chests = {}

local function getChestMaxWeight(id)
    local s = splitString(id, ":")
    local type = s[1]

    local maxWeight = Config.DefaultChestMaxWeight

    if type == "trunk" then
        local vehicle = s[3]
        local thisWeight = Config.Trunks[vehicle]

        maxWeight = Config.DefaultTrunkWeight

        if thisWeight ~= nil then
            maxWeight = thisWeight
        end
    elseif type == "chest" then
        local chestId = s[2]
        if Config.Chests[chestId] ~= nil then
		local thisWeight = Config.Chests[chestId].maxWeight
        
		if thisWeight ~= nil then
		    maxWeight = thisWeight
		end
	end
    end

    return maxWeight
end

function vRPin.putIntoChest(idname, amount)
    local user_id = vRP.getUserId({source})
    local chestname = openInventories[user_id]
    local player = vRP.getUserSource({user_id})
    if chestname ~= nil then
        local items = Chests[chestname] or {}
        local greutate = true 																--[[Adaugate]]--
        if idname == "rucsac" or idname == "rucsac2" or idname == "rucsac3" then 	--[[Adaugate]]--
            greutate = vRP.setRucsac({user_id,0}) 											--[[Adaugate]]--
        end 																			--[[Adaugate]]--
        if greutate then 																	--[[Adaugate]]--
        local new_weight = vRP.computeItemsWeight({items})+vRP.getItemWeight({idname})*amount
        if new_weight <= getChestMaxWeight(chestname) then
            if amount >= 0 and vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                local citem = items[idname]

                if citem ~= nil then
                    citem.amount = citem.amount+amount
                else
                    items[idname] = {amount=amount}
                end

                Chests[chestname] = items
                local embed = {
                    {
                        ["color"] = 0xcf0000,
                        ["title"] = "" ..chestname,
                        ["description"] = "Jucatorul "..GetPlayerName(source).." ["..user_id.."] a pus in cufar/Portbagaj itemul "..vRP.getItemName({idname}).." . Numar bucati: "..parseInt(amount).."",
                        ["thumbnail"] = {
                            ["url"] = "https://media.discordapp.net/attachments/945841155998904400/1076957758571692052/gangsterv2.png",
                        },
                    }
                }
                PerformHttpRequest('https://discord.com/api/webhooks/1321589993197535333/OMSFZyVhmj1HYgCHqpCaWmF25G-epRN306VJS82i33mtfRogV07ASfDgjeMZQbOrTwkY', function(err, text, headers) end, 'POST', json.encode({embeds = embed}), {['Content-Type'] = 'application/json'})
            end
        else
            vRPclient.notifyerror(player,{"Cufar plin"})
        end
    else																		--[[Adaugate]]--
        vRPclient.notify(source,{"Ai rucsacul echipat."})			--[[Adaugate]]--
    end																			--[[Adaugate]]--

        Wait(20)
        vRPin.getChestItems(chestname, player)
        INclient.loadPlayerInventory(player)
    end
end

function vRPin.takeFromChest(idname, amount)
    local user_id = vRP.getUserId({source})
    local chestname = openInventories[user_id]
    local player = vRP.getUserSource({user_id})
    if chestname ~= nil then
        local items = Chests[chestname] or {}
        local citem = items[idname]
        if amount >= 0 and amount <= citem.amount then
            local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({idname})*amount
            if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
                vRP.giveInventoryItem({user_id, idname, amount, true})
                citem.amount = citem.amount-amount

                if citem.amount <= 0 then
                    items[idname] = nil -- remove item entry
                end

                Chests[chestname] = items

                local embed = {
                    {
                        ["color"] = 0xcf0000,
                        ["title"] = "" ..chestname,
                        ["description"] = "Jucatorul "..GetPlayerName(source).." ["..user_id.."] a scos din cufar/Portbagaj itemul "..vRP.getItemName({idname}).." . Numar bucati: "..parseInt(amount).."",
                        ["thumbnail"] = {
                            ["url"] = "https://media.discordapp.net/attachments/945841155998904400/1076957758571692052/gangsterv2.png",
                        },
                    }
                }
                PerformHttpRequest('https://discord.com/api/webhooks/1321589993197535333/OMSFZyVhmj1HYgCHqpCaWmF25G-epRN306VJS82i33mtfRogV07ASfDgjeMZQbOrTwkY', function(err, text, headers) end, 'POST', json.encode({embeds = embed}), {['Content-Type'] = 'application/json'})

            else
                vRPclient.notifyerror(player,{"Inventar plin"})
            end
        end

        Wait(20)
        vRPin.getChestItems(chestname, player)
        INclient.loadPlayerInventory(player)
    end
end

function vRPin.getChestItems(chestname, player, label)
    if Chests[chestname] then
        local weight = vRP.computeItemsWeight({Chests[chestname]})
        local max_weight = getChestMaxWeight(chestname)
        local items = {}
        for k,v in pairs(Chests[chestname]) do
            local item_name,description,weight = vRP.getItemDefinition({k})
			table.insert(items, {
				label = item_name,
				count = v.amount,
				description = description,
				name = k,
                weight = weight
			})
        end
        INclient.setSecondInventoryItems(player, {items, weight, max_weight, label})
    else
        vRP.getSData({chestname, function(cdata)
            local rawItems = json.decode(cdata) or {}
            local items = {}
            local weight = vRP.computeItemsWeight({rawItems})
            local max_weight = getChestMaxWeight(chestname)
            for k,v in pairs(rawItems) do
                local item_name,description,weight = vRP.getItemDefinition({k})
                table.insert(items, {
                    label = item_name,
                    count = v.amount,
                    description = description,
                    name = k,
                    weight = weight
                })
            end

            INclient.setSecondInventoryItems(player, {items, weight, max_weight, label})
            Chests[chestname] = rawItems
        end})
    end
end

function openTrunk(player, user_id, owner_id, vname, vtype)    
    local id = "trunk:user-" .. owner_id .. ":" .. string.lower(vname)
    if isChestFree(id) then
        openInventories[user_id] = id
        INclient.openInventory(player, {"trunk"})
        vRPin.getChestItems(id, player)
        local ownerSource = vRP.getUserSource({owner_id})
        vRPclient.vc_openDoor(ownerSource, {vtype,5})
        vTypes[user_id] = {ownerSource,vtype}
        vRPclient.playAnim(player,{true,{{"mini@repair","fixing_a_player",1}},true})
    else
        vRPclient.notifyerror(player,{"Portbagaju e futut"})
    end
end

function isChestFree(id)
    for user_id, chestId in pairs(openInventories) do
        if chestId == id then
            return false
        end
    end
    return true
end

function openChest(user_id, player, id, label)
    if isChestFree(id) then
        openInventories[user_id] = id
        INclient.openInventory(player, {"chest"})
        vRPin.getChestItems(id, player, label)
    else
        vRPclient.notifyerror(player,{"Cufarul e futut"})
    end
end
exports("openChest", openChest)

-- tasks
function task_save_chests()
    
    for k,v in pairs(Chests) do
        vRP.setSData({k,json.encode(v)})
    end
    
    SetTimeout(Config.ChestSaveTime*60*1000, task_save_chests)
end
task_save_chests()

vRP.registerMenuBuilder({"main", function(add, data)
    local user_id = vRP.getUserId({data.player})
    if user_id ~= nil then
        local choices = {}
        choices["Cere Portbagaj Masina"] = {function(player, choice)
            vRPclient.getNearestPlayer(player,{10},function(nplayer)
                local nuser_id = vRP.getUserId({nplayer})
                if nuser_id ~= nil then
                    vRP.request({nplayer,"Un jucator din-mprejur vrea sa se uita in portbagaju tau",15,function(nplayer,ok)
                        if ok then -- request accepted, open trunk
                            vRPclient.getNearestOwnedVehicle(nplayer,{7},function(ok,vtype,name)
                                if ok then
                                    -- local chestname = "trunk:user-" .. nuser_id .. ":" .. string.lower(name)
                                    -- openChest(user_id, player, chestname)
                                    openTrunk(player, user_id, nuser_id, name, vtype)
                                else
                                    vRPclient.notifyerror(player,{"Niciun vehicul imprejur"})
                                    vRPclient.notifyerror(nplayer,{"Niciun vehicul imprejur"})
                                end
                            end)
                        else
                            vRPclient.notifyerror(player,{"Jucatorul a refuzat"})
                        end
                    end})
                else
                    vRPclient.notifyerror(player,{"Niciun jucator in apropiere"})
                end
            end)
        end}

        add(choices)
    end
end})

function openGlovebox(player, user_id, owner_id, vname)    
    local id = "glovebox:user-" .. owner_id .. ":" .. string.lower(vname)
    if isChestFree(id) then
        openInventories[user_id] = id
        INclient.openInventory(player, {"glovebox"})
        vRPin.getChestItems(id, player)
        vRPclient.playAnim(player,{true,{{"mini@repair","fixing_a_player",1}},true})
    else
        vRPclient.notify(player,{"~r~Glovebox is busy."})
    end
end