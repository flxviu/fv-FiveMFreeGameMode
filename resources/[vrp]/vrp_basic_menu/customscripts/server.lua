local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_customScripts")

vRPScustom = {}
Tunnel.bindInterface("vRP_customScripts",vRPScustom)
Proxy.addInterface("vRP_customScripts",vRPScustom)

function vRPScustom.getUserID()
	return vRP.getUserId({source})
end

function vRPScustom.getUserFaction()
	user_id = vRP.getUserId({source})
	if(vRP.hasUserFaction({user_id}))then
		local theFaction = vRP.getUserFaction({user_id})
		return theFaction
	else
		return "Civil"
	end
end

function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end

function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end

-- A function to loop thru the permissions table
function DoUserHavePermission(id)
	for k, v in pairs(permission) do
		if id == v then
			return true
		end
	end
	return false
end

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end


-----------------------------------------------------------------

factions = {
	"Smurd",
	"Politie",
	"DIICOT",
	"Mafia Yakuza",
	"Sons of Anarchy",
	"Crips Gang",
	"Mafia Corleone",
	"Sindicat",
	"Mafia Brigada",
	"Mafia Casa Blanca",
	"Mafia The Jokers",
	"Mafiad",
	"Mafia Gipsy",
	"Guvern",
	"Mafia Araba",
	"Casa Blanca",
	"Grove Street",
	"Mafia Sons of Anarchy",
	"Mafia Rusa",
	"Mafia Bloods",
	"Mafia Diablos",
	"Mafia Travolta",
	"The Families",
	"Mafia Ballas",
	"Ballas Gang",
	"Mafia Sarba",
	"Hitman",
	"Mafia Bratva",
	"225200 Gang",
	"Clanul Pian",
	"Mafia Brigada",
	"Cartel de Medelin",
	"Los Vagos",
	"Clanul Paune",
	"Sons of Anarchy",
	"Mafia Albaneza",
	"Mafia Sarba",
	"Peaky Blinders",
	"Mafia Vanju Mare",
	"Cartel de Sinaloa",
	"Clanul Sportivilor",
	"12 O'Clock Boys",
	"KGB MAFIA",
	"Mafia Corleone",
	"Mafia Columbiana",
	"Mafia Spaniola",
}

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

RegisterCommand('f', function(source, args, rawCommand)
	if(args[1] == nil)then
		TriggerClientEvent('chatMessage', source, "^3SYNTAXA: /"..rawCommand.." [Mesaj]") 
	else
		local user_id = vRP.getUserId({source})
		theFaction = ""
		for i, v in pairs(factions) do
			if vRP.isUserInFaction({user_id,tostring(v)}) then
				theFaction = tostring(v)
			end
		end
		local fMembers = vRP.getOnlineUsersByFaction({tostring(theFaction)})
		for i, v in ipairs(fMembers) do
			local player = vRP.getUserSource({tonumber(v)})
			TriggerClientEvent('chatMessage', player, "^0[^5"..firstToUpper(theFaction).."^0] [^5"..user_id.."^0] " .. GetPlayerName(source) .. " » ^5" ..  rawCommand:sub(3))
		end
	end
end)

-----------------------------------------------------------------

prefix = {
	["AB"] = "Alba",
	["AR"] = "Arad",
	["AG"] = "Arges",
	["BC"] = "Bacau",
	["BH"] = "Bihor",
	["BN"] = "Bistrita-Nasaud",
	["BT"] = "Botosani",
	["BR"] = "Braila",
	["BV"] = "Brasov",
	["BZ"] = "Buzau",
	["CL"] = "Calarasi",
	["CS"] = "Caras-Severin",
	["CJ"] = "Cluj",
	["CT"] = "Constanta",
	["CV"] = "Covasna",
	["DB"] = "Dambovita",
	["DJ"] = "Dolj",
	["GL"] = "Galati",
	["GR"] = "Giurgiu",
	["GJ"] = "Gorj",
	["HR"] = "Harghita",
	["HD"] = "Hunedoara",
	["IL"] = "Ialomita",
	["IS"] = "Iasi",
	["IF"] = "Ilfov",
	["MM"] = "Maramures",
	["MH"] = "Mehedinti",
	["MS"] = "Mures",
	["NT"] = "Neamt",
	["OT"] = "Olt",
	["PH"] = "Prahova",
	["SJ"] = "Salaj",
	["SM"] = "Satu Mare",
	["SB"] = "Sibiu",
	["SV"] = "Suceava",
	["TR"] = "Teleorman",
	["TM"] = "Timis",
	["TL"] = "Tulcea",
	["VL"] = "Valcea",
	["VS"] = "Vaslui",
	["VN"] = "Vrancea",
	["B"] = "Bucuresti"
}

