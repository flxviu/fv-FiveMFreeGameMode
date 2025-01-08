RegisterNetEvent("lucidromania:platestetratarea")
AddEventHandler("lucidromania:platestetratarea", function()
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    if vRP.tryFullPayment(user_id,30000) then
    end
end)