RegisterNetEvent('alpha:verificaPerms', function(player)
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    
    if vRP.isUserInFaction(user_id,"Politie") then
        TriggerClientEvent('alpha:gunshop', player)
    else
        vRPclient.notify(player,{"Eroare: Nu ai permisiunea de a accesa acest meniu."})
    end 
end)