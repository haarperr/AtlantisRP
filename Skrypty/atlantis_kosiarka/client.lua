ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local working = false
local doneMeters = 0
local seconds = 0 
local workCoords = {x = -1152.42, y = 15.83, z = 49.94}

RegisterNetEvent('kosiarka:start')
AddEventHandler('kosiarka:start', function()
	if not working then 
		TriggerEvent('kosiarka:working')
	end
end)

RegisterCommand("kosiarka", function(source, args)
	if carcheck() then
    	if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), workCoords.x, workCoords.y, workCoords.z, true) < 250.0 then
  			TriggerEvent('kosiarka:start')
  		end
  	end
end, false)

RegisterNetEvent('kosiarka:working')
AddEventHandler('kosiarka:working', function()
    working = true
    while working do 
    Citizen.Wait(0)
    	if carcheck() then
    		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), workCoords.x, workCoords.y, workCoords.z, true) < 250.0 then
    			if GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) > 2 and GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) < 10 then
    				Wait(1000)
    				seconds = seconds + 1
    					if seconds == 10 then
    						seconds = 0
    						doneMeters = doneMeters + 1
    					end
    					if doneMeters == 10 then
    						TriggerEvent('show:money', 3)
    						TriggerServerEvent('kosiarka:pay')
    						doneMeters = 0 
    					end 
    			end
    		end
    	else 
    		working = false 
    	end
    end
end)

function carcheck()
	local currentcar = GetVehiclePedIsIn(PlayerPedId(), false)
	local currentcarmodel = GetEntityModel(currentcar)
	if currentcarmodel == GetHashKey('mower') then
		return true
	else 
		return false
	end
end