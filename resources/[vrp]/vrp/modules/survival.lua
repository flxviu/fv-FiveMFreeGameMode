local cfg = module("cfg/survival")
local lang = vRP.lang

-- api

function vRP.getHunger(user_id)
    local data = vRP.getUserDataTable(user_id)
    if data then
        return data.hunger
    end

    return 0
end

function vRP.getThirst(user_id)
    local data = vRP.getUserDataTable(user_id)
    if data then
        return data.thirst
    end

    return 0
end

function vRP.setHunger(user_id,value)
  local data = vRP.getUserDataTable(user_id)
  if data then
    if value then
      data.hunger = value
      if data.hunger < 0 then
        data.hunger = 0
      elseif data.hunger > 100 then
        data.hunger = 100
      end

      -- -- update bar
      local source = vRP.getUserSource(user_id)
      if source ~= nil then
        TriggerClientEvent("lucid:setDependencies", source, (data.thirst or 0), (data.hunger or 0))
      end
    end
  end
end

function vRP.setThirst(user_id,value)
  local data = vRP.getUserDataTable(user_id)
  if data then
    if value then
      data.thirst = value
      if data.thirst < 0 then
        data.thirst = 0
      elseif data.thirst > 100 then
        data.thirst = 100
      end

      -- update bar
      local source = vRP.getUserSource(user_id)
      if source ~= nil then
        TriggerClientEvent("lucid:setDependencies", source, (data.thirst or 0), (data.hunger or 0))
      end
    end
  end
end

function vRP.varyHunger(user_id, variation)
  local data = vRP.getUserDataTable(user_id)
  if data then
    if variation then
      if data.hunger then
        data.hunger = data.hunger + variation

        -- apply overflow as damage
        local overflow = data.hunger-100
        if overflow > 0 then
          vRPclient.varyHealth(vRP.getUserSource(user_id),{-overflow*cfg.overflow_damage_factor})
        end

        if data.hunger < 0 then
          data.hunger = 0
        elseif data.hunger > 100 then
          data.hunger = 100
        end

        -- set progress bar data
        local source = vRP.getUserSource(user_id)
        if source ~= nil then
          TriggerClientEvent("lucid:setDependencies", source, (data.thirst or 0), (data.hunger or 0))
        end
      end
    end
  end
end

function vRP.varyThirst(user_id, variation)
  local data = vRP.getUserDataTable(user_id)
  if data then
    if variation then
      if data.thirst then
        data.thirst = data.thirst + variation

        -- apply overflow as damage
        local overflow = data.thirst-100
        if overflow > 0 then
          vRPclient.varyHealth(vRP.getUserSource(user_id),{-overflow*cfg.overflow_damage_factor})
        end

        if data.thirst < 0 then
          data.thirst = 0
        elseif data.thirst > 100 then
          data.thirst = 100
        end

        -- set progress bar data
        local source = vRP.getUserSource(user_id)
        if source ~= nil then
          TriggerClientEvent("lucid:setDependencies", source, (data.thirst or 0), (data.hunger or 0))
        end
      end
    end
  end
end

-- tunnel api (expose some functions to clients)

function tvRP.varyHunger(variation)
        local user_id = vRP.getUserId(source)
        if user_id ~= nil then
            vRP.varyHunger(user_id, variation)
        end
end

function tvRP.varyThirst(variation)
        local user_id = vRP.getUserId(source)
        if user_id ~= nil then
            vRP.varyThirst(user_id, variation)
        end
end

-- tasks

-- hunger/thirst increase
function task_update()
    for k, v in pairs(vRP.users) do
        vRP.varyHunger(v, cfg.hunger_per_minute)
        vRP.varyThirst(v, cfg.thirst_per_minute)
    end

    SetTimeout(60000, task_update)
end

task_update()

-- handlers

-- init values
AddEventHandler("vRP:playerJoin", function(user_id, source, name, last_login)
    local data = vRP.getUserDataTable(user_id)
    if data.hunger == nil then
        data.hunger = 0
        data.thirst = 0
    end
end)

-- add survival progress bars on spawn
-- AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
--     local data = vRP.getUserDataTable(user_id)
--     vRPclient.setPolice(source, {cfg.police})
--     vRPclient.setFriendlyFire(source, {cfg.pvp})
--     if user_id ~= nil then
--       vRP.setHunger(user_id, data.hunger)
--       vRP.setThirst(user_id, data.thirst)
--     end
-- end)

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
  local data = vRP.getUserDataTable(user_id)
  if data ~= nil then
    vRP.setHunger(user_id, data.hunger)
    vRP.setThirst(user_id, data.thirst)
    TriggerClientEvent("haiper:updateWater", source, {water = data.thirst})
    TriggerClientEvent("haiper:updateHunger", source, {hunger = data.hunger})
  end
end)


local revive_seq = {
  {"amb@medic@standing@kneel@enter","enter",1},
  {"amb@medic@standing@kneel@idle_a","idle_a",1},
  {"amb@medic@standing@kneel@exit","exit",1}
}

local bandaj_seq = {
  {"amb@medic@standing@tendtodead@enter","enter",1},
  {"amb@medic@standing@tendtodead@idle_a","idle_a",1},
  {"amb@medic@standing@tendtodead@exit","exit",1}
}

bandaged = {}
function vRP.useBandaje(player)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRPclient.isInComa(player,{}, function(in_coma)
      if (in_coma == false) then
        if(bandaged[user_id] == nil)then
          if vRP.tryGetInventoryItem(user_id,"bandaj",1,true) then
            vRPclient.playAnim(player,{false,bandaj_seq,false})
            bandaged[user_id] = true
            SetTimeout(5000, function()
              vRPclient.stopAnim(player,{true})
              vRPclient.varyHealth(player,{15})
              vRPclient.notify(player,{"Succes: Ti-ai aplicat un Bandaj si ti-ai revenit cu 15%!"})
              bandaged[user_id] = nil
            end)
          end
        else
          vRPclient.notify(player,{"Eroare: Ti-ai aplicat un bandaj deja!, asteapta 5 secunde"})
          return
        end
      else
        vRPclient.notify(player,{"Eroare: Esti lesinat doar Medicul te poate ajuta!"})
      end
    end)
  end
end

local choice_revive = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRPclient.getNearestPlayer(player,{10},function(nplayer)
      local nuser_id = vRP.getUserId(nplayer)
      if nuser_id ~= nil then
        vRPclient.isInComa(nplayer,{}, function(in_coma)
          if in_coma then
            if vRP.tryGetInventoryItem(user_id,"medkit",1,true) then
              vRPclient.playAnim(player,{false,revive_seq,false}) -- anim
              SetTimeout(15000, function()
                vRPclient.varyHealth(nplayer,{50}) -- heal 50
              end)
            end
          else
            vRPclient.notify(player,{lang.emergency.menu.revive.not_in_coma()})
          end
        end)
      else
        vRPclient.notify(player,{lang.common.no_player_near()})
      end
    end)
  end
end,lang.emergency.menu.revive.description()}

-- add choices to the main menu (emergency)
vRP.registerMenuBuilder("jucator", function(add, data)
  local user_id = vRP.getUserId(data.player)
  if user_id ~= nil then
    local choices = {}

    if vRP.isUserInFaction(user_id,"Smurd") then
      choices[lang.emergency.menu.revive.title()] = choice_revive
    end

    add(choices)
  end
end)