local htmlEntities = module("lib/htmlEntities")
local Tools = module("lib/Tools")

local titles = {"Trial Helper", "Helper", "Helper Avansat", "Moderator", "Super Moderator", "Administrator", "Super Administrator",  "Supervizor", "Lucid Loyal", "Head of Staff", "Manager Staff", "Manager Server", "Co Fondator", "Developer", "Fondator"}

local staffDuty = {}

function setPlayerDuty(player, user_id)
    if not user_id then return end 
	local players = vRP.getUserId(player)
    if not staffDuty[user_id] then 
        staffDuty[user_id] = true
        vRPclient.notify(players,{"Te-ai pus ON-Duty"})
        vRP.closeMenu(players)
        TriggerClientEvent('chatMessage', -1, "Admin-ul ^5".. vRP.getPlayerName(player) .. "^0 s-a pus ^1 ON-DUTY!")
    else
        if staffDuty[user_id] then 
            staffDuty[user_id] = false
            vRPclient.notify(players,{"Te-ai pus OFF-Duty"})
            vRP.closeMenu(players)
            TriggerClientEvent('chatMessage', -1, "Admin-ul ^5".. vRP.getPlayerName(player) .. "^0 cu grad-ul de ^1"..vRP.getUserAdminTitle(user_id).." ^0 s-a pus ^1 OFF-DUTY!")
        end
    end
end



function vRP.getUserAdminLevel(user_id)
	if user_id ~= nil then
		local tmp = vRP.getUserTmpTable(user_id)
		if tmp then
		
			return tonumber(tmp.adminLevel)
		end
	end
	return 0
end


function vRP.isAdmin(user_id)
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp then
		adminLevel = tmp.adminLevel
	end
	if (adminLevel > 0) then
		return true
	else
		return false
	end
end

function vRP.isUserTrialHelper(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 1)then
		return true
	else
		return false
	end
end

function vRP.isUserHelper(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 2)then
		return true
	else
		return false
	end
end

function vRP.isUserHelperAvansat(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 3)then
		return true
	else
		return false
	end
end

function vRP.isUserModerator(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 4)then
		return true
	else
		return false
	end
end

function vRP.isUserSuperModerator(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 5)then
		return true
	else
		return false
	end
end


function vRP.isUserAdministrator(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 6)then
		return true
	else
		return false
	end
end

function vRP.isUserSuperAdministrator(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 7)then
		return true
	else
		return false
	end
end

function vRP.isUserManagerServer(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 12)then
		return true
	else
		return false
	end
end

function vRP.isUserManagerStaff(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 11)then
		return true
	else
		return false
	end
end

function vRP.isUserLucidLoyal(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 9)then
		return true
	else
		return false
	end
end


function vRP.isUserHeadofStaff(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 10)then
		return true
	else
		return false
	end
end


function vRP.isUserSupervizor(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 8)then
		return true
	else
		return false
	end
end

function vRP.isUserCoFondator(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 13)then
		return true
	else
		return false
	end
end

function vRP.isUserFondator(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 14)then
		return true
	else
		return false
	end
end

function vRP.isUserDeveloper(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 15)then
		return true
	else
		return false
	end
end

function vRP.isUserFondatorComunitate(user_id)
	local adminLevel = vRP.getUserAdminLevel(user_id)
	if(adminLevel >= 16)then
		return true
	else
		return false
	end
end

function vRP.getUserAdminTitle(source)
	local user_id = vRP.getUserId(source)
    local text = titles[vRP.getUserAdminLevel(user_id)] or "Admin"
    return text
end

function vRP.setUserAdminLevel(user_id,admin)
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp then
		tmp.adminLevel = admin
	end
	exports.oxmysql:execute("UPDATE vrp_users SET adminLvl = @adminLevel WHERE id = @user_id", {user_id = user_id, adminLevel = admin})
end

function vRP.getOnlineAdmins()
	local oUsers = {}
	for k,v in pairs(vRP.rusers) do
		if vRP.isUserAdmin(tonumber(k)) then table.insert(oUsers, tonumber(k)) end
	end
	return oUsers
end

function vRP.getOnlineStaff()
    local onStaff = {}
    local users = vRP.getUsers()
    for k,v in pairs(users) do
        if vRP.isUserTrialHelper(tonumber(k)) then
            table.insert(onStaff, tonumber(k))
        end
    end
    return onStaff
end


function vRP.sendStaffMessage(msg)
	for k, v in pairs(vRP.rusers) do
		local ply = vRP.getUserSource(tonumber(k))
		if vRP.isUserTrialHelper(k) and ply then
			TriggerClientEvent("chatMessage", ply, msg)
		end
	end
end

local function ch_addgroup(player,choice)
	local user_id = vRP.getUserId(player)
	local numestaff = vRP.getPlayerName(player)
	
	if user_id ~= nil then
	  vRP.prompt(player,"User id: ","",function(player,id)
		id = parseInt(id)
		vRP.prompt(player,"Group to add: ","",function(player,group)
		  vRP.addUserGroup(id,group)
		  Wait(150)
		  vRP.sendStaffMessage("^1Staff: ^0Admin-ul ^1".. vRP.getPlayerName(player) .." ^0i-a dat add group lui ID ^1".. id .."")
		  vRP.sendStaffMessage("^1Group: ^0".. group)
		  vRPclient.notify(player,{"Succes: Grupa "..group.." a fost adaugata lui "..id})
		end)
	  end)
	end
end

