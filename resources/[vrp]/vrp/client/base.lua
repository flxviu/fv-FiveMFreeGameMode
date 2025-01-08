cfg = module("cfg/client")

tvRP = {}
local players = {}-- keep track of connected players (server id)

-- bind client tunnel interface
Tunnel.bindInterface("vRP", tvRP)

-- get server interface
vRPserver = Tunnel.getInterface("vRP", "vRP")

-- add client proxy interface (same as tunnel interface)
Proxy.addInterface("vRP", tvRP)

local Wait = Citizen.Wait
local CreateThread = Citizen.CreateThread
local InvokeNative = Citizen.InvokeNative
_GPED = PlayerPedId()
_GCOORDS = vector3(0.0,0.0,0.0)
_GVEH = GetVehiclePedIsIn(_GPED,false)
_GHEALTH = GetEntityHealth(_GPED)

_GPLAYER = PlayerId()
_GVEHICLE = GetVehiclePedIsIn(_GPED,false)
_GISINVEH = IsPedInAnyVehicle(_GPED,false)
_GISDRIVER = (GetPedInVehicleSeat(_GVEHICLE, -1) == _GPED)
local islandVec = vector3(4840.571, -5174.425, 2.0)
CreateThread(function()
  while true do
    _GPED = PlayerPedId()
    _GCOORDS = GetEntityCoords(_GPED)
    _GVEH = GetVehiclePedIsIn(_GPED,false)
    _GHEALTH = GetEntityHealth(_GPED)
    _GPLAYER = PlayerId()
    _GVEHICLE = GetVehiclePedIsIn(_GPED,false)
    _GISINVEH = IsPedInAnyVehicle(_GPED,false)
    _GISDRIVER = (GetPedInVehicleSeat(_GVEHICLE, -1) == _GPED)
    for i = 1, 12 do
      EnableDispatchService(i, false)
    end
    SetPlayerHealthRechargeMultiplier(PlayerId(), 0)
    SetPlayerWantedLevel(PlayerId(), 0, false)
    SetPlayerWantedLevelNow(PlayerId(), false)
    RemoveAllPickupsOfType(0xDF711959) -- carbine rifle
    RemoveAllPickupsOfType(0xF9AFB48F) -- pistol
    RemoveAllPickupsOfType(0xA9355DCD) -- pumpshotgun
    SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)
    SetPlayerHealthRechargeMultiplier(PlayerId(), 0)
    SetVehicleDensityMultiplierThisFrame(0.0)
    SetPedDensityMultiplierThisFrame(0.0)
    SetRandomVehicleDensityMultiplierThisFrame(0.0)
    SetParkedVehicleDensityMultiplierThisFrame(0.0)
    SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
    SetGarbageTrucks(false)
    SetRandomBoats(false)
    SetCreateRandomCops(false) 
    SetCreateRandomCopsNotOnScenarios(false) 
    SetCreateRandomCopsOnScenarios(false) 
    
    local x,y,z = table.unpack(_GCOORDS)
    ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
    RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0)
    local dist = #(_GCOORDS - islandVec)
    if dist < 1900.0 then
      InvokeNative(0x9A9D1BA639675CF1, "HeistIsland", true)
      InvokeNative(0x5E1460624D194A38, true)
      InvokeNative(0xF74B1FFA4A15FBEA, true)
      InvokeNative(0x53797676AD34A9AA, false)
      SetAudioFlag('PlayerOnDLCHeist4Island', true)
      SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Zones', true, true)
      SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Disabled_Zones', false, true)
    else
        InvokeNative(0x9A9D1BA639675CF1, "HeistIsland", false)
        InvokeNative(0x5E1460624D194A38, false)
        InvokeNative(0xF74B1FFA4A15FBEA, false)
        InvokeNative(0x53797676AD34A9AA, true)
        SetAudioFlag('PlayerOnDLCHeist4Island', false)
        SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Zones', false, false)
        SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Disabled_Zones', false, false)
    end
    Wait(1024)
  end
end)


