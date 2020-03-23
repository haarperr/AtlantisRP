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

local builderBlip               = false
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
local onDuty					= false
local JobBlips					= {}
local CustomerEnteredVehicle    = false
local TargetCoords              = nil
local IsDead                    = false
local showPro                 	= false
local box 						= nil
local isHolding 				= false
local wietara = nil

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

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'builder_cloakroom',
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
			builderblip()
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
					Wait(200)
					orchard_givekeys()
				end)

				TriggerServerEvent('esx_society:removeVehicleFromGarage', 'builder', vehicleProps)

			end, function(data, menu)
				CurrentAction     = 'vehicle_spawner'
				CurrentActionMsg  = _U('spawner_prompt')
				CurrentActionData = {}

				menu.close()
			end)
		end, 'builder')

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
					Wait(200)
					orchard_givekeys()
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
			TriggerServerEvent('esx_society:putVehicleInGarage', 'builder', vehicleProps)
			ESX.Game.DeleteVehicle(CurrentActionData.vehicle)

			--if Config.MaxInService ~= -1 then
			--	TriggerServerEvent('esx_service:disableService', 'builder')
			--end
		else
			ESX.ShowNotification(_U('only_builder'))
		end
end

function OpenBuilderActionsMenu()
	local elements = {
		{label = _U('deposit_stock'), value = 'put_stock'},
		{label = _U('take_stock'), value = 'get_stock'}
	}

	if Config.EnablePlayerManagement and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'builder_actions',
	{
		title    = 'BuilderJob',
		align    = 'right',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'builder', function(data, menu)
				menu.close()
			end)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'builder_actions_menu'
		CurrentActionMsg  = _U('press_to_open')
		CurrentActionData = {}
	end)
end

