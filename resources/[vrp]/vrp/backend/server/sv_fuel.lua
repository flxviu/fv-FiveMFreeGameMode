local Vehicles = {
	{ plate = 'Test Car', fuel = 100}
}

RegisterServerEvent("buyCan")
AddEventHandler("buyCan", function()

	local toPay = 200
	local user_id = vRP.getUserId(source)
		TriggerClientEvent("buyCan", source)
end)


RegisterCommand('fuel', function(source, args, msg)
	local user_id = vRP.getUserId(source)
	if vRP.isUserModerator(user_id) then
		local fuel = msg:sub(6)
		if fuel:len() >= 1 then
			fuel = tonumber(fuel)
			TriggerClientEvent('cmdSetFuel', source, math.floor(tonumber(fuel)))
		else
			TriggerClientEvent('chatMessage', source, "^1Legend: ^0/fuel <procent>!")
		end
	else
		TriggerClientEvent('chatMessage', source, "^1Lucid ^0Nu ai acces la aceasta comanda!")
	end
end)

RegisterServerEvent('LegacyFuel:UpdateServerFuelTable')
AddEventHandler('LegacyFuel:UpdateServerFuelTable', function(plate, fuel)
	local found = false

	for i = 1, #Vehicles do
		if Vehicles[i].plate == plate then
			found = true

			if fuel ~= Vehicles[i].fuel then
				table.remove(Vehicles, i)
				table.insert(Vehicles, {plate = plate, fuel = fuel})
			end
			break
		end
	end

	if not found then
		table.insert(Vehicles, {plate = plate, fuel = fuel})
	end
end)

RegisterServerEvent('LegacyFuel:CheckServerFuelTable')
AddEventHandler('LegacyFuel:CheckServerFuelTable', function(plate)
	for i = 1, #Vehicles do
		if Vehicles[i].plate == plate then
			local vehInfo = {plate = Vehicles[i].plate, fuel = Vehicles[i].fuel}

			TriggerClientEvent('LegacyFuel:ReturnFuelFromServerTable', source, vehInfo)

			break
		end
	end
end)

RegisterServerEvent('LegacyFuel:CheckCashOnHand')
AddEventHandler('LegacyFuel:CheckCashOnHand', function()
	local user_id = vRP.getUserId(source)
	local cb 	  	= vRP.getMoney(user_id)

	TriggerClientEvent('LegacyFuel:RecieveCashOnHand', source, cb)
end)

function round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end
