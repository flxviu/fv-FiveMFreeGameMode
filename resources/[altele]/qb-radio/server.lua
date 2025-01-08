local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRPCase")

radio.RegisterServerCallback('qb-radio:server:GetItem', function(source, cb, item)
    local _src = source
    local user_id = vRP.getUserId({_src})
    local player = vRP.getUserSource({user_id}) 
    if user_id ~= nil then
        vRPclient.isInComa({player,{}, function(in_coma)
            local RadioItem = vRP.getInventoryItemAmount({user_id,"radio"}) > 0
            if RadioItem ~= nil and not in_coma then
                cb(true)
            else
                cb(false)
            end
        end})
    else
        cb(false)
    end
end)

vRP.defInventoryItem({"radio","Radio","Statie Radio",function(args)
	local choices = {}
  
	choices["Foloseste"] = {function(player,choice)
        local user_id = vRP.getUserId({player})
        local _source = vRP.getUserSource({user_id})
	  if user_id ~= nil then
			TriggerClientEvent('qb-radio:use', _source)
		  vRP.closeMenu({player})
	  end
	end}
  
	return choices
end,0.1})


-- for channel, config in pairs(Config.RestrictedChannels) do
--     exports['pma-voice']:addChannelCheck(channel, function(source)
--         local _src = source
--         local user_id = vRP.getUserId({_src})
--         local player = vRP.getUserSource({user_id}) 

--         return config[Player.PlayerData.job.name] and Player.PlayerData.job.onduty
--     end)
-- end
