ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local working = false
local workCoords = {x = -1850.04, y = -1250.68, z = 8.61}
local sucess = false
local fail = false

RegisterNetEvent('fishing:start')
AddEventHandler('fishing:start', function()
	if not working then 
		DisplayHelpText('Nacisnij ~b~E ~w~aby zacząć łowienie')
		TriggerEvent('fishing:working')
	end
end)

RegisterCommand("fishing", function(source, args)
	if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), workCoords.x, workCoords.y, workCoords.z, true) < 2.0 then
		TriggerEvent('fishing:start')
	end
end, false)

RegisterNetEvent('fishing:working')
AddEventHandler('fishing:working', function()
    working = true
    while working do 
    Citizen.Wait(0)
    	if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), workCoords.x, workCoords.y, workCoords.z, true) < 1.0 then
    		if IsControlJustReleased(0, 38) then
    			TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_STAND_FISHING', 0, true)
    			random()
    			working = false
    		end
    	end
    end
end)

RegisterNetEvent('fishing:sucess')
AddEventHandler('fishing:sucess', function()
	sucess = true
	clicks = 0
    DisplayHelpText('Naciskaj ~b~E ~w~aby wyciągnąć zdobycz')
	while sucess do
	Citizen.Wait(0)
		if IsControlJustReleased(0, 38) then
			clicks = clicks + 1
			if clicks > math.random(10) then
				print('sucess')
				if clicks >= 7 then
					TriggerServerEvent('fishing:giveitem', 3)
				else 
					TriggerServerEvent('fishing:giveitem', 1)
				end
				random()
				sucess = false
			end
		end
	end
end)

RegisterNetEvent('fishing:fail')
AddEventHandler('fishing:fail', function()
	fail = true
	clicks = 0
	DisplayHelpText('Naciskaj ~b~E ~w~aby wyciągnąć zdobycz')
	while fail do
	Citizen.Wait(0)
		if IsControlJustReleased(0, 38) then
			clicks = clicks + 1
			if clicks > math.random(10) then
				print('fail')
				ClearPedTasks(PlayerPedId())
				fail = false
			end
		end
	end
end)

function random()
	local chance = math.random(10)
	Wait(2500)
	if chance <= 5 then
		TriggerEvent('fishing:sucess')
	elseif chance > 5 then
		TriggerEvent('fishing:fail')
	end
end

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 0, -1)
end