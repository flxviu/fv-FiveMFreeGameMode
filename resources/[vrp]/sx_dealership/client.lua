vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP","sx_dealership")
vRPds = Tunnel.getInterface("sx_dealership","sx_dealership")
vRPdsC = {}
Tunnel.bindInterface("sx_dealership",vRPdsC)
vRPSds = Tunnel.getInterface("sx_dealership","sx_dealership")
vRP.addBlip({-32.738410949707,-1096.3504638672,27.274339675903,595,26,'Showroom'})

local inShowroom = false
local inTesting = false
local showroomID = nil
local testVehicle = nil
local cam = nil

 CreateThread(function()
     while true do 
         local sleep = config.defaultWaitTime
         for k,v in pairs(config.dealerships) do 
             local dist = #(GetEntityCoords(PlayerPedId()) - v.coordsPed)
             if dist < 1.5 then
                 sleep = 1
                 drawTxt("APASA ~b~E~w~ PENTRU A INTRA IN SHOWROOM",4,0.5,0.93,0.50,255,255,255,180)
                 if IsControlJustPressed(0, 51) then
                     openCategories(k)
                 end
             end
         end
         Wait(sleep)
     end
 end)

-- RegisterCommand('dahashu', function()
--     local masina = GetVehiclePedIsIn(PlayerPedId())
--     local hash = GetHashKey(masina)

--     print("masina: "..masina.." hash: "..hash)
-- end)

openCategories = function(id)
    SetEntityVisible(PlayerPedId(), false)
    SetEntityCoords(PlayerPedId(),config.dealerships[id].coordsVehicle)
    inShowroom = true
    showroomID = id
    inTestingTime = 0
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)

    if config.dealerships[id].type == "vehicles" then
        SetCamCoord(cam, config.dealerships[id].coordsCam[1], config.dealerships[id].coordsCam[2], config.dealerships[id].coordsCam[3])
        PointCamAtCoord(cam, config.dealerships[id].coordsVehicle[1]+1.0, config.dealerships[id].coordsVehicle[2]+1.0, config.dealerships[id].coordsVehicle[3])
        RenderScriptCams(1, 0, 0, 1, 1)
    elseif config.dealerships[id].type == "airplane" then 
        SetCamCoord(cam, config.dealerships[id].coordsCam[1], config.dealerships[id].coordsCam[2], config.dealerships[id].coordsCam[3])
        PointCamAtCoord(cam, config.dealerships[id].coordsVehicle[1], config.dealerships[id].coordsVehicle[2], config.dealerships[id].coordsVehicle[3])
        RenderScriptCams(1, 0, 0, 1, 1)
    elseif config.dealerships[id].type == "boats" then 
        SetCamCoord(cam, config.dealerships[id].coordsCam[1], config.dealerships[id].coordsCam[2], config.dealerships[id].coordsCam[3])
        PointCamAtCoord(cam, config.dealerships[id].coordsVehicle[1], config.dealerships[id].coordsVehicle[2], config.dealerships[id].coordsVehicle[3])
        RenderScriptCams(1, 0, 0, 1, 1)
    end

    SetNuiFocus(true, true)


    SendNUIMessage({
        action = "openShowroomCategories",
        sh_name = config.dealerships[id].name,
        sh_type = config.dealerships[id].type,
        veh_table = config.dealerships[id].vehicles,
    })
end

