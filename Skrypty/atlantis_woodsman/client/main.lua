local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local AnimalsInSession 			= {}
local woodsmanBlips             = {}
local OnJob                     = false
local IsDead                    = false
local Animal 					= 0
local searchingAnimal 			= false 
local slaughtering 				= false
local locked					= false
local dropedfood				= 0 
local feedbag					= 0
local zone 						= nil 
local zoneswithfood 			= {}
local lastZoneId 				= 0
local keylock 					= false
ESX                             = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

function DrawSub(msg, time)
	ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(msg)
	DrawSubtitleTimed(time, 1)
end

function ShowLoadingPromt(msg, time, type)
	Citizen.CreateThread(function()
		Citizen.Wait(0)
		BeginTextCommandBusyString("STRING")
		AddTextComponentString(msg)
		EndTextCommandBusyString(type)
		Citizen.Wait(time)

		RemoveLoadingPrompt()
	end)
end

function OpenCloakroom()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'woodsman_cloakroom',
	{
		title    = _U('cloakroom_menu'),
		align    = 'right',
		elements = {
			{ label = _U('wear_citizen'), value = 'wear_citizen' },
			{ label = _U('wear_work'),    value = 'wear_work'}
		}
	}, function(data, menu)
		if data.current.value == 'wear_citizen' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		elseif data.current.value == 'wear_work' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
				else
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
				end
			end)
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'cloakroom'
		CurrentActionMsg  = _U('cloakroom_prompt')
		CurrentActionData = {}
	end)
end

function OpenVehicleSpawnerMenu()
	ESX.UI.Menu.CloseAll()

	local elements = {}

	if Config.EnableSocietyOwnedVehicles then

		ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)

			for i=1, #vehicles, 1 do
				table.insert(elements, {
					label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']',
					value = vehicles[i]
				})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
			{
				title    = _U('spawn_veh'),
				align    = 'right',
				elements = elements
			}, function(data, menu)
				if not ESX.Game.IsSpawnPointClear(Config.Zones.VehicleSpawnPoint.Pos, 5.0) then
					ESX.ShowNotification(_U('spawnpoint_blocked'))
					return
				end

				menu.close()

				local vehicleProps = data.current.value
				ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint.Pos, Config.Zones.VehicleSpawnPoint.Heading, function(vehicle)
					ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
					local playerPed = PlayerPedId()
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
				end)

				TriggerServerEvent('esx_society:removeVehicleFromGarage', 'woodsman', vehicleProps)

			end, function(data, menu)
				CurrentAction     = 'vehicle_spawner'
				CurrentActionMsg  = _U('spawner_prompt')
				CurrentActionData = {}

				menu.close()
			end)
		end, 'woodsman')

	else -- not society vehicles

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
		{
			title		= _U('spawn_veh'),
			align    = 'right',
			elements	= Config.AuthorizedVehicles
		}, function(data, menu)
			if not ESX.Game.IsSpawnPointClear(Config.Zones.VehicleSpawnPoint.Pos, 5.0) then
				ESX.ShowNotification(_U('spawnpoint_blocked'))
				return
			end

			menu.close()
			if data.current.model == 'pranger' then
				if ESX.PlayerData.job.grade == 3 or ESX.PlayerData.job.grade == 4 then
					ESX.Game.SpawnVehicle(data.current.model, Config.Zones.VehicleSpawnPoint.Pos, Config.Zones.VehicleSpawnPoint.Heading, function(vehicle)
						local playerPed = PlayerPedId()
						TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
					end)
				else
					ESX.ShowNotification('Ten pojazd jest dostępny tylko dla doświadczonych pracowników.')
				end
			else
				ESX.Game.SpawnVehicle(data.current.model, Config.Zones.VehicleSpawnPoint.Pos, Config.Zones.VehicleSpawnPoint.Heading, function(vehicle)
					local playerPed = PlayerPedId()
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
				end)
			end
		end, function(data, menu)
			CurrentAction     = 'vehicle_spawner'
			CurrentActionMsg  = _U('spawner_prompt')
			CurrentActionData = {}

			menu.close()
		end)
	end
end