--function OpenMobileBuilderActionsMenu()
--	ESX.UI.Menu.CloseAll()
--
--	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_builder_actions',
--	{
--		title    = 'Taxi',
--		align    = 'top-left',
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
--				if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'builder' then
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
	ESX.TriggerServerCallback('esx_builder:getStockItems', function(items)
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
					TriggerServerEvent('esx_builder:getStockItem', itemName, count)
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
	ESX.TriggerServerCallback('esx_builder:getPlayerInventory', function(inventory)

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
					TriggerServerEvent('esx_builder:putStockItems', itemName, count)
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

AddEventHandler('esx_builder:hasEnteredMarker', function(zone)
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
	elseif zone == 'BuilderActions' then
		CurrentAction     = 'builder_actions_menu'
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

  elseif zone == 'Job1xd' then
  CurrentAction     = 'Job1xd'
  CurrentActionMsg  = _U('press_to_work')
  CurrentActionData = {}

		elseif zone == 'Job1' then
		CurrentAction     = 'Job1'
		CurrentActionMsg  = _U('press_to_work')
		CurrentActionData = {}

		elseif zone == 'Job2' then
		CurrentAction     = 'Job2'
		CurrentActionMsg  = _U('press_to_work')
		CurrentActionData = {}

    elseif zone == 'Job2a' then
    CurrentAction     = 'Job2a'
    CurrentActionMsg  = _U('press_to_work')
    CurrentActionData = {}

    elseif zone == 'Job2b' then
    CurrentAction     = 'Job2b'
    CurrentActionMsg  = _U('press_to_work')
    CurrentActionData = {}

	end
end)

AddEventHandler('esx_builder:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

--RegisterNetEvent('esx_phone:loaded')
--AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
--	local specialContact = {
--		name       = _U('phone_taxi'),
--		number     = 'builder',
--		base64Icon = 'data:image/png;base64,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',
--	}
--
--	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
--end)

-- Create Blips
function builderblip()
   local blipBuilder = AddBlipForCoord(Config.Zones.Cloakroom.Pos.x, Config.Zones.Cloakroom.Pos.y, Config.Zones.Cloakroom.Pos.z)

  SetBlipSprite (blipBuilder, Config.Blips.Job1xd.Sprite)
  SetBlipDisplay(blip, 4)
  SetBlipScale  (blip, 0.9)
  SetBlipColour (blip, 6)
  SetBlipAsShortRange(blip, true)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName('BU DO WA!')
  EndTextCommandSetBlipName(blip)
  table.insert(JobBlips, blip)
end



function onduty()
  onDuty = true
  local blipJob1xd = AddBlipForCoord(Config.Zones.Job1xd.Pos.x, Config.Zones.Job1xd.Pos.y, Config.Zones.Job1xd.Pos.z)
  local blipJob1 = AddBlipForCoord(Config.Zones.Job1.Pos.x, Config.Zones.Job1.Pos.y, Config.Zones.Job1.Pos.z)
  local blipJob2 = AddBlipForCoord(Config.Zones.Job2.Pos.x, Config.Zones.Job2.Pos.y, Config.Zones.Job2.Pos.z)
  local blipJob2a = AddBlipForCoord(Config.Zones.Job2a.Pos.x, Config.Zones.Job2a.Pos.y, Config.Zones.Job2a.Pos.z)
  local blipJob2b = AddBlipForCoord(Config.Zones.Job2b.Pos.x, Config.Zones.Job2b.Pos.y, Config.Zones.Job2b.Pos.z)

  SetBlipSprite (blipJob1xd, Config.Blips.Job1xd.Sprite)
  SetBlipDisplay(blip, 4)
  SetBlipScale  (blip, 0.8)
  SetBlipColour (blip, 6)
  SetBlipAsShortRange(blipJob1xd, true)

  SetBlipSprite (blipJob1, Config.Blips.Job1.Sprite)
  SetBlipDisplay(blip, 4)
  SetBlipScale  (blip, 0.8)
  SetBlipColour (blip, 6)
  SetBlipAsShortRange(blipJob1, true)

  SetBlipSprite (blipJob2, Config.Blips.Job2.Sprite)
  SetBlipDisplay(blip, 4)
  SetBlipScale  (blip, 0.8)
  SetBlipColour (blip, 6)
  SetBlipAsShortRange(blipJob2, true)

  SetBlipSprite (blipJob2a, Config.Blips.Job2a.Sprite)
  SetBlipDisplay(blip, 4)
  SetBlipScale  (blip, 0.8)
  SetBlipColour (blip, 6)
  SetBlipAsShortRange(blipJob2a, true)

  SetBlipSprite (blipJob2b, Config.Blips.Job2b.Sprite)
  SetBlipDisplay(blip, 4)
  SetBlipScale  (blip, 0.8)
  SetBlipColour (blip, 6)
  SetBlipAsShortRange(blipJob2b, true)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName('blipJob1xd')
  EndTextCommandSetBlipName(blipJob1xd)
  table.insert(JobBlips, blipJob1xd)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName('blipJob1')
  EndTextCommandSetBlipName(blipJob1)
  table.insert(JobBlips, blipJob1)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName('blipJob2')
  EndTextCommandSetBlipName(blipJob2)
  table.insert(JobBlips, blipJob2)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName('blipJob2a')
  EndTextCommandSetBlipName(blipJob2a)
  table.insert(JobBlips, blipJob2a)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName('blipJob2b')
  EndTextCommandSetBlipName(blipJob2b)
  table.insert(JobBlips, blipJob2b)

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

-- Enter / Exit marker events, and draw markers
Citizen.CreateThread(function()
builderblip()
	while true do
		Citizen.Wait(0)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'builder' then
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
        local time = TimeToSeconds(GetClockTime())
        if time >= 0 and time <= TimeToSeconds(6, 00, 0) then
          ESX.ShowNotification("FIRMA JEST NIECZYNNA. ZAPRASZAMY W GODZINACH 06:00-23:59")
        else
        	TriggerEvent('esx_builder:hasEnteredMarker', currentZone)
        end
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_builder:hasExitedMarker', LastZone)
			end
		else
			Citizen.Wait(1000)
		end
	end
end)


function GetClockTime()
	return GetClockHours(), GetClockMinutes(), GetClockSeconds()
end

function SecondsToTime(seconds)
    local hou = math.floor(seconds / 3600)
    local min = math.floor(seconds / 60 - (hou * 60))
    local sec = math.floor(seconds - hou * 3600 - min * 60)

    return { seconds = sec, minutes = min, hours = hou}
end

function TimeToSeconds(hou, min, sec)
    sec = sec + (min * 60)
    sec = sec + (hou * 60 * 60)

    return sec
end

-- 3x Marker Praca

function WorkJob1xd()
    if IsInAuthorizedVehicle() then
		ESX.ShowNotification("Pracownicy zakładu przelewają beton do Twojej betoniarki")
		FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), true)
		exports.pNotify:SendNotification({text = "Poczekaj na zakończenie załadunku. Następnie udaj się z nim na mniejszą budowę, majster przekaże Ci paczkę dla mnie...", type = "atlantis", queue = "global", timeout = 10000, layout = "atlantis"})
		procent(400)
		FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), false)
		TriggerServerEvent('builder:job1xd')
	else
		exports.pNotify:SendNotification({text = "Gdzie mamy wlać ten beton? Do dupy?", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
	end
end

function WorkJob1()
	if IsInAuthorizedVehicle() then
		exports.pNotify:SendNotification({text = "Ekipa budowlana zaczyna przelewać beton z Twojej betoniarki, w między czasie weź te gwoździe i zawieź je na budowe główną. Tam szef ma dla Ciebie jeszcze kilka zadań, zanim będziesz miał fajrant musisz je wykonać Zacznij od wbicia tych gwoździ.", type = "atlantis", queue = "global", timeout = 15000, layout = "atlantis"})
		FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), true)
		procent(200)
		FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), false)
		TriggerServerEvent('builder:job1')
	else
		exports.pNotify:SendNotification({text = "Papiery są? Betoniarka jest? CO?!", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
	end
end

function WorkJob2()
	exports.pNotify:SendNotification({text = "Wbijaj wbijaj nie mamy całego dnia, jeszcze musimy rozwalić kilka skał obok baraku szefa.", type = "atlantis", queue = "global", timeout = 10000, layout = "atlantis"})
	mlotek()
	FreezeEntityPosition(PlayerPedId(), true)
	procent(100)
	FreezeEntityPosition(PlayerPedId(), false)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	TriggerServerEvent('builder:job2')
end

-- function WorkJob2a()
--	ESX.ShowNotification("DEBUG: PRACA 2a")
--	wiertarka()
--	procent(200)
--    usunwiertarke()
--	TriggerServerEvent('builder:job1')
--end

function WorkJob2b()
  exports.pNotify:SendNotification({text = "TY TY TY TY DY DY DY DY DA DA DA TU TU TU JE JE JE S S S T T T ZA ZA PŁ PŁ PŁ A A A TA TA TA TA", type = "atlantis", queue = "global", timeout = 10000, layout = "atlantis"})
	bulikopacz()
	FreezeEntityPosition(PlayerPedId(), true)
	procent(100)
	FreezeEntityPosition(PlayerPedId(), false)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	TriggerServerEvent('builder:job2b')
	TriggerEvent('show:money', 1.5)
end

function WorkJob3()
	ESX.ShowNotification("DEBUG: PRACA 3")
	FreezeEntityPosition(PlayerPedId(), true)
	procent(100)
	FreezeEntityPosition(PlayerPedId(), false)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	TriggerServerEvent('builder:job3')
end

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction and not IsDead then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'builder' then
				if CurrentAction == 'builder_actions_menu' then
					OpenBuilderActionsMenu()
				elseif CurrentAction == 'cloakroom' then
					OpenCloakroom()
				elseif CurrentAction == 'vehicle_spawner' then
					OpenVehicleSpawnerMenu()
				elseif CurrentAction == 'delete_vehicle' then
					DeleteJobVehicle()
				elseif CurrentAction == 'buy_vehicle' then
					OpenShopMenu()
        elseif CurrentAction == 'Job1xd' then
          WorkJob1xd()
				elseif CurrentAction == 'Job1' then
					WorkJob1()
				elseif CurrentAction == 'Job2' then
					WorkJob2()
        elseif CurrentAction == 'Job2a' then
					--WorkJob2a()
        elseif CurrentAction == 'Job2b' then
          WorkJob2b()
				elseif CurrentAction == 'Job3' then
					WorkJob3()
				end

				CurrentAction = nil
			end
		end

		if IsControlJustReleased(0, Keys['F6']) and IsInputDisabled(0) and not IsDead and Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.name == 'builder' then
			OpenMobileBuilderActionsMenu()
		end
	end
end)

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	IsDead = false
end)

