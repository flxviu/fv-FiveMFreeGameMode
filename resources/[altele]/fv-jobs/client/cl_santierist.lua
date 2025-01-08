local sxJobs = {}
Tunnel.bindInterface("sx_jobs", sxJobs)
Proxy.addInterface("sx_jobs", sxJobs)
local sxJobs = Tunnel.getInterface("sx_jobs", "sx_jobs")

vRP = Proxy.getInterface("vRP") -- vRPclient

local hasJob = false

local SantieristLevel = math.random(1, #Config.SantieristLocations)

local MissionData = {}

local hasMissions = false

local itemModel

local UzuraScule = 0;

local function UpdateUzuraScule()
    UzuraScule = UzuraScule + math.random(1, 3)
    if UzuraScule >= 95 then
        UzuraScule = 0
        TriggerServerEvent("UG:ItemUzat", "trusascule")
        TriggerEvent("notify:Alert", "Info", "Ti s-au stricat sculele din cauza uzurii", 5000, "info");
        -- TriggerEvent("notify", 4, "Santierist", "Ti s-au stricat sculele din cauza uzurii", 5000)
    end

    SendNUIMessage({
        action = "updateMenu",
        progress = UzuraScule
    })
end

local function GenerateMissions()
    MissionData = {}
    SantieristLevel = math.random(1, #Config.SantieristLocations)
    vRP.setGPS({Config.SantieristLocations[SantieristLevel].Location[1],Config.SantieristLocations[SantieristLevel].Location[2]})
    for k, v in pairs(Config.SantieristLocations[SantieristLevel].Places) do

        local blip = AddBlipForCoord(v.Pos)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Misiune Santierist")
        EndTextCommandSetBlipName(blip)

        SetBlipSprite(blip, 566)
        SetBlipScale(blip, 0.6)
        SetBlipColour(blip, 26)

        MissionData[#MissionData + 1] = {
            coords = v.Pos,
            time = v.WorkingTime,
            type = v.Tool,
            made = false,
            text = v.text,
            blips = blip
        }
    end
    hasMissions = true
end

function sxJobs.GetSantieristProgress()
    return SantieristLevel
end

function startAnim(ped, dictionary, anim, time)
    Citizen.CreateThread(function()
        RequestAnimDict(dictionary)
        while not HasAnimDictLoaded(dictionary) do
            Wait(0)
        end
        TaskPlayAnim(ped, dictionary, anim, 8.0, 8.0, -1, 49, 0, 0, 0, 0)

        RequestAnimDict(dictionary)
        while not HasAnimDictLoaded(dictionary) do
            Wait(0)
        end
        TaskPlayAnim(ped, dictionary, anim, 8.0, 8.0, -1, 49, 0, 0, 0, 0)

        RequestAnimDict(dictionary)
        while not HasAnimDictLoaded(dictionary) do
            Wait(0)
        end
        TaskPlayAnim(ped, dictionary, anim, 8.0, 8.0, -1, 49, 0, 0, 0, 0)
        Wait(time)
    end)
end

local function hasFinishedMissions()
    local misiuniTerminate = 0
    for k, v in pairs(MissionData) do
        if v.made then
            misiuniTerminate = misiuniTerminate + 1
        end 
    end
    return misiuniTerminate == #Config.SantieristLocations[SantieristLevel].Places
end

local function progressBar(time)
    exports.rprogress:Custom({
        Duration = time,
        Label = "Lucrezi..",
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
end

RegisterNetEvent("UG:GenerateSantierist", function()
    GenerateMissions()
end)

local pressed = false
RegisterNetEvent("UG:ToggleSantierist", function(toggle)
    if toggle then GenerateMissions() end

    hasJob = toggle
    Citizen.CreateThread(function()
        while hasJob do
            Wait(0)
            local playerCoords = GetEntityCoords(PlayerPedId())
            if hasMissions then
                for k, v in pairs(MissionData) do
                    local distance = #(v.coords - playerCoords)
                    if distance <= 50 and not v.made then
                        DrawMarker(2, v.coords[1], v.coords[2], v.coords[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.3,0.15, 255, 255, 255, 200, false, false, false, true, false, false, false)
                        if distance <= 2.5 then
                            ShowScreenText("Apasa tasta ~g~[E] ~s~pentru a incepe sa lucrezi")
                            if IsControlJustPressed(1, 51) and not pressed then
                                pressed = true 
                                sxJobs.hasItemAmount({"trusascule", 1, false}, function(scule)

                                    if not scule then pressed = false end
                                    
                                    if scule then
                                        if v.type == 'hammer' then
                                            itemModel = CreateObject(GetHashKey('prop_tool_hammer'), v.coords[1], v.coords[2], v.coords[3], true, true, true)
                                            AttachEntityToEntity(itemModel, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0,0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
                                            
                                            startAnim(PlayerPedId(), 'amb@world_human_hammering@male@base', 'base', v.time)
                                        elseif v.type == 'pneumatic hammer' then
                                            itemModel = CreateObject(GetHashKey('prop_tool_jackham'), v.coords[1], v.coords[2],v.coords[3], true, true, true)
                                            AttachEntityToEntity(itemModel, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0,0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
        
                                            startAnim(PlayerPedId(), 'amb@world_human_const_drill@male@drill@base', 'base',v.time)
                                        elseif v.type == 'drill' then
                                            itemModel = CreateObject(GetHashKey('prop_tool_drill'), v.coords[1], v.coords[2],v.coords[3], true, true, true)
                                            AttachEntityToEntity(itemModel, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.07, 0.0, 0.0, 0.0, 90.0, 1, 1, 0, 0, 2, 1)
        
                                            startAnim(PlayerPedId(), 'anim@heists@fleeca_bank@drilling', 'drill_straight_idle',v.time)
                                            RequestAmbientAudioBank("DLC_HEIST_FLEECA_SOUNDSET", 0)
                                            RequestAmbientAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL", 0)
                                            RequestAmbientAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL_2", 0)
        
                                        elseif v.type == 'weld' then
                                            itemModel = CreateObject(GetHashKey('prop_weld_torch'), v.coords[1], v.coords[2],v.coords[3], true, true, true)
                                            AttachEntityToEntity(itemModel, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0,0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
        
                                            startAnim(PlayerPedId(), 'amb@world_human_welding@male@base', 'base', v.time)
                                        end
                                        progressBar(v.time)
                                        SetTimeout(v.time, function()
                                            DeleteEntity(itemModel)
                                            ClearPedTasks(PlayerPedId())
                                            RemoveBlip(v.blips)
                                            UpdateUzuraScule()
                                            pressed = false
                                            if hasFinishedMissions() then
                                                TriggerServerEvent("UG:GetSantieristMoney",Config.SantieristLocations[SantieristLevel].Location);
                                                hasMissions = false
                                            end
                                        end)
                                        v.made = true
                                    else
                                        --[[ARGS: 'notify:Alert', function(title, message, time, type)]]
                                        TriggerEvent("notify:Alert", "Info", "Nu ai o trusa de scule la tine", 5000, "info");
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
        while hasJob do
            Wait(1)
            if IsControlJustPressed(0, 19) then
                sxJobs.hasItemAmount({"trusascule", 1, false}, function(trusascule)
                    if trusascule then
                        SendNUIMessage({
                            action = "showMenu",
                            tipCurentMenu = "Trusa Scule",
                            tipCurrentProduct = "Uzura",
                            color = '255, 255, 255',
                            image = 'trusascule.png',
                            progress = UzuraScule
                        })
                    else
                        TriggerEvent("notify:Alert", "Info", "Nu ai o trusa de scule la tine", 5000, "info");
                        -- TriggerEvent("notify", 4, "Santierist", "Nu ai o Trusa de Scule la tine", 5000)
                    end
                end)
            end  
        end
    end)

end)