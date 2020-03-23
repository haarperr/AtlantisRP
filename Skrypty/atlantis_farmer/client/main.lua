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

local farmerBlip                = false
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local OnJob                     = false
local CurrentCustomer           = nil
local CurrentCustomerBlip       = nil
local DestinationBlip           = nil
local IsNearCustomer            = false
local CustomerIsEnteringVehicle = false
local CustomerEnteredVehicle    = false
local TargetCoords              = nil
local IsDead                    = false
local zbieranie					= false
local box 						= nil
local feedbag 					= nil
local isHoldingplatki			= false
local JobBlips					= {}
local showPro					= false
local onDuty					= false
local isInRV 					= false
local rvHash 					= GetHashKey("tractor2")
local vehicle 					= nil


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

--function GetRandomWalkingNPC()
--	local search = {}
--	local peds   = ESX.Game.GetPeds()
--
--	for i=1, #peds, 1 do
--		if IsPedHuman(peds[i]) and IsPedWalking(peds[i]) and not IsPedAPlayer(peds[i]) then
--			table.insert(search, peds[i])
--		end
--	end
--
--	if #search > 0 then
--		return search[GetRandomIntInRange(1, #search)]
--	end
--
--	for i=1, 250, 1 do
--		local ped = GetRandomPedAtCoord(0.0, 0.0, 0.0, math.huge + 0.0, math.huge + 0.0, math.huge + 0.0, 26)
--
--		if DoesEntityExist(ped) and IsPedHuman(ped) and IsPedWalking(ped) and not IsPedAPlayer(ped) then
--			table.insert(search, ped)
--		end
--	end
--
--	if #search > 0 then
--		return search[GetRandomIntInRange(1, #search)]
--	end
--end

--function ClearCurrentMission()
--	if DoesBlipExist(CurrentCustomerBlip) then
--		RemoveBlip(CurrentCustomerBlip)
--	end
--
--	if DoesBlipExist(DestinationBlip) then
--		RemoveBlip(DestinationBlip)
--	end
--
--	CurrentCustomer           = nil
--	CurrentCustomerBlip       = nil
--	DestinationBlip           = nil
--	IsNearCustomer            = false
--	CustomerIsEnteringVehicle = false
--	CustomerEnteredVehicle    = false
--	TargetCoords              = nil
--end

--function StartTaxiJob()
--	ShowLoadingPromt(_U('taking_service'), 5000, 3)
--	ClearCurrentMission()
--
--	OnJob = true
--end
--
--function StopTaxiJob()
--	local playerPed = PlayerPedId()
--
--	if IsPedInAnyVehicle(playerPed, false) and CurrentCustomer ~= nil then
--		local vehicle = GetVehiclePedIsIn(playerPed,  false)
--		TaskLeaveVehicle(CurrentCustomer,  vehicle,  0)
--
--		if CustomerEnteredVehicle then
--			TaskGoStraightToCoord(CurrentCustomer,  TargetCoords.x,  TargetCoords.y,  TargetCoords.z,  1.0,  -1,  0.0,  0.0)
--		end
--	end
--
--	ClearCurrentMission()
--	OnJob = false
--	DrawSub(_U('mission_complete'), 5000)
--end

function OpenCloakroom()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'farmer_cloakroom',
	{
		title    = _U('cloakroom_menu'),
		align    = 'right',
		elements = {
			{ label = _U('wear_citizen'), value = 'wear_citizen' },
			{ label = _U('wear_work'),    value = 'wear_work'}
		}
	}, function(data, menu)
		if data.current.value == 'wear_citizen' then
		offduty()
		farmerblip()
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		elseif data.current.value == 'wear_work' then
		onduty()
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

function OpenPrzerobka()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'farmer_przerob',
	{
		title    = _U('przerobka_menu'),
		align    = 'right',
		elements = {
			{ label = _U('przerob_wheat'), value = 'przerob_wheat' },
		}
	}, function(data, menu)
		if data.current.value == 'przerob_wheat' then
		
		TriggerServerEvent('farmer:job3a_pre')
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'farmer_przerob'
		CurrentActionMsg  = _U('przrob_prompt')
		CurrentActionData = {}
	end)
end

function OpenSell()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'farmer_sell',
	{
		title    = _U('sell_menu'),
		align    = 'right',
		elements = {
			{ label = _U('sell_wheat'), value = 'sell_wheat' },
			--{ label = _U('sell_milk'), value = 'sell_milk' },
		}
	}, function(data, menu)
		if data.current.value == 'sell_wheat' and IsInAuthorizedVehicle() then
		ESX.UI.Menu.CloseAll()
		FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), true)
		procent(100)
		FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), false)
		TriggerServerEvent('farmer:job3')
		ESX.UI.Menu.CloseAll()
		TriggerEvent('show:money', 1.5)
		else
		exports.pNotify:SendNotification({text = "Gdzie auto z farmy?", type = "atlantis", queue = "global", timeout = 10000, layout = "atlantis"})
		--elseif data.current.value == 'sell_milk' then
		--TriggerServerEvent('farmer:job3a')
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'farmer_sell'
		CurrentActionMsg  = _U('sell_prompt')
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
				local trHash = GetHashKey("tractor2")
				local vehicleProps = data.current.value
				ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint.Pos, Config.Zones.VehicleSpawnPoint.Heading, function(vehicle)
					if vehicleProps == trHash then
						ESX.Game.SpawnVehicle('raketrailer', Config.Zones.TrailerSpawnPoint.Pos, Config.Zones.TrailerSpawnPoint.Heading, function(vehicle)
						end)
					end
					ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
					local playerPed = PlayerPedId()
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
					Wait(200)
					orchard_givekeys()
				end)

				TriggerServerEvent('esx_society:removeVehicleFromGarage', 'farmer', vehicleProps)

			end, function(data, menu)
				CurrentAction     = 'vehicle_spawner'
				CurrentActionMsg  = _U('spawner_prompt')
				CurrentActionData = {}

				menu.close()
			end)
		end, 'farmer')

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
			ESX.Game.SpawnVehicle(data.current.model, Config.Zones.VehicleSpawnPoint.Pos, Config.Zones.VehicleSpawnPoint.Heading, function(vehicle)
				local playerPed = PlayerPedId()
				TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			end)
			
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
			TriggerServerEvent('esx_society:putVehicleInGarage', 'farmer', vehicleProps)
			ESX.Game.DeleteVehicle(CurrentActionData.vehicle)

			--if Config.MaxInService ~= -1 then
			--	TriggerServerEvent('esx_service:disableService', 'boiler')
			--end
		else
			ESX.ShowNotification(_U('only_farmer'))
		end
