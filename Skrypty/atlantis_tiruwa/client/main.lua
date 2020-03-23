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

local truckerrBlip                = false
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local truckerBlips 				= {}
local jobBlips 					= {}
local OnJob                     = false
local CurrentCustomer           = nil
local CurrentCustomerBlip       = nil
local DestinationBlip           = nil
local IsNearCustomer            = false
local CustomerIsEnteringVehicle = false
local CustomerEnteredVehicle    = false
local TargetCoords              = nil
local IsDead                    = false
local currentTrailer			= nil
local TrailerParked				= false
local jobClothes = false
local onDuty = false

ESX                             = nil

truckerJobCoords = {
--[1] = {x = 2445.66, y = -381.06, z = 92.99},
--[2] = {x = 870.90,y = 2343.57, z = 51.69},
[1] = {x = 2901.82, y = 4383.13, z = 50.35},
[2] = {x = -131.40, y = 6216.75, z = 31.21},
[3] = {x = -697.44, y = 5774.12, z = 17.33},
[4] = {x = -58.13, y = 6551.22, z = 31.49},
[5] = {x = 64.24, y = 6512.84, z = 31.45},
[6] = {x = 197.92, y = 6612.39, z = 31.76},
[7] = {x = 1577.98, y = 6443.21, z = 24.73},
[8] = {x = 1709.45, y = 4804.04, z = 41.79},
[9] = {x = 1685.75,y = 4919.99, z = 42.08},
[10] = {x = -1664.12,y = 3119.09, z = 31.30},
[11] = {x = 2902.59,y = 4382.75, z = 50.35},
[12] = {x = -2200.40,y = 4256.60, z = 47.81},
[13] = {x = -572.06,y = 5339.49, z = 70.21},
[14] = {x = 2674.38,y = 3526.36, z = 52.48},
}

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

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'trucker_cloakroom',
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

	if onDuty == true then

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

				TriggerServerEvent('esx_society:removeVehicleFromGarage', 'trucker', vehicleProps)

			end, function(data, menu)
				CurrentAction     = 'vehicle_spawner'
				CurrentActionMsg  = _U('spawner_prompt')
				CurrentActionData = {}

				menu.close()
			end)
		end, 'trucker')

	else -- not society vehicles

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
		{
			title		= _U('spawn_veh'),
			align		= 'right',
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
end

function DeleteJobVehicle()
	local playerPed = PlayerPedId()

	if onDuty == true then
		if IsInAuthorizedVehicle() then
			local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
			TriggerServerEvent('esx_society:putVehicleInGarage', 'trucker', vehicleProps)
			ESX.Game.DeleteVehicle(CurrentActionData.vehicle)

			--if Config.MaxInService ~= -1 then
			--	TriggerServerEvent('esx_service:disableService', 'trucker')
			--end
		else
			ESX.ShowNotification(_U('only_trucker'))
		end
	end
end

function OpenTruckerActionsMenu()
	local elements = {
		{label = _U('deposit_stock'), value = 'put_stock'},
		{label = _U('take_stock'), value = 'get_stock'}
	}

	if Config.EnablePlayerManagement and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'trucker_actions',
	{
		title    = 'truckerJob',
		align    = 'right',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'trucker', function(data, menu)
				menu.close()
			end)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'trucker_actions_menu'
		CurrentActionMsg  = _U('press_to_open')
		CurrentActionData = {}
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
	ESX.TriggerServerCallback('esx_trucker:getStockItems', function(items)
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
					TriggerServerEvent('esx_trucker:getStockItem', itemName, count)
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
	ESX.TriggerServerCallback('esx_trucker:getPlayerInventory', function(inventory)

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
					TriggerServerEvent('esx_trucker:putStockItems', itemName, count)
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
-----------------------------------------------------------------
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	offduty()
   	mainblip()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	offduty()
   	mainblip()
end)

AddEventHandler('esx_trucker:hasEnteredMarker', function(zone)
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
	elseif zone == 'TruckerActions' then
		CurrentAction     = 'trucker_actions_menu'
		CurrentActionMsg  = _U('press_to_open')
		CurrentActionData = {}

	elseif zone == 'Cloakroom' then
		CurrentAction     = 'cloakroom'
		CurrentActionMsg  = _U('cloakroom_prompt')
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
	end
end)

AddEventHandler('esx_trucker:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'trucker' and not onDuty then
			local coords = GetEntityCoords(PlayerPedId())
			local distance = GetDistanceBetweenCoords(coords, Config.Zones.Cloakroom.Pos.x, Config.Zones.Cloakroom.Pos.y, Config.Zones.Cloakroom.Pos.z, true)
			local isInMarker, currentZone = false

			if distance < Config.DrawDistance then
				DrawMarker(Config.Zones.Cloakroom.Type, Config.Zones.Cloakroom.Pos.x, Config.Zones.Cloakroom.Pos.y, Config.Zones.Cloakroom.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Zones.Cloakroom.Size.x, Config.Zones.Cloakroom.Size.y, Config.Zones.Cloakroom.Size.z, Config.Zones.Cloakroom.Color.r, Config.Zones.Cloakroom.Color.g, Config.Zones.Cloakroom.Color.b, 100, false, false, 2, Config.Zones.Cloakroom.Rotate, nil, nil, false)
				--DrawText3Ds(Config.Zones.Cloakroom.Pos.x, Config.Zones.Cloakroom.Pos.y, Config.Zones.Cloakroom.Pos.z+0.5, Config.Zones.Cloakroom.Text)

			if distance < Config.Zones.Cloakroom.Size.x then
				isInMarker, currentZone = true, 'Cloakroom'
			end

			  if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker, LastZone = true, currentZone
				TriggerEvent('esx_trucker:hasEnteredMarker', currentZone)
			  end

			  if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_trucker:hasExitedMarker', LastZone)
			  end

			  if isInMarker and IsControlJustReleased(0, Keys['E']) then
			  		OpenCloakroom()
				  	CurrentAction = nil
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
mainblip()
	while true do
		Citizen.Wait(0)
		if onDuty then
			local coords = GetEntityCoords(PlayerPedId())
			local isInMarker, currentZone = false


			for k,v in pairs(Config.Zones) do
				local distance = GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true)

				if v.Type ~= -1 then
					--and distance < Config.DrawDistance then
					if distance > 5 and distance < Config.DrawDistance then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, false, 2, v.Rotate, nil, nil, false)
					--DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z+0.5, v.Text)
					elseif distance < 5 and distance < Config.DrawDistance then
						DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, false, 2, v.Rotate, nil, nil, false)
						--DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z+0.5, v.Text)
					end
				end

				if distance < v.Size.x then
					isInMarker, currentZone = true, k
				end
			end

		  if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker, LastZone = true, currentZone
			TriggerEvent('esx_trucker:hasEnteredMarker', currentZone)
		  end

		  if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_trucker:hasExitedMarker', LastZone)
		  end
		else
			Citizen.Wait(5000)
		end

		if CurrentAction and not IsDead then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'trucker' then
				if CurrentAction == 'trucker_actions_menu' then
					OpenTruckerActionsMenu()
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
				end

				CurrentAction = nil
			end
		end
	end
