    

vRP = Proxy.getInterface("vRP")


local Basket = {}
local sleep = 2000
local targetShop = nil


function openMarket()
    SetNuiFocus(true, true)
    loadCategories()
    loadItems()
    TriggerServerEvent("LucidShops:getMoney")
    Wait(100)
    loadMoney()
    SendNUIMessage({
        type = "open",  
        title = STG.Shops[targetShop].title,
        text = STG.Shops[targetShop].text
    })
end

function loadCategories()
    for k,v in pairs(STG.Category) do
        SendNUIMessage({
            type = "addCategory",
            name = v
        })
    end
end
local pmoney = 0
RegisterNetEvent("LucidShops:c:setmoney",function(money)
    pmoney = money
end)

function loadMoney()
    SendNUIMessage({
        type = "updateMoney",
        money = pmoney
    })
end

function loadItems()
    for k,v in pairs(STG.Items) do
        local info = STG.Items[k]
        SendNUIMessage({
            type = "addItem",
            name = info.name,
            label = info.label,
            price = info.price,
            category = info.category,
            desc = info.description,
            image = STG.ImageLocation..info.name..".png",
        })
    end
end


RegisterNUICallback('addbasket', function(data)
    if not Basket[data.name] then
        Basket[data.name] = {amount = 1}
        SendNUIMessage({
            type = "addList",
            name = data.name,
            amount = 1,
            label = data.label,
            image = STG.ImageLocation..data.name..".png",
            price = STG.Items[data.name].price
        })
    end
end)

RegisterNUICallback('addAmount', function(data)
    local newAmount = Basket[data.name].amount+1
    Basket[data.name].amount = newAmount
    SendNUIMessage({
        type = "addAmount",
        name = data.name,
        amount = newAmount,
        price = STG.Items[data.name].price
    })
end)

RegisterNUICallback('removeAmount', function(data)
    local newAmount = Basket[data.name].amount-1
    if(newAmount > 0) then
        Basket[data.name].amount = newAmount
        SendNUIMessage({
            type = "removeAmount",
            name = data.name,
            amount = newAmount,
            price = STG.Items[data.name].price
        })
    end 
end)

RegisterNUICallback('deleteItem', function(data) 
    SendNUIMessage({
        type = "removeItem",
        name = data.name,
        price = Basket[data.name].amount*STG.Items[data.name].price,
    })
    Basket[data.name] = nil
end)

RegisterNUICallback('buy', function(data) 
    TriggerServerEvent('LucidShops:checkCost', tonumber(data.totalCost), data.method,Basket)
    SendNUIMessage({ type = "close" })
end)

RegisterNUICallback('exit', function() 
    SetNuiFocus(false, false)
    Basket = {}
end)

Citizen.CreateThread(function()
    for k,v in pairs(STG.Shops) do
        local blipinfo = STG.Blip
        local blip = AddBlipForCoord(STG.Shops[k]["coords"])
        SetBlipSprite(blip, blipinfo.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, blipinfo.scale)
        SetBlipColour(blip, blipinfo.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(blipinfo.name)
        EndTextCommandSetBlipName(blip)
    end
end)

Citizen.CreateThread(function()
    while true do
        local find = false
        for k,v in pairs(STG.Shops) do
            local shopCoord = STG.Shops[k]["coords"]
            local myCoord = GetEntityCoords(PlayerPedId())
            if (GetDistanceBetweenCoords(shopCoord, myCoord, true) < 10.0) then
                targetShop = k
                find = true
                sleep = 0
            end
        end
        if not find then
            targetShop = nil
            sleep = 2000
        end
        Citizen.Wait(3000)
    end
end)


Citizen.CreateThread(function()
    if STG.customMarker then
        while true do
            Citizen.Wait(sleep)
            if targetShop then
                local coords = STG.Shops[targetShop]["coords"]
                    if not HasStreamedTextureDictLoaded("shopping") then
                        RequestStreamedTextureDict("shopping", true)
                        while not HasStreamedTextureDictLoaded("shopping") do
                            Wait(1)
                        end
                    else
                        DrawMarker(9, vector3(coords.x, coords.y, coords.z), 0.0, 0.0, 0.0, 0.0, 90.0, 90.0, 1.0, 1.0, 1.0, 255, 255, 255, 255,false, false, 2, true, "shopping", "shopping", false)
                    end
                if IsControlJustPressed(0, 38) then
                    openMarket()
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    if not STG.customMarker then
        while true do
            Citizen.Wait(sleep)
            if targetShop then
                local coords = STG.Shops[targetShop]["coords"]
                SetTextFont(4)
                SetTextProportional(0)
                SetTextScale(0.6, 0.6)
                SetTextColour(255, 255, 255, 255)
                SetTextDropShadow(0, 0, 0, 0, 255)
                SetTextEdge(1, 0, 0, 0, 255)
                SetTextDropShadow()
                SetTextOutline()
                SetTextCentre(1)
                SetTextEntry("STRING")
                AddTextComponentString("~w~Apasa ~b~E~w~ pentru a deschide magazin-ul")
                DrawText(0.5, 0.890)
                DrawMarker(0, vector3(coords.x, coords.y, coords.z+1) - vector3(0.0, 0.0, 0.985), 0.0, 0.0, 0.0, 0, 0.0, 0.0,0.5, 0.5, 0.5, 0, 255, 255, 100, false, false, 2, true, false, false, false)
                if IsControlJustPressed(0, 38) then
                    openMarket()
                end
            end
        end
    end
end)