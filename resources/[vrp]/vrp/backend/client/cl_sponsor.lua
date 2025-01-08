CreateThread(function()
    while true do
        _GPED = PlayerPedId()
        _PLAYERCOORDS = GetEntityCoords(_GPED) 
        Wait(600)
    end
end)

local lastVehicle

function tvRP.spawnSponsorCar()
	local model = GetHashKey("manscent")
	local ped = _GPED
	
	if not lastVehicle and _GVEHICLE then
		lastVehicle = _GVEHICLE
	end
	
	x, y, z = table.unpack(_PLAYERCOORDS)
	
	local i = 0
	while not HasModelLoaded(model) and i < 1000 do
		RequestModel(model)
		Wait(1000)
		i = i+1
	end
	if HasModelLoaded(model) then
		local veh = CreateVehicle( model, x, y, z + 1, heading, true, true )
		
		SetPedIntoVehicle(ped, veh, -1)
	
		if (lastVehicle) then
			SetEntityAsMissionEntity(lastVehicle, true, true)
			DeleteVehicle(lastVehicle)
		end
		
		lastVehicle = veh

		SetModelAsNoLongerNeeded( veh )
	end
end


local sponsorThread = false
RegisterNetEvent("sponsor:togglethread", function()
	sponsorThread = not sponsorThread;
	if sponsorThread then
		CreateThread(function()
			while sponsorThread do
				while _GVEHICLE ~= 0 do
					if GetPedInVehicleSeat(_GVEHICLE, 0) == _GPED then
						if GetIsTaskActive(_GPED, 165) then
							vRPserver.denySponsorCarDriving({});
							break;
						end;
					end;
					Wait(500);
				end;
				Wait(2000);
			end;
		end)
	end
end)

function tvRP.denySponsorCarDriving()
	SetPedIntoVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), 0)
end



function GetPedVehicleSeat(ped)
    local vehicle = GetVehiclePedIsIn(ped, false)
    for i=-2,GetVehicleMaxNumberOfPassengers(vehicle) do
        if(GetPedInVehicleSeat(vehicle, i) == ped) then return i end
    end
    return -2
end
