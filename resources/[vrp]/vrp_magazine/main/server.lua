local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","LucidShops")

RegisterServerEvent("LucidShops:getMoney")
AddEventHandler("LucidShops:getMoney", function()
    local source = source
    TriggerClientEvent("LucidShops:c:setmoney",source,vRP.getMoney({vRP.getUserId({source})}))
end)

RegisterServerEvent("LucidShops:checkCost")
AddEventHandler("LucidShops:checkCost", function(cost, method, basket)
    local user_id = vRP.getUserId({source})
    local cash, bank = vRP.getMoney({user_id}), vRP.getBankMoney({user_id})
    
    if method == "cash" and cash >= cost then
        vRP.tryPayment({user_id,cost})
        Wait(100)
        for k, v in pairs(basket) do
            vRP.giveInventoryItem({user_id, k, v.amount})
        end
    elseif method == "bank" and bank >= cost then
        vRP.setBankMoney({user_id, bank-cost})
        Wait(100)
        for k, v in pairs(basket) do
            vRP.giveInventoryItem({user_id, k, v.amount})
        end
    end
end)