vRP = Proxy.getInterface("vRP")

local checkEngineHealth <const> = 300.0
local inVeh = false
local seatBeltActive = false
local cruiseControlActive = false

exports("setHudActive", function(active)
    SendNUIMessage({
        type = 'allHud',
        on = active
    })
end)

Citizen.CreateThread(function()
    local speedoActive = false
    Citizen.Wait(250)
    while true do
        local ped = PlayerPedId()
        inVeh = IsPedInAnyVehicle(ped)
        if not speedoActive and inVeh then
            SendNUIMessage({
                type = 'speedometer',
                on = true
            })
            speedoActive = true
            local veh = GetVehiclePedIsIn(ped)
            local cruiseMaxSpeed = GetVehicleHandlingFloat(veh,"CHandlingData","fInitialDriveMaxFlatVel")
            TriggerEvent("nzv:setVehicleMaxSpeed", veh, -1.0)
            local isDriver = (GetPedInVehicleSeat(veh, -1) == ped) or false
            if isDriver then
                SetPedCanBeDraggedOut(ped, false)
                SendNUIMessage({
                    type = 'speedometer',
                    updates = {
                        utility = true
                    }
                })
            end

            Citizen.CreateThread(function()
                local lastSpeed = 0
                local lastEngine = false
                Citizen.CreateThread(function()
                    while speedoActive and DoesEntityExist(veh) do
                        SendNUIMessage({
                            type = 'speedometer',
                            updates = {
                                rpm = (GetVehicleCurrentRpm(veh) * 100)
                            }
                        })
                        Citizen.Wait(100)
                    end
                end)
                while speedoActive and DoesEntityExist(veh) do
                    local gear = GetVehicleCurrentGear(veh)
                    local speed = math.ceil(GetEntitySpeed(veh) * 3.6)
                    
                    local engineOn = GetIsVehicleEngineRunning(veh)

                    if engineOn ~= lastEngine then
                        lastEngine = engineOn
                        SendNUIMessage({
                            type = 'speedometer',
                            updates = {
                                engine = engineOn
                            }
                        })
                    end
    
                    SendNUIMessage({
                        type = 'speedometer',
                        updates = {
                            speed = speed,
                            gear = engineOn and (speed > 1 and (gear ~= 0 and gear or "R") or "P") or "",
                            fuel = math.ceil(GetVehicleFuelLevel(veh))
                        }
                    })
                    lastSpeed = speed
                    Citizen.Wait(400)
                end
            end)
        elseif speedoActive and not inVeh then
            SendNUIMessage({
                type = 'speedometer',
                on = false
            })
            speedoActive = false
            seatBeltActive = false
            cruiseControlActive = false
        end

        TriggerEvent("hud:update","health", GetEntityHealth(ped) - 100)
        TriggerEvent("hud:update","armour", GetPedArmour(ped))
        Citizen.Wait(500)
    end
end)

RegisterNetEvent("speedometer:setNitro", function(nitroCharges)
    if not inVeh then return end
    SendNUIMessage({
        type = 'speedometer',
        updates = {
            nitro = nitroCharges
        }
    })
end)

RegisterNetEvent("speedometer:setOdometer", function(totalKm)
    if not inVeh then return end
    totalKm = math.ceil(totalKm)
    SendNUIMessage({
        type = 'speedometer',
        updates = {
            odometer = totalKm
        }
    })
end)

RegisterNetEvent("speedometer:setCheckEngine", function(oilHealth)
    if not inVeh then return end
    if oilHealth <= 5 then
        SendNUIMessage({
            type = 'speedometer',
            updates = {
                engine = "checkengine"
            }
        })
    else
        SendNUIMessage({
            type = 'speedometer',
            updates = {
                engine = nil
            }
        })
    end
end)

AddEventHandler("nzv:setPlayerDataExtern", function (type, value)
    if type == "walletMoney" then
        SendNUIMessage({
            type = 'hud',
            update = "cash",
            value = value
        })
    elseif type == "diamonds" then
        SendNUIMessage({
            type = 'hud',
            update = "premium-currency",
            value = value
        })
    elseif type == "job" then
        SendNUIMessage({
            type = 'hud',
            update = "job",
            value = value
        })
    end
end)

local hudActive = true
RegisterNetEvent("nzv:togHud", function()
    hudActive = not hudActive
    SendNUIMessage({
        type = 'allHud',
        on = hudActive
    })
    if hudActive then
        TriggerEvent("nzv:notify", "Ai pornit ~b~Hud-ul~w~.")
    else
        TriggerEvent("nzv:notify", "Ai oprit ~r~Hud-ul~w~.")
    end
end)

