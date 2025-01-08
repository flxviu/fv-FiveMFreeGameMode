local getLocalPed = PlayerPedId
local getECoords = GetEntityCoords
local yieldThread = Citizen.Wait

--local cachedPed = 0xff

_GPED = getLocalPed()
_PLAYERCOORDS = getECoords(_GPED)

local updateGlobalVariables = function()
    while 1 do
        _GPED = getLocalPed()
        _PLAYERCOORDS = getECoords(_GPED)
        yieldThread(430)
    end
end

CreateThread(updateGlobalVariables)

