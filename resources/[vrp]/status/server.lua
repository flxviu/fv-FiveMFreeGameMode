local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

local vRP = Proxy.getInterface("vRP")
local vRPclient = Tunnel.getInterface("vRP", GetCurrentResourceName())
local vRPhudC = Tunnel.getInterface("vms_subway", "vms_subway")

local vRPhudS = {}
Tunnel.bindInterface("vms_subway", vRPhudS)
Proxy.addInterface("vms_subway", vRPhudS)


function vRPhudS.setShit()
    local _src = source
    local user_id = vRP.getUserId({_src})
    if user_id ~= nil then
        vRP.varyCaca({user_id,-100})
    end
end

function vRPhudS.setPee()
    local _src = source
    local user_id = vRP.getUserId({_src})
    if user_id ~= nil then
        vRP.varyPipi({user_id,-100})
    end
end

function vRPhudS.setIgiena()
    local _src = source
    local user_id = vRP.getUserId({_src})
    if user_id ~= nil then
        vRP.varyJeg({user_id,-100})
    end
end

local requests = {}

function requestsv(source, text, cb)
    if not requests[source] then
        requests[source] = cb
        vRPhudC.sendRequst(source, { text })
    else
        cb(false)
    end
end

exports("requestsv", requestsv)

vRPhudS.requestresponse = function(response)
    requests[source](response)
    requests[source] = nil

    print(position)
end
