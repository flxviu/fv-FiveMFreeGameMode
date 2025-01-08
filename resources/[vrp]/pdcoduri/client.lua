RegisterNetEvent("Politie:coduri")
AddEventHandler("Politie:coduri", function()
     SendNuiMessage(json.encode({adam = true}))
end)


RegisterNetEvent("Politie:codur2i")
AddEventHandler("Politie:codur2i", function()
     SendNuiMessage(json.encode({adam2 = false}))
end)
