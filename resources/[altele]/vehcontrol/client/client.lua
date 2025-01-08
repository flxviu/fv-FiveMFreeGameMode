local enabled = false
local player = false
local veh = 0
local vehicle_fuel = 0


RegisterNetEvent('veh:options')
AddEventHandler('veh:options', function()
    EnableGUI(true)
end)


Citizen.CreateThread(function()
    while true do
        player = PlayerPedId()
        veh = GetVehiclePedIsIn(player, false)
        if veh ~= 0 then
            local temp_veh_fuel = GetVehicleFuelLevel(veh)
            if temp_veh_fuel > 0 then
                vehicle_fuel = temp_veh_fuel
            end
        end
        Citizen.Wait(2000)
    end
end)


-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(0)
--         if IsDisabledControlJustPressed(1, 20) then
--             if IsPedInAnyVehicle(PlayerPedId(), false) then
--                 EnableGUI(not enabled)
--             end
--        end
--     end
-- end)



local justOpen = false

function EnableGUI(enable)
    if not justOpen then
        enabled = enable

        justOpen = true
        Citizen.CreateThread(function()
            Wait(1000)
            justOpen = false
        end)

        SetNuiFocus(enable, enable)

        SendNUIMessage({
            type = "enablecarmenu",
            enable = enable
        })
    end
end

function checkSeat(player, veh, seatIndex)
    local ped = GetPedInVehicleSeat(veh, seatIndex);
    if ped == player then
        return seatIndex;
    elseif ped ~= 0 then
        return false;
    else
        return true;
    end
end

-- Check vehicles doors etc and send to UI
function refreshUI()
    local settings = {}
    player = PlayerPedId()
    veh = GetVehiclePedIsIn(player, false)
    if veh ~= 0 then
        settings.seat1 = checkSeat(player, veh, -1)
        settings.seat2 = checkSeat(player, veh,  0)
        settings.seat3 = checkSeat(player, veh,  1)
        settings.seat4 = checkSeat(player, veh,  2)

        settings.doorAccess = settings.seat1 == -1 and true or false
        if GetVehicleDoorAngleRatio(veh, 0) ~= 0 then
            settings.door0 = true
        end
        if GetVehicleDoorAngleRatio(veh, 1) ~= 0 then
            settings.door1 = true
        end
        if GetVehicleDoorAngleRatio(veh, 2) ~= 0 then
            settings.door2 = true
        end
        if GetVehicleDoorAngleRatio(veh, 3) ~= 0 then
            settings.door3 = true
        end
        if GetVehicleDoorAngleRatio(veh, 4) ~= 0 then
            settings.hood = true
        end
        if GetVehicleDoorAngleRatio(veh, 5) ~= 0 then
            settings.trunk = true
        end

        if not IsVehicleWindowIntact(veh, 0) then
            settings.windowr1 = true
        end
        if not IsVehicleWindowIntact(veh, 1) then
            settings.windowl1 = true
        end
        if not IsVehicleWindowIntact(veh, 2) then
            settings.windowr2 = true
        end
        if not IsVehicleWindowIntact(veh, 3) then
            settings.windowl2 = true
        end

        local engine = GetIsVehicleEngineRunning(veh);
        -- local lockStatus = GetVehicleDoorLockStatus(veh)
        -- if (lockStatus == 1 or lockStatus == 0) and settings.seat1 == -1 then
        --     settings.engineAccess = true
        -- end
        if engine then
            settings.engine = true
        else
            settings.engine = false
        end

        SendNUIMessage({
            type = "refreshcarmenu",
            settings = settings
        })
    else
        SendNUIMessage({
            type = "resetcarmenu"
        })
    end
end

RegisterNUICallback('openDoor', function(data, cb)
    doorIndex = tonumber(data['doorIndex'])
    player = PlayerPedId()
    veh = GetVehiclePedIsIn(player, false)

    if veh ~= 0 then
        -- if doors are unlocked?
        -- if not GetVehicleDoorsLockedForPlayer(veh, player) then
        local lockStatus = GetVehicleDoorLockStatus(veh)
        if lockStatus == 1 or lockStatus == 0 then
            if (GetVehicleDoorAngleRatio(veh, doorIndex) == 0) then
                SetVehicleDoorOpen(veh, doorIndex, false, false)
            else
                SetVehicleDoorShut(veh, doorIndex, false)
            end
        end
    end
    cb('ok')
end)

local seatNames = {
    [-1] = "la volan",
    [0] = "pe scaunul din dreapta",
    [1] = "in spate pe stanga",
    [2] = "in spate pe dreapta"
}

local justMooved = false

RegisterNUICallback('switchSeat', function(data, cb)
    if not justMooved then
        justMooved = true
        Citizen.CreateThread(function()
            Wait(3000)
            justMooved = false
        end)

        seatIndex = tonumber(data['seatIndex'])
        player = PlayerPedId()
        veh = GetVehiclePedIsIn(player, false)
        if veh ~= 0 then
            -- May need to check if another player is in seat?
            TriggerEvent("3dme:display", "Se muta "..seatNames[seatIndex])
            SetPedIntoVehicle(player, veh, seatIndex)
        end
        cb('ok')
    end
end)

RegisterNUICallback('togglewindow', function(data, cb)
    windowIndex = tonumber(data['windowIndex'])
    player = PlayerPedId()
    veh = GetVehiclePedIsIn(player, false)
    if veh ~= 0 then
        if not IsVehicleWindowIntact(veh, windowIndex) then
            
            TriggerEvent("3dme:display", "Inchide geamul")
            RollUpWindow(veh, windowIndex)
            if not IsVehicleWindowIntact(veh, windowIndex) then
                RollDownWindow(veh, windowIndex)
            end
        else
            TriggerEvent("3dme:display", "Deschide geamul")
            RollDownWindow(veh, windowIndex)
        end
    end
    cb('ok')
end)

RegisterNUICallback('toggleengine', function(data, cb)
    player = PlayerPedId()
    veh = GetVehiclePedIsIn(player, false)
    if veh ~= 0 then
        local engine = not GetIsVehicleEngineRunning(veh)

        if not IsPedInAnyHeli(player) then
            SetVehicleEngineOn(veh, engine, false, true)
            SetVehicleJetEngineOn(veh, engine)
        else
            if engine then
                SetVehicleFuelLevel(veh, vehicle_fuel)
            else
                SetVehicleFuelLevel(veh, 0)
            end
        end
    end
    cb('ok')
end)

 RegisterNUICallback('escape', function(data, cb)
    EnableGUI(false)
    cb('ok')
end)


RegisterCommand('carcontrol', function()
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        EnableGUI(not enabled)
    end
end)

RegisterKeyMapping('carcontrol','carcontrol22','keyboard','M')