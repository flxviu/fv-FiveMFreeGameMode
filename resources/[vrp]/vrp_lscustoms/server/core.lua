local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface("vRP", "tunning")

vRPserver = {}
Tunnel.bindInterface("tunning", vRPserver)

function vRPserver.getMoney()
    local player = source
    local user_id = vRP.getUserId({player})
    if (user_id ~= nil) then
        return vRP.getMoney({user_id})
    else
        DropPlayer(player, "Reilable Network Overflow")
    end
end

RegisterServerEvent('lls-mechanic:removeMoney')
AddEventHandler('lls-mechanic:removeMoney', function(amount, vname, tunning)
    local player = source
    local user_id = vRP.getUserId({player})
    local amount = tonumber(amount)
    if (not amount or amount <= 0) or (tunning == nil or tunning == {}) then return end;

    if (user_id ~= nil) then
        vRPclient.getNearestOwnedVehicle(player,{1},function(ok,vtype,name)
            if ok and (vname == name) then
                if vRP.tryPayment({user_id,amount}) then
                    vRPclient.notify(player,{"Succes: ~w~Ai tunat masina cu succes"})
                    Wait(500)
                    exports.oxmysql:execute("UPDATE vrp_user_vehicles SET upgrades = @upgrades WHERE user_id = @user_id AND vehicle = @vehicle", {["@user_id"] = user_id, ["@vehicle"] = vname, ["@upgrades"] = json.encode(tunning)})
                else
                    vRPclient.notify(player,{"Eroare: ~w~Nu ai destui bani la tine"})
                end
            end
        end)
    else
        DropPlayer(player, "Reilable Network Overflow")
    end
end)