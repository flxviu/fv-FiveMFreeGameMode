-- this module define some police tools and functions

local handcuffed = false
local cop = false

--Skrypt By Ruski, Contact Information @Ruski#0001 on Discord, Made For PlanetaRP  Si tradus de radu pt vrp

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}




local arrst					= false		-- Zostaw na False innaczej bedzie aresztowac na start Skryptu                         --- Astea sa le traduca pula mea
local arest_on				= false		-- Zostaw na False innaczej bedziesz Arresztowany na start Skryptu
 
local variabila3			= 'mp_arrest_paired'	-- Sekcja Katalogu Animcji
local variabila2 			= 'cop_p2_back_left'	-- Animacja Aresztujacego
local variabila1			= 'crook_p2_back_left'	-- Animacja Aresztowanego
--local Ostatnioarest_on		= 0						-- Mozna sie domyslec ;) 



RegisterNetEvent('mita:arrestonway')
AddEventHandler('mita:arrestonway', function(target)             -- sa fac rost de asta in server side
	arest_on = true

	local playerPed = PlayerPedId()
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

	RequestAnimDict(variabila3)

	while not HasAnimDictLoaded(variabila3) do
		Citizen.Wait(10)
	end

	AttachEntityToEntity(PlayerPedId(), targetPed, 11816, -0.1, 0.45, 0.0, 0.0, 0.0, 20.0, false, false, false, false, 20, false)
	TaskPlayAnim(playerPed, variabila3, variabila1, 8.0, -8.0, 5500, 33, 0, false, false, false)

	Citizen.Wait(950)
	DetachEntity(PlayerPedId(), true, false)

	arest_on = false
end) 


RegisterNetEvent('radu:arrest')
AddEventHandler('radu:arrest', function()
	local playerPed = PlayerPedId()

	RequestAnimDict(variabila3)

	while not HasAnimDictLoaded(variabila3) do
		Citizen.Wait(10)
	end

	TaskPlayAnim(playerPed, variabila3, variabila2, 8.0, -8.0, 5500, 33, 0, false, false, false)

	Citizen.Wait(3000)

	arrst = false

end)

function tvRP.toggleInEvent()
  inEvent = not inEvent
end

function tvRP.setInEvent(flag)
  if inEvent ~= flag then
    tvRP.toggleInEvent()
  end
end

function tvRP.isInEvent()
  return inEvent
end

-- set player as cop (true or false)
--[[function tvRP.setCop(flag)
  cop = flag
  SetPedAsCop(PlayerPedId(),flag)
end]]

-- HANDCUFF

function tvRP.toggleHandcuff()
  handcuffed = not handcuffed

  SetEnableHandcuffs(PlayerPedId(), handcuffed)
  if handcuffed then
    tvRP.playAnim(true,{{"mp_arresting","idle",1}},true)
  else
    tvRP.stopAnim(true)
    SetPedStealthMovement(PlayerPedId(),false,"") 
  end
end

function tvRP.setHandcuffed(flag)
  if handcuffed ~= flag then
    tvRP.toggleHandcuff()
  end
end

function tvRP.isHandcuffed()
  return handcuffed
end

-- (experimental, based on experimental getNearestVehicle)
function tvRP.putInNearestVehicleAsPassenger(radius)
  local veh = tvRP.getNearestVehicle(radius)

  if IsEntityAVehicle(veh) then
    for i=1,math.max(GetVehicleMaxNumberOfPassengers(veh),3) do
      if IsVehicleSeatFree(veh,i) then
        SetPedIntoVehicle(PlayerPedId(),veh,i)
        return true
      end
    end
  end
  
  return false
end

function tvRP.putInNetVehicleAsPassenger(net_veh)
  local veh = NetworkGetEntityFromNetworkId(net_veh)
  if IsEntityAVehicle(veh) then
    for i=1,GetVehicleMaxNumberOfPassengers(veh) do
      if IsVehicleSeatFree(veh,i) then
        SetPedIntoVehicle(PlayerPedId(),veh,i)
        return true
      end
    end
  end
end

function tvRP.putInVehiclePositionAsPassenger(x,y,z)
  local veh = tvRP.getVehicleAtPosition(x,y,z)
  if IsEntityAVehicle(veh) then
    for i=1,GetVehicleMaxNumberOfPassengers(veh) do
      if IsVehicleSeatFree(veh,i) then
        SetPedIntoVehicle(PlayerPedId(),veh,i)
        return true
      end
    end
  end
end

-- keep handcuffed animation
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(15000)
    if handcuffed then
      tvRP.playAnim(true,{{"mp_arresting","idle",1}},true)
    end
  end
end)

