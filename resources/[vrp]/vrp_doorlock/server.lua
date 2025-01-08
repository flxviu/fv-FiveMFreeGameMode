-- DA DA , SUNTETI DEVELOPERI BUNI JOIN PE SHOP DACA VREI MAI MULTE -> https://discord.gg/JUnemf8YuU
-- DA DA , SUNTETI DEVELOPERI BUNI JOIN PE SHOP DACA VREI MAI MULTE -> https://discord.gg/JUnemf8YuU
-- DA DA , SUNTETI DEVELOPERI BUNI JOIN PE SHOP DACA VREI MAI MULTE -> https://discord.gg/JUnemf8YuU
-- DA DA , SUNTETI DEVELOPERI BUNI JOIN PE SHOP DACA VREI MAI MULTE -> https://discord.gg/JUnemf8YuU
-- DA DA , SUNTETI DEVELOPERI BUNI JOIN PE SHOP DACA VREI MAI MULTE -> https://discord.gg/JUnemf8YuU
-- DA DA , SUNTETI DEVELOPERI BUNI JOIN PE SHOP DACA VREI MAI MULTE -> https://discord.gg/JUnemf8YuU
-- DA DA , SUNTETI DEVELOPERI BUNI JOIN PE SHOP DACA VREI MAI MULTE -> https://discord.gg/JUnemf8YuU
-- DA DA , SUNTETI DEVELOPERI BUNI JOIN PE SHOP DACA VREI MAI MULTE -> https://discord.gg/JUnemf8YuU
-- DA DA , SUNTETI DEVELOPERI BUNI JOIN PE SHOP DACA VREI MAI MULTE -> https://discord.gg/JUnemf8YuU
-- DA DA , SUNTETI DEVELOPERI BUNI JOIN PE SHOP DACA VREI MAI MULTE -> https://discord.gg/JUnemf8YuU
-- DA DA , SUNTETI DEVELOPERI BUNI JOIN PE SHOP DACA VREI MAI MULTE -> https://discord.gg/JUnemf8YuU
-- DA DA , SUNTETI DEVELOPERI BUNI JOIN PE SHOP DACA VREI MAI MULTE -> https://discord.gg/JUnemf8YuU

local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')

local vRP = Proxy.getInterface('vRP')
vRPdoors = {}
Tunnel.bindInterface("vRP_doors", vRPdoors)

local DoorInfo = {}

function vRPdoors.updateState(doorID,state)
    local users = vRP.getUsers({})
    DoorInfo[doorID] = {}
    DoorInfo[doorID].state = state
    DoorInfo[doorID].doorID = doorID
    for k,v in pairs(users) do
        TriggerClientEvent('vRP_doors:setdoorState', v, doorID, state)
    end
end

function vRPdoors.getDoorsInfo()
    return DoorInfo
end