end)

-- 3x Marker Praca
function WorkJob1()
	local spawnpoint = {x = 168.22, y = -3075.12, z = 5.87}
	if onDuty == true then
	if not ESX.Game.IsSpawnPointClear(spawnpoint, 5.0) then
		ESX.ShowNotification('Miejsce poboru naczepy jest zablokowane.')
	else
		if currentTrailer == nil and GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false)) == GetHashKey('phantom') then
			ESX.Game.SpawnVehicle('trailers', spawnpoint, 266.96, function(vehicle)
				currentTrailer = vehicle
			end)
			TriggerEvent('trucker:onjob')
		else
			ESX.ShowNotification('Masz juz pobraną naczepę lub nie jesteś w odpowiednim pojeździe aby ją pobrać.')
		end
	end
	end
end

local inwork
RegisterNetEvent('trucker:onjob')
AddEventHandler('trucker:onjob', function()
if onDuty == true then
	inwork = true
	jobCoords = truckerJobCoords[math.random(#truckerJobCoords)]
    SetNewWaypoint(jobCoords.x, jobCoords.y)
    CreateDeliveryBlip(jobCoords.x, jobCoords.y, jobCoords.z)
    while inwork do 
    Citizen.Wait(0)
    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), jobCoords.x, jobCoords.y, jobCoords.z, true) < 30.0 then
        DrawText3Ds(jobCoords.x, jobCoords.y, jobCoords.z, "~b~[E] ~s~Aby dostarczyć towar.")
        DrawMarker(27,jobCoords.x,jobCoords.y,jobCoords.z-0.80, 0, 0, 0, 0, 0, 0, 10.6, 10.6, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0) 
      if IsControlJustReleased(0, 38) then 
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), jobCoords.x, jobCoords.y, jobCoords.z, true) < 30.0 then
            	if IsVehicleAttachedToTrailer(GetVehiclePedIsIn(PlayerPedId(), false)) then 
            		ESX.ShowNotification('Najpierw odłącz naczepę (Przytrzymaj ~b~H~w~)')
            	else
            		if GetDistanceBetweenCoords(GetEntityCoords(currentTrailer), jobCoords.x, jobCoords.y, jobCoords.z, true) < 10.0 then
		              	inwork = false
		              	ESX.ShowNotification('Udało się naczepa ~g~dostarczona~w~!')
		              	ESX.Game.DeleteVehicle(currentTrailer)
		              	removeBlips()
		              	--TrailerParked = true
		              	SetNewWaypoint(153.61, -3080.16)
		              	TriggerServerEvent('esx_trucker:job1', 'trucker_check')
		                return
		            else
		            	ESX.ShowNotification('~r~Przyczepa stoi w złym miejscu!')
	            	end
	            end
            end
        end
     end
    end
	end
