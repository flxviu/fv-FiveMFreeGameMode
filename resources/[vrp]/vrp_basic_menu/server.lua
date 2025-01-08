local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local htmlEntities = module("vrp", "lib/htmlEntities")

vRPbm = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_basic_menu")
BMclient = Tunnel.getInterface("vRP_basic_menu", "vRP_basic_menu")
vRPbsC = Tunnel.getInterface("vRP_barberShop", "vRP_basic_menu")
Tunnel.bindInterface("vRP_basic_menu", vRPbm)

local Lang = module("vrp", "lib/Lang")
local cfg = module("vrp", "cfg/base")
local lang = Lang.new(module("vrp", "cfg/lang/" .. cfg.lang) or {})

-- teleport waypoint
local choice_tptowaypoint = {function(player, choice)
    TriggerClientEvent("TpToWaypoint", player)
end, "Teleporteaza-te La Point-ul Setat."}

--toggle blips
local ch_blips = {function(player, choice)
    TriggerClientEvent("showBlips", player)
    vRP.sendStaffMessage({"^1Staff: ^0Admin-ul ^1" .. vRP.getPlayerName({player}) .. " ^0a folosit blips"})
end, "Porneste Blip-surile."}

local jucator_check = {function(player, choice)
        
        vRPclient.getNearestPlayer(player, {5}, function(nplayer)
            local nuser_id = vRP.getUserId({nplayer})
            if nuser_id ~= nil then
                TriggerClientEvent("perc", player)
                vRPclient.notify(nplayer, {lang.police.menu.check.checked()})
                vRPclient.getWeapons(nplayer, {}, function(weapons)
                        -- prepare display data (money, items, weapons)
                        local money = vRP.getMoney({nuser_id})
                        local items = ""
                        local data = vRP.getUserDataTable({nuser_id})
                        if data and data.inventory then
                            for k, v in pairs(data.inventory) do
                                local item_name = vRP.getItemName({k})
                                local item_desc = vRP.getKeyDesc({k})
                                if item_desc ~= nil and (not string.match(item_desc, "WEAPON_")) then
                                    item_name = item_name .. " [" .. item_desc .. "]"
                                end
                                if item_name then
                                    items = items .. "<br />" .. item_name .. " (" .. v.amount .. ")"
                                end
                            end
                        end
                        
                        local weapons_info = ""
                        for k, v in pairs(weapons) do
                            weapons_info = weapons_info .. "<br />" .. k .. " (" .. v.ammo .. ")"
                        end
                        
                        vRPclient.setDiv(player, {"police_check", ".div_police_check{ background-color: rgba(0,0,0,0.75); color: white; font-weight: bold; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }", lang.police.menu.check.info({money, items, weapons_info})})
                        -- request to hide div
                        vRP.request({player, lang.police.menu.check.request_hide(), 1000, function(player, ok)
                            vRPclient.removeDiv(player, {"police_check"})
                            TriggerClientEvent("removeperc", player)
                        end})
                end)
            else
                vRPclient.notify(player, {lang.common.no_player_near()})
            end
        end)
end, lang.police.menu.check.description()}

hacktimes = {}
local ch_hack = {function(player, choice)
    local user_id = vRP.getUserId({player})
    if user_id ~= nil then
        vRPclient.getNearestPlayer(player, {25}, function(nplayer)
            if nplayer ~= nil then
                local nuser_id = vRP.getUserId({nplayer})
                if nuser_id ~= nil then
                    if (hacktimes[user_id] == nil) then
                        vRPclient.notify(player, {"~r~Hack: ~w~Asteapta 10 secunde!"})
                        hacktimes[user_id] = true
                        local nbank = vRP.getBankMoney({nuser_id})
                        local amount = math.floor(nbank * 0.01)
                        local nvalue = nbank - amount
                        SetTimeout(10000, function()
                            if math.random(1, 100) == 1 then
                                vRP.setBankMoney({nuser_id, nvalue})
                                vRPclient.notify(nplayer, {"~r~Info: ~w~Ai hackuit ~r~" .. amount .. "$"})
                                vRPclient.notify(player, {"~r~Info: ~w~Cineva te-a hackuit cu ~r~" .. amount .. "$"})
                                vRP.giveInventoryItem({user_id, "dirty_money", amount, true})
                            else
                                vRPclient.notify(nplayer, {"~r~Info: ~w~Cineva a incercat sa te hackuiasca!"})
                                vRPclient.notify(player, {"~r~Info: ~w~Metoda esuata!"})
                            end
                            hacktimes[user_id] = nil
                        end)
                    else
                        vRPclient.notify(player, {"Eroare: ~w~Ai hackuit deja pe cineva!"})
                        return
                    end
                else
                    vRPclient.notify(player, {lang.common.no_player_near()})
                end
            else
                vRPclient.notify(player, {lang.common.no_player_near()})
            end
        end)
    end
end, "Hack-uieste Cel Mai Apropiat Om."}

local ch_drag = {function(player, choice)
    local user_id = vRP.getUserId({player})
    if user_id ~= nil then
        vRPclient.getNearestPlayer(player, {10}, function(nplayer)
            if nplayer ~= nil then
                local nuser_id = vRP.getUserId({nplayer})
                if nuser_id ~= nil then
                    vRPclient.isHandcuffed(nplayer, {}, function(handcuffed)
                        if handcuffed then
                            TriggerClientEvent("dr:drag", nplayer, player)
                        else
                            vRPclient.notify(player, {"Eroare: ~w~Jucatorul nu este incatusat."})
                        end
                    end)
                else
                    vRPclient.notify(player, {lang.common.no_player_near()})
                end
            else
                vRPclient.notify(player, {lang.common.no_player_near()})
            end
        end)
    end
end, "Ia pe sus cel mai apropiat jucator."}

