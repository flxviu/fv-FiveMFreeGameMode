local inSafeZone = false
local inSlowZone = false

local safeZone = nil

local safeZones = {
	["showroom"] = {-43.726108551026, -1101.1746826172, 35.20348739624, 50, true},
	["spawn"] = {-488.5849609375, -282.91690063477, 35.473323822021, 100, true},
	--["paintball"] = {230.11630249023,-24.016855239868,69.782211303711, 40, true},
	-- ["taxi"] = {-797.25836181641,-1308.7915039063,5.000382900238, 50, true}, 
	--["casino"] = {-1746.8065185547,-755.10034179688,9.9973878860474, 50, true},
	["spital"] = {312.29745483398,-590.3564453125,43.283985137939, 60, true},
	--["trucker"] = {819.14221191406,-2976.4624023438,6.020658493042, 70, true},
	["cnn"] = {-606.72247314453,-930.59405517578,23.862083435059, 40, true},
	--["mecanici"] = {138.45062255859,-3042.9780273438,7.0408911705017, 60, true},

	--["biliard"] = {-1612.9239501953,-983.63250732422,13.01732635498, 80, false},

	-- ["haine1"]  = {-712.11108398438,-155.24806213379,37.415126800537, 40, false},
--	["haine2"]  = {617.86389160156,2762.0537109375,42.088138580322, 40, false},
--	["haine3"]  = {-1099.5728759766,2710.2900390625,19.107845306396, 40, false},
--	["haine4"]  = {1.9525212049484,6513.3486328125,31.877853393555, 40, false},
}




local once = 
	
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)
		
		local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
		local px,py,pz = playerPos.x, playerPos.y, playerPos.z
		
		for i, v in pairs(safeZones)do
			x, y, z = v[1], v[2], v[3]
			radius = v[4]
			if(GetDistanceBetweenCoords(x, y, z, px, py, pz, false) < radius)then
				if v[5] then
					inSafeZone = true
				else
					inSlowZone = true
				
				end


				safeZone = i
			end
		end
		if safeZone ~= nil then
			x2, y2, z2 = safeZones[safeZone][1], safeZones[safeZone][2], safeZones[safeZone][3]
			radius2 = safeZones[safeZone][4]
			if(GetDistanceBetweenCoords(x2, y2, z2, px, py, pz, false) > radius2)then
				inSafeZone = false
				inSlowZone = false
				
			
				safeZone = nil
			end
		end
	end
end)

function tvRP.isInSafeZone()
	return inSafeZone
end

exports("isInSafeZone", function(acceptSlowZone)
	return inSafeZone or (acceptSlowZone and inSlowZone)
end)




local sendSafezone = false;
local wasInSafezone = false

local sendSlowzone = true 
local wasInSlowzone = false 




Citizen.CreateThread(function()
	local logoFont = RegisterFontId('Font Logo')

	while true do
		Citizen.Wait(1000)
		local ped = GetPlayerPed(-1)

		if sendSlowzone and inSlowZone then 
			sendSlowzone = false 
			wasInSlowzone = true 
			TriggerEvent("lucid:togSlowZone", true)
		end

		if wasInSlowzone and not inSlowZone then 
			wasInSlowzone = false 
			sendSlowzone = true 
			TriggerEvent("lucid:togSlowZone", false)
		end 


		while inSafeZone do
			Citizen.Wait(1)

			if not sendSafezone then 
				TriggerEvent("lucid:togSafeZone",true)
				sendSafezone = true
				wasInSafezone = true
			end
			DisableControlAction(0,25,true)
			DisableControlAction(0,47,true)
			DisableControlAction(0,58,true)
			DisableControlAction(0,263,true)
			DisableControlAction(0,264,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,140,true)
			DisableControlAction(0,141,true)
			DisableControlAction(0,142,true)
			DisableControlAction(0,143,true)
			SetEntityInvincible(ped, true)
			SetPlayerInvincible(PlayerId(), true)
			ClearPedBloodDamage(ped)
			ResetPedVisibleDamage(ped)
			ClearPedLastWeaponDamage(ped)
			SetEntityProofs(ped, true, true, true, true, true, true, true, true)
			SetEntityMaxSpeed(GetVehiclePedIsIn(ped, false), 8.0)
			SetEntityCanBeDamaged(ped, false)
		end

		if sendSafezone then 
			if wasInSafezone then 
				TriggerEvent("lucid:togSafeZone",false)
				sendSafezone = false 
			end
		end

		SetEntityInvincible(ped, false)
		SetPlayerInvincible(PlayerId(), false)
		ClearPedLastWeaponDamage(ped)
		SetEntityProofs(ped, false, false, false, false, false, false, false, false)
		SetEntityCanBeDamaged(ped, true)
		SetEntityMaxSpeed(GetVehiclePedIsIn(ped, false), 11001.5)
	end
end)


