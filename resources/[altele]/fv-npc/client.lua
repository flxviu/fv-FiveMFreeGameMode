local UGIlegale = {}

vRP = Proxy.getInterface("vRP") -- vRPclient
Tunnel.bindInterface("ug_ilegale", UGIlegale)
Proxy.addInterface("ug_ilegale", UGIlegale)

local pedList = {}
local IDMeniuDeschis = 0;

CreateThread(function()
    local camCoords = nil
    local pedInfo = {}
    local camRotation = nil
    Wait(1)
    for k, v in pairs(Config.Npcs) do
        RequestModel(GetHashKey(v.npc))
        while not HasModelLoaded(GetHashKey(v.npc)) do
            Wait(1)
        end

        RequestAnimDict("mini@strip_club@idles@bouncer@base")
        while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
            Wait(1)
        end

        ped = CreatePed(4, v.npc, v.coords[1], v.coords[2], v.coords[3], v.heading, false, true)
        SetEntityHeading(ped, v.heading)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskPlayAnim(ped, "mini@strip_club@idles@bouncer@base", "base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
        local px, py, pz = table.unpack(GetEntityCoords(ped, true))
        local x, y, z = px + GetEntityForwardX(ped) * 1.2, py + GetEntityForwardY(ped) * 1.2, pz + 0.52
        camCoords = vector3(x, y, z)
        local rx = GetEntityRotation(ped, 2)
        camRotation = rx + vector3(0.0, 0.0, 181)
        -- Auto Position
        local px, py, pz = table.unpack(GetEntityCoords(ped, true))
        local x, y, z = px + GetEntityForwardX(ped) * 1.2, py + GetEntityForwardY(ped) * 1.2, pz + 0.52

        camCoords = vector3(x, y, z)

        -- Auto Cam Rotation
        local rx = GetEntityRotation(ped, 2)
        camRotation = rx + vector3(0.0, 0.0, 181)

        pedList[#pedList + 1] = {
            name = v.text,
            model = v.npc,
            pedCoords = v.coords,
            entity = ped,
            camCoords = camCoords,
            camRotation = camRotation
        }
    end
end)

local cam = nil
local openCache = {}
for i = 1, #Config.Npcs do
    openCache[i] = false
end

CreateThread(function()
    while true do
        local sleepTime = 1024
        local _PEDCOORDS = GetEntityCoords(PlayerPedId(), false)
        for i = 1, #Config.Npcs do
            if #(Config.Npcs[i].coords - _PEDCOORDS) <= 8.5 and not openCache[i] then
                DrawText3D(Config.Npcs[i].holo, '~w~~g~[E]~w~ Vorbeste cu ~g~' .. Config.Npcs[i].text)
                sleepTime = 1;
            end
            if #(Config.Npcs[i].coords - _PEDCOORDS) <= 3.5 and not openCache[i] then
                if IsControlJustReleased(0, 51) then
                    StartCam(Config.Npcs[i].coords, Config.Npcs[i].camOffset, Config.Npcs[i].camRotation,
                        Config.Npcs[i].npc, Config.Npcs[i].text)
                    SendNUIMessage({
                        action = "createSelector",
                        meniu = tostring(Config.Npcs[i].meniu),
                        descriere = tostring(Config.Npcs[i].descriereMeniu),
                        rolNPC = tostring(Config.Npcs[i].rolNPC),
                        numeNPC = tostring(Config.Npcs[i].text)
                    })
                    SetNuiFocus(true, true)
                    IDMeniuDeschis = i;
                    openCache[i] = true;
                end
                sleepTime = 1;
            end
        end
        Wait(sleepTime)
    end
end)

function StartCam(coords, offset, rotation, model, name)
    ClearFocus()

    for k, v in pairs(pedList) do
        if v.pedCoords == coords then
            if v.name == name and v.model == model then
                rotation = v.camRotation
            end
        end
    end

    for k, v in pairs(pedList) do
        if v.pedCoords == coords then
            if v.name == name and v.model == model then
                coords = v.camCoords
            end
        end
    end

    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords, rotation, GetGameplayCamFov())

    SetCamActive(cam, true)
    RenderScriptCams(true, true, 1000, true, false)
end

function DrawText3D(coordsTable, text)
    local x, y, z = table.unpack(coordsTable)
    local scale = 0.4
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

RegisterNUICallback("inchideMeniul", function(data)
    if (data.inchidereNpc) then
        openCache[IDMeniuDeschis] = false;
        IDMeniuDeschis = 0;
        ClearFocus()
        RenderScriptCams(false, true, 1000, true, false)
        DestroyCam(cam, false)
        cam = nil
    end
    SetNuiFocus(false, false);
end)

RegisterNUICallback("actionData", function(data)
    TriggerServerEvent(data)
end)
