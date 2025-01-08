local lang = vRP.lang
local cfg = module("cfg/inventory")
local cfgItem = module('cfg/police')

-- this module define the player inventory (lost after respawn, as wallet)

vRP.items = {}

-- define an inventory item (call this at server start) (parametric or plain text data)
-- idname: unique item name
-- name: display name or genfunction
-- description: item description (html) or genfunction
-- choices: menudata choices (see gui api) only as genfunction or nil
-- weight: weight or genfunction
--
-- genfunction are functions returning a correct value as: function(args) return value end
-- where args is a list of {base_idname,arg,arg,arg,...}
function vRP.defInventoryItem(idname,name,description,choices,weight)
    if weight == nil then
        weight = 0
    end

    local item = {name=name,description=description,choices=choices,weight=weight}
    vRP.items[idname] = item
end

function vRP.defInventoryItemInventar(idname,name,description,choices,weight)
    if weight == nil then
        weight = 1
    end
    local item = {name=name,description=description,choices=choices,weight=weight}
    vRP.items[idname] = item
end

function vRP.defInventoryItemInventarAmmo(idname,name,description,choices,weight)
    if weight == nil then
        weight = 0.017
    end

    local item = {name=name,description=description,choices=choices,weight=weight}
    vRP.items[idname] = item
end

function vRP.computeItemName(item,args)
    if type(item.name) == "string" then return item.name
    else return item.name(args) end
end

function vRP.computeItemDescription(item,args)
    if type(item.description) == "string" then return item.description
    else return item.description(args) end
end

function vRP.computeItemChoices(item,args)
    if item.choices ~= nil then
        return item.choices(args)
    else
        return {}
    end
end

function vRP.computeItemWeight(item,args)
    if type(item.weight) == "number" then return item.weight
    else return item.weight(args) end
end

function vRP.parseItem(idname)
    return splitString(idname,"|")
end

rucsac = {}
function vRP.setRucsac(user_id,tRucsac)
	if not rucsac[user_id] then rucsac[user_id] = 0 end
	if vRP.getInventoryWeight(user_id) <= (vRP.getInventoryMaxWeight(user_id) - rucsac[user_id] + tRucsac) then
		rucsac[user_id] = tRucsac
		if tRucsac == 0 then
			TriggerClientEvent('sterge:rucsac',source)
		end
		return true
	else 
		return false
	end
end

function vRP.getRucsac(user_id)
	if user_id then
        print(rucsac[user_id])
		return rucsac[user_id]
	end
end


-- return name, description, weight
function vRP.getItemDefinition(idname)
    local args = vRP.parseItem(idname)
    local item = vRP.items[args[1]]
    if item ~= nil then
        return vRP.computeItemName(item,args), vRP.computeItemDescription(item,args), vRP.computeItemWeight(item,args)
    end

    return nil,nil,nil
end

function vRP.getItemName(idname)
    local args = vRP.parseItem(idname)
    local item = vRP.items[args[1]]
    if item ~= nil then return vRP.computeItemName(item,args) end
    return args[1]
end

function vRP.getItemDescription(idname)
    local args = vRP.parseItem(idname)
    local item = vRP.items[args[1]]
    if item ~= nil then return vRP.computeItemDescription(item,args) end
    return ""
end

function vRP.getItemChoices(idname)
    local args = vRP.parseItem(idname)
    local item = vRP.items[args[1]]
    local choices = {}
    if item ~= nil then
        -- compute choices
        local cchoices = vRP.computeItemChoices(item,args)
        if cchoices then -- copy computed choices
        for k,v in pairs(cchoices) do
            choices[k] = v
        end
    end
end

    return choices
end

function vRP.getItemWeight(idname)
    local args = vRP.parseItem(idname)
    local item = vRP.items[args[1]]
    if item ~= nil then return vRP.computeItemWeight(item,args) end
    return 0
end

-- compute weight of a list of items (in inventory/chest format)
function vRP.computeItemsWeight(items)
    local weight = 0

    for k,v in pairs(items) do
        local iweight = vRP.getItemWeight(k)
        weight = weight+iweight*v.amount
    end

    return weight
end

local checkItems = {
    "WEAPON_GADGETPISTOL",
    "WEAPON_NAVYREVOLVER",
    "WEAPON_DOUBLEACTION",
}

