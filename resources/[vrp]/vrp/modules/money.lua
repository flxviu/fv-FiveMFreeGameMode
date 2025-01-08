local lang = vRP.lang
local playerMoney = {}
local cfg = module("cfg/money")

function round(n)
	return n % 1 >= 0.5 and math.ceil(n) or math.floor(n)
end

-- get money
-- cbreturn nil if error
function vRP.getMoney(user_id)
	if(playerMoney[user_id])then
		return playerMoney[user_id].wallet
	else
		return 0
	end
end

-- set Giftpoints
function vRP.setGiftpoints(user_id,value)

	if(playerMoney[user_id])then
		playerMoney[user_id].Giftpoints = value
	end
	exports.oxmysql:execute("UPDATE vrp_users SET Giftpoints = @Giftpoints WHERE id = @user_id", {Giftpoints = value, user_id = user_id}, function()end)

	local source = vRP.getUserSource(user_id)
	if source ~= nil then

		TriggerClientEvent('hud:updateThings', source, 'giftBoxes', value)
	end
end

function vRP.setdonationCoins(user_id,value)

	if(playerMoney[user_id])then
		playerMoney[user_id].donationCoins = value
	end
	exports.oxmysql:execute("UPDATE vrp_users SET donationCoins = @donationCoins WHERE id = @user_id", {donationCoins = value, user_id = user_id}, function()end)

	local source = vRP.getUserSource(user_id)
	if source ~= nil then
		TriggerClientEvent('hud:updateThings', source, 'coins', vRP.getdonationCoins(user_id))
	end
end

-- get Giftpoints
-- cbreturn nil if error
function vRP.getGiftpoints(user_id)
	if(playerMoney[user_id])then
		return playerMoney[user_id].Giftpoints
	else
		return 0
	end
end

function vRP.getdonationCoins(user_id)
	if(playerMoney[user_id])then
		return playerMoney[user_id].donationCoins
	else
		return 0
	end
end

-- set money
function vRP.setMoney(user_id,value)
	if(tonumber(value) >= 0)then
		if(playerMoney[user_id])then
			playerMoney[user_id].wallet = value
		end
		exports.oxmysql:execute("UPDATE vrp_users SET walletMoney = @wallet WHERE id = @user_id", {wallet = value, user_id = user_id}, function()end)
	end

  -- update client display
  local source = vRP.getUserSource(user_id)
  if source ~= nil then
	TriggerClientEvent('hud:updateThings', source, 'money', vRP.getMoney(user_id))
  end

  if(tonumber(value) >= 300000000 and tonumber(vRP.getUserHoursPlayed(user_id)) <= 2)then 
		vRP.sendStaffMessage("^1ATENTIE: ID "..user_id.." a depasit suma 300.000.000$ in mana. Are "..value.."$ la mai putin de 2 ore. Daca ti se pare suspect du-te la el!")
	end

	if(tonumber(value) > 400000000 and tonumber(vRP.getUserHoursPlayed(user_id)) < 3)then 
		vRP.sendStaffMessage("^1ATENTIE: ID "..user_id.." a depasit suma 400.000.000$ in mana. Are "..value.."$ la mai putin de 2 ore. Daca ti se pare suspect du-te la el!")
	end

	if(tonumber(value) > 800000000 and tonumber(vRP.getUserHoursPlayed(user_id)) < 10)then 
		vRP.sendStaffMessage("^1ATENTIE: ID "..user_id.." a depasit suma 800.000.000$ in mana. Are "..value.."$ la mai putin de 10 ore. Daca ti se pare suspect du-te la el!")
	end

	if(tonumber(vRP.getUserHoursPlayed(user_id)) > 1000)then 
		vRP.setBanned(user_id,true,1,"Suspect hours hack", "Iepurila")
		DropPlayer(source, "Banat de Bugs Bunny > Suspect hours inject")
	end
end

function vRP.takeMoney(user_id,amount)
	local money = vRP.getMoney(user_id)
	local newBani = money - amount
	vRP.setMoney(user_id,newBani)
	vRPclient.arataTranzactie(vRP.getUserSource(user_id), {"minus", amount})
end

function vRP.takeCoins(user_id,amount)
	local coins = vRP.getGiftpoints(user_id)
	local sallmane = coins - amount
	vRP.setGiftpoints(user_id,sallmane)
	vRPclient.arataTranzactie(vRP.getUserSource(user_id), {"minus", amount})
end

function vRP.takeDonationCoins(user_id,amount)
	local coins = vRP.getdonationCoins(user_id)
	local sallmane = coins - amount
	vRP.setdonationCoins(user_id,sallmane)
	vRPclient.arataTranzactie(vRP.getUserSource(user_id), {"minus", amount})
end

function vRP.getTransferLimit(user_id)
    return 10000000
end

-- set transfer limit 
function vRP.setTransferLimit(user_id,value)
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp then
		tmp.transfer_limit = value
	end
end

