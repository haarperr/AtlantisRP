ESX = nil
local isAllowed = false
local Hired = false
local CurrentJobGrade = 0
local allowedHex = {'steam:x','steam:x'}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
	CheckIfIsHired()
	CheckIfIsAllowed()
end)


Marker = {
	  
	{
		Pos   = {x = 153.41, y = -3077.97, z = 5.91},
		event = 'organisationmenu'
	},
	{
		Pos   = {x = 128.03, y = -3073.49, z = 5.92},
		event = 'StorageMenu'
	},
	{
		Pos   = {x = 114.71, y = -3101.16, z = 6.0},
		event = 'GarageMenu'
	},

}
local p1coords = GetEntityCoords(PlayerPedId())
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)
		p1coords = GetEntityCoords(PlayerPedId())
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if isAllowed or Hired then
			for i=1, #Marker do
		        local markerID = Marker[i]
				local dystans = GetDistanceBetweenCoords(markerID.Pos.x, markerID.Pos.y, markerID.Pos.z, p1coords, true)

				if dystans < 10 then
					DrawMarker(27,markerID.Pos.x, markerID.Pos.y, markerID.Pos.z-0.90, 0, 0, 0, 0, 0, 0, 1.6, 1.6, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0) 
					if dystans < 2 then
						if IsControlJustReleased(0, 38) and dystans < 1.25 then
							TriggerEvent(markerID.event)
						end
					end
				end
			end
		else
			Wait(5000)
		end
	end
end)

function checkArray (array, val)
  for name, value in ipairs(array) do
	  if value == val then
		  return true
	  end
  end
  return false
end

function CheckIfIsAllowed()
	hex = PlayerData.identifier
	if checkArray(allowedHex, hex) then
		isAllowed = true
	else
		isAllowed = false
	end
end

function CheckIfIsHired()
	ESX.TriggerServerCallback('esx_society:job2', function(job2name)
		if job2name == 'society_organisation' then
			Hired = true
			gradeCheck()
		else
			Hired = false
		end
	end)	
end

function gradeCheck()
	ESX.TriggerServerCallback('organisation:grade', function(jobGrade)
		CurrentJobGrade = jobGrade 
	end)	
end

function IsHired()
	ESX.TriggerServerCallback('esx_society:job2', function(job2name)
		if job2name == 'society_organisation' then
			Hired = true
		else
			Hired = false
		end
	end)
	if Hired then
		return true
	else
		return false
	end	
end
RegisterNetEvent('update:job2grade')
AddEventHandler('update:job2grade', function()
	gradeCheck()
end)

AddEventHandler('organisationmenu', function()
	if isAllowed then
		TriggerEvent('esx_society:organisationmenu', 'society_organisation')
	end
end)

AddEventHandler('StorageMenu', function()
	StorageMenu()
end)

AddEventHandler('GarageMenu', function()
	if IsPedInAnyVehicle(PlayerPedId(), false) then
	    DeleteJobVehicle()
	else
		OpenVehicleSpawnerMenu()
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--szafka

function StorageMenu()
	local elements = {}
	if IsHired() then
		table.insert(elements, {label = 'Wyciągnij broń',     value = 'get_weapon'})
		table.insert(elements, {label = 'Schowaj broń',     value = 'put_weapon'})
		table.insert(elements, {label = 'Wyciągnij przedmiot z szafki',  value = 'get_stock'})
		table.insert(elements, {label = 'Wsadź przedmiot do szafki', value = 'put_stock'})
		if CurrentJobGrade > 0 then
			table.insert(elements, {label = 'Sejf', value = 'money_menu'})
		end

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'storage',
		{
			title    = 'Storage',
			align    = 'right',
			elements = elements
		}, function(data, menu)

			if data.current.value == 'get_weapon' then
				OpenGetWeaponMenu()
			elseif data.current.value == 'put_weapon' then
				OpenPutWeaponMenu()
			elseif data.current.value == 'put_stock' then
				OpenPutStocksMenu()
			elseif data.current.value == 'get_stock' then
				OpenGetStocksMenu()
			elseif data.current.value == 'money_menu' then
				MoneyMenu()
			end

		end, function(data, menu)
			menu.close()
		end)
	end