-- functions
function tvRP.teleport(x, y, z)
    tvRP.unjail()-- force unjail before a teleportation
    SetEntityCoords(PlayerPedId(), x + 0.0001, y + 0.0001, z + 0.0001, 1, 0, 0, 1)
    vRPserver.updatePos({x, y, z})
end

-- return x,y,z
function tvRP.getPosition()
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    return x, y, z
end

tvRP.subtitle = function(text, ms)
    ms = tonumber(ms)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(ms, 1)
end

-- return false if in exterior, true if inside a building
function tvRP.isInside()
    local x, y, z = tvRP.getPosition()
    return not (GetInteriorAtCoords(x, y, z) == 0)
end

-- return vx,vy,vz
function tvRP.getSpeed()
    local vx, vy, vz = table.unpack(GetEntityVelocity(PlayerPedId()))
    return math.sqrt(vx * vx + vy * vy + vz * vz)
end

local totalTickets = 0
local isAdmin = false

function tvRP.setAdmin()
    isAdmin = true
    Citizen.CreateThread(function ()
        while isAdmin do Wait(3000)
            SendNUIMessage({act = "tickete", tickete = string.format("%02d", totalTickets), value = true})
        end
    end)
end

RegisterNetEvent("alpha:TicketsUpdate")
AddEventHandler("alpha:TicketsUpdate", function(ticketCounter)
    totalTickets = ticketCounter
end)

tvRP.formatMoney = function(amount)
    local left, num, right = string.match(tostring(amount), '^([^%d]*%d)(%d*)(.-)$')
    return left .. (num:reverse():gsub('(%d%d%d)', '%1.'):reverse()) .. right
end

-- tinta --
spawned = true
crossHair = false

function tvRP.toggleWeaponCrosshair()
    crossHair = not crossHair
    if (crossHair) then
        tvRP.notify("~g~Ti-ai activat tinta de pe arme!")
    else
        tvRP.notify("~r~Ti-ai dezactivat tinta de pe arme!")
    end
end

local scopedWeapons =
    {
        100416529,
        205991906,
        3342088282
    }

function HashInTable(hash)
    for k, v in pairs(scopedWeapons) do
        if (hash == v) then
            return true
        end
    end
    
    return false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        while (crossHair == false) do
            if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
                local _, hash = GetCurrentPedWeapon(ped, true)
                
                if (not HashInTable(hash)) then
                    HideHudComponentThisFrame(14)
                end
            end
            Wait(0)
        end
    end
