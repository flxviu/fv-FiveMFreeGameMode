RegisterNetEvent('vrp_notify:Alert', function(_, msg, _, type)
    SendNUIMessage({
        action = 'notify',
        type = type or 'info',
        message = msg
    })
end)