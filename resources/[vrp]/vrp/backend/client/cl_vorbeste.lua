Citizen.CreateThread(function()
  while true do
    local ticks = 500
    local theUsers = GetActivePlayers()

    for _, i in pairs(theUsers)  do
      local ped = GetPlayerPed(i)

      if NetworkIsPlayerTalking(i) then
        ticks = 1

        local coords = GetEntityCoords(ped) + vector3(0.0, 0.0, 1.0)
        DrawMarker(28, coords, 0, 0, 0, 0, 0, 0, 0.020, 0.020, 0.020, 255, 255, 255, 200)
        PlayFacialAnim(ped, 'mic_chatter', 'mp_facial')
      else
        PlayFacialAnim(ped, 'mood_normal_1', 'facials@gen_male@variations@normal')
      end
    end

    Wait(ticks)
  end
end)

local isCrouched, lastUserCam = false, 0

Citizen.CreateThread(function()
  while not HasAnimSetLoaded('move_ped_crouched') do
    Wait(5)
    RequestAnimSet('move_ped_crouched')
  end
end)

local function resetCrouch()
  SetPedMaxMoveBlendRatio(_GPED, 1.0)
  ResetPedMovementClipset(_GPED, 0.55)
  ResetPedStrafeClipset(_GPED)
  SetPedCanPlayAmbientAnims(_GPED, true)
  SetPedCanPlayAmbientBaseAnims(_GPED, true)
  ResetPedWeaponMovementClipset(_GPED)
  SetFollowPedCamViewMode(lastUserCam)
  SetPedStealthMovement(_GPED,false,"")
end

RegisterCommand('useCrouch', function()
  local currentCamera = GetFollowPedCamViewMode()
  
  if isCrouched then
      isCrouched = false;
      resetCrouch()
  else
      lastUserCam = currentCamera
      isCrouched = true;
      Citizen.CreateThread(function()
          while isCrouched do
              SetPedUsingActionMode(_GPED, false, -1, "DEFAULT_ACTION")
              SetPedMovementClipset(_GPED, 'move_ped_crouched', 0.55)
              SetPedStrafeClipset(_GPED, 'move_ped_crouched_strafing')
              SetWeaponAnimationOverride(_GPED, "Ballistic")
              Wait(5)
          end
          resetCrouch()
      end)
  end
end, false)

RegisterKeyMapping('useCrouch', 'Intra in modul crouch', 'keyboard', 'LCONTROL')