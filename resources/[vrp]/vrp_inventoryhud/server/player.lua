local function getTarget(user_id)
    local id = openInventories[user_id]
    local split = splitString(id, ":")
    if split[1] == 'u' then
        local target = split[2]
        return target
    end

    return nil
end

function loadTargetInventory(player, user_id, target, target_id)
    local items, hotbarItems, weight, maxWeight = vRPin.getInventoryItems(target)
    INclient.openInventory(player, {"player"})
    INclient.setSecondInventoryItems(player, {items, weight, maxWeight})
    openInventories[user_id] = "u:" .. target_id
    vRPclient.playAnim(player,{true,{{"mini@repair","fixing_a_player",1}},true})
end

function loadTargetCheckInventory(player, user_id, target, target_id)
    local items, hotbarItems, weight, maxWeight = vRPin.getInventoryItems(target)
    vRP.prompt{player,'Jucator ID: ' ,'', function(player, target_id)
        target_id = parseInt(target_id)
		if(tonumber(target_id) and (target_id ~= "") and (target_id > 0)) then
            INclient.openInventory(player, {"player"})
            INclient.setSecondInventoryItems(player, {items, weight, maxWeight})
            openInventories[user_id] = "u:" .. target_id

        --vRPclient.playAnim(player,{true,{{"mini@repair","fixing_a_player",1}},true})
        end
    end}
end

-- vRP.registerMenuBuilder({"admin", function(add, data)
-- 	local user_id = vRP.getUserId({data.player})
-- 	if user_id ~= nil then
-- 	  local choices = {}
	  
-- 	  if vRP.isUserAdministrator({user_id}) then
--         choices["Check Inventory"] = loadTargetCheckInventory
-- 	  end

-- 	  add(choices)
-- 	end
--   end})


function vRPin.putIntoPlayer(idname, amount)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local target_id = getTarget(user_id)
    if target_id ~= nil then
        local new_weight = vRP.getInventoryWeight({target_id})+vRP.getItemWeight({idname})*amount
        if new_weight <= vRP.getInventoryMaxWeight({target_id}) then
            if vRP.tryGetInventoryItem({user_id,idname,amount,true}) then
                vRP.giveInventoryItem({target_id,idname,amount,true})

                vRPclient.playAnim(player,{true,{{"mp_common","givetake1_a",1}},false})
                vRPclient.playAnim(target,{true,{{"mp_common","givetake2_a",1}},false})
            end
        else
            vRPclient.notifyerror(player,{"Inventarul jucatorului e full"})
        end

        loadTargetInventory(player, user_id, target)
        INclient.loadPlayerInventory(player)
    end
end

function vRPin.takeFromPlayer(idname, amount)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local target_id = getTarget(user_id)
    if target_id ~= nil then
        local new_weight = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({idname})*amount
        if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
            if vRP.tryGetInventoryItem({target_id,idname,amount,true}) then
                vRP.giveInventoryItem({user_id,idname,amount,true})

                vRPclient.playAnim(player,{true,{{"mp_common","givetake1_a",1}},false})
                vRPclient.playAnim(target,{true,{{"mp_common","givetake2_a",1}},false})
            end
        else
            vRPclient.notifyerror(player,{"Inventarul e full"})
        end

        loadTargetInventory(player, user_id, target)
        INclient.loadPlayerInventory(player)
    end
end