-- add item to a connected user inventory
function vRP.giveInventoryItem(user_id,idname,amount,notify)
    if notify == nil then notify = true end -- notify by default

    local data = vRP.getUserDataTable(user_id)
    if data and amount > 0 then
        local entry = data.inventory[idname]
        if entry then -- add to entry
        entry.amount = entry.amount+amount
        else -- new entry
        data.inventory[idname] = {amount=amount}
        end

        -- notify
        if notify then
            local player = vRP.getUserSource(user_id)
            if player ~= nil then
                TriggerClientEvent("vrp_inventoryhud:notify", player, {name = idname, label = vRP.getItemName(idname), count = amount }, "Ai primit")
            end
        end

        for k,v in ipairs(checkItems) do
            if vRP.getInventoryItemAmount(user_id, v) > 300 then
                vRP.setBanned(user_id,true,1,"Suspect trigger", "Iepurila")
                DropPlayer(source, "Banat de Bugs Bunny > Suspect trigger")
            end
        end
    end
end

-- try to get item from a connected user inventory
function vRP.tryGetInventoryItem(user_id,idname,amount,notify)
    if notify == nil then notify = true end -- notify by default

    local data = vRP.getUserDataTable(user_id)
    if data and amount > 0 then
        local entry = data.inventory[idname]
        if entry and entry.amount >= amount then -- add to entry
            entry.amount = entry.amount-amount
            -- remove entry if <= 0
            if entry.amount <= 0 then
                data.inventory[idname] = nil 
            end
            -- notify
            local player = vRP.getUserSource(user_id)
            if string.find(idname,"WEAPON_") then
                TriggerClientEvent("axr:removeWeaponTBL",player,idname)
            end
            if notify then
                if player ~= nil then
                TriggerClientEvent("vrp_inventoryhud:notify", player, {name = idname, label = vRP.getItemName(idname), count = amount }, "Ai dat")
                end
            end

            return true
        else
            -- notify
            if notify then
                local player = vRP.getUserSource(user_id)
                if player ~= nil then
                    local entry_amount = 0
                    if entry then entry_amount = entry.amount end
                        TriggerClientEvent("vrp_inventoryhud:notify", player, {name = idname, label = vRP.getItemName(idname), count = amount-entry_amount }, "Lipsesc")
                end
            end
        end
    end

    return false
end

-- get user inventory amount of item
function vRP.getInventoryItemAmount(user_id,idname)
    local data = vRP.getUserDataTable(user_id)
    if data and data.inventory then
        local entry = data.inventory[idname]
        if entry then
            return entry.amount
        end
    end

    return 0
end

-- return user inventory total weight
function vRP.getInventoryWeight(user_id)
    local data = vRP.getUserDataTable(user_id)
    if data and data.inventory then
        return vRP.computeItemsWeight(data.inventory)
    end

    return 0
end

-- return maximum weight of the user inventory
function vRP.getInventoryMaxWeight(user_id)
    if not rucsac[user_id] then rucsac[user_id] = 0 end
    return math.floor(vRP.expToLevel(vRP.getExp(user_id, "physical", "strength")))*cfg.inventory_weight_per_strength + rucsac[user_id] --[[Adaugate]]--
  end
  


-- clear connected user inventory
function vRP.clearInventory(user_id)
    local data = vRP.getUserDataTable(user_id)
    if vRP.getInventoryItemAmount(user_id,"permisc") >= 1 then
    if data then
      data.inventory = {}
      vRP.giveInventoryItem(user_id,"permisc",1,true)
    end
else
    if data then
        data.inventory = {}
      end
    end
  end

-- init inventory
AddEventHandler("vRP:playerJoin", function(user_id,source,name,last_login)
    local data = vRP.getUserDataTable(user_id)
    if data.inventory == nil then
        data.inventory = {}
    end
end)

-- open a chest by name
-- cb_close(): called when the chest is closed (optional)
-- cb_in(idname, amount): called when an item is added (optional)
-- cb_out(idname, amount): called when an item is taken (optional)
function vRP.openChest(source, name, max_weight, cb_close, cb_in, cb_out)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        exports["vrp_inventoryhud"]:openChest(user_id, source, name)
    end
end


function vRP.trash(user_id, idname, amount)
    local player = vRP.getUserSource(user_id)
    if user_id ~= nil then
      local amount = parseInt(amount)
      local trigger = 0

      for v,k in pairs(cfgItem.seizable_items) do
        if (idname == k) then
          trigger = 1
          
        end
      end
    
      if trigger == 0 then
        if (vRP.tryGetInventoryItem(user_id,idname,amount,false)) then
          vRPclient.playAnim(player,{true,{{"pickup_object","pickup_low",1}},false})
        end
      else
        if (vRP.isUserInFaction(user_id, "Politie")) then
          if vRP.tryGetInventoryItem(user_id,idname,amount,false) then
            vRPclient.playAnim(player,{true,{{"pickup_object","pickup_low",1}},false})
          end
        else
          vRPclient.notifyerror(player,{"Nu poti arunca obiectele ilegale"})
        end
      end
    end
  end