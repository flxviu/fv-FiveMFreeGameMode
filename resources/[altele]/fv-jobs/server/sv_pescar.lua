local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "sx_jobs");

local pescarTable = {};

RegisterNetEvent('sxint:generateFisherMission',function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    local job = vRP.hasGroup{user_id, "Pescar"};
    if not job then return vRPclient.notify(player,{"Nu esti angajat ca Pescar!"}) end;
    pescarTable[user_id] = true;
    vRPclient.notify(player,{"Ai inceput tura de Pescar!"});
    TriggerClientEvent('UG:StartPescarJob',player,true);
end)

RegisterNetEvent("sxint:cumparaUndita",function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    vRP.prompt({player , "Cate undite doresti sa cumperi?", "", function(player, topoare)
        topoare = parseInt(topoare);
        if topoare > 0 then
            vRP.tryPayment{user_id,topoare*5000};
            vRP.giveInventoryItem({user_id, "undita", topoare})
            vRPclient.notify(player, {"Ai cumparat x"..topoare.." pentru $"..vRP.formatMoney({topoare*5000})});
        else
            return vRPclient.notify(player, {"Error: Nu poti cumpara sub 0 undite."});
        end
    end})
end)

RegisterNetEvent("sxint:stopPescar",function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    if pescarTable[user_id] then
        TriggerClientEvent("UG:StartPescarJob",player,false);
        pescarTable[user_id] = nil;
    else
        return vRPclient.notify(player, {"Nu te afli in tura!"});
    end
end)

RegisterNetEvent('sxint:giveRewardFish',function(cara)
    local player = source;
    local user_id = vRP.getUserId{player};
    if not (user_id or cara) then return end;
    local job = vRP.hasGroup{user_id, "Pescar"};
    if not job then return DropPlayer(player, "[sAC]: Numai incerca boss!") end;
    if not pescarTable[user_id] then return DropPlayer(player, "[sAC]: Scriptez nebunii #89") end;
    local myPed = GetPlayerPed(player);
    local pCoords = GetEntityCoords(myPed);
    if #(pCoords-cara) > 5.0 then return DropPlayer(player, "[sAC]: Antonio o beleste grav 🍆 #6969") end;
    local thePay = math.random(8000, 12500);
    vRP.giveMoney{user_id, thePay};
    vRPclient.notify(player, {"Ai fost platit cu $"..vRP.formatMoney{thePay}.." pentru munca depusa!"});
end)

RegisterNetEvent('UG:GiveMomeala',function(alineboss)
    local player = source;
    local user_id = vRP.getUserId{player};
    if not (user_id or alineboss) then return end;
    local job = vRP.hasGroup{user_id, "Pescar"};
    if not job then return DropPlayer(player, "[sAC]: Numai incerca boss!") end;
    local myPed = GetPlayerPed(player);
    local pCoords = GetEntityCoords(myPed);
    if #(pCoords-alineboss) > 40 then return DropPlayer(player, "[sAC]: Mochaita este homosexual - #47 exploit number") end;
    if not pescarTable[user_id] then return DropPlayer(player, "[sAC]: Sa-mi trag toata pula n neamu lu jasper - #577 exploit number") end;
    vRP.giveInventoryItem({user_id, "momeala", 1});
end)

vRP.defInventoryItem({"momeala","Momeala", function(args)
    local choices = {}
    return choices
end, 1.0})

vRP.defInventoryItem({"undita","Undita", function(args)
    local choices = {}
    return choices
end, 1.0})

AddEventHandler('vRP:playerLeave',function(tail)
    if pescarTable[tail] then
        pescarTable[tail] = nil;
    end
end)