RegisterNetEvent("lucidDeathScreen:SetDeath", function(...)
 local args = {...};
 SendNUIMessage({ setDeath = args[1] })
end);

RegisterNetEvent("lucidDeathScreen:SetButon",function(...)
 local args = {...};
 SendNUIMessage{setButon = args[1]};
end)


RegisterNetEvent("lucidDeathScreen:SetDeathTime", function(...)
 local args = {...};
 SendNUIMessage({ updateTime = true; secunde = args[1] })
end);
