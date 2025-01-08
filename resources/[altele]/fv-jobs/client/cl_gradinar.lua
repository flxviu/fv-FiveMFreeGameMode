local hasJob = false
local hasMission = false
local MissionData = {}
local StropitoareApa = 0;
local ClientLevel;
local nearStropitoare = false
local umplereCooldown = true;


local function addBlip(x,y,z,idtype,idcolor,text)
    if(idtype ~= 0 and idcolor ~= 0)then
        local blip = AddBlipForCoord(x+0.001,y+0.001,z+0.001) -- solve strange gta5 madness with integer -> double
        SetBlipSprite(blip, idtype)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip,idcolor)
        SetBlipScale(blip, 0.3)
    if text ~= nil then
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(text)
        EndTextCommandSetBlipName(blip)
    end
        return blip
    end

end

local tempBlips = {}
local function createTempBlips(bool)
    if bool then
        for _, handle in pairs(tempBlips) do 
            RemoveBlip(tonumber(handle))
            SetBlipAlpha(tonumber(handle),0)
        end 
        return 
    end

    for k, v in pairs(Config.GradinarStropitori) do
        table.insert(tempBlips,addBlip(v.coords[1], v.coords[2], v.coords[3], 407, 45, 'Stropitoare'))
    end
end


RegisterNetEvent("UG:GradinarGenerateMission", function(MissionLevel)
    MissionData = {}

    ClientLevel = MissionLevel
    for k, v in pairs(Config.GradinarLocations[MissionLevel].Places) do

        local blip = AddBlipForCoord(v.Pos)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Misiune Gradinar")
        EndTextCommandSetBlipName(blip)

        SetBlipSprite(blip, 140)
        SetBlipScale(blip, 0.6)
        SetBlipColour(blip, 26)

        MissionData[#MissionData + 1] = {
            coords = v.Pos,
            made = false,
            blips = blip
        }
    end
    hasMission = true
end)

local function hasFinishedMissions()
    local misiuniTerminate = 0
    for k, v in pairs(MissionData) do
        if v.made then
            misiuniTerminate = misiuniTerminate + 1
        end 
    end
    return misiuniTerminate == #Config.GradinarLocations[ClientLevel].Places
end

local function GetMissions()
    local misiuniTerminate = 0
    for k, v in pairs(MissionData) do
        if v.made then
            misiuniTerminate = misiuniTerminate + 1
        end 
    end
    return misiuniTerminate
end

local function udaAnimatie()
    local ped = PlayerPedId()
    local objCoords = vector3(GetEntityCoords(ped)[1] + GetEntityForwardVector(ped)[1] * 0.5,GetEntityCoords(ped)[2] + GetEntityForwardVector(ped)[1] * 0.5, GetEntityCoords(ped)[3] - 1.0)
    FreezeEntityPosition(ped, true)
    local bottleObj = CreateObject(GetHashKey("prop_wateringcan"), objCoords[1], objCoords[2], objCoords[3], true, true,true)
    loadAnimDict("random@domestic")
    TaskPlayAnim(ped, "random@domestic", "pickup_low", 1.0, 1.0, -1, 0, 0, false, false, false)
    Wait(750)
    AttachEntityToEntity(bottleObj, ped, GetPedBoneIndex(ped, 28422), 0.07, 0.0, -0.22, 0.0, 30.0, -0.0, 1, 1, 0, 1, 0,1)
    loadAnimDict("missarmenian3_gardener")
    TaskPlayAnim(ped, "missarmenian3_gardener", "blower_idle_a", 1.0, 1.0, -1, 16, 0, false, false, false)
    SetTimeout(14000, function()
        DeleteEntity(bottleObj)
        FreezeEntityPosition(ped, false)
        StropitoareApa = StropitoareApa - math.random(1,3)
    end)
end

RegisterNetEvent("UG:StartGradinar", function(toggle)
    hasJob = toggle

    if hasJob then 
        createTempBlips()
    else
        createTempBlips(true)
    end

    if not toggle then
        for k, v in pairs(MissionData) do
            RemoveBlip(v.blips)
        end
        MissionData = {}
    end

    Citizen.CreateThread(function()
        while hasJob do
            Wait(1)
            if hasMission then
                local playerCoords = GetEntityCoords(PlayerPedId())
                for k, v in pairs(MissionData) do
                    local distance = #(playerCoords - v.coords)
                    if distance <= 15 and not v.made then
                        DrawMarker(2, v.coords[1], v.coords[2], v.coords[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.3,0.15, 255, 255, 255, 222, false, false, false, true, false, false, false)
                        
                        if distance <= 2.5 then
                            ShowScreenText("Apasa tasta ~g~[E] ~s~pentru a uda")
                            if IsControlJustPressed(0,51) then
                                if StropitoareApa >= 3 then
                                v.made = true
                                RemoveBlip(v.blips)
                                udaAnimatie()
                                exports.rprogress:Custom({
                                    Duration = 14000,
                                    Label = "Uzi plantele...",
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

                                if hasFinishedMissions() then
                                    TriggerServerEvent("UG:FinishGradinarMission", GetMissions(), ClientLevel);
                                    hasMission = false
                                end
                            else
                                --[[ARGS: 'notify:Alert', function(title, message, time, type)]]
                                exports["vrp_notify"]:Alert("Info", "Nu ai destula apa in Stropitoare",5000, "info");
                             end
                             
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
            if umplereCooldown then
            local playerCoords = GetEntityCoords(PlayerPedId(), false)
            for k, v in pairs(Config.GradinarStropitori) do
                local distance = #(playerCoords - v.coords)

                if distance <= 10 then
                    DrawMarker(2, v.coords[1], v.coords[2], v.coords[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.3,0.15, 255, 255, 255, 222, false, false, false, true, false, false, false)

                    if distance <= 1.5 then
                        ShowScreenText("Tine apasata tasta ~g~[E] ~s~pentru a iti umple stropitoarea")
                            if IsControlJustPressed(0, 51) then
                                umplereCooldown = false
                                loadAnimDict("random@domestic")
                                TaskPlayAnim(PlayerPedId(), "random@domestic", "pickup_low", 1.0, 1.0, -1, 0, 0, false, false, false)
                                exports.rprogress:Custom({
                                    Duration = 2500,
                                    Label = "Iti umpli stropitoarea..",
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

                             SetTimeout(2500, function()
                                 StropitoareApa = StropitoareApa + math.random(1, 10)
                                 if StropitoareApa >= 95 then
                                     StropitoareApa = 100
                                 end
                                 umplereCooldown = true
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
                SendNUIMessage({
                    action = "showMenu",
                    tipCurentMenu = "STROPITOARE",
                    tipCurrentProduct = "Apa",
                    color = '52, 180, 235',
                    image = 'water.png',
                    progress = StropitoareApa
                })
            end
        end
    end)

    Citizen.CreateThread(function()
        while hasJob do
            Wait(1024)
            SendNUIMessage({
                action = "updateMenu",
                progress = StropitoareApa
            })
        end
    end)

end)