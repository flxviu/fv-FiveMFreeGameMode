vRP = Proxy.getInterface("vRP")

local radioMenu = false
local onRadio = false
local RadioChannel = 0

RegisterNetEvent('qb-radio:use')
AddEventHandler('qb-radio:use', function()
    toggleRadio(not radioMenu)
end)

RegisterCommand("radio", function()
    toggleRadio(not radioMenu)
end)

RegisterCommand("radiorp", function ()
    toggleRadio(not radioMenu)
end)

RegisterKeyMapping("radiorp", "Statie", "keyboard", "F2")

RegisterNetEvent('qb-radio:onRadioDrop')
AddEventHandler('qb-radio:onRadioDrop', function()
    if RadioChannel ~= 0 then
        leaveradio()
    end
end)

-- Main Thread

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        if onRadio then
            radio.TriggerServerCallback('qb-radio:server:GetItem', function(hasItem)
                if not hasItem then
                    if RadioChannel ~= 0 then
                        leaveradio()
                    end
                end
            end,"radio")
        end
    end
end)

-- Functions

function connecttoradio(channel)
    RadioChannel = channel
    if onRadio then
        exports["pma-voice"]:setRadioChannel(0)
    else
        onRadio = true
        exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
    end

    exports["pma-voice"]:setRadioChannel(channel)

    if SplitStr(tostring(channel), ".")[2] ~= nil and SplitStr(tostring(channel), ".")[2] ~= "" then
        vRP.notify({"You're connected to:"..channel.. ' MHz'})
    else
        vRP.notify({"You're connected to:"..channel.. ' MHz'})
    end
end

function leaveradio()
    RadioChannel = 0
    onRadio = false
    exports["pma-voice"]:setRadioChannel(0)
    exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
    vRP.notify({"You left the channel."})
end

function SplitStr(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end
  
function IsRadioOn()
    return onRadio
end

exports("IsRadioOn", IsRadioOn)

-- NUI
RegisterNUICallback('joinRadio', function(data, cb)
    local rchannel = tonumber(data.channel)
    if rchannel ~= nil then
        if rchannel <= 500 and rchannel ~= 0 then
            if rchannel ~= RadioChannel then
                connecttoradio(rchannel)
            else
                vRP.notify({"You're already connected to this channel."})
            end
        else
            vRP.notify({"This frequency is not available."})
        end
    else
        vRP.notify({"This frequency is not available."})
    end
end)

function toggleRadio(toggle)
    radioMenu = toggle
    SetNuiFocus(radioMenu, radioMenu)
    if radioMenu then
        PhonePlayIn()
        SendNUIMessage({type = "open"})
    else
        PhonePlayOut()
        SendNUIMessage({type = "close"})
    end
end

RegisterNUICallback('leaveRadio', function(data, cb)
    if RadioChannel == 0 then
        vRP.notify({"You're not connected to a signal"})
    else
        leaveradio()
    end
end)

RegisterNUICallback('escape', function(data, cb)
    toggleRadio(false)
end)

radioup = false

Citizen.CreateThread(function()
    ticks = 500
    while true do
        local lPed = GetPlayerPed(-1)
        local playerLocalisation = GetEntityCoords(lPed)
        if GetPlayerWantedLevel(PlayerId()) ~= 0 then
            SetPlayerWantedLevel(PlayerId(), 0, false)
            SetPlayerWantedLevelNow(PlayerId(), false)
            ClearPlayerWantedLevel(PlayerId())
            ClearAreaOfCops(playerLocalisation.x, playerLocalisation.y, playerLocalisation.z, 400.0)
        end
        
        RequestAnimDict('random@mugging3')
        RequestAnimDict('random@arrests')
        if not IsPedInAnyVehicle(lPed, false) and not IsPedSwimming(lPed) and not IsPedShooting(lPed) and not IsPedClimbing(lPed) and not IsPedCuffed(lPed) and not IsPedDiving(lPed) and not IsPedFalling(lPed) and not IsPedJumping(lPed) and not IsPedJumpingOutOfVehicle(lPed) and IsPedOnFoot(lPed) and not IsPedRunning(lPed) and not IsPedUsingAnyScenario(lPed) and not IsPedInParachuteFreeFall(lPed) then
            if IsControlPressed(1, 137) then -- X
                if DoesEntityExist(lPed) then
                    SetCurrentPedWeapon(lPed, 0xA2719263, true)
                    Citizen.CreateThread(function()
                        RequestAnimDict("random@mugging3")
                        while not HasAnimDictLoaded("random@mugging3") do
                            Wait(100)
                        end

						if onRadio then
                        if not radioup then
                            radioup = true
                            TaskPlayAnim(lPed, 'random@arrests', 'generic_radio_chatter', 7.0, 1.0, -1, 50, 0, false, false, false)
                        end  
						end 
                    end)
                end
            end
        end
        if IsControlReleased(1, 137) then -- X
            if DoesEntityExist(lPed) then
                Citizen.CreateThread(function()
                    RequestAnimDict("random@mugging3")
                    while not HasAnimDictLoaded("random@mugging3") do
                        Wait(100)
                    end

					if onRadio then
                    if radioup then
                        radioup = false
                        ClearPedSecondaryTask(lPed)
                    end
					end
                end)
            end
        end
        Citizen.Wait(ticks)
        ticks = 500
    end
end)