function getPrice( category, model )
    for i,v in ipairs(vehshop.menu[category].buttons) do
      if v.model == model then
          return v.costs
      end
    end
    return nil 
end

function round(x)
  return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end

playerRegVeh = {}
isUsingRAR = false

local function build_rar_menu(source)
	local x, y, z = 143.90582275391,-832.201171875,31.166997909546
	local function rarmenu_enter(source,area)
		user_id = vRP.getUserId({source})
		--if user_id ~= nil then
			rar_menu = {name="Registrul Auto Roman",css={top="75px",header_color="rgba(0,125,255,0.75)"}}
			exports.ghmattimysql:execute("SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id", {["user_id"] = user_id}, function(theVehicles)
				if #theVehicles > 0 then
					for i, v in pairs(theVehicles) do
						vehName, vehPrice = vRP.checkVehicleName({v.vehicle})
						currentNrPlate = tostring(v.vehicle_plate)
						
						nrs = 0
						for ix = 1, string.len(currentNrPlate) do
							if(tonumber(string.sub(currentNrPlate,ix,ix)))then
								nrs = nrs + 1
							end
						end
						
						if(vehPrice <= 0)then
							platePrice = 50000
						else
							platePrice = round(tonumber(vehPrice*0.1))
						end
						
						if(nrs == 5)then
							isReg = "<font color='red'>NU</font><br>Apasa <font color='green'>'ENTER'</font> pentru a inmatricula vehiculul!"
							isPlate = "<font color='green'>"..currentNrPlate.."</font>"
						else
							isReg = "<font color='green'>DA</font><br>Apasa <font color='green'>'ENTER'</font> pentru a inmatricula vehiculul!"
							isPlate = "<font color='green'>"..currentNrPlate.."</font>"
							platePrice = 50000
						end
						rar_menu[vehName] = {function(player, choice)
							if(isUsingRAR == false)then
								isUsingRAR = true
								user_id = vRP.getUserId({player})
								playerRegVeh[user_id] = tostring(v.vehicle)
								rar2_menu = {name="Registrul Auto Roman 2",css={top="75px",header_color="rgba(0,125,255,0.75)"}}
								for i, v in pairs(prefix) do
									rar2_menu["Judetul "..v] = {function(player, choice) 
										user_id = vRP.getUserId({player})
										if(playerRegVeh[user_id] ~= nil)then
											vRP.prompt({player, "Numere (max 3): ", "", function(player, numbers)
												numbers = numbers
												if(string.len(tostring(numbers)) >= 2 and string.len(tostring(numbers)) <= 3)then
													if(tonumber(numbers))then
														vRP.prompt({player, "Litere (max 3): ", "", function(player, letters)
															letters = tostring(letters)
															if(letters:match("%a"))then
																if(string.len(letters) == 3)then
																	thePlate = i..""..numbers..""..letters:upper()
																	exports.ghmattimysql:execute("SELECT * FROM vrp_user_vehicles WHERE vehicle_plate = @vehicle_plate",{["vehicle_plate"] = thePlate}, function(pvehicle)
																		if #pvehicle > 0 then
																			vRPclient.notify(player, {"Eroare: ~w~Acest numar de inmatriculare exista deja!"})
																		else
																			if(vRP.tryPayment({user_id, platePrice}))then
																				theVeh = playerRegVeh[user_id]
																				exports.ghmattimysql:execute("UPDATE vrp_user_vehicles SET vehicle_plate = @vehicle_plate WHERE user_id = @user_id AND vehicle = @vehicle",{["user_id"] = user_id,["vehicle"] = theVeh,["vehicle_plate"] = thePlate}, function(data)end)
																				vehName, vehPrice = vRP.checkVehicleName({theVeh})
																				vRPclient.notify(player, {"Info: ~w~Ai inmatriculat vehiculul "..vehName})
																				vRPclient.notify(player, {"Succes: ~w~Judetul: ~r~"..v})
																				vRPclient.notify(player, {"Succes: ~w~Placuta: ~r~"..thePlate})
																				playerRegVeh[user_id] = nil
																				isUsingRAR = false
																				vRP.closeMenu({player})
																			else
																				vRPclient.notify(player, {"Eroare: ~w~Nu ai destui bani pentru ~r~inmatriculare"})
																			end
																		end
																	end)
																else
																	vRPclient.notify(player, {"Eroare: ~w~Trebuie sa pui 3 litere"})
																end
															else
																vRPclient.notify(player, {"Eroare: ~w~Trebuie sa pui 3 litere"})
															end
														end})
													else
														vRPclient.notify(player, {"Eroare: ~w~Trebuie sa pui 2 sau 3 numere"})
													end
												else
													vRPclient.notify(player, {"Eroare: ~w~Trebuie sa pui 2 sau 3 numere"})
												end
											end})
										end
									end, "Prefix: <font color='red'>"..i.."</font>"}
								end
								Citizen.Wait(100)
								vRP.openMenu({player, rar2_menu})
							else
								vRPclient.notify(source, {"Eroare: ~w~Cineva foloseste deja biroul R.A.R! Asteapta pana cand aceasta persoana termina!"})
							end
						end, "Placuta: "..isPlate.."<br>Inamtriculat: "..isReg.."<br><br>Taxa de inmatriculare <font color='red'>$"..platePrice.."</font>"}
					end
					Citizen.Wait(100)
					vRP.openMenu({source,rar_menu})
				end
			end)
		end
	--end

	local function rarmenu_leave(source,area)
		user_id = vRP.getUserId({source})
		vRP.closeMenu({source})
		playerRegVeh[user_id] = nil
		isUsingRAR = false
	end
		
	vRPclient.addBlip(source,{x,y,z,198,49,"Registrul Auto Roman"})
	vRPclient.addMarkerSign(source,{32,x,y,z-1.3,0.8,0.6,0.8,0, 161, 255,150,150,true,0,0})
	vRP.setArea({source,"vRP:RAR",x,y,z,1,1.5,rarmenu_enter,rarmenu_leave})
