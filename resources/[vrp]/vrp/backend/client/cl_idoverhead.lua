local disPlayerNames = 13

local playerData = {}

local idsOn = false

RegisterNetEvent("ples-idoverhead:setCViewing")
AddEventHandler("ples-idoverhead:setCViewing", function(sid, val)
	if playerData[sid] then
		playerData[sid].view = val

		if val then
			Citizen.CreateThread(function()
				if (playerData[sid].dst or 99) < 20 then

					local id = GetPlayerFromServerId(sid)
					local ped = GetPlayerPed(id)

					while playerData[sid].view do

						if not NetworkIsPlayerActive(id) or ped == PlayerPedId() then
							break
						end

						if IsPedInAnyVehicle(ped, false) then
							local veh = GetVehiclePedIsIn(ped)
							if not IsThisModelABike(GetEntityModel(veh)) then
								if GetPedInVehicleSeat(veh, -1) == ped then
									x2, y2, z2 = table.unpack(GetOffsetFromEntityInWorldCoords(veh, -0.4, 0.0, 0.0))
								elseif GetPedInVehicleSeat(veh, 0) == ped then
									x2, y2, z2 = table.unpack(GetOffsetFromEntityInWorldCoords(veh, 0.4, 0.0, 0.0))
								elseif GetPedInVehicleSeat(veh, 1) == ped then
									x2, y2, z2 = table.unpack(GetOffsetFromEntityInWorldCoords(veh, -0.4, -0.8, 0.0))
								else
									x2, y2, z2 = table.unpack(GetOffsetFromEntityInWorldCoords(veh, 0.4, -0.8, 0.0))
								end
							else
								if GetPedInVehicleSeat(veh, -1) == ped then
									x2, y2, z2 = table.unpack(GetOffsetFromEntityInWorldCoords(veh, 0.0, 0.0, 0.3))
								else
									x2, y2, z2 = table.unpack(GetOffsetFromEntityInWorldCoords(veh, 0.0, -0.5, 0.5))
								end
							end
						else
							x2, y2, z2 = table.unpack(GetEntityCoords(ped, true))
						end
						DrawText3D(x2, y2, z2+1, playerData[sid].user_id, 2, 0, {94, 255, 113})

						Citizen.Wait(1)
					end
				end
			end)
		end
	end
end)


RegisterCommand('+viewid', function()
    idsOn = true
	TriggerServerEvent("ples-idoverhead:setViewing", true)
	ExecuteCommand("me Se scarpina la ochi!")
end, false)
RegisterCommand('-viewid', function()
    idsOn = false
	TriggerServerEvent("ples-idoverhead:setViewing", false)
end, false)

RegisterKeyMapping('+viewid', 'Vezi ID-urile', 'keyboard', 'DELETE')

AddEventHandler("playerSpawned", function()

	Citizen.CreateThread(function()
	    while true do
	        while idsOn do
	            for _, id in ipairs(GetActivePlayers()) do
	    			if NetworkIsPlayerActive(id) then
	    				if GetPlayerPed(id) ~= PlayerPedId() then
	    					local sId = GetPlayerServerId(id)
	                        if playerData[sId] then
	                        	if playerData[sId].dst then
		        					if playerData[sId].dst < disPlayerNames then
		        						local ped = GetPlayerPed(id)
										if IsPedInAnyVehicle(ped, false) then
											local veh = GetVehiclePedIsIn(ped)
											if not IsThisModelABike(GetEntityModel(veh)) then
												if GetPedInVehicleSeat(veh, -1) == ped then
													x2, y2, z2 = table.unpack(GetOffsetFromEntityInWorldCoords(veh, -0.4, 0.0, 0.0))
												elseif GetPedInVehicleSeat(veh, 0) == ped then
													x2, y2, z2 = table.unpack(GetOffsetFromEntityInWorldCoords(veh, 0.4, 0.0, 0.0))
												elseif GetPedInVehicleSeat(veh, 1) == ped then
													x2, y2, z2 = table.unpack(GetOffsetFromEntityInWorldCoords(veh, -0.4, -0.8, 0.0))
												else
													x2, y2, z2 = table.unpack(GetOffsetFromEntityInWorldCoords(veh, 0.4, -0.8, 0.0))
												end
											else
												if GetPedInVehicleSeat(veh, -1) == ped then
													x2, y2, z2 = table.unpack(GetOffsetFromEntityInWorldCoords(veh, 0.0, 0.0, 0.3))
												else
													x2, y2, z2 = table.unpack(GetOffsetFromEntityInWorldCoords(veh, 0.0, -0.5, 0.5))
												end
											end
										else
											x2, y2, z2 = table.unpack(GetEntityCoords(ped, true))
										end
		        						if NetworkIsPlayerTalking(id) then
		        							DrawText3D(x2, y2, z2+1, playerData[sId].user_id, 2, 0, {187, 115, 248})
		        						else
		        							DrawText3D(x2, y2, z2+1, playerData[sId].user_id, 2, 0, {255, 255, 255})
		        						end
		        					end
		        				end
	                        end
	    				end
	    			end
	            end
	            Citizen.Wait(1)
	        end
	        Citizen.Wait(200)
	    end
	end)

	Citizen.CreateThread(function()
	    while true do
	    	local selfPed = PlayerPedId()
	        for _, id in ipairs(GetActivePlayers()) do
	            if NetworkIsPlayerActive(id) then
	            	local userPed = GetPlayerPed(id)
	                if userPed ~= selfPed then
                        local x1, y1, z1 = table.unpack(GetEntityCoords(selfPed, true))
                        local x2, y2, z2 = table.unpack(GetEntityCoords(userPed, true))
                        local distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))

                        if playerData[GetPlayerServerId(id)] then
                        	playerData[GetPlayerServerId(id)].dst = distance
                        end
	                end
	            end
	        end
	        Citizen.Wait(3000)
	    end
	end)
end)

RegisterNetEvent("id:initPlayer")
AddEventHandler("id:initPlayer", function(src, uid)
	playerData[src] = {user_id = uid}
end)

RegisterNetEvent("id:removePlayer")
AddEventHandler("id:removePlayer", function(src)
	playerData[src] = nil
end)


OGFont = RegisterFontId('Font Logo')

function DrawText3D(x,y,z, text, scl, font, colors) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    scale = scale*fov

    if not colors then
      colors = {255, 255, 255}
    end
    if font == "OGFont" then
      font = OGFont
    end
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(font or 2)
        SetTextProportional(1)
        SetTextColour(colors[1], colors[2], colors[3], 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end