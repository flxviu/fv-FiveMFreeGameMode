local Proxy = module("lib/Proxy")
local Tunnel = module("lib/Tunnel")
local Lang = module("lib/Lang")
Debug = module("lib/Debug")
local config = module("cfg/base")
Debug.active = config.debug
vRP = {}
Proxy.addInterface("vRP", vRP)
tvRP = {}
Tunnel.bindInterface("vRP", tvRP)

local dict = module("cfg/lang/" .. config.lang) or {}

vRP.lang = Lang.new(dict)
vRPclient = Tunnel.getInterface("vRP", "vRP")
vRPsb = Proxy.getInterface("vrp_scoreboard")
vRPjobs = Proxy.getInterface("vRP_jobs")
vRPin = Proxy.getInterface("vrp_hud_inventory")
vRPbiz = Proxy.getInterface("vRP_biz")

vRP.users = {}
vRP.rusers = {}
vRP.user_tables = {}
vRP.user_tmp_tables = {}
vRP.user_sources = {}
vRP.user_data = {}; -- user_data

hoursPlayed = {}

-- function vRP.getUserIdByIdentifiers(ids, cbr)
--     local task = Task(cbr)
--     if ids ~= nil and #ids then
--         local i = 0
--     local function search()
--         i = i+1
--         if i <= #ids then
--             if(string.match(ids[i], "ip:"))then
--                 search()
--             else
--                 exports.oxmysql:execute("SELECT user_id FROM vrp_user_ids WHERE identifier = @identifier", {['@identifier'] = ids[i]}, function (rows)
--                       if #rows > 0 then
--                           task({rows[1].user_id})
--                       else
--                           search()
--                       end
--                 end)
--             end
--         else
--           exports.oxmysql:execute("INSERT INTO vrp_users(whitelisted,banned,faction,isFactionLeader,isFactionCoLeader,factionRank,username) VALUES(false,false,'user',0,0,'none','Username')",{['@whitelisted'] = 0, ['@banned'] = 0}, function (rows)
--             if rows  then
--                     local user_id = rows["insertId"]
--                     for l,w in pairs(ids) do
--                             exports.oxmysql:execute("INSERT INTO vrp_user_ids(identifier,user_id) VALUES(@identifier,@user_id)", {['@user_id'] = user_id, ['@identifier'] = w})
--                     end
--                     task({user_id})
--                 else
--                     task()
--                 end
--             end)
--           end
--         end
--         search()
--     else
--         task()
--      end
--   end

local time = os.date("%H:%M")
print("Anubis Romania | Made by Flaviu1999 a ^2pornit ^0 | discord.gg/UXMsVhVpPv - Flaviu1999 regele, stiti toti ca eu sunt taticu vostru, va pup nepotii mei ^1[^0"..time.."^1] ^0ROBERTO E O PIZDA GRASA SA MA SUGI DE PULA LACHE MIC.^0")
print("Anubis Romania | Made by Flaviu1999 a ^2pornit ^0 | discord.gg/UXMsVhVpPv - Flaviu1999 regele, stiti toti ca eu sunt taticu vostru, va pup nepotii mei ^1[^0"..time.."^1] ^0ROBERTO E O PIZDA GRASA SA MA SUGI DE PULA LACHE MIC.^0")
print("Anubis Romania | Made by Flaviu1999 a ^2pornit ^0 | discord.gg/UXMsVhVpPv - Flaviu1999 regele, stiti toti ca eu sunt taticu vostru, va pup nepotii mei ^1[^0"..time.."^1] ^0ROBERTO E O PIZDA GRASA SA MA SUGI DE PULA LACHE MIC.^0")
print("Anubis Romania | Made by Flaviu1999 a ^2pornit ^0 | discord.gg/UXMsVhVpPv - Flaviu1999 regele, stiti toti ca eu sunt taticu vostru, va pup nepotii mei ^1[^0"..time.."^1] ^0ROBERTO E O PIZDA GRASA SA MA SUGI DE PULA LACHE MIC.^0")
print("Anubis Romania | Made by Flaviu1999 a ^2pornit ^0 | discord.gg/UXMsVhVpPv - Flaviu1999 regele, stiti toti ca eu sunt taticu vostru, va pup nepotii mei ^1[^0"..time.."^1] ^0ROBERTO E O PIZDA GRASA SA MA SUGI DE PULA LACHE MIC.^0")

