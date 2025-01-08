vRP = Proxy.getInterface("vRP") -- vRPclient

local hasGunoierActive = false

local CurrentMissionData = {}
local hasMission = false

local PlayerProps
local GunoierBlip
local GunoierVeh

local hasBin = false

local trashs = 0
local trashCollected = 0

local MasinaGunoi = 0;

local function SpawnGunoierVehicle()
    local vehicle = GetHashKey("trash")
    RequestModel(vehicle)
    while not HasModelLoaded(vehicle) do
        Wait(0)
    end
    GunoierVeh = CreateVehicle(vehicle, Config.spawnGunoierVeh.coords[1], Config.spawnGunoierVeh.coords[2],Config.spawnGunoierVeh.coords[3] + 0.5, 213.70028686523, true, false)
    SetVehicleOnGroundProperly(GunoierVeh)
    SetVehicleFuelLevel(GunoierVeh,100.0)
    SetEntityInvincible(GunoierVeh, true)
    SetPedIntoVehicle(PlayerPedId(), GunoierVeh, -1)
    Citizen.InvokeNative(0xAD738C3085FE7E11, GunoierVeh, true, true)
    SetVehicleHasBeenOwnedByPlayer(GunoierVeh, true)
    SetModelAsNoLongerNeeded(vehicle)
end

local function ToggleGunoiMenu()
    SendNUIMessage({
        action = "showMenu",
        tipCurentMenu = "Masina",
        tipCurrentProduct = "Gunoi",
        color = '27, 163, 0',
        image = 'gunoi.png',
        progress = MasinaGunoi
    })
end

local function UpdateGunoiLevel()
    MasinaGunoi = MasinaGunoi + math.random(10, 15)
    SendNUIMessage({
        action = "updateMenu",
        progress = MasinaGunoi
    })
end

RegisterNetEvent("UG:RegenerateGunoier", function(mission)
    CurrentMissionData.coords = Config.GarbageLocations[mission].coords

    if DoesBlipExist(GunoierBlip) then
        RemoveBlip(GunoierBlip)
    end

    GunoierBlip = AddBlipForCoord(CurrentMissionData.coords[1], CurrentMissionData.coords[2],CurrentMissionData.coords[3])
    SetBlipAsShortRange(GunoierBlip, true)
    SetBlipRoute(GunoierBlip, true)
    SetBlipScale(GunoierBlip, 0.6)
    SetBlipSprite(GunoierBlip, 271)
    SetBlipColour(GunoierBlip, 52)
    SetBlipRouteColour(GunoierBlip, 52)

    hasMission = true
end)