end

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
	if first_spawn then
		build_rar_menu(source)
		playerRegVeh[user_id] = nil
	end
end)

AddEventHandler("vRP:playerLeave", function(user_id, source)
	isUsingRAR = false
end)

----------------------------------------------------------------- 

local function sp_fixCar(player, choice)
	user_id = vRP.getUserId({player})
		TriggerClientEvent('murtaza:fix', player)
		vRPclient.notify(player, {"Succes: ~w~Ti-ai reparat vehiculul!"})
		TriggerClientEvent("chatMessage",-1,"^6"..GetPlayerName(player).." ^0a folosit fix din ^6Vip Menu")
end

local function ch_food(player,choice)
    local user_id = vRP.getUserId({player})
    vRP.setThirst({user_id,-100})
  	vRP.setHunger({user_id,-100})
  	TriggerClientEvent("chatMessage",-1,"^6"..GetPlayerName(player).." ^0a folosit apa si mancare din ^6Vip Menu")
	vRPclient.notify(player, {"Succes: ~w~Ti-ai dat apa si mancare!"})
end 

local function ch_carwash(player, choice)
	local user_id = vRP.getUserId({player})
	TriggerClientEvent('carwash:success', player)
	TriggerClientEvent("chatMessage",-1,"^6"..GetPlayerName(player).." ^0si-a spalat masina din ^6Vip Menu")
	vRPclient.notify(player, {"Succes: Ai spalat masina cu succes"})
end

vRP.registerMenuBuilder({"main", function(add, data)
	local user_id = vRP.getUserId({data.player})
	if user_id ~= nil then
		local choices = {}
		if vRP.isUserVipSilver({user_id}) then
				choices["💎 Vip Menu"] = {function(player,choice)
				vRP.buildMenu({"Vip Menu", {player = player}, function(menu)
					menu.name = "Vip Menu"
					menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
					menu.onclose = function(player) vRP.openMainMenu({player}) end 
					menu["🔧 Fix Masina"] = {sp_fixCar,"🔧 > Repara-ti vehiculul"}
					menu["🍟 Mancare si Apa"] = {ch_food,"🍟 > Da-ti mancare si apa"}
					menu["💦 Spala Masina"] = {ch_carwash,"💦 > Spala masina"}
					
					vRP.openMenu({player,menu})
				end})
			end, "💎 Meniu VIP 💎"}
		end
		add(choices)
	end
end})

