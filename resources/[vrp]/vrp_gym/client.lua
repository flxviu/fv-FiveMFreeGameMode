local Keys = {["E"] = 38, ["SPACE"] = 22, ["INSERT"] = 121}
local canExercise = false
local exercising = false
local procent = 0
local motionProcent = 0
local doingMotion = false
local motionTimesDone = 0

Citizen.CreateThread(function()
    while true do
        local coords = GetEntityCoords(PlayerPedId())
            for i, v in pairs(Config.Locations) do
                local pos = Config.Locations[i]
                local dist = GetDistanceBetweenCoords(pos["x"], pos["y"], pos["z"] + 0.98, coords, true)
                if dist <= 3.0 then
                    sleep = 1
                    DrawText3D(pos["x"], pos["y"], pos["z"] + 0.98, "[~g~E~w~] " .. pos["exercise"])
                    if IsControlJustPressed(0, Keys["E"]) then
                        startExercise(Config.Exercises[pos["exercise"]], pos)
                    end
                    else if dist <= 8.0 then
                        DrawText3D(pos["x"], pos["y"], pos["z"] + 0.98, pos["exercise"])
                    end
                end
            end
        Citizen.Wait(1)
    end
end)

function startExercise(animInfo, pos)
    local playerPed = PlayerPedId()

    LoadDict(animInfo["idleDict"])
    LoadDict(animInfo["enterDict"])
    LoadDict(animInfo["exitDict"])
    LoadDict(animInfo["actionDict"])

    if pos["h"] ~= nil then
        SetEntityCoords(playerPed, pos["x"], pos["y"], pos["z"])
        SetEntityHeading(playerPed, pos["h"])
    end

    TaskPlayAnim(playerPed, animInfo["enterDict"], animInfo["enterAnim"], 8.0, -8.0, animInfo["enterTime"], 0, 0.0, 0, 0, 0)
    Citizen.Wait(animInfo["enterTime"])

    canExercise = true
    exercising = true

    Citizen.CreateThread(function()
        while exercising do
            Citizen.Wait(0)
            if procent <= 24.99 then
                color = "~g~"
            elseif procent <= 49.99 then
                color = "~g~"
            elseif procent <= 74.99 then
                color = "~g~"
            elseif procent <= 100 then
                color = "~g~"
            end
            DrawText2D(0.505, 0.925, 1.0,1.0,0.33, "PROCENTAJ: " .. color..procent .. "%", 255, 255, 255, 255)
            DrawText2D(0.505, 0.95, 1.0,1.0,0.33, "APASA ~g~[SPACE]~w~ PENTRU A FACE ANTRENAMENTUL", 255, 255, 255, 255)
            DrawText2D(0.505, 0.975, 1.0,1.0,0.33, "APASA ~b~[INSERT]~w~ PENTRU A OPRII ANTRENAMENTUL", 255, 255, 255, 255)
        end
    end)
	
    Citizen.CreateThread(function()
        while canExercise do
            Citizen.Wait(8)
            local playerCoords = GetEntityCoords(playerPed)
            if procent <= 99 then
                TaskPlayAnim(playerPed, animInfo["idleDict"], animInfo["idleAnim"], 8.0, -8.0, -1, 0, 0.0, 0, 0, 0)
                if IsControlJustPressed(0, Keys["SPACE"]) then -- press space to exit training
                    canExercise = false
                    TaskPlayAnim(playerPed, animInfo["actionDict"], animInfo["actionAnim"], 8.0, -8.0, animInfo["actionTime"], 0, 0.0, 0, 0, 0)
                    AddProcent(animInfo["actionProcent"], animInfo["actionProcentTimes"], animInfo["actionTime"] - 70)
					TriggerServerEvent('vrp_sala:exerciseGym', 2.0)
                    canExercise = true
                end
                if IsControlJustPressed(0, Keys["INSERT"]) or GetEntityHealth(playerPed) <= 100 then -- press delete to exit training
                    ExitTraining(animInfo["exitDict"], animInfo["exitAnim"], animInfo["exitTime"])
                end
            else
                ExitTraining(animInfo["exitDict"], animInfo["exitAnim"], animInfo["exitTime"])
				TriggerServerEvent('vrp_sala:exerciseGym', 5.0)
                -- Here u can put a event to update some sort of skill or something.
                -- this is when u finished your exercise
            end
        end
    end)
end
local motionProcent = 0
RegisterNetEvent("vrp_sala:Corrida")
AddEventHandler("vrp_sala:Corrida", function()
    doingMotion = not doingMotion  
    Citizen.CreateThread(function()
        while doingMotion do
            Citizen.Wait(7) 
            if IsPedSprinting(PlayerPedId()) then
                motionProcent = motionProcent + 9
            elseif IsPedRunning(PlayerPedId()) then
                motionProcent = motionProcent + 6
            elseif IsPedWalking(PlayerPedId()) then
                motionProcent = motionProcent + 3
            end
            
            DrawText2D(0.505, 0.95, 1.0,1.0,0.4, "~b~PROCENTAJ:~w~ " .. tonumber(string.format("%.1f", motionProcent/1000)) .. "%", 255, 255, 255, 255)
            if motionProcent >= 100000 then
				TriggerServerEvent('vrp_sala:exerciseRunning', motionProcent/10000)
                doingMotion = false
                motionProcent = 0
				TriggerEvent('chatMessage', 'Loyal', {12,94,245}, "Opreste-te", {255, 255, 255, 1.0,'', 0, 0, 100, 0.5})
            end
        end
    end)
	
    if doingMotion then
        motionTimesDone = motionTimesDone + 1
        if motionTimesDone <= 2 then
			TriggerEvent('chatMessage', 'Loyal', {12,94,245}, "Ai inceput antrenamentul", {255, 255, 255, 1.0,'', 0, 0, 100, 0.5})
            print(motionTimesDone)
        else
			TriggerEvent('chatMessage', 'Loyal', {12,94,245}, "Ai obosit", {255, 255, 255, 1.0,'', 100, 100, 0, 0.5})
            doingMotion = false
        end
    else
		TriggerEvent('chatMessage', 'Loyal', {12,94,245}, "Te-ai oprit.", {255, 255, 255, 1.0,'', 0, 0, 100, 0.5})
		TriggerServerEvent('vrp_sala:exerciseRunning', motionProcent/10000)
    end
end)

function ExitTraining(exitDict, exitAnim, exitTime)
    TaskPlayAnim(PlayerPedId(), exitDict, exitAnim, 8.0, -8.0, exitTime, 0, 0.0, 0, 0, 0)
    Citizen.Wait(exitTime)
    canExercise = false
    exercising = false
    procent = 0
end

function AddProcent(amount, amountTimes, time)
    for i=1, amountTimes do
        Citizen.Wait(time/amountTimes)
        procent = procent + amount
    end
end

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(6)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
end
      
function DrawText2D(x, y, width, height, scale, text, r, g, b, a, outline)
	SetTextFont(4)
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