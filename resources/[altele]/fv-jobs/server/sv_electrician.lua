local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "ug-jobs")
local electricianTable = {};

RegisterNetEvent('sxint:generateElectricianMission',function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end; 
    local job = vRP.hasGroup{user_id, "Electrician"};
    if not job then return vRPclient.notify(player,{"Nu esti angajat ca Electrician!"}) end;
    electricianTable[user_id] = true;
    vRPclient.notify(player,{"Ai inceput tura la Electrician!"});
    TriggerClientEvent("UG:StartElectrician",player,true);
    TriggerClientEvent('UG:RegenerateElectrician',player,math.random(#Config.ElectricianLocations));
end)    

RegisterNetEvent("sxint:stopElectrician",function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    if electricianTable[user_id] then
        TriggerClientEvent("UG:StartElectrician",player,false);
        electricianTable[user_id] = nil;
    else
        return vRPclient.notify(player, {"Nu te afli in tura!"});
    end
end)

RegisterNetEvent('UG:GiveElectricianReward',function(cp)
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    if electricianTable[user_id] then
        local myPed = GetPlayerPed(player);
        local pCoords = GetEntityCoords(myPed);
        local job = vRP.hasGroup{user_id, "Electrician"};
        if not job then return DropPlayer(player, "[sAC]: Numai incerca boss!") end;
        if #(pCoords - cp) > 5 then return DropPlayer(player, "[sAC]: Numai incerca boss!") end;
        TriggerClientEvent('UG:RegenerateElectrician',player,math.random(#Config.ElectricianLocations));
        vRPclient.notify(player, {"Un punct catre alt stalp de electricitate ti-a fost pus pe GPS."})
        local thePay = math.random(5000,12000);
        vRPclient.notify(player, {"Ai primit $"..thePay.." pentru munca depusa!"})
        vRP.giveMoney({user_id, thePay})
    else    
        return DropPlayer(player, "[sAC]: Shawarma cu mujdei 🤮");
    end
end)

AddEventHandler('vRP:playerLeave',function(user_id)
    if electricianTable[user_id] then 
        electricianTable[user_id] = nil;
    end
end)