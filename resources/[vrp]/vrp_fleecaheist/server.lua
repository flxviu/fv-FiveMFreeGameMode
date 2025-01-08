local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPCfleeca = Tunnel.getInterface("vrp_fleeca","vrp_fleeca")
vRPSfleeca = {}
Tunnel.bindInterface("vrp_fleeca",vRPSfleeca)
Proxy.addInterface("vrp_fleeca",vRPSfleeca)
vRP = Proxy.getInterface("vRP")
ServerPlayers = true
Doors = {
    ["Alta"] = {{loc = vector3(312.93, -284.45, 54.16), h = 160.91, txtloc = vector3(312.93, -284.45, 54.16), obj = nil, locked = true}, {loc = vector3(310.93, -284.44, 54.16), txtloc = vector3(310.93, -284.44, 54.16), state = nil, locked = true}},
    ["Vinewood"] = {{loc = vector3(-1209.66, -335.15, 37.78), h = 213.67, txtloc = vector3(-1209.66, -335.15, 37.78), obj = nil, locked = true}, {loc = vector3(-1211.07, -336.68, 37.78), txtloc = vector3(-1211.07, -336.68, 37.78), state = nil, locked = true}},
    ["Highway"] = {{loc = vector3(-2957.26, 483.53, 15.70), h = 267.73, txtloc = vector3(-2957.26, 483.53, 15.70), obj = nil, locked = true}, {loc = vector3(-2956.68, 481.34, 15.70), txtloc = vector3(-2956.68, 481.34, 15.7), state = nil, locked = true}},
    ["Burton"] = {{loc = vector3(-351.97, -55.18, 49.04), h = 159.79, txtloc = vector3(-351.97, -55.18, 49.04), obj = nil, locked = true}, {loc = vector3(-354.15, -55.11, 49.04), txtloc = vector3(-354.15, -55.11, 49.04), state = nil, locked = true}},
    ["Desert"] = {{loc = vector3(1174.24, 2712.47, 38.09), h = 160.91, txtloc = vector3(1174.24, 2712.47, 38.09), obj = nil, locked = true}, {loc = vector3(1176.40, 2712.75, 38.09), txtloc = vector3(1176.40, 2712.75, 38.09), state = nil, locked = true}},
}

function vRPSfleeca.CheckCop()
    local xPlayer = vRP.getUserId({source})
	if vRP.isUserInFaction({user_id, "Politie"}) then
		TriggerClientEvent('utk_fh:IsCop', source)
	else
		TriggerClientEvent('utk_fh:IsNOTCop',source)
	end
end

 
RegisterServerEvent("utk_fh:startcheck")
AddEventHandler("utk_fh:startcheck", function(bank)
    local _source = source
    local copcount = 0
    local Players = vRP.getUsers()
    local user_id = vRP.getUserId{source}
    cops = vRP.getOnlineUsersByFaction({"Politie"})
    for i = 1, #Players, 1 do
        local xPlayer = vRP.getUserId({Players[i]})
        if vRP.isUserInFaction({Players[i], "Politie"}) then
            copcount = copcount + 1
            print(copcount)
            
        end
    end
    local xPlayer = vRP.getUserId({_source})
    local item = vRP.getInventoryItemAmount({xPlayer,"secure_card"})
    if vRP.isUserInFaction({user_id, "Politie"}) then return  TriggerClientEvent("chatMessage", -1, "^2Lucid: Esti politist nu poti da jaf") end
    
        if tonumber(#cops) >= UTK.mincops then
        print(#cops)
        if item >= 1 then
             
            if not UTK.Banks[bank].onaction == true then
                if (os.time() - UTK.cooldown) > UTK.Banks[bank].lastrobbed then
                    UTK.Banks[bank].onaction = true
                    TriggerClientEvent("utk_fh:policenotify", -1, bank)
     
                    vRP.tryGetInventoryItem({xPlayer,"secure_card",1})
                    TriggerClientEvent("utk_fh:outcome", _source, true, bank)
                   
                    TriggerClientEvent("chatMessage", -1, "^2Lucid: ^0Tocmai ce a pornit un jaf la ^4banca " .. bank)
                else
                    TriggerClientEvent("chatMessage", _source,  "^2Lucid: ^0Banca asta a fost deja sparta si mai ai de asteptat ^4"..math.floor((UTK.cooldown - (os.time() - UTK.Banks[bank].lastrobbed)) / 60)..":"..math.fmod((UTK.cooldown - (os.time() - UTK.Banks[bank].lastrobbed)), 60))
                end
            else
                TriggerClientEvent("chatMessage", _source, "^2Lucid: ^0In momentul actual este un ^4jaf in desfasurare!")
            end
        else
            TriggerClientEvent("chatMessage", _source, "^2Lucid: ^0Nu detii un card de ^4securitate!")
        end
    else
        TriggerClientEvent("chatMessage", _source,  "^2Lucid: ^0Nu sunt destui ^4politisti ^0in oras!")
    end
end)
RegisterServerEvent("utk_fh:lootup")
AddEventHandler("utk_fh:lootup", function(var, var2)
    TriggerClientEvent("utk_fh:lootup_c", -1, var, var2)
end)
RegisterServerEvent("utk_fh:openDoor")
AddEventHandler("utk_fh:openDoor", function(coords, method)
    TriggerClientEvent("utk_fh:openDoor_c", -1, coords, method)
end)
RegisterServerEvent("utk_fh:toggleDoor")
AddEventHandler("utk_fh:toggleDoor", function(key, state)
    Doors[key][1].locked = state
    TriggerClientEvent("utk_fh:toggleDoor", -1, key, state)
end)
RegisterServerEvent("utk_fh:toggleVault")
AddEventHandler("utk_fh:toggleVault", function(key, state)
    Doors[key][2].locked = state
    TriggerClientEvent("utk_fh:toggleVault", -1, key, state)
end)
RegisterServerEvent("utk_fh:updateVaultState")
AddEventHandler("utk_fh:updateVaultState", function(key, state)
    Doors[key][2].state = state
end)
RegisterServerEvent("utk_fh:startLoot")
AddEventHandler("utk_fh:startLoot", function(data, name, players)
    local _source = source
    if ServerPlayers then
        TriggerClientEvent("utk_fh:startLoot_c", data, name)
    end
    TriggerClientEvent("utk_fh:startLoot_c", _source, data, name)
end)
function vRPSfleeca.primesterecompensa()
    local xPlayer = vRP.getUserId({source})
    local reward = math.random(UTK.mincash, UTK.maxcash)
    if UTK.black then
        vRP.giveInventoryItem({xPlayer,UTK.blackmoney, reward})
    else
        vRP.giveMoney({xPlayer,reward})
    end
end
RegisterServerEvent("utk_fh:setCooldown")
AddEventHandler("utk_fh:setCooldown", function(name)
    UTK.Banks[name].lastrobbed = os.time()
    UTK.Banks[name].onaction = false
    TriggerClientEvent("utk_fh:resetDoorState", -1, name)
end)
UTKFleeca.RegisterServerCallback("utk_fh:getBanks", function(source, cb)
    cb(UTK.Banks, Doors)
end)
UTKFleeca.RegisterServerCallback("utk_fh:checkSecond", function(source, cb)
    local xPlayer = vRP.getUserId({source})
    local item = vRP.getInventoryItemAmount({xPlayer,"secure_card",1})
    if item >= 1 then
        vRP.tryGetInventoryItem({xPlayer,"secure_card",1})
        cb(true)
    else
        cb(false)
    end
end)
 