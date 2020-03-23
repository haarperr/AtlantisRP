ESX               = nil
local closestPlayer, closestDistance = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("esx_sellcar:Sell")
AddEventHandler("esx_sellcar:Sell", function(price)

sellcar(price)

end)
RegisterNetEvent("esx_sellcar:Ask")
AddEventHandler("esx_sellcar:Ask", function(plate, price)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer == -1 or closestDistance > 3.0 then
	  ESX.ShowNotification('~r~Brak gracza w pobliżu')
	else
	  OpenConfirmBuyCarMenu(plate, price, closestPlayer)
	end


end)
function sellcar(price)
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	local _price = price

	if IsPedInAnyVehicle(playerPed,  false) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
	--else
	--	vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 7.0, 0, 70)
	end
	
	local plate = GetVehicleNumberPlateText(vehicle)
	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	ESX.TriggerServerCallback('esx_sellcar:checkMoney', function(enoughMoney)

		if enoughMoney then
			ESX.TriggerServerCallback('esx_sellcar:requestPlayerCars', function(isOwnedVehicle)

				if isOwnedVehicle then
					if closestPlayer == -1 or closestDistance > 3.0 then
					  ESX.ShowNotification('~r~Brak gracza w pobliżu')
					else
					  ESX.ShowNotification('Oferujesz sprzedaż pojazdu: ~g~'..vehicleProps.plate..'!')
					  TriggerServerEvent('esx_sellcar:setVehicleOwnedPlayerIdAsk', GetPlayerServerId(closestPlayer), vehicleProps, _price)
					end
				
				else
					ESX.ShowNotification('Pojazd nie należy do Ciebie!')
				end
			end, GetVehicleNumberPlateText(vehicle))
		else
			Citizen.Wait(2000)
			TriggerServerEvent('esx_sellcar:CancelOffer', GetPlayerServerId(PlayerId()))
		end
	end, GetPlayerServerId(closestPlayer), price)

	
end


function OpenConfirmBuyCarMenu(plate, price, player) --This function is menu function

    local elements = {
          {label = 'Przyjmij ofertę', value = 'accept'},
          {label = 'Odrzuć ofertę', value = 'cancel'},
          
        }
  
    ESX.UI.Menu.CloseAll()
  
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'buyacar',
      {
        title    = 'Oferta sprzedaży: '.. plate .. " - " .. price .."$",
        align    = 'right',
        elements = elements
        },
  
            function(data, menu)
  
  
              local player, distance = ESX.Game.GetClosestPlayer()
  
              if distance ~= -1 and distance <= 3.0 then
  
                if data.current.value == 'accept' then
                  TriggerServerEvent('esx_sellcar:setVehicleOwnedPlayerId', GetPlayerServerId(PlayerId()), plate, price, GetPlayerServerId(player))
                  ESX.UI.Menu.CloseAll()
                elseif data.current.value == 'cancel' then
                  TriggerServerEvent('esx_sellcar:CancelOffer', GetPlayerServerId(player))
                  ESX.ShowNotification('~r~Odrzucasz ofertę')
                  ESX.UI.Menu.CloseAll()
                end
              else
                ESX.ShowNotification('~r~Brak gracza w pobliżu')
              end
            end,
      function(data, menu)
        menu.close()
      end
    )
  
  end