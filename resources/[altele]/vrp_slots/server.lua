--[[{"location":1,"prize":"grapesSlot"},{"location":2,"prize":"plumSlot"},{"location":3,"prize":"plumSlot"},
{"location":4,"prize":"plumSlot"},{"location":5,"prize":"orangeSlot"},{"location":6,"prize":"orangeSlot"},
{"location":7,"prize":"lemonSlot"},{"location":8,"prize":"sevenSlot"},{"location":9,"prize":"sevenSlot"},
{"location":10,"prize":"plumSlot"},{"location":11,"prize":"plumSlot"},{"location":12,"prize":"sevenSlot"},
{"location":13,"prize":"lemonSlot"},{"location":14,"prize":"plumSlot"},{"location":15,"prize":"lemonSlot"}],
[false,false,false,false,false,false,false,false,false,false,false,false,false,false,false],0]]
fr = {1,4,7,10,13}
dr = {2,5,8,11,14}
tr = {3,6,9,12,15}
br = {1,5,9,11,13}
brr = {3,5,7,11,15}
gigel = {"cherriesSlot","grapesSlot","sevenSlot","lemonSlot","melonSlot","orangeSlot","plumSlot"}




gigel2 = {
["cherriesSlot"] = 0.33,
["grapesSlot"]=0.5,
["sevenSlot"]=3,
["lemonSlot"]=0.4,
["melonSlot"]=0.5,
["orangeSlot"]=0.4,
["plumSlot"]=0.36
}
local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')

vRP = Proxy.getInterface('vRP')

function qgeorgeromaniarp(table1,fra)
    last = ""
    tabelcastigator = {}
    cons = 0
    asd = table1[fra[1]]["prize"]
    for fra1=1,#fra do
        mata = fra[fra1]
        if table1[mata]["prize"] == table1[fra[1]]["prize"] then
            cons = cons + 1
            table.insert(tabelcastigator,mata)
        else
            if cons>=3 then
                return tabelcastigator
            end
            return {}
        end
        last = table1[mata]["prize"]
    end
    return tabelcastigator
end


