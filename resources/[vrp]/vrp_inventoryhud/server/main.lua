
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPin = {}
Tunnel.bindInterface("vrp_inventoryhud",vRPin)
Proxy.addInterface("vrp_inventoryhud",vRPin)
INclient = Tunnel.getInterface("vrp_inventoryhud","vrp_inventoryhud")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_inventoryhud")

openInventories = {}
Hotbars = {}
vTypes = {}

RegisterCommand("hb",function ()
	print(json.encode(Hotbars))
end)

function sendLogs (message,webhook)
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ content = message }), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('toDiscord')
AddEventHandler('toDiscord', function(message, webhook)
	sendLogs(message , webhook)
end)

RegisterServerEvent("inventory_hud:sendDiscordLog")
AddEventHandler("inventory_hud:sendDiscordLog", function(type,msg,action)
	local src = source
	local user_id = vRP.getUserId{src}
	if user_id then
		if not vRP.isAdmin({user_id}) then
			local embed = {
				{
					["color"] = 0x0FFFF00,
					["type"] = "rich",
					["author"] = {
						["name"] = GetPlayerName(src).." ["..user_id.."] - "..type,
						["icon_url"] = "https://cdn.discordapp.com/attachments/676818781473079309/1093523522975961169/logo.png"
					} ,   
					["description"] = "**Event:** "..msg.."\n Action: "..action,                                            
					["footer"] = {
					["text"] = os.date("%d/%m/%y").." - "..os.date("%H:%M")
					}
				}
			}
			PerformHttpRequest('https://discord.com/api/webhooks/1321589993197535333/OMSFZyVhmj1HYgCHqpCaWmF25G-epRN306VJS82i33mtfRogV07ASfDgjeMZQbOrTwkY', function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' })
			-- if action == "KICK" then
			-- 	DropPlayer(src, msg)
			-- end
		end
	end
end)
function vRPin.requestItemGive(idname, amount)
	local _source = source
	local user_id = vRP.getUserId({_source})
	local player = vRP.getUserSource({user_id})
	if user_id ~= nil then
	  	-- get nearest player
	  	vRPclient.getNearestPlayer(player,{10},function(nplayer)
			local nuser_id = vRP.getUserId({nplayer})
			if nuser_id ~= nil then
				        -- weight check
		local greutate = true																--[[Adaugate]]--
		if idname == "rucsac" or idname == "rucsac2" or idname == "rucsac3" then		--[[Adaugate]]--
			greutate = vRP.setRucsac({user_id,0})											--[[Adaugate]]--
		end																				--[[Adaugate]]--
		if greutate then																	--[[Adaugate]]--
				local new_weight = vRP.getInventoryWeight({nuser_id})+vRP.getItemWeight({idname})*amount
				if new_weight <= vRP.getInventoryMaxWeight({nuser_id}) then
					if string.find(idname,"WEAPON_") then
						local hotbarItems = vRPin.getHotbarItems(player)
						for k, v in pairs(hotbarItems) do
							if v.name == idname then
								TriggerClientEvent("axr:takeWeaponFromHotbar",player,idname)
								TriggerClientEvent("axr:removeWeaponTBL", player, idname)
								Hotbars[user_id][v.slot] = nil
							end
						end
					end
					if vRP.tryGetInventoryItem({user_id,idname,amount,true}) then
						vRP.giveInventoryItem({nuser_id,idname,amount,true})
						vRPclient.playAnim(player,{true,{{"mp_common","givetake2_a",1}},false})
						vRPclient.playAnim(nplayer,{true,{{"mp_common","givetake2_a",1}},false})
						local embed = {
							{
								["color"] = 0xcf0000,
								["title"] = "OFERA ITEM INVENTAR",
								["description"] = "Jucatorul "..GetPlayerName(player).." ["..user_id.."] i-a oferit lui "..GetPlayerName(nplayer).."  ["..nuser_id.."] itemul "..vRP.getItemName({idname}).." . Numar bucati: "..parseInt(amount).."",
								["thumbnail"] = {
									["url"] = "https://media.discordapp.net/attachments/945841155998904400/1076957758571692052/gangsterv2.png",
								},
							}
						}
						PerformHttpRequest('https://discord.com/api/webhooks/1321589993197535333/OMSFZyVhmj1HYgCHqpCaWmF25G-epRN306VJS82i33mtfRogV07ASfDgjeMZQbOrTwkY', function(err, text, headers) end, 'POST', json.encode({embeds = embed}), {['Content-Type'] = 'application/json'})
					end
				else
					vRPclient.notifyerror(player,{"Inventar FULL"})
				end
			else  																--[[Adaugate]]--
				vRPclient.notify(player,{"Goliti mai intai rucsacul."})		--[[Adaugate]]--
			end																	--[[Adaugate]]--
			else
				vRPclient.notifyerror(player,{"Niciun jucator in apropiere"})
			end
	  	end)
	end
  
	INclient.loadPlayerInventory(player)
end



function vRPin.requestItemUse(idname)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local choice = vRP.getItemChoices({idname})
	if string.find(idname, "WEAPON_") and  not (string.find(idname, "ammo-"))  and not (string.find(idname, "_supressor")) and not (string.find(idname, "_clip")) and not (string.find(idname, "_flash")) and not (string.find(idname, "_grip")) and not (string.find(idname, "_skin")) and not (string.find(idname, "_scope")) then 
		INclient.equipWeapon(player, {idname})
	else
		for key, value in pairs(choice) do 
			if key ~= "Give" and key ~= "Trash" then
				local cb = value[1]
				cb(player,key)
				INclient.loadPlayerInventory(player)
				INclient.notifyinfo(player, {{name = idname, label = vRP.getItemName({idname}), count = 1}, "Used"})
			end
		end
	end
end

function vRPin.requestReload(weapon, ammo)
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then
		local ammoItem = vRPin.getAmmoNeed(source,weapon)
		if ammoItem then
			local maxAmmo = vRP.getInventoryItemAmount({user_id, ammoItem})
			if maxAmmo >= ammo then 
				vRP.tryGetInventoryItem({user_id, ammoItem, ammo,true}) 
				return true,ammo
			else 
				vRP.tryGetInventoryItem({user_id, ammoItem, maxAmmo, true}) 
				INclient.notifyinfo(source, {{name = ammoItem, label = vRP.getItemName({ammoItem}), count = ammo-maxAmmo}, "Missing"})
				return true,maxAmmo
			end
		end
	end
end

function vRPin.holstered(weapon, ammo)
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then
		local ammoItem = vRPin.getAmmoNeed(source,weapon)
		vRP.giveInventoryItem({user_id, ammoItem, ammo, true})
	end
end

function vRPin.requestPutHotbar(idname, amount, slot, from)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if user_id ~= nil then
		if from ~= nil then
			Hotbars[user_id][from] = nil
		end

		Hotbars[user_id][slot] = idname

		INclient.loadPlayerInventory(player)
	end
end

RegisterServerEvent("vrp_inventoryhud:RemoveWeaponsFromHotbar")
AddEventHandler("vrp_inventoryhud:RemoveWeaponsFromHotbar",function (source)
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then
		if Hotbars[user_id] then
			for k,v in pairs(Hotbars[user_id]) do
				if string.find(v,"WEAPON_") then
					TriggerClientEvent("axr:takeWeaponFromHotbar",source,v)
					Hotbars[user_id][k] = nil
					INclient.loadPlayerInventory(source)
				end
			end
		end
		INclient.loadPlayerInventory(source)
	end
end)

function vRPin.requestRemoveHotbar(slot)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if user_id ~= nil then
		-- if Hotbars[user_id] then
		-- 	if Hotbars[user_id][slot] then
			if string.find(Hotbars[user_id][slot],"WEAPON_") then
				TriggerClientEvent("axr:takeWeaponFromHotbar",player,Hotbars[user_id][slot])
			end
				Hotbars[user_id][slot] = nil
				INclient.loadPlayerInventory(player)
			
			end
	-- 	end
	-- end
end

function vRPin.useHotbarItem(slot)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if user_id ~= nil and Hotbars[user_id] ~= nil then
		local idname = Hotbars[user_id][slot]
		if idname ~= nil then
			vRPin.requestItemUse(idname)
			local amount = vRP.getInventoryItemAmount({user_id,idname})
			if amount < 1 then
				Hotbars[user_id][slot] = nil
			end
		end
	end
end

function vRPin.getHotbarItems(player)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		local hotbarItems = {}
		if Hotbars[user_id] ~= nil then
			for slot, idname in pairs(Hotbars[user_id]) do
				local item_name, description = vRP.getItemDefinition({idname})
				local amount = vRP.getInventoryItemAmount({user_id,idname})
				if amount > 0 then
					table.insert(hotbarItems, {
						label = item_name,
						count = amount,
						description = description,
						name = idname,
						slot = slot
					})
				end
			end
		end

		return hotbarItems
	end
end

function vRPin.closeInventory(type)
	local user_id = vRP.getUserId({source})
	if type == "trunk" then
		vRPclient.stopAnim(source, {false})
		if vTypes[user_id] ~= nil then
			vRPclient.vc_closeDoor(vTypes[user_id][1], {vTypes[user_id][2],5})
			vTypes[user_id] = nil
		end
	end
	openInventories[user_id] = nil
end

RegisterServerEvent("deschideinv")
AddEventHandler("deschideinv", function(player)
	local user_id = vRP.getUserId({player})
	local nuser_id = vRP.getUserId({nplayer})
	if nuser_id ~= nil then
					loadTargetInventory(player, user_id, nplayer, nuser_id)
					return
			end
		vRPin.openDrop(player, user_id)
	end)

function vRPin.inventoryOpened(player)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		vRPclient.getNearestOwnedVehicle(player,{3},function(ok,vtype,name)
			if ok then
				INclient.isIsideACar(player, {}, function(inside)
					if inside then
						openGlovebox(player, user_id, user_id, name,vtype)
						return
					else
						openTrunk(player, user_id, user_id, name, vtype)
						return
					end
				end)
			end
		end)

		vRPclient.getNearestPlayer(player,{2},function(nplayer)
			local nuser_id = vRP.getUserId({nplayer})
			if nuser_id ~= nil then
				vRPclient.isInComa(nplayer,{}, function(inComa)
					vRPclient.isHandcuffed(nplayer,{}, function(isHandcuffed)
						if inComa or isHandcuffed then
							loadTargetInventory(player, user_id, nplayer, nuser_id)
							return
						end
					end)
				end)
			end
		end)

		vRPin.openDrop(player, user_id)
		-- INclient.openInventory(player, {'normal'})
	end
end

function vRPin.getInventoryItems(player)
	local user_id = vRP.getUserId({player})
	local data = vRP.getUserDataTable({user_id})
	local weight = vRP.getInventoryWeight({user_id})
	local max_weight = vRP.getInventoryMaxWeight({user_id})
	local items = {}
	local hotbarItems = {}

	if Hotbars[user_id] == nil then
		Hotbars[user_id] = {}
	end

	for k,v in pairs(data.inventory) do 
		local item_name, description, weight = vRP.getItemDefinition({k})
		local found = false

		if item_name ~= nil then
			for slot, idname in pairs(Hotbars[user_id]) do
				if idname == k then
					found = true
					table.insert(hotbarItems, {
						label = item_name,
						count = v.amount,
						description = description,
						name = idname,
						weight = weight,
						slot = slot
					})
				end
			end

			if not found then
				table.insert(items, {
					label = item_name,
					count = v.amount,
					description = description,
					weight = weight,
					name = k
				})
			end
        end
    end

	return items, hotbarItems, weight, max_weight
end
