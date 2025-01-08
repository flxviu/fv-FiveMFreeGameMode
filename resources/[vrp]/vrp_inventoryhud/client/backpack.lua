local rucsac_list = {
	[1] = {159,3},
	[2] = {117,0},
	[3] = {133,2},
	[4] = {36,0}
}
RegisterNetEvent("pune:rucsac")
AddEventHandler("pune:rucsac",function(rucsac)
	if rucsac_list[rucsac] then
		SetPedComponentVariation(PlayerPedId(), 5, rucsac_list[rucsac][1],rucsac_list[rucsac][2],0)
	end
end)

RegisterNetEvent("sterge:rucsac")
AddEventHandler("sterge:rucsac",function(rucsac)
	SetPedComponentVariation(PlayerPedId(), 5, 1, 1, 1)
end)