function vRP.getUserIdByIdentifiers(ids, cbr)
    local task = Task(cbr)
    
    if ids?[1] then
      local i = 0
  
      local function search()
        i = i + 1
        if i <= #ids then
  
          if not string.find(ids[i], "ip:") then
            exports["oxmysql"]:query("SELECT user_id FROM vrp_user_ids WHERE identifier = @identifier", {['@identifier'] = ids[i]}, function (rows)
              if #rows > 0 then
                task({rows[1].user_id})
              else
                search()
              end
            end)
          else
            search()
          end
        else
          -- no ids found, create user
          exports["oxmysql"]:query("INSERT INTO vrp_users(whitelisted,banned,faction,isFactionLeader,isFactionCoLeader,factionRank,username) VALUES(false,false,'user',0,0,'none','Username')",{['@whitelisted'] = 0, ['@banned'] = 0}, function (rows)
            if rows  then
              local user_id = rows["insertId"]
              for l,w in pairs(ids) do
                if not string.find(w, "ip:") then
                  exports["oxmysql"]:query("INSERT INTO vrp_user_ids(identifier,user_id) VALUES(@identifier,@user_id)", {['@user_id'] = user_id, ['@identifier'] = w})
                end
              end
              task({user_id})
            else
              task()
            end
          end)
        end
      end
      search()
    else
      task()
    end
  end

function vRP.setUserDataTableVar(user_id, var, varData)
    local data = vRP.getUserDataTable(user_id);
    if not data then return end;
    data[var] = varData;
end;

function vRP.ReLoadChar(source)
    local name = GetPlayerName(source)
    local ids = GetPlayerIdentifiers(source)
    vRP.getUserIdByIdentifiers(ids, function(user_id)
        if user_id ~= nil then
            if vRP.rusers[user_id] == nil then
                vRP.users[ids[1]] = user_id
                vRP.rusers[user_id] = ids[1]
                vRP.user_tables[user_id] = {}
                vRP.user_tmp_tables[user_id] = {}
                vRP.user_sources[user_id] = source
                vRP.getUData(user_id, "vRP:datatable", function(sdata)
                    local data = json.decode(sdata)
                    if type(data) == "table" then vRP.user_tables[user_id] = data end
                    local tmpdata = vRP.getUserTmpTable(user_id)
                    vRP.getLastLogin(user_id, function(last_login)
                        tmpdata.last_login = last_login or ""
                        tmpdata.spawns = 0
                        local ep = vRP.getPlayerEndpoint(source)
                        local last_login_stamp = ep .. " " .. os.date("%H:%M:%S %d/%m/%Y")
                        exports.oxmysql:execute("UPDATE vrp_users SET last_login = @last_login WHERE id = @user_id", {['@user_id'] = user_id, ['@last_login'] = last_login_stamp})
                        TriggerEvent("vRP:playerJoin", user_id, source, name, tmpdata.last_login)
                        TriggerClientEvent("VRP:CheckIdRegister", source)
                    end)
                end)
            else
                TriggerEvent("vRP:playerRejoin", user_id, source, name)
                TriggerClientEvent("VRP:CheckIdRegister", source)
                local tmpdata = vRP.getUserTmpTable(user_id)
                tmpdata.spawns = 0
            end
        end
    end)
end
RegisterNetEvent("VRP:CheckID")
AddEventHandler("VRP:CheckID", function()
    local user_id = vRP.getUserId(source)
    if not user_id then
        vRP.ReLoadChar(source)
    end
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200000)
        for _, playerId in ipairs(GetPlayers()) do
            Wait(1000)
            local u_id = vRP.getUserId(playerId)
            if u_id == nil then
                DropPlayer(playerId, "Anubis: Ai intrat fara ID!")
            end
        end
    end