end

function OpenFarmerActionsMenu()
	local elements = {
		{label = _U('deposit_stock'), value = 'put_stock'},
		{label = _U('take_stock'), value = 'get_stock'}
	}

	if Config.EnablePlayerManagement and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'farmer_actions',
	{
		title    = 'FarmerJob',
		align    = 'right',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'farmer', function(data, menu)
				menu.close()
			end)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'farmer_actions_menu'
		CurrentActionMsg  = _U('press_to_open')
		CurrentActionData = {}
	end)
end

--function OpenMobileBoilerActionsMenu()
--	ESX.UI.Menu.CloseAll()
--
--	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_boiler_actions',
--	{
--		title    = 'Taxi',
--		align    = 'right',
--		elements = {
--			{ label = _U('billing'),   value = 'billing' },
--			{ label = _U('start_job'), value = 'start_job' }
--		}
--	}, function(data, menu)
--		if data.current.value == 'billing' then
--
--			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
--				title = _U('invoice_amount')
--			}, function(data, menu)
--
--				local amount = tonumber(data.value)
--				if amount == nil then
--					ESX.ShowNotification(_U('amount_invalid'))
--				else
--					menu.close()
--					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
--					if closestPlayer == -1 or closestDistance > 3.0 then
--						ESX.ShowNotification(_U('no_players_near'))
--					else
--						TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_taxi', 'Taxi', amount)
--						ESX.ShowNotification(_U('billing_sent'))
--					end
--
--				end
--
--			end, function(data, menu)
--				menu.close()
--			end)
--
--		elseif data.current.value == 'start_job' then
--			if OnJob then
--				StopTaxiJob()
--			else
--				if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'boiler' then
--					local playerPed = PlayerPedId()
--					local vehicle   = GetVehiclePedIsIn(playerPed, false)
--
--					if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
--						if tonumber(ESX.PlayerData.job.grade) >= 3 then
--							StartTaxiJob()
--						else
--							if IsInAuthorizedVehicle() then
--								StartTaxiJob()
--							else
--								ESX.ShowNotification(_U('must_in_taxi'))
--							end
--						end
--					else
--						if tonumber(ESX.PlayerData.job.grade) >= 3 then
--							ESX.ShowNotification(_U('must_in_vehicle'))
--						else
--							ESX.ShowNotification(_U('must_in_taxi'))
--						end
--					end
--				end
--			end
--		end
--	end, function(data, menu)
--		menu.close()
--	end)
--end

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
	ESX.TriggerServerCallback('esx_farmer:getStockItems', function(items)
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
					TriggerServerEvent('esx_farmer:getStockItem', itemName, count)
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
	ESX.TriggerServerCallback('esx_farmer:getPlayerInventory', function(inventory)

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
					TriggerServerEvent('esx_farmer:putStockItems', itemName, count)
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
----------------------------------------------------------------- WIPWIPWIP
function OpenShopMenu(elements, restoreCoords, shopCoords)
	local playerPed = PlayerPedId()
	isInShopMenu = true

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop', {
		title    = _U('vehicleshop_title'),
		align    = 'right',
		elements = elements
	}, function(data, menu)

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop_confirm',
		{
			title    = _U('vehicleshop_confirm', data.current.name, data.current.price),
			align    = 'right',
			elements = {
				{ label = _U('confirm_no'), value = 'no' },
				{ label = _U('confirm_yes'), value = 'yes' }
			}
		}, function(data2, menu2)

			if data2.current.value == 'yes' then
				local newPlate = exports['esx_vehicleshop']:GeneratePlate()
				local vehicle  = GetVehiclePedIsIn(playerPed, false)
				local props    = ESX.Game.GetVehicleProperties(vehicle)
				props.plate    = newPlate

				ESX.TriggerServerCallback('esx_ambulancejob:buyJobVehicle', function (bought)
					if bought then
						ESX.ShowNotification(_U('vehicleshop_bought', data.current.name, ESX.Math.GroupDigits(data.current.price)))

						isInShopMenu = false
						ESX.UI.Menu.CloseAll()
				
						DeleteSpawnedVehicles()
						FreezeEntityPosition(playerPed, false)
						SetEntityVisible(playerPed, true)
				
						ESX.Game.Teleport(playerPed, restoreCoords)
					else
						ESX.ShowNotification(_U('vehicleshop_money'))
						menu2.close()
					end
				end, props, data.current.type)
			else
				menu2.close()
			end

		end, function(data2, menu2)
			menu2.close()
		end)

		end, function(data, menu)
		isInShopMenu = false
		ESX.UI.Menu.CloseAll()

		DeleteSpawnedVehicles()
		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)

		ESX.Game.Teleport(playerPed, restoreCoords)
	end, function(data, menu)
		DeleteSpawnedVehicles()

		WaitForVehicleToLoad(data.current.model)
		ESX.Game.SpawnLocalVehicle(data.current.model, shopCoords, 0.0, function(vehicle)
			table.insert(spawnedVehicles, vehicle)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
		end)
	end)

	WaitForVehicleToLoad(elements[1].model)
	ESX.Game.SpawnLocalVehicle(elements[1].model, shopCoords, 0.0, function(vehicle)
		table.insert(spawnedVehicles, vehicle)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
	end)