-- force stealth movement while handcuffed (prevent use of fist and slow the player)
Citizen.CreateThread(function()
  while true do


    Citizen.Wait(1000)
    while handcuffed do 
      Citizen.Wait(0)
      SetPedStealthMovement(PlayerPedId(),true,"")
      DisableControlAction(0,21,true) -- disable sprint
      DisableControlAction(0,24,true) -- disable attack
      DisableControlAction(0,25,true) -- disable aim
      DisableControlAction(0,47,true) -- disable weapon
      DisableControlAction(0,58,true) -- disable weapon
      DisableControlAction(0,263,true) -- disable melee
      DisableControlAction(0,264,true) -- disable melee
      DisableControlAction(0,257,true) -- disable melee
      DisableControlAction(0,140,true) -- disable melee
      DisableControlAction(0,141,true) -- disable melee
      DisableControlAction(0,142,true) -- disable melee
      DisableControlAction(0,143,true) -- disable melee
      DisableControlAction(0,75,true) -- disable exit vehicle
      DisableControlAction(27,75,true) -- disable exit vehicle
    end

  end
end)

-- JAIL

local jail = nil

-- jail the player in a no-top no-bottom cylinder 
function tvRP.jail(x,y,z,radius)
  tvRP.teleport(x,y,z) -- teleport to center
  jail = {x+0.0001,y+0.0001,z+0.0001,radius+0.0001}
end

-- unjail the player
function tvRP.unjail()
  jail = nil
end

function tvRP.isJailed()
  return jail ~= nil
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1500)
    while jail do 
      Citizen.Wait(5)
      local x,y,z = tvRP.getPosition()

      local dx = x-jail[1]
      local dy = y-jail[2]
      local dist = math.sqrt(dx*dx+dy*dy)

      if dist >= jail[4] then
        local ped = PlayerPedId()
        SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001) -- stop player

        -- normalize + push to the edge + add origin
        dx = dx/dist*jail[4]+jail[1]
        dy = dy/dist*jail[4]+jail[2]

        -- teleport player at the edge
        SetEntityCoordsNoOffset(ped,dx,dy,z,true,true,true)
    end
  
    end
  end
end)


local wanted = {}

local wanted_level = 0

local cops = {}

RegisterNetEvent('C_WANTED:addPlayerToWantedList', function(nId,level)
    wanted[nId] = tonumber(level)
end)

RegisterNetEvent('C_WANTED:removePlayerFromWantedList', function(nId)
    wanted[nId] = nil
end)

local getWantedTableLength = function()
    local count = 0
    for _, p in pairs(wanted) do count = count + 1 end
    return count;
end

RegisterNetEvent('C_WANTED:startWantedLoop', function()
    Citizen.CreateThread(function()
        while 1 do
            Wait(1000)
            if (getWantedTableLength() > 0) then
                SetPedAsCop(PlayerPedId(), true)
                for serverId, wantedLevel in pairs(wanted) do
                    local player = GetPlayerFromServerId(serverId)
                    if NetworkIsPlayerActive(player) then

                        local ped = GetPlayerPed(player)
                        local blip = GetBlipFromEntity(ped)

                        if not DoesBlipExist(blip) then

                            blip = AddBlipForEntity(ped)
                            SetBlipSprite(blip, 1)
                            ShowHeadingIndicatorOnBlip(blip, 1)
                            ShowNumberOnBlip(blip, wantedLevel)
                            SetBlipColour(blip, 2)
                            SetBlipAsFriendly(blip, false)

                        else
                            local blipSprite = GetBlipSprite(blip)
                            if GetEntityHealth(ped) <= 105 then
                                if blipSprite ~= 274 then
                                    SetBlipSprite(blip, 274)
                                    ShowHeadingIndicatorOnBlip(blip, 0)
                                end
                            else
                                if blipSprite ~= 1 then
                                    SetBlipSprite(blip, 1)
                                    SetBlipColour(blip, 2)
                                    SetBlipAsFriendly(blip, false)
                                    ShowHeadingIndicatorOnBlip(blip, 1)
                                end
                            end
                            ShowNumberOnBlip(blip, wantedLevel)
                            SetBlipRotation(blip, math.ceil( GetEntityHeading(ped) ) )
                            SetBlipNameToPlayerName(blip, player)
                            SetBlipScale(blip, 0.85)
                            SetBlipAlpha(blip, 255)

                        end

                    end

                end

            end

        end
    end)

end)


RegisterNetEvent('C_WANTED:displayLocalWanted', function(level)
    wanted_level = level
    SetFakeWantedLevel(tonumber(level))
    Citizen.CreateThread(function()
        while wanted_level >= 1 do 
            Wait(0)
            ShowHudComponentThisFrame(1)
        end
    end)    
    if wanted_level <= 0 then
        for serverId,_ in pairs(cops) do
            local player = GetPlayerFromServerId(serverId)
            if NetworkIsPlayerActive(player) then
                SetPedAsCop(GetPlayerPed(player), false)
            end
        end
    end

end)

RegisterNetEvent('C_WANTED:addCop', function(sId)
    cops[sId] = true 
end)

RegisterNetEvent('C_WANTED:removeCop', function(sId)
    cops[sId] = nil
end)

RegisterNetEvent('C_WANTED:sendTableOfWantedPlayers', function(t)
    if not type(t) == 'table' then return end;
    wanted = t
end)


