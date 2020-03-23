ESX                     = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)
-- CLIENTSIDED

-- Registers a network event
RegisterNetEvent('EngineToggle:Engine')
RegisterNetEvent('EngineToggle:RPDamage')
RegisterNetEvent('EngineToggle:canDrive')
local vehicles = {}; RPWorking = true
local canDrive = true
local healthMax = 100.0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if UseKey and ToggleKey then
			if IsControlJustReleased(1, ToggleKey) then
				TriggerEvent('EngineToggle:Engine')
			end
		end
		if GetSeatPedIsTryingToEnter(GetPlayerPed(-1)) == -1 and not table.contains(vehicles, GetVehiclePedIsTryingToEnter(GetPlayerPed(-1))) then
			table.insert(vehicles, {GetVehiclePedIsTryingToEnter(GetPlayerPed(-1)), IsVehicleEngineOn(GetVehiclePedIsTryingToEnter(GetPlayerPed(-1)))})
		elseif IsPedInAnyVehicle(GetPlayerPed(-1), false) and not table.contains(vehicles, GetVehiclePedIsIn(GetPlayerPed(-1), false)) then
			table.insert(vehicles, {GetVehiclePedIsIn(GetPlayerPed(-1), false), IsVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false))})
		end
		if  GetVehicleEngineHealth(GetVehiclePedIsIn(GetPlayerPed(-1))) <= healthMax then
			canDrive = false
		elseif GetVehicleEngineHealth(GetVehiclePedIsIn(GetPlayerPed(-1))) > healthMax then
			canDrive = true
		end
		for i, vehicle in ipairs(vehicles) do
			if DoesEntityExist(vehicle[1]) then
				if (GetPedInVehicleSeat(vehicle[1], -1) == GetPlayerPed(-1)) or IsVehicleSeatFree(vehicle[1], -1) then
					if RPWorking and canDrive then
							SetVehicleEngineOn(vehicle[1], vehicle[2], false, false)
							SetVehicleJetEngineOn(vehicle[1], vehicle[2])
							if not IsPedInAnyVehicle(GetPlayerPed(-1), false) or (IsPedInAnyVehicle(GetPlayerPed(-1), false) and vehicle[1]~= GetVehiclePedIsIn(GetPlayerPed(-1), false)) then
								if IsThisModelAHeli(GetEntityModel(vehicle[1])) or IsThisModelAPlane(GetEntityModel(vehicle[1])) then
									if vehicle[2] then
										SetHeliBladesFullSpeed(vehicle[1])
									end
								end
							end

					end
				end
			else
				table.remove(vehicles, i)
			end
		end
		if IsControlJustReleased(0, 311) then
				if not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'carinteraction_menu') then
					local bliskieauto = isPlayerCloseToCar()
						if bliskieauto ~= 0 then
							CarInteractionMenu()
						elseif IsPedInAnyVehicle(PlayerPedId(), false) then
							CarInteractionMenu()
						end
					else
						ESX.UI.Menu.CloseAll()
				end
		end
	end
end)



AddEventHandler('EngineToggle:Engine', function()
	local veh
	local StateIndex
	for i, vehicle in ipairs(vehicles) do
		if vehicle[1] == GetVehiclePedIsIn(GetPlayerPed(-1), false) then
			veh = vehicle[1]
			StateIndex = i
		end
	end
	Citizen.Wait(750)
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1)) then
			vehicles[StateIndex][2] = not GetIsVehicleEngineRunning(veh)
			if vehicles[StateIndex][2] then
				if canDrive then
					DisplayAdvancedNotification("CHAR_LESTER", 140, "Some Subtitle", "Silnik włączony")
				else
					DisplayAdvancedNotification("CHAR_LESTER", 6, "Some Subtitle", "Silnik uszkodzony")
				end

			else
				DisplayAdvancedNotification("CHAR_LESTER", 140, "Some Subtitle", "Silnik wyłączony")
			end
		end
    end
end)

AddEventHandler('EngineToggle:RPDamage', function(State)
	RPWorking = State
end)

AddEventHandler('EngineToggle:FixEngine', function(cveh)
    local veh = nil
    local StateIndex
    
    for i, vehicle in ipairs(vehicles) do
    
        --print("[".. i .."] Veh: "..cveh .." | ".. vehicle[1])
        
        if vehicle[1] == cveh then
            veh = vehicle[1]
            StateIndex = i
        end
    end
    Citizen.Wait(100)
    if(veh ~= nil) then
    --if IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
        --if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1)) then
            --SetVehicleFixed(veh)
            --SetVehicleDeformationFixed(veh)
            
            Citizen.Wait(1500)
            vehicles[StateIndex][2] = false
            vehicles[StateIndex][3] = false
            ClearPedTasksImmediately(GetPlayerPed(-1))
            
        --end 
    --else
        --TriggerEvent("chatMessage", "", {255,0,0}, "Musisz byc w pojeździe aby użyć tej komendy!")
    --end 
    end