-- try a payment
-- return true or false (debited if true)
function vRP.tryPayment(user_id,amount)
  local money = vRP.getMoney(user_id)
  if (money >= amount) and (amount >= 0) then
    vRP.setMoney(user_id,money-amount)
	vRPclient.arataTranzactie(vRP.getUserSource(user_id), {"minus", amount})
    return true
  else
    return false
  end
end

function vRP.tryPaymentCoins(user_id,amount)
	local Giftpoints = vRP.getGiftpoints(user_id)
	if (Giftpoints >= amount) and (amount >= 0) then
	  vRP.setGiftpoints(user_id,Giftpoints-amount)
	  vRPclient.arataTranzactie(vRP.getUserSource(user_id), {"minus", amount})
	  return true
	else
	  return false
	end
end

function vRP.tryPaymentDonationCoins(user_id,amount)
	local donationCoins = vRP.getdonationCoins(user_id)
	if (donationCoins >= amount) and (amount >= 0) then
	  vRP.setdonationCoins(user_id,donationCoins-amount)
	  vRPclient.arataTranzactie(vRP.getUserSource(user_id), {"minus", amount})
	  return true
	else
	  return false
	end
end

-- give money
function vRP.giveMoney(user_id,amount)
  local money = vRP.getMoney(user_id)
  vRP.setMoney(user_id,money+amount)
	vRPclient.arataTranzactie(vRP.getUserSource(user_id), {"plus", amount})
end

-- give Giftpoints
function vRP.giveGiftpoints(user_id,amount)
  local Giftpoints = vRP.getGiftpoints(user_id)
  vRP.setGiftpoints(user_id,Giftpoints+amount)
  vRPclient.arataTranzactie(vRP.getUserSource(user_id), {"plus", amount})
end

function vRP.givedonationCoins(user_id,amount)
  local donationCoins = vRP.getdonationCoins(user_id)
  vRP.setdonationCoins(user_id,donationCoins+amount)
  vRPclient.arataTranzactie(vRP.getUserSource(user_id), {"plus", amount})
end

-- get bank money
function vRP.getBankMoney(user_id)
	if(playerMoney[user_id])then
		return playerMoney[user_id].bank
	else
		return 0
	end
end

-- set bank money
function vRP.setBankMoney(user_id,value)
	if(playerMoney[user_id])then
		playerMoney[user_id].bank = value
	end
	exports.oxmysql:execute("UPDATE vrp_users SET bankMoney = @bank WHERE id = @user_id", {bank = value, user_id = user_id}, function()end)
	local source = vRP.getUserSource(user_id)
	if source ~= nil then
		TriggerClientEvent('hud:updateThings', source, 'bank', vRP.getBankMoney(id))
	end

	if(tonumber(value) >= 300000000 and tonumber(vRP.getUserHoursPlayed(user_id)) <= 2)then 
		vRP.sendStaffMessage("^1ATENTIE: ID "..user_id.." a depasit suma 300.000.000$ in banca. Are "..value.."$ la mai putin de 2 ore. Daca ti se pare suspect du-te la el!")
	end

	if(tonumber(value) > 400000000 and tonumber(vRP.getUserHoursPlayed(user_id)) < 3)then 
		vRP.setBanned(user_id,true,1,"Suspect money hack", "Iepurila")
		DropPlayer(source, "Banat de Bugs Bunny > Suspect money inject")
	end

	if(tonumber(value) > 800000000 and tonumber(vRP.getUserHoursPlayed(user_id)) < 10)then 
		vRP.setBanned(user_id,true,1,"Suspect money hack", "Iepurila")
		DropPlayer(source, "Banat de Bugs Bunny > Suspect money inject")
	end

	if(tonumber(vRP.getUserHoursPlayed(user_id)) > 1000)then 
		vRP.setBanned(user_id,true,1,"Suspect hours hack", "Iepurila")
		DropPlayer(source, "Banat de Bugs Bunny > Suspect hours inject")
	end
end

-- give bank money
function vRP.giveBankMoney(user_id,amount)
  if amount > 0 then
    local money = vRP.getBankMoney(user_id)
    vRP.setBankMoney(user_id,money+amount)
	vRPclient.arataTranzactie(vRP.getUserSource(user_id), {"plus", amount})
  end
end

-- try a withdraw
-- return true or false (withdrawn if true)
function vRP.tryWithdraw(user_id,amount)
  local money = vRP.getBankMoney(user_id)
  if amount > 0 and money >= amount then
    vRP.setBankMoney(user_id,money-amount)
    vRP.giveMoney(user_id,amount)
	vRPclient.arataTranzactie(vRP.getUserSource(user_id), {"minus", amount})
    return true
  else
    return false
  end
end

-- try a deposit
-- return true or false (deposited if true)
function vRP.tryDeposit(user_id,amount)
  if amount > 0 and vRP.tryPayment(user_id,amount) then
    vRP.giveBankMoney(user_id,amount)
	vRPclient.arataTranzactie(vRP.getUserSource(user_id), {"minus", amount})
    return true
  else
    return false
  end
end

