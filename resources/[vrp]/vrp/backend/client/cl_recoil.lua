local recoils = {
	[453432689] = 0.3, -- PISTOL
	[3219281620] = 0.3, -- PISTOL MK2
	[1593441988] = 0.2, -- COMBAT PISTOL
	[584646201] = 0.01, -- AP PISTOL
	[2578377531] = 0.1, -- PISTOL .50
	[324215364] = 0.2, -- MICRO SMG
	[736523883] = 0.1, -- SMG
	[2024373456] = 0.1, -- SMG MK2
	[4024951519] = 0.1, -- ASSAULT SMG
	[3220176749] = 0.2, -- ASSAULT RIFLE
	[961495388] = 0.2, -- ASSAULT RIFLE MK2
	[2210333304] = 0.1, -- CARBINE RIFLE
	[4208062921] = 0.1, -- CARBINE RIFLE MK2
	[2937143193] = 0.1, -- ADVANCED RIFLE
	[2634544996] = 0.01, -- MG
	[2144741730] = 0.01, -- COMBAT MG
	[3686625920] = 0.1, -- COMBAT MG MK2
	[487013001] = 0.2, -- PUMP SHOTGUN
	[1432025498] = 0.4, -- PUMP SHOTGUN MK2
	[2017895192] = 0.7, -- SAWNOFF SHOTGUN
	[3800352039] = 0.4, -- ASSAULT SHOTGUN
	[2640438543] = 0.2, -- BULLPUP SHOTGUN
	[911657153] = 0.1, -- STUN GUN
	[100416529] = 0.2, -- SNIPER RIFLE
	[205991906] = 0.4, -- HEAVY SNIPER
	[177293209] = 0.5, -- HEAVY SNIPER MK2
	[856002082] = 1.2, -- REMOTE SNIPER
	[2726580491] = 1.0, -- GRENADE LAUNCHER
	[1305664598] = 1.0, -- GRENADE LAUNCHER SMOKE
	[2982836145] = 0.0, -- RPG
	[1752584910] = 0.0, -- STINGER
	[1119849093] = 0.01, -- MINIGUN
	[3218215474] = 0.2, -- SNS PISTOL
	[2009644972] = 0.25, -- SNS PISTOL MK2
	[1627465347] = 0.1, -- GUSENBERG
	[3231910285] = 0.2, -- SPECIAL CARBINE
	[-1768145561] = 0.25, -- SPECIAL CARBINE MK2
	[3523564046] = 0.5, -- HEAVY PISTOL
	[2132975508] = 0.2, -- BULLPUP RIFLE
	[-2066285827] = 0.25, -- BULLPUP RIFLE MK2
	[137902532] = 0.4, -- VINTAGE PISTOL
	[-1746263880] = 0.4, -- DOUBLE ACTION REVOLVER
	[2828843422] = 0.7, -- MUSKET
	[984333226] = 0.2, -- HEAVY SHOTGUN
	[3342088282] = 0.3, -- MARKSMAN RIFLE
	[1785463520] = 0.35, -- MARKSMAN RIFLE MK2
	[1672152130] = 0, -- HOMING LAUNCHER
	[1198879012] = 0.9, -- FLARE GUN
	[171789620] = 0.2, -- COMBAT PDW
	[3696079510] = 0.9, -- MARKSMAN PISTOL
  	[1834241177] = 2.4, -- RAILGUN
	[3675956304] = 0.3, -- MACHINE PISTOL
	[3249783761] = 0.6, -- REVOLVER
	[-879347409] = 0.65, -- REVOLVER MK2
	[4019527611] = 0.7, -- DOUBLE BARREL SHOTGUN
	[1649403952] = 0.3, -- COMPACT RIFLE
	[317205821] = 0.2, -- AUTO SHOTGUN
	[125959754] = 0.5, -- COMPACT LAUNCHER
	[3173288789] = 0.1, -- MINI SMG		
	[GetHashKey("WEAPON_PISTOL50")] = 0.5,
}

