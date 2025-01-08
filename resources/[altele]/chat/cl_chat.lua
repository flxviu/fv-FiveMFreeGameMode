local chatInputActive = false
local chatInputActivating = false
local mesaje = 0
chatOn = true
RegisterNetEvent("chatMessage")
RegisterNetEvent("chat:addTemplate")
RegisterNetEvent("chat:addMessage")
RegisterNetEvent("chat:addSuggestion")
RegisterNetEvent("chat:removeSuggestion")
RegisterNetEvent("chat:clear")
RegisterNetEvent("__cfx_internal:serverPrint")
RegisterNetEvent("_chat:muitzaqmessageEntered")
RegisterCommand("togchat", function()
	chatOn = not chatOn
	if not chatOn then
		SendNUIMessage({type = "ON_CLEAR"})
	else
		TriggerEvent("chatMessage", "^1Dice: ^7Chat-ul a fost activat.")
	end
end)
RegisterNetEvent("Legend:ClearChat",function() ExecuteCommand("togchat") end)

local isFrozen = false

RegisterNetEvent('white:setFreeze')
AddEventHandler('white:setFreeze', function(bool, ignoreVisibility)
    isFrozen = bool
    local ped = GetPlayerPed(-1)
    if not ignoreVisibility then
      SetEntityVisible(ped, not bool)
    end
    FreezeEntityPosition(ped, isFrozen)
    SetEntityInvincible(ped, isFrozen)
end)

Citizen.CreateThread(function()
    while true do
      while isFrozen do
        DisableControlAction(0, 311, true) -- K
        DisableControlAction(0, 24, true) -- Click
        DisableControlAction(0, 22, true) -- Space
        DisableControlAction(0, 288, true) -- F1 vMenu
        DisableControlAction(0, 289, true) -- F2 NoClip
        DisableControlAction(0, 37, true) -- TAB

        DisableControlAction(0,19,true)
        DisableControlAction(0,21,true)
        DisableControlAction(0,22,true)
        DisableControlAction(0,25,true)
        DisableControlAction(0,47,true)
        DisableControlAction(0,58,true)
        DisableControlAction(0,263,true)
        DisableControlAction(0,264,true)
        DisableControlAction(0,257,true)
        DisableControlAction(0,140,true)
        DisableControlAction(0,141,true)
        DisableControlAction(0,142,true)
        DisableControlAction(0,143,true)
        DisableControlAction(0,170,true)
        
        Citizen.Wait(1)
      end
      Citizen.Wait(1000)
    end
end)

function antiNuiLag()
    mesaje = 0
    SendNUIMessage({type = "ON_CLEAR"})
end

AddEventHandler(
    "chatMessage",
    function(author, color, text)
        if chatOn then
            local args = {text}
            mesaje = mesaje+1
            if mesaje == 150 then antiNuiLag() end;
            if author ~= "" then
                table.insert(args, 1, author)
            end
            SendNUIMessage({type = "ON_MESSAGE", message = {color = color, multiline = true, args = args}})
        end
    end
)
AddEventHandler(
    "__cfx_internal:serverPrint",
    function(msg)
        print(msg)
        SendNUIMessage({type = "ON_MESSAGE", message = {color = {0, 0, 0}, multiline = true, args = {msg}}})
    end
)
AddEventHandler(
    "chat:addMessage",
    function(message)
        SendNUIMessage({type = "ON_MESSAGE", message = message})
    end
)
AddEventHandler(
    "chat:addSuggestion",
    function(name, help, params)
        SendNUIMessage({type = "ON_SUGGESTION_ADD", suggestion = {name = name, help = help, params = params or nil}})
    end
)
AddEventHandler(
    "chat:removeSuggestion",
    function(name)
        SendNUIMessage({type = "ON_SUGGESTION_REMOVE", name = name})
    end
)
AddEventHandler(
    "chat:addTemplate",
    function(id, html)
        SendNUIMessage({type = "ON_TEMPLATE_ADD", template = {id = id, html = html}})
    end
)
AddEventHandler(
    "chat:clear",
    function(name)
        SendNUIMessage({type = "ON_CLEAR"})
    end
)
RegisterNUICallback(
    "chatResult",
    function(data, cb)
        chatInputActive = false
        SetNuiFocus(false)
        if not data.canceled then
            local id = PlayerId()
            local r, g, b = 0, 0x99, 255
            if data.message:sub(1, 1) == "/" then
                ExecuteCommand(data.message:sub(2))
            else
                TriggerServerEvent("_chat:muitzaqmessageEntered", GetPlayerName(id), {r, g, b}, data.message)
            end
        end
        cb("ok")
    end
)
RegisterNUICallback(
    "loaded",
    function(data, cb)
        TriggerServerEvent("chat:init")
        cb("ok")
    end
)
Citizen.CreateThread(
    function()
        SetTextChatEnabled(false)
        SetNuiFocus(false)
    end
)
RegisterCommand(
    "legend:openchat",
    function()
        SendNUIMessage({type = "ON_OPEN"})
        SetNuiFocus(true)
    end
)
RegisterKeyMapping("legend:openchat", "Chat", "keyboard", "t")
