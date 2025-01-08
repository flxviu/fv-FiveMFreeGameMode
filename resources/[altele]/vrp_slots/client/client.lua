RegisterNetEvent("machiamavlad:updateSlotBet")
AddEventHandler("machiamavlad:updateSlotBet",function(newbet)
	moneyBet = formatMoney(newbet).."$"
end)

RegisterNetEvent("machiamavlad:updateGamble")
AddEventHandler("machiamavlad:updateGamble",function(gTable,asd)
	gambleTable.cards[gTable.number].sprite =  gTable.shCard

	if json.encode(gambleTable) ~= "[]" then
		local alpha = 255
		shownCard = gTable.shCard


		if gTable.continue then
			gambleTable.bet = formatMoney(gTable.bet).."$"
			gambleTable.betx2 = formatMoney(gTable.bet * 2).."$"
			local timer = GetGameTimer() + 7000
			while GetGameTimer() < timer do
				drawTxt(0.5,0.8,1.2,"Ai castigat ~g~"..gambleTable.bet,255,255,255,alpha,7)
				if ((timer - GetGameTimer()) < 5000) then
					alpha = alpha - 1
					if alpha <= 5 then
						break
					end
				end
				Wait(1)
			end
			shownCard = "redCard"
		else
			local timer = GetGameTimer() + 3000
			while GetGameTimer() < timer do
				drawTxt(0.5,0.8,1.2,"Ai pierdut ~r~"..gambleTable.bet,255,255,255,alpha,7)
				if ((timer - GetGameTimer()) < 2000) then
					alpha = alpha - 1
					if alpha <= 5 then
						break
					end
				end
				Wait(1)
			end
			shownCard = "redCard"
			gambleTable.bet = "0$"
			gambleTable.betx2 = "0$"
			gambleOpen = false
			for i = 1 , #UtilsTable do
				UtilsTable[i].prize = "questionMark"
			end
			isSpinning = false
		end
	end
end)

RegisterNetEvent("machiamavlad:startGamble")
AddEventHandler("machiamavlad:startGamble",function(gTable,bet,wm)
	gambleOpen = true
	shownCard = "redCard"
	print(json.encode(gambleTable))

		gambleTable = {}
		gambleTable.cards = {}
		gambleTable.bet = formatMoney(bet).."$"
		gambleTable.betx2 = formatMoney(bet * 2).."$"
		for i = 1 , #gTable do
			if gambleTable.cards[i] == nil then
				gambleTable.cards[i] = {taken = gTable[i].taken,sprite = nil}
			end
		end

	Wait(10)
	while gambleOpen do

		for i=0, 31 do
	        DisableAllControlActions(i)
	    end
        EnableControlAction(0,249,true)
        EnableControlAction(3,177,true)

        ShowCursorThisFrame()
        SetCursorSprite(0)

		Config.BackgroundGamble(gambleTable.bet,gambleTable.betx2)
		for i = 1, #gambleTable.cards do
			if gambleTable.cards[i].sprite ~= nil then
				DrawSprite(gambleTable.cards[i].sprite,gambleTable.cards[i].sprite,0.26 + (i / 40),0.45,0.05,0.1,0.0,255,255,255,255)
			else
				DrawSprite("redCard","redCard",0.26 + (i / 40),0.45,0.05,0.1,0.0,255,255,255,255)
			end
		end

        Wait(1)
	end
end)

RegisterNetEvent("machiamavlad:showInfo")
AddEventHandler("machiamavlad:showInfo",function(state,amount)
	local string = "Ai "
	if state == 1 then
		string = "~w~" .. string .. " castigat ~g~"..formatMoney(amount).."$"
	else
		string = "~w~" .. string .. " pierdut ~r~"..formatMoney(amount).."$"
	end
	CreateThread(function()
		local state = GetGameTimer() + 3000
		local alpha = 255

		while GetGameTimer() < state do
			drawTxt(0.5,0.8,1.2,string,255,255,255,alpha,7)
			if ((state - GetGameTimer()) < 2000) then
				alpha = alpha - 1
				if alpha <= 5 then
					break
				end
			end
			Wait(0)
		end

		isSpinning = false
		showWins = false
		if autoSpin and not gambleOpen then
			Wait(500)
			if autoSpin and not gambleOpen then
				TriggerServerEvent("machiamavlad:spinSlotMachine")
			end
		end
	end)
end)