end)
function tvRP.selectNearestPlayer(radius, selfSelect)
     
    local pid = PlayerId()
    local nearPlayers, selected = {}, 0

    local pPos = _PLAYERCOORDS

    local activePlayers = GetActivePlayers()
    for _, player in ipairs(activePlayers) do
        if selfSelect or player ~= pid then
            local ped = GetPlayerPed(player)
            local distance = #(pPos - GetEntityCoords(ped))
            if distance <= radius then
                selected = 1
                table.insert(nearPlayers, {id = GetPlayerServerId(player), ped = ped, player = player})
            end
     end
    end

    if selected > 0 then
        local timeout = GetGameTimer() + 60000
        while timeout > GetGameTimer() do


            if not DoesEntityExist(nearPlayers[selected].ped) or not NetworkIsPlayerActive(nearPlayers[selected].player) then
                nearPlayers[selected] = nil
                for i = selected, #nearPlayers do
                    nearPlayers[i] = nearPlayers[i+1]
                end
                table.remove(nearPlayers, #nearPlayers)
                if #nearPlayers == 0 then
                    break
                end
            end

            local pos = GetEntityCoords(nearPlayers[selected].ped)
            DrawMarker(0,pos.x,pos.y,pos.z+1.0, 0.0,0.0,0.0,0.0,0.0,0.0,0.15,0.15,0.15,255,255,0,255,true,true,2,false,false,false,false)

            if IsControlJustPressed(0, 174) then
                selected = selected + 1
                if selected > #nearPlayers then
                    selected = 1
                end
            end
if IsControlJustPressed(0, 175) then
                selected = selected - 1
                if selected < 1 then
                    selected = #nearPlayers
                end
            end

            DisableControlAction(0, 177, false)
            if IsDisabledControlJustPressed(0, 177) then
                return false
            end

            if IsControlJustPressed(0, 191) then
                if nearPlayers[selected] then
                    return nearPlayers[selected].id
                end
            end

            Citizen.Wait(1)
        end
    end

    tvRP.notify("~r~Nimeni nu este langa tine.")
    return false
end
ClientPickupList = {"PICKUP_AMMO_BULLET_MP", "PICKUP_AMMO_FIREWORK", "PICKUP_AMMO_FIREWORK_MP", "PICKUP_AMMO_FLAREGUN", "PICKUP_AMMO_GRENADELAUNCHER", "PICKUP_AMMO_GRENADELAUNCHER_MP", "PICKUP_AMMO_HOMINGLAUNCHER", "PICKUP_AMMO_MG", "PICKUP_AMMO_MINIGUN", "PICKUP_AMMO_MISSILE_MP", "PICKUP_AMMO_PISTOL", "PICKUP_AMMO_RIFLE", "PICKUP_AMMO_RPG", "PICKUP_AMMO_SHOTGUN", "PICKUP_AMMO_SMG", "PICKUP_AMMO_SNIPER", "PICKUP_ARMOUR_STANDARD", "PICKUP_CAMERA", "PICKUP_CUSTOM_SCRIPT", "PICKUP_GANG_ATTACK_MONEY", "PICKUP_HEALTH_SNACK", "PICKUP_HEALTH_STANDARD", "PICKUP_MONEY_CASE", "PICKUP_MONEY_DEP_BAG", "PICKUP_MONEY_MED_BAG", "PICKUP_MONEY_PAPER_BAG", "PICKUP_MONEY_PURSE", "PICKUP_MONEY_SECURITY_CASE", "PICKUP_MONEY_VARIABLE", "PICKUP_MONEY_WALLET", "PICKUP_PARACHUTE", "PICKUP_PORTABLE_CRATE_FIXED_INCAR", "PICKUP_PORTABLE_CRATE_FIXED_INCAR_SMALL", "PICKUP_PORTABLE_CRATE_FIXED_INCAR_WITH_PASSENGERS", "PICKUP_PORTABLE_CRATE_UNFIXED", "PICKUP_PORTABLE_CRATE_UNFIXED_INAIRVEHICLE_WITH_PASSENGERS", "PICKUP_PORTABLE_CRATE_UNFIXED_INCAR", "PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_SMALL", "PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_WITH_PASSENGERS", "PICKUP_PORTABLE_CRATE_UNFIXED_LOW_GLOW", "PICKUP_PORTABLE_DLC_VEHICLE_PACKAGE", "PICKUP_PORTABLE_PACKAGE", "PICKUP_PORTABLE_PACKAGE_LARGE_RADIUS", "PICKUP_SUBMARINE", "PICKUP_VEHICLE_ARMOUR_STANDARD", "PICKUP_VEHICLE_CUSTOM_SCRIPT", "PICKUP_VEHICLE_CUSTOM_SCRIPT_LOW_GLOW", "PICKUP_VEHICLE_CUSTOM_SCRIPT_NO_ROTATE", "PICKUP_VEHICLE_HEALTH_STANDARD", "PICKUP_VEHICLE_HEALTH_STANDARD_LOW_GLOW", "PICKUP_VEHICLE_MONEY_VARIABLE", "PICKUP_VEHICLE_WEAPON_APPISTOL", "PICKUP_VEHICLE_WEAPON_ASSAULTSMG", "PICKUP_VEHICLE_WEAPON_COMBATPISTOL", "PICKUP_VEHICLE_WEAPON_GRENADE", "PICKUP_VEHICLE_WEAPON_MICROSMG", "PICKUP_VEHICLE_WEAPON_MOLOTOV", "PICKUP_VEHICLE_WEAPON_PISTOL", "PICKUP_VEHICLE_WEAPON_PISTOL50", "PICKUP_VEHICLE_WEAPON_SAWNOFF", "PICKUP_VEHICLE_WEAPON_SMG", "PICKUP_VEHICLE_WEAPON_SMOKEGRENADE", "PICKUP_VEHICLE_WEAPON_STICKYBOMB", "PICKUP_WEAPON_ADVANCEDRIFLE", "PICKUP_WEAPON_APPISTOL", "PICKUP_WEAPON_ASSAULTRIFLE", "PICKUP_WEAPON_ASSAULTRIFLE_MK2", "PICKUP_WEAPON_ASSAULTSHOTGUN", "PICKUP_WEAPON_ASSAULTSMG", "PICKUP_WEAPON_AUTOSHOTGUN", "PICKUP_WEAPON_BAT", "PICKUP_WEAPON_BATTLEAXE", "PICKUP_WEAPON_BOTTLE", "PICKUP_WEAPON_BULLPUPRIFLE", "PICKUP_WEAPON_BULLPUPRIFLE_MK2", "PICKUP_WEAPON_BULLPUPSHOTGUN", "PICKUP_WEAPON_CARBINERIFLE", "PICKUP_WEAPON_CARBINERIFLE_MK2", "PICKUP_WEAPON_COMBATMG", "PICKUP_WEAPON_COMBATMG_MK2", "PICKUP_WEAPON_COMBATPDW", "PICKUP_WEAPON_COMBATPISTOL", "PICKUP_WEAPON_COMPACTLAUNCHER", "PICKUP_WEAPON_COMPACTRIFLE", "PICKUP_WEAPON_CROWBAR", "PICKUP_WEAPON_DAGGER", "PICKUP_WEAPON_DBSHOTGUN", "PICKUP_WEAPON_DOUBLEACTION", "PICKUP_WEAPON_FIREWORK", "PICKUP_WEAPON_FLAREGUN", "PICKUP_WEAPON_FLASHLIGHT", "PICKUP_WEAPON_GRENADE", "PICKUP_WEAPON_GRENADELAUNCHER", "PICKUP_WEAPON_GUSENBERG", "PICKUP_WEAPON_GolfClub", "PICKUP_WEAPON_HAMMER", "PICKUP_WEAPON_HATCHET", "PICKUP_WEAPON_HEAVYPISTOL", "PICKUP_WEAPON_HEAVYSHOTGUN", "PICKUP_WEAPON_HEAVYSNIPER", "PICKUP_WEAPON_HEAVYSNIPER_MK2", "PICKUP_WEAPON_HOMINGLAUNCHER", "PICKUP_WEAPON_KNIFE", "PICKUP_WEAPON_KNUCKLE", "PICKUP_WEAPON_MACHETE", "PICKUP_WEAPON_MACHINEPISTOL", "PICKUP_WEAPON_MARKSMANPISTOL", "PICKUP_WEAPON_MARKSMANRIFLE", "PICKUP_WEAPON_MARKSMANRIFLE_MK2", "PICKUP_WEAPON_MG", "PICKUP_WEAPON_MICROSMG", "PICKUP_WEAPON_MINIGUN", "PICKUP_WEAPON_MINISMG", "PICKUP_WEAPON_MOLOTOV", "PICKUP_WEAPON_MUSKET", "PICKUP_WEAPON_NIGHTSTICK", "PICKUP_WEAPON_PETROLCAN", "PICKUP_WEAPON_PIPEBOMB", "PICKUP_WEAPON_PISTOL", "PICKUP_WEAPON_PISTOL50", "PICKUP_WEAPON_PISTOL_MK2", "PICKUP_WEAPON_POOLCUE", "PICKUP_WEAPON_PROXMINE", "PICKUP_WEAPON_PUMPSHOTGUN", "PICKUP_WEAPON_PUMPSHOTGUN_MK2", "PICKUP_WEAPON_RAILGUN", "PICKUP_WEAPON_RAYCARBINE", "PICKUP_WEAPON_RAYMINIGUN", "PICKUP_WEAPON_RAYPISTOL", "PICKUP_WEAPON_REVOLVER", "PICKUP_WEAPON_REVOLVER_MK2", "PICKUP_WEAPON_RPG", "PICKUP_WEAPON_SAWNOFFSHOTGUN", "PICKUP_WEAPON_SMG", "PICKUP_WEAPON_SMG_MK2", "PICKUP_WEAPON_SMOKEGRENADE", "PICKUP_WEAPON_SNIPERRIFLE", "PICKUP_WEAPON_SNSPISTOL", "PICKUP_WEAPON_SNSPISTOL_MK2", "PICKUP_WEAPON_SPECIALCARBINE", "PICKUP_WEAPON_SPECIALCARBINE_MK2", "PICKUP_WEAPON_STICKYBOMB", "PICKUP_WEAPON_STONE_HATCHET", "PICKUP_WEAPON_STUNGUN", "PICKUP_WEAPON_SWITCHBLADE", "PICKUP_WEAPON_VINTAGEPISTOL", "PICKUP_WEAPON_WRENCH"}

function RemoveWeaponDrops()
    for alpha = 1, #ClientPickupList do
        N_0x616093ec6b139dd9(PlayerId(), GetHashKey(ClientPickupList[alpha]), false)
        RemoveAllPickupsOfType(GetHashKey(ClientPickupList[alpha]))
    end
end

AddEventHandler("playerSpawned", function()
    Wait(10000)
    RemoveWeaponDrops()
end)

itemsOnGround = {}
function KeyboardInput(TextEntry, ExampleText, MaxStringLenght, NoSpaces)
    AddTextEntry(GetCurrentResourceName() .. '_KeyboardHead', TextEntry)
    DisplayOnscreenKeyboard(1, GetCurrentResourceName() .. '_KeyboardHead', '', ExampleText, '', '', '', MaxStringLenght)
    
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        if NoSpaces == true then
            drawNotification('~y~NO SPACES!')
        end
        Citizen.Wait(0)
    end
    
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        return result
    else
        Citizen.Wait(500)
        return nil
    end
end


function tvRP.teleport(x, y, z)
    local targetPed = PlayerPedId()
    local targetVeh = GetVehiclePedIsUsing(targetPed)
    if (IsPedInAnyVehicle(targetPed)) then
        targetPed = targetVeh
    end
    SetEntityCoords(targetPed, x + 0.0001, y + 0.0001, z + 0.0001, 1, 0, 0, 1)
    vRPserver.updatePos({x, y, z})
end

function tvRP.getCamDirection()
    local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(PlayerPedId())
    local pitch = GetGameplayCamRelativePitch()
    
    local x = -math.sin(heading * math.pi / 180.0)
    local y = math.cos(heading * math.pi / 180.0)
    local z = math.sin(pitch * math.pi / 180.0)
    
    -- normalize
    local len = math.sqrt(x * x + y * y + z * z)
    if len ~= 0 then
        x = x / len
        y = y / len
        z = z / len
    end
    
    return x, y, z
end

function tvRP.addPlayer(player)
    players[player] = true
end

function tvRP.removePlayer(player)
    players[player] = nil
end

function tvRP.getNearestPlayers(radius)
    local r = {}
    
    local ped = GetPlayerPed(i)
    local pid = PlayerId()
    local px, py, pz = tvRP.getPosition()
    
    for k, v in pairs(players) do
        local player = GetPlayerFromServerId(k)
        
        if v and player ~= pid and NetworkIsPlayerConnected(player) then
            local oped = GetPlayerPed(player)
            local x, y, z = table.unpack(GetEntityCoords(oped, true))
            local distance = GetDistanceBetweenCoords(x, y, z, px, py, pz, true)
            if distance <= radius then
                r[GetPlayerServerId(player)] = distance
            end
        end
    end
    
    return r
end

function tvRP.getNearestPlayer(radius)
    local p = nil
    
    local players = tvRP.getNearestPlayers(radius)
    local min = radius + 10.0
    for k, v in pairs(players) do
        if v < min then
            min = v
            p = k
        end
    end
    
    return p
end

function tvRP.sendSuccess(msg, time)
    tvRP.notify(msg, "success", time)
end

function tvRP.notify(msg, nType, nTitle, nMsec)
    local function clearColors(str)
      local idf = string.match(str, "~.~")
      while idf do
          str = str:gsub(idf, "")
          idf = string.match(str, "~.~")
      end
      idf = string.match(str, "\n")
      while idf do
          str = str:gsub(idf, " | ")
          idf = string.match(str, "\n")
      end
      return str
    end
    local notifyWords = {
      ["Succes"] = {"success", "Success"},
      ["Eroare"] = {"error", "Error"},
      ["Heaven"] = {"info", "Info"}
    }
    msg = clearColors(msg)
    for word, data in pairs(notifyWords) do
      if string.find(msg, word) then
        msg = msg:gsub(word.." ", ""):gsub(word..": ", "")
        nType, nTitle = table.unpack(data)
      end
    end
    if nType == "success" then nTitle = "Succes" end
    TriggerEvent("vrp_notify:Alert", nTitle or "Info", msg, 5000, nType or "info")
end

function tvRP.notifyPicture(icon, type, sender, title, text, r, g, b)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    SetNotificationMessage(icon, icon, true, type, sender, title, text)
    if r and g and b ~= nil then
        SetNotificationBackgroundColor(r, g, b)
    end
    DrawNotification(false, true)
end

function tvRP.playScreenEffect(name, duration)
    if duration < 0 then -- loop
        StartScreenEffect(name, 0, true)
    else
        StartScreenEffect(name, 0, true)
        
        Citizen.CreateThread(function()-- force stop the screen effect after duration+1 seconds
            Citizen.Wait(math.floor((duration + 1) * 1000))
            StopScreenEffect(name)
        end)
    end
end

function tvRP.stopScreenEffect(name)
    StopScreenEffect(name)
end

-- ANIM
-- animations dict and names: http://docs.ragepluginhook.net/html/62951c37-a440-478c-b389-c471230ddfc5.htm
local anims = {}
local anim_ids = Tools.newIDGenerator()

-- play animation (new version)
-- upper: true, only upper body, false, full animation
-- seq: list of animations as {dict,anim_name,loops} (loops is the number of loops, default 1) or a task def (properties: task, play_exit)
-- looping: if true, will infinitely loop the first element of the sequence until stopAnim is called
function tvRP.playAnim(upper, seq, looping)
    if seq.task ~= nil then -- is a task (cf https://github.com/ImagicTheCat/vRP/pull/118)
        tvRP.stopAnim(true)
        
        local ped = PlayerPedId()
        if seq.task == "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" then -- special case, sit in a chair
            local x, y, z = tvRP.getPosition()
            TaskStartScenarioAtPosition(ped, seq.task, x, y, z - 1, GetEntityHeading(ped), 0, 0, false)
        else
            TaskStartScenarioInPlace(ped, seq.task, 0, not seq.play_exit)
        end
    else -- a regular animation sequence
        tvRP.stopAnim(upper)
        
        local flags = 0
        if upper then flags = flags + 48 end
        if looping then flags = flags + 1 end
        
        Citizen.CreateThread(function()
                -- prepare unique id to stop sequence when needed
                local id = anim_ids:gen()
                anims[id] = true
                
                for k, v in pairs(seq) do
                    local dict = v[1]
                    local name = v[2]
                    local loops = v[3] or 1
                    
                    for i = 1, loops do
                        if anims[id] then -- check animation working
                            local first = (k == 1 and i == 1)
                            local last = (k == #seq and i == loops)
                            
                            -- request anim dict
                            RequestAnimDict(dict)
                            local i = 0
                            while not HasAnimDictLoaded(dict) and i < 1000 do -- max time, 10 seconds
                                Citizen.Wait(10)
                                RequestAnimDict(dict)
                                i = i + 1
                            end
                            
                            -- play anim
                            if HasAnimDictLoaded(dict) and anims[id] then
                                local inspeed = 8.0001
                                local outspeed = -8.0001
                                if not first then inspeed = 2.0001 end
                                if not last then outspeed = 2.0001 end
                                
                                TaskPlayAnim(PlayerPedId(), dict, name, inspeed, outspeed, -1, flags, 0, 0, 0, 0)
                            end
                            
                            Citizen.Wait(0)
                            while GetEntityAnimCurrentTime(PlayerPedId(), dict, name) <= 0.95 and IsEntityPlayingAnim(PlayerPedId(), dict, name, 3) and anims[id] do
                                Citizen.Wait(0)
                            end
                        end
                    end
                end
                
                -- free id
                anim_ids:free(id)
                anims[id] = nil
        end)
    end
end

-- stop animation (new version)
-- upper: true, stop the upper animation, false, stop full animations
function tvRP.stopAnim(upper)
    anims = {}-- stop all sequences
    if upper then
        ClearPedSecondaryTask(PlayerPedId())
    else
        ClearPedTasks(PlayerPedId())
    end
end

-- RAGDOLL
local ragdoll = false

-- set player ragdoll flag (true or false)
function tvRP.setRagdoll(flag)
    ragdoll = flag
end

-- ragdoll thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if ragdoll then
            SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
        end
    end
end)

function tvRP.playSpatializedSound(dict, name, x, y, z, range)
    PlaySoundFromCoord(-1, name, x + 0.0001, y + 0.0001, z + 0.0001, dict, 0, range + 0.0001, 0)
end

-- play sound
function tvRP.playSound(dict, name)
    PlaySound(-1, name, dict, 0, 0, 1)
end

AddEventHandler("playerSpawned", function()
    TriggerServerEvent("vRPcli:playerSpawned")
end)

AddEventHandler("onPlayerDied", function(player, reason)
    TriggerServerEvent("vRPcli:playerDied")
end)

AddEventHandler("onPlayerKilled", function(player, killer, reason)
    TriggerServerEvent("vRPcli:playerDied")
end)

-- voice proximity computation
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        local ped = PlayerPedId()
        local proximity = cfg.voice_proximity
        
        if IsPedSittingInAnyVehicle(ped) then
            local veh = GetVehiclePedIsIn(ped, false)
            local hash = GetEntityModel(veh)
            -- make open vehicles (bike,etc) use the default proximity
            if IsThisModelACar(hash) or IsThisModelAHeli(hash) or IsThisModelAPlane(hash) then
                proximity = cfg.voice_proximity_vehicle
            end
        elseif tvRP.isInside() then
            proximity = cfg.voice_proximity_inside
        end
        
        NetworkSetTalkerProximity(proximity + 0.0001)
    end
end)

TriggerServerEvent('VRP:CheckID')

RegisterNetEvent('VRP:CheckIdRegister')
AddEventHandler('VRP:CheckIdRegister', function()
    TriggerEvent('playerSpawned', GetEntityCoords(PlayerPedId()))
end)


hasMouthCovered = false

function tvRP.coverMouth(state)
    if (state == true) then
        hasMouthCovered = true
    else
        hasMouthCovered = false
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if (hasMouthCovered == false) then
            local ped = PlayerPedId()
            local proximity = cfg.voice_proximity
            
            if IsPedSittingInAnyVehicle(ped) then
                local veh = GetVehiclePedIsIn(ped, false)
                local hash = GetEntityModel(veh)
                -- make open vehicles (bike,etc) use the default proximity
                if IsThisModelACar(hash) or IsThisModelAHeli(hash) or IsThisModelAPlane(hash) then
                    proximity = cfg.voice_proximity_vehicle
                end
            elseif tvRP.isInside() then
                proximity = cfg.voice_proximity_inside
            end
            NetworkSetTalkerProximity(proximity + 0.0001)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1800000)-- odata la jumatate de ora se adauga cate 0.50h in scoreboard, daca folositi scoreboard ca pe Wattz.
        vRPserver.updateHoursPlayed({0.50})
    end