clearInv = {}
local clear_inventory = {function(player, choice)
    local user_id = vRP.getUserId({player})
    if user_id ~= nil then
        vRP.prompt({player, "Lucid", "[STERGE si scrie 'DA' pentru a ARUNCA TOT DIN INVENTAR]", function(player, answer)
            answer = tostring(answer)
            if (string.lower(answer) == "da") then
                vRPclient.isInComa(player, {}, function(in_coma)
                    if in_coma then
                        vRPclient.notify(player, {"Eroare: ~w~Esti in coma, nu poti folosi aceasta functie."})
                    else
                        if (clearInv[user_id] == nil) then
                            vRPclient.notify(player, {"Succes: ~w~Inventarul tau se va sterge intr-un minut!"})
                            clearInv[user_id] = true
                            SetTimeout(60000, function()
                                vRP.clearInventory({user_id})
                                vRPclient.notify(player, {"Succes: ~w~Inventarul tau a fost curatat cu succes."})
                                clearInv[user_id] = nil
                            end)
                        else
                            vRPclient.notify(player, {"Eroare: ~w~Ai folosit deja aceasta functie!"})
                            return
                        end
                    end
                end)
            end
        end})
    end
end}

local reload_skin = {function(source, choice)
    local user_id = vRP.getUserId({source})
    if user_id ~= nil then
        vRPclient.isInComa(source, {}, function(in_coma)
            if in_coma then
                vRPclient.notify(source, {"Eroare: Nu poti folosi optiunea fix skin in timp ce esti mort!"})
            else
                TriggerClientEvent("raid_clothes:incarcaHainele", source)
                TriggerClientEvent('chatMessage', source, "^4Succes: ^0Ai reincarcat skin-ul!")
            end
        end)
    end
end}

RegisterCommand('fixskin', function(source, choice)
    local user_id = vRP.getUserId({source})
    if user_id ~= nil then
        vRPclient.isInComa(source, {}, function(in_coma)
            if in_coma then
                vRPclient.notify(source, {"Eroare: Nu poti folosi optiunea fix skin in timp ce esti mort!"})
            else
                TriggerClientEvent("raid_clothes:incarcaHainele", source)
                TriggerClientEvent('chatMessage', source, "^4Succes: ^0Ai reincarcat skin-ul!")
            end
        end)
    end
end)

-- armor item
vRP.defInventoryItem({"body_armor", "Armura", "Armura de grad mare si calitate foarte buna, protectoare!", function()
    local choices = {}
    choices["Echipeaza"] = {function(player, choice)
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
            if vRP.tryGetInventoryItem({user_id, "body_armor", 1, true}) then
                BMclient.setArmour(player, {100, true})
                vRP.closeMenu({player})
            end
        end
    end}
    return choices
end, 5.00, "pocket"})

local unjailed = {}
function jail_clock(target_id, timer)
    local target = vRP.getUserSource({tonumber(target_id)})
    local users = vRP.getUsers({})
    local online = false
    for k, v in pairs(users) do
        if tonumber(k) == tonumber(target_id) then
            online = true
        end
    end
    
    if online then
        if timer > 0 then
            vRPclient.notify(target, {"Info: ~w~Timp ramas: " .. timer .. " minute."})
            vRP.setUData({tonumber(target_id), "vRP:jail:time", json.encode(timer)})
            SetTimeout(60 * 1000, function()
                for k, v in pairs(unjailed) do -- check if player has been unjailed by cop or admin
                    if v == tonumber(target_id) then
                        unjailed[v] = nil
                        timer = 0
                    end
                end
                vRP.setHunger({tonumber(target_id), 0})
                vRP.setThirst({tonumber(target_id), 0})
                jail_clock(tonumber(target_id), timer - 1)
            end)
        else
            BMclient.loadFreeze(target, {true})
            SetTimeout(15000, function()
                BMclient.loadFreeze(target, {false})
            end)
            vRPclient.teleport(target, {426.78323364258, -977.98498535156, 30.710720062256})-- teleport to outside jail
            vRPclient.setHandcuffed(target, {false})
            vRPclient.notify(target, {"Succes: ~w~Ai fost eliberat in libertate."})
            vRP.setUData({tonumber(target_id), "vRP:jail:time", json.encode(-1)})
        end
    end
end

-- player store weapons
local store_weapons_cd = {}
function storeWeaponsCooldown()
    for user_id, cd in pairs(store_weapons_cd) do
        if cd > 0 then
            store_weapons_cd[user_id] = cd - 1
        end
    end
    SetTimeout(1000, function()
        storeWeaponsCooldown()
    end)
end
storeWeaponsCooldown()
local choice_store_weapons = {function(player, choice)
    local user_id = vRP.getUserId({player})
    if (store_weapons_cd[user_id] == nil or store_weapons_cd[user_id] == 0) and user_id ~= nil then
        store_weapons_cd[user_id] = 5
        vRPclient.notify(player, {"Info: Asteapta 1 minut pana vei primi armele."})
        SetTimeout(60000, function()
            vRPclient.getWeapons(player, {}, function(weapons)
                    
                    for k, v in pairs(weapons) do
                        vRP.giveInventoryItem({user_id, "wbody|" .. k, 1, true})
                        exports.oxmysql:execute("UPDATE vrp_arme SET inventar = 1 WHERE user_id = @user_id AND hash = @hash", {
                            ['@user_id'] = user_id,
                            ['@hash'] = k
                        }, function(rows)
                        end)
                        if v.ammo > 0 then
                            vRP.giveInventoryItem({user_id, "wammo|" .. k, v.ammo, true})
                        end
                    end
            end)
            -- clear all weapons
            vRPclient.giveWeapons(player, {{}, true})
        end)
    else
        vRPclient.notify(player, {"Eroare: ~w~Deja ai strans armele!"})
    end
end, lang.police.menu.store_weapons.description()}

