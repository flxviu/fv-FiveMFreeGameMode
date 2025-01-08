-- DA DA , SUNTETI DEVELOPERI BUNI JOIN PE SHOP DACA VREI MAI MULTE -> https://discord.gg/JUnemf8YuU
-- DA DA , SUNTETI DEVELOPERI BUNI JOIN PE SHOP DACA VREI MAI MULTE -> https://discord.gg/JUnemf8YuU
-- DA DA , SUNTETI DEVELOPERI BUNI JOIN PE SHOP DACA VREI MAI MULTE -> https://discord.gg/JUnemf8YuU
-- DA DA , SUNTETI DEVELOPERI BUNI JOIN PE SHOP DACA VREI MAI MULTE -> https://discord.gg/JUnemf8YuU
-- DA DA , SUNTETI DEVELOPERI BUNI JOIN PE SHOP DACA VREI MAI MULTE -> https://discord.gg/JUnemf8YuU
-- DA DA , SUNTETI DEVELOPERI BUNI JOIN PE SHOP DACA VREI MAI MULTE -> https://discord.gg/JUnemf8YuU
-- DA DA , SUNTETI DEVELOPERI BUNI JOIN PE SHOP DACA VREI MAI MULTE -> https://discord.gg/JUnemf8YuU
-- DA DA , SUNTETI DEVELOPERI BUNI JOIN PE SHOP DACA VREI MAI MULTE -> https://discord.gg/JUnemf8YuU
-- DA DA , SUNTETI DEVELOPERI BUNI JOIN PE SHOP DACA VREI MAI MULTE -> https://discord.gg/JUnemf8YuU
-- DA DA , SUNTETI DEVELOPERI BUNI JOIN PE SHOP DACA VREI MAI MULTE -> https://discord.gg/JUnemf8YuU
-- DA DA , SUNTETI DEVELOPERI BUNI JOIN PE SHOP DACA VREI MAI MULTE -> https://discord.gg/JUnemf8YuU
-- DA DA , SUNTETI DEVELOPERI BUNI JOIN PE SHOP DACA VREI MAI MULTE -> https://discord.gg/JUnemf8YuU

local vRPdoors = Tunnel.getInterface("vRP_doors", "vRP_doors")

Citizen.CreateThread(function()
	local txd = CreateRuntimeTxd("doorlock")
	CreateRuntimeTextureFromImage(txd, "lock", "assests/locked.png")
	CreateRuntimeTextureFromImage(txd, "unlock", "assests/unlocked.png")

	vRPdoors.getDoorsInfo({}, function(doorInfo)
		for localID = 1, #doorInfo, 1 do
			if doorInfo[localID] ~= nil then
				Config.DoorList[doorInfo[localID].doorID].locked = doorInfo[localID].state
			end
		end
	end)
end)

local enableField = false

function toggleField(enable)
  SetNuiFocus(enable, enable)
  enableField = enable

  SendNUIMessage({
    type = "enableui",
    enable = enable
  })
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5) -- A Short Daily of 5 MS
		DisableControlAction(0, 140, true) -- Disable the Light Dmg Contr ol
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		local ped = PlayerPedId()
            	if IsPedArmed(ped, 6) then
	    	DisableControlAction(1, 140, true)
            	DisableControlAction(1, 141, true)
            	DisableControlAction(1, 142, true)
        end
    end
end)

RegisterNUICallback('escape', function(data, cb)
    toggleField(false)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('try', function(data, cb)
	toggleField(false)
	local code = data.code
	
	local playerCoords = GetEntityCoords(PlayerPedId())

	for i=1, #Config.DoorList do
		local doorID   = Config.DoorList[i]
		local distance = GetDistanceBetweenCoords(playerCoords, doorID.objCoords.x, doorID.objCoords.y, doorID.objCoords.z, true)
		
		local maxDistance = 1.25
		
		if doorID.distance then
			maxDistance = doorID.distance
		end

		if distance < maxDistance then
			for x=1, #doorID.authorizedCodes do
				if doorID.authorizedCodes[x] == code then
					doorID.locked = not doorID.locked
					if doorID.locked then
						vRPdoors.updateState({i, true})
					else
						vRPdoors.updateState({i, false})
					end
					
				end
			end
		end
	end		
    cb('ok')
end)

Citizen.CreateThread(function()
	local playerCoords = GetEntityCoords(PlayerPedId())
	local nearDoors = {}
	Citizen.CreateThread(function()
		while true do 
			Citizen.Wait(3000)
			playerCoords = GetEntityCoords(PlayerPedId())
			nearDoors = {}
			for i=1, #Config.DoorList do
				Citizen.Wait(10)
				local doorID   = Config.DoorList[i]
				local distance = GetDistanceBetweenCoords(playerCoords, doorID.objCoords.x, doorID.objCoords.y, doorID.objCoords.z, true)
				if distance < 50.0 then
					table.insert(nearDoors, doorID)
				end
			end
		end 
	end)
	local wTime = 100
	while true do
		for k, doorID in pairs(nearDoors) do
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), doorID.objCoords.x, doorID.objCoords.y, doorID.objCoords.z, true)

			local maxDistance = 5.0
			if doorID.distance then
				maxDistance = doorID.distance
			end

			if distance < maxDistance then
				wTime = 1
				ApplyDoorState(doorID)

				local size = 1
				if doorID.size then
					size = doorID.size
				end

				local img = "unlock"
				if doorID.locked then
					img = "lock"
				end

				if IsControlJustReleased(0, 38) then
					toggleField(true)
				end

				DrawImage3D(img, doorID.textCoords.x, doorID.textCoords.y, doorID.textCoords.z, 0.04, 0.09, 0.0)
			end
		end
		Citizen.Wait(wTime)
		wTime = 100
	end
end)


function ApplyDoorState(doorID)
	local hash = doorID.objModel
	if not hash then hash = GetHashKey(doorID.objName) end
	local closeDoor = GetClosestObjectOfType(doorID.objCoords.x, doorID.objCoords.y, doorID.objCoords.z, 1.0, hash, false, false, false)
	FreezeEntityPosition(closeDoor, doorID.locked)
end

function DrawImage3D(name, x, y, z, width, height, rot) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, true)
	
    if onScreen then
		local width = (1/dist)*width
		local height = (1/dist)*height
		local fov = (1/GetGameplayCamFov())*100
		local width = width*fov
		local height = height*fov
	
		DrawSprite("doorlock", name, _x, _y, width, height, rot, 255, 255, 255, 255)
	end
end

-- Set state for a door
RegisterNetEvent('vRP_doors:setdoorState')
AddEventHandler('vRP_doors:setdoorState', function(doorID, state)
	Config.DoorList[doorID].locked = state
end)

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	toggleField(false)
end)