ESX                           = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local lombardNPC = 0
local inlombardmenu = false

Citizen.CreateThread(function()

  RequestModel(GetHashKey("ig_chengsr"))
  while not HasModelLoaded(GetHashKey("ig_chengsr")) do
    Wait(1)
  end

  RequestAnimDict("mini@strip_club@idles@bouncer@base")
  while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
    Wait(1)
  end
    lombardNPC =  CreatePed(4, "ig_chengsr", -62.48, -1290.84, 30.0, 100.00, false, true)
    Wait(1000)
    SetEntityHeading(lombardNPC, 282.00)
    FreezeEntityPosition(lombardNPC, true)
	SetEntityInvincible(lombardNPC, true)
	SetBlockingOfNonTemporaryEvents(lombardNPC, true)
    TaskPlayAnim(lombardNPC,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000) 
        if inlombardmenu then
            if GetDistanceBetweenCoords(-62.48, -1290.84, 30.89, GetEntityCoords(PlayerPedId()), true) > 1 then
                ESX.UI.Menu.CloseAll()
                inlombardmenu = false
            end
        end
    end
end)
  

RegisterNetEvent('lombard:open')
AddEventHandler('lombard:open', function()
    if DoesEntityExist(lombardNPC) then
	    openLombardMenu()
        inlombardmenu = true
    else
        TriggerEvent("pNotify:SendNotification", {text = "Nie widać szefa w pobliżu.", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
    end
end)

function openLombardMenu()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'lombard_menu',
    {
        title    = 'Lombard',
        align    = 'right',
        elements = {
            {label = 'Sprzedaj', value = 'sell'},
            {label = 'Kup', value = 'buy'},
            {label = 'Wymień', value = 'exchange'},
        }
    }, function(data, menu)

            local action = data.current.value

            if action == 'sell' then
            	Sellmenu()
            elseif action == 'buy' then
            	Buymenu()
            elseif action == 'exchange' then
				Exchangemenu()
            end
    end, function(data, menu)
        menu.close()
    end)
end

function Sellmenu()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'lombard_sell',
    {
        title    = 'Sprzedaj',
        align    = 'right',
        elements = {
            {label = "Zestaw naprawczy do pojazdu <span style='color:green;'>80$", value = 'sell1'},
            {label = "Wytrych <span style='color:green;'>80$", value = 'sell2'},
            {label = "Telefon <span style='color:green;'>100$", value = 'sell3'},
            {label = "Lornetka <span style='color:green;'>100$", value = 'sell4'},
            {label = "Kajdanki <span style='color:green;'>200$", value = 'sell5'},
        }
    }, function(data, menu)

            local action = data.current.value

            if action == 'sell1' then
                TriggerServerEvent('lombard:sell', 'fixkit', 80)
            elseif action == 'sell2' then
                TriggerServerEvent('lombard:sell', 'blowpipe', 80)
            elseif action == 'sell3' then
                TriggerServerEvent('lombard:sell', 'phone', 100)
            elseif action == 'sell4' then
                TriggerServerEvent('lombard:sell', 'jumelles', 100)
            elseif action == 'sell5' then
                TriggerServerEvent('lombard:sell', 'handcuffs', 200)
            end
    end, function(data, menu)
        menu.close()
    end)
end

function Buymenu()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'lombard_buy',
    {
        title    = 'Kup',
        align    = 'right',
        elements = {
            {label = "Telefon <span style='color:red;'>200$", value = 'buy1'},
        }
    }, function(data, menu)

            local action = data.current.value

            if action == 'buy1' then
                TriggerServerEvent('lombard:buy', 'burner', 200)
            end
    end, function(data, menu)
        menu.close()
    end)
end

function Exchangemenu()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'lombard_exchange',
    {
        title    = 'Wymiana',
        align    = 'right',
        elements = {
            {label = "Wymiana gotówki <span style='color:red;'>(WYSOKA PROWIZJA)", value = 'exchange1'},
            --[[{label = '2', value = 'exchange2'},
            {label = '3', value = 'exchange3'},]]
        }
    }, function(data, menu)

            local action = data.current.value

            if action == 'exchange1' then
                TriggerServerEvent('lombard:cashexchange', 2000)
            elseif action == 'exchange2' then

            elseif action == 'exchange3' then

            end
    end, function(data, menu)
        menu.close()
    end)
end

function removeLombardNPC()
    DeleteEntity(lombardNPC)
    NPC = 0 
end