local ch_fixhair = {function(player, choice)
    local custom = {}
    local user_id = vRP.getUserId({player})
    vRP.getUData({user_id, "vRP:head:overlay", function(value)
        if value ~= nil then
            custom = json.decode(value)
            vRPbsC.setOverlay(player, {custom, true})
        end
        TriggerClientEvent('chatMessage', player, "^1Succes: ^0Ai reincarcat parul!")
    end})
end, "Repara parul daca cumva este buguit."}

RegisterCommand('fixhair', function(player, choice)
    local custom = {}
    local user_id = vRP.getUserId({player})
    vRP.getUData({user_id, "vRP:head:overlay", function(value)
        if value ~= nil then
            custom = json.decode(value)
            vRPbsC.setOverlay(player, {custom, true})
        end
        TriggerClientEvent('chatMessage', player, "^1Succes: ^0Ai reincarcat parul!")
    end})
end)

local ch_clearskin = {function(player, choice)
    TriggerClientEvent('clearskin:success', player)
    TriggerClientEvent('chatMessage', player, "^2Succes: ^0Ai curatat skin-ul!")
end, "Clear Skin"}

RegisterCommand('clearskin', function(player, choice)
    TriggerClientEvent('clearskin:success', player)
    TriggerClientEvent('chatMessage', player, "^2Succes: ^0Ai curatat skin-ul!")
end)

RegisterCommand('cleanskin', function(player, choice)
    TriggerClientEvent('clearskin:success', player)
    TriggerClientEvent('chatMessage', player, "^2Succes: ^0Ai curatat skin-ul!")
end)
-------------------Puscarie Admin J-------------------
function setInAJail(user_id, minutes, reason)
    local thePlayer = vRP.getUserSource({user_id})
    if (reason == nil or reason == "") then
        reason = " "
    end
    BMclient.setInAJail(thePlayer, {minutes, reason})
    vRPclient.teleport(thePlayer, {38.469585418701,-373.44845581055,45.501087188721})
    exports["oxmysql"]:execute("UPDATE vrp_users SET aJailTime = @aJailTime, aJailReason = @aJailReason WHERE id = @user_id", {["aJailTime"] = minutes, ["aJailReason"] = reason, ["user_id"] = user_id}, function(data) end)
end

function setInAJailOffline(user_id, jTime, reason)
    if (reason == nil or reason == "") then
        reason = " "
    end
    exports["oxmysql"]:execute("UPDATE vrp_users SET aJailTime = @aJailTime, aJailReason = @aJailReason WHERE id = @user_id", {
        aJailTime = jTime,
        aJailReason = reason,
        user_id = user_id
    })
end

function vRPbm.updateCheckpoints(check)
    local thePlayer = source
    local user_id = vRP.getUserId({thePlayer})
    exports["oxmysql"]:execute('SELECT * FROM vrp_users WHERE id = @user_id', {["user_id"] = user_id}, function(rows)
        if #rows > 0 then
            local aJailReason = tostring(rows[1].aJailReason)
            if (tonumber(check) == 0) then
                vRPclient.notify(thePlayer, {"Succes: ~w~Ai terminat toate checkpoint-urile!"})
                vRPclient.setHandcuffed(thePlayer, {false})
                if (reason == nil or reason == "") then
                    reason = " "
                end
                exports["oxmysql"]:execute("UPDATE vrp_users SET aJailTime = @aJailTime, aJailReason = @aJailReason WHERE id = @user_id", {["aJailTime"] = 0, ["aJailReason"] = aJailReason, ["user_id"] = user_id}, function(data) end)
                vRPclient.teleport(thePlayer, {429.63381958008, -980.81530761719, 30.711225509644})
            else
                if (aJailReason == nil or aJailReason == "") then
                    aJailReason = " "
                end
                exports["oxmysql"]:execute("UPDATE vrp_users SET aJailTime = @aJailTime, aJailReason = @aJailReason WHERE id = @user_id", {["aJailTime"] = check, ["aJailReason"] = aJailReason, ["user_id"] = user_id}, function(data) end)
                vRPclient.setHandcuffed(thePlayer, {false})
            end
        end
    end)
end