-----------------------------------------------------------------

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
	if user_id then
	  local numar = vRP.getInventoryItemAmount({user_id,"permis"})
	  if tonumber(numar) > 0 then
		TriggerClientEvent('vezidacaarepermisvere',source,0)
	  end
	end
  end)
  
  local oferapermis = {function(player,choice)
	vRPclient.getNearestPlayer(player,{10},function(nplayer)
	  local nuser_id = vRP.getUserId({nplayer})
	  if nuser_id ~= nil then
		vRPclient.notify(player,{"Succes: Oferi contract permis auto..."})
		vRP.request({nplayer,"Vrei sa platesti : 10.000$ pentru a primi permis-ul auto ?",15,function(nplayer,ok)
		  if ok then
			local numar = vRP.getInventoryItemAmount({nuser_id,"permis"})
			if tonumber(numar) < 1 then
			  if vRP.tryPayment({nuser_id,10000}) then
				vRPclient.notify(player,{"Succes: Jucator-ul : ~g~"..nuser_id.." ~w~a platit ~g~10.000$ ~w~pentru permis-ul auto"})
				vRPclient.notify(nplayer,{"Succes: Ai platit ~g~10.000$ ~w~pentru permis-ul auto"})
				vRP.giveInventoryItem({nuser_id,"permis",1,false})
				TriggerClientEvent('vezidacaarepermisvere',nplayer,0)
			  else
				vRPclient.notify(player,{"Info: Jucator-ul : ~g~"..nuser_id.." ~w~nu are suficienti bani pentru a semna contract-ul de primire al permisului auto"})
				vRPclient.notify(nplayer,{"Eroare: Nu ai ~g~10.000$ ~w~pentru pentru a semna contract-ul de primire al permisului auto"})
			  end
			else
			  vRPclient.notify(player,{"Eroare: Jucator-ul : ~g~"..nuser_id.." ~w~are deja un permis auto"})
			end
		  else
			vRPclient.notify(player,{"Info: Jucator-ul: ~g~"..nuser_id.." ~w~a refuzat contract-ul pentru primirea de permis auto"})
			vRPclient.notify(nplayer,{"Succes: Ai refuzat contract-ul de primire al permisului auto"})
		  end
		end})
	  else
		vRPclient.notify(player,{"Eroare: ~w~Nici un jucator in preajma"})
	  end
	end)
  end, "Ofera licenta de condus celui mai apropriat jucator"}
  
  local cere = {function(player,choice)
	vRPclient.getNearestPlayer(player,{10},function(nplayer)
	  local nuser_id = vRP.getUserId({nplayer})
	  if nuser_id ~= nil then
		vRPclient.notify(player,{"Info: Ceri permis..."})
		vRP.request({nplayer,"Vrei sa ii arati licenta ?",15,function(nplayer,ok)
		  if ok then
			local numar = vRP.getInventoryItemAmount({nuser_id,"permis"})
			if numar > 0 then
			  vRPclient.notify(player,{"Succes: ~w~Permis: ~g~Da"})
			else
			  vRPclient.notify(player,{"Eroare: ~w~Permis: ~r~Nu"})
			end
		  else
			vRPclient.notify(player,{"Info: ~w~A refuzat cererea"})
		  end
		end})
	  else
		vRPclient.notify(player,{"Eroare: ~w~Nici un jucator in preajma"})
	  end
	end)
  end, "Cere permisul de conducere celui mai apropriat jucator."}
  
  
  local confisca = {function(player, choice)
	vRPclient.getNearestPlayer(player,{10},function(nplayer)
	  local nuser_id = vRP.getUserId({nplayer})
	  if nuser_id ~= nil then
		local numar = vRP.getInventoryItemAmount({nuser_id,"permis"})
		if numar > 0 then
		  vRPclient.notify(player,{"Succes: I-ai confiscat permis-ul jucatorului : ~g~"..nuser_id.." !"})
		  vRPclient.notify(nplayer,{"Info: Ti-a fost confiscat permis-ul"})
		  vRP.tryGetInventoryItem({nuser_id,"permis",1,false})
		  TriggerClientEvent('vezidacaarepermisvere',nplayer,1)
		end
	  else
		vRPclient.notify(player,{"Eroare: ~w~Nici un jucator in preajma"})
	  end
	end)
  end, "Confisca permis-ul unui jucator"}
  
 