function DeleteJobVehicle()
	local playerPed = PlayerPedId()

		if IsInAuthorizedVehicle() then
			local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
			TriggerServerEvent('esx_society:putVehicleInGarage', 'woodsman', vehicleProps)
			ESX.Game.DeleteVehicle(CurrentActionData.vehicle)

			--if Config.MaxInService ~= -1 then
			--	TriggerServerEvent('esx_service:disableService', 'boiler')
			--end
		else
			ESX.ShowNotification(_U('only_woodsman'))
		end
end

function OpenWoodsmanActionsMenu()
	local elements = {
		{label = _U('deposit_stock'), value = 'put_stock'},
		{label = _U('take_stock'), value = 'get_stock'}
	}

	if Config.EnablePlayerManagement and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'woodsman_actions',
	{
		title    = 'BoilerJob',
		align    = 'right',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'woodsman', function(data, menu)
				menu.close()
			end)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'woodsman_actions_menu'
		CurrentActionMsg  = _U('press_to_open')
		CurrentActionData = {}
	end)
end

function OpenMobileWoodsmanActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'woodsman_mobileactions',
	{
		title    = 'Menu leśnika',
		align    = 'right',
		elements = {
			{ label = 'Rozsyp karme dla zwierząt', value = 'food' },
			{ label = 'Poszukaj sladów zwierzyny', value = 'get_zwierze' },
			{ label = 'Oskórój zwierzę',    value = 'loot_zwierze'}
		}
	}, function(data, menu)
		if data.current.value == 'food' then
			if posCheck() then
				menu.close()
				dropfood()
			end
		elseif data.current.value == 'get_zwierze' then
			if PosAndFoodCheck() then
				menu.close()
				searchinglol()
			else 
				ESX.ShowNotification('Najpierw rozsyp karme aby zwabic zwierzynę.')
			end
		elseif data.current.value == 'loot_zwierze' then
			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_KNIFE')  then
				menu.close()
				SlaughterAnimal()
			else
				ESX.ShowNotification('Potrzbujesz noża aby zebrać skóre')
			end
		end
	end, function(data, menu)
		menu.close()
	end)
end

function IsInAuthorizedVehicle()
	local playerPed = PlayerPedId()
	local vehModel  = GetEntityModel(GetVehiclePedIsIn(playerPed, false))

	for i=1, #Config.AuthorizedVehicles, 1 do
		if vehModel == GetHashKey(Config.AuthorizedVehicles[i].model) then
			return true
		end
	end
	
	return false
end

function OpenGetStocksMenu()
	ESX.TriggerServerCallback('esx_woodsman:getStockItems', function(items)
		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
		{
			title    = 'Depozyt',
			align    = 'right',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)

				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					menu2.close()
					menu.close()

					-- todo: refresh on callback
					TriggerServerEvent('esx_woodsman:getStockItem', itemName, count)
					Citizen.Wait(1000)
					OpenGetStocksMenu()
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
	ESX.TriggerServerCallback('esx_woodsman:getPlayerInventory', function(inventory)

		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type = 'item_standard', -- not used
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
		{
			title    = _U('inventory'),
			align    = 'right',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)

				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					menu2.close()
					menu.close()

					-- todo: refresh on callback
					TriggerServerEvent('esx_woodsman:putStockItems', itemName, count)
					Citizen.Wait(1000)
					OpenPutStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end
---------------------------------------------------------------------
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	removeWoodsmanBlips()	
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'woodsman' then
		CreateWoodsmanBlips()
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	removeWoodsmanBlips()	
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'woodsman' then
		CreateWoodsmanBlips()
	end
end)

AddEventHandler('esx_woodsman:hasEnteredMarker', function(zone)
	if zone == 'VehicleSpawner' then
		CurrentAction     = 'vehicle_spawner'
		CurrentActionMsg  = _U('spawner_prompt')
		CurrentActionData = {}
	elseif zone == 'VehicleDeleter' then
		local playerPed = PlayerPedId()
		local vehicle   = GetVehiclePedIsIn(playerPed, false)

		if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
			CurrentAction     = 'delete_vehicle'
			CurrentActionMsg  = _U('store_veh')
			CurrentActionData = { vehicle = vehicle }
		end
	elseif zone == 'WoodsmanActions' then
		CurrentAction     = 'woodsman_actions_menu'
		CurrentActionMsg  = _U('press_to_open')
		CurrentActionData = {}

	elseif zone == 'Cloakroom' then
		CurrentAction     = 'cloakroom'
		CurrentActionMsg  = _U('cloakroom_prompt')
		CurrentActionData = {}
		
	elseif zone == 'BuyVehicle' then
		CurrentAction     = 'buy_vehicle'
		CurrentActionMsg  = _U('press_to_open')
		CurrentActionData = {}
		
		elseif zone == 'Job1' then
		CurrentAction     = 'Job1'
		CurrentActionMsg  = _U('press_to_work')
		CurrentActionData = {}
		
		elseif zone == 'Job2' then
		CurrentAction     = 'Job2'
		CurrentActionMsg  = _U('press_to_work')
		CurrentActionData = {}
		
		elseif zone == 'Job3' then
		CurrentAction     = 'Job3'
		CurrentActionMsg  = _U('press_to_work')
		CurrentActionData = {}

		elseif zone == 'Shop' then
		CurrentAction     = 'Shop'
		CurrentActionMsg  = _U('press_to_open')
		CurrentActionData = {}		
	end
end)

AddEventHandler('esx_woodsman:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

--RegisterNetEvent('esx_phone:loaded')
--AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
--	local specialContact = {
--		name       = _U('phone_taxi'),
--		number     = 'boiler',
--		base64Icon = 'data:image/png;base64,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',
--	}
--
--	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
--end)


-- Enter / Exit marker events, and draw markers
Citizen.CreateThread(function()
	CreateWoodsmanBlips()
	while true do
		Citizen.Wait(0)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'woodsman' then
			local coords = GetEntityCoords(PlayerPedId())
			local isInMarker, currentZone = false

			for k,v in pairs(Config.Zones) do
				local distance = GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true)

				if v.Type ~= -1 and distance < Config.DrawDistance then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, false, 2, v.Rotate, nil, nil, false)
				end

				if distance < v.Size.x then
					isInMarker, currentZone = true, k
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker, LastZone = true, currentZone
				TriggerEvent('esx_woodsman:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_woodsman:hasExitedMarker', LastZone)
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