local greenZones = {
	{pos = vector3(138.45062255859,-3042.9780273438,7.0408911705017), width = 70.0, height = 100.0, rot = 0}, -- mecanici nou
	{pos = vector3(-1379.5339355469,-471.61624145508,31.589557647705), width = 120.0, height = 168.0, rot = 36},
	{pos = vector3(-1742.9849853516,-742.48602294922,11.206170082092), width = 38.0, height = 80.0, rot = 140},
	{pos = vector3(-1648.677734375,-905.58642578125,9.6934356689453), width = 100.0, height = 100.0, rot = 320},
	{pos = vector3(-533.13244628906,-223.70999145508,37.649765014648), width = 130.0, height = 150.0, rot = 210},
	{pos = vector3(223.03834533691,-37.733406066895,70.290115356445), width = 70.0, height = 50.0, rot = 340},
	{pos = vector3(293.47912597656,-590.38848876953,43.136894226074), width = 80.0, height = 60.0, rot = 248},
	{pos = vector3(441.56793212891,-982.18121337891,54.275299072266), width = 80.0, height = 95.0, rot = 89}, -- Politie
	{pos = vector3(-433.291015625,-1699.7692871094,29.277498245239), width = 50.0, height = 60.0, rot = 250},
	{pos = vector3(831.01556396484,-2974.0183105469,12.936800956726), width = 100.0, height = 80.0, rot = 0},
	{pos = vector3(-1020.0696411133,-2703.8911132813,13.807333946228), width = 230.0, height = 120.0, rot = 330},
	{pos = vector3(-54.799942016602,-1130.3120117188,25.887180328369), width = 220.0, height = 90.0, rot = 3},
	{pos = vector3(-797.25836181641,-1308.7915039063,5.000382900238), width = 75.0, height = 65.0, rot = 350},
    {pos = vector3(-755.28375244141,-1482.8428955078,5.0005226135254), width = 52.0, height = 64.0, rot = 202}, -- garaj aproape de taxi
	{pos = vector3(29.349266052246,-1734.4760742188,29.303062438965), width = 100.0, height = 45.0, rot = 45}, -- barci
	{pos = vector3(-584.84497070313,-1006.6435546875,25.367637634277), width = 80.0, height = 110.0, rot = 180},
	{pos = vector3(-337.17431640625,-135.36282348633,40.757350921631), width = 22.0, height = 45.0, rot = 70},
	{pos = vector3(105.64133453369,6623.2465820313,31.787233352661), width = 40.0, height = 40.0, rot = 50},

	{pos = vector3(1180.2391357422,2638.6555175781,37.753799438477), width = 40.0, height = 40.0, rot = 85},
	{pos = vector3(-212.07019042969,-1324.0407714844,30.890394210815), width = 20.0, height = 20.0, rot = 90},
	-- CNN
	{pos = vector3(-637.83312988281,-899.97344970703,23.588891983032), width = 210.0, height = 120.0, rot = 180},

  {pos = vector3(-1193.0712890625,-771.43090820313,17.323612213135), width = 50.0, height = 55.0, rot = 40},
  {pos = vector3(-1450.275390625,-236.48387145996,49.809371948242), width = 25.0, height = 25.0, rot = 40},
  {pos = vector3(425.5110168457,-804.87091064453,29.491151809692), width = 28.0, height = 28.0, rot = 0},
  {pos = vector3(75.464111328125,-1394.7019042969,29.377243041992), width = 28.0, height = 28.0, rot = 0},
  {pos = vector3(-823.77941894531,-1074.3265380859,11.329222679138), width = 28.0, height = 28.0, rot = 28},
  {pos = vector3(122.7183303833,-224.45320129395,54.557849884033), width = 28.0, height = 40.0, rot = -20},
  {pos = vector3(-162.90524291992,-302.53997802734,39.733299255371), width = 28.0, height = 28.0, rot = -20},
  {pos = vector3(250.40768432617,-1101.7937011719,40.869739532471), width = 70.0, height = 70.0, rot = 89} -- avocat

}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		local plyPos = GetEntityCoords(GetPlayerPed(-1))
		for _, zone in pairs(greenZones) do

			local dst = (IsPauseMenuActive() and 0.0) or GetDistanceBetweenCoords(plyPos, zone.pos, false)
			local minDst = math.max(zone.width, zone.height) + 10.0
			if not zone.blip and dst <= minDst then
				zone.blip = AddBlipForArea(zone.pos, zone.width, zone.height)
				SetBlipRotation(zone.blip, zone.rot)
				SetBlipColour(zone.blip, 69)
				SetBlipAlpha(zone.blip, 100)
			elseif dst > minDst then
				RemoveBlip(zone.blip)
				zone.blip = nil
			end

		end
	end
end)