function mlotek()
        TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_HAMMERING', 0, true)
end

function bulikopacz()
        TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_CONST_DRILL', 0, true)
end

function wiertarka()
  local wiertarkaad = "anim@heists@fleeca_bank@drilling"
  local wiertarkaanim = "drill_straight_start"
  local player = PlayerPedId()

  if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
    loadAnimDict( wiertarkaad )
    if ( IsEntityPlayingAnim( player, wiertarkaad, wiertarkaanim, 8 ) ) then
      TaskPlayAnim( player, wiertarkaad, "exit", 8.0, 8.0, 1.0, 50, 1, 0, 0, 0 )
      ClearPedSecondaryTask(player)
    else
      SetCurrentPedWeapon( player, GetHashKey("WEAPON_UNARMED"), equipNow)
      wiertara = CreateObject(GetHashKey('prop_tool_drill'), GetEntityCoords(PlayerPedId()), true)-- creates object
      AttachEntityToEntity(wiertara, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.1, 0.04, -0.03, -90.0, 180.0, 0.0, true, true, false, true, 1, true)
      TaskPlayAnim( player, wiertarkaad, wiertarkaanim, 8.0, 8.0, 1.0, 50, 1, 0, 0, 0 )
    end
  end
end

function usunwiertarke()
		DeleteEntity(wiertara)
		ClearPedSecondaryTask(PlayerPedId())
		wiertara = nil
