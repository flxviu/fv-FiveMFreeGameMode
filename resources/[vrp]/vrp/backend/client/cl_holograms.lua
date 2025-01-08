Citizen.CreateThread(function ()
    local ticks = 1000
    while true do		
		if GetDistanceBetweenCoords( -802.77294921875,-1230.7127685547,7.3349332809448, GetEntityCoords(PlayerPedId())) < 20.0 then
            ticks = 1
			Draw3DText( -534.40991210938,-222.2776184082,37.649787902832  -1.630, "~b~Bine ai venit pe Anubis Romania!", 1, 0.1, 0.1)
            Draw3DText( -534.40991210938,-222.2776184082,37.649787902832  -1.800, "Nu uita sa intri pe dsc.gg/Lucidro", 4, 0.1, 0.1)
		end	
        if GetDistanceBetweenCoords( -594.99987792969,-929.91333007812,23.86962890625, GetEntityCoords(PlayerPedId())) < 10.0 then
            ticks = 1
		end	
        if GetDistanceBetweenCoords( -169.80123901367,279.13363647461,93.585632324219, GetEntityCoords(PlayerPedId())) < 15.0 then
            ticks = 1
            Draw3DText( -169.80123901367,279.13363647461,93.585632324219  -1.630, "MERGI IN FATA", 4, 0.1, 0.1)
			Draw3DText( -169.80123901367,279.13363647461,93.585632324219  -1.800, "~r~MAGAZIN ATASAMENTE", 4, 0.1, 0.1)	
        end
        Wait(ticks)
        ticks = 1000
	end
end)

function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov   
    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(250, 250, 250, 255)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end
