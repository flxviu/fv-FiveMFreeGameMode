local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "sx_jobs");

local sxJobs = {}
Tunnel.bindInterface("sx_jobs", sxJobs)
Proxy.addInterface("sx_jobs", sxJobs)
local sxJobsC = Tunnel.getInterface("vRP", "sx_jobs")

sxJobs["hasItemAmount"] = function(nume, amount, boolean)
    local user_id = vRP["getUserId"]{source}
    if not user_id then return end;
    if vRP["getInventoryItemAmount"]{user_id, nume, amount, boolean} then
        return true
    else
        return false
    end
end