local function ch_removegroup(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"ID: ","",function(player,id)
			id = parseInt(id)
			nplayer = vRP.getUserSource(tonumber(id))
			if(tonumber(id)) and (id > 0) and (id ~= "") and (id ~= nil)then
				if nplayer ~= nil then
					vRP.prompt(player,"Grad de scos: ","",function(player,group)
						if group ~= nil then
							vRP.removeUserGroup(id,group)
							vRPclient.notify(player,{"Succes: Grad-ul "..group.." a fost scos pentru id-ul "..id})
							vRP.sendStaffMessage("^1Staff: ^0Admin-ul ^1".. vRP.getPlayerName(player) .." ^0i-a dat remove group lui ID ^1".. id .."")
							vRP.sendStaffMessage("^1Group: ^0".. group)
						end
					end)
				else
					vRPclient.notify(player,{"Eroare: Jucatorul nu este online!"})
				end
			else
				vRPclient.notify(player,{"Eroare: ID-ul pare invalid!"})
			end
		end)
	end
end

local function staffimbracarea(player)
    local user_id = vRP.getUserId(player)
    if vRP.isUserHelperInTeste(user_id) then
        TriggerClientEvent("ilc:hainastaff", player)
    end
end
local function staffdezbracarea(player)
    local user_id = vRP.getUserId(player)
    if vRP.isUserHelperInTeste(user_id) then
        TriggerEvent("raid_clothes:load_ped", player)
    end
end

cooldowns = {}
local function toggleDuty(player)
    local user_id = vRP.getUserId(player)

    if user_id then
        local current_time = os.time()

        if not cooldowns[user_id] or current_time - cooldowns[user_id] >= 5 then 
            if not onsduty[user_id] then
                onsduty[user_id] = true
                vRPclient.notify(player, {"Ti ai pus imbracamintea staff"})
              
                staffimbracarea(player) 
            else
                staffdezbracarea(player)

                onsduty[user_id] = nil
                vRPclient.notify(player, {"te ai dezbracat de staff"})
            end

            cooldowns[user_id] = current_time 
        else
            
            vRPclient.notify(player, {"Trebuie sa astepti 5 secunde."})
        end
    else
        vRPclient.notify(player, {"Nu esti staff"})
    end
end

local function ch_kick(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"ID: ","",function(player,id)
			id = parseInt(id)
      		local source = vRP.getUserSource(id)
      		if(tonumber(id) and (id ~= "") and (id > 0))then
				if(id == 1 or id == 2 or id == 3)then
					vRPclient.notify(player,{"Eroare: Nu ai cum sa imi dai kick fraiere!"})
					if(source ~= nil)then
						TriggerClientEvent('chatMessage', -1, "^4Lucid: ^0Pripasul asta ^1"..vRP.getPlayerName(player).."^0 a incercat sa ii dea kick lui id 1, 2 sau 3")
					end
      			else
					vRP.prompt(player,"Motiv: ","",function(player,reason)
						if reason ~= "" then
							local source = vRP.getUserSource(id)
							if source ~= nil then
								TriggerClientEvent("chatMessage", -1, "^4Lucid: ^1"..vRP.getPlayerName(source).." ^0a primit kick de la ^1".. vRP.getPlayerName(player))
								TriggerClientEvent("chatMessage", -1, "^4Motiv: ^0".. reason)
                                vRP.kick(source,reason)
        					else
          						vRPclient.notify(player,{"Eroare: Jucatorul nu este online!"})
							end
						else
							vRPclient.notify(player,{"Eroare: Trebuie sa completezi motivul."})
						end
        			end)
      			end
    		else
      			vRPclient.notify(player,{"Eroare: ID-ul pare invalid!"})
			end
    	end)
	end
end

