--bind client tunnel interface
vRPbm = {}
Tunnel.bindInterface("vRP_basic_menu", vRPbm)
vRPserver = Tunnel.getInterface("vRP", "vRP_basic_menu")
HKserver = Tunnel.getInterface("vrp_hotkeys", "vRP_basic_menu")
BMserver = Tunnel.getInterface("vRP_basic_menu", "vRP_basic_menu")
vRP = Proxy.getInterface("vRP")

local fontsLoaded = false
local fontId
Citizen.CreateThread(function()
    Citizen.Wait(1000)
    RegisterFontFile('wmk')
    fontId = RegisterFontId('Freedom Font')
    fontsLoaded = true
end)

checkpoints = 0
local stage = 1
aJailReason = " "

local frozen = false
local unfrozen = false
local freeze = false
function vRPbm.loadFreeze(freeze)
    freeze = not freeze
    frozen = true
end

function vRPbm.setInAJail(jailTime, jailReason)
    aJailReason = jailReason
    checkpoints = jailTime
end

local locatiijail = {}
RegisterNetEvent("ajail:config", function(tbl)
    if type(tbl) == "table" then 
        locatiijail = tbl
    end
end)

function start(task)
    vRP.playAnim({false, {task = task.anim}, false})
    SetTimeout(25000, function()
        vRP.stopAnim({false})
        EnableControlAction(0, 311, true)
        task.active = true
        SetTimeout(100 * 10, function()task.active = false; end)
    end)
end

