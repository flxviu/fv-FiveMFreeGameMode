local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "sx_jobs");

local gunoierTable = {};

RegisterNetEvent('sxint:generateGunoierMission',function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    local job = vRP.hasGroup{user_id, "Gunoier"};
    if not job then return vRPclient.notify(player,{"Nu esti angajat ca Gunoier!"}) end;
    gunoierTable[user_id] = true;
    vRPclient.notify(player,{"Ai inceput tura de Gunoier!"});
    TriggerClientEvent("UG:RegenerateGunoier",player,math.random(#Config.GarbageLocations));
    TriggerClientEvent('UG:StartGunoierJob',player,true);
end)

RegisterNetEvent("sxint:stopGunoier",function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    if gunoierTable[user_id] then
        TriggerClientEvent("UG:StartGunoierJob",player,false);
        gunoierTable[user_id] = nil;
    else
        return vRPclient.notify(player, {"Nu te afli in tura!"});
    end
end)

RegisterNetEvent('UG:IncreaseGunoaie',function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    if not gunoierTable[user_id] then return DropPlayer(player, "[sAC]: Jana usor zdreant-o! #ws633") end;
    TriggerClientEvent("UG:RegenerateGunoier",player,math.random(#Config.GarbageLocations));
    -- gunoierTable[user_id].litres = (gunoierTable[user_id].litres or 0) + math.random(3);  
end)

RegisterNetEvent('UG:GetGunoierMoney',function(data)
    local player = source;
    local user_id = vRP.getUserId{player};
    if not (data or user_id or cp) then return end;
    if gunoierTable[user_id] then
        local myPed = GetPlayerPed(player);
        local myCoords = GetEntityCoords(myPed);
        if #(myCoords - data) < 25 then
            local job = vRP.hasGroup{user_id, "Gunoier"};
            if not job then return DropPlayer(player, "[sAC]: De ce tot incerci fratiuere?") end;
            local rWs = math.random(7500, 15000);
            vRP.giveMoney{user_id, rWs};
            vRPclient.notify(player,{"Ai terminat o tura si ai fost recompensat cu $"..vRP.formatMoney({rWs})});
            TriggerClientEvent("UG:RegenerateGunoier",player,math.random(#Config.GarbageLocations));
        else
            return DropPlayer(player, "[sAC]: Propendo labirindo #62");
        end
    else
        return DropPlayer(player, "[sAC]: Ai cel mai mare cod de pe planeta marte!");
    end
end)

AddEventHandler('vRP:playerLeave',function(user_id)
    if gunoierTable[user_id] then
        gunoierTable[user_id] = nil;
    end;
end)