end)
function vRP.getSourceIdKey(source)
    local ids = GetPlayerIdentifiers(source)
    local idk = "idk_"
    for k, v in pairs(ids) do
        idk = idk .. v
    end
    return idk
end
function vRP.getUserIdentifiers(player, type)
    if (type == "*") then
        local steamid = "Invalid-Steam"
        local license = "Invalid-License"
        local discord = "Invalid-User"
        local xbl = "Invalid-Xbox"
        local liveid = "Invalid-Live"
        for k, v in pairs(GetPlayerIdentifiers(player)) do
            if v:match("steam") then
                steamid = v:gsub("steam:", "")
            elseif v:match("license") then
                license = v:gsub("license:", "")
            elseif v:match("xbl") then
                xbl = v:gsub("xbl:", "")
            elseif v:match("ip") then
                ip = v:gsub("ip:", "")
            elseif v:match("discord") then
                discord = v:gsub("discord:", "")
            elseif v:match("live") then
                liveid = v:gsub("live:", "")
            end
        end
        return steamid, license, discord, xbl, liveid
    else
        local which = "Invalid-" .. type
        for k, v in pairs(GetPlayerIdentifiers(player)) do
            if v:match(type) then
                which = v:gsub(type .. ":", "")
            end
        end
        return which
    end
end
function vRP.getPlayerEndpoint(player)
    return GetPlayerEP(player) or "0.0.0.0"
end
function vRP.getPlayerName(player)
    return GetPlayerName(player) or "Unknown"
end
function vRP.formatMoney(amount)
    local left, num, right = string.match(tostring(amount), '^([^%d]*%d)(%d*)(.-)$')
    return left .. (num:reverse():gsub('(%d%d%d)', '%1.'):reverse()) .. right
end
function vRP.getBannedExpiredDate(time)
    local ora = os.date("%H:%M:%S")
    local creation_date = os.date("%d/%m/%Y")
    local dayValue, monthValue, yearValue = string.match(creation_date, '(%d+)/(%d+)/(%d+)')
    dayValue, monthValue, yearValue = tonumber(dayValue), tonumber(monthValue), tonumber(yearValue)
    return "" .. os.date("%d/%m/%Y", os.time{year = yearValue, month = monthValue, day = dayValue} + time * 24 * 60 * 60) .. " : " .. ora .. ""
end
function vRP.isBanned(user_id, cbr)
    local task = Task(cbr, {false})
    exports.oxmysql:execute("SELECT banned FROM vrp_users WHERE id = @user_id", {user_id = user_id}, function(rows)
        if #rows > 0 then
            task({rows[1].banned})
        else
            task()
        end
    end)
end
-- function vRP.setBanned(user_id, banned, reason, by)
--     if (banned == false) then
--         exports.oxmysql:execute("UPDATE vrp_users SET banned = @banned, bannedReason = @reason, bannedBy = @bannedBy WHERE id = @user_id", {user_id = user_id, banned = banned, reason = reason, bannedBy = ""}, function() end)
--     else
--         if (tostring(by) ~= "Consola") then
--             theAdmin = vRP.getUserId(by)
--             adminName = vRP.getPlayerName(by)
--             banBy = adminName .. " [" .. theAdmin .. "]"
--         else
--             banBy = "Consola"
--         end
--         exports.oxmysql:execute("UPDATE vrp_users SET banned = @banned, bannedReason = @reason, bannedBy = @bannedBy WHERE id = @user_id", {user_id = user_id, banned = banned, reason = reason, bannedBy = banBy}, function() end)
--     end
-- end

function vRP.setBanned(user_id,banned,reason,by)
    exports.oxmysql:query("UPDATE vrp_users SET banned = @banned, bannedReason = @reason, bannedBy = @bannedBy WHERE id = @user_id", {user_id = user_id, banned = banned, reason = reason, bannedBy = by}, function()end)
