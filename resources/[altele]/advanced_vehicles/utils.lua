RegisterNetEvent('advanced_vehicles:Notify')
AddEventHandler('advanced_vehicles:Notify', function(type,msg)
    prefix = ""
	if type == "negado" then
		prefix = "~r~"
    elseif type == "importante" then
		prefix = "~y~"
    elseif type == "sucesso" then
        prefix = "~g~"
    end
	SetNotificationTextEntry("STRING")
	AddTextComponentString(prefix..msg)
	DrawNotification(false, false)
end)