end

function wiertarka2()
  local ad = "amb@world_human_welding@male@base"
  local anim = "base"
  local player = PlayerPedId()


  if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
    loadAnimDict( ad )
    if ( IsEntityPlayingAnim( player, ad, anim, 8 ) ) then
      TaskPlayAnim( player, ad, "exit", 8.0, 8.0, 1.0, 00, 0, 0, 0, 0 )
      ClearPedSecondaryTask(player)
    else
      SetCurrentPedWeapon( player, GetHashKey("WEAPON_UNARMED"), equipNow)
      Citizen.Wait(50)
      TaskPlayAnim( player, ad, anim, 8.0, 8.0, 1.0, 00, 0, 0, 0, 0 )
    end
  end
end

function animacja()
	local ad = "mini@repair"
	local anim = "fixing_a_ped"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 8 ) ) then
			TaskPlayAnim( player, ad, "exit", 8.0, 8.0, 1.0, 00, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			SetCurrentPedWeapon( player, GetHashKey("WEAPON_UNARMED"), equipNow)
			Citizen.Wait(50)
			TaskPlayAnim( player, ad, anim, 8.0, 8.0, 1.0, 00, 0, 0, 0, 0 )
		end
	end
end


function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

function procent(time)
  showPro = true
  TimeLeft = 0
  repeat
  TimeLeft = TimeLeft + 1
  Citizen.Wait(time)
  until(TimeLeft == 100)
  showPro = false
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
		DrawText3D(coords.x, coords.y, coords.z+0.2, 'PRACUJE' , 0.4)
      DrawText3D(coords.x, coords.y, coords.z, TimeLeft .. '~g~%', 0.4)
    end
	end
end)