local locatiijail = {
    [1] = {cds = vec3(37.651180267334, -378.12350463867, 45.500659942627), anim = "WORLD_HUMAN_HAMMERING", active = false},
    [2] = {cds = vec3(33.523391723633, -387.50469970703, 45.50065612793), anim = "WORLD_HUMAN_HAMMERING", active = false},
    [3] = {cds = vec3(35.077743530273, -392.96105957031, 45.557441711426), anim = "WORLD_HUMAN_PUSH_UPS", active = false},
    [4] = {cds = vec3(23.885292053223, -391.6086730957, 45.552837371826), anim = "WORLD_HUMAN_CONST_DRILL", active = false},
    [5] = {cds = vec3(22.989177703857, -402.85577392578, 45.558940887451), anim = "WORLD_HUMAN_PUSH_UPS", active = false},
    [6] = {cds = vec3(30.466842651367, -408.77795410156, 45.558990478516), anim = "WORLD_HUMAN_CONST_DRILL", active = false},
    [7] = {cds = vec3(37.230903625488, -411.25369262695, 45.559005737305), anim = "WORLD_HUMAN_PUSH_UPS", active = false},
    [8] = {cds = vec3(40.709945678711, -418.66925048828, 45.558986663818), anim = "WORLD_HUMAN_HAMMERING", active = false},
    [9] = {cds = vec3(41.013259887695, -426.77713012695, 45.557758331299), anim = "WORLD_HUMAN_CONST_DRILL", active = false},
    [10] = {cds = vec3(38.218269348145, -436.90460205078, 45.557800292969), anim = "WORLD_HUMAN_PUSH_UPS", active = false},
    [11] = {cds = vec3(34.016830444336, -440.71838378906, 45.557750701904), anim = "WORLD_HUMAN_CONST_DRILL", active = false},
    [12] = {cds = vec3(26.982534408569, -440.96856689453, 45.557750701904), anim = "WORLD_HUMAN_HAMMERING", active = false},
    [13] = {cds = vec3(23.214284896851, -447.11703491211, 45.557754516602), anim = "WORLD_HUMAN_PUSH_UPS", active = false},
    [14] = {cds = vec3(18.558139801025, -439.9592590332, 45.557754516602), anim = "WORLD_HUMAN_CONST_DRILL", active = false},
    [15] = {cds = vec3(22.957201004028, -427.63931274414, 45.557846069336), anim = "WORLD_HUMAN_PUSH_UPS", active = false},
    [16] = {cds = vec3(30.161100387573, -420.23104858398, 45.551197052002), anim = "WORLD_HUMAN_HAMMERING", active = false},
    [17] = {cds = vec3(29.488548278809, -412.34429931641, 45.558933258057), anim = "WORLD_HUMAN_CONST_DRILL", active = false},
    [18] = {cds = vec3(34.740715026855, -400.22348022461, 45.629718780518), anim = "WORLD_HUMAN_HAMMERING", active = false},
    [19] = {cds = vec3(34.06787109375, -390.19244384766, 45.557388305664), anim = "WORLD_HUMAN_CONST_DRILL", active = false},
}

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    local target = vRP.getUserSource({user_id})
    local user_id = vRP.getUserId({target})
    
    SetTimeout(2000, function()
        TriggerClientEvent("ajail:config", source, locatiijail)
        exports["oxmysql"]:execute('SELECT * FROM vrp_users WHERE id = @user_id', {["user_id"] = user_id}, function(rows)
            if #rows > 0 then
                local aJailTime = tonumber(rows[1].aJailTime)
                local aJailReason = tostring(rows[1].aJailReason)
                if (aJailTime > 0) then
                    setInAJail(tonumber(user_id), tonumber(aJailTime), tostring(aJailReason))
                    vRPclient.setHandcuffed(user_id, {false})
                end
            end
        end)
    end)
end)

local a_jail = {function(player, choice)
    vRP.prompt({player, "ID:", "", function(player, target_id)
        if target_id ~= nil and target_id ~= "" then
            vRP.prompt({player, "Checkpointuri:", "", function(player, jail_time)
                if jail_time ~= nil and jail_time ~= "" then
                    vRP.prompt({player, "Motiv:", "", function(player, jail_reason)
                        if jail_reason ~= nil and jail_reason ~= "" then
                            local target = vRP.getUserSource({tonumber(target_id)})
                            local ped = GetPlayerPed(target)
                            local entity = GetVehiclePedIsIn(ped)
                            if target ~= nil then
                                if tonumber(jail_time) > 500 then
                                    jail_time = 500
                                end
                                if tonumber(jail_time) < 1 then
                                    jail_time = 1
                                end
                                DeleteEntity(entity)
                                Wait(1)
                                vRPclient.teleport(target, {38.469585418701,-373.44845581055,45.501087188721})-- teleport to inside jail
                                TriggerClientEvent('chatMessage', -1, "", {0, 0, 0}, "^4Lucid: ^0Admin-ul ^1" .. GetPlayerName(player) .. " ^0i-a dat lui ^1" .. GetPlayerName(target) .. " ^0[^1" .. target_id .. "^0] " .. jail_time .. " (de) jail checkpoint-uri")
                                TriggerClientEvent('chatMessage', -1, "", {0, 0, 0}, "^4Motiv: ^0" .. jail_reason)
                                vRPclient.notify(player, {"Succes: ~w~L-ai bagat in jail pe ~b~ " .. GetPlayerName(target) .. ""})
                                vRPclient.notify(player, {"~w~Checkpoint-uri: ~b~" .. jail_time})
                                vRPclient.notify(player, {"~w~Motiv: ~b~" .. jail_reason})
                                vRP.closeMenu({player})
                                vRP.setHunger({tonumber(target_id), 0})
                                vRP.setThirst({tonumber(target_id), 0})
                                setInAJail(tonumber(target_id), tonumber(jail_time), tostring(jail_reason))
                            end
                        else
                            vRPclient.notify(player, {"Eroare: ~w~Motiv invalid!"})
                        end
                    end})
                else
                    vRPclient.notify(player, {"Eroare: ~w~Checkpoint-urile nu pot fi mai putin de 1!"})
                end
            end})
        else
            vRPclient.notify(player, {"Eroare: ~w~Acest ID este Invalid!"})
        end
    end})
end, "Da jail unui jucator"}

