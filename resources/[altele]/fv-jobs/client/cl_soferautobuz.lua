vRP = Proxy.getInterface("vRP") -- vRPclient

local hasJobSoferAutobuz = false

local inCursa = false

local CurrentMission
local busEvent = 0;
local busBlip
local bus

local function GenerateNextStation()
    busEvent = busEvent + 1
    CurrentMission = Config.BusLocations[busEvent]

    busBlip = AddBlipForCoord(CurrentMission.coords[1], CurrentMission.coords[2], CurrentMission.coords[3])
    SetBlipAsShortRange(busBlip, true)
    SetBlipColour(busBlip, 26)
    SetBlipScale(busBlip, 0.7)
    SetBlipRoute(busBlip, true)
end

local function SpawnBus()
    inCursa = true
    GenerateNextStation()

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped, true)
    local vehicle = GetHashKey("bus")
    RequestModel(vehicle)
    while not HasModelLoaded(vehicle) do
        Wait(1)
    end
    bus = CreateVehicle(vehicle, coords.x, coords.y, coords.z + 0.5, 213.70028686523, true, false)
    SetVehicleOnGroundProperly(bus)
    SetEntityInvincible(bus, false)
    SetPedIntoVehicle(PlayerPedId(), bus, -1)
    Citizen.InvokeNative(0xAD738C3085FE7E11, bus, true, true) -- set as mission entity
    SetVehicleHasBeenOwnedByPlayer(bus, true)
    SetModelAsNoLongerNeeded(vehicle)
end

RegisterNetEvent("UG:AutobuzStartCursa", function()
    SpawnBus()
end)

local function DespawnBus()
    DeleteEntity(bus)
    busEvent = 0
    inCursa = false
end

RegisterNetEvent("UG:StartSoferAutobuz", function(toggle)
    hasJobSoferAutobuz = toggle

    Citizen.CreateThread(function()
        while hasJobSoferAutobuz do
            Wait(1)
            if inCursa then

                if IsPedInAnyVehicle(PlayerPedId()) then
                    if not GetVehiclePedIsIn(PlayerPedId()) == bus then
                        ShowScreenText("~r~Intoarce te inapoi la autobuz pentru a continua cursa...")
                    end
                else
                    ShowScreenText("~r~Intoarce te inapoi la autobuz pentru a continua cursa...")
                end

                local playerCoords = GetEntityCoords(PlayerPedId())
                local distance = #(playerCoords - CurrentMission.coords)

                if distance <= 75 then
                    DrawMarker(0, CurrentMission.coords[1], CurrentMission.coords[2], CurrentMission.coords[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.2, 1.2, 1.15, 250, 250, 250, 90, false, false, false, true,false, false, false)
                end

                if distance <= 2.5 and not busEvent ~= #Config.BusLocations then
                    if CurrentMission.station and GetVehiclePedIsIn(PlayerPedId()) == bus then
                        RemoveBlip(busBlip)
                        exports.rprogress:Custom({
                            Duration = 15000,
                            Label = "Asteapta sa urce/coboare pasagerii...",
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
                        Wait(15000)
                        GenerateNextStation()
                    else
                    if busEvent ~= #Config.BusLocations then
                        if GetVehiclePedIsIn(PlayerPedId()) == bus then
                            RemoveBlip(busBlip)
                            GenerateNextStation()
                        end
                    end
                    end
                end

                if distance <= 5 and not CurrentMission.station and busEvent == #Config.BusLocations then
                    ShowScreenText("Apasa tasta ~g~[E] ~s~pentru a termina cursa")
                    if IsControlJustReleased(1, 51) then
                        RemoveBlip(busBlip)
                        DespawnBus()
                        TriggerServerEvent("UG:GiveAutobuzMoney",CurrentMission.coords);
                    end
                end

            end
        end
    end)

    Citizen.CreateThread(function()
        while hasJobSoferAutobuz do
            Wait(1)
            if not inCursa then
            local playerCoords = GetEntityCoords(PlayerPedId())
            for k, v in pairs(Config.busLocations) do
                if #(playerCoords - v.coords) <= 25 then
                    DrawMarker(2, v.coords[1], v.coords[2], v.coords[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.3, 0.15,255, 255, 255, 150, false, false, false, true, false, false, false)
                    if #(playerCoords - v.coords) <= 1.5 then
                        ShowScreenText("Apasa tasta ~g~[E] ~s~pentru a incepe cursa")
                        if IsControlJustReleased(1, 51) then
                            TriggerServerEvent("UG:RequestBusSpawn")
                        end
                    end
                end
              end
            end
        end
    end)

end)
