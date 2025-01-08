RegisterServerEvent('check_vw')
AddEventHandler('check_vw', function()
	source = source
	TriggerClientEvent("get_vw",source,GetPlayerRoutingBucket(source))
end)