local a_unjail = {function(player, choice)
    vRP.prompt({player, "ID:", "", function(player, target_id)
        if target_id ~= nil and target_id ~= "" then
            local target = vRP.getUserSource({tonumber(target_id)})
            if target ~= nil then
                exports["oxmysql"]:execute('SELECT * FROM vrp_users WHERE id = @user_id', {["user_id"] = target_id}, function(rows)
                    local aJailTime = tonumber(rows[1].aJailTime)
                    if (aJailTime == 0) then
                        vRPclient.notify(player, {"Eroare: ~w~Jucatorul nu este in ~b~Admin Jail!"})
                    else
                        setInAJail(tonumber(target_id), tonumber(0), tostring(" "))
                        vRPclient.setHandcuffed(target, {false})
                        vRPclient.teleport(target, {429.63381958008, -980.81530761719, 30.711225509644})
                        vRPclient.notify(target, {"Succes: ~w~Ai primit unjail!"})
                        vRPclient.notify(player, {"Succes: ~w~L-ai scos pe ~b~" .. GetPlayerName(target) .. " ~w~de la Admin Jail"})
                        TriggerClientEvent("chatMessage", -1, "^4Lucid: ^0Admin-ul ^1" .. GetPlayerName(player) .. "^0 i-a dat unjail lui ^1" .. GetPlayerName(target))
                    end
                end)
            else
                vRPclient.notify(player, {"Eroare: ~w~Acest ID este Invalid!"})
            end
        else
            vRPclient.notify(player, {"Eroare: ~w~Nu ai selectat un ID!"})
        end
    end})
end, "Scoate jail-ul unui jucator"}

local a_offlineJail = {function(player, choice)
    local user_id = vRP.getUserId({player})
    vRP.prompt({player, "ID:", "", function(player, target_id)
        if target_id ~= nil and target_id ~= "" then
            exports.oxmysql:execute("SELECT aJailTime FROM vrp_users WHERE id = @user_id", {["@user_id"] = target_id}, function(rows)
                if #rows == 0 then
                    vRPclient.notify(player, {"Eroare: ~w~Acest jucator nu exista!"})
                else
                    vRP.prompt({player, "Checkpointuri:", "", function(player, jail_time)
                        if jail_time ~= nil and jail_time ~= "" then
                            vRP.prompt({player, "Motiv:", "", function(player, jail_reason)
                                if jail_reason ~= nil and jail_reason ~= "" then
                                    local target = vRP.getUserSource({tonumber(target_id)})
                                    if target ~= nil then
                                        if tonumber(jail_time) > 500 then
                                            jail_time = 500
                                        end
                                        if tonumber(jail_time) < 1 then
                                            jail_time = 1
                                        end
                                        setInAJailOffline(tonumber(target_id), tonumber(jail_time), jail_reason)
                                        TriggerClientEvent('chatMessage', -1, "", {0, 0, 0}, "^4Lucid: ^0Admin-ul ^1" .. GetPlayerName(player) .. " ^0i-a dat lui ^1" .. GetPlayerName(target) .. " ^0[^1" .. target_id .. "^0] " .. jail_time .. " (de) jail checkpoint-uri")
                                        TriggerClientEvent('chatMessage', -1, "", {0, 0, 0}, "^4Motiv: ^0" .. jail_reason)
                                        vRPclient.notify(player, {"Succes: ~w~L-ai bagat in jail pe ~b~ " .. GetPlayerName(target) .. ""})
                                        vRPclient.notify(player, {"~w~Checkpoint-uri: ~b~" .. jail_time})
                                        vRPclient.notify(player, {"~w~Motiv: ~b~" .. jail_reason})
                                    end
                                end
                            end})
                        end
                    end})
                end
            end)
        end
    end})
end, "Da jail unui jucator offline"}
-------------------Puscarie Admin J-------------------
-- dynamic jail
local ch_jail = {function(player, choice)
    vRPclient.getNearestPlayers(player, {15}, function(nplayers)
        local user_list = ""
        for k, v in pairs(nplayers) do
            user_list = user_list .. "[" .. vRP.getUserId({k}) .. "]" .. vRP.getPlayerName({k}) .. " | "
        end
        if user_list ~= "" then
            vRP.prompt({player, "Jucatori Apropiati:" .. user_list, "", function(player, target_id)
                if target_id ~= nil and target_id ~= "" then
                    vRP.prompt({player, "Inchisoare Timp Luni:", "", function(player, jail_time)
                        if tonumber(jail_time) and jail_time ~= nil and jail_time ~= "" then
                            local target = vRP.getUserSource({tonumber(target_id)})
                            if target ~= nil then
                                if ((tonumber(jail_time) >= 60) and (jail_time ~= nil) and (jail_time ~= "")) then
                                    jail_time = 60
                                end
                                if ((tonumber(jail_time) <= 1) and (jail_time ~= nil) and (jail_time ~= "")) then
                                    jail_time = 1
                                end
                                
                                vRPclient.isHandcuffed(target, {}, function(handcuffed)
                                    if handcuffed then
                                        BMclient.loadFreeze(target, {true})
                                        SetTimeout(4000, function()
                                            BMclient.loadFreeze(target, {false})
                                        end)
                                        local celula = math.random(1, 10)
                                        if celula == 1 then
                                            vRPclient.teleport(target, {1641.5477294922, 2570.4819335938, 45.564788818359})
                                        elseif celula == 2 then
                                            vRPclient.teleport(target, {1650.9091796875, 2570.326171875, 45.56481552124})
                                        elseif celula == 3 then
                                            vRPclient.teleport(target, {1629.4643554688, 2569.84375, 45.564834594727})
                                        elseif celula == 4 then
                                            vRPclient.teleport(target, {1641.5477294922, 2570.4819335938, 45.564788818359})
                                        elseif celula == 5 then
                                            vRPclient.teleport(target, {1650.9091796875, 2570.326171875, 45.56481552124})
                                        elseif celula == 6 then
                                            vRPclient.teleport(target, {1629.4643554688, 2569.84375, 45.564834594727})
                                        elseif celula == 7 then
                                            vRPclient.teleport(target, {1641.5477294922, 2570.4819335938, 45.564788818359})
                                        elseif celula == 8 then
                                            vRPclient.teleport(target, {1650.9091796875, 2570.326171875, 45.56481552124})
                                        elseif celula == 9 then
                                            vRPclient.teleport(target, {1629.4643554688, 2569.84375, 45.564834594727})
                                        elseif celula == 10 then
                                            vRPclient.teleport(target, {1641.5477294922, 2570.4819335938, 45.564788818359})
                                        end
                                        vRPclient.notify(target, {"Succes: ~w~Ai fost trimis la puscarie"})
                                        vRPclient.notify(player, {"Succes: ~w~L-ai bagat la puscarie pe (~b~" .. target_id .. "~w~) pentru ~b~" .. jail_time .. " ~w~Minute"})
                                        vRP.setHunger({tonumber(target_id), 0})
                                        vRP.setThirst({tonumber(target_id), 0})
                                        jail_clock(tonumber(target_id), tonumber(jail_time))
                                        local user_id = vRP.getUserId({player})
                                    else
                                        vRPclient.notify(player, {"Eroare: ~w~Acel jucator nu este incatusat."})
                                    end
                                end)
                            else
                                vRPclient.notify(player, {"Eroare: ~w~Acel ID este invalid."})
                            end
                        else
                            vRPclient.notify(player, {"Eroare: ~w~Timp-ul la inchisoare nu poate fi gol."})
                        end
                    end})
                else
                    vRPclient.notify(player, {"Eroare: ~w~Nici un jucator ID selectat."})
                end
            end})
        else
            vRPclient.notify(player, {"Eroare: ~w~Nici un jucator apropiat."})
        end
    end)
end, "Trimite un jucator la puscarie."}

