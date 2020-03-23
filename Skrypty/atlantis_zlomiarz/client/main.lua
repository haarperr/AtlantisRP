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

local scrapBlip                 = false
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local onDuty                    = false
local CurrentCustomer           = nil
local CurrentCustomerBlip       = nil
local DestinationBlip           = nil
local IsNearCustomer            = false
local CustomerIsEnteringVehicle = false
local CustomerEnteredVehicle    = false
local TargetCoords              = nil
local IsDead                    = false
local showPro                 	= false
local box 						= nil
local isHolding 				= false
local JobBlips = {}

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

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'scrap_cloakroom',
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
      mainblip()
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		menu.close()
		elseif data.current.value == 'wear_work' then
      onduty()
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
				else
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
				end
			end)
		menu.close()
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
					scrap_givekeys()
				end)

				TriggerServerEvent('esx_society:removeVehicleFromGarage', 'scrap', vehicleProps)

			end, function(data, menu)
				CurrentAction     = 'vehicle_spawner'
				CurrentActionMsg  = _U('spawner_prompt')
				CurrentActionData = {}

				menu.close()
			end)
		end, 'scrap')

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
        		wskazowka("~y~Udaj sie na teren złomowiska i zacznij zbieranie.")
				Wait(200)
				scrap_givekeys()
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
  local pojazd = GetVehiclePedIsIn(PlayerPedId(), false)

		if IsInAuthorizedVehicle() then
      if IsVehicleDamaged(pojazd) then
        wskazowka("~BLIP_GARAGE~  ~r~Oddałeś uszkodzony pojazd, ~w~Szef firmy zostal poinformowany.")
        --TriggerServerEvent('scrap:kara')
        local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
        --TriggerServerEvent('esx_society:putVehicleInGarage', 'scrap', vehicleProps)
        ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
      else
        wskazowka("~BLIP_GARAGE~ ~g~ No teraz to mi zaimponowałeś! Dostales nagrode za oddanie sprawnego auta.")
        TriggerServerEvent('scrap:nagroda')
  			local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
  			--TriggerServerEvent('esx_society:putVehicleInGarage', 'scrap', vehicleProps)
  			ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
      end
  			--if Config.MaxInService ~= -1 then
  			--	TriggerServerEvent('esx_service:disableService', 'scrap')
  			--end
		else
			ESX.ShowNotification(_U('only_scrap'))
		end
end

function OpenScrapActionsMenu()
	local elements = {}

	if Config.EnablePlayerManagement and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'mid' then
		table.insert(elements, {label = _U('take_stock'), value = 'get_stock'})
		table.insert(elements, {label = _U('deposit_stock'), value = 'put_stock'})
	end

	if Config.EnablePlayerManagement and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'kierownik' then
		table.insert(elements, {label = _U('take_stock'), value = 'get_stock'})
		table.insert(elements, {label = _U('deposit_stock'), value = 'put_stock'})
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'scrap_actions',
	{
		title    = 'ScrapJob',
		align    = 'right',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'scrap', function(data, menu)
				menu.close()
			end)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'scrap_actions_menu'
		CurrentActionMsg  = _U('press_to_open')
		CurrentActionData = {}
	end)
end

