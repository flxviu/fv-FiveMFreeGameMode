Config = {}
Config.SlotMachines = {

	vec3(1012.9110717774, 59.73498916626,  73.281356811524),
    vec3(1013.670288086,  56.031421661376, 73.281356811524),
    vec3(1012.2470092774, 55.462600708008, 73.281341552734),
    vec3(1012.7138061524, 53.423091888428, 73.281219482422),
    vec3(1006.9424438476, 53.833541870118, 73.296340942382),
    vec3(1007.2501220704, 54.874298095704, 73.281394958496),
    vec3(1007.3468017578, 5.966777801514,  73.281341552734),
    vec3(1007.0830688476, 57.023155212402, 73.281341552734),
    vec3(1006.5548706054, 57.956340789794, 73.281341552734),
    vec3(1005.8106689454, 58.745471954346, 73.281341552734),
}

--  _____  ______  _____ _____ _____ _   _ 
-- |  __ \|  ____|/ ____|_   _/ ____| \ | |
-- | |  | | |__  | (___   | || |  __|  \| |
-- | |  | |  __|  \___ \  | || | |_ | . ` |
-- | |__| | |____ ____) |_| || |__| | |\  |
-- |_____/|______|_____/|_____\_____|_| \_|
--                                         
-- Info: De aici puteti sa modificati o mare parte a designului!
-- Atentie: Nu aduceti modificari daca nu stiti ce faceti.

Config.SlotMachineName = {
	name = "~b~Lucid ~w~Slots", -- Reprezinta textul din titlu
	font = 7,
	rgb = {255, 26, 26} -- Reprezinta culoarea titlului / culoarea de baza a pacanelei
}
Config.Background = function()
	--DrawRect(0.505,0.5, 0.55,0.51, 255, 26, 26,130)

	drawTxt(0.505,0.25,1.0,Config.SlotMachineName.name,Config.SlotMachineName.rgb[1],Config.SlotMachineName.rgb[2],Config.SlotMachineName.rgb[3],255,Config.SlotMachineName.font)
	for i = 1 , #UtilsTable do
        if showWins then
            if combTable[i] == true then
                DrawRect(UtilsTable[i].position[1],UtilsTable[i].position[2],0.07,0.11,255,0,0,150)
                DrawSprite(UtilsTable[i].prize,UtilsTable[i].prize,UtilsTable[i].position[1],UtilsTable[i].position[2],0.07,0.11,gHeading,255,255,255,255)
            else
                DrawRect(UtilsTable[i].position[1],UtilsTable[i].position[2],0.07,0.11,0,0,0,150)
                DrawSprite(UtilsTable[i].prize,UtilsTable[i].prize,UtilsTable[i].position[1],UtilsTable[i].position[2],0.07,0.11,0.0,255,255,255,255)
            end
        else
		    DrawRect(UtilsTable[i].position[1],UtilsTable[i].position[2],0.07,0.11,0,0,0,150)
		    DrawSprite(UtilsTable[i].prize,UtilsTable[i].prize,UtilsTable[i].position[1],UtilsTable[i].position[2],0.07,0.11,0.0,255,255,255,255)
        end
	end
end
Config.BackgroundGamble = function(bet,betx2,forced)
	DrawRect(0.505,0.5, 0.55,0.35, 255, 26, 26,130)

	drawTxt(0.505,0.25,1.0,Config.SlotMachineName.name,Config.SlotMachineName.rgb[1],Config.SlotMachineName.rgb[2],Config.SlotMachineName.rgb[3],255,Config.SlotMachineName.font)

	DrawSprite(shownCard,shownCard,0.505,0.47,0.065,0.12,0.0,255,255,255,255)

	drawTxt(0.67,0.35,0.5,"~w~Miza\n~y~"..bet,0,255,255,255,1)
	drawTxt(0.67,0.45,0.5,"~w~Miza Gamble\n~g~"..betx2,0,255,255,255,1)

	drawTxt(0.33,0.35,0.7,"~w~Istoric",0,255,255,255,1)
	if shownCard == "redCard" and shownCard ~= "redCard3" or forced then
		if forced then
			shownCard = "redCard"
		end
		DrawOnScreenButton(0.505,0.64,0.12,0.03,0.5,1,"Incaseaza Castiguri",{0,255,0},150,true,function()
			TriggerServerEvent("machiamavlad:requestGamblePrize")
			gambleOpen = false
	    end)
		DrawOnScreenButton(0.455,0.6,0.04,0.03,0.4,1,"Rosu",{255,0,0},255,true,function()
			TriggerServerEvent("machiamavlad:sendGambleAnswer","rosu")
		end)
		DrawOnScreenButton(0.555,0.6,0.04,0.03,0.4,1,"Negru",{0,0,0},255,true,function()
			TriggerServerEvent("machiamavlad:sendGambleAnswer","negru")
		end)
	end
end