end)

function DrawImage3D(name1, name2, x, y, z, width, height, rot, r, g, b, alpha)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, true)
    
    if onScreen then
        local width = (1 / dist) * width
        local height = (1 / dist) * height
        local fov = (1 / GetGameplayCamFov()) * 100
        local width = width * fov
        local height = height * fov
        
        local CoordFrom = GetEntityCoords(PlayerPedId(), true)
        local RayHandle = StartShapeTestRay(CoordFrom.x, CoordFrom.y, CoordFrom.z, x, y, z, -1, PlayerPedId(), 0)
        local _, _, _, _, object = GetShapeTestResult(RayHandle)
        if (object == 0) or (object == nil) then
            DrawSprite(name1, name2, _x, _y, width, height, rot, r, g, b, alpha)
        end
    end
end

local passengerDriveBy = true

Citizen.CreateThread(function()
    while true do
        Wait(1)
        
        playerPed = GetPlayerPed(-1)
        car = GetVehiclePedIsIn(playerPed, false)
        if car then
            if GetPedInVehicleSeat(car, -1) == playerPed then
                SetPlayerCanDoDriveBy(PlayerId(), false)
            elseif passengerDriveBy then
                SetPlayerCanDoDriveBy(PlayerId(), true)
            else
                SetPlayerCanDoDriveBy(PlayerId(), false)
            end
        end
    end
end)

