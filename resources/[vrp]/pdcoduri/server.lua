local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","admm_Comenzi")


RegisterCommand('codurion', function(source)
    local user_id = vRP.getUserId({source})
    local politie = vRP.isUserInFaction({user_id,"Politie"})
    local jandarmerie = vRP.isUserInFaction({user_id, "Jandarmerie"})
    if not politie or jandarmerie then return vRPclient.notify(source,{'Nu esti Politist'})  end
    local coduri =  TriggerClientEvent("Politie:coduri",source)
  return coduri
end)

  RegisterCommand('codurioff', function(source)
    local user_id = vRP.getUserId({source})
    local politie = vRP.isUserInFaction({user_id,"Politie"})
    local jandarmerie = vRP.isUserInFaction({user_id, "Jandarmerie"})
    if not politie or jandarmerie then return vRPclient.notify(source,{'Nu esti Politist'})  end
    local coduri =  TriggerClientEvent("Politie:codur2i",source)
  return coduri
end)
