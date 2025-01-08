local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","krimes_scoreboard")
vRPCscr = Tunnel.getInterface("krimes_scoreboard","krimes_scoreboard")
vRPscr = {}
Tunnel.bindInterface("krimes_scoreboard",vRPscr)
Proxy.addInterface("krimes_scoreboard",vRPscr)


playerlist = {}

function vRPscr.getScoreboardInformations()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local hours = vRP.getUserHoursPlayed({user_id})
    local jucatori = vRP.getUsers{}
    -- id = user_id
    -- users = #oameni
    vRPCscr.openscoreboard(player,{playerlist})
end


ems = 0
police = 0
fbi = 0
mafie = 0

function insertInScoreboard(jucator, user_id)
	factiune = "Civil"
	admin = 0
	local vip = 0
	numeNab = "Nume"

	local jucator = vRP.getUserSource({user_id})
	local factiune2 = vRP.getUserFaction{user_id}
	
	if vRP.isUserInFaction({user_id,"Smurd"})  then
		factiune = "Smurd"
		ems = ems + 1
	elseif vRP.isUserInFaction({user_id,"SRI"})  then
		factiune = "SRI"
		police = police + 1
	elseif vRP.isUserInFaction({user_id,"Politie"})  then
		factiune = "Politist"
		police = police + 1
	elseif vRP.getFactionType({factiune2}) == "Mafie" then
		factiune = "Mafiot"
		mafie = mafie + 1		
	end
	
	numeNab = vRP.getPlayerName({jucator})
	
	if(numeNab)then
		if(string.len(numeNab)>14)then
			newnumeNab = ""
			for i = 1, string.len(numeNab) do
				if(i <= 14)then
					newnumeNab = newnumeNab..string.sub(numeNab, i, i)
				end
			end
			numeNab = newnumeNab.."..."
		end
	end

	
	job = vRP.getUserFaction({user_id})
	if job == nil or job == "" then
		job = "Somer"
	end
	ore = vRP.getUserHoursPlayed({user_id})
	local useriOn = vRP.getUsers({user_id})
    users = #useriOn
    countJucatori = 0
    for k,v in pairs(useriOn) do
        countJucatori = countJucatori + 1
    end     
	playerlist[user_id] = {tostring(numeNab),tostring(factiune),tonumber(ore),tonumber(countJucatori), 1}
	
end

function uninitPlayer(user_id, jucator)
	if vRP.isUserInFaction({user_id,"Smurd"})  then
		ems = ems - 1
	elseif vRP.isUserInFaction({user_id,"SRI"})  then
		police = police - 1
	elseif vRP.isUserInFaction({user_id,"Politie"})  then
		police = police - 1
	end
	playerlist[user_id] = nil
end

AddEventHandler("vRP:playerSpawn",function(user_id, hours, jucatori, source, first_spawn)
	insertInScoreboard(source, user_id, hours, jucatori)
end)

AddEventHandler("vRP:playerLeave", function(user_id, source)
	if playerlist[user_id] ~= nil then
		uninitPlayer(user_id, source)
	end
end)

local function fixeazaUsaKrestine()
	playerlist = {}
	ems = 0
	police = 0
	users = vRP.getUsers({})
	for i, v in pairs(users) do
		jucator = v
		user_id = tonumber(i)

		if vRP.getPlayerName({jucator}) ~= "unknown" and vRP.getPlayerName({jucator}) ~= "Unknown" and vRP.getPlayerName({jucator}) ~= "username" and vRP.getPlayerName({jucator}) ~= "Username" and vRP.getPlayerName({jucator}) then
			insertInScoreboard(jucator, user_id)
		end
	end
end

RegisterCommand("scr", function() fixeazaUsaKrestine() end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(20000)
		fixeazaUsaKrestine()
	end
end)