-- dynamic unjail
local ch_unjail = {function(player, choice)
    vRP.prompt({player, "Jucator ID:", "", function(player, target_id)
        if target_id ~= nil and target_id ~= "" then
            vRP.getUData({tonumber(target_id), "vRP:jail:time", function(value)
                if value ~= nil then
                    custom = json.decode(value)
                    if custom ~= nil then
                        local user_id = vRP.getUserId({player})
                        if ((tonumber(custom) > 0) and (custom ~= nil) and (custom ~= "")) then
                            local target = vRP.getUserSource({tonumber(target_id)})
                            if target ~= nil then
                                unjailed[target] = tonumber(target_id)
                                vRPclient.notify(player, {"Succes: ~w~Jucatorul va fi eliberat in curand."})
                                vRPclient.notify(target, {"Succes: ~w~Cineva te-a salvat de la puscarie."})
                            else
                                vRPclient.notify(player, {"Eroare: ~w~Acel ID este invalid."})
                            end
                        else
                            vRPclient.notify(player, {"Eroare: ~w~Jucatorul nu este la puscarie."})
                        end
                    end
                end
            end})
        else
            vRPclient.notify(player, {"Eroare: ~w~Nici un jucator ID selectat."})
        end
    end})
end, "Elibereaza un jucator."}

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    local target = vRP.getUserSource({user_id})
    SetTimeout(2000, function()
        local rows = exports.oxmysql:executeSync("SELECT `aJailTime`, `aJailReason` FROM vrp_users WHERE id = @user_id", {user_id = user_id})
        if #rows > 0 then
            local aJailTime = tonumber(rows[1].aJailTime)
            local aJailReason = tostring(rows[1].aJailReason)
            if (aJailTime > 0) and (aJailTime ~= nil) then
                BMclient.setInAJail(source, {aJailTime, aJailReason})
                vRPclient.setInEvent(target, {true})
            end
        end
    end)
    SetTimeout(5000, function()
        local custom = {}
        vRP.getUData({user_id, "vRP:jail:time", function(value)
            if value ~= nil then
                custom = json.decode(value)
                if custom ~= nil then
                    if tonumber(custom) > 0 then
                        BMclient.loadFreeze(target, {true})
                        SetTimeout(15000, function()
                            BMclient.loadFreeze(target, {false})
                        end)
                        vRPclient.setHandcuffed(target, {true})
                        vRPclient.teleport(target, {1688.3275146484, 2518.7783203125, -120.84991455078})-- teleport inside jail
                        vRPclient.notify(target, {"Eroare: ~w~Termina sentinta."})
                        vRP.setHunger({tonumber(user_id), 0})
                        vRP.setThirst({tonumber(user_id), 0})
                        jail_clock(tonumber(user_id), tonumber(custom))
                    end
                end
            end
        end})
    end)
end)