end
local lockStorage = false
function OpenGetWeaponMenu()
if not lockStorage then
	lockStorage = true
	ESX.TriggerServerCallback('organisation:getArmoryWeapons', function(weapons)
		local elements = {}

		for i=1, #weapons, 1 do
			if weapons[i].count > 0 then
				table.insert(elements, {
					label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name),
					value = weapons[i].name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'organisation_get_weapon',
		{
			title    = 'Pobierz broń',
			align    = 'right',
			elements = elements
		}, function(data, menu)

			menu.close()

			ESX.TriggerServerCallback('organisation:removeArmoryWeapon', function(havenil)

			end, data.current.value)
			Wait(2000)
			lockStorage = false
		end, function(data, menu)
			menu.close()
			Wait(2000)
			lockStorage = false
		end)
	end)
end
end

function OpenPutWeaponMenu()
if not lockStorage then
	lockStorage = true
	local elements   = {}
	local playerPed  = PlayerPedId()
	local weaponList = ESX.GetWeaponList()

	for i=1, #weaponList, 1 do
		local weaponHash = GetHashKey(weaponList[i].name)

		if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
			table.insert(elements, {
				label = weaponList[i].label,
				value = weaponList[i].name
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'organisation_put_weapon',
	{
		title    = 'Schowaj broń',
		align    = 'right',
		elements = elements
	}, function(data, menu)

		menu.close()

		ESX.TriggerServerCallback('organisation:addArmoryWeapon', function(havenil)

		end, data.current.value, true)
		Wait(2000)
		lockStorage = false
	end, function(data, menu)
		menu.close()
		Wait(2000)
		lockStorage = false
	end)
end
end

function OpenGetStocksMenu()

	ESX.TriggerServerCallback('organisation:getStockItems', function(items)

		local elements = {}

		for i=1, #items, 1 do
			if items[i].count > 0 then
				table.insert(elements, {
					label = 'x' .. items[i].count .. ' ' .. items[i].label,
					value = items[i].name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'storage_menu',
		{
			title    = 'Szafka',
			align    = 'right',
			elements = elements
		}, function(data, menu)

			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'storage_menu_get_item_count', {
				title = 'quantity'
			}, function(data2, menu2)

				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification('quantity_invalid')
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('organisation:getStockItem', itemName, count)

				end

			end, function(data2, menu2)
				menu2.close()
			end)

		end, function(data, menu)
			menu.close()
		end)

	end)

end

function OpenPutStocksMenu()

	ESX.TriggerServerCallback('organisation:getPlayerInventory', function(inventory)

		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'organisation_stocks_menu',
		{
			title    = 'Ekwipunek',
			align    = 'right',
			elements = elements
		}, function(data, menu)

			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'organisation_stocks_menu_put_item_count', {
				title = 'quantity'
			}, function(data2, menu2)

				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification('quantity_invalid')
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('organisation:putStockItems', itemName, count)

				end

			end, function(data2, menu2)
				menu2.close()
			end)

		end, function(data, menu)
			menu.close()
		end)
	end)

end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- kasa

function MoneyMenu()
	local elements = {}

	table.insert(elements, {label = 'Stan konta',     value = 'account'})
	table.insert(elements, {label = 'Zdeponuj pieniądze',     value = 'put_money'})
	table.insert(elements, {label = 'Wyciągnij pieniądze',  value = 'get_money'})
	table.insert(elements, {label = 'Zdeponuj nieopodatkowane pieniądze',     value = 'put_dirty_money'})
	table.insert(elements, {label = 'Wyciągnij nieopodatkowane pieniądze',  value = 'get_dirty_money'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'money',
	{
		title    = 'Sejf',
		align    = 'right',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'account' then
			TriggerServerEvent('organisation:showmoney')
		elseif data.current.value == 'put_money' then
			putmoneymenu()
		elseif data.current.value == 'get_money' then
			takemoneymenu()
		elseif data.current.value == 'put_dirty_money' then
			putdirtymenu()
		elseif data.current.value == 'get_dirty_money' then
			takedirtymenu()
		end

	end, function(data, menu)
		menu.close()
	end)
end

function putmoneymenu()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'xxxx', {
		title = 'amount'
	}, function(data2, menu)

		local quantity = tonumber(data2.value)
		if quantity == nil then
			ESX.ShowNotification('amount_invalid')
		else
			menu.close()

			TriggerServerEvent('organisation:putmoneyclean', quantity)
		end

	end, function(data2,menu)
		menu.close()
	end)
end

function takemoneymenu()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'xxxxxx', {
		title = 'amount'
	}, function(data2, menu)

		local quantity = tonumber(data2.value)
		if quantity == nil then
			ESX.ShowNotification('amount_invalid')
		else
			menu.close()

			TriggerServerEvent('organisation:takemoneyclean', quantity)
		end

	end, function(data2,menu)
		menu.close()
	end)