local weapShakes = {
	[GetHashKey('WEAPON_FLAREGUN')] = 0.01,
	[GetHashKey('WEAPON_STUNGUN')] = 0.01,
	[GetHashKey('WEAPON_SNSPISTOL')] = 0.15,
	[GetHashKey('WEAPON_SNSPISTOL_MK2')] = 0.15,
	[GetHashKey('WEAPON_PISTOL')] = 0.025,
	[GetHashKey('WEAPON_PISTOL_MK2')] = 0.15,
	[GetHashKey('WEAPON_APPISTOL')] = 0.05,
	[GetHashKey('WEAPON_COMBATPISTOL')] = 0.15,
	[GetHashKey('WEAPON_PISTOL50')] = 0.25,
	[GetHashKey('WEAPON_HEAVYPISTOL')] = 0.15,
	[GetHashKey('WEAPON_VINTAGEPISTOL')] = 0.15,
	[GetHashKey('WEAPON_MARKSMANPISTOL')] = 0.03,
	[GetHashKey('WEAPON_REVOLVER')] = 0.55,
	[GetHashKey('WEAPON_REVOLVER_MK2')] = 0.055,
	[GetHashKey('WEAPON_DOUBLEACTION')] = 0.25,
	[GetHashKey('WEAPON_NAVYREVOLVER')] = 0.35,
	[GetHashKey('WEAPON_GADGETPISTOL')] = 0.55,

	[GetHashKey('WEAPON_MICROSMG')] = 0.095,
	[GetHashKey('WEAPON_COMBATPDW')] = 0.095,
	[GetHashKey('WEAPON_SMG')] = 0.095,
	[GetHashKey('WEAPON_SMG_MK2')] = 0.055,
	[GetHashKey('WEAPON_ASSAULTSMG')] = 0.095,
	[GetHashKey('WEAPON_MACHINEPISTOL')] = 0.095,
	[GetHashKey('WEAPON_MINISMG')] = 0.035,
	[GetHashKey('WEAPON_MG')] = 0.095,
	[GetHashKey('WEAPON_COMBATMG')] = 0.095,
	[GetHashKey('WEAPON_COMBATMG_MK2')] = 0.095,
	[GetHashKey('WEAPON_MINISMG')] = 0.095,

	[GetHashKey('WEAPON_ASSAULTRIFLE')] = 0.040,
	[GetHashKey('WEAPON_ASSAULTRIFLE_MK2')] = 0.090,
	[GetHashKey('WEAPON_CARBINERIFLE')] = 0.095,
	[GetHashKey('WEAPON_CARBINERIFLE_MK2')] = 0.065,
	[GetHashKey('WEAPON_ADVANCEDRIFLE')] = 0.06,
	[GetHashKey('WEAPON_GUSENBERG')] = 0.095,
	[GetHashKey('WEAPON_SPECIALCARBINE')] = 0.06,
	[GetHashKey('WEAPON_SPECIALCARBINE_MK2')] = 0.095,
	[GetHashKey('WEAPON_BULLPUPRIFLE')] = 0.05,
	[GetHashKey('WEAPON_BULLPUPRIFLE_MK2')] = 0.095,
	[GetHashKey('WEAPON_COMPACTRIFLE')] = 0.095,
	[GetHashKey('WEAPON_MILITARYRIFLE')] = 0.08,

	[GetHashKey('WEAPON_PUMPSHOTGUN')] = 0.55,
	[GetHashKey('WEAPON_PUMPSHOTGUN_MK2')] = 0.55,
	[GetHashKey('WEAPON_SAWNOFFSHOTGUN')] = 0.55,
	[GetHashKey('WEAPON_ASSAULTSHOTGUN')] = 0.55,
	[GetHashKey('WEAPON_BULLPUPSHOTGUN')] = 0.55,
	[GetHashKey('WEAPON_DBSHOTGUN')] = 0.55,
	[GetHashKey('WEAPON_AUTOSHOTGUN')] = 0.55,
	[GetHashKey('WEAPON_HEAVYSHOTGUN')] = 0.55,

	[GetHashKey('WEAPON_SNIPERRIFLE')] = 0.2,
	[GetHashKey('WEAPON_HEAVYSNIPER')] = 0.3,
	[GetHashKey('WEAPON_HEAVYSNIPER_MK2')] = 0.35,
	[GetHashKey('WEAPON_MARKSMANRIFLE')] = 0.1,
	[GetHashKey('WEAPON_MARKSMANRIFLE_MK2')] = 0.1,

	[GetHashKey('WEAPON_GRENADELAUNCHER')] = 0.08,
	[GetHashKey('WEAPON_RPG')] = 0.9,
	[GetHashKey('WEAPON_HOMINGLAUNCHER')] = 0.9,
	[GetHashKey('WEAPON_MINIGUN')] = 0.20,
	[GetHashKey('WEAPON_RAILGUN')] = 1.0,
	[GetHashKey('WEAPON_COMPACTLAUNCHER')] = 0.08,
	[GetHashKey('WEAPON_FIREWORK')] = 0.5,
}

local function showWeaponRecoil()
	local _,wep = GetCurrentPedWeapon(_GPED)
	
	if recoils[wep] and recoils[wep] ~= 0 then
		local tv = 0

		repeat 
			Citizen.Wait(0)
			p = GetGameplayCamRelativePitch()
			if GetFollowPedCamViewMode() ~= 4 then
				SetGameplayCamRelativePitch(p+0.1, 0.2)
			end
			tv = tv+0.1
		until tv >= recoils[wep]
	end
end

AddEventHandler("CEventGunShot", function(_,eventEntity,_)
	if eventEntity == _GPED then
		if not IsPedDoingDriveby(_GPED) then
			local uWeap = GetSelectedPedWeapon(_GPED)
			local wShake = weapShakes[uWeap]

			if wShake then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', wShake)
			end

			showWeaponRecoil()

		end
	end
end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(1)
-- 		if IsPedArmed(ped, 6) then
--         	DisableControlAction(1, 140, true)
--             DisableControlAction(1, 141, true)
--             DisableControlAction(1, 142, true)
--         end
-- 	end
-- end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		
		if IsPedArmed(ped, 6) then
        	DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end

		end
end)