openShowroom = function(id, numeCategorie)
    SetEntityVisible(PlayerPedId(), false)
    SetEntityCoords(PlayerPedId(),config.dealerships[id].coordsVehicle)
    inShowroom = true
    showroomID = id
    inTestingTime = 0
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)

    if config.dealerships[id].type == "vehicles" then
        SetCamCoord(cam, config.dealerships[id].coordsCam[1], config.dealerships[id].coordsCam[2], config.dealerships[id].coordsCam[3])
        PointCamAtCoord(cam, config.dealerships[id].coordsVehicle[1]+1.0, config.dealerships[id].coordsVehicle[2]+1.0, config.dealerships[id].coordsVehicle[3])
        RenderScriptCams(1, 0, 0, 1, 1)
    elseif config.dealerships[id].type == "airplane" then 
        SetCamCoord(cam, config.dealerships[id].coordsCam[1], config.dealerships[id].coordsCam[2], config.dealerships[id].coordsCam[3])
        PointCamAtCoord(cam, config.dealerships[id].coordsVehicle[1], config.dealerships[id].coordsVehicle[2], config.dealerships[id].coordsVehicle[3])
        RenderScriptCams(1, 0, 0, 1, 1)
    elseif config.dealerships[id].type == "boats" then 
        SetCamCoord(cam, config.dealerships[id].coordsCam[1], config.dealerships[id].coordsCam[2], config.dealerships[id].coordsCam[3])
        PointCamAtCoord(cam, config.dealerships[id].coordsVehicle[1], config.dealerships[id].coordsVehicle[2], config.dealerships[id].coordsVehicle[3])
        RenderScriptCams(1, 0, 0, 1, 1)
    end

    SetNuiFocus(true, true)


    SendNUIMessage({
        action = "openShowroomJS",
        sh_name = config.dealerships[id].name,
        sh_type = config.dealerships[id].type,
        veh_table = config.dealerships[id].vehicles[numeCategorie],
    })
end

-- Citizen.CreateThread(function()
--     while true do
--         Wait(400)
--         while Vdist2(GetEntityCoords(PlayerPedId()),  table.unpack(coordonateOpenShowroom)) <= 10  do
--             Wait(1)
--             DrawMarker(21, 106.12724304199,6435.7470703125,37.956539154053-0.1, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.60, 255, 255, 255, 165, 0, 0, 0, 1)
--             if inShowroom ~= true then
--                 drawTxt("APASA ~b~E~w~ PENTRU A INTRA IN SHOWROOM",4,0.5,0.93,0.50,255,255,255,180)
--                 if ( IsControlJustReleased(0,51) )then
--                     openCategories(k)
--                 end
--             end
--         end
--     end
-- end)

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

--NUI

RegisterNUICallback('closeShowroom', function(data, cb)
    DestroyCam(cam, false)
    SetCamActive(cam, false)
    RenderScriptCams(0, false, 100, false, false)
    SetNuiFocus(false, false)

    rablactuala = GetVehiclePedIsUsing(PlayerPedId())
    DeleteEntity(rablactuala)

    SetEntityCoords(PlayerPedId(),config.dealerships[showroomID].coordsPed[1]-1.0, config.dealerships[showroomID].coordsPed[2], config.dealerships[showroomID].coordsPed[3])

    inShowroom = false
    showroomID = nil
    SetEntityVisible(PlayerPedId(), true)
end)


RegisterNUICallback('changeVehicleColors', function(data, cb)
    if inShowroom then
        r, g, b = data.colours[1]:match("([^,]+),([^,]+),([^,]+)")
        rablactuala = GetVehiclePedIsUsing(PlayerPedId())
        if rablactuala ~= nil then
            SetVehicleCustomPrimaryColour(rablactuala, tonumber(r),tonumber(g),tonumber(b))
        end
    end
end)

RegisterNUICallback('schimbaCategoria', function(data, cb)
    openShowroom(showroomID, data.categorie)
end)

