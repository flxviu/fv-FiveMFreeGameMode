local lang = vRP.lang
local cfg = module("cfg/police")

function vRP.insertPoliceRecord(user_id, line)
   if not user_id then return end
   vRP.getUData(user_id, "vRP:police_records", function(data)
   local records = data..line.."<br />"
   vRP.setUData(user_id, "vRP:police_records", records)
   end)
end
local menu_pc = {name=lang.police.pc.title(),css={top="75px",header_color="rgba(0,125,255,0.75)"}}
local function pc_leave(source,area)
   vRP.closeMenu(source)
end
local choice_mitarrest = {function(player,choice)
vRPclient.getNearestPlayer(player,{10},function(nplayer)
local nuser_id = vRP.getUserId(nplayer)
if nuser_id ~= nil then
   TriggerClientEvent('mita:arrestonway', nplayer, player)
   TriggerClientEvent('radu:arrest', player)
   Citizen.Wait(5000)
   vRPclient.toggleHandcuff(nplayer,{})
else
   vRPclient.notify(player,{"Nu e nimeni prin preajma boule"})
end
end)
end, "Aresteaza fraieru"}


---- Pune jucatoru in masina
local choice_putinveh = {function(player,choice)
vRPclient.getNearestPlayer(player,{10},function(nplayer)
if nplayer ~= nil then
   local nuser_id = vRP.getUserId(nplayer)
   if nuser_id ~= nil then
      vRPclient.isHandcuffed(nplayer,{}, function(handcuffed)  -- check handcuffed
      if handcuffed then
         vRPclient.putInNearestVehicleAsPassenger(nplayer, {5})
      else
         vRPclient.notify(player,{lang.police.not_handcuffed()})
      end
      end)
   else
      vRPclient.notify(player,{lang.common.no_player_near()})
   end
end
end)
end,lang.police.menu.putinveh.description()}

---- Scoate jucatoru din masina
local choice_getoutveh = {function(player,choice)
vRPclient.getNearestPlayer(player,{10},function(nplayer)
if nplayer ~= nil then
   local nuser_id = vRP.getUserId(nplayer)
   if nuser_id ~= nil then
      vRPclient.isHandcuffed(nplayer,{}, function(handcuffed)  -- check handcuffed
      if handcuffed then
         vRPclient.ejectVehicle(nplayer, {})
      else
         vRPclient.notify(player,{lang.police.not_handcuffed()})
      end
      end)
   else
      vRPclient.notify(player,{lang.common.no_player_near()})
   end
end
end)
end,lang.police.menu.getoutveh.description()}

---- Cere Buletinul
local choice_askid = {function(player,choice)
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
end, lang.police.menu.askid.description()}

