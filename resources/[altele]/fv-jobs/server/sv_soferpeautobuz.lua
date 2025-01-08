local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "ug-jobs")

local busDriverTable = {};

RegisterNetEvent('UG:RequestBusSpawn',function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    local job = vRP.hasGroup{user_id, "Sofer Autobuz"};
    if not job then return end;
    if not busDriverTable[user_id] then return DropPlayer(player, "[sAC]: (( Sa ma iei in gura ))") end;
    TriggerClientEvent('UG:AutobuzStartCursa',player);
end)

RegisterNetEvent('UG:GiveAutobuzMoney',function(cp)
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    if busDriverTable[user_id] then
        local myPed = GetPlayerPed(player);
        local pCoords = GetEntityCoords(myPed);
        if #(pCoords - cp) > 15 then return DropPlayer(player, "[sAC]: Numai incerca boss!") end;
        local thePay = math.random(50000,90000);
        vRPclient.notify(player, {"Ai primit $"..vRP.formatMoney{thePay}.." pentru munca depusa!"})
        vRP.giveMoney({user_id, thePay})
    else    
        return DropPlayer(player, "[sAC]: Shawarma cu mujdei 🤮");
    end
end)

RegisterNetEvent('sxint:startBusDriver',function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    local job = vRP.hasGroup{user_id, "Sofer Autobuz"};
    if not job then return vRPclient.notify(player, {"Error: Nu esti angajat ca Sofer de Autobuz."}) end;
    busDriverTable[user_id] = true;
    TriggerClientEvent('UG:StartSoferAutobuz',player, true);
    vRPclient.notify(player, {"Ai inceput tura ca Sofer de autobuz."});
end)

RegisterNetEvent("sxint:stopBusDriver",function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    if busDriverTable[user_id] then
        TriggerClientEvent("UG:StartSoferAutobuz",player,false);
        busDriverTable[user_id] = nil;
    else
        return vRPclient.notify(player, {"Nu te afli in tura!"});
    end
end)

AddEventHandler('vRP:playerLeave',function(l)
    if busDriverTable[l] then 
        busDriverTable[l] = nil;
    end
end)