local SetTimeout = Citizen.SetTimeout
local Wait = Citizen.Wait
local CreateThread = Citizen.CreateThread

CreateThread(function()
  Wait(1000)
  RegisterFontFile('wmk')
  RegisterFontFile('Montserrat')
end)

local function Scaleform(scaleformName, amount)
	local scaleform = RequestScaleformMovie(scaleformName)
	while not HasScaleformMovieLoaded(scaleform) do
		Wait(0)
	end
	PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
	PushScaleformMovieFunctionParameterString("~r~Payday")
	PushScaleformMovieFunctionParameterString("~w~Ai primit salariul: ~g~$"..tvRP.formatMoney(amount))
	PopScaleformMovieFunctionVoid()
	TriggerEvent("InteractSound_CL:PlayOnOne", "pass", 0.2)
	SetTimeout(6500, function()
		PushScaleformMovieFunction(scaleform, "SHARD_ANIM_OUT")
		PushScaleformMovieFunctionParameterInt(1)
		PushScaleformMovieFunctionParameterFloat(0.33)
		PopScaleformMovieFunctionVoid()
		SetTimeout(3000, function() EndScaleformMovieMethod() end)
	end)
	return scaleform
end

function tvRP.doPayDay(incomeTotal)
	if incomeTotal > 0 then
		local scaleform = Scaleform('mp_big_message_freemode',incomeTotal)

		local ms = GetGameTimer() + 15000
		while GetGameTimer() < ms do
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 150, 0)
			Wait(1)
		end
		scaleform = nil
	end
end


 local min, sec = GlobalState.minute,GlobalState.secunde

AddStateBagChangeHandler('minute', 'global', function(bagName, key, value, reserved, replicated)
    min = value
    local paydayformat = ("%02dm %02ds"):format(min, sec)
    TriggerEvent("hud:updateThings", "paydayy", paydayformat)
end)

AddStateBagChangeHandler('secunde', 'global', function(bagName, key, value, reserved, replicated)
    sec = value
    local paydayformat = ("%02dm %02ds"):format(min, sec)
    TriggerEvent("hud:updateThings", "paydayy", paydayformat)
end)