local radarActive = true
RegisterNetEvent("nzv:togRadar", function()
    radarActive = not radarActive
    Citizen.CreateThread(function()
        DisplayRadar(radarActive)
    end)
    if togradar == true then
        TriggerEvent("nzv:notify", "Ai pornit ~b~Radar-ul~w~.")
    else
        TriggerEvent("nzv:notify", "Ai oprit ~r~Radar-ul~w~.")
    end
end)

RegisterKeyMapping('+seatBelt', 'Centura', 'keyboard', 'x')
RegisterCommand('+seatBelt', function()
    if inVeh then
        seatBeltActive = not seatBeltActive
        if seatBeltActive then
            TriggerEvent("nzv:notify", "Ti-ai ~b~pus ~w~centura.")
            SendNUIMessage({
                type = 'speedometer',
                updates = {
                    seatbelt = true
                }
            })
        else
            TriggerEvent("nzv:notify", "Ti-ai ~r~scos ~w~centura.")
            SendNUIMessage({
                type = 'speedometer',
                updates = {
                    seatbelt = false
                }
            })
        end
        Citizen.CreateThread(function ()
            while seatBeltActive do
                Citizen.Wait(1)
                DisableControlAction(0, 75)
            end
        end)
    end
end)

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

RegisterKeyMapping('+cruiseControl', 'Cruise Control', 'keyboard', 'F5')
RegisterCommand('+cruiseControl', function()
    if inVeh then
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped,false)
        local cruiseMaxSpeed = GetEntitySpeed(veh)
        if cruiseMaxSpeed * 3.6 > 30 and not cruiseControlActive then
            TriggerEvent("nzv:setVehicleMaxSpeed", veh, cruiseMaxSpeed)
            TriggerEvent("nzv:notify","Cruise Control ~b~ACTIVAT~w~, viteza maxima: ~b~"..(round(cruiseMaxSpeed*3.6,0)).."~w~.")
            SendNUIMessage({
                type = 'speedometer',
                updates = {
                    cruisecontrol = true
                }
            })
            cruiseControlActive = true
        elseif cruiseControlActive then
            TriggerEvent("nzv:setVehicleMaxSpeed", veh, -1.0)
            TriggerEvent("nzv:notify","Cruise Control ~r~DEZACTIVAT~w~.")
            SendNUIMessage({
                type = 'speedometer',
                updates = {
                    cruisecontrol = false
                }
            })
            cruiseControlActive = false
        else
            TriggerEvent("nzv:notify","~r~Cruise Control poate fi folosit la o viteza de peste ~w~30 km/h~r~.")
        end
    end
end)

local text = ""
function drawtxtAdmin(textt, font, centre, x, y, scale, r, g, b, a)
    y = y - 0.010
    y = y + 0.002
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextFont(font)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(textt)
    DrawText(x, y)
end

AddEventHandler("nzv:setPlayerDataExtern", function (type,value)
  if type == "adminOnDuty" and value == false then
    text = ""
  end
end)

Citizen.CreateThread(function()
    while true do
        local tick = 2000
        if text ~= "" and hudActive then
            tick = 1
            drawtxtAdmin(text, 4, 0.5, 0.082, 0.978, 0.5, 255, 255, 255, 255)
        else
            tick = 2500
        end
    Citizen.Wait(tick)
    end
end)

RegisterNetEvent('NZV:update_tickete_intrebari')
AddEventHandler('NZV:update_tickete_intrebari', function(tickets,intrebari)
    local playerData = vRP.getPlayerData({})
    if playerData["adminLvl"] > 0 then
        text = "Tickete: ~b~"..tickets.." ~m~| ~w~Intrebari: ~b~"..intrebari
    end
end)

-- Main HUD
RegisterNetEvent("hud:update", function(dataType, value)
    if type(dataType) == "table" and not value then
        SendNUIMessage(dataType)
        return
    end
    SendNUIMessage({
        type = 'hud',
        update = dataType,
        value = value
    })
end)


RegisterCommand("ts", function ()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh ~= 0 then
        print("top speed 1: "..GetVehicleEstimatedMaxSpeed(veh)*3.6)
        print("top speed 2:"..GetVehicleModelEstimatedMaxSpeed(GetEntityModel(veh))*3.6)
    end
end)