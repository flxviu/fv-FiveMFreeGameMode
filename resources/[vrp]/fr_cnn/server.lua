local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","fr_cnn")

-- SelectPlayerNumber = function(user_id)
--     local rows = exports.oxmysql:executeSync("SELECT id FROM vrp_users WHERE id = @id",{id = id})[1]
--     if rows.phone then
--         return rows.phone
--     end
--     return "Necunoscut"
-- end

local cld = {}
RegisterNetEvent("CNN:Create",function(aType)
    local user_id = vRP.getUserId{source};
    if not user_id then return end;
    if not aType then return end;
    if cld[user_id] ~= nil then return vRPclient.notify(source,{"Mai trebuie sa astepti "..cld[user_id] - os.time().." de secunde daca doresti sa dai un anunt nou !"}) ;end
    if aType == "comercial" then;
        if vRP.tryPayment{user_id,50000} then;
            vRP.prompt{source , "Ce anunt doresti sa pui ?","",function(source, message);
                local mess = tostring(message);
                if mess then
                    if cld[user_id] == nil then
                        vRPclient.notify(source,{"Ai dat cu succes un anunt, acesta va fii afisat in 30 de secunde !"})
                        TriggerClientEvent("1TAP__CNN:NextPost",-1,tostring(mess),"comercial");
                    end
                else
                    vRPclient.notify(source,{"Trebuie sa pui un Mesaj."})
                end
            end}
        else
            vRPclient.notify(source,{"Nu ai 50.000$ in Buzunar"})
        end
    elseif aType == "event" then
        if vRP.tryPayment{user_id,50000} then;
            vRP.prompt{source , "Ce anunt doresti sa pui ?","",function(source, message);
                local mess = tostring(message);
                if mess then
                    if cld[user_id] == nil then
                        vRPclient.notify(source,{"Ai dat cu succes un anunt, acesta va fii afisat in 30 de secunde !"})
                        cld[user_id] = os.time() + 60
                        TriggerClientEvent("1TAP__CNN:NextPost",-1,tostring(mess),"event");
                    end
                else
                    vRPclient.notify(source,{"Trebuie sa pui un Mesaj."})
                end
            end}
        else
            vRPclient.notify(source,{"Nu ai 50.000$ in Buzunar"})
        end
    end;
    local stopCld = function()
        cld[user_id] = nil
    end
    Citizen.SetTimeout(30000,stopCld)
end)

AddEventHandler("vRP:playerLeave",function(user_id, source)
    cld[user_id] = nil
end)