-- 3x Marker Praca

function WorkJob1()
	TriggerServerEvent('esx_woodsman:job1')
end

function WorkJob2()
	LoadAnimDict('amb@medic@standing@kneel@base')
	LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
	TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
	TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
	TriggerEvent('2d:ProgressBar', "Dokładne mycie zdobytej skóry...", 80)
   	Wait(11000)
	ClearPedTasksImmediately(PlayerPedId())
	TriggerServerEvent('esx_woodsman:job2')
	HasAlreadyEnteredMarker, LastZone = true, currentZone
	TriggerEvent('esx_woodsman:hasEnteredMarker', currentZone)
end

function WorkJob3()
	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
    Citizen.Wait(7000)
    ClearPedTasksImmediately(PlayerPedId())
	TriggerServerEvent('esx_woodsman:job3')
	HasAlreadyEnteredMarker, LastZone = true, currentZone
	TriggerEvent('esx_woodsman:hasEnteredMarker', currentZone)
end

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction and not IsDead then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'woodsman' then
				if CurrentAction == 'woodsman_actions_menu' then
					OpenWoodsmanActionsMenu()
				elseif CurrentAction == 'cloakroom' then
					OpenCloakroom()
				elseif CurrentAction == 'vehicle_spawner' then
					OpenVehicleSpawnerMenu()
				elseif CurrentAction == 'delete_vehicle' then
					DeleteJobVehicle()
				elseif CurrentAction == 'buy_vehicle' then
					OpenShopMenu()
				elseif CurrentAction == 'Job1' then
					WorkJob1()
				elseif CurrentAction == 'Job2' then
					WorkJob2()
				elseif CurrentAction == 'Job3' then
					WorkJob3()
				elseif CurrentAction == 'Shop' then
					TriggerServerEvent('esx_woodsman:shop')
				end

				CurrentAction = nil
			end
		end

		if IsControlJustReleased(0, Keys['F6']) and IsInputDisabled(0) and not IsDead and Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.name == 'woodsman' and not keylock then
			OpenMobileWoodsmanActionsMenu()
		end
	end
end)

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	IsDead = false
end)

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end    
end

function LoadModel(model)
    while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(10)
    end
end

