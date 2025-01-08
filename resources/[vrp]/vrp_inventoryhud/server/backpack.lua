

-- RegisterServerEvent("backpack:openMenu")
-- AddEventHandler("backpack:openMenu",function(player)
-- 	local user_id = vRP.getUserId({player})
-- 	if vRP.getRucsac{user_id} ~= 0 then
-- 		if vRP.setRucsac({user_id,0}) then
-- 			TriggerClientEvent('sterge:rucsac',player,1)
-- 		else
-- 			vRPclient.notify(player,{"Goliți mai întâi rucsacul."})
-- 		end
-- 	else
-- 		TriggerClientEvent('pune:rucsac',player,1)
-- 		vRP.setRucsac({user_id,15})
-- 	end
-- end)

-- RegisterServerEvent("backpack:openMenu2")
-- AddEventHandler("backpack:openMenu2",function(player)
-- 	local user_id = vRP.getUserId({player})
-- 	if vRP.getRucsac{user_id} ~= 0 then
-- 		if vRP.setRucsac({user_id,0}) then
-- 			TriggerClientEvent('sterge:rucsac',player,2)
-- 		else
-- 			vRPclient.notify(player,{"Goliți mai întâi rucsacul."})
-- 		end
-- 	else
-- 		TriggerClientEvent('pune:rucsac',player,2)
-- 		vRP.setRucsac({user_id,25})
-- 	end
-- end)

-- RegisterServerEvent("backpack:openMenu3")
-- AddEventHandler("backpack:openMenu3",function(player)
-- 	local user_id = vRP.getUserId({player})
-- 	if vRP.getRucsac{user_id} ~= 0 then
-- 		if vRP.setRucsac({user_id,0}) then
-- 			TriggerClientEvent('sterge:rucsac',player,3)
-- 		else
-- 			vRPclient.notify(player,{"Goliți mai întâi rucsacul."})
-- 		end
-- 	else
-- 		TriggerClientEvent('pune:rucsac',player,3)
-- 		vRP.setRucsac({user_id,45})
-- 	end
-- end)

Citizen.CreateThread(function()
    for k,v in pairs(itemerucsac) do
      vRP.defInventoryItem({k,v.name,v.desc,v.choices,v.weight})
    end
  end)

  itemerucsac= {
    ["rucsac"] = {
      name = "Rucsac Mic",
      desc = "",
      choices = function(args)
      local menu = {}
        menu["Foloseste"] = {function(player,choice)
          local user_id = vRP.getUserId({player})
          if user_id ~= nil then
			if vRP.getRucsac({user_id}) ~= 0 then
				if vRP.setRucsac({user_id,0}) then
					TriggerClientEvent('sterge:rucsac',player,1)
				else
					vRPclient.notify(player,{"Goliți mai întâi rucsacul."})
				end
			else
				TriggerClientEvent('pune:rucsac',player,1)
				vRP.setRucsac({user_id,15})
			end
          end
        end}
      return menu
      end,
    weight =0.50
    },
    ["rucsac2"] = {
        name = "Rucsac Mediu",
        desc = "",
        choices = function(args)
        local menu = {}
          menu["Foloseste"] = {function(player,choice)
            local user_id = vRP.getUserId({player})
            if user_id ~= nil then
				if vRP.getRucsac({user_id}) ~= 0 then
					if vRP.setRucsac({user_id,0}) then
						TriggerClientEvent('sterge:rucsac',player,2)
					else
						vRPclient.notify(player,{"Goliți mai întâi rucsacul."})
					end
				else
					TriggerClientEvent('pune:rucsac',player,2)
					vRP.setRucsac({user_id,25})
				end
            end
          end}
        return menu
        end,
      weight =1.00
      },
	  ["rucsac3"] = {
        name = "Rucsac Mare",
        desc = "",
        choices = function(args)
        local menu = {}
          menu["Foloseste"] = {function(player,choice)
            local user_id = vRP.getUserId({player})
            if user_id ~= nil then
				if vRP.getRucsac({user_id}) ~= 0 then
					if vRP.setRucsac({user_id,0}) then
						TriggerClientEvent('sterge:rucsac',player,3)
					else
						vRPclient.notify(player,{"Goliți mai întâi rucsacul."})
					end
				else
					TriggerClientEvent('pune:rucsac',player,3)
					vRP.setRucsac({user_id,45})
				end
            end
          end}
        return menu
        end,
      weight =2.00
      },
      ["valiza"] = {
        name = "Valiza",
        desc = "",
        choices = function(args)
        local menu = {}
          menu["Foloseste"] = {function(player,choice)
            local user_id = vRP.getUserId({player})
            if user_id ~= nil then
				if vRP.getRucsac({user_id}) ~= 0 then
					if vRP.setRucsac({user_id,0}) then
						TriggerClientEvent('sterge:rucsac',player,3)
					else
						vRPclient.notify(player,{"Goliți mai întâi rucsacul."})
					end
				else
					TriggerClientEvent('pune:rucsac',player,4)
					vRP.setRucsac({user_id,50})
				end
            end
          end}
        return menu
        end,
      weight =2.00
      },
  }