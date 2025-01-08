local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "ug-jobs")

local gradinarTable = {};

RegisterServerEvent('sxint:generateGradinarMission',function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    local job = vRP.hasGroup{user_id, "Gradinar"};
    if not job then return vRPclient.notify(player,{"Nu esti angajat ca Gradinar!"}) end;
    gradinarTable[user_id] = true;
    vRPclient.notify(player,{"Ai inceput tura de gradinar!"});
    TriggerClientEvent("UG:StartGradinar",player,true);
    TriggerClientEvent('UG:GradinarGenerateMission',player,math.random(#Config.GradinarLocations));
end)    

RegisterServerEvent("sxint:stopGradinar",function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    if gradinarTable[user_id] then
        TriggerClientEvent("UG:StartGradinar",player,false);
        gradinarTable[user_id] = nil;
    else
        return vRPclient.notify(player, {"Nu te afli in tura!"});
    end
end)

RegisterServerEvent('sxint:angajeazaElectrician',function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    if vRP.getUserHoursPlayed{user_id} >= Config.oreJoburi["Electrician"] then
        vRP.addUserGroup{user_id,"Electrician"}
        if vRP.hasGroup{user_id, "Somer"} then
            vRP.removeUserGroup{user_id,"Somer"}
        end
        vRPclient.notify(player, {"Te-ai angajat ca Electrician"});
    else
        return vRPclient.notify(player,{"Nu te poti angaja deoarece iti trebuiesc "..Config.oreJoburi["Electrician"].." (de) ore jucate."})
    end
end)

RegisterServerEvent('sxint:angajeazaGradinar',function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    if vRP.getUserHoursPlayed{user_id} >= Config.oreJoburi["Gradinar"] then
        vRP.addUserGroup{user_id,"Gradinar"}
        if vRP.hasGroup{user_id, "Somer"} then
            vRP.removeUserGroup{user_id,"Somer"}
        end
        vRPclient.notify(player, {"Te-ai angajat ca Gradinar"});
    else
        return vRPclient.notify(player,{"Nu te poti angaja deoarece iti trebuiesc "..Config.oreJoburi["Gradinar"].." (de) ore jucate."})
    end
end)

RegisterServerEvent('sxint:angajeazaGunoier',function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    if vRP.getUserHoursPlayed{user_id} >= Config.oreJoburi["Gunoier"] then
        vRP.addUserGroup{user_id,"Gunoier"}
        if vRP.hasGroup{user_id, "Somer"} then
            vRP.removeUserGroup{user_id,"Somer"}
        end
        vRPclient.notify(player, {"Te-ai angajat ca Gunoier"});
    else
        return vRPclient.notify(player,{"Nu te poti angaja deoarece iti trebuiesc "..Config.oreJoburi["Gunoier"].." (de) ore jucate."})
    end
end)

RegisterServerEvent('sxint:angajeazaMiner',function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    if vRP.getUserHoursPlayed{user_id} >= Config.oreJoburi["Miner"] then
        vRP.addUserGroup{user_id,"Miner"}
        if vRP.hasGroup{user_id, "Somer"} then
            vRP.removeUserGroup{user_id,"Somer"}
        end
        vRPclient.notify(player, {"Te-ai angajat ca Miner"});
    else
        return vRPclient.notify(player,{"Nu te poti angaja deoarece iti trebuiesc "..Config.oreJoburi["Miner"].." (de) ore jucate."})
    end
end)

RegisterServerEvent('sxint:angajeazaPescar',function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    if vRP.getUserHoursPlayed{user_id} >= Config.oreJoburi["Pescar"] then
        vRP.addUserGroup{user_id,"Pescar"}
        if vRP.hasGroup{user_id, "Somer"} then
            vRP.removeUserGroup{user_id,"Somer"}
        end
        vRPclient.notify(player, {"Te-ai angajat ca Pescar"});
    else
        return vRPclient.notify(player,{"Nu te poti angaja deoarece iti trebuiesc "..Config.oreJoburi["Pescar"].." (de) ore jucate."})
    end
end)

RegisterServerEvent('sxint:angajeazaSantierist',function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    if vRP.getUserHoursPlayed{user_id} >= Config.oreJoburi["Santierist"] then
        vRP.addUserGroup{user_id,"Santierist"}
        if vRP.hasGroup{user_id, "Somer"} then
            vRP.removeUserGroup{user_id,"Somer"}
        end
        vRPclient.notify(player, {"Te-ai angajat ca  Santierist"});
    else
        return vRPclient.notify(player,{"Nu te poti angaja deoarece iti trebuiesc "..Config.oreJoburi["Santierist"].." (de) ore jucate."})
    end
end)

RegisterServerEvent('sxint:angajeazaAutobuz',function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    if vRP.getUserHoursPlayed{user_id} >= Config.oreJoburi["Sofer Autobuz"] then
        vRP.addUserGroup{user_id,"Sofer Autobuz"}
        if vRP.hasGroup{user_id, "Somer"} then
            vRP.removeUserGroup{user_id,"Somer"}
        end
        vRPclient.notify(player, {"Te-ai angajat ca Sofer de Autobuz"});
    else
        return vRPclient.notify(player,{"Nu te poti angaja deoarece iti trebuiesc "..Config.oreJoburi["Sofer Autobuz"].." (de) ore jucate."})
    end
end)

RegisterServerEvent('sxint:angajeazaLemne',function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    if vRP.getUserHoursPlayed{user_id} >= Config.oreJoburi["Taietor Lemne"] then
        vRP.addUserGroup{user_id,"Taietor Lemne"}
        if vRP.hasGroup{user_id, "Somer"} then
            vRP.removeUserGroup{user_id,"Somer"}
        end
        vRPclient.notify(player, {"Te-ai angajat ca Taietor de Lemne"});
    else
        return vRPclient.notify(player,{"Nu te poti angaja deoarece iti trebuiesc "..Config.oreJoburi["Taietor Lemne"].." (de) ore jucate."})
    end
end)

RegisterServerEvent('sxint:devinoSomer',function()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    if vRP.hasGroup{user_id, "Taietor Lemne"} then vRP.removeUserGroup{user_id, "Taietor Lemne"}; vRP.addUserGroup{user_id,"Somer"} end;
    if vRP.hasGroup{user_id, "Sofer Autobuz"} then vRP.removeUserGroup{user_id, "Sofer Autobuz"}; vRP.addUserGroup{user_id,"Somer"} end;
    if vRP.hasGroup{user_id, "Santierist"} then vRP.removeUserGroup{user_id, "Santierist"}; vRP.addUserGroup{user_id,"Somer"} end;
    if vRP.hasGroup{user_id, "Pescar"} then vRP.removeUserGroup{user_id, "Pescar"}; vRP.addUserGroup{user_id,"Somer"} end;
    if vRP.hasGroup{user_id, "Miner"} then vRP.removeUserGroup{user_id, "Miner"}; vRP.addUserGroup{user_id,"Somer"} end;
    if vRP.hasGroup{user_id, "Gunoier"} then vRP.removeUserGroup{user_id, "Gunoier"}; vRP.addUserGroup{user_id,"Somer"} end;
    if vRP.hasGroup{user_id, "Gradinar"} then vRP.removeUserGroup{user_id, "Gradinar"}; vRP.addUserGroup{user_id,"Somer"} end;
    if vRP.hasGroup{user_id, "Electrician"} then vRP.removeUserGroup{user_id, "Electrician"}; vRP.addUserGroup{user_id,"Somer"} end;
    vRPclient.notify(player,{"Succes: Ai devenit Somer!"})
end)

RegisterServerEvent('UG:FinishGradinarMission',function(data, cp)
    local player = source;
    local user_id = vRP.getUserId{player};
    if not (data or user_id or cp) then return end;
    if data > 17 and data < 1 then return DropPlayer(player, "[sAC]: Distrus de la narcotica #33") end;
    if gradinarTable[user_id] then
        local myPed = GetPlayerPed(player);
        local myCoords = GetEntityCoords(myPed);
        if #(myCoords - vector3(1913.6947021484,5007.9091796875,45.655475616455)) < 50 then
            local job = vRP.hasGroup{user_id, "Gradinar"};
            if not job then return DropPlayer(player, "[sAC]: De ce tot incerci fratiuere?") end;
            vRP.giveMoney{user_id, Config.GradinarLocations[cp].Money};
            vRPclient.notify(player,{"Ai terminat o tura si ai fost recompensat cu $"..Config.GradinarLocations[cp].Money});
            TriggerClientEvent('UG:GradinarGenerateMission', player, math.random(#Config.GradinarLocations));
        else
            return DropPlayer(player, "[sAC]: Propendo labirindo #22");
        end
    else
        return DropPlayer(player, "[sAC]: Ai cel mai mare cod de pe planeta marte!");
    end
end)

AddEventHandler('vRP:playerLeave',function(fratior)
    if gradinarTable[fratior] then
        gradinarTable[fratior] = nil;
    end
end)