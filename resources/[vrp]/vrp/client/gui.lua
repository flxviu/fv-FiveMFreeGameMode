AddEventHandler("vRP:pauseChange", function(paused)
	SendNUIMessage({act="pause_change", paused=paused})
end)

local focus = false
exports("isUiFocused", function()
  return focus
end)

RegisterNetEvent("vRP:interfaceFocus")
AddEventHandler("vRP:interfaceFocus", function(stateTbl, keepInput)
	if type(stateTbl) == "table" then
		SetNuiFocus(stateTbl[1], stateTbl[2])
  else
    SetNuiFocus(stateTbl, stateTbl)
  end

  focus = stateTbl

  SetNuiFocusKeepInput(keepInput)
end)

RegisterNUICallback("setFocus", function(data, cb)
	TriggerEvent("vRP:interfaceFocus", data[1])
  
	cb('ok')
  end)

tvRP.openMenuData = function(menudata)
  SendNUIMessage({act="open_menu", menudata = menudata})
  SetNuiFocus(false)
  SetNuiFocus(false)
  vRPserver.promptResult()
end

function tvRP.closeMenu()
  SendNUIMessage({act="close_menu"})
  SetNuiFocus(false)
  SetNuiFocus(false)
  vRPserver.promptResult()
end

local keepPromptFocus, keepRequestFocus = false, false
function tvRP.prompt(title,description,response,keepFocus)
  keepPromptFocus = keepFocus
  SendNUIMessage({act="prompt",title=title,description=description,response=response})
  TriggerEvent("vRP:interfaceFocus", true)
  -- SetCursorLocation(0.5, 0.5)
end

function ShowScreen(divId)
    SendNUIMessage({
        act = "screen",
        action = "show",
        div = divId
    })
end

function HideScreen(divId)
    SendNUIMessage({
        act = "screen",
        action = "hide",
        div = divId
    })
end

tvRP.showDiv = ShowScreen
tvRP.hideDiv = HideScreen

local waitingRequestResult = false
function tvRP.request(id,text,title,keepFocus)
  SendNUIMessage({act="request",id=id,text=tostring(text),title=title})
  waitingRequestResult = true
  while waitingRequestResult do
    DisableControlAction(0, 24, true) -- disable attack
		DisableControlAction(0, 25, true) -- disable aim
		DisableControlAction(0, 1, true) -- disable mouse look
		DisableControlAction(0, 2, true) -- disable mouse look
		DisableControlAction(0, 3, true) -- disable mouse look
		DisableControlAction(0, 4, true) -- disable mouse look
		DisableControlAction(0, 5, true) -- disable mouse look
		DisableControlAction(0, 6, true) -- disable mouse look
		DisableControlAction(0, 263, true) -- disable melee
		DisableControlAction(0, 264, true) -- disable melee
		DisableControlAction(0, 257, true) -- disable melee
		DisableControlAction(0, 140, true) -- disable melee
		DisableControlAction(0, 141, true) -- disable melee
		DisableControlAction(0, 142, true) -- disable melee
		DisableControlAction(0, 143, true) -- disable melee
		DisableControlAction(0, 177, true) -- disable escape
		DisableControlAction(0, 199, true) -- disable escape
		DisableControlAction(0, 200, true) -- disable escape
		DisableControlAction(0, 202, true) -- disable escape
		DisableControlAction(0, 322, true) -- disable escape
		DisableControlAction(0, 245, true) -- disable chat
    Citizen.Wait(1)
  end
end

RegisterNUICallback("menu",function(data,cb)
  if data.act == "close" then
	  vRPserver.closeMenu({data.id})
  elseif data.act == "valid" then
	  vRPserver.validMenuChoice({data.id,data.choice,data.mod})
  end
end)


RegisterNUICallback("prompt",function(data,cb)
	vRPserver.promptResult({data[1]})
  
	if not keepPromptFocus then
	  TriggerEvent("vRP:interfaceFocus", false)
	end
  
	cb("ok")
  end)
  
  -- gui request event
  RegisterNUICallback("request",function(data,cb)
	vRPserver.requestResult({data.id,data.ok})  
	waitingRequestResult = false
	cb("ok")
  end)

tvRP.announce = function(background,content)
    SendNUIMessage({act="announce",background=background,content=content})
end

RegisterNUICallback("cfg",function(data,cb)
	SendNUIMessage({act="cfg",cfg=cfg.gui})
end)
SendNUIMessage({act="cfg",cfg=cfg.gui})

for i=1,5 do
	SetTimeout(5000*i, function() SendNUIMessage({act="cfg",cfg=cfg.gui}) end)
end

function tvRP.setProgressBar(name,anchor,text,r,g,b,value)
  local pbar = {name=name,anchor=anchor,text=text,r=r,g=g,b=b,value=value}
  if pbar.value == nil then pbar.value = 0 end
  SendNUIMessage({act="set_pbar",pbar = pbar})
end

function tvRP.setProgressBarValue(name,value)
  SendNUIMessage({act="set_pbar_val", name = name, value = value})
end

-- set progress bar text
function tvRP.setProgressBarText(name,text)
  SendNUIMessage({act="set_pbar_text", name = name, text = text})
end

-- remove a progress bar
function tvRP.removeProgressBar(name)
  SendNUIMessage({act="remove_pbar", name = name})
end

RegisterCommand("testprogressbar", function()
	local pbar = {name="muie",anchor="center",text="O futi pe mama lui hyper...",r=0,g=191,b=255,value=50}
	SendNUIMessage({act="set_pbar",pbar = pbar})
  end)

  RegisterCommand('caca', function()
	SendNuiMessage({act="set_pbar", pbar = nil})
  end)