end

function vRP.setBannedTemp(user_id, banned, reason, by, timp)
    if (banned == false) then
        exports.oxmysql:execute("UPDATE vrp_users SET banned = @banned, bannedTemp = 0, bannedReason = @reason, bannedBy = @bannedBy, BanTempZile = 0, BanTempData = @date, BanTempExpire = @expireDate WHERE id = @user_id", {user_id = user_id, banned = banned, reason = "", bannedBy = "", date = "", expireDate = ""}, function() end)
    else
        banTimp = os.time() + timp * 24 * 60 * 60
        data = os.date("%d/%m/%Y : %H:%M:%S")
        expireDate = vRP.getBannedExpiredDate(timp)
        if (tostring(by) ~= "Consola") then
            theAdmin = vRP.getUserId(by)
            adminName = vRP.getPlayerName(by)
            banBy = adminName .. " [" .. theAdmin .. "]"
        else
            banBy = "Consola"
        end
        exports.oxmysql:execute("UPDATE vrp_users SET bannedTemp = @durata, bannedReason = @reason, bannedBy = @bannedBy, BanTempZile = @time, BanTempData = @date, BanTempExpire = @expireDate WHERE id = @user_id", {user_id = user_id, durata = banTimp, reason = reason, bannedBy = banBy, time = timp, date = data, expireDate = expireDate}, function() end)
    end
end
function vRP.isWhitelisted(user_id, cbr)
    local task = Task(cbr, {false})
    exports.oxmysql:execute("SELECT whitelisted FROM vrp_users WHERE id = @user_id", {user_id = user_id}, function(rows)
        if #rows > 0 then
            task({rows[1].whitelisted})
        else
            task()
        end
    end)
end
function vRP.setWhitelisted(user_id, whitelisted)
    exports.oxmysql:execute("UPDATE vrp_users SET whitelisted = @whitelisted WHERE id = @user_id", {user_id = user_id, whitelisted = whitelisted}, function() end)
end
function vRP.getLastLogin(user_id, cbr)
    local task = Task(cbr, {""})
    exports.oxmysql:execute("SELECT last_login FROM vrp_users WHERE id = @user_id", {user_id = user_id}, function(rows)
        if #rows > 0 then
            task({rows[1].last_login})
        else
            task()
        end
    end)
end
function vRP.setUData(user_id, key, value)
    exports.oxmysql:execute("REPLACE INTO vrp_user_data(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)", {user_id = user_id, key = key, value = value}, function() end)
end
function vRP.getUData(user_id, key, cbr)
    local task = Task(cbr, {""})
    exports.oxmysql:execute("SELECT dvalue FROM vrp_user_data WHERE user_id = @user_id AND dkey = @key", {user_id = user_id, key = key}, function(rows)
        if #rows > 0 then
            task({rows[1].dvalue})
        else
            task()
        end
    end)
end
function vRP.setSData(key, value)
    exports.oxmysql:execute("REPLACE INTO vrp_srv_data(dkey,dvalue) VALUES(@key,@value)", {key = key, value = value}, function() end)
end
function vRP.getSData(key, cbr)
    local task = Task(cbr, {""})
    exports.oxmysql:execute("SELECT dvalue FROM vrp_srv_data WHERE dkey = @key", {key = key}, function(rows)
        if #rows > 0 then
            task({rows[1].dvalue})
        else
            task()
        end
    end)
end
function vRP.getUserDataTable(user_id)
    return vRP.user_tables[user_id]
end
function vRP.getUserTmpTable(user_id)
    return vRP.user_tmp_tables[user_id]
end
function vRP.isConnected(user_id)
    return vRP.rusers[user_id] ~= nil
end
function vRP.isFirstSpawn(user_id)
    local tmp = vRP.getUserTmpTable(user_id)
    return tmp and tmp.spawns == 1
end
function vRP.getUserId(source)
    if source ~= nil then
        local ids = GetPlayerIdentifiers(source)
        if ids ~= nil and #ids > 0 then
            return vRP.users[ids[1]]
        end
    end
    return nil
