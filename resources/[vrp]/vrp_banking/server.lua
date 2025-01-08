local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_banking")

vRPbanking = {}
Tunnel.bindInterface("vRP_banking",vRPbanking)
Proxy.addInterface("vRP_banking",vRPbanking)

RegisterServerEvent('TRF:deposit')
AddEventHandler('TRF:deposit', function(amount)
	local thePlayer = source
	
	local user_id = vRP.getUserId({thePlayer})
	local walletMoney = vRP.getMoney({user_id})
	local bankMoney = vRP.getBankMoney({user_id})
	if(tonumber(amount))then
		amount = tonumber(amount)
		if(amount > 0 and 0 <= bankMoney)then
			if(vRP.tryPayment({user_id, amount}))then
				vRP.setBankMoney({user_id, bankMoney+amount})
				vRP.setMoney({user_id, walletMoney-amount})
				vRPclient.notify(thePlayer, {"Succes: ~w~Ai depus ~r~$"..amount.." ~w~in banca!"})
			else
				vRPclient.notify(thePlayer, {"Eroare: ~w~Nu ai destui bani la tine!"})
			end
		else
			vRPclient.notify(thePlayer, {"Eroare: ~w~Numar invalid!"})
		end
	else
		vRPclient.notify(thePlayer, {"Eroare: ~w~Numar invalid!"})
	end
end)

RegisterServerEvent('TRF:withdraw')
AddEventHandler('TRF:withdraw', function(amount)
	local thePlayer = source
	
	local user_id = vRP.getUserId({thePlayer})
	local walletMoney = vRP.getMoney({user_id})
	local bankMoney = vRP.getBankMoney({user_id})
	if(tonumber(amount))then	
		amount = tonumber(amount)
		if(amount > 0 and amount <= bankMoney)then
			vRP.setBankMoney({user_id, bankMoney-amount})
			vRP.setMoney({user_id, walletMoney+amount})
			vRPclient.notify(thePlayer, {"Succes: ~w~Ai retras ~r~$"..amount.." ~w~din banca!"})
		else
			vRPclient.notify(thePlayer, {"Eroare: ~w~Nu ai destui bani in banca!"})
		end
	else
		vRPclient.notify(thePlayer, {"Eroare: ~w~Numar invalid!"})
	end
end)

RegisterServerEvent('TRF:balance')
AddEventHandler('TRF:balance', function()
	local thePlayer = source
	
	local user_id = vRP.getUserId({thePlayer})
	local bankMoney = vRP.getBankMoney({user_id})
	TriggerClientEvent('TRFcurrentbalance1', thePlayer, bankMoney)
end)

RegisterServerEvent('TRF:transfer')
AddEventHandler('TRF:transfer', function(to, amount)
	local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	if(tonumber(to)  and to ~= "" and to ~= nil)then
		to = tonumber(to)
		theTarget = vRP.getUserSource({to})
		if(theTarget)then
			if(thePlayer == theTarget)then
				vRPclient.notify(thePlayer, {"Eroare: ~w~Nu iti poti transfera bani tie!"})
			else
				if(tonumber(amount) and tonumber(amount) > 0 and amount ~= "" and amount ~= nil)then
					amount = tonumber(amount)
					bankMoney = vRP.getBankMoney({user_id})
					if(bankMoney >= amount)then
						newBankMoney = tonumber(bankMoney - amount)
						vRP.setBankMoney({user_id, newBankMoney})
						vRP.giveBankMoney({to, amount})
						vRPclient.notify(thePlayer, {"Succes: ~w~Ai transferat ~r~$"..amount.." ~w~lui ~r~"..vRP.getPlayerName({theTarget})})
						vRPclient.notify(theTarget, {"Succes: ~w~"..vRP.getPlayerName({thePlayer}).." ti-a transferat ~r~$"..amount})
					else
						vRPclient.notify(thePlayer, {"Eroare: ~w~Nu ai destui bani in banca!"})
					end
				else
					vRPclient.notify(thePlayer, {"Eroare: ~w~Numar invalid!"})
				end
			end
		else
			vRPclient.notify(thePlayer, {"Eroare: ~w~Jucatorul nu a fost gasit"})
		end
	end
end)