RegisterNUICallback('spawnTheVehicle', function(data, cb)
    for k,v in pairs (config.dealerships[showroomID].vehicles[tostring(data.numeC)]) do 
        
        if v.vehID == data.id then 
            model = v.spawncode
            RequestModel(model)
            local timpfake = 0
            while not HasModelLoaded(model) and timpfake < 500 do
                Wait(0)
                SetNuiFocus(false, false)
                timpfake = timpfake + 1
            end
            SetNuiFocus(true, true)
            rablactuala = GetVehiclePedIsUsing(PlayerPedId())
            if rablactuala == nil then
                local nveh = CreateVehicle(model, config.dealerships[showroomID].coordsVehicle[1], config.dealerships[showroomID].coordsVehicle[2], config.dealerships[showroomID].coordsVehicle[3], 120.0, false, false)
                SetPedIntoVehicle(PlayerPedId(),nveh,-1)
                SetVehicleEngineOn(nveh,false,false,0)
                SetVehicleDirtLevel(nveh,0.0)
                SetEntityHeading(nveh, config.dealerships[showroomID].headingVehicle)

                SetVehicleCustomPrimaryColour(nveh, 255,255,255)
                SetVehicleCustomSecondaryColour(nveh, 255,255,255)
            else
                DeleteEntity(rablactuala)
                local nveh = CreateVehicle(model, config.dealerships[showroomID].coordsVehicle[1], config.dealerships[showroomID].coordsVehicle[2], config.dealerships[showroomID].coordsVehicle[3], 120.0, false, false)
                SetPedIntoVehicle(PlayerPedId(),nveh,-1)
                SetVehicleEngineOn(nveh,false,true,true)
                SetVehicleDirtLevel(nveh,0.0)
                SetEntityHeading(nveh, config.dealerships[showroomID].headingVehicle)

                SetVehicleCustomPrimaryColour(nveh, 255,255,255)
                SetVehicleCustomSecondaryColour(nveh, 255,255,255)
            end

            SendNUIMessage({
                action = "updateVehicleSpecifications",
                speed = v.speed,
                acceleration = v.acceleration,
                brakes = v.brakes,
                seats = v.seats
            })
        end
    end
end)




Positions = {
	[1] = {-2160.6833496094,-396.16622924805,13.366439819336,83.6},
	[2] = {-2160.046875,-393.20867919922,13.345651626587,83.6},
	[3] = {-2159.5483398438,-390.2880859375,13.308574676514,83.6},
	[4] = {-2159.046875,-387.21661376953,13.269671440125,83.6},
	[5] = {-2158.1967773438,-384.17535400391,13.230498313904,83.6},
	[6] = {-2157.6965332031,-381.36590576172,13.195074081421,83.6},
    [7]={-2164.6,-380.2,13.1,262.3},
    [8]={-2164.6,-383.2,13.1,262.3},
    [9]={-2165.6,-386.2,13.1,262.3},
    [10]={-2165.6,-389.2,13.1,262.3},
    [11]={-2166.6,-392.2,13.1,262.3},
    [12]={-2167.6,-395.2,13.1,262.3},
    [13]={-2167.6,-398.2,13.1,262.3},
    [14]={-2167.6,-401.2,13.1,262.3},
    [15]={-2153.8,-414.7,13.4,32.9},
    [16]={-2151.0,-413.0,13.4,35.9},
    [17]={-2148.5,-411.3,13.4,37.9},
    [18]={-2146.3,-408.7,13.4,41.3}
    
}

function DrawText3D(x,y,z, text, scl, font) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(font)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
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
local function EndFade()
	Citizen.CreateThread(function()
		ShutdownLoadingScreen()

        DoScreenFadeIn(500)

        while IsScreenFadingIn() do
            Citizen.Wait(0)
        end
	end)
end
function showroom_drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

