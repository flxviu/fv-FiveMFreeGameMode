local lang = vRP.lang
local playerMoney = {}
local cfg = module("cfg/money")

local function ch_mapoff(player,choice)
    local user_id = vRP.getUserId(player)
    TriggerClientEvent('alpha:mapoff', player)
end

local function ch_payday(player,choice)
    local user_id = vRP.getUserId(player)
    TriggerClientEvent('alpha:payday', player)
end

local function ch_speedometer(player,choice)
    local user_id = vRP.getUserId(player)
    TriggerClientEvent('alpha:speedo', player)
end

local function ch_anunturi(player,choice)
    local user_id = vRP.getUserId(player)
    TriggerClientEvent('alpha:announces', player)
end

local function ch_viataarmura(player,choice)
    local user_id = vRP.getUserId(player)
    TriggerClientEvent('alpha:viataarmura', player)
end

local function ch_modgrafica(player,choice)
    local user_id = vRP.getUserId(player)
    TriggerClientEvent('alpha:modgrafica', player)
end

local function ch_fpsboost(player,choice)
    local user_id = vRP.getUserId(player)
    TriggerClientEvent('alpha:fpsboost', player)
end

local function ch_oprestetot(player,choice)
    local user_id = vRP.getUserId(player)
    TriggerClientEvent('alpha:mapoff', player)
    TriggerClientEvent('alpha:payday', player)
    TriggerClientEvent('alpha:announces', player)
    TriggerClientEvent('alpha:speedo', player)
    TriggerClientEvent('alpha:viataarmura', player)
end

local hudMenu = {name="Hud",css = {top="75px",header_color="rgba(51, 153, 255,1.0)"}}

RegisterCommand('hud', function(source)
    hudMenu['#Dezactiveaza TOT'] = {function(player,choice)
        TriggerClientEvent('alpha:mapoff', player)
        TriggerClientEvent('alpha:bani', player)
        TriggerClientEvent('alpha:payday', player)
        TriggerClientEvent('alpha:announces', player)
        TriggerClientEvent('alpha:speedo', player)
        TriggerClientEvent('alpha:viataarmura', player)
    end, "<font color='red'>Dezactiveaza</font>/<font color='green'>Activeaza</font> tot ce este mai jos"}
    hudMenu['Anunturi'] = {function(player,choice)
        TriggerClientEvent('alpha:announces', player)
    end, '<font color="red">Dezactiveaza</font>/<font color="green">Activeaza</font> Anunturile'}
    hudMenu['Payday'] = {function(player,choice)
        TriggerClientEvent('alpha:payday', player)
    end, '<font color="red">Dezactiveaza</font>/<font color="green">Activeaza</font> Payday-ul'}
    hudMenu['Speedometer'] = {function(player,choice)
        TriggerClientEvent('alpha:speedo', player)
    end, '<font color="red">Dezactiveaza</font>/<font color="green">Activeaza</font> Speedometer-ul'}
    hudMenu['Mod Grafica'] = {function(player,choice)
        TriggerClientEvent('alpha:modgrafica', player)
    end, '<font color="red">Dezactiveaza</font>/<font color="green">Activeaza</font> Modul de Grafica'}
    hudMenu['Viata/Armura'] = {function(player,choice)
        TriggerClientEvent('alpha:viataarmura', player)
    end, '<font color="red">Dezactiveaza</font>/<font color="green">Activeaza</font> Viata si Armura'}
 
    hudMenu['Harta/Mapa'] = {function(player,choice)
        TriggerClientEvent('alpha:mapoff', player)
    end, '<font color="red">Dezactiveaza</font>/<font color="green">Activeaza</font> Mapa'}
    hudMenu['Hud Bani'] = {function(player,choice)
        local user_id = vRP.getUserId(player)
        if bani then
        vRPclient.removeDiv(source,{"money"})
        vRPclient.removeDiv(source,{"bmoney"})
        vRPclient.removeDiv(source,{"Giftpoints"})
        vRPclient.removeDiv(source,{"donationCoins"})
        bani = false
        vRPclient.notify(player,{"Succes: Ai oprit ~r~Hud-ul de bani"})
    else
        vRPclient.setDiv(source,{"money",cfg.display_css,lang.money.display({vRP.formatMoney(vRP.getMoney(user_id))})})
        vRPclient.setDiv(source,{"bmoney",cfg.display_css,lang.money.bdisplay({vRP.formatMoney(vRP.getBankMoney(user_id))})})
        vRPclient.setDiv(source,{"Giftpoints",cfg.display_css,lang.money.display({vRP.formatMoney(vRP.getGiftpoints(user_id))})})
        vRPclient.setDiv(source,{"donationCoins",cfg.display_css,lang.money.display({vRP.formatMoney(vRP.getdonationCoins(user_id))})})
        bani = true
        vRPclient.notify(player,{"Succes: Ai pornit ~g~Hud-ul de bani"})
        end    
    end, '<font color="red">Dezactiveaza</font>/<font color="green">Activeaza</font> Hud-ul de bani'}
    vRP.openMenu(source,hudMenu)
end)