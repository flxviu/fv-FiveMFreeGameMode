pingLimit = 2000
RegisterServerEvent("checkMyPingBro")
AddEventHandler("checkMyPingBro", function()
	ping = GetPlayerPing(source)
	if ping >= pingLimit then
		DropPlayer(source, "Conexiunea internetului tau este prea slaba! Te rugam sa te reconectezi.")
	end
end)