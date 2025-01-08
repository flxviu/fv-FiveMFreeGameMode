local isDead = false
RegisterNetEvent('majestic-deathscreen:openUI', function(time)
    isDead = true
    SendNUIMessage({action = "DSMenu", open = true, time = time})
    if Config.Blur then
        TriggerScreenblurFadeIn()
    end
end)

RegisterNetEvent('majestic-deathscreen:revive', function()
    isDead = false
    SendNUIMessage({action = "DSMenu", open = false})
    if Config.Blur then
        TriggerScreenblurFadeOut()
    end
end)

RegisterNetEvent('majestic-deathscreen:res', function()
    SendNUIMessage({action = "res"})
end)

RegisterNetEvent('majestic-deathscreen:updateRes', function(time)
    SendNUIMessage({action = "updateRes", time = time})
end)
