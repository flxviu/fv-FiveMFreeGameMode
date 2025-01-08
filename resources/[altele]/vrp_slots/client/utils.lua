RegisterFontFile("FontTurf")
Gothic = RegisterFontId("Font Turf")
vRPCSlots = {}
Tunnel.bindInterface("vrp_slots",vRPCSlots)
Proxy.addInterface("vrp_slots",vRPCSlots)
vRP = Proxy.getInterface("vRP")
moneyBet = "0$"
isSpinning = false
slotMachineOpen = false
gambleOpen = false
combTable = {}
gambleTable = {}
gHeading = 0.0
autoSpin = false
shownCard = ""

function getState(x)
    if x then
        return "~g~ON"
    end
    return "~r~OFF"
end

function isCursorInPosition(x,y,width,height)
    local sx, sy = GetActiveScreenResolution()
    local cx, cy = GetNuiCursorPosition()
    local cx, cy = (cx / sx), (cy / sy)
  
    local width = width / 2
    local height = height / 2
  
    if (cx >= (x - width) and cx <= (x + width)) and (cy >= (y - height) and cy <= (y + height)) then
        return true
    else
        return false
    end
end

function DrawOnScreenButton(x,y,w,h,scale,font,text,col,defAlpha,onHover,callback)
    local defAlpha = defAlpha or 150
    local w,h = w or 0.08, h or 0.02
    local isHovering = isCursorInPosition(x,y,w,h)
    local font = font or 2
    
    if onHover then
        if isHovering then
            DrawRect(x,y,w,h,col[1],col[2],col[3],200)
        else
            DrawRect(x,y,w,h,col[1],col[2],col[3],defAlpha)
        end
    else
        DrawRect(x,y,w,h,col[1],col[2],col[3],defAlpha)
    end
    if isHovering then
        SetCursorSprite(5)
        if IsDisabledControlJustPressed(0, 24) then
            callback()
        end
    end
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale,scale)
    SetTextColour(255,255,255, 255)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x + 0.0001,(y + 0.0001) - (0.015 * ((scale * 2.5))))
end

function drawTxt(x,y,scale,text,r,g,b,a,font)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextCentre(1)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - 0.0/2, y - 0.0/2 + 0.005)
end

function DrawAdvanced3DText(x,y,z, text, scl,font,r,g,b,a) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        if(font ~= nil)then
            SetTextFont(font)
        else
            SetTextFont(4)
        end
        SetTextProportional(1)

        SetTextColour(r, g, b, a or 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

-- Nu atinge!
UtilsTable = {
    [1] = {position = vec2(0.36,0.37), prize = "questionMark"},
    [2] = {position = vec2(0.36,0.485), prize = "questionMark"},
    [3] = {position = vec2(0.36,0.6), prize = "questionMark"},
    
    [4] = {position = vec2(0.4325,0.37), prize = "questionMark"},
    [5] = {position = vec2(0.4325,0.485), prize = "questionMark"},
    [6] = {position = vec2(0.4325,0.6), prize = "questionMark"},

    [7] = {position = vec2(0.505,0.37), prize = "questionMark"},
    [8] = {position = vec2(0.505,0.485), prize = "questionMark"},
    [9] = {position = vec2(0.505,0.6), prize = "questionMark"},

    [10] = {position = vec2(0.5775,0.37), prize = "questionMark"},
    [11] = {position = vec2(0.5775,0.485), prize = "questionMark"},
    [12] = {position = vec2(0.5775,0.6), prize = "questionMark"},

    [13] = {position = vec2(0.65,0.37), prize = "questionMark"},
    [14] = {position = vec2(0.65,0.485), prize = "questionMark"},
    [15] = {position = vec2(0.65,0.6), prize = "questionMark"}
}


local symbols = {"cherriesSlot","grapesSlot","sevenSlot","lemonSlot","melonSlot","orangeSlot","plumSlot"}
local icons = {
    "questionMark",
    "redCard",
    "blackCard",
    "redCard1",
    "blackCard1"
}

local function loadAllIcons()
    for i = 1 , #symbols do
        table.insert(icons,symbols[i])
    end

    for i, v in pairs(icons) do
        local txd = CreateRuntimeTxd(v)
        CreateRuntimeTextureFromImage(txd, v, "assets/"..v..".png")
    end
end

loadAllIcons()

function formatMoney(amount)
    local left,num,right = string.match(tostring(amount),'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end