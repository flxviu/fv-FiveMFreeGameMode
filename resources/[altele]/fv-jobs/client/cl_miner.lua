vRP = Proxy.getInterface("vRP") -- vRPclient
local sxJobs = Tunnel.getInterface("sx_jobs", "sx_jobs")

local hasJobMiner = false
local hasMissions = false

local MinerCheckpoint
local PickaxeItem

local MinerBlip

local carbune = true

RegisterNetEvent("UG:RegenerateMiner", function(mission)
    MinerCheckpoint = Config.MinerLocations[mission]

    if DoesBlipExist(MinerBlip) then
        RemoveBlip(MinerBlip)
    end

    MinerBlip = AddBlipForCoord(MinerCheckpoint[1], MinerCheckpoint[2], MinerCheckpoint[3])
    SetBlipSprite(MinerBlip, 11)
    SetBlipColour(MinerBlip, 82)
    SetBlipRoute(MinerBlip, true)
    SetBlipRouteColour(MinerBlip, 82)

    SetBlipAsShortRange(MinerBlip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Misiune")
    EndTextCommandSetBlipName(MinerBlip)

    hasMissions = true
end)

local UzuraTarnacop = 0;

local function UpdateUzuraTarnacop()
    UzuraTarnacop = UzuraTarnacop + math.random(1, 3)

    if UzuraTarnacop >= 95 then
        UzuraTarnacop = 0
        TriggerServerEvent("UG:ItemUzat", "pickaxe")
        --[[title, message, time, type]]
        -- TriggerEvent("notify:Alert", "Info", "Ti s-a tricat Tarnacopul din cauza uzurii", 5000, "info");
        exports["vrp_notify"]:Alert("Info", "Ti s-a tricat Tarnacopul din cauza uzurii", 5000, "info")
    end

    SendNUIMessage({
        action = "updateMenu",
        progress = UzuraTarnacop
    })
end

RegisterNetEvent("UG:StartMinerJob", function(job)
    hasJobMiner = job
    if not job then
        RemoveBlip(MinerBlip)
    end

    local action = true 
    Citizen.CreateThread(function()
        while hasJobMiner do
            Wait(1)
            if hasMissions then
                local playerCoords = GetEntityCoords(PlayerPedId())
                local distance = #(playerCoords - MinerCheckpoint)
                if distance <= 50 then
                    DrawMarker(2, MinerCheckpoint[1], MinerCheckpoint[2], MinerCheckpoint[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.3,0.15, 255,255,255, 200, false, false, false, true, false, false, false)
                end

                if distance <= 2.5 then
                    ShowScreenText("Apasa tasta ~g~[E] ~s~pentru a incepe sa minezi")
                    if IsControlJustReleased(0, 38) and action then
                            sxJobs.hasItemAmount({"pickaxe", 1, false}, function(pickaxe)
                            if pickaxe then
                                hasMissions = false
                                PickaxeItem = CreateObject(GetHashKey("prop_tool_pickaxe"), 0, 0, 0, true, true, true)
                                AttachEntityToEntity(PickaxeItem, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.12, -0.02, -0.02, 280.0, 10.0, 360.0, true, true, false, true, 1, true)
                                loadAnimDict("melee@large_wpn@streamed_core")
                                Wait(100)
                                FreezeEntityPosition(PlayerPedId(), true)
                                TaskPlayAnim(PlayerPedId(), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot', 8.0, 8.0, -1, 49, 0, 0, 0, 0)
                                exports.rprogress:Custom({
                                    Duration = 15000,
                                    Label = "Minezi...",
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
                                SetTimeout(15000, function()
                                    action = true
                                    ClearPedTasks(PlayerPedId())
                                    UpdateUzuraTarnacop()
                                    TriggerServerEvent("UG:FinishMineaza",MinerCheckpoint)
                                    FreezeEntityPosition(PlayerPedId(), false)
                                    DetachEntity(PickaxeItem, 1, true)
                                    DeleteEntity(PickaxeItem)
                                end)
                            else
                                action = true 
                                exports["vrp_notify"]:Alert("Eroare", "Nu ai tarnacop la tine", 5000, "error");
                            end
                        end)
                    end
                end
            end
        end
    end)

    Citizen.CreateThread(function()
        while hasJobMiner do
            Wait(1)
            if IsControlJustPressed(0, 19) then
                sxJobs.hasItemAmount({"pickaxe", 1, false}, function(pickaxe)
                    if pickaxe then
                        SendNUIMessage({
                            action = "showMenu",
                            tipCurentMenu = "Tarnacop",
                            tipCurrentProduct = "Uzura",
                            color = '191, 108, 44',
                            image = 'pickaxe.png',
                            progress = UzuraTarnacop
                        })
                    else
                        exports["vrp_notify"]:Alert("Eroare", "Nu ai un tarnacop la tine", 5000, "error");
                    end
                end)
            end  
        end
    end)

        Citizen.CreateThread(function()
            while true do
                Wait(1)
                if carbune then
                local playerCoords = GetEntityCoords(PlayerPedId())

                if #(playerCoords - Config.CarbuneLocation) <= 10 then
                    ShowScreenText("Apasa tasta ~g~[E] ~s~pentru a aduna carbune")
                    if IsControlJustPressed(0, 51) then
                        carbune = false
                        exports.rprogress:Custom({
                            Duration = 7000,
                            Label = "Aduni carbuni ...",
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
                            TriggerServerEvent('UG:GiveCarbune')
                            carbune = true
                        end)
                    end
                end
            end
        end
    end)
end)
