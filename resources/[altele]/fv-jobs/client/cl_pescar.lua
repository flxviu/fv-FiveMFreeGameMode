vRP = Proxy.getInterface("vRP") -- vRPclient
local sxJobs = Tunnel.getInterface("sx_jobs", "sx_jobs")

local hasJobPescar = false
local hasMission = false

local inMission = false

local PescarData
local PescarBlip
local FishRod

local PescarLocation

local UzuraUndita = 0;

local mlastina = true

local function CreatePescarBlip(x, y, z)
    if DoesBlipExist(PescarBlip) then
        RemoveBlip(PescarBlip)
    end

    PescarBlip = AddBlipForCoord(x, y, z)
    SetBlipSprite(PescarBlip, 317)
    SetBlipColour(PescarBlip, 26)
    SetBlipAsShortRange(PescarBlip, true)
    SetBlipRoute(PescarBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Misiune Pescar")
    EndTextCommandSetBlipName(PescarBlip)
end

local function GeneratePescarMission()
    PescarData = math.random(1, #Config.PescarLocations)
    PescarLocation = Config.PescarLocations[PescarData].coords
    CreatePescarBlip(PescarLocation[1], PescarLocation[2], PescarLocation[3])
    hasMission = true
end

local function AttachEntityToPed(prop, bone_ID, x, y, z, RotX, RotY, RotZ)
    local ped = PlayerPedId()
    BoneID = GetPedBoneIndex(ped, bone_ID)
    obj = CreateObject(GetHashKey(prop), 1729.73, 6403.90, 34.56, true, true, true)
    vX, vY, vZ = table.unpack(GetEntityCoords(ped))
    xRot, yRot, zRot = table.unpack(GetEntityRotation(ped, 2))
    AttachEntityToEntity(obj, ped, BoneID, x, y, z, RotX, RotY, RotZ, false, false, false, false, 2, true)
    return obj
end

local function UpdateUzuraUndita()
    UzuraUndita = UzuraUndita + math.random(1, 3)
    if UzuraUndita >= 95 then
        UzuraUndita = 0
        TriggerServerEvent("UG:ItemUzat", "undita")
        exports["vrp_notify"]:Alert("Ti s-a tricat undita din cauza uzurii", 5000, "info");
    end

    SendNUIMessage({
        action = "updateMenu",
        progress = UzuraUndita
    })
end

RegisterNetEvent("UG:StartPescarJob", function(toggle)
    if toggle then
        GeneratePescarMission()
    else
        RemoveBlip(PescarBlip)
    end

    local action = true 
    
    hasJobPescar = toggle
    Citizen.CreateThread(function()
        while hasJobPescar do
            Wait(1)

            if hasMission and not inMission then
                local playerCoords = GetEntityCoords(PlayerPedId())
                local distance = #(playerCoords - PescarLocation)

                if distance <= 50 then
                    DrawMarker(2, PescarLocation[1], PescarLocation[2], PescarLocation[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                        0.4, 0.3, 0.15, 255,255,255, 200, false, false, false, true, false, false, false)
                end

                if distance <= 2.5 then
                    ShowScreenText("Apasa tasta ~g~[E] ~s~pentru a incepe sa pescuiesti")
                    if IsControlJustReleased(0, 38) and action then
                        sxJobs.hasItemAmount({"undita", 1, false}, function(undita)
                            if undita then
                                sxJobs.hasItemAmount({"momeala", 1, true}, function(momeala)
                                    if momeala then
                                        inMission = true
                                        FishRod = AttachEntityToPed('prop_fishing_rod_01', 60309, 0, 0, 0, 0, 0, 0)

                                        RequestAnimDict('amb@world_human_stand_fishing@base')
                                        while not HasAnimDictLoaded('amb@world_human_stand_fishing@base') do
                                            Wait(0)
                                        end

                                        TaskPlayAnim(PlayerPedId(), 'amb@world_human_stand_fishing@base', 'base', 8.0,8.0, -1, 49, 0, 0, 0, 0)
                                        exports.rprogress:Custom({
                                            Duration = 9000,
                                            Label = "Pescuiesti...",
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
                                        Wait(9200)
                                        action = true

                                        TaskPlayAnim(PlayerPedId(), 'amb@world_human_stand_fishing@base', 'base', 8.0,
                                            8.0, -1, 49, 0, 0, 0, 0)
                                        exports.rprogress:MiniGame({
                                            Difficulty = "Medium",
                                            Timeout = 5000,
                                            onComplete = function(success)
                                                 action = true 
                                                if success then
                                                    TriggerServerEvent('sxint:giveRewardFish',PescarLocation);
                                                    -- sxJobs.giveRewardFish()

                                                    DeleteEntity(FishRod)
                                                    RemoveBlip(PescarBlip)

                                                    hasMission = false
                                                    GeneratePescarMission()
                                                    UpdateUzuraUndita()

                                                    ClearPedTasks(PlayerPedId())

                                                else

                                                    TriggerEvent("notify:Alert", "Info", "Ti-a scapat pestele", 5000, "info");

                                                    DeleteEntity(FishRod)
                                                    RemoveBlip(PescarBlip)

                                                    hasMission = false
                                                    GeneratePescarMission()

                                                    ClearPedTasks(PlayerPedId())

                                                end
                                            end
                                        })
                                        inMission = false
                                    else
                                        action = true 
                                        TriggerEvent("notify:Alert", "Info", "Nu ai momeala la tine", 5000, "info");
                                    end
                                end)
                            else
                                action = true 
                                exports["vrp_notify"]:Alert("Info", "Ai nevoie de o undita pentru a putea pescui!", 5000, "info");
                            end
                        end)
                    end
                end

            end
        end
    end)

    Citizen.CreateThread(function()
        while hasJobPescar do
            Wait(1)
            if IsControlJustPressed(0, 19) then
                local coords = GetEntityCoords(PlayerPedId())

                if not IsPedInAnyVehicle(PlayerPedId()) and #(coords - vector3(PescarLocation[1], PescarLocation[2], PescarLocation[3]) ) <= 200.0 then 
                    sxJobs.hasItemAmount({"undita", 1, false}, function(undita)
                        if undita then
                            SendNUIMessage({
                                action = "showMenu",
                                tipCurentMenu = "Uzura",
                                tipCurrentProduct = "Undita",
                                color = '31, 170, 230',
                                image = 'undita.png',
                                progress = UzuraUndita
                            })
                        else
                            TriggerEvent("notify:Alert", "Info", "Nu ai o undita la tine", 5000, "info")
                        end
                    end)
                end
            end
        end
    end)

    local action = false 

    Citizen.CreateThread(function()
        while true do
            Wait(700)
            local playerCoords = GetEntityCoords(PlayerPedId())
            if mlastina then

            while #(playerCoords - Config.MlastinaLocation) <= 35 do 
                Citizen.Wait(1)
                playerCoords = GetEntityCoords(PlayerPedId())
                ShowScreenText("Apasa tasta ~g~[E] ~s~pentru a culege momeala")
                if IsControlJustPressed(0, 51) and not action then
                    if IsPedInAnyVehicle(PlayerPedId()) then
                        TriggerEvent("notify:Alert", "Info", "Nu poti culege momeala din masina", 5000, "info")
                    else
                        mlastina = false
                        action = true
                        exports.rprogress:Custom({
                            Duration = 7000,
                            Label = "Culegi momeala ...",
                            Animation = {
                                scenario = "world_human_gardener_plant",
                                animationDictionary = "idle_b"
                            },
                            DisableControls = {
                                Mouse = false,
                                Player = true,
                                Vehicle = true
                            }
                        })
                        SetTimeout(7000, function()
                         
                            TriggerServerEvent('UG:GiveMomeala', Config.MlastinaLocation)
                            mlastina = true
                            action = false
                        end)
                    end
                end
            end
        end
    end
    end)

end)
