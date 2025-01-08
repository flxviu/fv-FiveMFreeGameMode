local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","sx_dealership")
vRPCds = Tunnel.getInterface("sx_dealership","sx_dealership")
vRPds = {}
Tunnel.bindInterface("sx_dealership",vRPds)
Proxy.addInterface("sx_dealership",vRPds)

local prefix = {
    ["AB"] = "Alba",
    ["AR"] = "Arad",
    ["AG"] = "Arges",
    ["BC"] = "Bacau",
    ["BH"] = "Bihor",
    ["BN"] = "Bistrita-Nasaud",
    ["BT"] = "Botosani",
    ["BR"] = "Braila",
    ["BV"] = "Brasov",
    ["BZ"] = "Buzau",
    ["CL"] = "Calarasi",
    ["CS"] = "Caras-Severin",
    ["CJ"] = "Cluj",
    ["CT"] = "Constanta",
    ["CV"] = "Covasna",
    ["DB"] = "Dambovita",
    ["DJ"] = "Dolj",
    ["GL"] = "Galati",
    ["GR"] = "Giurgiu",
    ["GJ"] = "Gorj",
    ["HR"] = "Harghita",
    ["HD"] = "Hunedoara",
    ["IL"] = "Ialomita",
    ["IS"] = "Iasi",
    ["IF"] = "Ilfov",
    ["MM"] = "Maramures",
    ["MH"] = "Mehedinti",
    ["MS"] = "Mures",
    ["NT"] = "Neamt",
    ["OT"] = "Olt",
    ["PH"] = "Prahova",
    ["SJ"] = "Salaj",
    ["SM"] = "Satu Mare",
    ["SB"] = "Sibiu",
    ["SV"] = "Suceava",
    ["TR"] = "Teleorman",
    ["TM"] = "Timis",
    ["TL"] = "Tulcea",
    ["VL"] = "Valcea",
    ["VS"] = "Vaslui",
    ["VN"] = "Vrancea",
    ["B"] = "Bucuresti"
}

local culori = {
    danger = 12263716,
    warning = 15773006,
    success = 2276147,
    info =     6013150
}

local function discordLog(url, embed)
    PerformHttpRequest(url, function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' })
end

function numWithCommas(n)
    return tostring(math.floor(n)):reverse():gsub("(%d%d%d)","%1,")
                                  :gsub(",(%-?)$","%1"):reverse()
  end

function vRPds.checkMoneyForTesting(price)
    local user_id = vRP.getUserId({source})
    if user_id ~= nil then
        local money = vRP.getMoney({user_id})
        testPrice = 0
        if price > 0 then
            if vRP.tryPayment({user_id,testPrice}) then 
                return true
            else
                return false
            end
        else
            return false
        end
    end
end

function vRPds.checkMoneyForBuyingVehicle(showroomID,selectedVehicle, categorie)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if user_id ~= nil then
        local vehID = math.random(1,9999)
        cityPrefix = {}
        for i, v in pairs(prefix) do
            table.insert(cityPrefix, i)
        end
        thePlate = cityPrefix[math.random(#cityPrefix)].." "..vehID
        for k,v in pairs(config.dealerships[showroomID].vehicles[categorie]) do 
            if v.vehID == selectedVehicle then
                model = v.spawncode
                if vRP.tryPayment({user_id,v.price}) then
                    exports.oxmysql:query("SELECT vehicle FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle", {['@user_id'] = user_id, ['@vehicle'] = model}, function (haveCar)
                        if #haveCar > 0 then
                            vRPclient.notify(player,{"You already own this vehicle."})
                        else
                            exports.oxmysql:query("INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,upgrades,vehicle_plate) VALUES(@user_id,@vehicle,@upgrades,@vehicle_plate)", {
                                ['@user_id'] = user_id,
                                ['@vehicle'] = model,
                                ['@upgrades'] = json.encode(tuning),
                                ['@vehicle_plate'] = "ICED"..math.random(1111,9999)
                            })
                            vRPclient.notify(player, {"Ai platit ~g~$"..v.price.."~w~ pentru acest vehicul!\nDu-te la un garaj pentru a-l scoate!"})
                            local embed = {
                                {
                                    color = culori.info,
                                    title = "Un player a cumparat o masina",
                                    footer = {
                                        text = "sxint developing services",
                                        ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S')
                                    },
                                    fields = {
                                        {
                                            name = "Username",
                                            value = GetPlayerName(player),
                                            inline = true
                                        },
                                        {
                                            name = "ID",
                                            value = user_id,
                                            inline = true
                                        },
                                        {
                                            name = "Model masina",
                                            value = v.spawncode,
                                            inline = false
                                        },
                                        {
                                            name = "Pret masina",
                                            value = numWithCommas(v.price),
                                            inline = true
                                        }
                                    }
                                }
                            }
                            local linkWebhook = "https://discord.com/api/webhooks/1321589580255723541/lmwhldHONoKL6idPE4GnD_SDsYWJ-oY3l7QH4dfoee3h_hsZzVyCkYabOMu7LAvZCJW6"
                            discordLog(linkWebhook, embed)
                        end
                    end)
                    return true 
                else
                    vRPclient.notify(player,{"You don't have enough money to buy this vehicle."})
                    return false
                end
            end
        end
    end
end