function createitttgigel()
    ll = {}
    la = {}
    lista = {}
    win = 0
    sugus = {}
    for ceva =1,15 do
        aa = {}
        aa.location = ceva
        aa.prize = gigel[math.random(#gigel)]
        table.insert(ll,aa)
        table.insert(sugus,false)
    end
    tabeldemefeot = {}
    q1 = qgeorgeromaniarp(ll,fr)
    for i=1,#q1 do
        table.insert(tabeldemefeot,q1[i])
    end

    q2 = qgeorgeromaniarp(ll,dr)
    for i=1,#q2 do
        table.insert(tabeldemefeot,q2[i])
    end

    q3 = qgeorgeromaniarp(ll,tr)
    for i=1,#q3 do
        table.insert(tabeldemefeot,q3[i])
    end

    q3b = qgeorgeromaniarp(ll,br)
    for i=1,#q3b do
        table.insert(tabeldemefeot,q3b[i])
    end

    q3br = qgeorgeromaniarp(ll,brr)
    for i=1,#q3br do
        table.insert(tabeldemefeot,q3br[i])
    end
    
 

    sumatt = 0
    for italia=0,#tabeldemefeot do
        if tabeldemefeot[italia] then
            sumatt = sumatt + (gigel2[ll[tabeldemefeot[italia]].prize]*2)
        end
    end

    for italia=0,#tabeldemefeot do
        if tabeldemefeot[italia] then
            sugus[tabeldemefeot[italia]] = true
        end
    end

    return ll,sugus,sumatt

end
tabeljucatori = {}


RegisterServerEvent("machiamavlad:openSlotMachine",function(cat)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    player = source

        cat = tonumber(cat)
        if cat ~= nil and cat > 0 and cat < 500001 then
            if cat > 0 then
                tabeljucatori[player] = {}
                tabeljucatori[player].pariu = cat
                tabeljucatori[player].carti = {}
                for i=0,6 do
                    if math.random(0,1) == 0 then
                        table.insert(tabeljucatori[player].carti,"blackCard1")
                    else
                        table.insert(tabeljucatori[player].carti,"redCard1")
                    end
                end
                TriggerClientEvent("machiamavlad:openSlotMachine",player,cat)
            end
    end

end)
RegisterServerEvent("machiamavlad:spinSlotMachine",function()
    player = src
    if vRP.tryFullPayment({vRP.getUserId({player}),tabeljucatori[player].pariu}) then
    TriggerClientEvent("machiamavlad:spinSlotMachine",source,tabeljucatori[player].pariu)
    end
end)
RegisterServerEvent("machiamavlad:requestGamblePrize",function()
    player = source
    vRP.giveMoney({vRP.getUserId({player}),tabeljucatori[player].ttu})
    tabeljucatori[player].ttu = 0
end)

RegisterServerEvent("machiamavlad:requestGamblePrize",function()
    player = source
    if tabeljucatori[player].ttu > 0 then
    vRP.giveMoney({vRP.getUserId({player}),tabeljucatori[player].ttu})
    end
    tabeljucatori[player].ttu = 0
end)
RegisterServerEvent("machiamavlad:getSlotPrize",function()
    player = source
    if tabeljucatori[player].ttu > 0 then
        vRP.giveMoney({vRP.getUserId({player}),tabeljucatori[player].ttu})
    end
    tabeljucatori[player].ttu = 0
end)


RegisterServerEvent("machiamavlad:spinSlotMachine",function()
    src = source
    sugi,nu,tu = createitttgigel()
    tabeljucatori[src].ttu = 0
    TriggerClientEvent("machiamavlad:doSlotSpin",src,sugi,nu,0)
    Wait(3000)

    if tu ==0 then
        TriggerClientEvent("machiamavlad:showInfo",src,0,tabeljucatori[player].pariu)
    else
        tabeljucatori[player].ttu = tu*tabeljucatori[player].pariu+tabeljucatori[player].pariu
        TriggerClientEvent("machiamavlad:showInfo",src,1,tu*tabeljucatori[player].pariu+tabeljucatori[player].pariu)
    end
end)

RegisterServerEvent("machiamavlad:startGamble",function()
    src = source
    player = src
    tabeljucatori[player].carti = {}
    tabeljucatori[src].cat = 0
    for i=0,6 do
    if math.random(0,1) == 0 then
        table.insert(tabeljucatori[player].carti,"blackCard1")
    else
        table.insert(tabeljucatori[player].carti,"redCard1")
    end
    end
    tabeljucatori[player].delmiza = tabeljucatori[player].ttu
    tabeljucatori[player].wons = 0
    TriggerClientEvent("machiamavlad:startGamble", src, tabeljucatori[src].carti,tabeljucatori[player].ttu,tabeljucatori[src].cat)
end)



RegisterServerEvent("machiamavlad:sendGambleAnswer",function(ce)
    src = source
    tb = {}
    tabeljucatori[src].cat = tabeljucatori[src].cat + 1
    asd = tabeljucatori[src].cat
    won = false
    if ce == "negru" and tabeljucatori[src].carti[asd] == "blackCard1" then
        tb.continue = true
        won = true
        tabeljucatori[player].delmiza = tabeljucatori[player].delmiza*2
    end
    if ce == "rosu" and tabeljucatori[src].carti[asd] == "redCard1" then
        tb.continue = true
        tabeljucatori[player].delmiza = tabeljucatori[player].delmiza*2
        won = true
    end


    tb.shCard = tabeljucatori[src].carti[asd]
    tabeljucatori[player].wons = 0
    tb.number = asd
    tb.bet = tabeljucatori[player].delmiza
    TriggerClientEvent("machiamavlad:updateGamble", src, tb,tabeljucatori[src].carti[#tabeljucatori[src].carti])
end)

