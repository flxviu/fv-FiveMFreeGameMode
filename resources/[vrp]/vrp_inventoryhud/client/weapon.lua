local currentWeapon,canThread = nil,false
local weapons = {}

RegisterCommand("wp", function()
    print(json.encode(weapons))
end)

function vRPin.equipWeapon(weapon)
    local ped = PlayerPedId()
    local selectedWeapon = GetSelectedPedWeapon(ped)
    if not weapons[weapon] then
        weapons[weapon] = {}
    end
    if currentWeapon == weapon and not (selectedWeapon == GetHashKey('WEAPON_UNARMED')) then
        vRP.playAnim({true,{{"reaction@intimidation@1h","outro",1}},false})
        Citizen.Wait(1600)
        ClearPedTasks(ped)
        local currentAmmo = GetAmmoInPedWeapon(ped, GetHashKey(currentWeapon))
        weapons[weapon]["ammo"] = currentAmmo
        TriggerServerEvent("axr:setweapons",weapons)
        RemoveWeaponFromPed(ped, GetHashKey(weapon))
        currentWeapon = nil
        vRPin.notify({name = weapon, count = 1, label = Config.Weapons[weapon][1]}, "Ai bagat arma")
        print("1")
    elseif currentWeapon ~= nil and currentWeapon ~= weapon and not (selectedWeapon == GetHashKey('WEAPON_UNARMED')) then
        vRP.playAnim({true,{{"reaction@intimidation@1h","outro",1}},false})
        Citizen.Wait(1600)
        ClearPedTasks(ped)
        local currentAmmo = GetAmmoInPedWeapon(ped, GetHashKey(currentWeapon))
        weapons[currentWeapon]["ammo"] = currentAmmo
        TriggerServerEvent("axr:setweapons",weapons)
        RemoveWeaponFromPed(ped, GetHashKey(currentWeapon))
        vRPin.notify({name = currentWeapon, count = 1, label = Config.Weapons[currentWeapon][1]}, "Ai bagat arma")
        currentWeapon = nil
        RemoveAllPedWeapons(ped, true)
        vRP.playAnim({true,{{"reaction@intimidation@1h","intro",1}},false})
        Citizen.Wait(1600)
        ClearPedTasks(ped)
        GiveWeaponToPed(ped, GetHashKey(weapon), weapons[weapon]["ammo"], false, true)
        if weapons[weapon]["atash"] then
            for _,atash in pairs(weapons[weapon]["atash"]) do
                GiveWeaponComponentToPed(ped, GetHashKey(weapon), atash)
            end
        end
        TriggerServerEvent("axr:setweapons",weapons)
        currentWeapon = weapon
        vRPin.notify({name = weapon, count = 1, label = Config.Weapons[weapon][1]}, "Ai scos arma")
        print("2")
            else
                RemoveAllPedWeapons(ped, true)
                vRP.playAnim({true,{{"reaction@intimidation@1h","intro",1}},false})
                Citizen.Wait(1600)
                ClearPedTasks(ped)
                GiveWeaponToPed(ped, GetHashKey(weapon), weapons[weapon]["ammo"], false, true)
                if weapons[weapon]["atash"] then
                    for _,atash in pairs(weapons[weapon]["atash"]) do
                        GiveWeaponComponentToPed(ped, GetHashKey(weapon), atash)
                    end
                end
                TriggerServerEvent("axr:setweapons",weapons)
                currentWeapon = weapon
                vRPin.notify({name = weapon, count = 1, label = Config.Weapons[weapon][1]}, "Ai scos arma")
                print("33")
      
    end
end

RegisterNetEvent("axr:setCLWeapons")
AddEventHandler("axr:setCLWeapons",function (weap)
    if weap then
        weapons = weap
    end
    canThread = true
    Citizen.Wait(1000)
    startWeaponThread()
end)


function vRPin.getWeaponAtash(weap)
    if weap then
        return weapons[weap]["atash"]
    end
end

function vRPin.getWeaponSpecificAtash(weap,atash_name)
    if weap then
        return weapons[weap]["atash"][atash_name]
    end
end
function getAtashType(atash)
    local atash_tbl = {"supressor","clip","flash","scope","skin","grip"}
    for _,v in pairs(atash_tbl) do
        if string.find(atash,v) then
            return v
        end
    end
    return nil
end

function vRPin.getClientWPTable()
    return weapons
end


RegisterNetEvent("axr:setatash")
AddEventHandler("axr:setatash",function(weap,atash,user_id,atash_code)
  local ped = PlayerPedId()
  local currentWeaponHash = GetSelectedPedWeapon(ped)
  if currentWeaponHash == GetHashKey(weap) then
    GiveWeaponComponentToPed(ped, GetHashKey(weap), GetHashKey(atash))
    TriggerServerEvent("axr:getatash",user_id,atash_code)
    local atash_type = getAtashType(atash_code)
    if atash_type then
        if not weapons[currentWeapon]["atash"] then
            weapons[currentWeapon]["atash"] = {}
        end
        if not weapons[currentWeapon]["atash"][atash_type] then
            weapons[currentWeapon]["atash"][atash_type] = {}
        end
        weapons[weap]["atash"][atash_type] = atash
        TriggerServerEvent("axr:setweapons",weapons)
    end
  else
    vRP.notify({"Trebuie sa ai arma in mana"})
  end
end)