end
---------------------------------------------------------------------
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

AddEventHandler('esx_farmer:hasEnteredMarker', function(zone)
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
	elseif zone == 'FarmerActions' then
		CurrentAction     = 'farmer_actions_menu'
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
		
		elseif zone == 'Job1ziemniaki' then
		CurrentAction     = 'Job1ziemniaki'
		CurrentActionMsg  = _U('press_to_work')
		CurrentActionData = {}
		
		elseif zone == 'Job1Pasza' then
		CurrentAction     = 'Job1Pasza'
		CurrentActionMsg  = _U('press_to_work')
		CurrentActionData = {}
		
		elseif zone == 'Job2' then
		CurrentAction     = 'Job2'
		CurrentActionMsg  = _U('press_to_work')
		CurrentActionData = {}
		
		elseif zone == 'Job3' then
		CurrentAction     = 'Job3'
		CurrentActionMsg  = _U('sell_prompt')
		CurrentActionData = {}

		elseif zone == 'Job3a' then
		CurrentAction     = 'Job3a'
		CurrentActionMsg  = _U('przerob_prompt')
		CurrentActionData = {}
	end
end)

AddEventHandler('esx_farmer:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	zbieranie = false
	CurrentAction = nil
end)

-- Enter / Exit marker events, and draw markers
Citizen.CreateThread(function()
farmerblip()
	while true do
		Citizen.Wait(0)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'farmer' then
			local coords = GetEntityCoords(PlayerPedId())
			local isInMarker, currentZone = false

			for k,v in pairs(Config.Zones) do
				local distance = GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true)

				if v.Type ~= -1 and distance < Config.DrawDistance then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, false, 2, v.Rotate, nil, nil, false)
					DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z+0.5, 'Nacisnij ~b~[E]')
				end

				if distance < v.Size.x then
					isInMarker, currentZone = true, k
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker, LastZone = true, currentZone
				TriggerEvent('esx_farmer:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_farmer:hasExitedMarker', LastZone)
			end
			
					if CurrentAction and not IsDead then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'farmer' then
				if CurrentAction == 'farmer_actions_menu' then
					OpenFarmerActionsMenu()
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
				elseif CurrentAction == 'Job1ziemniaki' then
					WorkJob1ziemniaki()
				elseif CurrentAction == 'Job1Pasza' then
					WorkJob1Pasza()
				elseif CurrentAction == 'Job2' then
					WorkJob2()
				elseif CurrentAction == 'Job3' then
					OpenSell()
				elseif CurrentAction == 'Job3a' then
					OpenPrzerobka()
				end

				CurrentAction = nil
			end
		end
			
		else
			Citizen.Wait(1000)
		end
	end