function posCheck()
    local playerPed = PlayerPedId()
	local playerPos = GetEntityCoords(playerPed, true)
	if GetDistanceBetweenCoords(-1570.39, 4432.23, 8.13, playerPos, true) <= 15 then
		if lastZoneId == 1 then
			ESX.ShowNotification('W tym miejscu już pracowałeś')
			return false
		else
			return true
		end
	end
	if GetDistanceBetweenCoords(-1518.18, 4423.27, 12.24, playerPos, true) <= 15 then
		if lastZoneId == 2 then
			ESX.ShowNotification('W tym miejscu już pracowałeś')
			return false
		else
			return true
		end
	end
	if GetDistanceBetweenCoords(-1447.83, 4453.81, 22.03, playerPos, true) <= 15 then
		if lastZoneId == 3 then
			ESX.ShowNotification('W tym miejscu już pracowałeś')
			return false
		else
			return true
		end
	end
	if GetDistanceBetweenCoords(-1374.89, 4427.36, 28.51, playerPos, true) <= 15 then
		if lastZoneId == 4 then
			ESX.ShowNotification('W tym miejscu już pracowałeś')
			return false
		else
			return true
		end
	end
	if GetDistanceBetweenCoords(-1271.8, 4425.2, 12.91, playerPos, true) <= 15 then
		if lastZoneId == 5 then
			ESX.ShowNotification('W tym miejscu już pracowałeś')
			return false
		else
			return true
		end
	end
	return false
end


function PosAndFoodCheck()
    local playerPed = PlayerPedId()
	local playerPos = GetEntityCoords(playerPed, true)
	if GetDistanceBetweenCoords(-1570.39, 4432.23, 8.13, playerPos, true) <= 15 then
		if table.contains(zoneswithfood,1) then
			return true
		end
	end
	if GetDistanceBetweenCoords(-1518.18, 4423.27, 12.24, playerPos, true) <= 15 then
		if table.contains(zoneswithfood,2) then
			return true
		end
	end
	if GetDistanceBetweenCoords(-1447.83, 4453.81, 22.03, playerPos, true) <= 15 then
		if table.contains(zoneswithfood,3) then
			return true
		end
	end
	if GetDistanceBetweenCoords(-1374.89, 4427.36, 28.51, playerPos, true) <= 15 then
		if table.contains(zoneswithfood,4) then
			return true
		end
	end
	if GetDistanceBetweenCoords(-1271.8, 4425.2, 12.91, playerPos, true) <= 15 then
		if table.contains(zoneswithfood,5) then
			return true
		end
	end
	return false
end

function addFood()
    local playerPed = PlayerPedId()
	local playerPos = GetEntityCoords(playerPed, true)
	if GetDistanceBetweenCoords(-1570.39, 4432.23, 8.13, playerPos, true) <= 15 then
		table.insert(zoneswithfood, 1)
	end
	if GetDistanceBetweenCoords(-1518.18, 4423.27, 12.24, playerPos, true) <= 15 then
		table.insert(zoneswithfood, 2)
	end
	if GetDistanceBetweenCoords(-1447.83, 4453.81, 22.03, playerPos, true) <= 15 then
		table.insert(zoneswithfood, 3)
	end
	if GetDistanceBetweenCoords(-1374.89, 4427.36, 28.51, playerPos, true) <= 15 then
		table.insert(zoneswithfood, 4)
	end
	if GetDistanceBetweenCoords(-1271.8, 4425.2, 12.91, playerPos, true) <= 15 then
		table.insert(zoneswithfood, 5)
	end
end

function removeFood()
    local playerPed = PlayerPedId()
	local playerPos = GetEntityCoords(playerPed, true)
	if GetDistanceBetweenCoords(-1570.39, 4432.23, 8.13, playerPos, true) <= 15 then
		if table.contains(zoneswithfood,1) then
			table.remove(zoneswithfood, 1)
		end	
	end
	if GetDistanceBetweenCoords(-1518.18, 4423.27, 12.24, playerPos, true) <= 15 then
		if table.contains(zoneswithfood,2) then
			table.remove(zoneswithfood, 2)
		end	
	end
	if GetDistanceBetweenCoords(-1447.83, 4453.81, 22.03, playerPos, true) <= 15 then
		if table.contains(zoneswithfood,3) then
			table.remove(zoneswithfood, 3)
		end	
	end
	if GetDistanceBetweenCoords(-1374.89, 4427.36, 28.51, playerPos, true) <= 15 then
		if table.contains(zoneswithfood,4) then
			table.remove(zoneswithfood, 4)
		end	
	end
	if GetDistanceBetweenCoords(-1271.8, 4425.2, 12.91, playerPos, true) <= 15 then
		if table.contains(zoneswithfood,5) then
			table.remove(zoneswithfood, 5)
		end	
	end
