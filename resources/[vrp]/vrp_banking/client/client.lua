--================================================================================================
--==                                VARIABLES - DO NOT EDIT                                     ==
--================================================================================================
inMenu                      = true
local showblips = true
local atbank = false
local bankMenu = true
local banks = {
  {name="Banca", x=150.266, y=-1040.203, z=29.374},
  {name="Banca", x=-1212.980, y=-330.841, z=37.787},
  {name="Banca", x=-2962.582, y=482.627, z=15.703},
  {name="Banca", x=-112.202, y=6469.295, z=31.626},
  {name="Banca", x=314.187, y=-278.621, z=54.170},
  {name="Banca", x=-351.534, y=-49.529, z=49.042},
  {name="Banca", x=246.400, y=223.204, z=106.286},
  {name="Banca", x= -1308.827, y=-823.879, z=17.148},
  {name="Banca", x=-569.68225097656, y=-586.03021240234, z=41.430229187012}, -- mall
  {name="Banca", x=-569.5873413086, y=-592.35278320312, z=41.430229187012}, -- mall
  {name="Banca", x=121.26466369629, y=-3019.7783203125, z=7.0408878326416},
  {name="Banca", x=1175.0643310547, y=2706.6435546875, z=38.094036102295},
  {name="Banca", x=-540.12493896484, y=-198.54289245605, z=38.22110748291},
  {name="Banca", x=-552.49157714844, y=-205.97828674316, z=38.221069335938}

}

local atms = {


}

--===============================================
--==             Core Threading                ==
--===============================================
Citizen.CreateThread(function()
	while true do
		Wait(1000)
		while nearBank() or nearATM() do
			DisplayHelpText("Apasa ~INPUT_PICKUP~ pentru a iti accesa contul ~r~")

			if IsControlJustPressed(1, 38) then
				inMenu = true
				SetNuiFocus(true, true)
				SendNUIMessage({type = 'openGeneral'})
				TriggerServerEvent('TRF:balance')

				while inMenu do
					if IsControlJustPressed(1, 322) then
						inMenu = false
						SetNuiFocus(false, false)
						SendNUIMessage({type = 'close'})
					end
					Wait(1)
				end
			end
			Wait(1)
		end

	end
end)


--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNetEvent('TRFcurrentbalance1')
AddEventHandler('TRFcurrentbalance1', function(balance)
	local id = PlayerId()
	local playerName = GetPlayerName(id)

	SendNUIMessage({
		type = "balanceHUD",
		balance = balance,
		player = playerName
		})
end)
--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('TRF:deposit', tonumber(data.amount))
	TriggerServerEvent('TRF:balance')
end)

--===============================================
--==          Withdraw Event                   ==
--===============================================
RegisterNUICallback('withdrawl', function(data)
	TriggerServerEvent('TRF:withdraw', tonumber(data.amountw))
	TriggerServerEvent('TRF:balance')
end)

--===============================================
--==         Balance Event                     ==
--===============================================
RegisterNUICallback('balance', function()
	TriggerServerEvent('TRF:balance')
end)

RegisterNetEvent('balance:back')
AddEventHandler('balance:back', function(balance)
	SendNUIMessage({type = 'balanceReturn', bal = balance})
end)


--===============================================
--==         Transfer Event                    ==
--===============================================
RegisterNUICallback('transfer', function(data)
	TriggerServerEvent('TRF:transfer', data.to, data.amountt)
	TriggerServerEvent('TRF:balance')
end)

--===============================================
--==         Result   Event                    ==
--===============================================
RegisterNetEvent('bank:result')
AddEventHandler('bank:result', function(type, message)
	SendNUIMessage({type = 'result', m = message, t = type})
end)

--===============================================
--==               NUIFocusoff                 ==
--===============================================
RegisterNUICallback('NUIFocusOff', function()
	inMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeAll'})
end)


--===============================================
--==            Capture Bank Distance          ==
--===============================================
function nearBank()
	local player = PlayerPedId()
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(banks) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

		if distance <= 3 then
			return true
		end
	end
end

function nearATM()
	local player = PlayerPedId()
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(atms) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

		if distance <= 2 then
			return true
		end
	end
end


function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