RegisterNetEvent("machiamavlad:doSlotSpin")
AddEventHandler("machiamavlad:doSlotSpin",function(winTable,combTbl,pWin)
	local alreadyDone = false
	print(type(winTable))
	if type(winTable) == "table" then
		combTable = combTbl
		isSpinning = true
		CreateThread(function()
			for i = 1, #UtilsTable do 
				UtilsTable[i].prize = winTable[i].prize
				PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
				if i == #UtilsTable then
					Wait(300)
					break
				end
				Wait(135)
			end
			showWins = false
			for i = 1, #combTable do
				if combTable[i] then
					showWins = true
				end
			end
			CreateThread(function()
				while showWins and not gambleOpen do
					
					DrawOnScreenButton(0.455,0.7,0.082,0.045,0.56,1,"Incaseaza",{0,255,0},150,true,function()
						TriggerServerEvent("machiamavlad:getSlotPrize")
						Wait(100)
						showWins = false
						alreadyDone = true
        			end)
					DrawOnScreenButton(0.555,0.7,0.082,0.045,0.56,1,"Gamble",{255,100,0},150,true,function()
						Wait(100)
						TriggerServerEvent("machiamavlad:startGamble")
						showWins = false
        			end)
	    			Wait(1)
				end
				showWins = false
				Wait(3300)
				if not gambleOpen and not showWins and not alreadyDone then
					Wait(100)
					TriggerServerEvent("machiamavlad:getSlotPrize")
					Wait(100)
				end
			end)
		end)
	end
end)
open = false
RegisterNetEvent("machiamavlad:openSlotMachine")
AddEventHandler("machiamavlad:openSlotMachine",function(amount)
	moneyBet = amount.."$"
	open = true
	slotMachineOpen = true
	StartScreenEffect("MenuMGHeistIn", 0, true)
	while slotMachineOpen do
		for i=0, 31 do
	        DisableAllControlActions(i)
	    end
        EnableControlAction(0,249,true)
        EnableControlAction(3,177,true)

        ShowCursorThisFrame()
        SetCursorSprite(0)

		Config.Background()
		if not showWins then
			drawTxt(0.505,0.715,0.6,"~w~Miza: ~g~"..moneyBet,0,255,0,255,1)
			DrawOnScreenButton(0.605,0.7,0.082,0.045,0.56,1,"Schimba Miza",{255,255,0},150,true,function()
				if not isSpinning and open then
					open = false
					Wait(50)
					slotMachineOpen = false
        			autoSpin = false
        			isSpinning = false
        			TriggerServerEvent("machiamavlad:closeSlotMachine")
					Wait(200)
					Citizen.CreateThread(
						function()
							while true do
								Citizen.Wait(0)
								DisplayOnscreenKeyboard(6, "FMMC_KEY_TIP8", "", "", "", "", "", 70)
								while UpdateOnscreenKeyboard() == 0 do
									DisableAllControlActions(0)
									Wait(0)
								end
								if UpdateOnscreenKeyboard() == 1 then
									mesaj = true
									local amount = GetOnscreenKeyboardResult()
									if (mesaj) then
									
										TriggerServerEvent("machiamavlad:openSlotMachine",amount)
										open = false
										while true do
											Citizen.Wait(111110)

											if GetOnscreenKeyboardResult() then
											end
										end
									end
								end
							end
						end
					)
				
					vRP.notify({"Apasa E pentru a re-intra!"})
				else
					vRP.notify({'~r~Nu poti sa schimbi miza chiar acum!'})
				end
				Wait(3050)
        	end)
			DrawOnScreenButton(0.405,0.7,0.082,0.045,0.56,1,"Auto Spin "..getState(autoSpin),{255,0,0},150,true,function()
				if not isSpinning then
					autoSpin = not autoSpin
					if autoSpin then
						vRP.notify({"Ai activat ~g~Auto Spin~w~!"})
						TriggerServerEvent("machiamavlad:spinSlotMachine")
					else
						vRP.notify({"Ai dezactivat ~r~Auto Spin~w~!"})
					end
				else
					vRP.notify({'~r~Nu poti activa auto spin chiar acum!'})
				end
        	end)
			DrawOnScreenButton(0.505,0.7,0.082,0.045,0.56,1,"Joaca",{0,255,0},150,true,function()
				if not autoSpin then
					if not isSpinning then
						TriggerServerEvent("machiamavlad:spinSlotMachine")
					else
						vRP.notify({'~r~Nu poti sa joci chiar acum!'})
					end
				else
					vRP.notify({"~r~Nu poti sa joci in timp ce ai autospin activ!"})
				end
        	end)
			
        	if IsDisabledControlJustPressed(0,177) then
        		if not isSpinning then
        			slotMachineOpen = false
        			autoSpin = false
        			isSpinning = false
        			TriggerServerEvent("machiamavlad:closeSlotMachine")
        		else
        			vRP.notify({"~r~Nu poti sa inchizi aparatul acum!"})
        		end
        	end
		end
        while gambleOpen do
        	Wait(500)
        end
		Wait(1)
	end
	StopScreenEffect("MenuMGHeistIn")
	StartScreenEffect("MenuMGHeistOut", 800, false)
	slotMachineOpen = false
end)

function DrawAdvanced3DText(x,y,z, text, scl,font,r,g,b,a) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        if(font ~= nil)then
            SetTextFont(font)
        else
            SetTextFont(4)
        end
        SetTextProportional(1)

        SetTextColour(r, g, b, a or 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

CreateThread(function()
	while true do
		for k,v in pairs(Config.SlotMachines) do
			while #(GetEntityCoords(PlayerPedId()) - v) < 1.0 and not slotMachineOpen do
				DrawAdvanced3DText(v.x,v.y,v.z, "Apasa tasta ~g~E~w~ pentru a juca la ~r~pacanele", 0.5,0,255,255,255,150)
				Wait(1)
				if IsDisabledControlJustPressed(0,38) then
					
					
						Citizen.CreateThread(
							function()
								while true do
									Citizen.Wait(0)
									DisplayOnscreenKeyboard(6, "FMMC_KEY_TIP8", "", "", "", "", "", 70)
									while UpdateOnscreenKeyboard() == 0 do
										DisableAllControlActions(0)
										Wait(0)
									end
									if UpdateOnscreenKeyboard() == 1 then
										mesaj = true
										local amount = GetOnscreenKeyboardResult()
										if (mesaj) then
										
											TriggerServerEvent("machiamavlad:openSlotMachine",amount)
											while true do
												Citizen.Wait(111110)

												if GetOnscreenKeyboardResult() then
												end
											end
										end
									end
								end
							end
						)
					end
					
			
				end
		end
		Wait(900)
	end
end)

