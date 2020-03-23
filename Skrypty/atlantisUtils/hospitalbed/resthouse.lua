ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local resthoucedoc = nil 
local disablecontrols = false

RegisterNetEvent('resthouse:start')
AddEventHandler('resthouse:start', function()
	if IsEntityDead(PlayerPedId()) then
    	TriggerServerEvent("resthouse:checkdirtymoney", 2000)
    else
    	TriggerServerEvent("resthouse:checkdirtymoney", 500)
    end
end)

RegisterNetEvent('resthouse:heal')
AddEventHandler('resthouse:heal', function()
	if IsEntityDead(PlayerPedId()) then
		fullheal()
		TriggerServerEvent('resthouse:payforheal', 2000)
        TriggerServerEvent('atlantisStatus:remove', 25)
	else
    	RestHouseMenu()
    end	
end)

function RestHouseMenu()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'resthouse',
    {
        title    = 'Usługi weterynarskie',
        align    = 'right',
        elements = {
            {label = 'Szybkie leczenie ran', value = 'fastheal'},
        }
    }, function(data, menu)

            local action = data.current.value

            if action == 'fastheal' then
            	menu.close()
            	startHealing()
            	TriggerServerEvent('resthouse:payforheal', 500)
                TriggerServerEvent('atlantisStatus:remove', 25)
                TriggerEvent('show:money', 1.5)
                TriggerEvent("pNotify:SendNotification", {text = "Wykupiono szybkie leczenie", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
            end
    end, function(data, menu)
        menu.close()
    end)
end

function fullheal()
	TriggerEvent('esx_ambulancejob:revive')
	Wait(1000)
	--loadAnimDict('missprologueig_6')
	--TaskPlayAnim(PlayerPedId(), 'missprologueig_6', 'lying_dead_player0', 8.0, 8.0, -1, 1, 0, false, false, false)
	TriggerEvent('resthouse:controllock')
	Wait(1000)
	spawnRestHouseDoc()
	TriggerEvent('3d:procentbar', 270, 'Badanie w toku...')
	Wait(30000)
	SetEntityHealth(GetPlayerPed(-1), 200)
    ClearPedTasks(PlayerPedId())
    DeleteEntity(resthoucedoc)
    disablecontrols = false
    resthoucedoc = nil
end

function startHealing()
	spawnRestHouseDoc()
	TriggerEvent('resthouse:controllock')
	TriggerEvent('3d:procentbar', 180, 'Badanie w toku...')
	Wait(20000)
	SetEntityHealth(GetPlayerPed(-1), 200)
    ClearPedTasks(PlayerPedId())
    DeleteEntity(resthoucedoc)
    disablecontrols = false
    resthoucedoc = nil
end

function spawnRestHouseDoc()
    loadModel("S_M_M_Doctor_01")
    local playerCoords = GetEntityCoords(PlayerPedId(), false)
    resthoucedoc = CreatePed(4, "S_M_M_Doctor_01", playerCoords.x, playerCoords.y+1.5, playerCoords.z, GetEntityHeading(PlayerPedId()) + 180.0, true, true)
    TaskStartScenarioInPlace(resthoucedoc, 'WORLD_HUMAN_CLIPBOARD', 0, true)
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

RegisterNetEvent('resthouse:controllock')
AddEventHandler('resthouse:controllock', function()
    disablecontrols = true
    while disablecontrols do
    Citizen.Wait(0)
     DisableAllControlActions(0)
     EnableControlAction(0, 166, true)
     EnableControlAction(0, 249, true)
    end
end)
