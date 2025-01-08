local Proxy,Tunnel = module("vrp","lib/Proxy"),module('vrp', 'lib/Tunnel')
local vRP,vRPclient = Proxy.getInterface("vRP"),Tunnel.getInterface("vRP", "vrp_barbut");

vRP.defInventoryItem({"zaruri", "Zaruri de aur", "Zaruri de categoria grea!",function()
	local choices = {};
	choices["Use"] = {function(player,choice)
		local user_id = vRP.getUserId{player};
		if not user_id then return end;
		vRPclient.getNearestPlayer(player, {5},function(nplayer)
			-- magie
			if not nplayer then return vRPclient.notify(player, {"Nici o persoana prin jurul tau!"}) end;
			local nuser_id = vRP.getUserId{nplayer};
			if not nuser_id then return end;
			vRP.prompt({player, 'Cat vrei sa joci?', '', function(player, suma)
				if not suma then return end;
				suma = parseInt(suma);
				if suma ~= 0 and suma > 0 then
					-- local money = vRP.getMoney({user_id});
					if vRP.tryPayment{user_id, suma} then
						vRP.prompt({nplayer, 'Doresti sa joci barbut pe suma de $'..suma..'?', 'Scrie 1 pentru a accepta cererea', function(_, ok)
							raspuns = parseInt(ok)
							if raspuns ~= 1 then return vRPclient.notify(player, {"Jucator-ul a refuzat cererea!"}),vRP.giveMoney{user_id, suma} end;
							if not vRP.tryPayment{nuser_id, suma} then return vRPclient.notify(player, {"Jucatorul nu are destui bani pentru a juca barbut!"}),vRPclient.notify(nplayer, {"Nu ai destui bani pentru a putea juca!"}),vRP.giveMoney{user_id, suma} end
							
							local dices = {}
							dices[user_id], dices[nuser_id] = {}, {};
						
							math.randomseed((GetGameTimer() * (user_id + player)))
							for i = 1, 2 do
								dices[user_id][i] = {dicenum = math.random(6)}
								Wait(100)
							end
						
							math.randomseed((GetGameTimer() * (nuser_id * player + nplayer)))
							for i = 1, 2 do
								dices[nuser_id][i] = {dicenum = math.random(6)}
								Wait(100)
							end
						
							local playerGame = table.clone(dices[user_id])
							local nplayerGame = table.clone(dices[nuser_id])
						
							dices[user_id][2] = nplayerGame[1]
							dices[nuser_id][1] = playerGame[2]
						
							dices[user_id][1] = nplayerGame[2]
							dices[nuser_id][2] = playerGame[1]
							


							CreateThread(function()
								TriggerClientEvent('bb-dices:ToggleDiceAnim', player);
								TriggerClientEvent('bb-dices:ToggleDiceAnim', nplayer);
								Citizen.Wait(2000);
								TriggerClientEvent('bb-dices:ToggleDisplay', -1, player, dices[user_id], "dices");
								TriggerClientEvent('bb-dices:ToggleDisplay', -1, nplayer, dices[nuser_id], "dices");

								local totalP = dices[user_id][1].dicenum + dices[user_id][2].dicenum;
								local totalN = dices[nuser_id][1].dicenum + dices[nuser_id][2].dicenum;

								-- print(totalP , totalN);
								if totalP == totalN then
									vRP.giveMoney{user_id, suma};
									vRP.giveMoney{nuser_id, suma};
									vRPclient.notify(player, {"A fost egal!"});
									vRPclient.notify(nplayer, {"A fost egal!"});
								elseif totalP > totalN then
									
									-- print(totalP > totalN)
									vRP.giveMoney{user_id, (suma*2)};
									vRPclient.notify(player, {"Ai castigat $"..vRP.formatMoney({suma})});
									vRPclient.notify(nplayer, {"Ai pierdut!"});
								elseif totalP == 2 and totalN ~= 2 then

									vRP.giveMoney{user_id, (suma*2)};
									vRPclient.notify(player, {"Ai castigat $"..vRP.formatMoney({suma})});
									vRPclient.notify(nplayer, {"Ai pierdut!"});
								elseif totalN == 2 and totalP ~= 2 then

									vRP.giveMoney{nuser_id, (suma*2)};
									vRPclient.notify(nplayer, {"Ai castigat $"..vRP.formatMoney({suma})});
									vRPclient.notify(player, {"Ai pierdut!"});
								elseif totalN > totalP then

									vRP.giveMoney{nuser_id, (suma*2)};
									vRPclient.notify(nplayer, {"Ai castigat $"..vRP.formatMoney({suma})});
									vRPclient.notify(player, {"Ai pierdut!"});
								end
							end)
						end}) 
					end
				end
			end})
		end)
	end}
	return choices
end,0.1,"pocket"})