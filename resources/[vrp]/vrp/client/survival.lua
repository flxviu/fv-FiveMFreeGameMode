function tvRP.varyHealth(variation)
  local ped = PlayerPedId()

  local n = math.floor(GetEntityHealth(ped)+variation)
  SetEntityHealth(ped,n)
end

function tvRP.getHealth()
  return GetEntityHealth(PlayerPedId())
end

function tvRP.getArmura()
  return GetPedArmour(PlayerPedId())
end

function tvRP.setHealth(health)
  local n = math.floor(health)
  SetEntityHealth(PlayerPedId(),n)
  Citizen.CreateThread(function()
    Wait(1000)
    SetEntityHealth(PlayerPedId(), n)
  end)
end

function tvRP.setArmura(armura)
  local n = math.floor(armura)
  AddArmourToPed(PlayerPedId(), n)
  Citizen.CreateThread(function()
    Wait(1000)
    AddArmourToPed(PlayerPedId(), n)
  end)
end

-- impact thirst and hunger when the player is running (every 5 seconds)
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(5000)

    if IsPlayerPlaying(PlayerId()) then
      local ped = GetPlayerPed(-1)

      -- variations for one minute
      local vthirst = 0
      local vhunger = 0

      -- on foot, increase thirst/hunger in function of velocity
      if IsPedOnFoot(ped) and not tvRP.isNoclip() then
        local factor = math.min(tvRP.getSpeed(),10)

        vthirst = vthirst+1*factor
        vhunger = vhunger+0.5*factor
      end

      -- in melee combat, increase
      if IsPedInMeleeCombat(ped) then
        vthirst = vthirst+10
        vhunger = vhunger+5
      end

      -- injured, hurt, increase
      if IsPedHurt(ped) or IsPedInjured(ped) then
        vthirst = vthirst+2
        vhunger = vhunger+1
      end

      -- do variation
      if vthirst ~= 0 then
        vRPserver.varyThirst({vthirst/12.0})
      end

      if vhunger ~= 0 then
        vRPserver.varyHunger({vhunger/12.0})
      end
    end
  end
end)

function tvRP.setArmourica(armour, vest)
	local ped = PlayerPedId()
	if vest then
		RequestAnimDict("clothingtie")
	  while not HasAnimDictLoaded("clothingtie") do
		  Citizen.Wait(1) 
	  end
	  TaskPlayAnim(ped, "clothingtie", "try_tie_negative_a", 3.0, 3.0, 2000, 01, 0, false, false, false)
		if(GetEntityModel(player) == GetHashKey("mp_m_freemode_01")) then
			SetPedComponentVariation(player, 9, 26, 9, 0)
		else 
			if(GetEntityModel(player) == GetHashKey("mp_f_freemode_01")) then
			SetPedComponentVariation(ped, 9, 6, 1, 2)
			end
	  	end
	end
	local n = math.floor(armour)
	SetPedArmour(ped, n)
end

local mamamatii = false
AddEventHandler("playerSpawned",function()
    Wait(cfg.coma_duration * 60 * 100)
    mamamatii = true
end)
local in_coma = false
local gsagas = false
local buginv = false
local coma_left = cfg.coma_duration * 60

local comaText = ""

Citizen.CreateThread(function() -- coma thread
  while true do
    tick = 500
    local ped = PlayerPedId()
    
    local health = GetEntityHealth(ped)
    if health <= cfg.coma_threshold and coma_left > 0 then
      tick = 0
      if not in_coma then -- go to coma state
        if IsEntityDead(ped) then -- if dead, resurrect
          local x,y,z = tvRP.getPosition()
          NetworkResurrectLocalPlayer(x, y, z, true, true, false)
          Citizen.Wait(0)
        end

        -- coma state
        in_coma = true
        gsagas = true
        buginv = true
        vRPserver.updateHealth({cfg.coma_threshold}) -- force health update
        TriggerEvent('majestic-deathscreen:openUI', coma_left)
        SetEntityHealth(ped, cfg.coma_threshold)
        SetEntityInvincible(ped,true)
        tvRP.ejectVehicle()
        tvRP.setRagdoll(true)
      else -- in coma
        -- maintain life
        if health < cfg.coma_threshold then 
          SetEntityHealth(ped, cfg.coma_threshold) 
        end
      end
    else
      if in_coma then -- get out of coma state
        tick = 0
        Citizen.CreateThread(function()
          in_coma = false
          while (GetEntityHealth(ped)-1 <= cfg.coma_threshold) and gsagas and mamamatii do
            Wait(1)
            if IsControlJustPressed(0, 38) then
              break
            end
          end
          SetEntityInvincible(ped,false)
          gsagas = false
          TriggerEvent('majestic-deathscreen:revive')
          tvRP.setRagdoll(false)
          comaText = ""
          SetTimeout(10000, function()  -- able to be in coma again after coma death after 5 seconds
            buginv = false
          end)
          if coma_left <= 0 then -- get out of coma by death
            if GetEntityHealth(ped)-1 <= cfg.coma_threshold then
              SetEntityHealth(ped, 0)
            end
          end

          SetTimeout(5000, function()  -- able to be in coma again after coma death after 5 seconds
            coma_left = cfg.coma_duration*60
          end)
        end)
      end
    end
    Wait(tick)
  end
end)

function tvRP.isInComa()
    return gsagas
end

function tvRP.wasInComa()
  return buginv
end

-- kill the player if in coma
function tvRP.killComa()
    if in_coma then
        coma_left = 0
    end
end


Citizen.CreateThread(function() -- coma decrease thread
    while true do 
      Citizen.Wait(1000)
      SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
      if in_coma then
        coma_left = coma_left-1
      end
    end
  end)

