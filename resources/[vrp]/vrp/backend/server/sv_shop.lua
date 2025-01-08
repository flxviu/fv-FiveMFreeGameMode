local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

local vRP = Proxy.getInterface("vRP")
local vRPclient = Tunnel.getInterface("vRP", "vrp_core")

local shopMenu = {name = "Shop", css = {top = "75px", header_color = "rgba(51, 153, 255,1.0)"}}

local buy = function(user_id, price)
    if not user_id then return end;
    if vRP.tryPaymentDonationCoins({user_id, price}) then
        return true
    end
    local source = vRP.getUserSource({user_id})
    TriggerClientEvent('chatMessage', source, '^2Lucid: ^0Nu ai destule ^1Diamante')
    return false
end

local pachete = {
    ['+10 KG'] = {200, function(user_id)
        if buy(user_id, 200) then
            vRPclient.notify(vRP.getUserSource({user_id}), {'Succes: Ai cumparat +10 KG!'})
            TriggerClientEvent('chatMessage', source, '^2Lucid: ^0Jucatorul ^4' .. GetPlayerName(source) .. '^0 a cumparat ^1+10 KG')
            vRP.levelUp({user_id, "physical", "strength"})
        end
    end},
    
    ['1.000.000$'] = {500, function(user_id)
        if buy(user_id, 500) then
            vRP.giveMoney({user_id, 1000000})
            TriggerClientEvent('chatMessage', source, '^2Lucid: ^0Jucatorul ^4' .. GetPlayerName(source) .. '^0 a cumparat ^11.000.000$')
        end
    end},

    ['[Permanent] Vip Bronze'] = {1000, function(user_id)
        local source = vRP.getUserSource({user_id})
        if vRP.isUserVipBronze({user_id}) then
            return vRPclient.notify(source, {'Eroare: Ai deja Vip Bronze'})
        end
        if buy(user_id, 1000) then
            TriggerClientEvent('chatMessage', source, '^2Lucid: ^0Jucatorul ^4' .. GetPlayerName(source) .. '^0 a cumparat ^5Vip Bronze ^0(^9Permanent^0)')
            vRP.setUserVip({user_id, 1, 600})
            vRP.giveMoney({user_id, 25000000})
        end
    end},
    
    ['[Permanent] Vip Silver'] = {2000, function(user_id)
        local source = vRP.getUserSource({user_id})
        if vRP.isUserVipSilver({user_id}) then
            return vRPclient.notify(source, {'Eroare: Ai deja Vip Silver'})
        end
        if buy(user_id, 2000) then
            TriggerClientEvent('chatMessage', source, '^2Lucid: ^0Jucatorul ^4' .. GetPlayerName(source) .. '^0 a cumparat ^0Vip Silver ^0(^9Permanent^0)')
            vRP.setUserVip({user_id, 2, 600})
            vRP.giveMoney({user_id, 35000000})
        end
    end},
    
    
    ['[Permanent] Vip Gold'] = {3000, function(user_id)
        local source = vRP.getUserSource({user_id})
        if vRP.isUserVipGold({user_id}) then
            return vRPclient.notify(source, {'Eroare: Ai deja Vip Gold'})
        end
        if buy(user_id, 3000) then
            TriggerClientEvent('chatMessage', source, '^2Lucid: ^0Jucatorul ^4' .. GetPlayerName(source) .. '^0 a cumparat ^4Vip Gold ^0(^9Permanent^0)')
            vRP.setUserVip({user_id, 3, 600})
            vRP.giveMoney({user_id, 45000000})
        end
    end},
    
    ['[Permanent] Vip Diamond'] = {5000, function(user_id)
        local source = vRP.getUserSource({user_id})
        if vRP.isUserVipDiamond({user_id}) then
            return vRPclient.notify(source, {'Eroare: Ai deja Vip Diamond'})
        end
        if buy(user_id, 5000) then
            TriggerClientEvent('chatMessage', source, '^2Lucid: ^0Jucatorul ^4' .. GetPlayerName(source) .. '^0 a cumparat ^3Vip Diamond ^0(^9Permanent^0)')
            vRP.setUserVip({user_id, 4, 600})
            vRP.giveMoney({user_id, 55000000})
        end
    end},
    
    ['[Permanent] Vip Emerald'] = {10000, function(user_id)
        local source = vRP.getUserSource({user_id})
        if vRP.isUserVipEmerald({user_id}) then
            return vRPclient.notify(source, {'Eroare: Ai deja Vip Emerald'})
        end
        if buy(user_id, 10000) then
            TriggerClientEvent('chatMessage', source, '^2Lucid: ^0Jucatorul ^4' .. GetPlayerName(source) .. '^0 a cumparat ^1Vip Emerald ^0(^9Permanent^0)')
            vRP.setUserVip({user_id, 5, 600})
            vRP.giveMoney({user_id, 65000000})
        end
    end},
    
    ['[30 Zile] Vip Bronze'] = {500, function(user_id)
        local source = vRP.getUserSource({user_id})
        if vRP.isUserVipBronze({user_id}) then
            return vRPclient.notify(source, {'Eroare: Ai deja Vip Bronze'})
        end
        if buy(user_id, 500) then
            TriggerClientEvent('chatMessage', source, '^2Lucid: ^0Jucatorul ^4' .. GetPlayerName(source) .. '^0 a cumparat ^5Vip Bronze ^0(^130 zile^0)')
            vRP.setUserVip({user_id, 1, 30})
            vRP.giveMoney({user_id, 25000000})
        end
    end},
    
    ['[30 Zile] Vip Silver'] = {1000, function(user_id)
        local source = vRP.getUserSource({user_id})
        if vRP.isUserVipSilver({user_id}) then
            return vRPclient.notify(source, {'Eroare: Ai deja Vip Silver'})
        end
        if buy(user_id, 1000) then
            TriggerClientEvent('chatMessage', source, '^2Lucid: ^0Jucatorul ^4' .. GetPlayerName(source) .. '^0 a cumparat ^0Vip Silver ^0(^130 zile^0)')
            vRP.setUserVip({user_id, 2, 30})
            vRP.giveMoney({user_id, 35000000})
        end
    end},
    
    
    ['[30 Zile] Vip Gold'] = {2000, function(user_id)
        local source = vRP.getUserSource({user_id})
        if vRP.isUserVipGold({user_id}) then
            return vRPclient.notify(source, {'Eroare: Ai deja Vip Gold'})
        end
        if buy(user_id, 2000) then
            TriggerClientEvent('chatMessage', source, '^2Lucid: ^0Jucatorul ^4' .. GetPlayerName(source) .. '^0 a cumparat ^4Vip Gold ^0(^130 zile^0)')
            vRP.setUserVip({user_id, 3, 30})
            vRP.giveMoney({user_id, 45000000})
        end
    end},
    
    ['[30 Zile] Vip Diamond'] = {3000, function(user_id)
        local source = vRP.getUserSource({user_id})
        if vRP.isUserVipDiamond({user_id}) then
            return vRPclient.notify(source, {'Eroare: Ai deja Vip Diamond'})
        end
        if buy(user_id, 3000) then
            TriggerClientEvent('chatMessage', source, '^2Lucid: ^0Jucatorul ^4' .. GetPlayerName(source) .. '^0 a cumparat ^3Vip Diamond ^0(^130 zile^0)')
            vRP.setUserVip({user_id, 4, 30})
            vRP.giveMoney({user_id, 55000000})
        end
    end},
    
    ['[30 Zile] Vip Emerald'] = {5000, function(user_id)
        local source = vRP.getUserSource({user_id})
        if vRP.isUserVipEmerald({user_id}) then
            return vRPclient.notify(source, {'Eroare: Ai deja Vip Emerald'})
        end
        if buy(user_id, 5000) then
            TriggerClientEvent('chatMessage', source, '^2Lucid: ^0Jucatorul ^4' .. GetPlayerName(source) .. '^0 a cumparat ^1Vip Emerald ^0(^130 zile^0)')
            vRP.setUserVip({user_id, 5, 30})
            vRP.giveMoney({user_id, 65000000})
        end
    end},
    
    ['[30 Zile] Sponsor'] = {3000, function(user_id)
        local source = vRP.getUserSource({user_id})
        if vRP.isUserSponsors({user_id}) then
            return vRPclient.notify(source, {'Eroare: Ai deja Sponsor'})
        end
        if buy(user_id, 3000) then
            TriggerClientEvent('chatMessage', source, '^2Lucid: ^0Jucatorul ^4' .. GetPlayerName(source) .. '^0 a cumparat ^1Sponsor ^0(^130 zile^0)')
            vRP.setUserSponsor({user_id, 1, 30})
        end
    end},
    
    ['Nume Rainbow'] = {500, function(user_id)
        local source = vRP.getUserSource({user_id})
        if vRP.hasGroup({user_id, "rainbow"}) then
            return vRPclient.notify(source, {'Eroare: Ai deja Nume Rainbow'})
        end
        if buy(user_id, 500) then
            TriggerClientEvent('chatMessage', source, '^2Lucid: ^0Jucatorul ^4' .. GetPlayerName(source) .. '^0 a cumparat ^9Nume Rainbow')
            vRP.addUserGroup({user_id, "rainbow"})
        end
    end}
}

for k, v in pairs(pachete) do
    shopMenu[k] = {function(player, choice)
        v[2](vRP.getUserId({player}))
    end, 'Pret: <font color="green">' .. v[1] .. '</font> <font color="red">Diamante</font>'}
end

RegisterCommand('shop', function(p)
    vRP.openMenu({p, shopMenu})
end)

local function ch_openShop(player, ch)
    vRP.openMenu({player, shopMenu})
end

vRP.registerMenuBuilder({"main", function(add, data)
    local user_id = vRP.getUserId({data.player})
    if user_id ~= nil then
        local choices = {}
        choices["Shop"] = {ch_openShop, 'Ai nevoie de <font color="lightblue">Diamante</font> pentru a cumpara <font color="red">grade/vip/bani</font>, pentru acele <font color="lightblue">Diamante</font> trebuie sa <font color="green">donezi</font> la fondator.'}
        add(choices)
    end
end})