end

function lastZone()
    local playerPed = PlayerPedId()
	local playerPos = GetEntityCoords(playerPed, true)
	if GetDistanceBetweenCoords(-1570.39, 4432.23, 8.13, playerPos, true) <= 15 then
		lastZoneId = 1
	end
	if GetDistanceBetweenCoords(-1518.18, 4423.27, 12.24, playerPos, true) <= 15 then
		lastZoneId = 2	
	end
	if GetDistanceBetweenCoords(-1447.83, 4453.81, 22.03, playerPos, true) <= 15 then
		lastZoneId = 3
	end
	if GetDistanceBetweenCoords(-1374.89, 4427.36, 28.51, playerPos, true) <= 15 then
		lastZoneId = 4
	end
	if GetDistanceBetweenCoords(-1271.8, 4425.2, 12.91, playerPos, true) <= 15 then
		lastZoneId = 5
	end
end

function dropfood()
	fooddrop()
	TriggerEvent('2d:ProgressBar', "Rozsypywanie karmy...", 40)
   	keylock = true
   	Wait(6000)
   	dropedfood = dropedfood + 1
   	addFood()
   	deleteobject()
   	ClearPedTasksImmediately(PlayerPedId())
   	keylock = false
end

function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

function searchinglol()
	if not locked then
		
		LoadAnimDict('amb@medic@standing@kneel@base')
		LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
		TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
		TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
		TriggerEvent('2d:ProgressBar', "Sprawdzanie sladów...", 40)
		keylock = true
	   	Wait(6000)
		ClearPedTasksImmediately(PlayerPedId())
		keylock = false
		lastZone()
		local chance = math.random(0,15)
		if chance <= 5 then
			spawnAnimal()
			ESX.ShowNotification('Mamy coś!')
			removeFood()
		else
			locked = true
			ESX.ShowNotification('Nic tu nie ma :(')
			lockcooldown()
		end
	end
end

RegisterCommand("spradzzwierzyne", function(source, args, raw)
    local aiming, targetPed = GetEntityPlayerIsFreeAimingAt(PlayerId(-1))

    if aiming then
        local playerPed = GetPlayerPed(-1)
        local pCoords = GetEntityCoords(playerPed, true)
        local tCoords = GetEntityCoords(targetPed, true)

        if DoesEntityExist(targetPed) and IsEntityAPed(targetPed) then
        	local targettype = GetPedType(targetPed)
        	if targettype == 28 then
        		local playerPed = PlayerPedId()
				local playerPos = GetEntityCoords(playerPed, true)
		    	deadanimal = GetEntityCoords(targetPed)
		    	distance = GetDistanceBetweenCoords(deadanimal.x, deadanimal.y, deadanimal.z, playerPos, true)
	    		if distance < 2 then 
	    			slaughtering = true
	    			keylock = true
					LoadAnimDict('amb@medic@standing@kneel@base')
					LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
					TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
					TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
					Citizen.Wait(5000)
					keylock = false
					ClearPedTasksImmediately(PlayerPedId())
					ResurrectPed(targetPed)
					ClearPedTasksImmediately(targetPed)
					Wait(500)
					SetPedToRagdoll(targetPed, 1000, 1000, 2, 0, 0, 0)
					Wait(1000)
					ClearPedTasks(targetPed)
					SetPedAsNoLongerNeeded(targetPed)
					searchingAnimal = false 
					slaughtering = false
	    		end
        	end
        end
    end

end, false)

function SlaughterAnimal()
	if not slaughtering then
		local playerPed = PlayerPedId()
		local playerPos = GetEntityCoords(playerPed, true)
    	deer = GetEntityCoords(Animal)
    	distance = GetDistanceBetweenCoords(deer.x, deer.y, deer.z, playerPos, true)
    	if distance < 2 then
			slaughtering = true
			LoadAnimDict('amb@medic@standing@kneel@base')
			LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
			TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
			TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
			keylock = true
			Citizen.Wait(5000)
			ClearPedTasksImmediately(PlayerPedId())
			keylock = false
			WorkJob1()
			DeleteEntity(Animal)
			searchingAnimal = false 
			slaughtering = false
		end
	end