-----------------------------------------------------------------

RegisterServerEvent("insurance:buysuccess")
AddEventHandler("insurance:buysuccess", function()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if vRP.tryPayment({user_id,10000}) then
    vRP.giveInventoryItem({user_id,"asigurare",1,true})
    vRPclient.notify(player,{"Succes: Ai cumparat asigurare pentru masina!"})
     else
        vRPclient.notifyPicture(player,{"CHAR_BANK_FLEECA",1,"~g~Lucid Bank",false,"Nu ai ~r~Bani~w~ de asigurare"})
    end
end)

local choice_askinsurance = {function(player,choice)
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId({nplayer})
    if nuser_id ~= nil then
      vRPclient.notify(player,{"Succes: Asigurare..."})
      vRP.request({nplayer,"Vrei sa arati asigurarea?",15,function(nplayer,ok)
        if ok then
          local numar = vRP.getInventoryItemAmount({nuser_id,"asigurare"})
            if numar > 0 then
              vRPclient.notify(player,{"Succes: Asigurare: DA"})
            else
              vRPclient.notify(player,{"Eroare: Asigurare: NU"})
            end
        else
          vRPclient.notify(player,{"Info: ~w~A refuzat cererea"})
        end
      end})
    else
      vRPclient.notify(player,{"Eroare: ~w~Nici un jucator in preajma"})
    end
  end)
end, "Verifica asigurarea masinii."}

vRP.registerMenuBuilder({"police", function(add, data)
  local player = data.player

  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    local choices = {}

    if vRP.isUserInFaction({user_id,"Politie"}) then
       choices["Verifica Asigurare"] = choice_askinsurance
    end
    
    add(choices)
  end
end})

----------------------------------------------------------------- 
 
RegisterCommand('giveweapon', function(source, args)
local user_id = vRP.getUserId({source})
if vRP.isUserAdministrator{user_id} then
	local targetId = parseInt(args[1])
	local weapon = GetHashKey(args[2])
	local targetSrc = vRP.getUserSource({targetId})
	if targetSrc ~= nil then
		TriggerClientEvent('addWeapon', targetSrc, {
			hash = weapon,
			admin = GetPlayerName(source),
			id = user_id
		})
	else
		vRPclient.notify(source, {'Eroare: Jucatorul nu este online!'})
	end
else
	vRPclient.notify(source, {'Eroare: ~w~Nu ai acces la aceasta comanda!'})
end
end)


RegisterCommand("id", function(source, args)
local users = vRP.getUsers({})

if not args[1] or args[1] == "" then
	return TriggerClientEvent('chatMessage', source, '^1Failed: ^0Id-ul nu pare valid!')
end
local usingName = (tonumber(args[1]) == nil)
if args[1] ~= nil and args[1]:len() >= 1 then
	local filtered = {}
	local users = vRP.getUsers({})
	for id, sourcee in pairs(users) do
		if usingName then
			local n = GetPlayerName(sourcee)
			if n ~= nil and string.lower(n):find(string.lower(args[1])) then
				table.insert(filtered, id)
			end
		else
			if id == tonumber(args[1]) then
				table.insert(filtered, id)
			end
		end
	end
	for _, user_id in pairs(filtered) do
		local faction = vRP.getUserFaction({user_id})
		local hoursPlayed = vRP.getUserHoursPlayed({user_id})
		if faction == 'none' then
			faction = 'Civil'
		end
		local player = vRP.getUserSource({user_id})
		exports['ghmattimysql']:execute('SELECT warns FROM vrp_users WHERE id = @id', {id = user_id}, function(rows)
			local admin = vRP.isAdmin{user_id}
			local title = ""
			if not admin then
				title = 'Jucator'
			else
				title = vRP.getUserAdminTitle{user_id}
			end
			local usrr = "ID: ^1" .. user_id .. "^0 | Nume: ^1" .. GetPlayerName(player) .. " ^0| Ore: ^1" .. hoursPlayed .. " ^0| Factiune: ^1" .. faction .. " ^0| Warns: ^1" .. rows[1].warns .. " ^0| Grad: ^1" .. title
			TriggerClientEvent("chatMessage", source, usrr)
		end)
	
	end
else
	TriggerClientEvent('chatMessage', source, '^1Eroare: ^0ID-ul nu pare valid!')
end
end)