end)

function WorkJob2()
--if onDuty == true then
	--if TrailerParked then
		TriggerServerEvent('esx_trucker:job2')
		TriggerEvent('show:money', 2.5)
		--currentTrailer = nil
	--else 
		--ESX.ShowNotification('Nie wykonałeś jeszcze kursu...')
	--end
	--end
end

function WorkJob3()
if onDuty == true then
	if inwork then
		if DoesEntityExist(currentTrailer) then
			if GetDistanceBetweenCoords(GetEntityCoords(currentTrailer), Config.Zones.Job3.Pos.x, Config.Zones.Job3.Pos.y, Config.Zones.Job3.Pos.z, true) < 10.0 then
				inwork = false
				ESX.Game.DeleteVehicle(currentTrailer)
				currentTrailer = nil
		        removeBlips()
		        SetNewWaypoint(153.61, -3080.16)
			end
		else
			inwork = false
			currentTrailer = nil
			removeBlips()
		    SetNewWaypoint(153.61, -3080.16)
		end
	end
	end
end

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	IsDead = false
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.30, 0.30)
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

function CreateDeliveryBlip(x,y,z)
    removeBlips()
    Wait(500)
    local blipTruckerJob = AddBlipForCoord(x,y,z)

  SetBlipSprite (blipTruckerJob, 477)
  SetBlipDisplay(blipTruckerJob, 4)
  SetBlipScale  (blipTruckerJob, 1.0)
  SetBlipColour (blipTruckerJob, 5)
  SetBlipAsShortRange(blipTruckerJob, true)

  BeginTextCommandSetBlipName("STRING")
  --AddTextComponentSubstringPlayerName("Stacja")
  EndTextCommandSetBlipName(blipTruckerJob)
  table.insert(jobBlips, blipTruckerJob)
end

function removeBlips()
      if jobBlips[1] ~= nil then
        for i=1, #jobBlips, 1 do
            RemoveBlip(jobBlips[i])
            jobBlips[i] = nil
        end
    end
end