RegisterNUICallback(
	"spawncategory",
		function(data, cb)
            
            SetNuiFocus(false, false)
	
			
	invw = true
	cat = 1
    DestroyCam(cam, false)
    SetCamActive(cam, false)
    RenderScriptCams(0, false, 100, false, false)
    SetNuiFocus(false, false)

	SetEntityCoords(GetPlayerPed(-1),-2153.6169433594,-401.96615600586,13.372273445129)	

	vehslist = {}
	while invw do
		Wait(0)
		found = false
		usi = false
		unloadedvehs = "\n"
        data.vehs = config.dealerships[showroomID].vehicles[tostring(data.spawncategory)]
		for k,v in pairs(config.dealerships[showroomID].vehicles[tostring(data.spawncategory)]) do
			
 				if data.vehs[k].vehicle == nil then
					if not HasModelLoaded(data.vehs[k].spawncode) then
						RequestModel(data.vehs[k].spawncode)
						unloadedvehs = unloadedvehs..k.."\n"
					end
						
					
					if HasModelLoaded(data.vehs[k].spawncode) then
				
						data.vehs[k].vehicle = CreateVehicle(data.vehs[k].spawncode,Positions[cat][1],Positions[cat][2],Positions[cat][3],Positions[cat][4],false,false)
						SetVehicleEngineOn(data.vehs[k].vehicle,true,true,false)
						SetModelAsNoLongerNeeded(data.vehs[k].spawncode)
						table.insert(vehslist,data.vehs[k].vehicle)
						for i = 0,24 do
							SetVehicleModKit(data.vehs[k].vehicle,0)
							RemoveVehicleMod(data.vehs[k].vehicle,i)
						end
						if(data.vehs[k].vehicle)then
							SetEntityVisible(GetPlayerPed(-1),true)
							SetVehicleLights(data.vehs[k].vehicle,2)
						end
						cat = cat + 1
					end
				else
					local pos = GetEntityCoords(GetPlayerPed(-1), true)
					local posv = GetEntityCoords(data.vehs[k].vehicle, true)
					DrawText3D(posv.x, posv.y, posv.z+ 0.5, k.."\n"..data.vehs[k].price.."$", 1.0)
				
					if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, posv.x, posv.y, posv.z) < 3)then
						SetVehicleCurrentRpm(data.vehs[k].vehicle,1.0)
						if IsControlJustPressed(0,47) then
							if data.vehs[k].odors == nil then
								data.vehs[k].odors = false
							end
							data.vehs[k].odors = not data.vehs[k].odors
								for k1=-1,10 do
									if data.vehs[k].odors then
										SetVehicleDoorOpen(data.vehs[k].vehicle,k1,false,false)
									else
										SetVehicleDoorShut(data.vehs[k].vehicle,k1,true,false)
									end
								end
								Wait(500)
								
						end
						if data.vehs[k].odors == nil then
							data.vehs[k].odors = false
						end
						found = true
						if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, posv.x, posv.y, posv.z) < 1)then
							SetVehicleUndriveable(data.vehs[k].vehicle,true)
						else
							SetVehicleUndriveable(data.vehs[k].vehicle,false)
							SetVehicleLights(data.vehs[k].vehicle,2)
							SetVehicleEngineOn(data.vehs[k].vehicle,true,true,false)
						end
						if data.vehs[k].odors then
							usi = true
						end
					end
				end
		
		end
		if #unloadedvehs> 4 then
			showroom_drawTxt(1.235, 1.375, 1.0,1.0,0.4, "~r~Vehicule care inca se incarca:"..unloadedvehs, 255, 255, 255, 255)
		end
		--SetVehicleUndriveable(vcar,true)
		if found == true then
			if usi then
				showroom_drawTxt(0.935, 1.375, 1.0,1.0,0.4, "~r~[G] - ~w~Inchide Usile ~r~[H] - ~w~Iesi", 255, 255, 255, 255)
			else
				showroom_drawTxt(0.935, 1.375, 1.0,1.0,0.4, "~r~[G] - ~w~Deschide Usile  ~r~[H] - ~w~Iesi", 255, 255, 255, 255)
			end
		end
		if found == false then
			showroom_drawTxt(0.935, 1.375, 1.0,1.0,0.4, "~r~[H] - ~w~Iesi", 255, 255, 255, 255)
		end
		
		if IsControlJustPressed(0,74) then
			DoScreenFadeOut(1000)
					Wait(1000)
					
			for k,v in pairs(vehslist) do
				Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(v))
				SetEntityCoords(GetPlayerPed(-1),-39.77363204956,-1110.4862060546,26.438457489014)
			end
			TriggerServerEvent("exitvw")
			Wait(2000)
					EndFade()
				invw = false
		end
	end	
end)



