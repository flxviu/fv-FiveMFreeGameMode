local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "sx_jobs");

local santieristTable = {};

RegisterNetEvent('sxint:startSantieristJob',function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end; 
    local job = vRP.hasGroup{user_id, "Santierist"};
    if not job then return vRPclient.notify(player,{"Nu esti angajat ca Santierist!"}) end;
    santieristTable[user_id] = true;
    vRPclient.notify(player,{"Ai inceput tura de Santierist!"});
    TriggerClientEvent("UG:ToggleSantierist",player,true);
    TriggerClientEvent('UG:GenerateSantierist',player);
end)    

RegisterNetEvent("sxint:stopSantieristJob",function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    if santieristTable[user_id] then
        TriggerClientEvent("UG:ToggleSantierist",player,false);
        santieristTable[user_id] = nil;
    else
        return vRPclient.notify(player, {"Nu te afli in tura!"});
    end
end)

RegisterNetEvent("sxint:cumparaScule",function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    vRP.prompt({player , "Cate truse doresti sa cumperi?", "", function(player, topoare)
        topoare = parseInt(topoare);
        if topoare > 0 then
            vRP.tryPayment{user_id,topoare*1000};
            vRP.giveInventoryItem({user_id, "trusascule", topoare})
            vRPclient.notify(player, {"Ai cumparat x"..topoare.." pentru $"..vRP.formatMoney({topoare*1000})});
        else
            return vRPclient.notify(player, {"Error: Nu poti cumpara sub 0 Truse."});
        end
    end})
end)

RegisterNetEvent('UG:GetSantieristMoney',function(cp)
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    local job = vRP.hasGroup{user_id, "Santierist"};
    if not job then return DropPlayer(player, "[sAC]: Shawarma cu mujdei 🤮"); end;
    if santieristTable[user_id] then
        local myPed = GetPlayerPed(player);
        local pCoords = GetEntityCoords(myPed);
        -- print(#(pCoords - cp));
        if #(pCoords - cp) > 50 then return DropPlayer(player, "[sAC]: Numai incerca boss!") end;
        TriggerClientEvent('UG:GenerateSantierist',player);
        -- vRPclient.notify(player, {"Un punct pentru alt copac ti-a fost pus pe GPS."})
        local thePay = math.random(950,10000);
        vRPclient.notify(player, {"Ai primit $"..thePay.." pentru munca depusa!"})
        vRP.giveMoney({user_id, thePay})

    else    
        return DropPlayer(player, "[sAC]: Shawarma cu mujdei 🤮");
    end
end)

AddEventHandler('vRP:playerLeave', function(user_id)
    if santieristTable[user_id] then
        santieristTable[user_id] = nil;
    end
end)