RegisterCommand('reload',function()
    if currentWeapon  then
        local ped = PlayerPedId()
        local magazineSize = GetMaxAmmoInClip(ped, GetHashKey(currentWeapon))
        local currentAmmo = GetAmmoInPedWeapon(ped, GetHashKey(currentWeapon))
        local toReload = magazineSize
        if not weapons[currentWeapon]["ammo"] then
            weapons[currentWeapon]["ammo"] = {}
        end
        if currentAmmo > 0 then
            toReload = magazineSize - currentAmmo
        end
        INserver.requestReload({currentWeapon, toReload}, function(ok,ra)
            if ok then
                if magazineSize == currentAmmo then
                    
                    vRP.notify({"Ai arma deja incarcata"})
                else
                    incarca = false
                ra = currentAmmo + ra
                SetPedAmmo(ped, currentWeapon, ra)
                weapons[currentWeapon]["ammo"] = ra
                TriggerServerEvent("axr:setweapons",weapons)
                Citizen.Wait(100)
                MakePedReload(ped)
                Citizen.Wait(1000)
                incarca = true
                end
            end
        end)
    end
end)
RegisterKeyMapping('reload', 'Reload your weapon', 'keyboard', 'R')

RegisterCommand('strangeatasamente',function()
    if currentWeapon  then
        local ped = PlayerPedId()
        if weapons[currentWeapon] then
            if weapons[currentWeapon]['atash'] then
                local itemsToGive = {}
                for atashType,atashHash in pairs(weapons[currentWeapon]['atash']) do
                    itemsToGive[atashType] = true
                end
                weapons[currentWeapon]['atash'] = nil
                RemoveWeaponFromPed(ped, GetHashKey(currentWeapon))
                GiveWeaponToPed(ped, GetHashKey(currentWeapon), weapons[currentWeapon]["ammo"], false, true)
                TriggerServerEvent("axr:removeAtashFromWeapon",currentWeapon,itemsToGive)
            else
                vRP.notify({"Arma trebuie sa aibe atasamente"})
            end
        else
            vRP.notify({"Trebuie sa ai o arma in mana"})
        end
    else
        vRP.notify({"Trebuie sa ai o arma in mana"})
    end
end)



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if currentWeapon  then
            local ped = PlayerPedId()
            local currentAmmo = GetAmmoInPedWeapon(ped, GetHashKey(currentWeapon))
            weapons[currentWeapon]["ammo"] = currentAmmo
            if currentAmmo < 1 then
                GiveWeaponToPed(ped, GetHashKey(currentWeapon), 0, false, true)
            end

            if vRP.isInComa({}) or vRP.isHandcuffed{} or vRP.isJailed({}) then
                currentWeapon = nil
                RemoveAllPedWeapons(PlayerPedId(), true)
            end
        end
    end
end)


RegisterNetEvent("axr:takeWeaponFromHotbar")
AddEventHandler("axr:takeWeaponFromHotbar",function (weapon)
    if GetHashKey(currentWeapon) == GetHashKey(weapon) then
        currentWeapon = nil
        RemoveAllPedWeapons(PlayerPedId(), true) 
    end
end)
RegisterNetEvent("axr:removeWeaponsTBL")
AddEventHandler("axr:removeWeaponsTBL",function ()
    weapons = nil
    TriggerServerEvent("axr:setweapons",weapons)
end)


RegisterNetEvent("axr:removeWeaponTBL")
AddEventHandler("axr:removeWeaponTBL",function (weap)
    if not weap then
    weapons = nil
    else
        weapons[weap] = nil
    end
    TriggerServerEvent("axr:setweapons",weapons)
end)

function startWeaponThread()
    Citizen.CreateThread(function()
        while canThread do
            for weap,infow in pairs(Config.Weapons) do
                local hash = GetHashKey(weap)
                if (HasPedGotWeapon(PlayerPedId(),hash)) then
                    if not (weapons[weap] or weapons[weap] == {} or weapons[weap] == "") then
                        RemoveWeaponFromPed(PlayerPedId(), hash)
                        canThread = false
                        TriggerServerEvent("inventory_hud:sendDiscordLog","hacker","Playerul a fost prins cu arma "..weap.." din hack. Toate celelalte arme au fost inlaturate","KICK")
                    end
                end
            end
            TriggerServerEvent("axr:setweapons",weapons)
            Citizen.Wait(10000)
        end
    end)
end