end)

function table.contains(table, element)
  for _, value in pairs(table) do
    if value[1] == element then
      return true
    end
  end
  return false
end


function DisplayAdvancedNotification(icon, title, subtitle, text)
	SetNotificationBackgroundColor(title)
	SetNotificationTextEntry("STRING")
	AddTextComponentSubstringPlayerName(text)
	--SetNotificationMessage(icon, icon, false, 3, title, subtitle)
	DrawNotification(false, false)
end
--------------------------------MENU DRZWI POJAZDU--------------------------------------------


function CarInteractionMenu()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'carinteraction_menu',
    {
        title    = 'Menu pojazdu',
        align    = 'right',
        elements = {
			{label = 'Zmień miejsce w pojeździe', value = 'seats'},
            {label = 'Otwórz / zamknij maskę', value = 'hood'},
            {label = 'Otwórz / zamknij drzwi', value = 'doors'},
            {label = 'Otwórz / zamknij bagażnik', value = 'trunk'},
            {label = 'Wejdź do bagażnika', value = 'hideintrunk'},
        }
    }, function(data, menu)

            local action = data.current.value

            if action == 'hood' then
            	OpenHood()
            elseif action == 'trunk' then
            	OpenTrunk()
            elseif action == 'doors' then
				CarDoorsMenu()
			elseif action == 'seats' then
				CarSeatsMenu()
			elseif action == 'hideintrunk' then
				TriggerEvent('hidein:trunk_enter')
            end
    end, function(data, menu)
        menu.close()
    end)
end

function CarDoorsMenu()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'car_doors_menu',
    {
        title    = 'Menu pojazdu',
        align    = 'right',
        elements = {
            {label = 'Lewy przód', value = 'left1'},
            {label = 'Prawy przód', value = 'right1'},
            {label = 'Lewy tył', value = 'left2'},
            {label = 'Prawy tył', value = 'right2'},
            {label = 'Zamknij wszystkie drzwi', value = 'closeall'},
        }
    }, function(data, menu)

            local action = data.current.value

		if data.current.value == 'left1' then
			OpenLeft1()
		elseif data.current.value == 'right1' then
			OpenRight1()
		elseif data.current.value == 'left2' then
			OpenLeft2()
		elseif data.current.value == 'right2' then
			OpenRight2()
		elseif data.current.value == 'closeall' then
			CloseAll()
		end
    end, function(data, menu)
        menu.close()
    end)
end

function CarSeatsMenu()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'car_seats_menu',
    {
        title    = 'Przesiadka',
        align    = 'right',
        elements = {
            {label = 'Lewy przód', value = 'seatleft1'},
            {label = 'Prawy przód', value = 'seatright1'},
            {label = 'Lewy tył', value = 'seatleft2'},
            {label = 'Prawy tył', value = 'seatright2'},
        }
    }, function(data, menu)

            local action = data.current.value

		if data.current.value == 'seatleft1' then
			changeseat(-1)
		elseif data.current.value == 'seatright1' then
			changeseat(0)
		elseif data.current.value == 'seatleft2' then
			changeseat(1)
		elseif data.current.value == 'seatright2' then
			changeseat(2)
		end
    end, function(data, menu)
        menu.close()
    end)
end

function OpenHood()
	local inveh = GetVehiclePedIsIn(PlayerPedId(), false)
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)
	local locked = GetVehicleDoorLockStatus(closecar)
		if locked == 1 or class == 15 or class == 16 or class == 14 then
			if GetVehicleDoorAngleRatio(closecar, 4) > 0 then
					SetVehicleDoorShut(closecar, 4, false)
			else
					SetVehicleDoorOpen(closecar, 4, false, false)
			end
		else
			if GetVehicleDoorAngleRatio(inveh, 4) > 0 then
					SetVehicleDoorShut(inveh, 4, false)
			else
					SetVehicleDoorOpen(inveh, 4, false, false)
			end
		end
end