-- dynamic fine
local ch_fine = {function(player, choice)
    vRPclient.getNearestPlayers(player, {15}, function(nplayers)
        local user_list = ""
        for k, v in pairs(nplayers) do
            user_list = user_list .. "[" .. vRP.getUserId({k}) .. "]" .. vRP.getPlayerName({k}) .. " | "
        end
        if user_list ~= "" then
            vRP.prompt({player, "Jucatori Apropiati:" .. user_list, "", function(player, target_id)
                if target_id ~= nil and target_id ~= "" then
                    vRP.prompt({player, "Amenda Suma:", "100", function(player, fine)
                        if tonumber(fine) and fine ~= nil and fine ~= "" then
                            vRP.prompt({player, "Amenda Motiv:", "", function(player, reason)
                                if reason ~= nil and reason ~= "" then
                                    local target = vRP.getUserSource({tonumber(target_id)})
                                    if target ~= nil then
                                        if ((tonumber(fine) >= 10000000) and (fine ~= nil) and (fine ~= "")) then
                                            fine = 10000000
                                        end
                                        if ((tonumber(fine) <= 100) and (fine ~= nil) and (fine ~= "")) then
                                            fine = 100
                                        end
                                        if vRP.tryFullPayment({tonumber(target_id), tonumber(fine)}) then
                                            vRP.insertPoliceRecord({tonumber(target_id), lang.police.menu.fine.record({reason, fine})})
                                            vRPclient.notify(player, {lang.police.menu.fine.fined({reason, fine})})
                                            vRPclient.notify(target, {lang.police.menu.fine.notify_fined({reason, fine})})
                                            local user_id = vRP.getUserId({player})
                                            vRP.closeMenu({player})
                                        else
                                            vRPclient.notify(player, {lang.money.not_enough()})
                                        end
                                    else
                                        vRPclient.notify(player, {"Eroare: ~w~Acel ID este invalid"})
                                    end
                                else
                                    vRPclient.notify(player, {"Eroare: ~w~Nu poti amenda degeaba fara motiv"})
                                end
                            end})
                        else
                            vRPclient.notify(player, {"Eroare: ~w~Amenda ta trebuie sa fie o valoare"})
                        end
                    end})
                else
                    vRPclient.notify(player, {"Eroare: ~w~Nici un jucator ID selectat"})
                end
            end})
        else
            vRPclient.notify(player, {"Eroare: ~w~Nici un jucator apropiat"})
        end
    end)
end, "Amenda un jucator apropiat."}

local ch_spawnveh = {function(player, choice)
    local user_id = vRP.getUserId({player})
    vRP.prompt({player, "Model Vehicul:", "", function(player, model)
        if model ~= nil and model ~= "" then
            BMclient.spawnVehicle(player, {model})
            vRP.sendStaffMessage({"^1Staff: ^0Admin-ul ^1" .. vRP.getPlayerName({player}) .. " ^0a spawnat modelul ^1" .. model .. "^0"})
        else
            vRPclient.notify(player, {"Eroare: ~w~Trebuie sa pui un model de vehicul."})
        end
    end})
end, "Spawneaza un model vehicul."}

local a_revive = {function(player, choice)
    vRP.prompt({player, "ID:", "", function(player, target_id)
        if target_id ~= nil and target_id ~= "" then
            local nplayer = vRP.getUserSource({tonumber(target_id)})
            if nplayer ~= nil then
                vRPclient.isInComa(nplayer, {}, function(in_coma)
                    if in_coma then
                        vRPclient.varyHealth(nplayer, {100})
                        SetTimeout(1000, function()
                            vRPclient.varyHealth(nplayer, {100})
                        end)
                        vRP.sendStaffMessage({"^4Lucid: ^0Admin-ul ^4" .. vRP.getPlayerName({player}) .. " ^0i-a dat revive lui ^4" .. vRP.getPlayerName({nplayer}) .. " (" .. target_id .. ")"})
                    else
                        vRPclient.notify(player, {"Eroare: ~w~Jucatorul nu este in coma."})
                    end
                end)
            else
                vRPclient.notify(player, {"Eroare: ~w~Acest ID pare invalid."})
            end
        else
            vRPclient.notify(player, {"Eroare: ~w~Nu ai selectat niciun ID."})
        end
    end})
end}

local muted = {}

local a_mute = {function(player, choice)
    vRP.prompt({player, "Player ID:", "", function(player, target_id)
        if target_id ~= nil and target_id ~= "" then
            local nplayer = vRP.getUserSource({tonumber(target_id)})
            if nplayer then
                vRP.prompt({player, "Time:", "", function(player, minutes)
                    if (tonumber(minutes)) then
                        vRP.prompt({player, "Motiv:", "", function(player, reason)
                            if (tostring(reason)) then
                                if (muted[nplayer] == nil) then
                                    muted[nplayer] = nplayer
                                    TriggerClientEvent('chatMessage', -1, "^4Lucid: ^1" .. GetPlayerName(nplayer) .. " ^0a primit mute ^1" .. minutes .. " ^0minute de la ^1" .. GetPlayerName(player))
                                    TriggerClientEvent('chatMessage', -1, "^4Motiv: ^0" .. reason)   
                                    SetTimeout(minutes * 60000, function()
                                        if (muted[nplayer] ~= nil) then
                                            muted[nplayer] = nil
                                            TriggerClientEvent('chatMessage', nplayer, "^1Failed: ^0Mute-ul ti-a expirat!")
                                        end
                                    
                                    end)
                                else
                                    TriggerClientEvent('chatMessage', player, "^1Failed: ^0Jucatorul are deja mute!")
                                end
                            else
                                vRPclient.notify(player, {"~r~Failed"})
                            end
                        end})
                    end
                end})
            else
                vRPclient.notify(player, {"Eroare: ~w~Player-ul nu a fost gasit"})
            end
        else
            vRPclient.notify(player, {"Eroare: ~w~Nu ai selectat un player"})
        end
    end})
end, "Da mute la un player"}

