RegisterNetEvent('alpha_radar:pay')
AddEventHandler('alpha_radar:pay',function(speed)
    local user_id = vRP.getUserId(source)
    speed = parseInt(speed)
    if speed ~= nil and speed > 0 then 
    if vRP.tryFullPayment(user_id,500000) then 
            TriggerClientEvent('chatMessage',source,'^3Police: ^0Ai fost amendat cu ^150.0000$^0 pentru ca mergeai cu ^3'..speed..' KM/h')
    else
            TriggerClientEvent('chatMessage',source,'^1Radar: ^0Nu ai destui bani pentru a plati amenda.')
        end
    end
end)