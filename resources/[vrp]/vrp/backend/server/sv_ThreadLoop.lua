 local players = {}
 local activeBlips = {}
 CreateThread(function()    
     while true do
         local users = vRP.getUsers({})
         for uid,source in pairs(users) do
             local user_id = uid or "unknown"
             local plyPed = GetPlayerPed(source)
             local plyCoords = GetEntityCoords(plyPed)
             local plyName = GetPlayerName(source) or "unknown"
             local faction = vRP.getUserFaction(user_id) or "user"
             local factionRank = vRP.getFactionRank(user_id) or "none"
             if factionRank == "none" then
                 factionRank = "Nu are factiune"
             end
             if faction == "user" then
                 faction = "Somer"
             end
 			local _GPLAYERS = GetNumPlayerIndices()
 			TriggerLatentClientEvent("Lucid:DiscordShow",source,1024,plyName,user_id,faction,_GPLAYERS)
         end
         Wait(20000)
     end
 end)

tvRP.isPlayerSponsor = function()
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.isUserSponsor(user_id) then
            return true
        end
        return false
    end
end