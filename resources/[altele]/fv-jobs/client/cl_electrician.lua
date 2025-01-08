local hasElectrician = false
local MissionData = {}
local ElectricianBlip
local hasMission = false

local hasLadderInHand = false
local ladderInHandObj = 0

local hasLadderPlaced = false
local ladderPlacedObj = 0

local minigameWins
local minigameWinsNeeded

RegisterNetEvent("UG:RegenerateElectrician", function(mission)
    MissionData.coords = Config.ElectricianLocations[mission].coords
    MissionData.PropHash = Config.ElectricianLocations[mission].PropHash

    if DoesBlipExist(ElectricianBlip) then
        RemoveBlip(ElectricianBlip)
    end
    
    ElectricianBlip = AddBlipForCoord(MissionData.coords)
    SetBlipSprite(ElectricianBlip, 400)
    SetBlipScale(ElectricianBlip, 0.6)
    SetBlipColour(ElectricianBlip, 26)
	SetBlipRoute(ElectricianBlip, true)
	SetBlipRouteColour(ElectricianBlip, 26)


    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Stalp de Electricitate")
    EndTextCommandSetBlipName(ElectricianBlip)

    hasMission = true
end)

local function DrawText3D(x, y, z, text, scl, font, colors)

    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = #(vector3(px,py,pz) - vector3(x,y,z))


    local scale = (1 / dist) * scl
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextScale(0.0 * scale, 1.1 * scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(colors[1], colors[2], colors[3], 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

local function showMinigame(toggle)
	SetNuiFocus(toggle, toggle)
	SendNUIMessage({open = toggle})
end

local function StartAnim(lib, anim)
	RequestAnimDict(lib)
	while not HasAnimDictLoaded(lib) do
		Wait(1)
	end
	TaskPlayAnim(PlayerPedId(), lib, anim ,8.0, -8.0, -1, 50, 0, false, false, false)
end

RegisterNUICallback("closeMinigame", function()
	showMinigame(false)
	minigameWins = -1
end)

RegisterNUICallback("winMinigame", function()
	minigameWins = (minigameWins or 0) + 1
end)

RegisterNetEvent("UG:StartElectrician", function(job)
    if job then
        hasElectrician = true
    else
        RemoveBlip(ElectricianBlip)
    end


    local action = true 

    Citizen.CreateThread(function()
        while hasElectrician do
            Wait(1)
            if hasMission and DoesEntityExist(GetPlayersLastVehicle()) then
                local playerCoords = GetEntityCoords(PlayerPedId())
                
                local stalp = GetClosestObjectOfType(MissionData.coords[1], MissionData.coords[2],MissionData.coords[3], 1.0, MissionData.PropHash, false, false, false)
                local stalpCoords = GetEntityCoords(stalp)
                
                local vehicle = GetPlayersLastVehicle()
                local vehPos = GetEntityCoords(vehicle)
                local vehDst = #(playerCoords - vehPos)
             
                local dist = #(playerCoords - stalpCoords)

                if dist <= 5 then
                    if IsPedInAnyVehicle(PlayerPedId()) then
                        DrawText3D(stalpCoords[1], stalpCoords[2], stalpCoords[3] + 2.5, "Coboara din vehicul", 1.2, 2,{122, 195, 254})
                    else

                        if not hasLadderInHand then

                            DrawText3D(vehPos.x, vehPos.y, vehPos.z + 1, "Apasa E~n~~w~Ia scara din vehicul", 1.2, 2,{122, 195, 254})

                            if vehDst <= 3.0 then
                                if IsControlJustPressed(0, 38) and action  then
                                    action = false 
                                    local ok, type, vehicleName = vRP.getNearestOwnedVehicle{25.0}
                                    if vehicleName:lower() ~= 'comet2' then return exports['ax-pack']:Alert("Info", "Trebuie sa folosesti masina de electrician!",5000, "info") end 

                                    StartAnim('mini@repair', 'fixing_a_ped')
                                    exports.rprogress:Custom({
                                        Duration = 5000,
                                        Label = "Iei scara din masina...",
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

                                    Wait(5000)
                                    action = true
                                    ladderInHandObj = CreateObject(GetHashKey("prop_byard_ladder01"), playerCoords, true,true, true)
                                    StartAnim('amb@world_human_muscle_free_weights@male@barbell@idle_a', 'idle_a')
                                    AttachEntityToEntity(ladderInHandObj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.05, 0.1, -0.3, 300.0, 100.0, 20.0, true, true, false, true, 1, true)

                                    hasLadderInHand = true
                                end
                            end

                        else

                            DrawText3D(stalpCoords[1], stalpCoords[2], stalpCoords[3] + 2.5, "Apasa E~n~~w~Monteaza scara", 1.2, 2, {122, 195, 254})
                            if dist <= 2.0 then
                                if IsControlJustPressed(0, 38) then

                                    hasLadderInHand = false
                                    DeleteObject(ladderInHandObj)

                                    StartAnim('mini@repair', 'fixing_a_ped')
                                    exports.rprogress:Custom({
                                        Duration = 5000,
                                        Label = "Montezi scara...",
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

                                    Wait(5000)
                                    ClearPedTasks(PlayerPedId())
                                    ladderPlacedObj = CreateObject(GetHashKey("hw1_06_ldr_"), stalpCoords - vector3(0.5, 0, 0),true, true, false)

                                    PlaceObjectOnGroundProperly(ladderPlacedObj)
                                    SetEntityHeading(ladderPlacedObj, 69.0)
                                    FreezeEntityPosition(ladderPlacedObj, true)
                                    SetEntityAsMissionEntity(ladderPlacedObj, true, true)

                                    hasLadderPlaced = true

                                    while hasMission do
                                        local playerCoords = GetEntityCoords(PlayerPedId())
                                        if playerCoords[3] >= stalpCoords[3] + 6 then
                                            break
                                        end
                                        Wait(100)
                                    end

                                    minigameWins = 0
                                    showMinigame(true)
                                    FreezeEntityPosition(PlayerPedId(), true)

                                    math.randomseed(GetGameTimer())
                                    minigameWinsNeeded = math.random(1, 4)

                                    while hasElectrician and minigameWins < minigameWinsNeeded do
                                        Wait(1000)
                                        if minigameWins == -1 then
                                            break
                                        end
                                    end

                                    showMinigame(false)
                                    FreezeEntityPosition(PlayerPedId(), false)

                                    if hasMission and minigameWins > 0 then

                                        while hasMission do
                                            Wait(1)
                                            if hasLadderPlaced then

                                                local dst = #(playerCoords - stalpCoords)

                                                DrawText3D(stalpCoords[1], stalpCoords[2], stalpCoords[3] + 2.5, "Apasa E~n~~w~Demonteaza scara",1.2, 2, {122, 195, 254})

                                                if dst <= 2.0 then
                                                    if IsControlJustPressed(0, 38) then
                                                        StartAnim('mini@repair', 'fixing_a_ped')
                                                        exports.rprogress:Custom({
                                                            Duration = 5000,
                                                            Label = "Demontezi scara...",
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
                                                        Wait(5000)
                                                        DeleteObject(ladderPlacedObj)
                                                        ladderInHandObj = CreateObject(GetHashKey("prop_byard_ladder01"), playerCoords, true, true, true)
                                                        StartAnim('amb@world_human_muscle_free_weights@male@barbell@idle_a','idle_a')
                                                        AttachEntityToEntity(ladderInHandObj, PlayerPedId(),GetPedBoneIndex(PlayerPedId(), 28422), 0.05, 0.1, -0.3, 300.0, 100.0,20.0, true, true, false, true, 1, true)

                                                        hasLadderPlaced = false
                                                        hasLadderInHand = true
                                                    end
                                                end

                                            else

                                                DrawText3D(vehPos.x, vehPos.y, vehPos.z + 1,"Apasa E~n~~w~Pune scara in vehicul", 1.2, 2, {122, 195, 254})


                                             

                                                if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(GetPlayersLastVehicle())) <= 3.0 then 
                                            
                                                  if IsControlJustPressed(0, 38) then
                                                      StartAnim('mini@repair', 'fixing_a_ped')
                                                      exports.rprogress:Custom({
                                                          Duration = 5000,
                                                          Label = "Pui scara in masina...",
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
                                                      Wait(5000)
                                                      hasLadderInHand = false
                                                      DeleteObject(ladderInHandObj)
                                                      ClearPedTasks(PlayerPedId())
 
                                                      break
                                                  end
                                                end
                                            end
                                        end
                                        TriggerServerEvent("UG:GiveElectricianReward",MissionData.coords)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
end)