---- Perchizitioneaza
local choice_check = {function(player,choice)
vRPclient.getNearestPlayer(player,{5},function(nplayer)
if nplayer ~= nil then
   local nuser_id = vRP.getUserId(nplayer)
   if nuser_id ~= nil then
      vRPclient.isHandcuffed(nplayer,{},function(handcuffed)
      if handcuffed then
         vRPclient.notify(nplayer,{lang.police.menu.check.checked()})
         vRPclient.getWeapons(nplayer,{},function(weapons)
         -- prepare display data (money, items, weapons)
         local money = vRP.getMoney(nuser_id)
         local items = ""
         local data = vRP.getUserDataTable(nuser_id)
         if data and data.inventory then
            for k,v in pairs(data.inventory) do
               local item = vRP.items[k]
               if item then
                  items = items.."<br />"..item.name.." ("..v.amount..")"
               end
            end
         end

         local weapons_info = ""
         for k,v in pairs(weapons) do
            weapons_info = weapons_info.."<br />"..k.." ("..v.ammo..")"
         end

         vRPclient.setDiv(player,{"police_check",".div_police_check{ background-color: rgba(0,0,0,0.75); color: white; font-weight: bold; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",lang.police.menu.check.info({money,items,weapons_info})})
         -- request to hide div
         vRP.request(player, lang.police.menu.check.request_hide(), 1000, function(player,ok)
         vRPclient.removeDiv(player,{"police_check"})
         end)
         end)
      else
         vRPclient.notify(player,{"~r~Nu este incatusat!"})
      end
      end)
   else
      vRPclient.notify(player,{lang.common.no_player_near()})
   end
end
end)
end, lang.police.menu.check.description()}
-- Confisca armele
local choice_seize_weapons = {function(player, choice)
local user_id = vRP.getUserId(player)
if user_id ~= nil then
   vRPclient.getNearestPlayer(player, {5}, function(nplayer)
   if nplayer ~= nil then
      local nuser_id = vRP.getUserId(nplayer)
      if nuser_id ~= nil and vRP.isUserInFaction(user_id,"Politie") or vRP.isUserInFaction(user_id,"SWAT") or vRP.isUserInFaction(user_id,"S.R.I") then
         vRPclient.isHandcuffed(nplayer,{},function(handcuffed)
         if handcuffed then
            vRPclient.getWeapons(nplayer,{},function(weapons)
            for k,v in pairs(weapons) do -- display seized weapons
            end
            vRPclient.giveWeapons(nplayer,{{},true})
            vRPclient.notify(player,{'[~r~Paketaxo~w~] Ai confiscat cu ~g~succes~w~ armele!'})
            vRPclient.notify(nplayer,{'~r~Armele tale au fost confiscate!'})
            end)
         else
            vRPclient.notify(player,{lang.police.not_handcuffed()})
         end
         end)
      else
         vRPclient.notify(player,{lang.common.no_player_near()})
      end
   end
   end)
end
end, lang.police.menu.seize.weapons.description()}
-- Confisca obiecte ilegale
local choice_seize_items = {function(player, choice)
local user_id = vRP.getUserId(player)
if user_id ~= nil then
   vRPclient.getNearestPlayer(player, {5}, function(nplayer)
 
      local nuser_id = vRP.getUserId(nplayer)
      if nuser_id ~= nil and vRP.isUserInFaction(user_id,"Politie") or vRP.isUserInFaction(user_id,"SWAT") or vRP.isUserInFaction(user_id,"S.R.I") then
         vRPclient.isHandcuffed(nplayer,{}, function(handcuffed)  -- check handcuffed
         if handcuffed then
            for k,v in pairs(cfg.seizable_items) do -- transfer seizable items
               local amount = vRP.getInventoryItemAmount(nuser_id,v)
               if amount > 0 then
                  local item = vRP.items[v]
                  if item then -- do transfer
                     if vRP.tryGetInventoryItem(nuser_id,v,amount,true) then
                        -- vRP.giveInventoryItem(user_id,v,amount,false)
                        vRPclient.notify(player,{lang.police.menu.seize.seized({item.name,amount})})
                        --vRPclient.notify(nplayer,{lang.police.menu.seize.seized({item.name,amount})})
                     end
                  end
               end
            end
         else
            vRPclient.notify(player,{lang.police.not_handcuffed()})
         end
         end)
      else
         vRPclient.notify(player,{lang.common.no_player_near()})
      end
   end)
end
end, lang.police.menu.seize.items.description()}