function adminjailtxt(text, font, centre, x, y, scale, r, g, b, a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

Citizen.CreateThread(function()
    local x2, y2, z2 = 38.469585418701, -373.44845581055, 45.501087188721
    local mainloc = vec3(30.154348373413,-402.00085449219,45.557666778564)
    local ticks = 1000
    while true do
        Wait(30)
        while (checkpoints > 0) do
            Wait(0)
            local playerPos = GetEntityCoords(PlayerPedId(), true)
            local px, py, pz = playerPos.x, playerPos.y, playerPos.z
            for k, v in pairs(locatiijail) do
                local once = false;
                ticks = 1
                while not v.active and checkpoints > 0 do
                    local playerPos = GetEntityCoords(PlayerPedId(), true)
                    if #(playerPos - mainloc) > 50.0 then
                        SetEntityCoords(PlayerPedId(), mainloc.x, mainloc.y, mainloc.z)
                        vRP.notify({"Eroare: Ai incercat sa fugi de la jail, nu mai incerca. :)"})
                    end
                    Wait(1)
                    SetEntityHealth(PlayerPedId(), 200)
                    DisableControlAction(0, 21, true)
                    DisableControlAction(0, 22, true)
                    DisableControlAction(0, 24, true)
                    DisableControlAction(0, 25, true)
                    DisableControlAction(0, 47, true)
                    DisableControlAction(0, 58, true)
                    DisableControlAction(0, 263, true)
                    DisableControlAction(0, 23, true)
                    DisableControlAction(0, 264, true)
                    DisableControlAction(0, 29, true)
                    DisableControlAction(0, 121, true)
                    DisableControlAction(0, 311, true)
                    DisableControlAction(0, 20, true)
                    DisableControlAction(0, 73, true)
                    DisableControlAction(0, 257, true)
                    DisableControlAction(0, 36, true)
                    DisableControlAction(0, 140, true)
                    DisableControlAction(0, 141, true)
                    DisableControlAction(0, 142, true)
                    DisableControlAction(0, 249, true)
                    DisableControlAction(0, 246, true)
                    DisableControlAction(0, 288, true)
                    DisableControlAction(0, 143, true)
                    DisableControlAction(0, 75, true)
                    DisableControlAction(27, 75, true)
                    adminjailtxt("~b~Checkpoint-uri: ~w~" .. checkpoints .. "\n~r~Motiv: ~w~" .. aJailReason, 4, 1, 0.5, 0.80, 0.60, 255, 255, 255, 255)
                    local playerPos = GetEntityCoords(PlayerPedId(), true)
                    DrawMarker(0, v.pos, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 50.00, 97, 195, 0, 90, 1, 0, 0, 0)
                    DrawMarker(21, locatiijail[stage].cds.x, locatiijail[stage].cds.y, locatiijail[stage].cds.z, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 166, 35, 232, 200, 0, 0, 0, 1)
                    DrawMarker(21, locatiijail[stage + 1].cds.x, locatiijail[stage + 1].cds.y, locatiijail[stage + 1].cds.z, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 0, 153, 255, 200, 0, 0, 0, 1)
                    if #(playerPos - locatiijail[stage].cds) <= 0.5 and not once then
                        once = true
                        locatiijail[stage].active = true
                        checkpoints = checkpoints - 1
                        BMserver.updateCheckpoints({checkpoints})
                        start(v)
                        SetTimeout(1, function()locatiijail[stage].active = false; stage = stage + 1; if stage == 19 then stage = 1 end; end)
                    end
                end
                Wait(ticks)
            end
            if #(vector3(x2, y2, z2) - vector3(px, py, pz)) > 40.0 then
                SetEntityCoords(PlayerPedId(), x2, y2, z2)
            end
        end
    end
end)

local frozen = false
local unfrozen = false
function vRPbm.loadFreeze(freeze)
    if freeze then
        frozen = true
        unfrozen = false
    else
        unfrozen = true
    end
end

local playerMask = GetPedDrawableVariation(PlayerPedId(), 1) or 0
local playerMaskColor = GetPedTextureVariation(PlayerPedId(), 1) or 0

RegisterCommand("maskoff", function()
    local ped = PlayerPedId()
    playerMask = GetPedDrawableVariation(ped, 1)
    playerMaskColor = GetPedTextureVariation(ped, 1)
    if playerMask > 0 then
        vRP.playAnim({false, {{"mp_masks@standard_car@ds@", "put_on_mask"}}, false})
        Citizen.Wait(800)
        SetPedComponentVariation(ped, 1, 0, 0, 0)
        vRP.notify({"Succes ~w~Ti-ai dat ~r~masca ~w~jos"})
    else
        vRP.notify({"Eroare: ~w~Nu ai nici o ~r~masca ~w~pe cap"})
    end
end)

RegisterCommand("maskon", function()
    if playerMask > 0 then
        vRP.playAnim({false, {{"mp_masks@standard_car@ds@", "put_on_mask"}}, false})
        Citizen.Wait(800)
        SetPedComponentVariation(PlayerPedId(), 1, (playerMask or 0), (playerMaskColor or 0), 0)
        vRP.notify({"Succes: ~w~Ti-ai pus ~r~masca ~w~pe cap"})
    else
        vRP.notify({"Eroare: ~w~Nu ai nici o ~r~masca ~w~in buzunar"})
    end
end)

function vRPbm.spawnVehicle(model)
    -- load vehicle model
    local i = 0
    local mhash = GetHashKey(model)
    while not HasModelLoaded(mhash) and i < 1000 do
        if math.fmod(i, 100) == 0 then
            vRP.notify({"Info: ~p~Masina se incarca"})
        end
        RequestModel(mhash)
        Citizen.Wait(30)
        i = i + 1
    end
    
    if HasModelLoaded(mhash) then
        local x, y, z = vRP.getPosition({})
        local nveh = CreateVehicle(mhash, x, y, z + 0.5, GetEntityHeading(PlayerPedId()), true, false)
        SetVehicleOnGroundProperly(nveh)
        SetEntityInvincible(nveh, false)
        SetPedIntoVehicle(PlayerPedId(), nveh, -1)
        Citizen.InvokeNative(0xAD738C3085FE7E11, nveh, true, true)
        SetVehicleHasBeenOwnedByPlayer(nveh, true)
        SetModelAsNoLongerNeeded(mhash)
        SetVehicleNumberPlateText(nveh, "SPAWNVEH")
        vRP.notify({"Succes: ~g~Masina spawnata cu succes"})
    else
        vRP.notify({"Eroare: ~r~Model masina invalid"})
    end
end

local maleModel = GetHashKey("mp_m_freemode_01")
local femaleModel = GetHashKey("mp_f_freemode_01")

function vRPbm.getArmour()
    return GetPedArmour(PlayerPedId())
end

function vRPbm.setArmour(armour, vest)
    local ped = PlayerPedId()
    if vest then
        
        RequestAnimDict("clothingtie")
        while not HasAnimDictLoaded("clothingtie") do
            Citizen.Wait(1)
        end
        TaskPlayAnim(ped, "clothingtie", "try_tie_negative_a", 3.0, 3.0, 2000, 01, 0, false, false, false)
        
        local model = GetEntityModel(ped)
        
        if model == maleModel then
            SetPedComponentVariation(ped, 9, 6, 1, 2)--Bulletproof Vest
        elseif model == femaleModel then
            SetPedComponentVariation(ped, 9, 6, 1, 2)
        end
    end
    local n = math.floor(armour)
    SetPedArmour(ped, n)
end

 

RegisterNetEvent('clearskin:success')
AddEventHandler('clearskin:success', function()
    local ped = PlayerPedId({player})
    ClearPedBloodDamage(ped)
    ResetPedVisibleDamage(ped)
    ClearPedWetness(ped)
end)