function SecondsToClock(seconds,whatReturn)
    local seconds = tonumber(seconds)
  
    if seconds <= 0 then
      return "00:00:00";
    else
      hours = string.format("%02.f", math.floor(seconds/3600));
      mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
      secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
      if whatReturn == "hours" then
        return hours..":"..mins..":"..secs
      elseif whatReturn == "minutes" then
        return mins..":"..secs
      else
        return hours..":"..mins..":"..secs
      end
    end
end

RegisterNUICallback('spawnTheVehicleForTesting', function(data, cb)
    if inShowroom then
        for k,v in pairs (config.dealerships[showroomID].vehicles[tostring(data.numeC)]) do 
            if v.vehID == data.selectedVehicle then
                vRPSds.checkMoneyForTesting({v.price},function(haveMoney)

                    if haveMoney then

                        SendNUIMessage({action = "startTestingTheVehicle"})

                        model = v.spawncode
                        rablactuala = GetVehiclePedIsUsing(PlayerPedId())
                        DeleteEntity(rablactuala)

                        local nveh = CreateVehicle(model, config.dealerships[showroomID].testVehicleSpawn[1], config.dealerships[showroomID].testVehicleSpawn[2], config.dealerships[showroomID].testVehicleSpawn[3], config.dealerships[showroomID].testVehicleSpawnHeading, false, false)
                        SetPedIntoVehicle(PlayerPedId(),nveh,-1)
                        SetVehicleEngineOn(nveh,true,true,true)
                        SetVehicleDirtLevel(nveh,0.0)

                        testVehicle = nveh

                        if data.selectedColor == 0 then
                            SetVehicleCustomPrimaryColour(nveh, 255,255,255)
                        else
                            r, g, b = data.selectedColor[1]:match("([^,]+),([^,]+),([^,]+)")
                            rablactuala = GetVehiclePedIsUsing(PlayerPedId())
                            if rablactuala ~= nil then
                                SetVehicleCustomPrimaryColour(nveh, tonumber(r),tonumber(g),tonumber(b))
                            end
                        end

                        inShowroom = false
                        SetEntityVisible(PlayerPedId(), true)
                        DestroyCam(cam, false)
                        SetCamActive(cam, false)
                        RenderScriptCams(0, false, 100, false, false)
                        SetNuiFocus(false, false)

                        inTesting = true
                        inTestingTime = config.dealerships[showroomID].testVehicleTime

                        CreateThread(function()
                            while true do 
                                Wait(1000)
                                if inTesting then
                                    
                                    if not DoesEntityExist(testVehicle) then 
                                        DeleteEntity(testVehicle)
                                        inTestingTime = 0
                                    end

                                    if GetEntityHealth(PlayerPedId()) < 121 then 
                                        SetEntityHealth(PlayerPedId(),200)
                                        DeleteEntity(testVehicle)
                                        inTestingTime = 0
                                    end

                                    if inTestingTime == 0 then 

                                        DeleteEntity(GetVehiclePedIsUsing(PlayerPedId()))
                                        inTesting = false
                                        openShowroom(showroomID)
                                        break
                                    else
                                        SendNUIMessage({
                                            action = "timeRemaining",
                                            timeRemaining = SecondsToClock(inTestingTime,"minutes")
                                        })

                                        inTestingTime = inTestingTime - 1
                                        
                                    end
                                
                                end
                            end
                        end)
                    else
                        vRP.notify({"You don't have enough money for testing this vehcle."})
                    end
                end)
            end
        end
    end
end)


RegisterNUICallback('buyVehicle', function(data, cb)
    vRPSds.checkMoneyForBuyingVehicle({showroomID,data.selectedVehicle, data.numeC},function(haveMoney)
        if haveMoney then
            SendNUIMessage({action = "closeShowroom"})
        end
    end)
end)

RegisterNUICallback('openCategorii', function(data, cb)
    rablactuala = GetVehiclePedIsUsing(PlayerPedId())
    DeleteEntity(rablactuala)
    openCategories(showroomID)
end)