end)

-- 3x Marker Praca

RegisterNetEvent('farmer:zbieranie')
AddEventHandler('farmer:zbieranie', function()
	zbieranie = true
	
	while (zbieranie) do
		vehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
		if IsVehicleModel(vehicle, rvHash) then
			if GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) > 2 and GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) < 10 then
				Citizen.Wait(3000)
				TriggerServerEvent('farmer:job1')
			else
				Citizen.Wait(2000)
				ESX.ShowNotification("Stoisz lub jedziesz za szybko!")
			end
		else
			ESX.ShowNotification("Tym pojazdem wiele nie zdziałamy...")
			zbieranie = false
		end
	end
end)


RegisterNetEvent('farmer:limit')
AddEventHandler('farmer:limit', function()
	zbieranie = false
	exports.pNotify:SendNotification({text = "Osiągnięto limit.", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
end)

function WorkJob1()
	TriggerEvent('farmer:zbieranie')
end

--function WorkJob1ziemniaki()
--
--end
--
--function WorkJob1Pasza()
--
--end

--function WorkJob2()
--	ESX.ShowNotification("DEBUG: PRACA 2")
--	TriggerServerEvent('farmer:job2')
--end
--
--function WorkJob3()
--	ESX.ShowNotification("DEBUG: PRACA 3")
--	TriggerServerEvent('farmer:job3')
--end

RegisterNetEvent('farmer:przerobkawheat')
AddEventHandler('farmer:przerobkawheat', function()
	ESX.UI.Menu.CloseAll()
	local playerPed = GetPlayerPed(-1)
	TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WINDOW_SHOP_BROWSE", 0, 1)
	procent(150)
	ClearPedTasksImmediately(playerPed)
	TriggerServerEvent('farmer:job3a')
end)

RegisterNetEvent('dajplatki')
AddEventHandler('dajplatki', function()
		animacjanoszeniaplatek()
		isHoldingplatki = true
end)

RegisterNetEvent('farmer:maszchleb')
AddEventHandler('farmer:maszchleb', function()
		exports.pNotify:SendNotification({text = "Towar z ostatnich zbiorów nie został sprzedany.", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
end)

RegisterNetEvent('farmer:empty')
AddEventHandler('farmer:empty', function()
		exports.pNotify:SendNotification({text = "Chyba nie masz tego czego potrzebuję...", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
end)

RegisterNetEvent('farmer:pieniazki')
AddEventHandler('farmer:pieniazki', function()

end)

-- Key Controls
--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction and not IsDead then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'farmer' then
				if CurrentAction == 'farmer_actions_menu' then
					OpenFarmerActionsMenu()
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
				elseif CurrentAction == 'Job1ziemniaki' then
					WorkJob1ziemniaki()
				elseif CurrentAction == 'Job1Pasza' then
					WorkJob1Pasza()
				elseif CurrentAction == 'Job2' then
					WorkJob2()
				elseif CurrentAction == 'Job3' then
					OpenSell()
				elseif CurrentAction == 'Job3a' then
					OpenPrzerobka()
				end

				CurrentAction = nil
			end
		end

		if IsControlJustReleased(0, Keys['F6']) and IsInputDisabled(0) and not IsDead and Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.name == 'farmer' then
			OpenMobileFarmerActionsMenu()
		end
	end
end)]]

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
	isHoldingplatki = false
end)

AddEventHandler('playerSpawned', function(spawn)
	IsDead = false
end)

function feedinganimation()
	local ad = "weapon@w_sp_jerrycan"
	local anim = "fire"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
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

function animacjanoszeniaplatek()
	local ad = "anim@heists@box_carry@"
	local anim = "idle"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 8 ) ) then 
			TaskPlayAnim( player, ad, "exit", 8.0, 8.0, 1.0, 50, 1, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			--SetCurrentPedWeapon( player, GetHashKey("WEAPON_UNARMED"), equipNow)
			--boxplatkow = CreateObject(GetHashKey("prop_cs_cardbox_01"), 0, 0, 0, true, true, true) -- creates object
			--AttachEntityToEntity(boxplatkow, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 28422), 0, 0, 0, 0, 0, 0, true, true, false, true, 1, true)
			--Citizen.Wait(50) 
			--TaskPlayAnim( player, ad, anim, 8.0, 8.0, 1.0, 50, 1, 0, 0, 0 )
		end       
	end