tvRP.setDiv = function(name,css,content)
	SendNUIMessage({act="set_div", name = name, css = css, content = content})
end


tvRP.setDivCss = function(name,css)
	SendNUIMessage({act="set_div_css", name = name, css = css})
end

tvRP.setDivContent = function(name,content)
	SendNUIMessage({act="set_div_content", name = name, content = content})
end

tvRP.divExecuteJS = function(name,js)
	SendNUIMessage({act="div_execjs", name = name, js = js})
end

tvRP.removeDiv = function(name)
	SendNUIMessage({act="remove_div", name = name})
end

function tvRP.sendCoordsToClipboard()
	local ped = PlayerPedId()
	local coords = _GCOORDS 
	SendNUIMessage({
		act = 'clipboard',
		text = coords[1]..','..coords[2]..','..coords[3]
	})
	tvRP.notify('Coordonatele au fost copiate!')
end

local paused = false

function tvRP.isPaused()
	return paused
end

tastaBlocata = false
function tvRP.disableMeniu(bool)
	tastaBlocata = bool
end

local shiftBlocat = false
function tvRP.disableTastaShift(bool)
  shiftBlocat = bool
  Citizen.CreateThread(function()
	  while true do
		  if shiftBlocat then
			  DisableControlAction(0, 21, true)
			  DisableControlAction(0, 61, true)
			  DisableControlAction(0, 131, true)
			  DisableControlAction(0, 155, true)
			  DisableControlAction(0, 209, true)
			  DisableControlAction(0, 254, true)
			  DisableControlAction(0, 340, true)
			  DisableControlAction(0, 352, true)
		  else
			  break
		  end
		  Wait(0)
	  end
  end)
end

function tvRP.canHandleAnim()
    local ped = _GPED
    local _, weapon = GetCurrentPedWeapon(_GPED, false)
    local fistKey = GetHashKey("WEAPON_UNARMED")
	if (not IsPedInAnyVehicle(_GPED, false)) and (not IsPedSwimming(_GPED)) and (not IsPedRunning()) and (not IsPedShooting(_GPED)) and (not IsPedJumping(_GPED)) and (not IsPedUsingAnyScenario(_GPED)) and (not IsPedInParachuteFreeFall(_GPED)) and (weapon == fistKey) and (not importantAnim) and (not IsPauseMenuActive()) and (not tvRP.isInComa() and not tastaBlocata and not isHandsUp and not isBusted and not GymInWorkout) then
        return true
    end
    return false
end

--===========HOTKEYS===========--
isChangingPos = false
local keytable = {
	["k"] = {
		commandname = "gui_openmainmenu",
		description = "Deschide meniul principal K",
		func = function() if ((not tvRP.isInComa() or not cfg.coma_disable_menu) and (not tvRP.isHandcuffed() or not cfg.handcuff_disable_menu) and not isChangingPos) then vRPserver.openMainMenu({}) end end
	},
	["up"] = {
	  commandname = "gui_menuup",
	  description = "Key UP",
	  func = function() 
		if not isChangingPos then
		  SendNUIMessage({act="event",event="UP"})
		  Citizen.CreateThread(function()
			local timer = 0
			while IsControlPressed(table.unpack(cfg.controls.phone.up)) do
			  Citizen.Wait(0)
			  timer = timer + 1
			  if timer > 30 then
			  Citizen.Wait(25)
			  SendNUIMessage({act="event",event="UP"})
			  end
			end
		  end)
		end
	   end
	},
	["down"] = {
	  commandname = "gui_menudown",
	  description = "Key DOWN",
	  func = function() 
		if not isChangingPos then
		  SendNUIMessage({act="event",event="DOWN"}) 
		  Citizen.CreateThread(function()
			local timer = 0
			while IsControlPressed(table.unpack(cfg.controls.phone.down)) do
			  Citizen.Wait(0)
			  timer = timer + 1
			  if timer > 30 then
			  Citizen.Wait(25)
			  SendNUIMessage({act="event",event="DOWN"})
			  end
			end
		  end)
		end
	  end
	},
	["left"] = {
	  commandname = "gui_menuleft",
	  description = "Key LEFT",
	  func = function() if not isChangingPos then SendNUIMessage({act="event",event="LEFT"}) end end
	},
	["right"] = {
	  commandname = "gui_menuright",
	  description = "Key RIGHT",
	  func = function() if not isChangingPos then SendNUIMessage({act="event",event="RIGHT"}) end end
	},
	["return"] = {
	  commandname = "gui_menuselect",
	  description = "Key SELECT",
	  func = function() if not isChangingPos then SendNUIMessage({act="event",event="SELECT"}) end end
	},
	["back"] = {
	  commandname = "gui_menuback",
	  description = "Key BACK",
	  func = function() if not isChangingPos then SendNUIMessage({act="event",event="CANCEL"}) end end
	},
	["F5"] = {
	  commandname = "gui_menuF5",
	  description = "Accepta apel",
	  func = function() if not isChangingPos then SendNUIMessage({act="event",event="F5"}) end end
	},
	["F6"] = {
	  commandname = "gui_menuF6",
	  description = "Respinge Apel",
	  func = function() if not isChangingPos then SendNUIMessage({act="event",event="F6"}) end end
	}
  }

Citizen.CreateThread(function()
	for k,v in pairs(keytable) do
		RegisterCommand(v.commandname, function()
			v.func()
		end)
		RegisterKeyMapping(v.commandname, v.description, 'keyboard', k)
	end
end)