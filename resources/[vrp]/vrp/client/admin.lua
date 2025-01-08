 
function tvRP.toggleInvisible()
    invisible = not invisible
    local ped = PlayerPedId()
    if invisible then
        SetEntityInvincible(ped, true)
        SetEntityVisible(ped, false, false)
    else
        SetEntityInvincible(ped, false)
        SetEntityVisible(ped, true, false)
    end
end

function tvRP.invisiblemod()
    invisiblehaha = not invisiblehaha
    local ped = PlayerPedId()
    if invisiblehaha then
        SetEntityInvincible(ped, true)
        SetEntityVisible(ped, false, false)
        tvRP.notify("~g~Succes: Acum esti ~r~invizibil.")
    else
        SetEntityInvincible(ped, false)
        SetEntityVisible(ped, true, false)
        tvRP.notify("~g~Succes: Acum esti ~g~vizibil.")
    end
end

function tvRP.isInvisible()
    return invisible
end
 
tvRP.cleanupAnnouncement = function(subtitle, message, ms)
    ms = ms or 7000
    local timer = true
    Citizen.SetTimeout(ms, function()
        timer = false
    end)
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        function Initialize(scaleform)
            local scaleform = RequestScaleformMovie(scaleform)
            while not HasScaleformMovieLoaded(scaleform) do
                Citizen.Wait(0)
            end
            PushScaleformMovieFunction(scaleform, "SHOW_WEAPON_PURCHASED")
            PushScaleformMovieFunctionParameterString("~r~CLEANUP")
            PushScaleformMovieFunctionParameterString(message)
            PushScaleformMovieFunctionParameterString(subtitle)
            PopScaleformMovieFunctionVoid()
            Citizen.SetTimeout(ms, function()
                PushScaleformMovieFunction(scaleform, "SHARD_ANIM_OUT")
                PushScaleformMovieFunctionParameterInt(1)
                PushScaleformMovieFunctionParameterFloat(0.33)
                PopScaleformMovieFunctionVoid()
                Citizen.SetTimeout(6000, function()EndScaleformMovieMethod() end)
            end)
            return scaleform
        end
        scaleform = Initialize("mp_big_message_freemode")
        while timer do
            Citizen.Wait(0)
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 100, 0)
        end
    end)
end

local noclip = false
local invisible = false
local noclip_speed = 3.0

function tvRP.tryToggleNoclip()
  TriggerServerEvent("noclip:tryToToggle")
end

function tvRP.toggleNoclip()
  noclip = not noclip
  local ped = PlayerPedId()
  if noclip then
  SetEntityInvincible(ped, true)
  SetEntityVisible(ped, false, false)
	tvRP.notify("~g~Succes: ~w~Foloseste tastele ~b~SHIFT ~w~si ~b~CTRL ~w~pentru a regla viteza")
  else
    SetEntityInvincible(ped, false)
    SetEntityVisible(ped, true, false)
  end
end



Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1)
      if noclip then
        local ped = PlayerPedId()
        local x,y,z = tvRP.getPosition()
        local dx,dy,dz = tvRP.getCamDirection()
        local speed = noclip_speed
  
        -- reset velocity
        SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)
  
        -- forward
        if IsControlPressed(0,32) then 
          if 		IsControlPressed(0,21) then speed = 10.0
          elseif 	IsControlPressed(0,210) then speed = 1.0 end
  
          x = x+speed*dx
          y = y+speed*dy
          z = z+speed*dz
        end
  
        -- backward
        if IsControlPressed(0,269) then 
          if 		IsControlPressed(0,21) then speed = 10.0 
          elseif 	IsControlPressed(0,210) then speed = 1.0 end
  
          x = x-speed*dx
          y = y-speed*dy
          z = z-speed*dz
        end
  
        SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
      end
    end
  end)
  
  function tvRP.isNoclip()
    return noclip
  end

  RegisterNetEvent("ilc:hainastaff")
  AddEventHandler("ilc:hainastaff", function()
      ClearPedTasks(PlayerPedId())
  
      local male = (GetEntityModel(PlayerPedId()))
      local uniforma = {}
      if male > 0    then
          uniforma = {
              SetPedComponentVariation(PlayerPedId(),3, 4,0),-- Maini
              SetPedComponentVariation(PlayerPedId(),11,416,1) -- Tricou
          }
      elseif male < 0 then
          uniforma = {
      
              SetPedComponentVariation(PlayerPedId(),11,14,0) -- Tricou
          }
      end
  end)
  RegisterNetEvent("alex:dezbracate")
AddEventHandler("alex:dezbracate", function(source)
    ExecuteCommand("fixskin")
end)