local a_unmute = {function(player, choice)
    vRP.prompt({player, "Player ID:", "", function(player, target_id)
        if target_id ~= nil and target_id ~= "" then
            local nplayer = vRP.getUserSource({tonumber(target_id)})
            if nplayer then
                if (muted[nplayer] ~= nil) then
                    TriggerClientEvent('chatMessage', -1, "^4Lucid: ^1" .. GetPlayerName(nplayer) .. " ^0a primit unmute de la ^1" .. GetPlayerName(player))
                    muted[nplayer] = nil
                else
                    vRPclient.notify(player, {"Eroare: ~w~Player-ul nu are mute"})
                end
            else
                vRPclient.notify(player, {"Eroare: ~w~Nu a fost gasit player-ul"})
            end
        else
            vRPclient.notify(player, {"Eroare: ~w~Nu ai selectat niciun id"})
        end
    end})
end, "Unmute a player."}


AddEventHandler('chatMessage', function(thePlayer, color, message)
    if (muted[thePlayer] ~= nil) then
        TriggerClientEvent('chatMessage', thePlayer, "^1Failed ^0Nu poti vorbii ai mute !")
        CancelEvent()
    end
end)

RegisterCommand('arevive', function(source, args, msg)
    local user_id = vRP.getUserId({source})
    msg = msg:sub(9)
    if msg:len() >= 1 then
        msg = tonumber(msg)
        local target = vRP.getUserSource({msg})
        if target ~= nil then
            local target_id = vRP.getUserId({target})
            if vRP.isUserTrialHelper({user_id}) then
                vRPclient.varyHealth(target, {100})
                
                vRP.sendStaffMessage({"^4Lucid: ^0Admin-ul ^1" .. vRP.getPlayerName({source}) .. " ^0i-a dat revive lui ^1" .. vRP.getPlayerName({target}) .. " (" .. target_id .. ")"})
            else
                TriggerClientEvent('chatMessage', source, "^1Info: ^0Nu ai acces la aceasta comanda.")
            end
        else
            TriggerClientEvent('chatMessage', source, "^1Info: ^0Player-ul nu este conectat.")
        end
    else
        TriggerClientEvent('chatMessage', source, "^1Info: ^0/arevive <user-id>")
    end
end)

vRP.registerMenuBuilder({"admin", function(add, data)
    local user_id = vRP.getUserId({data.player})
    if user_id ~= nil then
        local choices = {}
        
        if vRP.isUserDeveloper({user_id}) then
            choices["SpawnVeh"] = ch_spawnveh
        end
        if vRP.isUserDeveloper({user_id}) then
            choices["Blips"] = ch_blips
        end
        if vRP.isUserSuperModerator({user_id}) then
            choices["TpToWaypoint"] = choice_tptowaypoint
        end
        if vRP.isUserTrialHelper({user_id}) then
            choices["Admin Jail"] = a_jail
            choices["Admin Revive"] = a_revive
            choices["Mute"] = a_mute
            choices["Admin UnJail"] = a_unjail
            choices["Admin Jail Offline"] = a_offlineJail
            choices["UnMute"] = a_unmute
        end
        if vRP.hasPermission({user_id, "supporter.menu"}) then
            choices["Revive Supporter"] = a_revive
        end
        
        add(choices)
    end
end})

vRP.registerMenuBuilder({"jucator", function(add, data)
    local user_id = vRP.getUserId({data.player})
    if user_id ~= nil then
        local choices = {}
        
        choices[lang.police.menu.check.title()] = jucator_check
        choices["Fix Hair"] = ch_fixhair
        choices["Clear Skin"] = ch_clearskin
        choices["Curata Inventar"] = clear_inventory
        choices["Fix Skin"] = reload_skin
        
        if vRP.hasGroup({user_id, "Specialist Arme"}) then
            choices["Strange Armele"] = choice_store_weapons
        end
        
        add(choices)
    end
end})

vRP.registerMenuBuilder({"police", function(add, data)
    local user_id = vRP.getUserId({data.player})
    if user_id ~= nil then
        local choices = {}
        
        if vRP.hasGroup({user_id, "onduty"}) then
            if vRP.isUserInFaction({user_id, "Politie"}) or vRP.isUserInFaction({user_id, "DIICOT"}) then
                choices["Trimite la inchisoare"] = ch_jail
                choices["Scoate de la inchisoare"] = ch_unjail
                choices["Amendeaza"] = ch_fine
            end
            if vRP.isUserInFaction({user_id, "Politie"}) or vRP.isUserInFaction({user_id, "DIICOT"}) then
                choices["Ridica"] = ch_drag
            end
            add(choices)
        end
    end
end})

local usedrugscooldown = {}
vRP.defInventoryItem({"adrenalina","Adrenalina","", 
function(args)
  local choices = {} 
  choices["Foloseste"] = {function(player,choice)
local user_id = vRP.getUserId({player})
if not usedrugscooldown[user_id] then usedrugscooldown[user_id] = 0 end

if (os.time() - usedrugscooldown[user_id]) < 60 then 
	vRPclient.notify(player,{"Eroare: Asteapta "..(60 - (os.time() - usedrugscooldown[user_id])).." secunde pentru a consuma adrenalina"})
	return
else
	vRPclient.isInComa(player,{}, function(in_coma)
	  if not in_coma then
		if vRP.tryGetInventoryItem({user_id, "adrenalina", 1, "Folosesti adrenalina"}) then
		TriggerClientEvent('3dme:shareDisplay', -1, "~w~Isi administreaza o seringa de ~b~adrenalina~w~", source)
		   vRPclient.varyHealth(player,{50})
		   vRP.varyHunger({user_id, -100})
		   vRP.varyThirst({user_id, -100})
		   usedrugscooldown[user_id] = os.time()
		end
	  else
		vRPclient.notify(player, {"Eroare: Esti mort!"})
	  end
	end)
end
  end}
  return choices
end,
0.1})

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    usedrugscooldown[user_id] = 0
end)