local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "ug-jobs")
BMclient = Tunnel["getInterface"]('vRP_basic_menu', 'vRP_basic_menu')

local yesTables = {
    ['topor'] = true,
    ['trusascule'] = true,
    ['undita'] = true,
    ['pickaxe'] = true;
}

RegisterNetEvent('UG:ItemUzat',function(idname)
    local player = source;
    local user_id = vRP.getUserId{player};
    if not (user_id or idname) then return end;
    if not yesTables[idname] then return DropPlayer(player, "[sAC]: Trappere nu esti hard bros!") end;
    vRP.tryGetInventoryItem({user_id, idname, 1});
    vRPclient.notify(player, {"Info: Tocmai ti-a fost uzat item-ul!"});
end)

local toporiscaTable = {};

RegisterNetEvent('sxint:generateTaietorLemneMission',function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end; 
    local job = vRP.hasGroup{user_id, "Taietor Lemne"};
    if not job then return vRPclient.notify(player,{"Nu esti angajat ca Taietor de lemne!"}) end;
    toporiscaTable[user_id] = true;
    vRPclient.notify(player,{"Ai inceput tura de taietor lemne!"});
    TriggerClientEvent("UG:StartTaietorLemne",player,true);
    TriggerClientEvent('UG:SetTLemneMission',player,math.random(#Config.TaietorLemne));
    vRPclient.teleport(player, {-570.52392578125,5262.5053710938,70.468772888184});
    BMclient.spawnVehicle(player, {"sadler2", "JOB"});
end)    

RegisterNetEvent("sxint:stopTLemne",function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    if toporiscaTable[user_id] then
        TriggerClientEvent("UG:StartTaietorLemne",player,false);
        toporiscaTable[user_id] = nil;
    else
        return vRPclient.notify(player, {"Nu te afli in tura!"});
    end
end)

RegisterNetEvent("sxint:cumparaTopor",function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    vRP.prompt({player , "Cate topoare doresti sa cumperi?", "", function(player, topoare)
        topoare = parseInt(topoare);
        if topoare > 0 then
            vRP.tryPayment{user_id,topoare*1000};
            vRP.giveInventoryItem({user_id, "topor", topoare})
            vRPclient.notify(player, {"Ai cumparat x"..topoare.." pentru $"..vRP.formatMoney({topoare*5000})});
        else
            return vRPclient.notify(player, {"Error: Nu poti cumpara sub 0 topoare."});
        end
    end})
end)

RegisterNetEvent('UG:GiveTaietorReward',function(cp)
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    if toporiscaTable[user_id] then
        local myPed = GetPlayerPed(player);
        local pCoords = GetEntityCoords(myPed);
        local job = vRP.hasGroup{user_id, "Taietor Lemne"};
        if not job then return DropPlayer(player,"[sAC] Dc esti Golan??") end;
        if #(pCoords - cp) > 5 then return DropPlayer(player, "[sAC]: Numai incerca boss!") end;
        TriggerClientEvent('UG:SetTLemneMission',player,math.random(#Config.TaietorLemne));
        vRPclient.notify(player, {"Un punct pentru alt copac ti-a fost pus pe GPS."})
        local thePay = math.random(990,10000);
        vRPclient.notify(player, {"Ai primit $"..thePay.." pentru munca depusa!"})
        vRP.giveMoney({user_id, thePay})
    else    
        return DropPlayer(player, "[sAC]: Shawarma cu mujdei 🤮");
    end
end)

AddEventHandler('vRP:playerLeave', function(user_id)
    if toporiscaTable[user_id] then
        toporiscaTable[user_id] = nil;
    end
end)