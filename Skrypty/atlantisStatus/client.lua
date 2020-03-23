ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)



-- Przykładowe użycie z callbackiem
local statusSpoleczny = 0
RegisterNetEvent("atlantisStatus:show")
AddEventHandler("atlantisStatus:show", function()

    ESX.TriggerServerCallback('atlantisStatus:get', function(status)
        statusSpoleczny = status
    end)
    Citizen.Wait(100)
    print("Status:" .. tostring(statusSpoleczny))
end)

--[[

##### Przykładowe pobranie z callbackiem:

[...]
ESX.TriggerServerCallback('atlantisStatus:get', function(status)
        statusSpoleczny = status
end)
Citizen.Wait(200) -- czekamy 200ms zeby Callback Ustawil zmienna glabalna
[...]

##### Przykładowe dodanie i zabranie karmy:

TriggerServerEvent('atlantisStatus:add', 200) 			- dodanie 200 karmy
TriggerServerEvent('atlantisStatus:remove', 200)		- zabranie 200 karmy


]]--