-----------------------------------------------------------------

RegisterCommand("warns", function(source)
	local user_id = vRP.getUserId({source})
	local rows = exports.ghmattimysql:executeSync("SELECT warns FROM vrp_users WHERE id = @user_id", {['@user_id'] = user_id})
	warns = rows[1].warns
	vRPclient.notify(source,{"Info: Ai "..warns.." warns!"})
end, false)

local function warnp(player,choice)
	local ID = vRP.getUserId({player})
	vRP.prompt({player, "Jucator ID:", "", function(player, user_id)
		user_id = tonumber(user_id)
		if user_id ~= nil and user_id ~= "" then 
			vRP.prompt({player, "Motiv:", "", function(player, motivr)
				if motivr ~= "" then
					motivr = motivr
					exports.ghmattimysql:execute("UPDATE vrp_users SET warns = warns + 1 WHERE id = @user_id", {['@user_id'] = user_id}, function()end)
					exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id = @user_id", {['@user_id'] = user_id}, function(rows)
						local idoff2 = rows[1].id

						nume = vRP.getPlayerName({player}).." ("..ID..")"
						motiv = rows[1].warnr1
						if motiv == "none" then
							exports.ghmattimysql:execute("UPDATE vrp_users SET warnr1 = @warnr1, warnid1 = @warnid1 WHERE id = @user_id", {['@user_id'] = user_id, ['@warnr1'] = motivr, ['@warnid1'] = nume}, function()end)
							TriggerClientEvent('chatMessage', -1, '^3Warn: ^0Jucatorul ^1'..idoff2..' ^0a primit un warn ^4(1/3) ^0de la ^1'..nume)
							TriggerClientEvent('chatMessage', -1, '^3Motiv: ^0'..motivr..'')	
						else
							motiv2 = rows[1].warnr2
							if motiv2 == "none" then
								exports.ghmattimysql:execute("UPDATE vrp_users SET warnr2 = @warnr2, warnid2 = @warnid2 WHERE id = @user_id", {['@user_id'] = user_id, ['@warnr2'] = motivr, ['@warnid2'] = nume}, function()end)
								TriggerClientEvent('chatMessage', -1, '^3Warn: ^0Jucatorul ^1'..idoff2..' ^0a primit un warn ^4(2/3) ^0de la ^1'..nume)
								TriggerClientEvent('chatMessage', -1, '^3Motiv: ^0'..motivr..'')							
							else
								motiv3 = rows[1].warnr3
								if motiv3 == "none" then
									exports.ghmattimysql:execute("UPDATE vrp_users SET warnr3 = @warnr3, warnid3 = @warnid3 WHERE id = @user_id", {['@user_id'] = user_id, ['@warnr3'] = motivr, ['@warnid3'] = nume}, function()end)
									DBwarnr1 = rows[1].warnr1
									DBwarnr2 = rows[1].warnr2
									DBwarnid1 = rows[1].warnid1
									DBwarnid2 = rows[1].warnid2
									if rows[1].finalSansa == 1 then
										local motivban = "Ai acumulat a doua oara 3 avertismente!\nAi primit ban permanent!\n\n➤ Primul avertisment: "..DBwarnr1..", de: "..DBwarnid1.."\n➤ Al doilea avertisment: "..DBwarnr2..", de: "..DBwarnid2.."\n➤ Al treilea avertisment: "..motivr..", de: "..nume.."\n"
										local source = vRP.getUserSource({user_id})
										if source ~= nil then
											vRP.ban({source,motivban,player})
										else
											vRP.setBanned({user_id,true,motivban,player})
										end

										TriggerClientEvent('chatMessage', -1, '^3Warn: ^0Jucatorul ^1'..idoff2..' ^0a primit un warn ^4(3/3) ^0de la ^1'..nume)
										TriggerClientEvent('chatMessage', -1, '^3Motiv: ^0'..motivr..'')	
									else
										local expireDate = vRP.getBannedExpiredDate({7})
										local motivban = "Ai acumulat peste 3 avertismente!\n\n➤ Primul avertisment: "..DBwarnr1..", de: "..DBwarnid1.."\n➤ Al doilea avertisment: "..DBwarnr2..", de: "..DBwarnid2.."\n➤ Al treilea avertisment: "..motivr..", de: "..nume.."\n"
										local source = vRP.getUserSource({user_id})
										if source ~= nil then
											vRP.banTemp({source,motivban,player,7})
										else
											vRP.setBannedTemp({user_id,true,motivban,player,7})
										end
										TriggerClientEvent('chatMessage', -1, '^3Warn: ^0Jucatorul ^1'..idoff2..' ^0a primit un warn ^4(3/3) ^0de la ^1'..nume)
										TriggerClientEvent('chatMessage', -1, '^3Motiv: ^0'..motivr..'')	
									end
								elseif motiv3 ~= "none" then
									exports.ghmattimysql:execute("UPDATE vrp_users SET warnr1 = @warnr1, warnr2 = @warnr2, warnr3 = @warnr3, warnid1 = @warnid1, warnid2 = @warnid2, warnid3 = @warnid3, warns = 0, finalSansa = 1, bannedTemp = 0, bannedReason = @reason, bannedBy = @bannedBy, BanTempZile = 0, BanTempData = @date, BanTempExpire = @expireDate WHERE id = @user_id", {user_id = user_id, warnr1 = "none", warnr2 = "none", warnr3 = "none", warnid1 = "none", warnid2 = "none", warnid3 = "none", reason = "", bannedBy = "", date = "", expireDate = ""}, function()end)
									exports.ghmattimysql:execute("UPDATE vrp_users SET warnr1 = @warnr1, warnid1 = @warnid1 WHERE id = @user_id", {user_id = user_id, warnr1 = motivr, warnid1 = nume}, function()end)
									TriggerClientEvent('chatMessage', -1, '^3Warn: ^0Jucatorul ^1'..idoff2..' ^0a primit un warn ^4(1/3) ^0de la ^1'..nume)
									TriggerClientEvent('chatMessage', -1, '^3Motiv: ^0'..motivr..'')	
								else
									vRPclient.notify(player,{"Eroare: [".. user_id .."] are deja 3 avertismente si ban 7 zile!"})
								end
							end
						end
					end)
				else
					vRPclient.notify(player,{"Eroare: Motivul este obligatoriu"})
					return
				end
			end})
		else
			vRPclient.notify(player,{"Eroare: Niciun ID selectat!"})
		end
	end})