end
function vRP.getUsers()
    local users = {}
    for k, v in pairs(vRP.user_sources) do
        users[k] = v
    end
    return users
end
function vRP.getUserSource(user_id)
    return vRP.user_sources[user_id]
end
function vRP.ban(source, reason, admin)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        if (tostring(admin) ~= "Consola") then
            theAdmin = vRP.getUserId(admin)
            adminName = vRP.getPlayerName(admin)
            banBy = adminName .. " [" .. theAdmin .. "]"
        else
            banBy = "Consola"
        end
        vRP.setBanned(user_id, true, reason, admin)
        motiv = " Ai fost interzis permanent pe server!\nInterzis de catre: " .. banBy .. "\nMotiv: " .. reason .. "\nID-ul tau: [" .. user_id .. "]\nACEST BAN NU EXPIRA NICIODATA!\n\n⚠ Daca crezi ca ai fost interzis pe nedrept, poti face o cerere de unban pe Discord: discord.gg/anubisro"
        vRP.kick(source, motiv)
    end
end
function vRP.banTemp(source, reason, admin, timp)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        data = os.date("%d/%m/%Y : %H:%M:%S")
        expireDate = vRP.getBannedExpiredDate(timp)
        if (tostring(admin) ~= "Consola") then
            theAdmin = vRP.getUserId(admin)
            adminName = vRP.getPlayerName(admin)
            banBy = adminName .. " [" .. theAdmin .. "]"
        else
            banBy = "Consola"
        end
        vRP.setBannedTemp(user_id, true, reason, admin, timp)
        motiv = " Ai fost interzis temporar pe server!\nInterzis de catre: " .. banBy .. "\nMotiv: " .. reason .. "\nTimp: " .. timp .. " zile\nID-ul Tau: [" .. user_id .. "]\nInterzis la data de: " .. data .. "\nExpira la data de: " .. expireDate .. "\n\n⮚ Vei primi unban automat dupa ce a trecut timpul! ⮘\n\n⚠ Daca crezi ca ai fost interzis pe nedrept, poti face o cerere de unban pe Discord: discord.gg/anubisro"
        vRP.kick(source, motiv)
    end
end
function vRP.kick(source, reason)
    DropPlayer(source, reason)
end

-- RegisterCommand('staff', function(source)
-- 	local user_id = vRP.getUserId(source)
-- 	local staff = vRP.getOnlineStaff()
-- 	for k,v in pairs(staff) do 
-- 		local player = vRP.getUserSource(v)
-- 		local name = GetPlayerName(player)
--     name = name or "Necunoscut"
-- 		TriggerClientEvent('chatMessage',source,'[^3Anubis^0] ' .. name .. '^0 - ^1' ..vRP.getUserAdminTitle(v))
-- 	end
-- end)
 
RegisterCommand('politie', function(source)
	local cops = vRP.getOnlineUsersByFaction('Politie')
  local c = 0 
	for _,user_id in pairs(cops) do 
    c = c + 1
		local player = vRP.getUserSource(user_id)
		local name = GetPlayerName(player)
    name = name or "Necunoscut"
		TriggerClientEvent('chatMessage',source,'[^3Anubis^0] ' .. name)
	end

  TriggerClientEvent('chatMessage',source,'[^3Anubis^0] Total politisti online: ^1' .. c )
end)

RegisterCommand('medici', function(source)
    local medici = vRP.getOnlineUsersByFaction('Smurd')
    local m = 0
    for _, user_id in pairs(medici) do
        m = m + 1
        local player = vRP.getUserSource(user_id)
        local name = GetPlayerName(player)
        name = name or "Necunoscut"
        TriggerClientEvent('chatMessage', source, '^3' .. name .. ' ^0(^3' .. vRP.getUserId(player) .. '^0) ^0-> ^1Medic')
    end
    TriggerClientEvent('chatMessage', source, 'Medici ^0Online: ^1' .. m)
end)
function tvRP.isPlayerCop()
    local user_id = vRP.getUserId(source)
    return vRP.isUserInFaction(user_id, "Politie")