--function OpenMobileScrapActionsMenu()
--	ESX.UI.Menu.CloseAll()
--
--	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_scrap_actions',
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
--				if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'scrap' then
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
	ESX.TriggerServerCallback('esx_jobscrap:getStockItems', function(items)
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
					TriggerServerEvent('esx_jobscrap:getStockItem', itemName, count)
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
	ESX.TriggerServerCallback('esx_jobscrap:getPlayerInventory', function(inventory)

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
					TriggerServerEvent('esx_jobscrap:putStockItems', itemName, count)
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

				ESX.TriggerServerCallback('scrap:buyJobVehicle', function (bought)
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
  offduty()
  mainblip()
end)


AddEventHandler('esx_jobscrap:hasEnteredMarker', function(zone)
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
	elseif zone == 'ScrapActions' then
		CurrentAction     = 'scrap_actions_menu'
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
		CurrentActionMsg  = ('Naciśnij ~INPUT_CONTEXT~ aby zebrać złom')
		CurrentActionData = {}

		elseif zone == 'Job1a' then
		CurrentAction     = 'Job1a'
		CurrentActionMsg  = ('Naciśnij ~INPUT_CONTEXT~ aby zebrać złom')
		CurrentActionData = {}

		elseif zone == 'Job1b' then
		CurrentAction     = 'Job1b'
		CurrentActionMsg  = ('Naciśnij ~INPUT_CONTEXT~ aby zebrać złom')
		CurrentActionData = {}

		elseif zone == 'Job2' then
		CurrentAction     = 'Job2'
		CurrentActionMsg  = ('Naciśnij ~INPUT_CONTEXT~ aby uruchomić prasę do złomu')
		CurrentActionData = {}

		elseif zone == 'Job3' then
		CurrentAction     = 'Job3'
		CurrentActionMsg  = ('Naciśnij ~INPUT_CONTEXT~ aby oddac sprasowany złom')
		CurrentActionData = {}

		elseif zone == 'Job4' then
		CurrentAction     = 'Job4'
		CurrentActionMsg  = ('Naciśnij ~INPUT_CONTEXT~ aby odebrać wynagrodzenie')
		CurrentActionData = {}

	end
end)

AddEventHandler('esx_jobscrap:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

Citizen.CreateThread(function()
	mainblip()
	while true do
		Citizen.Wait(0)
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'scrap' and not onDuty then
			local coords = GetEntityCoords(PlayerPedId())
			local distance = GetDistanceBetweenCoords(coords, Config.Zones.Cloakroom.Pos.x, Config.Zones.Cloakroom.Pos.y, Config.Zones.Cloakroom.Pos.z, true)
			local isInMarker, currentZone = false

			if distance < Config.DrawDistance then
				DrawMarker(Config.Zones.Cloakroom.Type, Config.Zones.Cloakroom.Pos.x, Config.Zones.Cloakroom.Pos.y, Config.Zones.Cloakroom.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Zones.Cloakroom.Size.x, Config.Zones.Cloakroom.Size.y, Config.Zones.Cloakroom.Size.z, Config.Zones.Cloakroom.Color.r, Config.Zones.Cloakroom.Color.g, Config.Zones.Cloakroom.Color.b, 100, false, false, 2, Config.Zones.Cloakroom.Rotate, nil, nil, false)

			if distance < Config.Zones.Cloakroom.Size.x then
				isInMarker, currentZone = true, 'Cloakroom'
			end

			  if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker, LastZone = true, currentZone
				TriggerEvent('esx_jobscrap:hasEnteredMarker', currentZone)
			  end

			  if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_jobscrap:hasExitedMarker', LastZone)
			  end

			  if isInMarker and IsControlJustReleased(0, Keys['E']) then
			  		OpenCloakroom()
				  	CurrentAction = nil
				end
			end
		end
	end
end)

-- Enter / Exit marker events, and draw markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if onDuty then
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
				TriggerEvent('esx_jobscrap:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_jobscrap:hasExitedMarker', LastZone)
			end
		else
			Citizen.Wait(5000)
		end

      if CurrentAction and not IsDead then
        ESX.ShowHelpNotification(CurrentActionMsg)

        if IsControlJustReleased(0, Keys['E']) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'scrap' then
          if CurrentAction == 'scrap_actions_menu' then
            OpenScrapActionsMenu()
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
          elseif CurrentAction == 'Job1a' then
            WorkJob1a()
          elseif CurrentAction == 'Job1b' then
            WorkJob1b()
          elseif CurrentAction == 'Job2' then
            WorkJob2()
          elseif CurrentAction == 'Job3' then
            WorkJob3()
          elseif CurrentAction == 'Job4' then
            WorkJob4()
          end

          CurrentAction = nil
        end
      end

      --[[if IsControlJustReleased(0, Keys['F6']) and IsInputDisabled(0) and not IsDead and Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.name == 'scrap' then
        OpenMobileScrapActionsMenu()
      end]]
	end
end)

-- 3x Marker Praca

function WorkJob1()

    if onDuty == true then
    	if isHolding == true then
    		TriggerEvent("pNotify:SendNotification", {text = "Najpierw odstaw paczke do auta", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
    	else
    		animacja()
		FreezeEntityPosition(PlayerPedId(), true)
        procent(150)
    	TriggerServerEvent('scrap:job1')
		FreezeEntityPosition(PlayerPedId(), false)
    	end
    else
      wskazowka("~r~A gdzie ciuszki robocze?")
    end
end

function WorkJob1a()
    if onDuty == true then
    	if isHolding == true then
    		TriggerEvent("pNotify:SendNotification", {text = "Najpierw odstaw paczke do auta", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
    	else
    		animacja()
		FreezeEntityPosition(PlayerPedId(), true)
    	procent(150)
    	TriggerServerEvent('scrap:job1a')
		FreezeEntityPosition(PlayerPedId(), false)
      end
    else
      wskazowka("~r~A gdzie ciuszki robocze?")
    end
end

function WorkJob1b()
    if onDuty == true then
    	if isHolding == true then
    		TriggerEvent("pNotify:SendNotification", {text = "Najpierw odstaw paczke do auta", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
    	else
    		animacja()
		FreezeEntityPosition(PlayerPedId(), true)
    	procent(150)
    	TriggerServerEvent('scrap:job1b')
		FreezeEntityPosition(PlayerPedId(), false)
      end
    else
      wskazowka("~r~A gdzie ciuszki robocze?")
    end
end

function WorkJob2()
local pozycja = GetEntityCoords(PlayerPedId())
local pojazd = GetVehiclePedIsIn(PlayerPedId(), true)
local pozycja = GetEntityCoords(pojazd)
local odleglosc = GetDistanceBetweenCoords(pozycja.x, pozycja.y, pozycja.z, 1021.58, 3572.62, 34.03, true)
if IsPedInAnyVehicle(PlayerPedId()) then
    wskazowka("Wyjdz z pojazdu")
else
    if odleglosc > 5 then
      wskazowka("Ustaw pojazd ze złomem bliżej prasy!.")
    else
      wskazowka("Prasa uruchomiona poczekaj chwile.")
      FreezeEntityPosition(pojazd, true)
    	animacjaprzycisk()
    	procent(150)
    	TriggerServerEvent('scrap:job2')
      FreezeEntityPosition(pojazd, false)
      wskazowka("Odstaw sprasowany złom na baze.")
      SetNewWaypoint(Config.Zones.Job3.Pos.x, Config.Zones.Job3.Pos.y)
    end
  end
end

function WorkJob3()
local pozycja = GetEntityCoords(PlayerPedId())
local pojazd = GetVehiclePedIsIn(PlayerPedId(), true)
local pozycja = GetEntityCoords(pojazd)
local odleglosc = GetDistanceBetweenCoords(pozycja.x, pozycja.y, pozycja.z, 2354.39, 3037.32, 47.35, true)
if IsPedInAnyVehicle(PlayerPedId()) then
    wskazowka("Wyjdz z pojazdu")
else
    if odleglosc > 5 then
      wskazowka("Ustaw pojazd ze złomem bliżej maszyny do rozładunku!.")
    else
    	FreezeEntityPosition(pojazd, true)
      wskazowka("Poczekaj aż maszyna rozładuje samochód.")
    	procent(150)
    	FreezeEntityPosition(pojazd, false)
    	TriggerServerEvent('scrap:job3')
      wskazowka("Oddstaw pojazd do garażu i udaj się do kasy po wynagrodzenie")
    end
  end
end

function WorkJob4()
	TriggerServerEvent('scrap:job4')
	TriggerEvent('show:money', 2.5)
end

RegisterNetEvent('zlom:anim')
AddEventHandler('zlom:anim', function()
  ClearPedTasks(PlayerPedId())
	animacjanoszenia()
  TriggerEvent('zlomiarz:petelka')
  wskazowka("MAMY ZŁOM! Podejdź do samochodu słuzbowego i ~y~naciśnij ~INPUT_CONTEXT~ aby zapakować złom")
end)

RegisterNetEvent('zlom:toomuch')
AddEventHandler('zlom:toomuch', function()
	ClearPedTasksImmediately(PlayerPedId())
end)

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
  onDuty = false
  carload()
end)

AddEventHandler('playerSpawned', function(spawn)
	IsDead = false
end)

function mainblip()
  local blipScrap = AddBlipForCoord(Config.Zones.Cloakroom.Pos.x, Config.Zones.Cloakroom.Pos.y, Config.Zones.Cloakroom.Pos.z)

  SetBlipSprite (blipScrap, Config.Blips.CloakroomScrap.Sprite)
  SetBlipDisplay(blipScrap, 4)
  SetBlipScale  (blipScrap, 1.0)
  SetBlipColour (blipScrap, 0)

  SetBlipAsShortRange(blipScrap, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName('Baza złomiarzy')
  EndTextCommandSetBlipName(blipScrap)
  table.insert(JobBlips, blipScrap)
end

-- wejscie na sluzbe i dodanie blipow
function onduty()
  onDuty = true
  local blipScrap2 = AddBlipForCoord(Config.Zones.Job2.Pos.x, Config.Zones.Job2.Pos.y, Config.Zones.Job2.Pos.z)
  local blipScrap3 = AddBlipForCoord(Config.Zones.Job3.Pos.x, Config.Zones.Job3.Pos.y, Config.Zones.Job3.Pos.z)
  local blipScrap4 = AddBlipForCoord(Config.Zones.Job1.Pos.x, Config.Zones.Job1.Pos.y, Config.Zones.Job1.Pos.z)

  SetBlipSprite (blipScrap2, Config.Blips.Prasa.Sprite)
  SetBlipDisplay(blipScrap2, 4)
  SetBlipScale  (blipScrap2, 1.0)
  SetBlipColour (blipScrap2, 0)
  SetBlipAsShortRange(blipScrap2, true)


  SetBlipSprite (blipScrap3, Config.Blips.Zwrot.Sprite)
  SetBlipDisplay(blipScrap3, 4)
  SetBlipScale  (blipScrap3, 1.0)
  SetBlipColour (blipScrap3, 0)
  SetBlipAsShortRange(blipScrap3, true)

  SetBlipSprite (blipScrap4, Config.Blips.Zbieranie.Sprite)
  SetBlipDisplay(blipScrap4, 4)
  SetBlipScale  (blipScrap4, 1.0)
  SetBlipColour (blipScrap4, 0)
  SetBlipAsShortRange(blipScrap4, true)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName('Prasowanie złomu')
  EndTextCommandSetBlipName(blipScrap2)
  table.insert(JobBlips, blipScrap2)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName('Zwrot sprasowanego złomu')
  EndTextCommandSetBlipName(blipScrap3)
  table.insert(JobBlips, blipScrap3)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName('Zbieranie złomu')
  EndTextCommandSetBlipName(blipScrap4)
  table.insert(JobBlips, blipScrap4)
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


function animacja()
	local ad = "mini@repair"
	local anim = "fixing_a_ped"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 8 ) ) then
			TaskPlayAnim( player, ad, "exit", 8.0, -8.0, 0.2, 1, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			SetCurrentPedWeapon( player, GetHashKey("WEAPON_UNARMED"), equipNow)
			Citizen.Wait(50)
			TaskPlayAnim( player, ad, anim, 8.0, -8.0, 0.2, 1, 0, 0, 0, 0 )
		end
	end
end

function animacjaprzycisk()
	local ad = "missagency_heist_2a"
	local anim = "push_button"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 8 ) ) then
			TaskPlayAnim( player, ad, "exit", 8.0, 8.0, 0.3, 00, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			SetCurrentPedWeapon( player, GetHashKey("WEAPON_UNARMED"), equipNow)
			Citizen.Wait(50)
			TaskPlayAnim( player, ad, anim, 8.0, 8.0, 0.3, 00, 0, 0, 0, 0 )
		end
	end
end

function animacjanoszenia()
	local ad = "anim@heists@box_carry@"
	local anim = "idle"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 8 ) ) then
			TaskPlayAnim( player, ad, "exit", 8.0, 8.0, 1.0, 50, 1, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			usunpropzlom()
			SetCurrentPedWeapon( player, GetHashKey("WEAPON_UNARMED"), equipNow)
			box = CreateObject(GetHashKey("prop_cs_cardbox_01"), 0, 0, 0, true, true, true) -- creates object
			AttachEntityToEntity(box, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 28422), 0, 0, 0, 0, 0, 0, true, true, false, true, 1, true)
			Citizen.Wait(50)
			TaskPlayAnim( player, ad, anim, 8.0, 8.0, 1.0, 50, 1, 0, 0, 0 )
		end
	end
end

function carload()
    --wskazowka("~g~ Złom zapakowany.")
		DeleteEntity(box)
		ClearPedSecondaryTask(PlayerPedId())
		box = nil
		isHolding = false
end

--- usuwanie samego propa złomu
function usunpropzlom()
    DeleteEntity(box)
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

function wskazowka(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent('zlomiarz:petelka')
AddEventHandler('zlomiarz:petelka', function()
	isHolding = true
  while (isHolding) do
    Citizen.Wait(1)
				if IsControlJustPressed(1, 38) then
          local coords = GetEntityCoords(PlayerPedId())
          local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 2.0, 0, 70)
          local dupcia = GetEntityModel(vehicle)
            for i=1, #Config.AuthorizedVehicles, 1 do
            if dupcia == GetHashKey(Config.AuthorizedVehicles[i].model) then
						carload()
						isHolding = false
					else
						ESX.ShowNotification("Za daleko do pojazdu lub nieautoryzowany model.")
					end
        end
			end
	end
end)

RegisterNetEvent('zlomiarz:procenty')
AddEventHandler('zlomiarz:procenty', function()
  showPro = true
    while (showPro) do
      Citizen.Wait(10)
      local playerPed = PlayerPedId()
      local coords = GetEntityCoords(playerPed)
      local hp2 = GetEntityHealth(GetPlayerPed(-1))
      DisableControlAction(0, 73, true) -- X
      DrawText3D(coords.x, coords.y, coords.z+0.1,'Pracuje...' , 0.4)
      DrawText3D(coords.x, coords.y, coords.z, TimeLeft .. '~g~%', 0.4)
    end
end)

function procent(time)
  TriggerEvent('zlomiarz:procenty')
  TimeLeft = 0
  repeat
  TimeLeft = TimeLeft + 1
  Citizen.Wait(time)
  until(TimeLeft == 100)
  showPro = false
end

function scrap_givekeys()
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