function onduty()
if not BlipsAdded then
  onDuty = true
  BlipsAdded = true 
		  local blippos = {x = 143.86, y = -3111.27, z = 5.89}
		  local blippos2 = {x = 152.92, y = -3113.09, z = 5.9}
		  local blippos3 = {x = 157.15, y = -3102.65, z = 7.03}
		  local truckerblips = AddBlipForCoord(blippos.x, blippos.y, blippos.z)
		  local truckerblips2 = AddBlipForCoord(blippos2.x, blippos2.y, blippos2.z)
		  local truckerblips3 = AddBlipForCoord(blippos3.x, blippos3.y, blippos3.z)
		  local truckerblips4 = AddBlipForCoord(Config.Zones.Job3.Pos.x, Config.Zones.Job3.Pos.y, Config.Zones.Job3.Pos.z)

		  SetBlipSprite (truckerblips, 477)
		  SetBlipDisplay(truckerblips, 4)
		  SetBlipScale  (truckerblips, 1.0)
		  SetBlipColour (truckerblips, 5)
		  SetBlipAsShortRange(truckerblips, true)

		  SetBlipSprite (truckerblips2, 477)
		  SetBlipDisplay(truckerblips2, 4)
		  SetBlipScale  (truckerblips2, 0.6)
		  SetBlipColour (truckerblips2, 5)
		  SetBlipAsShortRange(truckerblips2, true)

		  SetBlipSprite (truckerblips3, 477)
		  SetBlipDisplay(truckerblips3, 4)
		  SetBlipScale  (truckerblips3, 0.6)
		  SetBlipColour (truckerblips3, 5)
		  SetBlipAsShortRange(truckerblips3, true)

		  SetBlipSprite (truckerblips4, 477)
		  SetBlipDisplay(truckerblips4, 4)
		  SetBlipScale  (truckerblips4, 0.6)
		  SetBlipColour (truckerblips4, 5)
		  SetBlipAsShortRange(truckerblips4, true)
		
		  BeginTextCommandSetBlipName("STRING")
		  AddTextComponentSubstringPlayerName('Siedziba Truckerow')
		  EndTextCommandSetBlipName(truckerblips)
		  table.insert(truckerBlips, truckerblips)

		  BeginTextCommandSetBlipName("STRING")
		  AddTextComponentSubstringPlayerName('Szatnia')
		  EndTextCommandSetBlipName(truckerblips2)
		  table.insert(truckerBlips, truckerblips2)

		  BeginTextCommandSetBlipName("STRING")
		  AddTextComponentSubstringPlayerName('Pobór pojazdu')
		  EndTextCommandSetBlipName(truckerblips3)
		  table.insert(truckerBlips, truckerblips3)

		  BeginTextCommandSetBlipName("STRING")
		  AddTextComponentSubstringPlayerName('Utylizacja naczep')
		  EndTextCommandSetBlipName(truckerblips4)
		  table.insert(truckerBlips, truckerblips4)
	else
 		ESX.ShowNotification('Masz juz służbowe ciuchy.')
	end
end

function offduty()
  onDuty = false
  BlipsAdded = false
    if truckerBlips[1] ~= nil then
        for i=1, #truckerBlips, 1 do
            RemoveBlip(truckerBlips[i])
            truckerBlips[i] = nil
		end
	end
end

function mainblip()
  local blippos = {x = 143.86, y = -3111.27, z = 5.89}
  local truckerblips = AddBlipForCoord(blippos.x, blippos.y, blippos.z)

		  SetBlipSprite (truckerblips, 477)
		  SetBlipDisplay(truckerblips, 4)
		  SetBlipScale  (truckerblips, 1.0)
		  SetBlipColour (truckerblips, 5)
		  SetBlipAsShortRange(truckerblips, true)

		  BeginTextCommandSetBlipName("STRING")
		  AddTextComponentSubstringPlayerName('Siedziba Truckerow')
		  EndTextCommandSetBlipName(truckerblips)
		  table.insert(truckerBlips, truckerblips)
end

-- Key Controls
--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction and not IsDead then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'trucker' then
				if CurrentAction == 'trucker_actions_menu' then
					OpenTruckerActionsMenu()
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
				end

				CurrentAction = nil
			end
		end

		--[[if IsControlJustReleased(0, Keys['F6']) and IsInputDisabled(0) and not IsDead and Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.name == 'trucker' then
			OpenMobiletruckerActionsMenu()
		end
	end
end)]]

