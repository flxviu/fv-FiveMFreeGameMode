
Key = 38 -- ENTER

vehicleWashStation = {
	{26.5906,  -1392.0261,  27.3634},
	{170.58941650391,-1718.6125488281,  27.2916},
	{-74.5693,  6427.8715,  29.4400},
	{-700.07843017578,-932.45861816406,  17.0139}
}

local fontsLoaded = false
local fontId
Citizen.CreateThread(function()
  Citizen.Wait(1000)
  RegisterFontFile('wmk')
  fontId = RegisterFontId('Freedom Font')
  fontsLoaded = true
end)

Citizen.CreateThread(function ()
	local ticks = 1000
	for i = 1, #vehicleWashStation do
		garageCoords = vehicleWashStation[i]
		stationBlip = AddBlipForCoord(garageCoords[1], garageCoords[2], garageCoords[3])
		ticks = 1
		SetBlipSprite(stationBlip, 100) -- 100 = carwash
		SetBlipAsShortRange(stationBlip, true)

		Wait(ticks)
		ticks = 1000
	end
    return
end)

Citizen.CreateThread(function ()
	local ticks = 1000
	while true do
		if IsPedSittingInAnyVehicle(PlayerPedId()) then 
			for i = 1, #vehicleWashStation do
				garageCoords2 = vehicleWashStation[i]
				ticks = 1
				DrawMarker(1, garageCoords2[1], garageCoords2[2], garageCoords2[3], 0, 0, 0, 0, 0, 0, 5.0, 5.0, 1.5, 0, 134, 255, 255, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), garageCoords2[1], garageCoords2[2], garageCoords2[3], true ) < 5 then
					carwashdraw(0.51, 0.85, 0,0, 0.55, "~w~Apasa ~b~E ~w~pentru a curata ~b~masina", 255, 255, 255, 230, 1, 2, 1)
					if(IsControlJustPressed(1, Key)) then
						DoScreenFadeOut(500)
						SetTimeout(500, function()
						TriggerServerEvent('carwash:checkmoney', GetVehicleDirtLevel(GetVehiclePedIsIn(PlayerPedId(),false)))	
						SetTimeout(1000, function()
                        DoScreenFadeIn(100)
							end)
						end)
					end
				end
			end
		end
		Wait(ticks)
		ticks = 1000
	end
end)

RegisterNetEvent('carwash:success')
AddEventHandler('carwash:success', function()
	SetVehicleDirtLevel(GetVehiclePedIsIn(PlayerPedId(),false), 0.0)
	SetVehicleUndriveable(GetVehiclePedIsIn(PlayerPedId(),false), false)
	tvRP.notify("Succes: ~w~Ai curatat masina cu succes! ~g~(30.000 lei)~w~")
end)

RegisterNetEvent('carwash:notenough')
AddEventHandler('carwash:notenough', function()
	tvRP.notify("Eroare: ~w~Nu ai destui bani la tine!")
end)

RegisterNetEvent('carwash:alreadyclean')
AddEventHandler('carwash:alreadyclean', function()
	tvRP.notify("Eroare: ~w~Masina este deja spalata.")
end)

function carwashdraw(x,y ,width,height,scale, text, r,g,b,a, outline, font, center)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextCentre(center)
	if(outline)then
	  SetTextOutline()
	end
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width/1, y - height/1 + 0.002)
  end