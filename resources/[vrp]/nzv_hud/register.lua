RegisterNetEvent("nzv:openPlayerRegister", function ()
	SetNuiFocus(true, true)
	SendNUIMessage({
        action = 'openRegisterUi'
    })
end)

RegisterNetEvent("nzv:closePlayerRegister", function ()
	SetNuiFocus(false, false)
	SendNUIMessage({
        action = 'closeRegisterUi'
    })
end)

local delayRegister = nil
RegisterNUICallback("register", function(data, cb)
	if delayRegister == nil then
    	TriggerServerEvent("nzv:setRegisterData", data)
    	delayRegister = 1000
    	SetTimeout(2500, function ()
    		delayRegister = nil
    	end)
    end
    cb("ok")
end)