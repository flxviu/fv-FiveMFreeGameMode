local fontsLoaded = false
local fontId
Citizen.CreateThread(function()
  Citizen.Wait(1000)
  RegisterFontFile('wmk')
  fontId = RegisterFontId('Freedom Font')
  fontsLoaded = true
end)

Citizen.CreateThread(function()
	local ped = GetPlayerPed(-1)
	local predaArmele = {441.50979614258,-987.15399169922,30.689319610596}

	while true do
		Citizen.Wait(1500)
		ped = GetPlayerPed(-1)
		if not IsPedSittingInAnyVehicle(ped) then 
			local dst = GetDistanceBetweenCoords(GetEntityCoords(ped), predaArmele[1], predaArmele[2], predaArmele[3], false)
			while dst <= 10 do

				DrawText3D(predaArmele[1], predaArmele[2], predaArmele[3]+0.4, "Preda Armele", 1.0, 2, {255, 255, 255})
				DrawMarker(20, predaArmele[1], predaArmele[2], predaArmele[3], 0, 0, 0, 0, 0, 0, 0.501, 0.501, 0.5001, 222, 31, 53, 200, 0, 0, 0, 1)

				if dst <= 1 then
					carwashdraw(0.5, 0.90, 0, 0, 0.6, "Apasa ~b~E ~w~pentru a preda ~r~Armele ~w~la sectie", 255, 255, 255, 230, 1, 4, 1)
					if IsControlJustPressed(0, 38) then
						RemoveAllPedWeapons(ped, true)
						tvRP.notify("Succes: Ai predat armele")
						Citizen.Wait(5000)
						break
					end
				end

				Citizen.Wait(1)
				dst = GetDistanceBetweenCoords(GetEntityCoords(ped), predaArmele[1], predaArmele[2], predaArmele[3], false)
			end
		end
	end

end)