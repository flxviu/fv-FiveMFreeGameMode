Citizen.CreateThread(function()
    while true
    	do
		
		SetWeatherTypePersist("XMAS")
        SetWeatherTypeNowPersist("XMAS")
        SetWeatherTypeNow("XMAS")
        SetOverrideWeather("XMAS")
    	
		Citizen.Wait(1)
	end

end)

Citizen.CreateThread(function()
    local IsPauseMenu = false 

    while true do
        Wait(0)

        if IsPauseMenuActive() then
            if not isPauseMenu then
                isPauseMenu = true
            end

            BeginScaleformMovieMethodOnFrontendHeader("SHIFT_CORONA_DESC")
            PushScaleformMovieFunctionParameterBool(true)
            PushScaleformMovieFunctionParameterBool(true)
            PopScaleformMovieFunction()
            
            
            BeginScaleformMovieMethodOnFrontendHeader("SET_HEADER_TITLE")
            PushScaleformMovieFunctionParameterString('~g~Anubis ~w~Romania')
            PushScaleformMovieFunctionParameterBool(true)
            
            
            PushScaleformMovieFunctionParameterString('~w~Anubis Romania, un nume, un vis, o comunitate')
            PushScaleformMovieFunctionParameterBool(true)
            PopScaleformMovieFunctionVoid()

            BeginScaleformMovieMethodOnFrontendHeader("SET_HEADING_DETAILS")
            PushScaleformMovieFunctionParameterString(GlobalState['NumeIndivid']) 
            PushScaleformMovieFunctionParameterString('Cash $'..GlobalState['Coins']['banca']) 
            PushScaleformMovieFunctionParameterString('Banca $'..GlobalState['Coins']['cash']) 
            ScaleformMovieMethodAddParamBool(false)
            ScaleformMovieMethodAddParamBool(isScripted)
            EndScaleformMovieMethod()

        else
          if isPauseMenu then
            isPauseMenu = false
          end
        end

    end

end)