RegisterNetEvent("UG:StartGunoierJob", function(job)
    if job then
        hasGunoierActive = true
        SpawnGunoierVehicle()
        ToggleGunoiMenu()
    else
        RemoveBlip(GunoierBlip)
        hasGunoierActive = false
        ToggleGunoiMenu()
    end

    Citizen.CreateThread(function()
        while hasGunoierActive do
            Wait(1)
            local playerCoords = GetEntityCoords(PlayerPedId())
            if hasMission then
                local distance = #(playerCoords - CurrentMissionData.coords)

                if not hasBin then

                    if distance <= 20 then
                        DrawMarker(2, CurrentMissionData.coords[1], CurrentMissionData.coords[2],CurrentMissionData.coords[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4,0.3, 0.15,255,255,255, 222, false, false, false, true, false, false, false)
                    end

                    if distance <= 1.5 then
                        ShowScreenText("Apasa tasta ~g~[E] ~s~pentru a ridica gunoiul")
                        if IsControlJustPressed(0, 51) then
                            if MasinaGunoi <= 95 then

                                hasMission = false
                                TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
                                exports.rprogress:Custom({
                                    Duration = 9000,
                                    Label = "Ridici gunoiul...",
                                    Animation = {
                                        scenario = "",
                                        animationDictionary = ""
                                    },
                                    DisableControls = {
                                        Mouse = false,
                                        Player = true,
                                        Vehicle = true
                                    }
                                })
                                Wait(9000)

                                hasMission = true
                                ClearPedTasks(PlayerPedId())

                                if not HasAnimDictLoaded("anim@heists@narcotics@trash") then
                                    RequestAnimDict("anim@heists@narcotics@trash")
                                end

                                PlayerProps = CreateObject(GetHashKey("hei_prop_heist_binbag"), 0, 0, 0, true, true,true)
                                AttachEntityToEntity(PlayerProps, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.12, 0.0, 0.00, 25.0, 270.0, 180.0, true, true, false, true, 1, true)

                                TaskPlayAnim(PlayerPedId(), 'anim@heists@narcotics@trash', 'walk', 1.0, -1.0, -1, 49, 0,0, 0, 0)

                                hasBin = true;
                                if trashs == trashCollected then
                                    trashs = math.random(1, 3)
                                    trashCollected = 0
                                end
                            else
                                exports["vrp_notify"]:Alert("Info", "Masina ta este aproape plina, iti recomandam sa te intorci la sediu!",5000, "info")
                            end
                        end
                    end
                else
                    if not IsPedInAnyVehicle(PlayerPedId()) then

                        local TruckCoords = GetWorldPositionOfEntityBone(GunoierVeh, GetEntityBoneIndexByName(GunoierVeh, "platelight"))
                        local TrapDistance = #(GetEntityCoords(PlayerPedId()) - TruckCoords)

                        if TrapDistance <= 10 then
                            DrawMarker(2, TruckCoords[1] - 0.6, TruckCoords[2] - 0.6, TruckCoords[3] , 0.0, 0.0,0.0, 0.0, 0.0, 0.0, 0.4, 0.3, 0.15, 255,255,255, 222, false, false, false, true,false, false, false)
                        end

                        if TrapDistance <= 2.5 then
                            ShowScreenText("Apasa tasta ~g~[E] ~s~pentru a arunca gunoiul")
                            if IsControlJustPressed(0, 51) then

                                hasMission = false
                                TaskPlayAnim(PlayerPedId(), 'anim@heists@narcotics@trash', 'throw_b', 1.0, -1.0, -1, 2, 0, 0, 0, 0)
                                exports.rprogress:Custom({
                                    Duration = 1500,
                                    Label = "Arunci gunoiul in masina...",
                                    Animation = {
                                        scenario = "",
                                        animationDictionary = ""
                                    },
                                    DisableControls = {
                                        Mouse = false,
                                        Player = true,
                                        Vehicle = true
                                    }
                                })

                                SetTimeout(1500, function()
                                    hasMission = true
                                    DeleteEntity(PlayerProps)
                                    ClearPedTasksImmediately(PlayerPedId())

                                    trashCollected = trashCollected + 1
                                    local remainToCollect = trashs - trashCollected

                                    if remainToCollect == 0 then
                                        hasBin = false;
                                        
                                        TriggerServerEvent("UG:IncreaseGunoaie")

                                        UpdateGunoiLevel()

                                        if MasinaGunoi >= 95 then
                                            exports["vrp_notify"]:Alert("Info", "Masina ta este aproape plina, iti recomandam sa te intorci la sediu!", 5000, "info")
                                            -- TriggerEvent("notify:Alert", "Info", "Masina ta este aproape plina, iti recomandam sa te intorci la sediu!",5000, "info")
                                            -- TriggerEvent("notify", 1,"Job Gunoier", "Masina ta este aproape plina, iti recomandam sa te intorci la sediu!",5000)
                                            RemoveBlip(GunoierBlip)

                                            GunoierBlip = AddBlipForCoord(Config.sellGunoier.coords[1], Config.sellGunoier.coords[2], Config.sellGunoier.coords[3])
                                            SetBlipAsShortRange(GunoierBlip, true)
                                            SetBlipRoute(GunoierBlip, true)
                                            SetBlipScale(GunoierBlip, 0.6)
                                            SetBlipSprite(GunoierBlip, 271)
                                            SetBlipColour(GunoierBlip, 52)
                                            SetBlipRouteColour(GunoierBlip, 52)
                                        else
                                            TriggerEvent("notify:Alert", "Info", "Ai terminat de luat saci de gunoi de la aceasta locatie",5000, "info")
                                            -- TriggerEvent("notify", 1,"Job Gunoier", "Ai terminat de luat saci de gunoi de la aceasta locatie",5000)
                                        end

                                    else
                                        hasBin = false;
                                        UpdateGunoiLevel()
                                        exports["vrp_notify"]:Alert("Info", "Mai ai de luat " .. remainToCollect .. " saci de gunoi", 5000, "info")
                                        -- TriggerEvent("notify:Alert", "Info", "Mai ai de luat " .. remainToCollect .. " saci de gunoi",5000, "info")
                                        -- TriggerEvent("notify", 1,"Job Gunoier", "Mai ai de luat " .. remainToCollect .. " saci de gunoi",5000)
                                    end
                                end)
                            end

                        end
                    end
                end
            end
        end
    end)

    Citizen.CreateThread(function()
        while hasGunoierActive do
            Wait(1)
            local playerCoords = GetEntityCoords(PlayerPedId())

            if #(playerCoords - Config.sellGunoier.coords) <= 120 then
                DrawMarker(1, Config.sellGunoier.coords[1], Config.sellGunoier.coords[2], Config.sellGunoier.coords[3],0.0, 0.0, 0.0, 0, 0.0, 0.0, 4.0, 4.0, 1.0, 255, 255, 255, 100, false, true, 2, nil, nil, false)
            end

            if #(playerCoords - Config.sellGunoier.coords) <= 2.5 then
                ShowScreenText("Apasa tasta ~g~[E] ~s~pentru a termina cursa")

                if IsControlJustPressed(1, 51) then
                    TriggerServerEvent("UG:GetGunoierMoney", Config.sellGunoier.coords);
                    if DoesEntityExist(GunoierVeh) then
                        DeleteEntity(GunoierVeh)
                    end
                    hasGunoierActive = false;
                    MasinaGunoi = 0;
                    Citizen.Wait(1000)
                end
            end
        end
    end)

end)