end

function spawnAnimal()
	if not searchingAnimal then
		searchingAnimal = true
		animalname = 'a_c_deer'
		LoadModel(animalname)
		local value = GetEntityCoords(PlayerPedId())
		Animal = CreatePed(5, GetHashKey(animalname), value.x+50, value.y+50, value.z, 0.0, true, false)
		TaskWanderStandard(Animal, true, true)
		SetEntityAsMissionEntity(Animal, true, true)
		--Blips
		local AnimalBlip = AddBlipForEntity(Animal)
		SetBlipSprite(AnimalBlip, 153)
		SetBlipColour(AnimalBlip, 1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Slady zwierzę')
		EndTextCommandSetBlipName(AnimalBlip)
		table.insert(AnimalsInSession, {id = Animal, x = value.x+20, y = value.y+20, z = value.z, Blipid = AnimalBlip})
	end
end

function CreateWoodsmanBlips()
	Wait(5000)
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'woodsman' then
	  local blippos = {x = 387.07, y = 792.18, z = 187.69}
	  local blippos2 = {x = -1606.71, y = 2094.11, z = 65.84}
	  local blippos3 = {x = 2938.21, y = 5326.24, z = 100.60}
	  local woodsmanblip = AddBlipForCoord(blippos.x, blippos.y, blippos.z)
	  local woodsmanblip2 = AddBlipForCoord(blippos2.x, blippos2.y, blippos2.z)
	  local woodsmanblip3 = AddBlipForCoord(blippos3.x, blippos3.y, blippos3.z)

	  SetBlipSprite (woodsmanblip, 141)
	  SetBlipDisplay(woodsmanblip, 4)
	  SetBlipScale  (woodsmanblip, 1.5)
	  SetBlipColour (woodsmanblip, 5)
	  SetBlipAsShortRange(woodsmanblip, true)

	  SetBlipSprite (woodsmandblip2, 463)
	  SetBlipDisplay(woodsmandblip2, 4)
	  SetBlipScale  (woodsmandblip2, 1.0)
	  SetBlipColour (woodsmandblip2, 5)
	  SetBlipAsShortRange(woodsmandblip2, true)

	  SetBlipSprite (woodsmandblip3, 463)
	  SetBlipDisplay(woodsmandblip3, 4)
	  SetBlipScale  (woodsmandblip3, 1.0)
	  SetBlipColour (woodsmandblip3, 5)
	  SetBlipAsShortRange(woodsmandblip3, true)

	  BeginTextCommandSetBlipName("STRING")
	  AddTextComponentSubstringPlayerName('Siedziba Forest Ranger')
	  EndTextCommandSetBlipName(woodsmanblip)
	  table.insert(woodsmanBlips, woodsmanblip)

	  BeginTextCommandSetBlipName("STRING")
	  AddTextComponentSubstringPlayerName('Mycie skór')
	  EndTextCommandSetBlipName(woodsmanblip2)
	  table.insert(woodsmanBlips, woodsmanblip2)

	  BeginTextCommandSetBlipName("STRING")
	  AddTextComponentSubstringPlayerName('Suszenie skór')
	  EndTextCommandSetBlipName(woodsmanblip3)
	  table.insert(woodsmanBlips, woodsmanblip3)
	  local blippos3 = {x = -1430.5, y = 4438.99, z = 33.65}
	  local idcolor = 2
	  
	  zone = AddBlipForRadius(blippos3.x, blippos3.y, blippos3.z, 170.0)
	  SetBlipColour(zone,idcolor)
	  SetBlipAlpha(zone,120)
	  SetBlipSprite(zone,10)
	end
end

function removeWoodsmanBlips()
    if woodsmanBlips[1] ~= nil then
        for i=1, #woodsmanBlips, 1 do
            RemoveBlip(woodsmanBlips[i])
            woodsmanBlips[i] = nil
        end
    end
    if zone ~= nil then
    	RemoveBlip(zone)
    	zone = nil
    end
end

function lockcooldown()
  TIMER = 30
  repeat
  TIMER = TIMER - 1
  Citizen.Wait(1000)
  until(TIMER == 0)
  locked = false
end

function fooddrop()
	local ad = "weapon@w_sp_jerrycan"
	local anim = "fire"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		LoadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 8 ) ) then 
			TaskPlayAnim( player, ad, "exit", 8.0, 8.0, 1.0, 01, 1, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			SetCurrentPedWeapon( player, GetHashKey("WEAPON_UNARMED"), equipNow)
			feedbag = CreateObject(GetHashKey("prop_feed_sack_01"), 0, 0, 0, true, true, true) -- creates object
			AttachEntityToEntity(feedbag, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 28422), 0.5, -0.1, 0.0, 0.0, -80.0, -0.50, 1, 0, 0, 0, 0, 1)
			Citizen.Wait(50) 
			TaskPlayAnim( player, ad, anim, 8.0, 8.0, 1.0, 01, 1, 0, 0, 0 )
		end       
	end
