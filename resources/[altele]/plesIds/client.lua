local signatureFont
local idReady = false
local baseColor = vector4(255, 255, 255, 255)
Citizen.CreateThread(function()
	RegisterFontFile('sgn')
    signatureFont = RegisterFontId('Adinda Melia')
    local txd = CreateRuntimeTxd("permis_bg")
	CreateRuntimeTextureFromImage(txd, "permis_bg", "assets/permis.png")
	txd = CreateRuntimeTxd("buletin_bg")
	CreateRuntimeTextureFromImage(txd, "buletin_bg", "assets/buletin.png")
	txd = CreateRuntimeTxd("police_bg")
	CreateRuntimeTextureFromImage(txd, "police_bg", "assets/police.png")
	txd = CreateRuntimeTxd("smurd")
	CreateRuntimeTextureFromImage(txd, "smurd", "assets/smurd.png")
	idReady = true
end)
local function drawTxt(text, font, thePos, scale, center, r, g, b, a)
	SetTextFont(font)
	SetTextProportional(center)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(thePos)
end
RegisterNetEvent("ples-id:showPoliceBadge")
AddEventHandler("ples-id:showPoliceBadge", function(data)
	while not idReady do Citizen.Wait(100) end
	local waitEnded = false
	if type(data) == "table" then
		if data.nume:len() > 0 and data.prenume:len() > 0 then
			local pedHeadshot = RegisterPedheadshot_3(PlayerPedId())
			if data.target then
				UnregisterPedheadshot(pedHeadshot)
				local player = GetPlayerFromServerId(data.target)
				pedHeadshot = RegisterPedheadshot_3(GetPlayerPed(player))
			end
			while not IsPedheadshotReady(pedHeadshot) or not IsPedheadshotValid(pedHeadshot) do Citizen.Wait(100) end
			local headshot = GetPedheadshotTxdString(pedHeadshot)
			local pos = vector2(0.2, 0.5)
			Citizen.CreateThread(function()
				while not waitEnded do
					Citizen.Wait(1)
					DrawSprite(headshot, headshot, pos+vector2(0.0315, -0.046), 0.058, 0.1, 0.0, baseColor)
					DrawSprite("police_bg", "police_bg", pos, 0.30, 0.33, 0.0, baseColor)
					drawTxt(data.nume:upper(), 0, pos+vector2(0.0525, -0.0715), 0.26, 0, 5, 5, 5, 255)
					drawTxt(data.prenume:upper(), 0, pos+vector2(0.0525, -0.044), 0.26, 0, 5, 5, 5, 255)
					drawTxt(data.rank:upper(), 0, pos+vector2(0.0525, -0.0165), 0.26, 0, 5, 5, 5, 255)
				end
			end)
			Citizen.Wait(7000)
			UnregisterPedheadshot(pedHeadshot)
			waitEnded = true
		end
	end
end)
RegisterNetEvent("ples-id:showSmurdBadge")
AddEventHandler("ples-id:showSmurdBadge", function(data)
	while not idReady do Citizen.Wait(100) end
	local waitEnded = false
	if type(data) == "table" then
		if data.nume:len() > 0 and data.prenume:len() > 0 then
			local pedHeadshot = RegisterPedheadshot_3(PlayerPedId())
			if data.target then
				UnregisterPedheadshot(pedHeadshot)
				local player = GetPlayerFromServerId(data.target)
				pedHeadshot = RegisterPedheadshot_3(GetPlayerPed(player))
			end
			while not IsPedheadshotReady(pedHeadshot) or not IsPedheadshotValid(pedHeadshot) do Citizen.Wait(100) end
			local headshot = GetPedheadshotTxdString(pedHeadshot)
			local pos = vector2(0.2, 0.5)
			Citizen.CreateThread(function()
				while not waitEnded do
					Citizen.Wait(1)
					DrawSprite(headshot, headshot, pos+vector2(0.06, 0.025), 0.08, 0.15, 0.0, baseColor)
					DrawSprite("smurd", "smurd", pos, 0.20, 0.23, 0.0, baseColor)
					drawTxt(data.nume:upper(), 0, pos-vector2(0.058, 0.043), 0.28, 0, 5, 5, 5, 255)
					drawTxt(data.prenume:upper(), 0, pos-vector2(0.04, 0.013), 0.28, 0, 5, 5, 5, 255)
				end
			end)
			Citizen.Wait(7000)
			UnregisterPedheadshot(pedHeadshot)
			waitEnded = true
		end
	end
end)
RegisterNetEvent("ples-id:showPermis")
AddEventHandler("ples-id:showPermis", function(data)
	while not idReady do Citizen.Wait(100) end
	local waitEnded = false
	if type(data) == "table" then
		if data.nume:len() > 0 and data.prenume:len() > 0 then
			local pedHeadshot = Citizen.InvokeNative(0xBA8805A1108A2515, PlayerPedId())
			if data.target then
				UnregisterPedheadshot(pedHeadshot)
				local player = GetPlayerFromServerId(data.target)
				pedHeadshot = Citizen.InvokeNative(0xBA8805A1108A2515, GetPlayerPed(player))
			end
			while not IsPedheadshotReady(pedHeadshot) or not IsPedheadshotValid(pedHeadshot) do Citizen.Wait(100) end
			local headshot = GetPedheadshotTxdString(pedHeadshot)
			local sign = data.prenume..data.nume:reverse():sub(data.nume:len())
			local pos = vector2(0.2, 0.5)
			Citizen.CreateThread(function()
				while not waitEnded do
					Citizen.Wait(1)
					DrawSprite("permis_bg", "permis_bg", pos, 0.28, 0.3, 0.0, baseColor)
					DrawSprite(headshot, headshot, pos-vector2(0.1, -0.01), 0.058, 0.1, 0.0, baseColor)
					drawTxt(data.prenume, 0, pos-vector2(0.0448, 0.12), 0.26, 0, 5, 5, 5, 255)
					drawTxt(data.nume, 0, pos-vector2(0.0448, 0.1), 0.26, 5, 0, 5, 5, 255)
					drawTxt(sign, signatureFont, pos-vector2(0.032, 0.0), 0.35, 0, 5, 5, 5, 255)
				end
			end)
			Citizen.Wait(7000)
			UnregisterPedheadshot(pedHeadshot)
			waitEnded = true
		end
	end
end)
RegisterNetEvent("ples-id:showBuletin")
AddEventHandler("ples-id:showBuletin", function(data)
	while not idReady do Citizen.Wait(100) end
	local waitEnded = false
	if type(data) == "table" then
		if data.nume:len() > 0 and data.prenume:len() > 0 then
			local sex = 5
			local pedHeadshot = Citizen.InvokeNative(0xBA8805A1108A2515, PlayerPedId())
			if not IsPedMale(PlayerPedId()) then sex = 4 end
			if data.target then
				UnregisterPedheadshot(pedHeadshot)
				local player = GetPlayerFromServerId(data.target)
				pedHeadshot = Citizen.InvokeNative(0xBA8805A1108A2515, GetPlayerPed(player))
				if not IsPedMale(GetPlayerPed(player)) then sex = 4 end
			end
			while not IsPedheadshotReady(pedHeadshot) or not IsPedheadshotValid(pedHeadshot) do Citizen.Wait(100) end
			local headshot = GetPedheadshotTxdString(pedHeadshot)
			data.nume = data.nume:upper()
			data.prenume = data.prenume:upper()
			local anul_nasterii = 20 - (data.age or 24)
			if anul_nasterii < 0 then
				anul_nasterii = 100 + anul_nasterii
			end
			local sexChr = "M"
			if sex == 4 then sexChr = "F" end
			local cnp = string.format("~r~%d~b~%02d%02d%02d~r~%06d", sex ,anul_nasterii, math.random(1, 12), math.random(1, 30), data.usr_id)
			local sect = math.random(1, 4)
			local nastere = "Mun. Bucuresti Sect. "..sect
			if data.adresa == "Str.  Nr. " then
				data.adresa = "Strada Zambilei 84"
			end
			local directiva = "S.P.C.E.P. Sector "..sect
			local pos = vector2(0.2, 0.5)
			Citizen.CreateThread(function()
				while not waitEnded do
					Citizen.Wait(1)
					DrawSprite("buletin_bg", "buletin_bg", pos, 0.25, 0.3, 0.0, baseColor)
					DrawSprite(headshot, headshot, pos-vector2(0.0855, 0.03), 0.058, 0.1, 0.0, baseColor)
					drawTxt(cnp, 0, pos-vector2(0.04, 0.09+0.0015), 0.22, 0, 5, 5, 5, 255)
					drawTxt(data.nume, 0, pos-vector2(0.05, 0.07-0.001), 0.26, 0, 5, 5, 5, 255)
					drawTxt(data.prenume, 0, pos-vector2(0.05, 0.05-0.003), 0.26, 0, 5, 5, 5, 255)
					drawTxt("Romana / ROU", 0, pos-vector2(0.05, 0.03-0.004), 0.26, 0, 5, 5, 5, 255)
					drawTxt(sexChr, 0, pos-vector2(-0.095, 0.03-0.004), 0.26, 0, 5, 5, 5, 255)
					drawTxt(nastere, 0, pos-vector2(0.05, 0.01-0.005), 0.26, 0, 5, 5, 5, 255)
					drawTxt(nastere, 0, pos-vector2(0.05, -0.01-0.007), 0.26, 0, 5, 5, 5, 255)
					drawTxt(data.adresa, 0, pos-vector2(0.05, -0.025-0.007), 0.26, 0, 5, 5, 5, 255)
					drawTxt(directiva, 0, pos-vector2(0.05, -0.045-0.009), 0.26, 0, 5, 5, 5, 255) 
					drawTxt("05.12.19-18.11.2029", 0, pos-vector2(-0.0548, -0.045-0.009), 0.26, 0, 5, 5, 5, 255) 
				end
			end)
			Citizen.Wait(7000)
			UnregisterPedheadshot(pedHeadshot)
			waitEnded = true
		end
	end
end)