function vRP.tryFullPayment(user_id,amount)
	local money = vRP.getMoney(user_id)
	if money >= amount  and (amount >= 0) then -- enough, simple payment
	  return vRP.tryPayment(user_id, amount)
		else  -- not enough, withdraw -> payment
	  if vRP.tryWithdraw(user_id, amount-money) then -- withdraw to complete amount
		vRPclient.arataTranzactie(vRP.getUserSource(user_id), {"minus", amount})
		return vRP.tryPayment(user_id, amount)
	  end
	end
  
	return false
end

-- events, init user account if doesn't exist at connection
AddEventHandler("vRP:playerJoin",function(user_id,source,name,last_login)
	local rows = exports.oxmysql:executeSync("SELECT bankMoney, walletMoney, Giftpoints, donationCoins FROM vrp_users WHERE id = @user_id", {user_id = user_id})
	if #rows > 0 then
		playerMoney[user_id] = {bank = rows[1].bankMoney, wallet = rows[1].walletMoney, Giftpoints = rows[1].Giftpoints, donationCoins = rows[1].donationCoins}
	end
end)

AddEventHandler("vRP:playerLeave",function(user_id,source)
	playerMoney[user_id] = nil
end)


   
local function ch_give(player,choice)
	-- get nearest player
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
	  vRPclient.getNearestPlayer(player,{10},function(nplayer)
		if nplayer ~= nil then
		  local nuser_id = vRP.getUserId(nplayer)
		  if nuser_id ~= nil then
			-- prompt number
			vRP.prompt(player,lang.money.give.prompt(),"",function(player,amount)
			  local amount = parseInt(amount)
			  local transfer_limit = vRP.getTransferLimit(user_id)
			  if amount > 0 and vRP.tryPayment(user_id,amount) then
				vRP.giveMoney(nuser_id,amount)
				vRPclient.notify(player,{lang.money.given({amount})})
				vRPclient.notify(nplayer,{lang.money.received({amount})})
			 else
				vRPclient.notify(player,{lang.money.not_enough()})
			end
			end)
		  else
			vRPclient.notify(player,{lang.common.no_player_near()})
		  end
		else
		  vRPclient.notify(player,{lang.common.no_player_near()})
		end
	  end)
	end
  end
  
  local  function choice_askid(player,choice)
	vRPclient.getNearestPlayer(player,{10},function(nplayer)
	  if nplayer ~= nil then
		local nuser_id = vRP.getUserId(nplayer)
		if nuser_id ~= nil then
		  vRPclient.notify(player,{lang.police.menu.askid.asked()})
		  vRP.request(nplayer,lang.police.menu.askid.request(),15,function(nplayer,ok)
			if ok then
			  vRP.getUserIdentity(nuser_id, function(identity)
				if identity then
				  local name = identity.name
				  local firstname = identity.firstname
				  local age = identity.age
				  TriggerClientEvent("ples-id:showBuletin", player, {
					nume = firstname,
					prenume = name,
					age = age,
					usr_id = nuser_id,
					target = nplayer
				  })
				end
			  end)
			else
			  vRPclient.notify(player,{lang.common.request_refused()})
			end
		  end)
		else
		  vRPclient.notify(player,{lang.common.no_player_near()})
		end
	  end
	end)
end
  
vRP.registerMenuBuilder("jucator", function(add, data)
  local user_id = vRP.getUserId(data.player)
  if user_id ~= nil then
    local choices = {}
    choices[lang.money.give.title()] = {ch_give, lang.money.give.description()}

    add(choices)
  end
end)


vRP.registerMenuBuilder("jucator", function(add, data)
  local user_id = vRP.getUserId(data.player)
  if user_id ~= nil then
    local choices = {}
		choices['Cere Buletinul'] = {choice_askid,'Cere buletinul celui mai apropriat jucator'}
    add(choices)
  end
end)


vRP.registerMenuBuilder("main", function(add, data)
  local user_id = vRP.getUserId(data.player)
  if user_id ~= nil then
    local choices = {}

    -- build admin menu
    choices["Interactiuni"] = {function(player,choice)
      vRP.buildMenu("jucator", {player = player}, function(menu)
        menu.name = "Jucator"
        menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
        menu.onclose = function(player) vRP.closeMenu(player) end -- nest menu

        vRP.openMenu(player,menu)
      end)
    end}

    add(choices)
  end
end)

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
    if not first_spawn then return end;
    SetTimeout(2500, function()
        TriggerClientEvent("ples-hud:Bani", true)
        TriggerClientEvent("ples-hud:Logo", true)

        TriggerClientEvent("hud:updateThings",source,"money",vRP.formatMoney(vRP.getMoney(user_id)))
        TriggerClientEvent("hud:updateThings",source,"bank",vRP.formatMoney(vRP.getBankMoney(user_id)))
        
        TriggerClientEvent("hud:updateThings",-1,"online",vRP.formatMoney(GetNumPlayerIndices()))
        TriggerClientEvent("hud:updateThings",source,"userid",vRP.formatMoney(user_id))
    end)
end)

Citizen.CreateThread(function()
    while true do Wait(3000)
        TriggerClientEvent("hud:updateThings",-1,"online",vRP.formatMoney(GetNumPlayerIndices()))
    end
end)
