vRPC = {}
Tunnel.bindInterface("vrp",vRPC)
Proxy.addInterface("vrp",vRPC)
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP","vrp")
vRPcstm = Tunnel.getInterface("vrp","vrp")

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

-----------------------------------------------------------------

local isBusted = false
RegisterCommand("k", function()
    local player = tempPed
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
 
        RequestAnimDict("random@arrests")
        while not HasAnimDictLoaded("random@arrests") do
            Citizen.Wait(50)
        end

        RequestAnimDict("random@arrests@busted")
        while not HasAnimDictLoaded("random@arrests@busted") do
            Citizen.Wait(50)
        end

        if ( IsEntityPlayingAnim( player, "random@arrests@busted", "idle_a", 3 ) ) then 
            TaskPlayAnim( player, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
            Wait (3000)
            TaskPlayAnim( player, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )
            isBusted = false
        else
            TaskPlayAnim( player, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
            Wait (4000)
            TaskPlayAnim( player, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
            Wait (500)
            TaskPlayAnim( player, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
            Wait (1000)
            TaskPlayAnim( player, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
            isBusted = true
            Citizen.CreateThread(function()
                local ticks = 1000
                while isBusted do
                    ticks = 1
                    DisableControlAction(1, 140, true)
                    DisableControlAction(1, 141, true)
                    DisableControlAction(1, 142, true)
                    DisableControlAction(0,21,true)
                    
                    Wait(ticks)
                    ticks = 1000
                end
            end)
        end     
    end
end, false)

-----------------------------------------------------------------

local crouched = false

RegisterCommand("keymapping:crouch", function ()
        local ped = GetPlayerPed()
        if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
            DisableControlAction( 0, 36, true )
            if ( not IsPauseMenuActive() ) then 
                RequestAnimSet( "move_ped_crouched" )

            while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do 
                Citizen.Wait( 100 )
            end 

            if ( crouched == true ) then 
                ResetPedMovementClipset( ped, 0 )
                crouched = false 
            elseif ( crouched == false ) then
                SetPedMovementClipset( ped, "move_ped_crouched", 0.25 )
                crouched = true 
            end 
        end 
    end
end )

RegisterKeyMapping("keymapping:crouch", "Crouch", "keyboard", "LCONTROL")

-----------------------------------------------------------------

local tempPed
Citizen.CreateThread(function()
    while true do
        tempPed = PlayerPedId()
        Citizen.Wait(20000)
    end
end)

function GetTempPed()
    return tempPed
end

local mp_pointing = false

Citizen.CreateThread(function()
    while true do
        if IsPedOnFoot(PlayerPedId()) then
            if IsControlJustPressed(0, 29) then
                if not IsPlayerFreeAiming(PlayerPedId()) then
                    if mp_pointing then 
                        mp_pointing = false
                        
                        Citizen.InvokeNative(0xD01015C7316AE176, tempPed, "Stop")
                        if not IsPedInjured(tempPed) then
                            ClearPedSecondaryTask(tempPed)
                        end
                        if not IsPedInAnyVehicle(tempPed, 1) then
                            SetPedCurrentWeaponVisible(tempPed, 1, 1, 1, 1)
                        end
                        SetPedConfigFlag(tempPed, 36, 0)
                        ClearPedSecondaryTask(PlayerPedId())

                    else
                        mp_pointing = true
                        
                        RequestAnimDict("anim@mp_point")
                        while not HasAnimDictLoaded("anim@mp_point") do
                            Wait(50)
                        end
                        SetPedCurrentWeaponVisible(tempPed, 0, 1, 1, 1)
                        SetPedConfigFlag(tempPed, 36, 1)
                        Citizen.InvokeNative(0x2D537BA194896636, tempPed, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
                        RemoveAnimDict("anim@mp_point")

                    end
                end
            end
            
            if mp_pointing then
                local camPitch = GetGameplayCamRelativePitch()
                if camPitch < -70.0 then
                    camPitch = -70.0
                elseif camPitch > 42.0 then
                    camPitch = 42.0
                end
                camPitch = (camPitch + 70.0) / 112.0

                local camHeading = GetGameplayCamRelativeHeading()
                local cosCamHeading = Cos(camHeading)
                local sinCamHeading = Sin(camHeading)
                if camHeading < -180.0 then
                    camHeading = -180.0
                elseif camHeading > 180.0 then
                    camHeading = 180.0
                end
                camHeading = (camHeading + 180.0) / 360.0

                local blocked = 0
                local nn = 0

                local coords = GetOffsetFromEntityInWorldCoords(tempPed, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, tempPed, 7);
                nn,blocked,coords,coords = GetRaycastResult(ray)

                Citizen.InvokeNative(0xD5BB4025AE449A4E, tempPed, "Pitch", camPitch)
                Citizen.InvokeNative(0xD5BB4025AE449A4E, tempPed, "Heading", camHeading * -1.0 + 1.0)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, tempPed, "isBlocked", blocked)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, tempPed, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)
            end
        else
            Citizen.Wait(500)
        end
        Citizen.Wait(1)
    end
end)

-----------------------------------------------------------------

facutetst = false

RegisterNetEvent('vezidacaarepermisvere')
AddEventHandler('vezidacaarepermisvere', function(are)
    if are == 0 then
        facutetst = true
    elseif are == 1 then
        facutetst = false
    end
end)

function DrawMissionText2(m_text, showtime)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(m_text)
    DrawSubtitleTimed(showtime, 1)
end


Citizen.CreateThread(function()
    local ticks = 1000
    while true do
        if (IsPedInAnyVehicle(PlayerPedId(), false)) and not facutetst then
            ticks = 1
            DrawMissionText2("", 2000)
        end
        Wait(ticks)
        ticks = 1000
    end
end)


_GPED = PlayerPedId()
_PLAYERCOORDS = GetEntityCoords(_GPED)

CreateThread(function()
    while true do
        _GPED = PlayerPedId()
        _PLAYERCOORDS = GetEntityCoords(_GPED)
        Wait(600)
    end
end)


Citizen.CreateThread(function()
    while true do
        playerHealth = GetEntityHealth(_GPED)
        playerArmor = GetPedArmour(_GPED)
        Citizen.Wait(2000)
    end
end)


Citizen.CreateThread(function()
    Citizen.Wait(20000)
    
    local injuredWalking = false
    
    if not HasAnimSetLoaded("move_m@injured") then
        RequestAnimSet("move_m@injured")
    end
    
    while true do
        local playerPed = PlayerPedId()
        playerHealth = GetEntityHealth(playerPed)
        playerArmor = GetPedArmour(playerPed)
        
        if playerHealth <= 130 then
            SetPedMovementClipset(playerPed, "move_m@injured", 0.2)
            injuredWalking = true
        elseif injuredWalking then
            injuredWalking = false
            ResetPedMovementClipset(playerPed)
        end
        
        Citizen.Wait(2000)
    end
end)

function sallmane(x,y ,width,height,scale, text, r,g,b,a, outline, font, center)
  SetTextFont(0)
  SetTextProportional(0)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0,255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x - width/2, y - height/2 + 0.005)
end

Citizen.CreateThread(function()
    Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'FE_THDR_GTAO', 'Anubis Romania')
    ReplaceHudColourWithRgba(116, 177, 3, 0, 255)
    local punch = GetHashKey('WEAPON_UNARMED')
    local rozeta = GetHashKey('WEAPON_KNUCKLE')
    local bat = GetHashKey('WEAPON_BAT')
    local fallingDmg = GetHashKey('WEAPON_FALL')
    local knife = GetHashKey('WEAPON_KNIFE')
    local animal = GetHashKey('WEAPON_ANIMAL')
    local cougar = GetHashKey('WEAPON_COUGAR')
    local pulan = GetHashKey('WEAPON_NIGHTSTICK')
    local lnt = GetHashKey('WEAPON_FLASHLIGHT')
    local smokeGrenade = GetHashKey("WEAPON_SMOKEGRENADE")
    while true do
        N_0x4757f00bc6323cfe(-1553120962, 0.0)-- Masina
        N_0x4757f00bc6323cfe(fallingDmg, 0.1)
        N_0x4757f00bc6323cfe(punch, 0.2)
        N_0x4757f00bc6323cfe(rozeta, 0.8)
        N_0x4757f00bc6323cfe(bat, 0.5)
        N_0x4757f00bc6323cfe(knife, 0.6)
        N_0x4757f00bc6323cfe(animal, 0.0)
        N_0x4757f00bc6323cfe(cougar, 0.0)
        N_0x4757f00bc6323cfe(pulan, 0.1)
        N_0x4757f00bc6323cfe(lnt, 0.05)
        N_0x4757f00bc6323cfe(smokeGrenade, 0.0)
        DisablePlayerVehicleRewards(PlayerId())
        DisablePlayerVehicleRewards(-1)
        RemoveAllPickupsOfType(0xDF711959)-- carbine rifle
        RemoveAllPickupsOfType(0xF9AFB48F)-- pistol
        RemoveAllPickupsOfType(0xA9355DCD)-- pumpshotgun
        RemoveAllPickupsOfType(0x3A4C2AD2)-- smg
        --HideHudComponentThisFrame(1) -- wanted level
        HideHudComponentThisFrame(3)-- cash
        HideHudComponentThisFrame(4)-- bank
        HideHudComponentThisFrame(6)-- Nume masina
        HideHudComponentThisFrame(7)-- Cartier
        HideHudComponentThisFrame(9)-- Strada
        Citizen.Wait(1)
    end
end)

----------------------------------------------------------------- 

local fontsLoaded = false
local fontId
Citizen.CreateThread(function()
    Citizen.Wait(1000)
    RegisterFontFile('wmk')
    fontId = RegisterFontId('Freedom Font')
    fontsLoaded = true
end)

local DTutOpen = false

function LocalPed()
    return PlayerPedId()
end

local talktoped = true

coordonatlocatieasigurare = {
    {441.47329711914, -983.4697265625, 30.689315795898}
}

Citizen.CreateThread(function()
    local ticks = 1000
    while true do
        for i = 1, #coordonatlocatieasigurare do
            asigurareCoord2 = coordonatlocatieasigurare[i]
            ticks = 1
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), asigurareCoord2[1], asigurareCoord2[2], asigurareCoord2[3], true) < 10 then
            DrawMarker(21, asigurareCoord2[1], asigurareCoord2[2], asigurareCoord2[3], 0, 0, 0, 0, 0, 0, 0.50, 0.60, 0.60, 0, 111, 255, 100, 1, 0, 0, true)
            end
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), asigurareCoord2[1], asigurareCoord2[2], asigurareCoord2[3], true) < 1 then
                asiguraredraw(0.5, 0.90, 0, 0, 0.6, "Apasa ~b~E ~w~pentru a cumpara ~p~asigurare", 255, 255, 255, 230, 1, 4, 1)
                if (IsControlJustReleased(1, 38)) then
                    if talktoped then
                        Citizen.Wait(500)
                        TriggerServerEvent('insurance:buysuccess')
                        talktoped = false
                    else
                        talktoped = true
                    end
                end
            end
        end
        Wait(ticks)
        ticks = 1000
    end
end)

function asiguraredraw(x,y ,width,height,scale, text, r,g,b,a, outline, font, center)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextCentre(center)
	if(outline)then
	  SetTextOutline()
	end
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width/1, y - height/1 + 0.002)
end

-----------------------------------------------------------------

RegisterNetEvent("addWeapon")
AddEventHandler('addWeapon', function(weaponObj)
    vRP.notify({"Succes: Ai primit o arma de la adminul "  .. weaponObj.admin .. " [".. weaponObj.id .. "]"})
    GiveWeaponToPed(PlayerPedId(), weaponObj.hash,255,true,false)
end)