function OpenTrunk()
	local inveh = GetVehiclePedIsIn(PlayerPedId(), false)
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)
	local locked = GetVehicleDoorLockStatus(closecar)
		if locked == 1 or class == 15 or class == 16 or class == 14 then
			if GetVehicleDoorAngleRatio(closecar, 5) > 0 then
					SetVehicleDoorShut(closecar, 5, false)
			else
					SetVehicleDoorOpen(closecar, 5, false, false)
			end
		else
			if GetVehicleDoorAngleRatio(inveh, 5) > 0 then
					SetVehicleDoorShut(inveh, 5, false)
			else
					SetVehicleDoorOpen(inveh, 5, false, false)
			end
		end
end

function OpenLeft1()
	local inveh = GetVehiclePedIsIn(PlayerPedId(), false)
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)
	local locked = GetVehicleDoorLockStatus(closecar)
		if locked == 1 or class == 15 or class == 16 or class == 14 then
			if GetVehicleDoorAngleRatio(closecar, 0) > 0 then
					SetVehicleDoorShut(closecar, 0, false)
			else
					SetVehicleDoorOpen(closecar, 0, false, false)
			end
		else
			if GetVehicleDoorAngleRatio(inveh, 0) > 0 then
					SetVehicleDoorShut(inveh, 0, false)
			else
					SetVehicleDoorOpen(inveh, 0, false, false)
			end
		end
end

function OpenRight1()
	local inveh = GetVehiclePedIsIn(PlayerPedId(), false)
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)
	local locked = GetVehicleDoorLockStatus(closecar)
		if locked == 1 or class == 15 or class == 16 or class == 14 then
			if GetVehicleDoorAngleRatio(closecar, 1) > 0 then
					SetVehicleDoorShut(closecar, 1, false)
			else
					SetVehicleDoorOpen(closecar, 1, false, false)
			end
		else
			if GetVehicleDoorAngleRatio(inveh, 1) > 0 then
					SetVehicleDoorShut(inveh, 1, false)
			else
					SetVehicleDoorOpen(inveh, 1, false, false)
			end
		end
end

function OpenLeft2()
	local inveh = GetVehiclePedIsIn(PlayerPedId(), false)
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)
	local locked = GetVehicleDoorLockStatus(closecar)
		if locked == 1 or class == 15 or class == 16 or class == 14 then
			if GetVehicleDoorAngleRatio(closecar, 2) > 0 then
					SetVehicleDoorShut(closecar, 2, false)
			else
					SetVehicleDoorOpen(closecar, 2, false, false)
			end
		else
			if GetVehicleDoorAngleRatio(inveh, 2) > 0 then
					SetVehicleDoorShut(inveh, 2, false)
			else
					SetVehicleDoorOpen(inveh, 2, false, false)
			end
		end
end

function OpenRight2()
	local inveh = GetVehiclePedIsIn(PlayerPedId(), false)
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)
	local locked = GetVehicleDoorLockStatus(closecar)
		if locked == 1 or class == 15 or class == 16 or class == 14 then
			if GetVehicleDoorAngleRatio(closecar, 3) > 0 then
					SetVehicleDoorShut(closecar, 3, false)
			else
					SetVehicleDoorOpen(closecar, 3, false, false)
			end
		else
			if GetVehicleDoorAngleRatio(inveh, 3) > 0 then
					SetVehicleDoorShut(inveh, 3, false)
			else
					SetVehicleDoorOpen(inveh, 3, false, false)
			end
		end
end

function CloseAll()
	local vehFront = VehicleInFront()
	local inveh = GetVehiclePedIsIn(PlayerPedId(), false)
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)
	local locked = GetVehicleDoorLockStatus(closecar)
		if locked == 1 or class == 15 or class == 16 or class == 14 then
				SetVehicleDoorsShut(closecar, false)
		else
			SetVehicleDoorsShut(inveh, false)
		end
end

local changing = false
function changeseat(seat)
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		local car = GetVehiclePedIsIn(PlayerPedId(), false)
		if IsVehicleStopped(car) and not changing then
			TriggerEvent("pNotify:SendNotification", {text = "Przesiadasz się...", type = "atlantisOk",queue = "global",timeout = 3000,layout = "atlantis"})
			changing = true
			Wait(3000)
			if IsVehicleStopped(car) then
				TaskWarpPedIntoVehicle(PlayerPedId(), car, seat)
			end
			Wait(1000)
			changing = false
		end
	end
end

function VehicleInFront()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 4.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
    local a, b, c, d, result = GetRaycastResult(rayHandle)
    return result
end

function isPlayerCloseToCar()
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local plyOffset = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.0, 0.0)
	local radius = 0.5
	local rayHandle = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, radius, 10, plyPed, 5)
	local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
	return vehicle
end