local function ch_ban(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"ID (BAN PERMANENT): ","",function(player,id)
      		id = parseInt(id)
      		local source = vRP.getUserSource(id)
      		if(tonumber(id) and (id ~= "") and (id > 0))then
				if(id == 1 or id == 2 or id == 3)then
					if(source ~= nil)then
						TriggerClientEvent('chatMessage', -1, "^4Lucid: ^0Pripasul asta ^1"..vRP.getPlayerName(player).."^0 a incercat sa ii dea ban lui id 1,2,3")
					end
      			else
					vRP.prompt(player,"Motiv: ","",function(player,reason)
						if reason ~= "" then
							local source = vRP.getUserSource(id)
							if source ~= nil then
								theFaction = vRP.getUserFaction(id)
								if(theFaction ~= "user")then
									vRP.removeUserFaction(id,theFaction)
									vRP.removeUserGroup(id,"onduty")
								end
								TriggerClientEvent("chatMessage", -1, "^4Lucid: ^1"..vRP.getPlayerName(source).." ("..id..") ^0a fost banat permanent de ^1"..vRP.getPlayerName(player).." ("..user_id..")")
								TriggerClientEvent("chatMessage", -1, "^4Motiv: ^0".. reason)			
								local embed = {
									{
										["color"] = "15158332",
										["type"] = "rich",
										["title"] = "Logs Unban",
									   
										["description"] = ""..vRP.getPlayerName(source).." ("..id..") ^0a fost banat permanent de ^1"..vRP.getPlayerName(player).." ("..user_id..") \n Motiv: "..reason.." ",
										["footer"] = {
										["text"] = "Made by Edy"
										}
									}
								  }
								
								PerformHttpRequest('https://discord.com/api/webhooks/1321589768420724766/bDEjvmKbANuy2OKfn-ZeLkEdR_NGlGVbpImLvXsSgBHshyklWZeQZKEIFb_yCz-F5uLn', function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' }) 					
								vRP.ban(source,reason,player) 
							else
								local rows = exports.oxmysql:executeSync("SELECT username FROM vrp_users WHERE id = @user_id", {user_id = id})
								TriggerClientEvent("chatMessage", -1, "^4Lucid: ^1"..tostring(rows[1].username).." ("..id..") ^0a fost banat permanent de ^1"..vRP.getPlayerName(player).." ("..user_id..")")
								TriggerClientEvent("chatMessage", -1, "^4Motiv: ^0".. reason)
								vRP.setBanned(id,true,reason,player)
							end
						else
							vRPclient.notify(player,{"Eroare: Trebuie sa completezi motivul."})
						end
       		 		end)
      			end
    		else
      			vRPclient.notify(player,{"Eroare: ID-ul pare invalid!"})
    		end
    	end)
	end
end

local function ch_banTemp(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"Jucator ID de BANAT TEMPORAR: ","",function(player,id)
      		id = parseInt(id)
      		local source = vRP.getUserSource(id)
      		if(tonumber(id) and (id ~= "") and (id > 0))then
				if(id == 1 or id == 2 or id == 3) then
					vRPclient.notify(player,{"Eroare: Nu ai cum sa banezi id-urile astea"})
					if(source ~= nil) then
						vRPclient.notify(source,{"Eroare: "..vRP.getPlayerName(player).." ~w~a incercat sa te baneze!"})
					end
      			else
					vRP.prompt(player,"Motiv: ","",function(player,reason)
						if reason ~= "" then
							vRP.prompt(player,"Timp (zile): ","",function(player,timp)
								timp = parseInt(timp)
								if tonumber(timp) and (timp ~= "") then
									if (timp >= 2) and (timp <= 90) then
										local expireDate = vRP.getBannedExpiredDate(timp)
										local source = vRP.getUserSource(id)
										if source ~= nil then
											if(timp == 90)then
												theFaction = vRP.getUserFaction(id)
												if(theFaction ~= "user")then
													vRP.removeUserFaction(id,theFaction)
												end
											end
											TriggerClientEvent("chatMessage", -1, "^4Lucid: ^1"..vRP.getPlayerName(source).." ("..id..") ^0a fost banat temporar de ^1"..vRP.getPlayerName(player).." ("..user_id..") ^0pentru ^4"..timp.." zile")
											TriggerClientEvent("chatMessage", -1, "^4Motiv: ^0".. reason)	
											vRP.banTemp(source,reason,player,timp)
										else
											exports.oxmysql:execute("SELECT username FROM vrp_users WHERE id = @user_id", {user_id = id}, function(rows)
											TriggerClientEvent("chatMessage", -1, "^4Lucid: ^1"..tostring(rows[1].username).." ("..id..") ^0a fost banat temporar de ^1"..vRP.getPlayerName(player).." ("..user_id..") ^0pentru ^4"..timp.." zile")
											TriggerClientEvent("chatMessage", -1, "^4Motiv: ^0".. reason)												
											vRP.setBannedTemp(id,true,reason,player,timp)
											end)
										end
									else
										vRPclient.notify(player,{"Eroare: ~w~Maxim 90 de zile (3 luni)"})
									end
								else
									vRPclient.notify(player,{"Eroare: ~w~Timp-ul nu poate fi gol"})
								end
							end)
						else
							vRPclient.notify(player,{"Eroare: ~w~Motiv-ul nu poate fi gol"})
						end
       		 		end)
      			end
    		else
      			vRPclient.notify(player,{"Eroare: ~w~Acest ID este INVALID!"})
    		end
    	end)
	end
end

local function ch_checkplayer(player, choice)
	check_menu = {name="Check Player",css={top="75px", header_color="rgba(0,125,255,0.75)"}}
	vRP.prompt(player, "User ID:", "", function(player, user_id)
		user_id = tonumber(user_id)
		usrID = vRP.getUserId(player)
		if(user_id == 1) and (user_id ~= 2) and (user_id ~= 3) then
			vRPclient.notify(player, {"Eroare: Nu ai cum sa dai check pe id 1,2 si 3"})
			return
		else
			theTarget = vRP.getUserSource(user_id)
			if(theTarget)then
				user_id = vRP.getUserId(theTarget)
				wallet = vRP.getMoney(user_id)
				ore = vRP.getUserHoursPlayed(user_id)
				bank = vRP.getBankMoney(user_id)
				steamID = GetPlayerIdentifier(theTarget) or "Invalid"
				rsLicense = GetPlayerIdentifier(theTarget, 1) or "Invalid"
				theIP = GetPlayerEndpoint(theTarget) or "Invalid"
				vRP.sendStaffMessage("^1Staff: ^0Admin-ul ^1".. vRP.getPlayerName(player) .." ^0a folosit check player")
			
				check_menu["[1] Bani"] = {function() end, "Buzunar: <font color='red'>$"..vRP.formatMoney(wallet).."</font><br>Banca: <font color='red'>$"..vRP.formatMoney(bank)}
				check_menu["[2] Ore"] = {function() end, "Ore: <font color='red'>"..ore.."</font>"}
				check_menu["[3] Nume"] = {function() end, "Nume: <font color='red'>"..GetPlayerName(theTarget).."</font>"}
				check_menu["[4] Vehicule"] = {function(player, choice) playerVehs(player,user_id) end, "Vezi masinile jucatorilui"}
				vRP.closeMenu(player)
				SetTimeout(200, function()
					vRP.openMenu(player, check_menu)
				end)
			end
		end
	end)
end

local function ch_food(player,choice)
    local user_id = vRP.getUserId(player)
    vRP.setThirst(user_id,-100)
  vRP.setHunger(user_id,-100)
end

local function ch_unban(player,choice)
  	local user_id = vRP.getUserId(player)
  	if user_id ~= nil then
    	vRP.prompt(player,"ID (UNBAN): ","",function(player,id)
      		id = parseInt(id)
			if(tonumber(id) and (id ~= "") and (id > 0)) then
				exports.oxmysql:execute("SELECT * FROM vrp_users WHERE id = @user_id", {user_id = id}, function(rows)
					warnuri = tonumber(rows[1].warns)
					if(warnuri == 3)then
						exports.oxmysql:execute("UPDATE vrp_users SET warnr1 = @warnr1, warnr2 = @warnr2, warnr3 = @warnr3, warnid1 = @warnid1, warnid2 = @warnid2, warnid3 = @warnid3, warns = 0, finalSansa = 0 WHERE id = @user_id", {user_id = id, warnr1 = "none", warnr2 = "none", warnr3 = "none", warnid1 = "none", warnid2 = "none", warnid3 = "none"}, function()end)
					end
					TriggerClientEvent('chatMessage', -1, "^4Lucid: ^1"..tostring(rows[1].username).." ("..id..") ^0a primit unban de la ^1"..vRP.getPlayerName(player).." ("..user_id..")")
					local embed = {
						{
							["color"] = "15158332",
							["type"] = "rich",
							["title"] = "Logs Unban",
						   
							["description"] = ""..tostring(rows[1].username).." ("..id..") a primit unban de la "..vRP.getPlayerName(player).." ("..user_id..")",
							["footer"] = {
							["text"] = "Made by Edy"
							}
						}
					  }
					
					PerformHttpRequest('https://discord.com/api/webhooks/1321589768420724766/bDEjvmKbANuy2OKfn-ZeLkEdR_NGlGVbpImLvXsSgBHshyklWZeQZKEIFb_yCz-F5uLn', function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' }) 
					vRP.setBannedTemp(id,false,"","",0)
				end)
    		else
      			vRPclient.notify(player,{"Eroare: ID-ul pare invalid."})
     		end
    	end)
  	end
end


local function ch_coords(player,choice)
  	vRPclient.getPosition(player,{},function(x,y,z)
    	vRP.prompt(player,"Coordonate",x..","..y..","..z,function(player,choice) end)
		print(""..x..","..y..","..z.."")
  	end)
end

local function ch_tptoplace(player,choice)
	local user_id = vRP.getUserId(source)
	vRP.prompt(player,"ID: ","",function(player,id) 
		local id = parseInt(id)
    vRP.prompt(player,"Unde vrei sa te teleportezi","[1] showroom, [2] spawn, [3] politie, [4] spital",function(player,raspuns) 
			tp = parseInt(raspuns)
			if id ~= nil then
				local thePlayer = vRP.getUserSource(id)
				if thePlayer ~= nil then
					if tp == 1 then
						vRPclient.notify(player,{"Succes: L-ai teleportat pe "..GetPlayerName(thePlayer).." la Showroom"})
						vRPclient.notify(thePlayer,{"Succes: Ai fost teleporat la Showroom de catre adminul "..GetPlayerName(player)})
						vRPclient.teleport(thePlayer,{-38.905174255371,-1110.2645263672,26.438343048096})
					elseif tp == 2 then
						vRPclient.notify(player,{"Succes: L-ai teleportat pe "..GetPlayerName(thePlayer).." la Spawn"})
						vRPclient.notify(thePlayer,{"Succes: Ai fost teleporat la Spawn de catre adminul "..GetPlayerName(player)})
						vRPclient.teleport(thePlayer,{-542.84997558594, -207.88090515137, 37.649826049805})
					elseif tp == 3 then
						vRPclient.notify(player,{"Succes: L-ai teleportat pe "..GetPlayerName(thePlayer).." la Politie"})
						vRPclient.notify(thePlayer,{"Succes: Ai fost teleporat la Politie de catre adminul "..GetPlayerName(player)})
						vRPclient.teleport(thePlayer,{426.77401733398,-981.39434814453,30.710090637207})
					elseif tp == 4 then
						vRPclient.notify(player,{"Succes: L-ai teleportat pe "..GetPlayerName(thePlayer).." la Spital"})
						vRPclient.notify(thePlayer,{"Succes: Ai fost teleporat la Spital de catre adminul "..GetPlayerName(player)})
						vRPclient.teleport(thePlayer,{294.42080688477,-591.26116943359,43.084869384766})
					end
				else
					vRPclient.notify(player,{"Eroare: ~w~Jucatorul nu este online!"})
				end
			else
				vRPclient.notify(player,{"Eroare: ~w~Jucatorul nu este online!"})
			end
		end)	
	end)
end

local function ch_tptome(player,choice)
  	vRPclient.getPosition(player,{},function(x,y,z)
    	vRP.prompt(player,"ID:","",function(player,user_id) 
     		local tplayer = vRP.getUserSource(tonumber(user_id))
			local target = vRP.getUserSource(user_id)
			local numestaff = vRP.getPlayerName(player)
      		if tplayer ~= nil then
        		vRPclient.teleport(tplayer,{x,y,z})
				vRP.sendStaffMessage("^1Staff: ^0Admin-ul ^1".. numestaff .." ^0a dat tptome lui ^1".. tplayer)
      		end
    	end)
  	end)
end
 
local function ch_tpto(player,choice)
  	vRP.prompt(player,"ID:","",function(player,user_id) 
    	local tplayer = vRP.getUserSource(tonumber(user_id))
		local numestaff = vRP.getPlayerName(player)
    	if tplayer ~= nil then
      		vRPclient.getPosition(tplayer,{},function(x,y,z)
        		vRPclient.teleport(player,{x,y,z})
				vRPclient.teleport(player,{x,y,z})
				vRP.sendStaffMessage("^1Staff: ^0Admin-ul ^1".. numestaff .." ^0a dat tpto la ID ^1".. tplayer)
      		end)
    	end
  	end)
end

local function ch_tptocoords(player,choice)
	vRP.prompt(player,"Coordonate X,Y,Z:","",function(player,fcoords) 
  local coords = {}
  for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
		table.insert(coords,tonumber(coord))
  end

	  local x,y,z = 0,0,0
	  if coords[1] ~= nil then x = coords[1] end
	  if coords[2] ~= nil then y = coords[2] end
	  if coords[3] ~= nil then z = coords[3] end

	  vRPclient.teleport(player,{x,y,z})
	end)
end

local function ch_givemoney(player,choice)
	local ID = vRP.getUserId(player)
	vRP.prompt(player, "ID:", "", function(player, user_id)
		user_id = tonumber(user_id)
		local target = vRP.getUserSource(user_id)
		if target ~= nil then
		vRP.prompt(player,"Suma:","",function(player,amount) 
			amount = parseInt(amount)
				if(tonumber(amount) ~= nil) and (tonumber(amount) ~= "")then
					if(tonumber(amount) > 0) and (tonumber(amount) <= 500000000)then
						vRP.giveMoney(user_id, amount)
						vRP.sendStaffMessage("^1Staff: ^0Admin-ul ^1".. vRP.getPlayerName(player) .." ^0i-a dat givemoney lui ^1".. vRP.getPlayerName(target) .." ("..target ..")")
						vRP.sendStaffMessage("^1Money: ^0".. amount)
						vRPclient.notify(player,{"Succes: I-ai dat lui "..vRP.getPlayerName(target).." suma de ".. vRP.formatMoney(amount) .." (de) €."})
						vRPclient.notify(target, {"Info: ".. vRP.getPlayerName(player) .." ti-a dat ".. vRP.formatMoney(amount) .." (de) €."})
						local embed = {
							{
								["color"] = "15158332",
								["type"] = "rich",
								["title"] = "Logs GiveMoney",
							   
								["description"] = "Admin-ul ".. vRP.getPlayerName(player) .." ^0i-a dat givemoney lui ".. vRP.getPlayerName(target) .." ("..target ..")",
								["footer"] = {
								["text"] = "Made by Edy"
								}
							}
						  }
						
						PerformHttpRequest('https://discord.com/api/webhooks/1321589328085778482/5PtTZJbHBZrtjzEr1jp0oT4RPWLj247_NUU2hZLYgMrwqzQGsvfkyQXATbz69xU1_5pj', function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' }) 
					else
						vRPclient.notify(player, {"Eroare: ~w~Maxim 100.000.000 coco"})
					end
				else
					vRPclient.notify(player, {"Eroare: ~w~Suma introdusa trebuie sa fie formata doar din numere"})
				end
			end)
		else
			vRPclient.notify(player, {"Eroare: ~w~Jucatorul nu este online."})
		end
	end)
end

local function ch_takemoney(player,choice)
	local ID = vRP.getUserId(player)
	vRP.prompt(player, "ID:", "", function(player, user_id)
		user_id = tonumber(user_id)
		local target = vRP.getUserSource(user_id)
		if target ~= nil then
			vRP.prompt(player, "Suma: ", "", function(player, amount)
				amount = parseInt(amount)
				local tBani = tonumber(vRP.getMoney(user_id))
				if(tonumber(amount))then
					amount = tonumber(amount)
					if(tBani >= amount)then
						vRP.takeMoney(user_id,amount)
						vRPclient.notify(player,{"Succes: ~w~I-ai luat lui ~r~"..vRP.getPlayerName(target).." ~w~suma de ~r~".. vRP.formatMoney(amount) .." ~w~(de) €."})
						vRPclient.notify(target, {"Info: ~r~".. vRP.getPlayerName(player) .."~w~ ti-a luat ~r~".. vRP.formatMoney(amount) .." ~w~(de) €."})
						vRP.sendStaffMessage("^1Staff: ^0Admin-ul ^1".. vRP.getPlayerName(player) .." ^0i-a dat take-money lui ^1".. vRP.getPlayerName(target) .." ("..target ..")")
						vRP.sendStaffMessage("^1Take-Money: ^0".. amount)
					else
						vRPclient.notify(player, {"Eroare: ~w~Jucatorul are doar ~b~"..vRP.formatMoney(tBani).." ~w~€."})
					end
				else
					vRPclient.notify(player, {"Eroare: ~w~Suma introdusa trebuie sa fie formata doar din numere."})
				end
			end)
		else
			vRPclient.notify(player, {"Eroare: ~w~Jucatorul nu este online."})
		end
	end)
end



local function ch_giveitem(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"ID:","",function(player,userID)
			userID = tonumber(userID)
			theTarget = vRP.getUserSource(userID)
			if(theTarget)then
				vRP.prompt(player,"Nume item:","",function(player,idname) 
					idname = idname or ""
					vRP.prompt(player,"Cantitate:","",function(player,amount) 
						amount = parseInt(amount)
						vRP.giveInventoryItem(userID, idname, amount, true)
					end)
				end)
			end
		end)
	end
end

local function ch_takeitem(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"ID:","", function(player,userID)
			userID = tonumber(userID)
			theTarget = vRP.getUserSource(userID)
			if(TheTarget) then
				vRP.prompt(player,"Nume item:","", function(player,idname)
					idname = idname or ""
					vRP.prompt(player,"Cantitate:","", function(player, amount)
						amount = parseInt(amount)
						vRP.tryGetInventoryItem(userID, idname, amount, true)
					end)	
				end)
			end
		end)
	end
end

local function ch_takedonationCoins(player,choice)
	local ID = vRP.getUserId(player)
	vRP.prompt(player, "ID:", "", function(player, user_id)
		user_id = tonumber(user_id)
		local target = vRP.getUserSource(user_id)
		if target ~= nil then
			vRP.prompt(player, "Suma: ", "", function(player, amount)
				amount = parseInt(amount)
				local tBani = tonumber(vRP.getdonationCoins(user_id))
				if(tonumber(amount))then
					amount = tonumber(amount)
					if(tBani >= amount)then
						vRP.takeDonationCoins(user_id,amount)
						vRPclient.notify(player,{"Succes ~w~I-ai luat lui ~r~"..vRP.getPlayerName(target).." ~w~suma de ~r~".. vRP.formatMoney(amount) .." ~w~(de) Diamante."})
						vRPclient.notify(target, {"Succes: ~w~".. vRP.getPlayerName(player) .." ti-a luat ~r~".. vRP.formatMoney(amount) .." ~w~(de) Diamante."})
					else
						vRPclient.notify(player, {"Eroare: ~w~Jucatorul are doar ~b~"..vRP.formatMoney(tBani).." ~w~€."})
					end
				else
					vRPclient.notify(player, {"Eroare: ~w~Suma introdusa trebuie sa fie formata doar din numere."})
				end
			end)
		else
			vRPclient.notify(player, {"Eroare: ~w~Jucatorul nu este online."})
		end
	end)
end

local function ch_givedonationCoins(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
	  vRP.prompt(player,"ID:","",function(player,nplayer) 
		  if nplayer ~= "" or nplayer ~= nil then
			  target = vRP.getUserSource(tonumber(nplayer))
			  if target then
				  vRP.prompt(player,"Suma:","",function(player,amount) 
					  amount = parseInt(amount)
					  vRP.givedonationCoins(tonumber(nplayer), amount)
					  vRPclient.notify(player,{"Succes: ~w~I-ai dat lui ~r~"..vRP.getPlayerName(target)..", ".. vRP.formatMoney(amount) .." ~w~(de) Diamante"})
				  end)
			  else
				  vRPclient.notify(player,{"Eroare: ~w~Jucatorul nu a fost gasit."})
			  end
		  end
	  end)
	end
  end

local cfg_inventory = module("cfg/inventory")

function playerVehs(player,user_id)
	check_menu2 = {name="Vehicule",css={top="75px", header_color="rgba(0,125,255,0.75)"}}
	local theVehicles = exports.oxmysql:executeSync("SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id", {user_id = user_id})
	for i, v in pairs(theVehicles) do
		vehName, vehPrice = vRP.checkVehicleName(v.vehicle)
		check_menu2[vehName] = {function(player, choice) 
			local chestname = "u"..user_id.."veh_"..string.lower(v.vehicle)
			local max_weight = cfg_inventory.vehicle_chest_weights[string.lower(v.vehicle)] or cfg_inventory.default_vehicle_chest_weight
			
			vRP.adminCheckInventory(player, chestname, max_weight)
		end, "Model: <font color='green'>"..v.vehicle.."</font><br>Placuta: "..v.vehicle_plate.."<br>"}
	end
	vRP.closeMenu(player)
	SetTimeout(400, function()
		vRP.openMenu(player, check_menu2)
	end)
end

local function ch_noclip(player, choice)
  	vRPclient.toggleNoclip(player, {})
end

RegisterCommand('invisiblemod', function(player, args)
	if vRP.isUserFondator(user_id) then 
  	vRPclient.invisiblemod(player, {})
  	vRPclient.notify(player,{"Succes: ~w~Invisible Mod"})
  end
end)

AddEventHandler("vRP:playerJoin",function(user_id,source,name,last_login)
	local rows = exports.oxmysql:executeSync("SELECT adminLvl FROM vrp_users WHERE id = @user_id", {user_id = user_id})
	local adminLevel = tonumber(rows[1].adminLvl)
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp then
		tmp.adminLevel = adminLevel
	end
end)

local function ch_addAdmin(player,choice)
	local user_id = vRP.getUserId(player)
	local numestaff = vRP.getPlayerName(player)
	local adminlvl = vRP.getUserAdminTitle(user_id)
	if user_id ~= nil then
		vRP.prompt(player,"ID:","",function(player,id) 
			id = parseInt(id)
			local target = vRP.getUserSource(id)
			if(target)then
				vRP.prompt(player,"Admin Rank:","",function(player,rank) 
					rank = parseInt(rank)
					if(tonumber(rank))then
						if(rank <= 14) and (0 < rank)then
							if(target) then
								vRP.setUserAdminLevel(id,rank)
								Wait(150)
								vRPclient.notify(player,{"Succes: ~w~I-ai dat up lui ~r~"..vRP.getPlayerName(target).." ~w~la ~r~"..vRP.getUserAdminTitle(id).."~w~!"})
								vRPclient.notify(target,{"Succes: ~w~Ai primit up la ~r~"..vRP.getUserAdminTitle(id).." ~w~de catre ~r~"..vRP.getPlayerName(player)})
								vRP.sendStaffMessage("^1Staff: ^0Admin-ul ^1".. numestaff .." ^0i-a dat admin lui ^1".. vRP.getPlayerName(target) .." ("..target ..")")
								vRP.sendStaffMessage("^1Admin: ^0".. vRP.getUserAdminTitle(id))
							else
								exports.oxmysql:execute("UPDATE vrp_users SET adminLvl = @adminLevel WHERE id = @user_id", {user_id = id, adminLevel = rank}, function()end)
								vRPclient.notify(player,{"Succes: ~w~I-ai dat up lui ~r~"..id.." ~w~la grad-ul ~r~"..rank.."~w~!"})
							end
						elseif(rank == 0)then
							if(target)then
								vRP.setUserAdminLevel(id,rank)
								Wait(150)
								vRPclient.notify(target,{"Eroare: ~w~Staff-ul ti-a fost scos de catre ~r~"..vRP.getPlayerName(player).."~w~!"})
								vRPclient.notify(player,{"Succes: ~w~I-ai scos staff-ul lui ~r~"..vRP.getPlayerName(target)})
							else
								exports.oxmysql:execute("UPDATE vrp_users SET adminLvl = @adminLevel WHERE id = @user_id", {user_id = id, adminLevel = rank}, function()end)
								vRPclient.notify(player,{"Succes: ~w~I-ai scos functia staff lui ~r~"..id})
							end
						end
					end
				end)
			else
				vRPclient.notify(player,{"Eroare: ~w~Acest ID nu a fost gasit."})
			end
		end)
	end
end

local function ch_ann(player,choice)
	local user_id = vRP.getUserId(player)
	if vRP.isUserSupervizor(user_id) then
		vRP.prompt(player,"Anunt:","",function(player,msg) 
			msg = tostring(msg)
			if(msg ~= "" and msg ~= nil)then
				local embed = {
					{
					  ["color"] = 0x0af2f2,
					  ["title"] = "".. "ANUNT-ADMIN".."",
					  ["description"] = "**Anunt:** "..GetPlayerName(player).." a dat un anunt administrativ \n **Mesaj:** ".. msg .."",
					  ["thumbnail"] = {
						["url"] = "https://cdn.discordapp.com/attachments/840212063258542090/840229914955219004/log1.png",
					  },
					}
				  }
				  PerformHttpRequest('', function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' }) 
				 TriggerClientEvent('chatMessage', -1, "^3"..GetPlayerName(player).." ^0a dat un anunt ^3administrativ!")
				 TriggerClientEvent("InteractSound_CL:PlayOnOne",-1,"sound",1.0)
				 TriggerClientEvent("hud:sendAdminAnn", -1, GetPlayerName(player), user_id, msg)
			end
		end)
	end
end



-- local ch_callStaff = function(src)
-- 	TriggerEvent('lucidTickets:openTicketMenu', src)
-- end

--  RegisterCommand('resettickets', function(source, args, msg)
--      local user_id = vRP.getUserId(source)
--  		if vRP.isUserHeadofStaff(user_id) then
--  		vRPclient.notify(source, {"Succes: ~w~Ticketele au fost resetate cu succes"})
--  		exports.oxmysql:execute("UPDATE vrp_users SET raport = 0", function()end)
--        end
--  end)

function vRP.sendStaffMessage(msg)
	for k, v in pairs(vRP.rusers) do
		local ply = vRP.getUserSource(tonumber(k))
		if vRP.isUserTrialHelper(k) and ply then
			TriggerClientEvent("chatMessage", ply, msg)
		end
	end
end

local function ch_givevip(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
        vRP.prompt(player,"User Id:","",function(player,id)
            local id = parseInt(id)
            if id ~= nil and id > 0 then
                local target = vRP.getUserSource(id)
                if target then
                    local name = GetPlayerName(target) 
                    vRP.prompt(player,"Vip:","",function(player,vip)
                        local vip = parseInt(vip)
                        if vip > 0 then
                            vRP.prompt(player,"Durata: (-1 = permanent)","",function(player,time)
                                time = parseInt(time)
                                if time ~= nil then
                                    vRP.setUserVip(id,vip,time)
                                    local vipTitle = vRP.getUserVipTitle(id)
                                    vRPclient.notify(player,{"~w~I-ai dat ~g~"..vipTitle.." ~w~lui ~g~"..name..""})
                                    vRPclient.notify(target,{"~w~Ai primit ~g~"..vipTitle})
                                end
                            end)
                        else
                            vRP.setUserVip(id,0,-1)
                            vRPclient.notify(player,{"~w~I-ai scos VIP-ul lui ~r~"..name..""})
                            vRPclient.notify(target,{"~r~VIP-ul ti-a fost scos!"})
                        end
                    end)
                else
                    vRPclient.notify(player,{'~r~Acest jucator nu a fost gasit!'})
                end
            else
                vRPclient.notify(player,{"Acest jucator nu a fost gasit!"})
            end
        end)
    end
end

local function ch_givesponsor(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"User ID:","",function(player,id) 
			id = parseInt(id)
			vRP.prompt(player,"SPONSOR:","",function(player,sponsor) 
				sponsor = parseInt(sponsor)
				local target = vRP.getUserSource(id)
				if(target)then
					local name = vRP.getPlayerName(target)
					local numestaff = vRP.getPlayerName(source)
					if(sponsor > 0)then
						vRP.setUserSponsor(id,sponsor)
						sponsorTitle = vRP.getUserSponsorTitle(id)
						Wait(150)
						vRPclient.notify(player,{"Succes: ~w~I-ai dat ~r~ "..sponsorTitle.." ~w~lui ~r~"..name..""})
						vRPclient.notify(target,{"Succes: ~w~Ai primit ~r~"..sponsorTitle})
						vRP.sendStaffMessage("^1Staff: ^0Admin-ul ^1".. numestaff .." ^0i-a dat sponsor lui ^1".. name .." ("..target ..")")
						local embed = {
							{
								["color"] = "15158332",
								["type"] = "rich",
								["title"] = "Logs Add Sponsor",
							   
								["description"] = "Admin-ul ^1".. numestaff .." ^0i-a dat sponsor lui ^1".. name .." ("..target ..")",
								["footer"] = {
								["text"] = "Made by Edy"
								}
							}
						  }
						
						PerformHttpRequest('https://discord.com/api/webhooks/1321589889535578232/wYjQ_mUmTBNXHnU6ZQfBFwVsLv7G24Id1y0Y0SC2wbuXExjmudp7enuk5KOxzGNkrmzM', function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' }) 
					else
						vRP.setUserSponsor(id,sponsor)
						vRPclient.notify(player,{"Succes: ~w~I-ai scos SPONSOR-ul lui ~r~"..name..""})
						vRPclient.notify(target,{"Eroare: ~r~SPONSOR-ul ~w~ti-a fost scos!"})
						local embed = {
							{
								["color"] = "15158332",
								["type"] = "rich",
								["title"] = "Logs Add Sponsor",
							   
								["description"] = "Admin-ul ^1".. numestaff .." ^0i-a scos sponsor-ul lui ^1".. name .." ("..target ..")",
								["footer"] = {
								["text"] = "Made by Edy"
								}
							}
						  }
						
						PerformHttpRequest('https://discord.com/api/webhooks/1321589889535578232/wYjQ_mUmTBNXHnU6ZQfBFwVsLv7G24Id1y0Y0SC2wbuXExjmudp7enuk5KOxzGNkrmzM', function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' }) 
					end
				end
			end)
		end)
	end
end

local dutyStatus = {
	['true'] = 'ON',
	['false'] = 'OFF'
}

local function ch_onDutyStaff(player)
	local user_id = vRP.getUserId(player)
	if not user_id then return end 

	setPlayerDuty(user_id)
end

function getDutyFormat(user_id)
	if not user_id then return end 

	if staffDuty[user_id] then 
		return "OFF"
	else
		return "ON"
	end
end

-- Hotkey Open Admin Menu 2/2
function tvRP.openAdminMenu()
  vRP.openAdminMenu(source)
end

vRP.registerMenuBuilder("main", function(add, data)
	local user_id = vRP.getUserId(data.player)
	if user_id ~= nil then
	  local choices = {}
  
	  -- build admin menu
	  choices["Admin"] = {function(player,choice)
		vRP.buildMenu("admin", {player = player}, function(menu)
		  menu.name = "Admin"
		  menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
		  menu.onclose = function(player) vRP.closeMenu(player) end -- nest menu
		  if vRP.isUserFondatorComunitate(user_id) then
			menu["Take item"] = {ch_takeitem}
			menu["Take Diamante"] = {ch_takedonationCoins}
			menu["#Anunt Administrativ"] = {ch_ann}
			menu["Take money"] = {ch_takemoney}
			menu["Give item"] = {ch_giveitem}
			menu["Add/Remove Admin"] = {ch_addAdmin}
		  end
		  if vRP.isUserDeveloper(user_id) then
			menu["Give money"] = {ch_givemoney}
			menu["Give item"] = {ch_giveitem}
			menu["Give Diamante"] = {ch_givedonationCoins}
			menu["Ban Temporar"] = {ch_banTemp}
			menu["Ban Permanent"] = {ch_ban}
			menu["Unban"] = {ch_unban}
		  end
			if vRP.isUserFondator(user_id) then
			menu["Add/Remove SPONSOR"] = {ch_givesponsor}
			menu["Add/Remove VIP"] = {ch_givevip}
			menu["Kick"] = {ch_kick}
			menu["Unban"] = {ch_unban}
			end
			if vRP.isUserCoFondator(user_id) then
		  end
			if vRP.isUserManagerServer(user_id) then
			menu["PlayerVeh"] = {PlayerVeh}

		  end
			if vRP.isUserManagerStaff(user_id) then
			menu["Food"] = {ch_food}
			menu["Noclip"] = {ch_noclip}
		  end
			if vRP.isUserHeadofStaff(user_id) then

			end
			if vRP.isUserSupervizor(user_id) then
			menu["Add group"] = {ch_addgroup}
			menu["Remove group"] = {ch_removegroup}
		  end
			if vRP.isUserAdministrator(user_id) then
			  menu["Check Player"] = {ch_checkplayer}
			  menu["Coords"] = {ch_coords}

			end
			if vRP.isUserSuperModerator(user_id) then
			end
			if vRP.isUserModerator(user_id) then
			end
			if vRP.isUserHelperAvansat(user_id) then
		  end
			if vRP.isUserHelper(user_id) then
			  menu["TpToCoords"] = {ch_tptocoords}
			end
			if vRP.isUserTrialHelper(user_id) then
			  menu["TpTo"] = {ch_tpto}
			  menu["TpToMe"] = {ch_tptome}
			  menu["IN TESTE -- Imbracaminte Staff"] = {staffimbracarea}
			  menu["TpToPlace"] = {ch_tptoplace}
			end

		   --menu["Admin Ticket"] = {ch_callStaff, "Fa ticket doar daca este ceva importat. Pentru intrebari foloseste comanda /tk."}

		   menu["Admin Ticket"] = {function(player)
			TriggerClientEvent('vrp_tickets:faticket', player)
		end}
  
		  vRP.openMenu(player,menu)
		end)
	  end}
  
	  add(choices)
	end
  end)

  tvRP.isUserStaff = function()
	local source = source
	local user_id = vRP["getUserId"](source)
	if vRP["isAdminOnDuty"](user_id) then
		return true
	else
		return false
	end
end