end

function deleteobject()
		DeleteEntity(boxplatkow)
		DeleteEntity(feedbag)
		ClearPedSecondaryTask(PlayerPedId())
		feedbag = nil
		boxplatkow = nil

end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

function schowajplatki()
		DeleteEntity(boxplatkow)
		ClearPedSecondaryTask(PlayerPedId())
		boxplatkow = nil
		isHoldingplatki = false
end

RegisterNetEvent('farmer:procenty')
AddEventHandler('framer:procenty', function()
  showPro = true
    while showPro do
      Citizen.Wait(10)
      local playerPed = PlayerPedId()
      local coords = GetEntityCoords(playerPed)
      DrawText3D(coords.x, coords.y, coords.z+0.1,'Praca...' , 0.4)
      DrawText3D(coords.x, coords.y, coords.z, TimeLeft .. '~g~%', 0.4)
    end
end)

-- Podjebane od bloodiego
function procent(time)
  showPro = true
  TimeLeft = 0
  repeat
  TimeLeft = TimeLeft + 1    
  Citizen.Wait(time)
  until(TimeLeft == 100)
  showPro = false
end


function DrawText3D(x, y, z, text, scale)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

  SetTextScale(scale, scale)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextEntry("STRING")
  SetTextCentre(1)
  SetTextColour(255, 255, 255, 255)
  SetTextOutline()

  AddTextComponentString(text)
  DrawText(_x, _y)

  local factor = (string.len(text)) / 270
  DrawRect(_x, _y + 0.015, 0.005 + factor, 0.03, 31, 31, 31, 155)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(6)
		if showPro == true then
			local playerPed = PlayerPedId()
			local coords = GetEntityCoords(playerPed)
		DrawText3D(coords.x, coords.y, coords.z, TimeLeft .. '~g~%', 0.5)
		DisableControlAction(0, 73, true) -- X
		end
	end
end)


function farmerblip()
  local blipFarmer = AddBlipForCoord(Config.Zones.Cloakroom.Pos.x, Config.Zones.Cloakroom.Pos.y, Config.Zones.Cloakroom.Pos.z)

  SetBlipSprite (blipFarmer, Config.Blips.Zbieranie.Sprite)
  SetBlipDisplay(blipFarmer, 4)
  SetBlipScale  (blipFarmer, 0.8)
  SetBlipColour (blipFarmer, 5)
  SetBlipAsShortRange(blipFarmer, true)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName(_U('blip_farmer'))
  EndTextCommandSetBlipName(blipFarmer)
  table.insert(JobBlips, blipFarmer)
end

