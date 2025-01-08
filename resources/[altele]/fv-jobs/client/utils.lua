local JobBlips = {}

Citizen.CreateThread(function()
    Wait(500)
    for k, v in pairs(Config.jobsBlips) do
        Wait(100)
        
        local blip = AddBlipForCoord(v[1], v[2], v[3])
        SetBlipSprite(blip, v[4])
        SetBlipColour(blip, v[5])
        SetBlipScale(blip,v[6])
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(k)
        EndTextCommandSetBlipName(blip)

        JobBlips[#JobBlips+1] = blip
    end
end)

function ShowScreenText(f)
    SetTextFont(6)
    SetTextProportional(0)
    SetTextScale(0.45, 0.450)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(40, 5, 5, 5, 255)
    SetTextEdge(30, 5, 5, 5, 255)
    SetTextDropShadow()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(f)
    DrawText(0.5, 0.95)
end

function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(500)
    end
end

local costume = {
    ['miner'] = { 25,25,25 };
}

RegisterNetEvent('sxint:setCostum', function(costum)
    if not costum then return end;
    

end)

local cineteaintrebat = {
    ['miner'] = {"blahblah"},
    ['gunoier'] = {"blahblah"},
    ['Santierist'] = {"blahblah"},
    ['woodcutter'] = {"blahblah"},
    ['soferistprost'] = {"blahblah"},
    ['electrician'] = {"blahblah"},
    ['pescar'] = {"blahblah"},
    ['gradinar'] = {"blahblah"},
}

RegisterNetEvent('sxint:intrebareLol',function(intrebare)
    if not (intrebare or cineteaintrebat[intrebare][1]) then return end;
    TriggerEvent('notify:Alert', 'info', tostring(cineteaintrebat[intrebare][1]), 5000, 'info');
end)