--[[function Createtruckerblipss()
	removeTruckerBlips()
	Wait(5000)
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'trucker' then
		  local blippos = {x = 143.86, y = -3111.27, z = 5.89}
		  local blippos2 = {x = 152.92, y = -3113.09, z = 5.9}
		  local blippos3 = {x = 157.15, y = -3102.65, z = 7.03}
		  local truckerblips = AddBlipForCoord(blippos.x, blippos.y, blippos.z)
		  local truckerblips2 = AddBlipForCoord(blippos2.x, blippos2.y, blippos2.z)
		  local truckerblips3 = AddBlipForCoord(blippos3.x, blippos3.y, blippos3.z)
		  local truckerblips4 = AddBlipForCoord(Config.Zones.Job3.Pos.x, Config.Zones.Job3.Pos.y, Config.Zones.Job3.Pos.z)

		  SetBlipSprite (truckerblips, 477)
		  SetBlipDisplay(truckerblips, 4)
		  SetBlipScale  (truckerblips, 1.0)
		  SetBlipColour (truckerblips, 5)
		  SetBlipAsShortRange(truckerblips, true)

		  SetBlipSprite (truckerblips2, 477)
		  SetBlipDisplay(truckerblips2, 4)
		  SetBlipScale  (truckerblips2, 0.6)
		  SetBlipColour (truckerblips2, 5)
		  SetBlipAsShortRange(truckerblips2, true)

		  SetBlipSprite (truckerblips3, 477)
		  SetBlipDisplay(truckerblips3, 4)
		  SetBlipScale  (truckerblips3, 0.6)
		  SetBlipColour (truckerblips3, 5)
		  SetBlipAsShortRange(truckerblips3, true)

		  SetBlipSprite (truckerblips4, 477)
		  SetBlipDisplay(truckerblips4, 4)
		  SetBlipScale  (truckerblips4, 0.6)
		  SetBlipColour (truckerblips4, 5)
		  SetBlipAsShortRange(truckerblips4, true)
		
		  BeginTextCommandSetBlipName("STRING")
		  AddTextComponentSubstringPlayerName('Siedziba Truckerow')
		  EndTextCommandSetBlipName(truckerblips)
		  table.insert(truckerBlips, truckerblips)

		  BeginTextCommandSetBlipName("STRING")
		  AddTextComponentSubstringPlayerName('Szatnia')
		  EndTextCommandSetBlipName(truckerblips2)
		  table.insert(truckerBlips, truckerblips2)

		  BeginTextCommandSetBlipName("STRING")
		  AddTextComponentSubstringPlayerName('Pobór pojazdu')
		  EndTextCommandSetBlipName(truckerblips3)
		  table.insert(truckerBlips, truckerblips3)

		  BeginTextCommandSetBlipName("STRING")
		  AddTextComponentSubstringPlayerName('Utylizacja naczep')
		  EndTextCommandSetBlipName(truckerblips4)
		  table.insert(truckerBlips, truckerblips4)
	else
		local blippos = {x = 143.86, y = -3111.27, z = 5.89}
		local truckerblips = AddBlipForCoord(blippos.x, blippos.y, blippos.z)
		
		  SetBlipSprite (truckerblips, 477)
		  SetBlipDisplay(truckerblips, 4)
		  SetBlipScale  (truckerblips, 1.0)
		  SetBlipColour (truckerblips, 5)
		  SetBlipAsShortRange(truckerblips, true)

		  BeginTextCommandSetBlipName("STRING")
		  AddTextComponentSubstringPlayerName('Siedziba Truckerow')
		  EndTextCommandSetBlipName(truckerblips)
		  table.insert(truckerBlips, truckerblips)
	end
end]]

--[[function removeTruckerBlips()
    if truckerBlips[1] ~= nil then
        for i=1, #truckerBlips, 1 do
            RemoveBlip(truckerBlips[i])
            truckerBlips[i] = nil
        end
    end
end]]

--[[function clothesCheck()
if ESX.PlayerData.job then
    if ESX.PlayerData.job.grade == 0 then
        one = tonumber(15)
        two = tonumber(6)
        three = tonumber(16)
    elseif ESX.PlayerData.job.grade == 1 then 
        one = tonumber(15)
        two = tonumber(6)
        three = tonumber(16)
    elseif ESX.PlayerData.job.grade == 2 then 
        one = tonumber(15)
        two = tonumber(6)
        three = tonumber(16)
    elseif ESX.PlayerData.job.grade == 3 then 
        one = tonumber(15)
        two = tonumber(6)
        three = tonumber(16)
    elseif ESX.PlayerData.job.grade == 4 then 
        one = tonumber(15)
        two = tonumber(6)
        three = tonumber(16)
    end
end
  TriggerEvent('update:numbers', one, two, three)
  Wait(100)
    TriggerEvent('skinchanger:clothes', function(have)
        if have then
          jobClothes = true
        else
          jobClothes = false
        end
    end)
  if jobClothes then
    return true
  else
    return false
  end
end]]

--RegisterNetEvent('esx_phone:loaded')
--AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
--	local specialContact = {
--		name       = _U('phone_taxi'),
--		number     = 'trucker',
--		base64Icon = 'data:image/png;base64,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',
--	}
--
--	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
--end)

-- Enter / Exit marker events, and draw markers
--[[Citizen.CreateThread(function()
	mainblip()
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
				TriggerEvent('esx_trucker:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_trucker:hasExitedMarker', LastZone)
			end
		else
			Citizen.Wait(1000)
		end
	end
end)]]