-- Ofera permis
local choice_givePermis = {function(player,choice)
local user_id = vRP.getUserId(player)
vRPclient.getNearestPlayer(player,{10},function(nplayer)
local nuser_id = vRP.getUserId(nplayer)
if nuser_id ~= nil then
   vRP.request(player,"Esti sigur ca vrei sa oferi permisul jucatorului: ["..nuser_id.."] ?",15,function(nplayer2,ok)
   if ok then
    vRP.giveInventoryItem(user_id,"Permis",1,false)
      exports.oxmysql:execute("UPDATE vrp_users SET permis='1' WHERE id = @id", {id = nuser_id}, function()end)
      vRPclient.notify(nplayer,{"Un politist ti-a dat permisul de conducere!"})
   else
   end
   end)
else
   vRPclient.notify(player,{lang.common.no_player_near()})
end
end)
end,"Ofera permisul jucatorului apropriat"}
-- Cere permis
local choice_askPermis = {function(player,choice)
local user_id = vRP.getUserId(player)
vRPclient.getNearestPlayer(player,{10},function(nplayer)
local nuser_id = vRP.getUserId(nplayer)
if nuser_id ~= nil then
   vRP.request(nplayer,"Vrei sa prezinti permisul?",15,function(nplayer2,ok)
   if ok then
      local rows = exports['oxmysql']:executeSync("SELECT * FROM vrp_users WHERE id = @id AND permis = '1'", {id = nuser_id})
      if #rows > 0 then
         vRP.getUserIdentity(nuser_id, function(identity)
         if identity then
            TriggerClientEvent("ples-id:showPermis", player, {
               nume = identity.firstname,
               prenume = identity.name,
               target = nplayer
            })
         end
         end)
      else
         vRPclient.notify(player,{"Jucatorul".."["..nuser_id.."] nu are permis de conducere!"})
      end
   else
      vRPclient.notify(player,{"Jucatorul".."["..nuser_id.."] a refuzat sa prezinte permisul de conducere!"})
   end
   end)
else
   vRPclient.notify(player,{lang.common.no_player_near()})
end
end)
end,"Verifica permisul jucatorului apropriat"}
-- Confisca permis
local choice_takePermis = {function(player,choice)
local user_id = vRP.getUserId(player)
vRPclient.getNearestPlayer(player,{10},function(nplayer)
local nuser_id = vRP.getUserId(nplayer)
if nuser_id ~= nil then
   vRP.request(player,"Esti sigur ca vrei sa anulezi permisul jucatorului: ["..nuser_id.."] ?",15,function(nplayer2,ok)
   if ok then
      exports.oxmysql:execute("UPDATE vrp_users SET permis='0' WHERE id = @id", {id = nuser_id}, function()end)
      if vRP.tryGetInventoryItem(nuser_id, "permis_dmv", 1, true) then
         vRPclient.notify(nplayer,{"Un politist ti-a confiscat permisul de conducere!"})
         vRPclient.notify(player,{"I-ai Confiscat permisul lui!["..nuser_id.."]"})
      else
         vRPclient.notify(player,{"Jucatorul nu are permmis de conducere"})
      end
   end
   end)
else
   vRPclient.notify(player,{lang.common.no_player_near()})
end
end)
end,"Anuleaza permisul jucatorului apropriat"}

vRP.registerMenuBuilder("main", function(add, data)
   local player = data.player
   local user_id = vRP.getUserId(player)
   if user_id ~= nil then
      local choices = {}
      local theFaction = vRP.getUserFaction(user_id)
      local factionType = vRP.getFactionType(theFaction)
      if factionType == 'Mafie' or factionType == 'Lege' then
         choices[lang.police.title()] = {function(player,choice)
         vRP.buildMenu("police", {player = player}, function(menu)
         menu.name = lang.police.title()
         menu.css = {top="75px",header_color="rgba(0,125,255,0.75)"}
            if factionType == 'Mafie' or factionType == 'Lege' then
               menu[lang.police.menu.putinveh.title()] = choice_putinveh
               menu[lang.police.menu.getoutveh.title()] = choice_getoutveh
               menu[lang.police.menu.check.title()] = choice_check
               menu["Incatuseaza"] = choice_mitarrest
            end
            if factionType == 'Lege' then
               menu["Confisa armele"] = choice_seize_weapons
               menu["Confisa obiectele ilegale"] = choice_seize_items      
               menu["Verifica Permis"] = choice_askPermis
               menu["Confisca Permis"] = choice_takePermis
               menu["Ofera Permis"] = choice_givePermis
            end
             vRP.openMenu(player,menu)
           end)
         end}
      end
      add(choices)
   end
end)