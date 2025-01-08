vRP = Proxy.getInterface("vRP") -- vRPclient
local sxServer = Tunnel.getInterface("sx_jobs", "sx_jobs")
local hasTaietor = false
local hasMission = false
local CurrentMission
local ToporItem
local TaietorLemneBlip
local UzuraTopor = 0;

RegisterNetEvent("UG:SetTLemneMission", function(missionData)
    CurrentMission = Config.TaietorLemne[missionData].coords
    hasMission = true

    TaietorLemneBlip = AddBlipForCoord(CurrentMission[1], CurrentMission[2], CurrentMission[3])
    SetBlipAsShortRange(TaietorLemneBlip, true)
    SetBlipRoute(TaietorLemneBlip, true)
    SetBlipScale(TaietorLemneBlip, 0.6)
    SetBlipSprite(TaietorLemneBlip, 271)
    SetBlipColour(TaietorLemneBlip, 52)
    SetBlipRouteColour(TaietorLemneBlip, 52)
end)

local function UpdateUzuraTopor()
    UzuraTopor = UzuraTopor + math.random(1, 3)
    if UzuraTopor >= 95 then
        UzuraTopor = 0
        TriggerServerEvent("UG:ItemUzat", "topor")
        TriggerEvent("notify:Alert", "Error", "Ti s-a rupt toporul din cauza uzurii", 5000, "error")
        -- TriggerEvent("notify", 4, "Taietor Lemne", "Ti s-a rupt toporul din cauza uzurii", 5000)
    end

    SendNUIMessage({
        action = "updateMenu",
        progress = UzuraTopor
    })
end

RegisterNetEvent("UG:StartTaietorLemne", function(job)
    if job then
        hasTaietor = true
    else
        hasTaietor = false
        RemoveBlip(TaietorLemneBlip)
    end


    local action = true 
    Citizen.CreateThread(function()
        while hasTaietor do
            Wait(1)
            if hasMission then
                local playerCoords = GetEntityCoords(PlayerPedId())
                local distance = #(playerCoords - CurrentMission)

                if distance <= 50 then
                    DrawMarker(2, CurrentMission[1], CurrentMission[2], CurrentMission[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,0.4, 0.3, 0.15, 255,255,255, 222, false, false, false, true, false, false, false)
                end

                if distance <= 2.5 then
                    ShowScreenText("Apasa tasta ~HC_22~[E] ~s~pentru a incepe sa tai copacul")
                    if IsControlJustReleased(0, 38) and action then
                        action = false 
                        sxServer.hasItemAmount({"topor", 1, false}, function(topor)
                            if topor then
                               
                                hasMission = false
                                ToporItem = CreateObject(GetHashKey("w_me_hatchet"), 0, 0, 0, true, true, true)
                                AttachEntityToEntity(ToporItem, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.12, -0.02, -0.02, 280.0, 10.0, 360.0, true, true, false, true, 1, true)
                                loadAnimDict("melee@hatchet@streamed_core")
                                Wait(100)
                                FreezeEntityPosition(PlayerPedId(), true)
                                TaskPlayAnim(PlayerPedId(), 'melee@hatchet@streamed_core', 'plyr_rear_takedown_b', 8.0,8.0, -1, 49, 0, 0, 0, 0)
                                exports.rprogress:Custom({
                                    Duration = 15000,
                                    Label = "Tai copacul...",
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
                                    ClearPedTasks(PlayerPedId())
                                    UpdateUzuraTopor()
                                    action = true 
                                    RemoveBlip(TaietorLemneBlip)
                                    DetachEntity(ToporItem, 1, true)
                                    DeleteEntity(ToporItem)
                                    FreezeEntityPosition(PlayerPedId(), false)
                                    TriggerServerEvent("UG:GiveTaietorReward", CurrentMission);
                                end)
                            else
                                action = true 
                                exports["vrp_notify"]:Alert("Error", "Nu ai un topor la tine", 5000, "error")
                            end
                        end)
                    end
                end
            end
        end
    end)

    Citizen.CreateThread(function()
        while hasTaietor do
            Wait(1)
            if IsControlJustPressed(0, 19) then
                sxServer.hasItemAmount({"topor", 1, false}, function(topor)
                    if topor then
                        SendNUIMessage({
                            action = "showMenu",
                            tipCurentMenu = "Uzura",
                            tipCurrentProduct = "TOPOR",
                            color = '214, 28, 28',
                            image = 'topor.png',
                            progress = UzuraTopor
                        })
                    else
                        TriggerEvent("notify:Alert", "Error", "Nu ai un topor la tine", 5000, "error")
                        -- TriggerEvent("notify", 4, "Taietor Lemne", "Nu ai un Topor la tine", 5000)
                    end
                end)
            end  
        end
    end)

end)