end


function putdirtymenu()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'xxxx', {
		title = 'amount'
	}, function(data2, menu)

		local quantity = tonumber(data2.value)
		if quantity == nil then
			ESX.ShowNotification('amount_invalid')
		else
			menu.close()

			TriggerServerEvent('organisation:putmoney', quantity)
		end

	end, function(data2,menu)
		menu.close()
	end)
end

function takedirtymenu()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'xxxxxx', {
		title = 'amount'
	}, function(data2, menu)

		local quantity = tonumber(data2.value)
		if quantity == nil then
			ESX.ShowNotification('amount_invalid')
		else
			menu.close()

			TriggerServerEvent('organisation:takemoney', quantity)
		end

	end, function(data2,menu)
		menu.close()
	end)
end

RegisterNetEvent('organisation:safe')
AddEventHandler('organisation:safe', function(clean, dirty)
	local _cleanmoney = tonumber(clean)
	local _dirtymoney = tonumber(dirty)
	Safe(_cleanmoney,_dirtymoney)
end)

function Safe(clean, dirty)
	
	local elements = {}

	table.insert(elements, {label = 'Gotówka: <span style="color:green;">'..clean..'$',     value = '1'})
	table.insert(elements, {label = 'Nieopodoatkowana Gotówka: <span style="color:red;">'..dirty..'$',     value = '2'})


	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Safe',
	{
		title    = 'Sejf',
		align    = 'right',
		elements = elements
	}, function(data, menu)

		if data.current.value == '1' then
			menu.close()
		elseif data.current.value == '2' then
			menu.close()
		end

	end, function(data, menu)
		menu.close()
		MoneyMenu()
	end)
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--pojazdy
function OpenVehicleSpawnerMenu()
ESX.UI.Menu.CloseAll()

local elements = {}

	ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)

		for i=1, #vehicles, 1 do
			table.insert(elements, {
				label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']',
				value = vehicles[i]
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
		{
			title    = 'Garaż',
			align    = 'right',
			elements = elements 
		}, function(data, menu)

			local vehicleProps = data.current.value
			local VehicleSpawnPoint = GetEntityCoords(PlayerPedId())
			local Heading = GetEntityHeading(PlayerPedId())
			ESX.Game.SpawnVehicle(vehicleProps.model, VehicleSpawnPoint, Heading, function(vehicle)
				ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
				local playerPed = PlayerPedId()
				TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			end)
			ESX.UI.Menu.CloseAll()
			TriggerServerEvent('esx_society:removeVehicleFromGarage', 'organisation_garage', vehicleProps)

		end, function(data, menu)

			menu.close()
		end)
	end, 'organisation_garage')
end

function DeleteJobVehicle()
local playerPed = PlayerPedId()
local veh = GetVehiclePedIsIn(playerPed, false)
	if IsInAuthorizedVehicle() then
		local vehicleProps = ESX.Game.GetVehicleProperties(veh)
		ESX.TriggerServerCallback('tablet:getVehicleInfos', function(retrivedInfo)
			if(retrivedInfo.owner ~= nil)then
				--
			else
				TriggerServerEvent('esx_society:putVehicleInGarage', 'organisation_garage', vehicleProps)
				ESX.Game.DeleteVehicle(veh)
			end
		end, vehicleProps.plate)
	else
		ESX.ShowNotification('Nieautoryzowany pojazd.')
	end
end
 
function IsInAuthorizedVehicle()
	local playerPed = PlayerPedId()
	local vehModel  = GetEntityModel(GetVehiclePedIsIn(playerPed, false))
	local AuthorizedVehicles = {'dubsta', 'dubsta2'}
	for i=1, #AuthorizedVehicles, 1 do
		if vehModel == GetHashKey(AuthorizedVehicles[i]) then
			return true
		end
	end
	
	return false
end