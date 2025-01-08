local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_pacificheist")

vRPpacificheist = {}
Tunnel.bindInterface("vRP_pacificheist",vRPpacificheist)
Proxy.addInterface("vRP_pacificheist",vRPpacificheist)
vRPpacificheistB = Tunnel.getInterface("vRP_pacificheist","vRP_pacificheist")

local TTPcodPacificHeist = [[
function Loot(currentgrab)
    Grab2clear = false
    Grab3clear = false
    UTK.grabber = true
    Trolley = nil
    local ped = PlayerPedId()
    local model = "hei_prop_heist_cash_pile"

    if currentgrab == 1 then
        Trolley = GetClosestObjectOfType(257.44, 215.07, 100.68, 1.0, 269934519, false, false, false)
    elseif currentgrab == 2 then
        Trolley = GetClosestObjectOfType(262.34, 213.28, 100.68, 1.0, 269934519, false, false, false)
    elseif currentgrab == 3 then
        Trolley = GetClosestObjectOfType(263.45, 216.05, 100.68, 1.0, 269934519, false, false, false)
    elseif currentgrab == 4 then
        Trolley = GetClosestObjectOfType(266.02, 215.34, 100.68, 1.0, 2007413986, false, false, false)
        model = "ch_prop_gold_bar_01a"
    elseif currentgrab == 5 then
        Trolley = GetClosestObjectOfType(265.11, 212.05, 100.68, 1.0, 881130828, false, false, false)
        model = "ch_prop_vault_dimaondbox_01a"
    end
	local CashAppear = function()
	    local pedCoords = GetEntityCoords(ped)
        local grabmodel = GetHashKey(model)

        RequestModel(grabmodel)
        while not HasModelLoaded(grabmodel) do
            Citizen.Wait(100)
        end
	    local grabobj = CreateObject(grabmodel, pedCoords, true)

	    FreezeEntityPosition(grabobj, true)
	    SetEntityInvincible(grabobj, true)
	    SetEntityNoCollisionEntity(grabobj, ped)
	    SetEntityVisible(grabobj, false, false)
	    AttachEntityToEntity(grabobj, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
	    local startedGrabbing = GetGameTimer()

	    Citizen.CreateThread(function()
		    while GetGameTimer() - startedGrabbing < 37000 do
			    Citizen.Wait(1)
			    DisableControlAction(0, 73, true)
			    if HasAnimEventFired(ped, GetHashKey("CASH_APPEAR")) then
				    if not IsEntityVisible(grabobj) then
					    SetEntityVisible(grabobj, true, false)
				    end
			    end
			    if HasAnimEventFired(ped, GetHashKey("RELEASE_CASH_DESTROY")) then
				    if IsEntityVisible(grabobj) then
                        SetEntityVisible(grabobj, false, false)
                        if currentgrab < 4 then
                            TriggerServerEvent("utk_oh:openvault1nozyNozyZeu")
                        elseif currentgrab == 4 then
                            TriggerServerEvent("utk_oh:openvault2nozyNozyZeu")
                        elseif currentgrab == 5 then
                            TriggerServerEvent("utk_oh:openvault3nozyNozyZeu")
                        end
				    end
			    end
		    end
		    DeleteObject(grabobj)
	    end)
    end
    local emptyobj = 769923921

    if currentgrab == 4 or currentgrab == 5 then
        emptyobj = 2714348429
    end
	if IsEntityPlayingAnim(Trolley, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 3) then
		return
    end
    local baghash = GetHashKey("hei_p_m_bag_var22_arm_s")

    RequestAnimDict("anim@heists@ornate_bank@grab_cash")
    RequestModel(baghash)
    RequestModel(emptyobj)
    while not HasAnimDictLoaded("anim@heists@ornate_bank@grab_cash") and not HasModelLoaded(emptyobj) and not HasModelLoaded(baghash) do
        Citizen.Wait(100)
    end
    while not NetworkHasControlOfEntity(Trolley) do
		Citizen.Wait(1)
		NetworkRequestControlOfEntity(Trolley)
	end
	GrabBag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), GetEntityCoords(PlayerPedId()), true, false, false)
    Grab1 = NetworkCreateSynchronisedScene(GetEntityCoords(Trolley), GetEntityRotation(Trolley), 2, false, false, 1065353216, 0, 1.3)
	NetworkAddPedToSynchronisedScene(ped, Grab1, "anim@heists@ornate_bank@grab_cash", "intro", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(GrabBag, Grab1, "anim@heists@ornate_bank@grab_cash", "bag_intro", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
	NetworkStartSynchronisedScene(Grab1)
	Citizen.Wait(1500)
	CashAppear()
    if not Grab2clear then
        Grab2 = NetworkCreateSynchronisedScene(GetEntityCoords(Trolley), GetEntityRotation(Trolley), 2, false, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(ped, Grab2, "anim@heists@ornate_bank@grab_cash", "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(GrabBag, Grab2, "anim@heists@ornate_bank@grab_cash", "bag_grab", 4.0, -8.0, 1)
        NetworkAddEntityToSynchronisedScene(Trolley, Grab2, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 4.0, -8.0, 1)
        NetworkStartSynchronisedScene(Grab2)
        Citizen.Wait(37000)
    end
    if not Grab3clear then
        Grab3 = NetworkCreateSynchronisedScene(GetEntityCoords(Trolley), GetEntityRotation(Trolley), 2, false, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(ped, Grab3, "anim@heists@ornate_bank@grab_cash", "exit", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(GrabBag, Grab3, "anim@heists@ornate_bank@grab_cash", "bag_exit", 4.0, -8.0, 1)
        NetworkStartSynchronisedScene(Grab3)
        NewTrolley = CreateObject(emptyobj, GetEntityCoords(Trolley) + vector3(0.0, 0.0, - 0.985), true, false, false)
        SetEntityRotation(NewTrolley, GetEntityRotation(Trolley))
        while not NetworkHasControlOfEntity(Trolley) do
            Citizen.Wait(1)
            NetworkRequestControlOfEntity(Trolley)
        end
        DeleteObject(Trolley)
        while DoesEntityExist(Trolley) do
            Citizen.Wait(1)
            DeleteObject(Trolley)
        end
        PlaceObjectOnGroundProperly(NewTrolley)
    end
	Citizen.Wait(1800)
	if DoesEntityExist(GrabBag) then
        DeleteEntity(GrabBag)
    end
    SetPedComponentVariation(ped, 5, 45, 0, 0)
	RemoveAnimDict("anim@heists@ornate_bank@grab_cash")
	SetModelAsNoLongerNeeded(emptyobj)
	SetModelAsNoLongerNeeded(GetHashKey("hei_p_m_bag_var22_arm_s"))
end

function Search(location)
    UTK.disableinput = true
    RequestAnimDict('mp_arresting')
    while not HasAnimDictLoaded('mp_arresting') do
        Citizen.Wait(10)
    end
    EnterAnim(vector3(location.coords.x, location.coords.y, location.coords.z))
    Citizen.Wait(1500)
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
    vRP.seteazaProgressBar({15000, Config.text.search})
    Citizen.Wait(15000)
    if UTK.searchinfo.random ~= 1 then
        location.status = true
        vRP.notify({Config.text.nothing})
        UTK.searchinfo.random = math.random(1, UTK.cur - 1)
        UTK.cur = UTK.cur - 1
    else
        UTK.searchinfo.found = true
        vRP.notify({Config.text.found})
        TriggerServerEvent("utk_oh:ostimeExtraNozyZeu")
    end
    ClearPedTasks(PlayerPedId())
    UTK.disableinput = false
end
]]

local lastrobbed = 0 -- don't change this
local info = {stage = 0, style = nil, locked = false}
local totalcash = 0
local PoliceDoors = {
    {loc = vector3(257.10, 220.30, 106.28), txtloc = vector3(257.10, 220.30, 106.28), model = "hei_v_ilev_bk_gate_pris", model2 = "hei_v_ilev_bk_gate_molten", obj = nil, obj2 = nil, locked = true},
    {loc = vector3(236.91, 227.50, 106.29), txtloc = vector3(236.91, 227.50, 106.29), model = "v_ilev_bk_door", model2 = "v_ilev_bk_door", obj = nil, obj2 = nil, locked = true},
    {loc = vector3(262.35, 223.00, 107.05), txtloc = vector3(262.35, 223.00, 107.05), model = "hei_v_ilev_bk_gate2_pris", model2 = "hei_v_ilev_bk_gate2_pris", obj = nil, obj2 = nil, locked = true},
    {loc = vector3(252.72, 220.95, 101.68), txtloc = vector3(252.72, 220.95, 101.68), model = "hei_v_ilev_bk_safegate_pris", model2 = "hei_v_ilev_bk_safegate_molten", obj = nil, obj2 = nil, locked = true},
    {loc = vector3(261.01, 215.01, 101.68), txtloc = vector3(261.01, 215.01, 101.68), model = "hei_v_ilev_bk_safegate_pris", model2 = "hei_v_ilev_bk_safegate_molten", obj = nil, obj2 = nil, locked = true},
    {loc = vector3(253.92, 224.56, 101.88), txtloc = vector3(253.92, 224.56, 101.88), model = "v_ilev_bk_vaultdoor", model2 = "v_ilev_bk_vaultdoor", obj = nil, obj2 = nil, locked = true}
}

RegisterServerEvent('utk_oh:GetData')
AddEventHandler('utk_oh:GetData', function()
    TriggerClientEvent('utk_oh:GetData', source, info)
end)

RegisterServerEvent('utk_oh:GetDoors')
AddEventHandler('utk_oh:GetDoors', function()
    TriggerClientEvent('utk_oh:GetDoors', source, PoliceDoors)
end)

RegisterServerEvent('utk_oh:startevent')
AddEventHandler('utk_oh:startevent', function(method)
    if source ~= nil then
        local user_id = vRP.getUserId({source})
        local swat = vRP.getOnlineUsersByFaction({"DIICOT"})
        local cops = vRP.getOnlineUsersByFaction({"Politia Romana"})
        if not info.locked then
            if (os.time() - Config.cooldown) > lastrobbed then
                if vRP.isUserInFaction({user_id,"SWAT"}) or vRP.isUserInFaction({user_id,"Politie"}) or vRP.isUserInFaction({user_id,"Smurd"}) then
                    vRPclient.notify(source,{"~r~Factiunile Guvernamentale Nu Pot Da Jaf."})
                else
                    local enforcers = tonumber(#cops) + tonumber(#swat)
                    if(enforcers >= Config.MinCops)then
                        if method == 1 then
                            if vRP.tryGetInventoryItem({user_id,Config.items.thermal,1,false}) then
                                TriggerClientEvent('utk_oh:startevent', source, true)
                                TriggerClientEvent('chatMessage', source, "^1[^8JAF^1] ^0Ai inceput jaful la banca: ^9Pacific^0, Cel mai periculos jaf din Romania!")
                                info.stage = 1
                                info.style = 1
                                info.locked = true
                                Wait(5000)
                                TriggerClientEvent('chatMessage', -1, "^1[^8RO-ALERT^1] ^0Jaf dat in exclusivitate, Toti politai sunt nevoiti sa se duca sa il opreasca la banca: ^9Pacific")
                                TriggerClientEvent('chatMessage', -1, "^1[^8RO-ALERT^1] ^0Jaf dat in exclusivitate, Toti politai sunt nevoiti sa se duca sa il opreasca la banca: ^9Pacific")
                                TriggerClientEvent('chatMessage', -1, "^1[^8RO-ALERT^1] ^0Jaf dat in exclusivitate, Toti politai sunt nevoiti sa se duca sa il opreasca la banca: ^9Pacific")
                            else
                                TriggerClientEvent('utk_oh:startevent', source, Config.text.nothermal)
                            end
                        elseif method == 2 then
                            if vRP.tryGetInventoryItem({user_id,Config.items.lockpick,1,false}) then
                                info.stage = 1
                                info.style = 2
                                info.locked = true
                                TriggerClientEvent('utk_oh:startevent', source, true)
                                TriggerClientEvent('chatMessage', source, "^1[^8JAF^1] ^0Ai inceput jaful la banca: ^9Pacific^0, Cel mai periculos jaf din Romania!")
                                Wait(45000)
                                TriggerClientEvent('chatMessage', -1, "^1[^8RO-ALERT^1] ^0Jaf dat in exclusivitate, Toti politai sunt nevoiti sa se duca sa il opreasca la banca: ^9Pacific")
                                TriggerClientEvent('chatMessage', -1, "^1[^8RO-ALERT^1] ^0Jaf dat in exclusivitate, Toti politai sunt nevoiti sa se duca sa il opreasca la banca: ^9Pacific")
                                TriggerClientEvent('chatMessage', -1, "^1[^8RO-ALERT^1] ^0Jaf dat in exclusivitate, Toti politai sunt nevoiti sa se duca sa il opreasca la banca: ^9Pacific")
                            else
                                TriggerClientEvent('utk_oh:startevent', source, Config.text.nolockpick)
                            end
                        end
                    else
                        TriggerClientEvent('utk_oh:startevent', source, Config.text.mincops)
                    end
                end
            else
                TriggerClientEvent('utk_oh:startevent', source, math.floor((Config.cooldown - (os.time() - lastrobbed)) / 60)..":"..math.fmod((Config.cooldown - (os.time() - lastrobbed)), 60).." "..Config.text.timeleft)
            end
        else
            TriggerClientEvent('utk_oh:startevent', source, Config.text.alreadyrobbed)
        end
    end
end)

RegisterServerEvent('utk_oh:checkItem')
AddEventHandler('utk_oh:checkItem', function(itemname)
	local user_id = vRP.getUserId({source})
    if vRP.tryGetInventoryItem({user_id,itemname,1,false}) then
        TriggerClientEvent('utk_oh:checkItem', source, true)
    else
        TriggerClientEvent('utk_oh:checkItem', source, false)
    end
end)

RegisterServerEvent('utk_oh:gettotalcash')
AddEventHandler('utk_oh:gettotalcash', function()
    TriggerClientEvent('utk_oh:gettotalcash', source, totalcash)
end)

RegisterServerEvent("utk_oh:updatecheck")
AddEventHandler("utk_oh:updatecheck", function(var, status)
    TriggerClientEvent("utk_oh:updatecheck_c", -1, var, status)
end)

RegisterServerEvent("utk_oh:policeDoor")
AddEventHandler("utk_oh:policeDoor", function(doornum, status)
    PoliceDoors[doornum].locked = status
    TriggerClientEvent("utk_oh:policeDoor_c", -1, doornum, status)
end)

RegisterServerEvent("utk_oh:moltgate")
AddEventHandler("utk_oh:moltgate", function(x, y, z, oldmodel, newmodel, method)
    TriggerClientEvent("utk_oh:moltgate_c", -1, x, y, z, oldmodel, newmodel, method)
end)

RegisterServerEvent("utk_oh:fixdoor")
AddEventHandler("utk_oh:fixdoor", function(hash, coords, heading)
    TriggerClientEvent("utk_oh:fixdoor_c", -1, hash, coords, heading)
end)

RegisterServerEvent("utk_oh:openvault")
AddEventHandler("utk_oh:openvault", function(method)
    TriggerClientEvent("utk_oh:openvault_c", -1, method)
end)

RegisterServerEvent("utk_oh:startloot")
AddEventHandler("utk_oh:startloot", function()
    TriggerClientEvent("utk_oh:startloot_c", -1)
end)

RegisterServerEvent("utk_oh:openvault1nozyNozyZeu")
AddEventHandler("utk_oh:openvault1nozyNozyZeu", function()
    local user_id = vRP.getUserId({source})
    local reward = math.random(Config.mincash, Config.maxcash)
    vRP.giveInventoryItem({user_id, Config.items.dirty_money, reward, true})
    totalcash = totalcash + reward
end)

RegisterServerEvent("utk_oh:openvault2nozyNozyZeu")
AddEventHandler("utk_oh:openvault2nozyNozyZeu", function()
    local user_id = vRP.getUserId({source})
    vRP.giveInventoryItem({user_id, Config.items.gold, 1, true})
end)

RegisterServerEvent("utk_oh:openvault3nozyNozyZeu")
AddEventHandler("utk_oh:openvault3nozyNozyZeu", function()
    local user_id = vRP.getUserId({source})
    vRP.giveInventoryItem({user_id, Config.items.diamond, 1, true})
end)

RegisterServerEvent("utk_oh:ostimeExtraNozyZeu")
AddEventHandler("utk_oh:ostimeExtraNozyZeu", function()
    local user_id = vRP.getUserId({source})
    vRP.giveInventoryItem({user_id, Config.items.id_card, 2, true})
end)

RegisterServerEvent("utk_oh:ostimer")
AddEventHandler("utk_oh:ostimer", function()
    lastrobbed = os.time()
    info.stage, info.style, info.locked = false, nil, false
    Citizen.Wait(300000)
    for i = 1, #PoliceDoors, 1 do
        PoliceDoors[i].locked = true
        TriggerClientEvent("utk_oh:policeDoor_c", -1, i, true)
    end
    totalcash = 0
    TriggerClientEvent("utk_oh:reset", -1)
end)

RegisterServerEvent("utk_oh:gas")
AddEventHandler("utk_oh:gas", function()
    TriggerClientEvent("utk_oh:gas_c", -1)
end)

RegisterServerEvent("utk_oh:ptfx")
AddEventHandler("utk_oh:ptfx", function(method)
   TriggerClientEvent("utk_oh:ptfx_c", -1, method)
end)

RegisterServerEvent("utk_oh:alarm_s")
AddEventHandler("utk_oh:alarm_s", function(toggle)
    if Config.enablesound then
        TriggerClientEvent("utk_oh:alarm", -1, toggle)
    end
    TriggerClientEvent("utk_oh:policenotify", -1, toggle)
end)

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
	if first_spawn then
        SetTimeout(1000, function()
            if vRP.isUserInFaction({user_id,"Politie"}) or vRP.isUserInFaction({user_id,"SWAT"}) then
                TriggerClientEvent('utk_oh:IsCop', source)
            else
                TriggerClientEvent('utk_oh:IsNOTCop', source)
            end
			vRPpacificheistB.PacificJafSmecherSaMoaraMamaTa(source, {TTPcodPacificHeist})
		end)
	end
end)