-- wejscie na sluzbe i dodanie blipow
function onduty()
  onDuty = true
  local blipFarmer2 = AddBlipForCoord(Config.Zones.Job1.Pos.x, Config.Zones.Job1.Pos.y, Config.Zones.Job1.Pos.z)
  --local blipFarmer3 = AddBlipForCoord(Config.Zones.Job1ziemniaki.Pos.x, Config.Zones.Job1ziemniaki.Pos.y, Config.Zones.Job1ziemniaki.Pos.z)
  --local blipFarmer4 = AddBlipForCoord(Config.Zones.Job1Pasza.Pos.x, Config.Zones.Job1Pasza.Pos.y, Config.Zones.Job1Pasza.Pos.z)
  local blipFarmer5 = AddBlipForCoord(Config.Zones.Job3.Pos.x, Config.Zones.Job3.Pos.y, Config.Zones.Job3.Pos.z)
  local blipFarmer6 = AddBlipForCoord(Config.Zones.Job3a.Pos.x, Config.Zones.Job3a.Pos.y, Config.Zones.Job3a.Pos.z)

  SetBlipSprite (blipFarmer2, Config.Blips.Zbieranie.Sprite)
  SetBlipDisplay(blipFarmer2, 4)
  SetBlipScale  (blipFarmer2, 0.9)
  SetBlipColour (blipFarmer2, 5)
  SetBlipAsShortRange(blipFarmer2, true)

  --SetBlipSprite (blipFarmer3, Config.Blips.Kopanie.Sprite)
  --SetBlipDisplay(blipFarmer3, 4)
  --SetBlipScale  (blipFarmer3, 2.0)
  --SetBlipColour (blipFarmer3, 5)
  --SetBlipAsShortRange(blipFarmer3, true)

  --SetBlipSprite (blipFarmer4, Config.Blips.Pasza.Sprite)
  --SetBlipDisplay(blipFarmer4, 4)
  --SetBlipScale  (blipFarmer4, 2.0)
  --SetBlipColour (blipFarmer4, 5)
  --SetBlipAsShortRange(blipFarmer4, true)

  SetBlipSprite (blipFarmer5, Config.Blips.Sprzedaz.Sprite)
  SetBlipDisplay(blipFarmer5, 4)
  SetBlipScale  (blipFarmer5, 0.9)
  SetBlipColour (blipFarmer5, 5)
  SetBlipAsShortRange(blipFarmer5, true)

  SetBlipSprite (blipFarmer6, Config.Blips.Chleb.Sprite)
  SetBlipDisplay(blipFarmer6, 4)
  SetBlipScale  (blipFarmer6, 0.9)
  SetBlipColour (blipFarmer6, 5)
  SetBlipAsShortRange(blipFarmer6, true)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName('Zbieranie pszenicy')
  EndTextCommandSetBlipName(blipFarmer2)
  table.insert(JobBlips, blipFarmer2)

  --BeginTextCommandSetBlipName("STRING")
  --AddTextComponentSubstringPlayerName('Wykopki')
  --EndTextCommandSetBlipName(blipFarmer3)
  --table.insert(JobBlips, blipFarmer3)

  --BeginTextCommandSetBlipName("STRING")
  --AddTextComponentSubstringPlayerName('Uzupelnianie jedzenia dla bydla.')
  --EndTextCommandSetBlipName(blipFarmer4)
  --table.insert(JobBlips, blipFarmer4)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName('Hurtownia spożywcza')
  EndTextCommandSetBlipName(blipFarmer5)
  table.insert(JobBlips, blipFarmer5)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName('Piekarnia')
  EndTextCommandSetBlipName(blipFarmer6)
  table.insert(JobBlips, blipFarmer6)

end

-- usuwanie blipow pracy oraz zejscie ze sluzby.
function offduty()
  onDuty = false
  if JobBlips[1] ~= nil then
		for i=1, #JobBlips, 1 do
			RemoveBlip(JobBlips[i])
			JobBlips[i] = nil
		end
	end
end

function orchard_givekeys()
    if(IsPedInAnyVehicle(PlayerPedId(), true))then
        VehId = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        local VehPlateTest = GetVehicleNumberPlateText(VehId)
        local VehLockStatus = GetVehicleDoorLockStatus(VehId)
        if VehPlateTest ~= nil then
            local VehPlate = string.lower(VehPlateTest)
            TriggerServerEvent('ls:checkOwner', VehId, VehPlate, VehLockStatus)
        end
    end
end


function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end