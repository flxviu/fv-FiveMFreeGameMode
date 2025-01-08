local frozen = true
local unfrozen = false

RegisterNetEvent('vRPlf:Unfreeze')
AddEventHandler('vRPlf:Unfreeze', function()
	unfrozen = true
end)

Citizen.CreateThread(function()
	while true do
		if frozen then
			if unfrozen then
				SetEntityInvincible(PlayerPedId(),false)
				SetEntityVisible(PlayerPedId(),true)
				FreezeEntityPosition(PlayerPedId(),false)
				frozen = false
			else
				SetEntityInvincible(PlayerPedId(),true)
				SetEntityVisible(PlayerPedId(),false)
				FreezeEntityPosition(PlayerPedId(),true)
			end
		end
		Citizen.Wait(0)
	end
end)
