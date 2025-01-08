vRPCtaxi = {}
Tunnel.bindInterface("vrp_taxi",vRPCtaxi)
Proxy.addInterface("vrp_taxi",vRPCtaxi)
vRP = Proxy.getInterface("vRP")

local taxiVehicles = {`taxi`}
local onDuty = false
local fareAmount = nil
local inTaxi = false

local paidAmount = nil
local driverName = nil

local clientName = nil
local earnings = nil
local pasagerPlyPed = nil

local fontId = RegisterFontId('Freedom Font')
RegisterFontFile('wmk')

function vRPCtaxi.isInTaxiVeh()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh then
        for i = 1 , #taxiVehicles do
            if taxiVehicles[i] == GetEntityModel(veh) then
                return VehToNet(veh)
            end
        end
    end
    return false
end

function drawText(x,y,scale, text, r,g,b,a, outline, font, centre, right,up)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
	SetTextCentre(centre)
    if(outline)then
	    SetTextOutline()
	end
	if(right)then
		SetTextRightJustify(true)
		SetTextWrap(0,x)
	end
    if (up) then
        text = text:upper()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y + 0.005)
end


function vRPCtaxi.updateNameAndEarnings(cName,paidAmount)
    clientName = tostring(cName)
    earnings = vRP.formatMoney({paidAmount})
end

function vRPCtaxi.updateNameAndPaid(dName,pAmount)
    driverName = tostring(dName)
    paidAmount = vRP.formatMoney({pAmount})
end


function vRPCtaxi.showOnScreenHud(dn,paid,fare,vehicleId,driverId)
    inTaxi = true
    vehicleId = NetToVeh(vehicleId)
    fareAmount = 50
    driverName = dn
    paidAmount = paid
    while (inTaxi and GetVehiclePedIsIn(PlayerPedId(),false) == vehicleId) do
        if driverName ~= nil then
            drawText(0.94,0.435,0.35, "~y~TAXI ~w~- ~g~ON", 255,255,255,255, false, fontId, 1)
            drawText(0.94,0.47,0.35, "~r~"..driverName, 255,255,255,255, false, fontId, 1)
            if paidAmount then
                drawText(0.94,0.49,0.25, "~g~$~w~"..paidAmount, 255,255,255,255, false, fontId, 1)
            end
        end
        Wait(1)
    end
    fareAmount = 50
    paidAmount = nil
    driverName = nil
    inTaxi = false
    TriggerServerEvent('taxi:passagerLeft',driverId)
end

function vRPCtaxi.startClock()
    CreateThread(function()
        while clientName ~= nil do
            TriggerServerEvent('taxi:checkPosition')
            Wait(2500)
        end
    end)
end

function vRPCtaxi.passagerLeft()
    pasagerPlyPed = nil
    clientName = nil
    earnings = nil
end

function vRPCtaxi.onTaxiDuty(vehicleId,amount)
    onDuty = true
    fareAmount = vRP.formatMoney({45000})
    vehicleId = NetToVeh(vehicleId)
    while (onDuty and GetVehiclePedIsIn(PlayerPedId(),false) == vehicleId) do
        if clientName ~= nil then
            drawText(0.94,0.435,0.35, "~y~TAXI ~w~- ~g~ON", 255,255,255,255, false, fontId, 1)
            drawText(0.94,0.47,0.35, "~b~"..clientName, 255,255,255,255, false, fontId, 1)
            if earnings then
                drawText(0.94,0.49,0.25, "~g~$~w~"..earnings, 255,255,255,255, false, fontId, 1)
            end
        end
        if clientName == nil then
            drawText(0.94,0.435,0.35, "~y~TAXI ~w~- ~r~OFF", 255,255,255,255, false, fontId, 1)
                drawText(0.94,0.46,0.30, "Waiting...", 255,255,255,255, false, fontId, 1)
            while GetVehicleEngineHealth(GetVehiclePedIsIn(PlayerPedId(),false)) <= 300.0 do
                drawText(0.5,0.8,0.35, "~y~Taxi\n~r~Nu ai cum sa primesti comenzi acum!\n~w~Taxi-ul tau este stricat!", 255,0,0,255, false, fontId, 1,false,false)
                Wait(1)
            end
        end
        if pasagerPlyPed == nil then
            for i = 0 , GetVehicleModelNumberOfSeats(GetEntityModel(vehicleId)) do
                if (IsVehicleSeatFree(vehicleId,i) == false) then
                    local thePasager = GetPedInVehicleSeat(vehicleId,i)
                    if thePasager ~= 0 then
                        local serverId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(thePasager))
                        TriggerServerEvent('taxi:setFirstPasager',serverId)
                        pasagerPlyPed = thePasager
                        break
                    end
                end
            end
        end
        Wait(1)
    end
    pasagerPlyPed = nil
    clientName = nil
    fareAmount = 1500
    earnings = nil
    onDuty = false
    TriggerServerEvent('taxi:setState',false)
end