checkTime = 60 --Minutes
deleteTime = 15 --Seconds

local enumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
        enum.destructor = nil
        enum.handle = nil
    end
}

local function getEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
            disposeFunc(iter)
            return
        end
        
        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, enumerator)
        
        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next
        
        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end

function getVehicles()
    return getEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

RegisterNetEvent("stergeMasini")
AddEventHandler("stergeMasini", function(sec)
    deleteAllVehs(sec)
end)

function deleteAllVehs(theTime)
    SetTimeout(theTime * 1000, function()
        theVehicles = getVehicles()
        for entity in theVehicles do
            local veh = entity
            if DoesEntityExist(veh) then
                if GetEntityModel(veh) ~= GetHashKey("rcbandito") then
                    if not IsEntityAttached(veh) then
                        if ((GetPedInVehicleSeat(veh, -1)) == false) or ((GetPedInVehicleSeat(veh, -1)) == nil) or ((GetPedInVehicleSeat(veh, -1)) == 0) then
                            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
                            
                            if (DoesEntityExist(veh)) then
                                DeleteEntity(veh)
                            end
                        end
                    end
                end
            end
        end
    end)
end
CreateThread(function()
    local punch = GetHashKey('WEAPON_UNARMED')
    local bat = GetHashKey('WEAPON_BAT')
    
    local fallingDmg = GetHashKey('WEAPON_FALL')
    local knife = GetHashKey('WEAPON_KNIFE')
    local airsoft = GetHashKey('WEAPON_SNSPISTOL')
    
    local animal = GetHashKey('WEAPON_ANIMAL')
    local cougar = GetHashKey('WEAPON_COUGAR')
    local pulan = GetHashKey('WEAPON_NIGHTSTICK')

    local snowball = GetHashKey('WEAPON_SNOWBALL')

    while true do
        SetWeaponDamageModifierThisFrame(airsoft, 0.0) -- WEAPON_SNSPISTOL
        SetWeaponDamageModifierThisFrame(snowball, 0.0)
        SetWeaponDamageModifierThisFrame(fallingDmg, 0.1)
        SetWeaponDamageModifierThisFrame(punch, 0.2)
        SetWeaponDamageModifierThisFrame(bat, 0.5)
        SetWeaponDamageModifierThisFrame(airsoft, 0.2)
        SetWeaponDamageModifierThisFrame(knife, 0.6)
        SetWeaponDamageModifierThisFrame(animal, 0.0)
        SetWeaponDamageModifierThisFrame(cougar, 0.0)
        SetWeaponDamageModifierThisFrame(pulan, 0.1)
        Wait(1)
    end
end)

ServerCallbacks = {}
CurrentRequestId = 0

function tvRP.TriggerCallback(name, callback, ...)
    ServerCallbacks[CurrentRequestId] = callback
    TriggerServerEvent(GetCurrentResourceName() .. ":triggerServerCallback", name, CurrentRequestId, ...)

    if CurrentRequestId < 65535 then
        CurrentRequestId = CurrentRequestId + 1
    else
        CurrentRequestId = 0
    end
end

RegisterNetEvent(GetCurrentResourceName() .. ":serverCallback")
AddEventHandler(GetCurrentResourceName() .. ":serverCallback", function(requestId, ...)
    if ServerCallbacks[requestId] then
        ServerCallbacks[requestId](...)
        ServerCallbacks[requestId] = nil
    end
end)