end
ChillDown = {}
function tvRP.getUserHours(PlayerId)
    local user_id = vRP.getUserId(PlayerId)
    local ore = vRP.getUserHoursPlayed(user_id)
    return ore
end
function tvRP.isPlayerMedic()
    local user_id = vRP.getUserId(source)
    return vRP.isUserInFaction(user_id, "Smurd")
end
function task_save_datatables()
    TriggerEvent("vRP:save")
    Debug.pbegin("vRP save datatables")
    for k, v in pairs(vRP.user_tables) do
        vRP.setUData(k, "vRP:datatable", json.encode(v))
    end
    Debug.pend()
    SetTimeout(config.save_interval * 1000, task_save_datatables)
end
task_save_datatables()
function vRP.getUserHoursPlayed(user_id)
    if (hoursPlayed[user_id] ~= nil) then
        return math.floor(hoursPlayed[user_id])
    else
        return 0
    end
end
RegisterServerEvent("getOnlinePly")
AddEventHandler("getOnlinePly", function()
    local connectedPlayers = GetPlayers()
    TriggerClientEvent("getGlobalOnlinePly", -1, #connectedPlayers)
end)
function tvRP.updateHoursPlayed(hours)
    user_id = vRP.getUserId(source)
    exports.oxmysql:execute("UPDATE vrp_users SET hoursPlayed = hoursPlayed + @hours WHERE id = @user_id", {hours = hours, user_id = user_id}, function() end)
    hoursPlayed[user_id] = hoursPlayed[user_id] + hours
    vRPsb.updateScoreboardPlayer({user_id, hours})
end
AddEventHandler("playerConnecting", function(name, setMessage, deferrals)
    deferrals.defer()
    local source = source
    Debug.pbegin("playerConnecting")
    local ids = GetPlayerIdentifiers(source)

    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        for z, x in ipairs(config.blacklistedId) do
          if string.find(v, x) then
            deferrals.done('\n\nA component of your computer is preventing you from being able to play FiveM. Please wait out your original ban (expiring in 254 days + 09:48:22) to be able to play FiveM. \nThe associated correlation ID is 1b672dd7-328f-d1fb-857e4a2j35p4')
            print("Un sclav a incercat sa intre. Verifica logurile")
          end
        end
      end 

    if ids ~= nil and #ids > 0 then
        deferrals.update("Te identificam...")
        Wait(3000)
        vRP.getUserIdByIdentifiers(ids, function(user_id)
                if user_id ~= nil then
                    deferrals.update("Verificam daca esti banat pe server...")
                    Wait(3000)
                    vRP.isBanned(user_id, function(banned)
                            exports.oxmysql:execute("SELECT * FROM vrp_users WHERE id = @user_id", {user_id = user_id}, function(rows)
                                bannedBy = rows[1].bannedBy or ""
                                banReason = rows[1].bannedReason or ""
                                BanDate = rows[1].BanTempData or ""
                                BanExpireDate = rows[1].BanTempExpire or ""
                                BanZile = tonumber(rows[1].BanTempZile)
                                if tonumber(rows[1].bannedTemp) < os.time() then
                                    if not banned then
                                        deferrals.update("Verificam daca esti adaugat in lista alba...")
                                        vRP.isWhitelisted(user_id, function(whitelisted)
                                            if not config.whitelist or whitelisted then
                                                Debug.pbegin("playerConnecting_delayed")
                                                if vRP.rusers[user_id] == nil then
                                                    vRP.users[ids[1]] = user_id
                                                    vRP.rusers[user_id] = ids[1]
                                                    vRP.user_tables[user_id] = {}
                                                    vRP.user_tmp_tables[user_id] = {}
                                                    vRP.user_sources[user_id] = source
                                                    deferrals.update("Preluam datele tale din baza de date...")
                                                    vRP.getUData(user_id, "vRP:datatable", function(sdata)
                                                        local data = json.decode(sdata)
                                                        if type(data) == "table" then vRP.user_tables[user_id] = data end
                                                        local tmpdata = vRP.getUserTmpTable(user_id)
                                                        deferrals.update("Verificam ultima ta conectare...")
                                                        vRP.getLastLogin(user_id, function(last_login)
                                                            tmpdata.last_login = last_login or ""
                                                            tmpdata.spawns = 0
                                                            local ep = vRP.getPlayerEndpoint(source)
                                                            local last_login_stamp = ep .. " " .. os.date("%H:%M:%S %d/%m/%Y")
                                                            exports.oxmysql:execute("UPDATE vrp_users SET last_login = @last_login WHERE id = @user_id", {user_id = user_id, last_login = last_login_stamp}, function() end)
                                                            local discordIdentifier = vRP.getUserIdentifiers(source, "discord")
                                                            local time = os.date("%d/%m/%Y - %X")
                                                            print("^0Jucatorul ^2" .. name .. " (^0" .. user_id .. "^2) ^0a intrat pe server. ^2[^0"..time.."^2]^0")
                                                            local name = vRP.getPlayerName(source)
                                                            local time = os.date("%d/%m/%Y - %X")
                                                            local embed = {
                                                                {
                                                                    ["color"] = "56921",
                                                                    ["type"] = "rich",
                                                                    ["title"] = "Anubis Connect",
                                                                    ["description"] = "Jucatorul ["  ..name..  '] ['..user_id..'] a intrat pe server!',
                                                                    ["footer"] = {
                                                                        ["text"] = ""..time..""
                                                                    }
                                                                }
                                                            }
                                                            PerformHttpRequest('https://discord.com/api/webhooks/1321588922270224477/e8XPomuv5ES5R-jk52BoKb_rORZF0RSf-INXvpKEtnE2adQFsaf7Ebt5WkuYH4tLVVFp', function(err, text, headers) end, 'POST', json.encode({embeds = embed}), {['Content-Type'] = 'application/json'})
                                                            TriggerEvent("vRP:playerJoin", user_id, source, name, tmpdata.last_login)
                                                            deferrals.done()
                                                        end)
                                                    end)
                                                else
                                                    TriggerEvent("vRP:playerRejoin", user_id, source, name)
                                                    deferrals.done()
                                                    local tmpdata = vRP.getUserTmpTable(user_id)
                                                    tmpdata.spawns = 0
                                                end
                                                Debug.pend()
                                            else
                                                deferrals.done("Serverul este in mentenanta! 🔒 [ID = " .. user_id .. "]")
                                            end
                                        end)
                                    else
                                        deferrals.done("Esti interzis permanent pe server!\nInterzis de catre: " .. bannedBy .. "\nMotiv: " .. banReason .. "\nID-ul tau: [" .. user_id .. "]\nACEST BAN NU EXPIRA NICIODATA!\n\n⚠ Daca crezi ca ai fost interzis pe nedrept, poti face o cerere de unban pe Discord: discord.gg/anubisro")
                                    end
                                else
                                    deferrals.done("Esti interzis temporar pe server!\nInterzis de catre: " .. bannedBy .. "\nMotiv: " .. banReason .. "\nTimp: " .. BanZile .. " zile\nID-ul tau: [" .. user_id .. "]\nInterzis la data de: " .. BanDate .. "\nExpira la data de: " .. BanExpireDate .. "\n\n⮚ Vei primi unban automat dupa ce a trecut timpul! ⮘\n\n⚠ Daca crezi ca ai fost interzis pe nedrept, poti face o cerere de unban pe Discord: discord.gg/anubisro")
                                end
                            end)
                    end)
                else
                    deferrals.done("Din pacate, au aparut unele probleme, te rugam sa te reconectezi... ✏️")
                end
        end)
    else
        deferrals.done("Nu te-am putut identifica, te rugam sa te reconectezi... 📌")
    end
    Debug.pend()
end)
AddEventHandler("playerDropped", function(reason)
    local source = source
    Debug.pbegin("playerDropped")
    vRPclient.removePlayer(-1, {source})
    local user_id = vRP.getUserId(source)
    local name = vRP.getPlayerName(source)
    if user_id ~= nil then
        local time = os.date("%d/%m/%Y - %X")
        print("^0Jucatorul ^1" .. name .. " (^0" .. user_id .. "^1) ^0a iesit de pe server. ^1[^0"..time.."^1]^0")
        local name = vRP.getPlayerName(source)
        local name = vRP.getPlayerName(source)
        local time = os.date("%d/%m/%Y - %X")
        local embed = {
            {
                ["color"] = "56921",
                ["type"] = "rich",
                ["title"] = "Anubis Disconnect",
                ["description"] = "Jucatorul ["  ..name..  '] ['..user_id..'] a iesit pe server!',
                ["footer"] = {
                    ["text"] = ""..time..""
                }
            }
        }
        PerformHttpRequest('https://discord.com/api/webhooks/1321589071755087925/szwkEh1OktT4SeFH77r7ceDIF59rxO-VjbLxul1i3PrGR7pv4D-NWYAFAJRQBUS6XAqI', function(err, text, headers) end, 'POST', json.encode({embeds = embed}), {['Content-Type'] = 'application/json'})
        TriggerEvent("vRP:playerLeave", user_id, source, reason)
        vRP.setUData(user_id, "vRP:datatable", json.encode(vRP.getUserDataTable(user_id)))
        vRP.users[vRP.rusers[user_id]] = nil
        vRP.rusers[user_id] = nil
        vRP.user_tables[user_id] = nil
        vRP.user_tmp_tables[user_id] = nil
        vRP.user_sources[user_id] = nil
    end
    Debug.pend()
end)
RegisterServerEvent("vRPcli:playerSpawned")
AddEventHandler("vRPcli:playerSpawned", function()
    Debug.pbegin("playerSpawned")
    local user_id = vRP.getUserId(source)
    local player = source
    if user_id ~= nil then
        vRP.user_sources[user_id] = source
        local tmp = vRP.getUserTmpTable(user_id)
        tmp.spawns = tmp.spawns + 1
        local first_spawn = (tmp.spawns == 1)
        if first_spawn then
            for k, v in pairs(vRP.user_sources) do
                vRPclient.addPlayer(source, {v})
            end
            vRPclient.addPlayer(-1, {source})
            hoursPlayed[user_id] = tonumber(exports.oxmysql:executeSync("SELECT hoursPlayed FROM vrp_users WHERE id = @user_id", {user_id = user_id})[1].hoursPlayed)
        end
        Tunnel.setDestDelay(player, config.load_delay)
        exports.oxmysql:execute("UPDATE vrp_users SET username = @username WHERE id = @user_id", {user_id = user_id, username = vRP.getPlayerName(player)}, function() end)
        SetTimeout(2000, function()
            TriggerEvent("vRP:playerSpawn", user_id, player, first_spawn)
            SetTimeout(config.load_duration * 1000, function()
                Tunnel.setDestDelay(player, config.global_delay)
            end)
        end)
    end
    Debug.pend()
end)
RegisterServerEvent("vRP:playerDied")


ServerCallbacks = {}

RegisterServerEvent(GetCurrentResourceName() .. ':triggerServerCallback')
AddEventHandler(GetCurrentResourceName() .. ':triggerServerCallback', function(name, requestId, ...)
    local playerId = source

    TriggerServerCallback(name, requestId, playerId, function(...)
        TriggerClientEvent(GetCurrentResourceName() .. ':serverCallback', playerId, requestId, ...)
    end, ...)
end)

function vRP.registerCallback(name, callback)
    ServerCallbacks[name] = callback
end

function TriggerServerCallback(name, requestId, source, callback, ...)
    if ServerCallbacks[name] then
        ServerCallbacks[name](source, callback, ...)
    end
end