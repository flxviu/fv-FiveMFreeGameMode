-- def Weapons
for k,v in pairs(Config.Weapons) do
	vRP.defInventoryItemInventar({k,v[1],"",v[3],v[4]})
end

-- create ammo item by type
local Weapons_Amunition = {}
for k,v in pairs(Config.Weapons) do
    local ammo = {}
    if v[5] then
        ammo = {
            code = "ammo-"..k,
            name = "Gloante "..v[1],
            desc = v[2],
            func = v[3],
            weight = v[4],
            weap = k
        }
	    vRP.defInventoryItemInventarAmmo({ammo.code,ammo.name,ammo.desc,ammo.func,ammo.weight})
        Weapons_Amunition[ammo.code] = ammo
    end
end


function vRPin.getAmmoNeed(player,weapon)
    local user_id = vRP.getUserId({player})
    if user_id then
        for k,v in pairs(Weapons_Amunition) do
            if v.weap == weapon then
                return v.code
            end
        end
    end
    return nil
end

function vRPin.getWeaponsTable(user_id)
    if user_id then
        local _src = vRP.getUserSource{user_id}
        local weaponsSV = {}
        for k,v in pairs(Config.Weapons) do
            local amount = vRP.getInventoryItemAmount{user_id,k}
                local ammoNR = vRP.getInventoryItemAmount{user_id,"ammo-"..k}
                local atashTBL = {}
                atashTBL["scope"] = vRP.getInventoryItemAmount{user_id,k.."_scope"}
                atashTBL["supressor"] = vRP.getInventoryItemAmount{user_id,k.."_supressor"}
                atashTBL["clip"] = vRP.getInventoryItemAmount{user_id,k.."_clip"}
                atashTBL["flash"] = vRP.getInventoryItemAmount{user_id,k.."_flash"}
                atashTBL["skin"] = vRP.getInventoryItemAmount{user_id,k.."_skin"}
                atashTBL["grip"] = vRP.getInventoryItemAmount{user_id,k.."_grip"}
                local isok = false
                if ammoNR > 0 then
                    isok = true
                else
                    for _,atn in pairs(atashTBL) do
                        if atn > 0 then
                            isok = true
                            break;
                        end
                    end
                end

            if isok then
                weaponsSV[k] =  {gun = amount,ammo = ammoNR,atash = atashTBL}
            end
        end
        return weaponsSV
    end
end



AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
    if first_spawn then
    local data = vRP.getUserDataTable({user_id})
        if data then
            if data.weapons then
                TriggerClientEvent("axr:setCLWeapons", source, data.weapons)
            end
        end
    end
end)



RegisterServerEvent("axr:removeAtashFromWeapon")
AddEventHandler("axr:removeAtashFromWeapon", function(weapon,weapToGive)
    local _src = source
    local user_id = vRP.getUserId({_src})
    if user_id then
        for k,v in pairs(weapToGive) do
            local itemToRecive = weapon.."_"..k
            vRP.giveInventoryItem{user_id,itemToRecive,1,true}
        end
    end
end)

RegisterServerEvent("vrp_inventory:removeallweapons")
AddEventHandler("vrp_inventory:removeallweapons", function(player)
    local user_id = vRP.getUserId({player})
    if user_id then
        local data = vRP.getUserDataTable{user_id}
        if data and data.inventory then
          for k,v in pairs(data.inventory) do
            local item = k
            if item then
                if string.find(item,"WEAPON_") then
                    vRP.tryGetInventoryItem{user_id,item,v.amount,false}
                end
            end
          end
        end
    end
end)

RegisterServerEvent("Mbs:GEtWeapon")
AddEventHandler("Mbs:GEtWeapon", function()
    local user_id = vRP.getUserId({source})
return Config.Weapons
end)    