local weaponz = {
  'weapon_pistol',
  'weapon_pistol_mk2',
  'weapon_combatpistol',
  'weapon_pistol50',
  'weapon_snspistol',
  'weapon_snspistol_mk2',
  'weapon_heavypistol',
  'weapon_vintagepistol',
  'weapon_marksmanpistol',
  'weapon_revolver',
  'weapon_revolver_mk2',
  'weapon_doubleaction',
  'weapon_appistol',
  'weapon_stungun',
  'weapon_flaregun',
  'weapon_microsmg',
  'weapon_machinepistol',
  'weapon_smg',
  'weapon_smg_mk2',
  'weapon_assaultsmg',
  'weapon_combatpdw',
  'weapon_mg',
  'weapon_combatmg',
  'weapon_combatmg_mk2',
  'weapon_gusenberg',
  'weapon_minismg',
  'weapon_assaultrifle',
  'weapon_assaultrifle_mk2',
  'weapon_carbinerifle',
  'weapon_carbinerifle_mk2',
  'weapon_advancedrifle',
  'weapon_specialcarbine',
  'weapon_specialcarbine_mk2',
  'weapon_bullpuprifle',
  'weapon_bullpuprifle_mk2',
  'weapon_compactrifle',
  'weapon_sniperrifle',
  'weapon_heavysniper',
  'weapon_heavysniper_mk2',
  'weapon_marksmanrifle',
  'weapon_marksmanrifle_mk2',
  'weapon_pumpshotgun',
  'weapon_pumpshotgun_mk2',
  'weapon_sawnoffshotgun',
  'weapon_bullpupshotgun',
  'weapon_assaultshotgun',
  'weapon_musket',
  'weapon_heavyshotgun',
  'weapon_dbshotgun',
  'weapon_autoshotgun',
  'weapon_grenadelauncher',
  'weapon_rpg',
  'weapon_minigun',
  'weapon_firework',
  'weapon_railgun',
  'weapon_hominglauncher',
  'weapon_grenadelauncher_smoke',
  'weapon_compactlauncher',
  'weapon_grenade',
  'weapon_stickybomb',
  'weapon_proxmine',
  'weapon_bzgas',
  'weapon_molotov',
  'weapon_fireextinguisher',
  'weapon_petrolcan',
  'weapon_petrolcan',
  'weapon_flare',
  'weapon_ball',
  'weapon_snowball',
  'weapon_smokegrenade',
  'weapon_pipebomb',
  'weapon_parachute',
  'weapon_rayminigun',
  'weapon_raypistol',
  'weapon_raycarbine',
}

local areas = {
      ['Sectie'] =  { pos =  vector3(434.6769, -981.1384, 30.71204), radius = 140, rot = 1 , w = 140.0, h =170.0},
    ['Showroom'] = {pos =vector3(-59.27472, -1121.196, 27.44324), radius = 130, rot = 90, w = 110.0, h =220.0},
    ['CNN'] = { pos = vector3(-628.5758, -942.9099, 21.81543), radius = 130, rot =1, w = 110.0, h =170.0},
  --  ['Paintball'] = { pos = vector3(227.8813, -37.04176, 69.70251), radius = 90, rot = 70, w = 110.0, h =170.0},
    --['Remat'] = { pos = vector3(-429.7055, -1697.037, 19.00146), radius = 80, rot = 70, w = 80.0, h =110.0},
    ['Casino'] = {pos = vector3(918.7121, 50.87473, 111.7091), radius = 120, rot = 150, w = 110.0, h =170.0},
    ['Primarie'] = {pos = vector3(237.0066, -407.6967, 47.91577),radius = 160, rot = 340, w = 150.0, h =170.0 }
}

local function isPedInCopArea()
  local ped = PlayerPedId()
  local c = GetEntityCoords(ped)
local zName = false

  for k,v in pairs(areas) do 
      if #(c - v.pos) <= v.radius then 
    zName = k
          return zName 
      end
  end

  return zName
end

function hasAgunInHand(weapon)
  for _, blacklistedWeapon in pairs(weaponz) do
      if weapon == GetHashKey(blacklistedWeapon) then
          return true
      end
  end

  return false
end

Citizen.CreateThread(function()
  while true do
      Wait(1000)
      local playerPed = PlayerPedId()
      local weapon = GetCurrentPedWeapon(playerPed, true)
      local townPos, townRadius = vector3(-117.53279876709,-1353.1544189453,29.33846282959), 2500.0
      if hasAgunInHand(weapon) then
          if(IsControlJustReleased(1, 24))then
              math.randomseed(GetGameTimer())
              local chance = math.random(1, 100)
              if chance < 30 or (chance < 15 and IsPedCurrentWeaponSilenced(playerPed)) then
                  local interiorId = GetInteriorFromEntity(playerPed)
                  if interiorId ~= 121090 and interiorId ~= 207105 then -- MLO Sinidcat / AA2

                      local pos = GetEntityCoords(playerPed)
                      local area = isPedInCopArea()
                      if GetDistanceBetweenCoords(pos, townPos, false) < townRadius then
                          TriggerServerEvent('alertCops',area)
                      end
                  end
              end
          end
      end
  end
end)    