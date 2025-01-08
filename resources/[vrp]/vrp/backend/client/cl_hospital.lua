Citizen.CreateThread(function()

    local locatietratare = {
      {x = -817.69665527344, y = -1236.2978515625, z = 7.3374209403992},
      {x = -811.49145507813, y = 167.78262329102, z = 72.227806091309},
      {x = 306.11566162109, y = -594.15496826172, z = 43.284057617188},
      {x = 807.26531982422, y = -494.75588989258, z = 30.68829536438},
      {x = -1790.7266845703, y = 443.84649658203, z = 128.30801391602},
      {x = -1909.5313720703, y = 129.00216674805, z = 82.450675964355},
      {x = -3348.96484375, y = 1798.2585449219, z = 33.894153594971},
      {x = 752.58435058594, y = -708.01165771484, z = 28.633325576782},
      {x = -3199.2905273438, y = 838.1806640625, z = 8.9284257888794},
      {x = 321.93557739258, y = -590.67700195312, z = 43.283996582031}
    }
  
    local treatment = false
  
    local dst = 5
  
    while true do
      Citizen.Wait(2000)
      local ped = PlayerPedId()
      for _, item in pairs(locatietratare) do
        dst = GetDistanceBetweenCoords(GetEntityCoords(ped), item.x, item.y, item.z, true)
          while dst <= 15 and not treatment do
          Citizen.Wait(1)
          DrawText3D(item.x, item.y, item.z+0.25, "Ajutor Medical", 1.0)
          DrawMarker(21, item.x, item.y, item.z-0.1, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 153, 255, 200, 0, 0, 0, 1)
          if dst <= 2 then
  
            SetTextFont(4)
            SetTextCentre(1)
            SetTextProportional(0)
            SetTextScale(0.55, 0.55)
            SetTextDropShadow(30, 5, 5, 5, 255)
            SetTextEntry("STRING")
            SetTextColour(0, 153, 255, 235)
            AddTextComponentString("~w~Apasa tasta ~r~E~w~ pentru a te trata~n~Costa ~s~30.000")
            DrawText(0.5, 0.85)
  
            if IsControlJustPressed(0, 38) then
              if GetEntityHealth(PlayerPedId()) < 200 then
                TriggerServerEvent("lucidromania:platestetratarea")
                tvRP.notify("Succes: Vei fi tratat in cateva momente!")
                treatment = true
              else
                tvRP.notify("Eroare: Esti deja intr-o stare buna")
              end
            end
          end
  
          dst = GetDistanceBetweenCoords(GetEntityCoords(ped), item.x, item.y, item.z, true)
        end
  
        if treatment then
            Citizen.Wait(7000)
          treatment = false
          if GetDistanceBetweenCoords(GetEntityCoords(ped), item.x, item.y, item.z, true) <= 2 then
                SetEntityHealth(ped, 200)
                tvRP.notify("Info: Ai fost tratat")
          else
            tvRP.notify("Eroare: Nu ai avut rabdare si medicul nu a terminat sa te vindece")
          end
          end
      end 
    end       
  end)