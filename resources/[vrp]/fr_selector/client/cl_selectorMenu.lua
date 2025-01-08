local _PED = PlayerPedId();
local _PEDCOORDS = GetEntityCoords(_PED);
local IDMeniuDeschis = 0;
CreateThread(function()
    while true do
        _PED = PlayerPedId();
        _PEDCOORDS = GetEntityCoords(_PED);
        Wait(250)
    end
end)

-- █▄░█ █▀█ █▀▀ ▄▄ █░█ █▀█ █
-- █░▀█ █▀▀ █▄▄ ░░ █▄█ █▀▄ █
CreateThread(function()
	local camCoords = nil
	local camRotation = nil
	Wait(1)
	for k, v in pairs(Config.NPCList) do
		RequestModel(GetHashKey(v.npc))
		while not HasModelLoaded(GetHashKey(v.npc)) do
			Wait(1)
		end

		RequestAnimDict("mini@strip_club@idles@bouncer@base")
		while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
			Wait(1)
		end

		ped = CreatePed(4, v.npc, v.coordonate[1], v.coordonate[2], v.coordonate[3], v.heading, false, true)
		SetEntityHeading(ped, v.heading)
		FreezeEntityPosition(ped, true)
		SetEntityInvincible(ped, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
		TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
		local px, py, pz = table.unpack(GetEntityCoords(ped, true))
		local x, y, z = px + GetEntityForwardX(ped) * 1.2, py + GetEntityForwardY(ped) * 1.2, pz + 0.52
		camCoords = vector3(x, y, z)
		local rx = GetEntityRotation(ped, 2)
		camRotation = rx + vector3(0.0, 0.0, 181)
	end
end)

-- ▀█▀ █░█ █▀█ █▀▀ ▄▀█ █▀▄ █░█ █▀█ █
-- ░█░ █▀█ █▀▄ ██▄ █▀█ █▄▀ █▄█ █▀▄ █
local openCache = {}
for i=1,#Config.NPCList do openCache[i] = false end

CreateThread(function()
    while true do
        local sleepTime = 1024
        for i=1,#Config.NPCList do
            if #(Config.NPCList[i].coordonate - _PEDCOORDS) <= 8.5 and not openCache[i] then
                DrawText3D(Config.NPCList[i].holo, '~w~[~g~E~w~] Vorbeste cu ~b~'..Config.NPCList[i].text)
                sleepTime = 1;
            end
            if #(Config.NPCList[i].coordonate - _PEDCOORDS) <= 3.5 and not openCache[i] then
                if IsControlJustReleased(0,51) then
                    SendNUIMessage({
                        action = "createSelector",
                        meniu = tostring(Config.NPCList[i].meniu),
                        descriere = tostring(Config.NPCList[i].descriereMeniu),
                        rolNPC = tostring(Config.NPCList[i].rolNPC),
                        numeNPC = tostring(Config.NPCList[i].text),
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

-- █▀▀ █░█ █▄░█ █▀▀ ▀█▀ █ █   █▀▄▀█ █▀▀ █▄░█ █ █░█
-- █▀░ █▄█ █░▀█ █▄▄ ░█░ █ █   █░▀░█ ██▄ █░▀█ █ █▄█

RegisterNUICallback("inchideMeniul", function()
    openCache[IDMeniuDeschis] = false;
    IDMeniuDeschis = 0;
    SetNuiFocus(false, false);
end)

function DrawText3D(coordsTable, text)
    local x,y,z = table.unpack(coordsTable)
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
        local factor = (string.len(text)) / 300
        DrawRect(_x, _y + 0.0135, 0.0 + factor, 0.030, 0, 0, 0, 65)
    end
end

-- Anunturi
RegisterNUICallback('__anunt:comercial__', function()
    TriggerServerEvent('CNN:Create', 'comercial')
end)

RegisterNUICallback('__anunt:eveniment__', function()
    TriggerServerEvent('CNN:Create', 'event')
end)