end

local function unwarnp(player,choice)
	local ID = vRP.getUserId({player})
	vRP.prompt({player, "Jucator ID:", "", function(player, user_id)
		user_id = tonumber(user_id)
		if user_id ~= nil and user_id ~= "" then
			local rows = exports.ghmattimysql:executeSync("SELECT id, warnr3, warnr2, warnr1 FROM vrp_users WHERE id = @id", {['@id'] = user_id})
			idoff2 = rows[1].id
			motiv3 = rows[1].warnr3
			motiv2 = rows[1].warnr2
			motiv1 = rows[1].warnr1

			if motiv3 == "none" then
				if motiv2 == "none" then
					if motiv1 == "none" then
						vRPclient.notify(player,{"Eroare: Jucatorul are 0 warn-uri"})
					else
						exports.ghmattimysql:execute("UPDATE vrp_users SET warnr1 = @warnr1, warnid1 = @warnid1, warns = warns - 1 WHERE id = @user_id", {['@user_id'] = user_id, ['@warnr1'] = "none", ['@warnid1'] = "none"}, function()end)
					end
				else
					exports.ghmattimysql:execute("UPDATE vrp_users SET warnr2 = @warnr2, warnid2 = @warnid2, warns = warns - 1 WHERE id = @user_id", {['@user_id'] = user_id, ['@warnr2'] = "none", ['@warnid2'] = "none"}, function()end)
				end
			else
				exports.ghmattimysql:execute("UPDATE vrp_users SET warnr3 = @warnr3, warnid3 = @warnid3, warns = warns - 1 WHERE id = @user_id", {['@user_id'] = user_id, ['@warnr3'] = "none", ['@warnid3'] = "none"}, function()end)
			end
		else
			vRPclient.notify(player,{"Eroare: Niciun ID selectat!"})
		end
	end})
end

