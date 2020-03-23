ESX                           = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('drugtest:givetester')
AddEventHandler('drugtest:givetester', function()
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job.name == 'police' then
		TriggerServerEvent('drugtest:giveitem')
	end
end)

RegisterNetEvent('drugtest:usetester')
AddEventHandler('drugtest:usetester', function()
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job.name == 'police' then
		TriggerServerEvent('drugtest:removetestitem')
	end
end)

RegisterNetEvent('drugtest:dotest')
AddEventHandler('drugtest:dotest', function(drugname)
	local _drugname = drugname
	playAnim('mp_common', 'givetake2_b')
	Wait(1500)
	playAnim('anim@heists@prison_heistig1_p1_guard_checks_bus', 'loop')
    TriggerEvent('3d:procentbar', 45, 'Sprawdzasz nasiono.')
	Wait(6000)
	ClearPedTasks(PlayerPedId())
	playAnim('anim@heists@prison_heistig1_p1_guard_checks_bus', 'loop')
	TriggerEvent('3d:procentbar', 45, 'Wysylasz wyniki do laboratorium.')
	Wait(6000)
	ClearPedTasks(PlayerPedId())
	TriggerEvent("pNotify:SendNotification", {text = "Wyniki otrzymasz do 2 minut.", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
	testresult(_drugname)
end)

function testresult(name)
	local waitrandom = math.random(60000,90000)
	local chancerandom = math.random(0,100)
	Wait(waitrandom)
	if chancerandom <= 25 then
		TriggerEvent("pNotify:SendNotification", {text = "Test pozytywny, nasiona pochodza od "..name, type = "atlantis", queue = "global", timeout = 15000, layout = "atlantis"})
	elseif chancerandom > 25 and chancerandom <= 50 then
		TriggerEvent("pNotify:SendNotification", {text = "Nie jesteśmy pewni ale, nasiona mogą pochodzić od rzadkiego gatunku Cardiospermum halicacabum", type = "atlantis", queue = "global", timeout = 10000, layout = "atlantis"})
	elseif chancerandom > 50 and chancerandom <= 75 then
		TriggerEvent("pNotify:SendNotification", {text = "Nie jesteśmy w stanie określić jakiego pochodzenia są nasioa.", type = "atlantis", queue = "global", timeout = 10000, layout = "atlantis"})
	elseif chancerandom > 75 and chancerandom <= 100 then
		TriggerEvent("pNotify:SendNotification", {text = "Tester lub nasiona były uszkodzone nie jesteśmy wstanie wygenerować wyniku.", type = "atlantis", queue = "global", timeout = 10000, layout = "atlantis"})
	end 
end

function playAnim(animdict, animname)
    local ad = animdict
    local anim = animname
    local player = PlayerPedId()


    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, anim, 8 ) ) then
            TaskPlayAnim( player, ad, "exit", 8.0, 8.0, 1.0, 50, 1, 0, 0, 0 )
            ClearPedSecondaryTask(player)
        else
            SetCurrentPedWeapon( player, GetHashKey("WEAPON_UNARMED"), equipNow)
	        Citizen.Wait(50)
            TaskPlayAnim( player, ad, anim, 8.0, 8.0, 1.0, 50, 1, 0, 0, 0 )
        end
    end
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end