end

function deleteobject()
		DeleteEntity(feedbag)
		ClearPedSecondaryTask(PlayerPedId())
		feedbag = 0
end


local known = {CEventNetworkEntityDamage = {[1] = 'target entity',[2] = 'source entity',[4] = 'fatal damage', [5] = 'weapon used'},}
AddEventHandler('gameEventTriggered', function (name, args)
	local myPed = PlayerPedId()
	local allowedpedtype = 28
	local damagedpedtype = GetPedType(args[1])
	if known[name] and args[2] == myPed and args[4] == 1 and args[5] ~= '-1466123874' then
		if damagedpedtype == allowedpedtype then
			local animalpos = GetEntityCoords(args[1], true)
				TriggerServerEvent('esx_woodsman:alert', animalpos.x, animalpos.y, animalpos.z)
		end
	end
end)

local blipTime = 300
RegisterNetEvent('ALARM')
AddEventHandler('ALARM', function(x, y, z)
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'woodsman' then
		ESX.ShowAdvancedNotification('CENTRALA', '911', 'Otrzymaliśmy zgłoszenie o przemocy wobec zwierząt.', 'CHAR_MINOTAUR', 8)
		local trans = 250
		local AlertBlip = AddBlipForCoord(x, y, z)
		SetBlipSprite(AlertBlip, 398)
		SetBlipColour(AlertBlip,  9)
		SetBlipAlpha(AlertBlip,  trans)
		SetBlipAsShortRange(AlertBlip,  1)
		SetBlipScale(AlertBlip, 1.0)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Zgłoszenie o ataku na zwierzę!")
		EndTextCommandSetBlipName(AlertBlip)
		Citizen.Wait(5000)
		while trans ~= 0 do
			Wait(blipTime * 4)
			trans = trans - 1
			SetBlipAlpha(AlertBlip,  transR)
			if transR == 0 then
				SetBlipSprite(AlertBlip,  2)
				return
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if keylock then
	    DisableControlAction(0, 44, true) -- Cover
	    DisableControlAction(0, 37, true) -- Select Weapon
	    DisableControlAction(0, 311, true) -- K
	    DisableControlAction(0, 59, true) -- Disable steering in vehicle
	    DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
	    DisableControlAction(0, 72, true) -- Disable reversing in vehicle
	    DisableControlAction(0, 69, true) -- INPUT_VEH_ATTACK
	    DisableControlAction(0, 92, true) -- INPUT_VEH_PASSENGER_ATTACK
	    DisableControlAction(0, 114, true) -- INPUT_VEH_FLY_ATTACK
	    DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
	    DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
	    DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
	    DisableControlAction(0, 257, true) -- INPUT_ATTACK2
	    DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
	    DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
	    DisableControlAction(0, 24, true) -- INPUT_ATTACK
	    DisableControlAction(0, 25, true) -- INPUT_AIM
	    DisableControlAction(0, 21, true) -- SHIFT
	    DisableControlAction(0, 22, true) -- SPACE
	    DisableControlAction(0, 288, true) -- F1
	    DisableControlAction(0, 289, true) -- F2
	    DisableControlAction(0, 170, true) -- F3
	    DisableControlAction(0, 57, true) -- F10
	    DisableControlAction(0, 73, true) -- X
	    DisableControlAction(0, 244, true) -- M
	    DisableControlAction(0, 246, true) -- Y
	    DisableControlAction(0, 74, true) -- H
	    DisableControlAction(0, 29, true) -- B
	    DisableControlAction(0, 243, true) -- ~
	    DisableControlAction(0, 244, true) -- M
	    DisableControlAction(0, 81, true) -- ,
	    DisableControlAction(0, 82, true) -- .
	   end
	end
end)