local function resetwarn(player,choice)
	local ID = vRP.getUserId({player})
	vRP.prompt({player, "Jucator ID:", "", function(player, user_id)
		user_id = tonumber(user_id)
		if user_id ~= nil and user_id ~= "" then 
			local rows = exports.ghmattimysql:executeSync("SELECT id, warnr1 FROM vrp_users WHERE id = @id", {id = user_id})
			idoff2 = rows[1].id
			motiv1 = rows[1].warnr1

			if motiv1 == "none" then
				vRPclient.notify(player,{"Eroare: Jucatorul are 0 warn-uri"})
			else
				exports.ghmattimysql:execute("UPDATE vrp_users SET warnr1 = @warnr1, warnr2 = @warnr2, warnr3 = @warnr3, warnid1 = @warnid1, warnid2 = @warnid2, warnid3 = @warnid3, warns = 0 WHERE id = @user_id", {
					['@user_id'] = user_id, 
					['@warnr1'] = "none", 
					['@warnr2'] = "none", 
					['@warnr3'] = "none", 
					['@warnid1'] = "none", 
					['@warnid2'] = "none", 
					['@warnid3'] = "none"
				}, function()end)
				vRP.setBannedTemp({user_id,false,"","",0})
			end
		else
			vRPclient.notify(player,{"Eroare: Niciun ID selectat"})
		end
	end})
end

local function searchwarn(player,choice)
	local ID = vRP.getUserId({player})
	vRP.prompt({player, "Jucator ID:", "", function(player, user_id)
		user_id = tonumber(user_id)
		if user_id ~= nil and user_id ~= "" then 
			local rows = exports.ghmattimysql:executeSync("SELECT * FROM vrp_users WHERE id = @id", {['@id'] = user_id})
			idoff2 = rows[1].id
			warns = rows[1].warns
			motiv3 = rows[1].warnr3
			motiv2 = rows[1].warnr2
			motiv1 = rows[1].warnr1
			warnid3 = rows[1].warnid3
			warnid2 = rows[1].warnid2
			warnid1 = rows[1].warnid1

			vRP.closeMenu({player})
			SetTimeout(250, function()
		       	vRP.buildMenu({"ID Search", {player = player}, function(menu)
			    	menu.name = "ID Search"
			   	 	menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
					menu.onclose = function(player) vRP.closeMenu({player}) end
					if warns == 0 then
						menu["Nu are warn-uri"] = {none,""}
					end
					if warns >= 1 then
						menu["Warn 1"] = {none,"Nume/ID: <font color='#33b5e5'>"..idoff2.."</font><br>By Admin: <font color='#33b5e5'>"..warnid1.."</font><br>Motiv: <font color='#33b5e5'>"..motiv1.."</font><br>Warn-uri: <font color='#33b5e5'>"..warns.."</font>/<font color='#33b5e5'>3</font>!"}
					end
					if warns >= 2 then
						menu["Warn 2"] = {none,"Nume/ID: <font color='#33b5e5'>"..idoff2.."</font><br>By Admin: <font color='#33b5e5'>"..warnid2.."</font><br>Motiv: <font color='#33b5e5'>"..motiv2.."</font><br>Warn-uri: <font color='#33b5e5'>"..warns.."</font>/<font color='#33b5e5'>3</font>!"}
					end
					if warns >= 3 then
						menu["Warn 3"] = {none,"Nume/ID: <font color='#33b5e5'>"..idoff2.."</font><br>By Admin: <font color='#33b5e5'>"..warnid3.."</font><br>Motiv: <font color='#33b5e5'>"..motiv3.."</font><br>Warn-uri: <font color='#33b5e5'>"..warns.."</font>/<font color='#33b5e5'>3</font>!"}
					end
					vRP.openMenu({player,menu})
		    	end})
			end)
		else
			vRPclient.notify(player,{"Eroare: Niciun ID selectat!"})
		end
	end})
end

vRP.registerMenuBuilder({"admin", function(add, data)
  	local user_id = vRP.getUserId({data.player})
  	if user_id ~= nil then
    	local choices = {}

		if vRP.isUserAdministrator({player}) then
			choices["Warn Reset"] = {resetwarn, "Reseteaza warn-urile + unban"}
		end
		if vRP.isUserModerator({player}) then
			choices["UnWarn Jucator"] = {unwarnp, ""}
		end
		if vRP.isUserHelper({user_id}) then
			choices["Warn Jucator"] = {warnp, ""}
			choices["Warn Search"] = {searchwarn, ""}
		end
	
    	add(choices)
  	end
end})