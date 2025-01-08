
local locatiiradare = {
    ['Showroom'] = vector3(-99.15165, -1139.156, 25.80884),
    ['Sectie'] = vector3(397.8989, -1046.98, 29.44836),
    ['Gunshop Sectie'] = vector3(842.0439, -1003.147, 27.88135),
    ['Fleeca'] = vector3(106.4176, -1000.325, 29.38098),
    ['Primarie'] = vector3(-513.7846, -277.4506, 35.51428)
}

local paid = false
function isInsideRadarzone(ms)
    local coords = GetEntityCoords(_GPED)
    for k,v in pairs(locatiiradare) do 
        if #(coords - v) <= 60.0 then
            if not paid then  
            paid = true
            if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()),-1) == PlayerPedId() then 
                TriggerServerEvent('alpha_radar:pay',ms)
                Citizen.SetTimeout(1000*60, function() paid = false; end)
                end
            end
        end
    end 
end

Citizen.CreateThread(function()
    while true do 
    Citizen.Wait(1300)
    while IsPedInAnyVehicle(_GPED,false) do 
        Citizen.Wait(800)
        local veh = GetVehiclePedIsIn(_GPED)
        local ms = GetEntitySpeed(veh) * 3.1
            if ms > 200 then 
                isInsideRadarzone(ms)
            end
         end
    end
end)