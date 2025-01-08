local cooldown = {}
local spCars = {}
local spTags = {}
spUtils = {}
local function sp_fixCar(player, choice)
	local user_id = vRP.getUserId(player)
	if not cooldown[user_id] then cooldown[user_id] = 0 end
	if (os.time() - cooldown[user_id]) < 1800 then 
		TriggerClientEvent("chatMessage", player, '^0Ai cooldown ^1'..(1800 - (os.time() - cooldown[user_id]))..' secunde ^0pentru Sponsor Menu')
		return
	else
		cooldown[user_id] = os.time()
		TriggerClientEvent('murtaza:fix', player)
		vRPclient.notify(player, {" ~w~Ti-ai reparat vehiculul!"})
		local time = os.date("%d/%m/%Y - %X")
		local embed = {
			{
				["color"] = "15158332",
				["type"] = "rich",
				["text"] = ""..time.."",
				["description"] = "**"..GetPlayerName(player).."["..user_id.."] a folosit a folosit fix din Sponsor Menu"
			}
		  }
		
		PerformHttpRequest('https://discord.com/api/webhooks/1321589680000729139/v8odqolgtOBSb9dSoey2GILo8mhB3pKNFiCU4mjsrkP5Izk0rp5us3HcON1VkdMkWx7c', function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' }) 
		end
end





local function sp_weapons(player, choice)
		local user_id = vRP.getUserId(player)
		if not cooldown[user_id] then cooldown[user_id] = 0 end
		if (os.time() - cooldown[user_id]) < 1800 then 
			TriggerClientEvent("chatMessage", player, '^0Ai cooldown ^1'..(1800 - (os.time() - cooldown[user_id]))..' secunde ^0pentru Sponsor Menu')
			return
		else
			cooldown[user_id] = os.time()
		vRPclient.giveWeapons(player,{{
			["WEAPON_COMBATMG"] = {ammo=100},
			["WEAPON_ASSAULTSMG"] = {ammo=100},
			["WEAPON_SWITCHBLADE"] = {ammo=1},
	
		}})
		vRPclient.notify(player, {"~w~Ai primit pachetul de ~y~Arme!"})
		local time = os.date("%d/%m/%Y - %X")
		local embed = {
			{
				["color"] = "15158332",
				["type"] = "rich",
				["text"] = ""..time.."",
				["description"] = "**"..GetPlayerName(player).."["..user_id.."] a folosit a folosit kit arme din Sponsor Menu"
			}
		  }
		
		PerformHttpRequest('https://discord.com/api/webhooks/1321589680000729139/v8odqolgtOBSb9dSoey2GILo8mhB3pKNFiCU4mjsrkP5Izk0rp5us3HcON1VkdMkWx7c', function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' })
		TriggerClientEvent("chatMessage",-1,"^4"..GetPlayerName(player)..'['..user_id..'] si-a dat arme din Sponsor Menu')
 end
end

local function sp_revive(player, choice)
    local user_id = vRP.getUserId({player})
    if not user_id then
        return
    end

    if not cooldown[user_id] then cooldown[user_id] = 0 end

    if (os.time() - cooldown[user_id]) < 1800 then 
        TriggerClientEvent("chatMessage", player, '^0Ai cooldown ^1'..(1800 - (os.time() - cooldown[user_id]))..' secunde ^0pentru Sponsor Menu')
        return
    else
        cooldown[user_id] = os.time()
        vRPclient.varyHealth(player,{200})
        
        vRPclient.notify(player, {"~y~Sponsor: ~w~Ti-ai refacut viata!"})
        TriggerClientEvent("chatMessage",-1,"^3"..GetPlayerName(player).." ^0a folosit revive din meniul de ^3Sponsor.")
    end
end


local function sp_spawnCar(player, choice)
	local user_id = vRP.getUserId(player)
	if not cooldown[user_id] then cooldown[user_id] = 0 end
	if (os.time() - cooldown[user_id]) < 1800 then 
		TriggerClientEvent("chatMessage", player, '^0Ai cooldown ^1'..(1800 - (os.time() - cooldown[user_id]))..' secunde ^0pentru Sponsor Menu')
		return
	else
		cooldown[user_id] = os.time()
	vRPclient.spawnSponsorCar(player, {})
 end
end

local function cleancar(player, choice)
	local user_id = vRP.getUserId(player)
	if not cooldown[user_id] then cooldown[user_id] = 0 end
	if (os.time() - cooldown[user_id]) < 1800 then 
		TriggerClientEvent("chatMessage", player, '^0Ai cooldown ^1'..(1800 - (os.time() - cooldown[user_id]))..' secunde ^0pentru Sponsor Menu')
		return
	else
		cooldown[user_id] = os.time()
	TriggerClientEvent('carwash:success', player)
	end
end

vRP.registerMenuBuilder("main", function(add, data)
	local user_id = vRP.getUserId(data.player)
	if user_id ~= nil then
		local choices = {}
		if vRP.isUserSponsors(user_id) then
			choices["💸 Sponsor Menu"] = {function(player,choice)
				vRP.buildMenu("💸 Sponsor Menu", {player = player}, function(menu)
					menu.name = "💸 Sponsor Menu"
					menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
					menu.onclose = function(player) vRP.openMainMenu(player) end -- nest menu
					menu["Fix Masina"] = {sp_fixCar,"🔧 > Fix vehicle"}
					menu["Spala Masina"] = {cleancar,"🔧 > Spala masina"}
					menu["Revive"] = {sp_revive,"🏥 > Revive"}
					menu["Pachet Arme"] = {sp_weapons,"🔫 > Pachet Arme"}
					menu["Masina Sponsor"] = {sp_spawnCar,"🏎️ > Spawn Sponsor Car"}
					vRP.openMenu(player,menu)
				end)
			end, "💸Facilitati sponsor💸"}
		end
		add(choices)
	end
end)

function tvRP.denySponsorCarDriving()
	local player = source
	local user_id = vRP.getUserId(player)
	if not(vRP.isUserSponsors(user_id))then
		vRPclient.denySponsorCarDriving(source, {})
	end
end

AddEventHandler("vRP:playerLeave", function(user_id)
	if(spCars[user_id] ~= nil)then
		vRPclient.deleteSponsorCar(-1, {spCars[user_id]})
		spCars[user_id] = nil
	end
	if(spTags[user_id] ~= nil)then
		spTags[user_id] = nil
	end
end)

 
