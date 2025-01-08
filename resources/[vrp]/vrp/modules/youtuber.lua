vRP.registerMenuBuilder("main", function(add, data)
	local user_id = vRP.getUserId(data.player)
	if user_id ~= nil then
		local choices = {}
	
		if(vRP.hasGroup(user_id, "youtuber"))then
			choices["Meniu YouTuber"] = {function(player,choice)
				vRP.buildMenu("ytmenu", {player = player}, function(menu)
					menu.name = "Meniu YouTuber"
					menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
					menu.onclose = function(player) vRP.closeMenu(player) end
					menu["Revive"] = {function(player, choice)
						vRPclient.isInComa(player,{}, function(in_coma)
							if in_coma then
								vRPclient.varyHealth(player,{100}) 
								SetTimeout(1000, function()
									vRPclient.varyHealth(player,{100})
								end)
								vRPclient.notify(player,{"Succes: ~w~Ti-ai dat revive."})
								TriggerClientEvent("chatMessage",-1,"^1"..GetPlayerName(player).." ^0a folosit revive din meniul de ^1Youtuber.")
							else
								vRPclient.notify(player,{"Eroare: ~w~Nu esti mort."})
							end
						end)
					end, "Da-ti revive"}
					
					menu["Fix Masina"] = {function(player, choice)
						vRPclient.fixeNearestVehicle(player,{7})
						vRPclient.notify(player, {"Succes: ~w~Ai reparat vehiculul."})
						TriggerClientEvent("chatMessage",-1,"^1"..GetPlayerName(player).." ^0a folosit fix din meniul de ^1Youtuber.")
					end, "Repara vehiculul in care te afli"}
					
					menu["Kit Arme"] = {function(player, choice)
						vRPclient.giveWeapons(player,{{
							["WEAPON_SWITCHBLADE"] = {ammo=1},
							["WEAPON_COMBATMG"] = {ammo=200},
						}})
						vRPclient.notify(player, {"Succes: ~w~Ti-ai dat un kit de arme."})
						TriggerClientEvent("chatMessage",-1,"^1"..GetPlayerName(player).." ^0a folosit kit arme din meniul de ^1Youtuber.")
					end, "Da-ti un kit de arme"}
					vRP.openMenu(player,menu)
				end)
			end}
		end
		add(choices)
	end
end)