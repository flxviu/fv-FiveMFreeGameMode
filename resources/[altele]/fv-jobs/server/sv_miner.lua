local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "ug-jobs")

local minerTable = {};

RegisterNetEvent('sxint:generateMinerMission',function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    local job = vRP.hasGroup{user_id, "Miner"};
    if not job then return vRPclient.notify(player,{"Nu esti angajat ca Miner!"}) end;
    minerTable[user_id] = true;
    vRPclient.notify(player,{"Ai inceput tura de miner!"});
    TriggerClientEvent("UG:StartMinerJob",player,true);
    TriggerClientEvent('UG:RegenerateMiner',player,math.random(#Config.MinerLocations));
end)    

RegisterNetEvent("sxint:stopMiner",function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    if minerTable[user_id] then
        TriggerClientEvent("UG:StartMinerJob",player,false);
        minerTable[user_id] = nil;
    else
        return vRPclient.notify(player, {"Nu te afli in tura!"});
    end
end)

RegisterNetEvent('UG:FinishMineaza',function(amiriblugii)
    local player = source;
    local user_id = vRP.getUserId{player};
    if not (user_id or amiriblugii) then return end;
    if not minerTable[user_id] then return DropPlayer(player, "[sAC]: Sa-mi trag pula-n tro' Sandru auzi - exploit number #65") end;
    local job = vRP.hasGroup{user_id, "Miner"};
    if not job then return DropPlayer(player, "[sAC]: Sunt demonizat, demoni in cap - exploit number #204") end;
    local ping = GetPlayerPing(player);
    if ping > 500 then return DropPlayer(player, "[sAC] Exploit number #205 (daca ai luat kick degeaba te rugam sa ne lasi un mesaj pe discord!") end;
    local myPed = GetPlayerPed(player);
    -- local myCoords = GetEntityCoords(myPed);
    -- if #(myCoords-amiriblugii) > 5 then return DropPlayer(player, "[sAC]: Nebulla - exploit number #304") end;
    local thePay = math.random(10000,15000);
    TriggerClientEvent('UG:RegenerateMiner',player,math.random(#Config.MinerLocations));
    vRP.giveMoney({user_id, thePay});
    vRPclient.notfiy(player, {"Ai fost platit cu $"..vRP.formatMoney{thePay}.." pentru munca depusa!"});
end)

RegisterNetEvent('UG:GiveCarbune',function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    local job = vRP.hasGroup{user_id, "Miner"};
    if not job then return DropPlayer(player, "[sAC]: Ultima data a zis c-o omor - exploit number #305") end;
    if not minerTable[user_id] then return DropPlayer(player, "[sAC]: Sa ma cac in mormantu ma-tii astazi si maine - exploit number #693") end;
    vRP.giveInventoryItem({user_id, 'carbune', 1});
end)

RegisterNetEvent("sxint:cumparaTarnacop",function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    vRP.prompt({player , "Cate tarnacoape doresti sa cumperi?", "", function(player, tarnacoape)
        tarnacoape = parseInt(tarnacoape);
        if tarnacoape > 0 then
            vRP.tryPayment{user_id,tarnacoape*1000};
            vRP.giveInventoryItem({user_id, "pickaxe", tarnacoape})
            vRPclient.notify(player, {"Ai cumparat x"..tarnacoape.." pentru $"..vRP.formatMoney({tarnacoape*1000})});
        else
            return vRPclient.notify(player, {"Error: Nu poti cumpara sub 0 undite."});
        end
    end})
end)

AddEventHandler('vRP:playerLeave',function(i)
    if minerTable[i] then
        minerTable[i] = nil;
    end
end)