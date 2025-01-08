vRP = Proxy.getInterface("vRP")
local annState = false
AddEventHandler("legend:ToggleAnnounces")
RegisterNetEvent("legend:ToggleAnnounces",function()
    annState = not annState
    if annState then
        vRP.notify({"Ai dezactivat Anunturile !"})
    else
        vRP.notify({"Ai activat Anunturile !"})
    end
end)
RegisterNetEvent("1TAP__CNN:NextPost")
AddEventHandler("1TAP__CNN:NextPost", function(info, tip, numar)
    if not annState then
        if tip == 'comercial' then
            SendNUIMessage({
                action = "createAnunt",
                info = info,
                telefon = numar,
                tag = 'Anunt Comercial',
            })
        elseif tip == 'event' then
            SendNUIMessage({
                action = "createAnunt",
                info = info,
                telefon = numar,
                tag = 'Anunt Eveniment',
            })
        elseif tip == 'admin' then
            SendNUIMessage({
                action = "createAnunt",
                info = info,
                telefon = numar,
                tag = 'Anunt Administrativ',
            })
        end
    end  
end)

RegisterNetEvent("1TAP__CNN:Create_FactionMessage")
AddEventHandler("1TAP__CNN:Create_FactionMessage", function(f, msg)
    if not annState then
        if f == 'Politie' then
            SendNUIMessage({
                action = "factionCNN",
                info = msg,
                f = 'politie',
            })
        else
            print("UN SCLAV CU EXECUTOR IA LA MUIE SI VREA SA PUNA ANUNTURI CUSTOM DAR E PREA PROST :)")
        end
    end
end)
