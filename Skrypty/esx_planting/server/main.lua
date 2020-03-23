ESX 			    			= nil
local lastTime = nil
local Config = {}
Config.CopsOnDuty = 0
Config.CopsNeededForWeed = 3
Config.CopsNeededForCoke = 3

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterUsableItem('seed_weed', function(source)
	local _source = source
	local currentTime = os.time(os.date("!*t"))
	if lastTime and currentTime - lastTime < 10 then
		TriggerClientEvent("pNotify:SendNotification", source, {
		    text = 'Poczekaj przynajmniej 10 sekund przed ponownym rozpoczęciem tej opreacji.',
			type = "atlantis", 
			queue = "global", 
			timeout = 2000, 
			layout = "atlantis"
		})
		do return end
	end
	lastTime = os.time(os.date("!*t"))

	--Sprawdź czy jest wystarczająca liczba glin
	local xPlayers = ESX.GetPlayers()
	local cops = 0
	for i=1, #xPlayers, 1 do
	 local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
	 if xPlayer.job.name == 'police' then
					cops = cops + 1
					if cops >= Config.CopsNeededForWeed then break end
			end
	end

	if cops >= Config.CopsNeededForWeed then
		TriggerClientEvent('esx_receptury:RequestStart', _source, 'seed_weed', lastTime)
	else
		TriggerClientEvent("pNotify:SendNotification", source, {text = "Nie ma odpowiedniej ilości LSPD na służbie", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
	end
end)

ESX.RegisterUsableItem('seed_coke100', function(source)
	local _source = source
	local currentTime = os.time(os.date("!*t"))
	if lastTime and currentTime - lastTime < 10 then
		TriggerClientEvent("pNotify:SendNotification", source, {
		    text = 'Poczekaj przynajmniej 10 sekund przed ponownym rozpoczęciem tej opreacji.',
			type = "atlantis", 
			queue = "global", 
			timeout = 2000, 
			layout = "atlantis"
		})
		do return end
	end
	lastTime = os.time(os.date("!*t"))

	--Sprawdź czy jest wystarczająca liczba glin
	local xPlayers = ESX.GetPlayers()
	local cops = 0
	for i=1, #xPlayers, 1 do
	 local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
	 if xPlayer.job.name == 'police' then
					cops = cops + 1
					if cops >= Config.CopsNeededForCoke then break end
			end
	end

	if cops >= Config.CopsNeededForCoke then
		TriggerClientEvent('esx_receptury:RequestStart', _source, 'seed_coke100', lastTime)
	else
		TriggerClientEvent("pNotify:SendNotification", source, {text = "Nie ma odpowiedniej ilości LSPD na służbie", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
	end
end)

ESX.RegisterUsableItem('seed_coke90', function(source)
	local _source = source
	local currentTime = os.time(os.date("!*t"))
	if lastTime and currentTime - lastTime < 10 then
		TriggerClientEvent("pNotify:SendNotification", source, {
		    text = 'Poczekaj przynajmniej 10 sekund przed ponownym rozpoczęciem tej opreacji.',
			type = "atlantis", 
			queue = "global", 
			timeout = 2000, 
			layout = "atlantis"
		})
		do return end
	end
	lastTime = os.time(os.date("!*t"))

	--Sprawdź czy jest wystarczająca liczba glin
	local xPlayers = ESX.GetPlayers()
	local cops = 0
	for i=1, #xPlayers, 1 do
	 local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
	 if xPlayer.job.name == 'police' then
					cops = cops + 1
					if cops >= Config.CopsNeededForCoke then break end
			end
	end

	if cops >= Config.CopsNeededForCoke then
		TriggerClientEvent('esx_receptury:RequestStart', _source, 'seed_coke90', lastTime)
	else
		TriggerClientEvent("pNotify:SendNotification", source, {text = "Nie ma odpowiedniej ilości LSPD na służbie", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
	end
end)

ESX.RegisterUsableItem('seed_coke70', function(source)
	local _source = source
	local currentTime = os.time(os.date("!*t"))
	if lastTime and currentTime - lastTime < 10 then
		TriggerClientEvent("pNotify:SendNotification", source, {
		    text = 'Poczekaj przynajmniej 10 sekund przed ponownym rozpoczęciem tej opreacji.',
			type = "atlantis", 
			queue = "global", 
			timeout = 2000, 
			layout = "atlantis"
		})
		do return end
	end
	lastTime = os.time(os.date("!*t"))

	--Sprawdź czy jest wystarczająca liczba glin
	local xPlayers = ESX.GetPlayers()
	local cops = 0
	for i=1, #xPlayers, 1 do
	 local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
	 if xPlayer.job.name == 'police' then
					cops = cops + 1
					if cops >= Config.CopsNeededForCoke then break end
			end
	end

	if cops >= Config.CopsNeededForCoke then
		TriggerClientEvent('esx_receptury:RequestStart', _source, 'seed_coke70', lastTime)
	else
		TriggerClientEvent("pNotify:SendNotification", source, {text = "Nie ma odpowiedniej ilości LSPD na służbie", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
	end
end)

ESX.RegisterUsableItem('seed_sativa', function(source)
	local _source = source
	local currentTime = os.time(os.date("!*t"))
	if lastTime and currentTime - lastTime < 10 then
		TriggerClientEvent("pNotify:SendNotification", source, {
		    text = 'Poczekaj przynajmniej 10 sekund przed ponownym rozpoczęciem tej opreacji.',
			type = "atlantis", 
			queue = "global", 
			timeout = 2000, 
			layout = "atlantis"
		})
		do return end
	end
	lastTime = os.time(os.date("!*t"))

	--Sprawdź czy jest wystarczająca liczba glin
	local xPlayers = ESX.GetPlayers()
	local cops = 0
	for i=1, #xPlayers, 1 do
	 local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
	 if xPlayer.job.name == 'police' then
					cops = cops + 1
					if cops >= Config.CopsNeededForWeed then break end
			end
	end

	if cops >= Config.CopsNeededForWeed then
		TriggerClientEvent('esx_receptury:RequestStart', _source, 'seed_sativa', lastTime)
	else
		TriggerClientEvent("pNotify:SendNotification", source, {text = "Nie ma odpowiedniej ilości LSPD na służbie", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
	end
end)

ESX.RegisterUsableItem('seed_hybrid', function(source)
	local _source = source
	local currentTime = os.time(os.date("!*t"))
	if lastTime and currentTime - lastTime < 10 then
		TriggerClientEvent("pNotify:SendNotification", source, {
		    text = 'Poczekaj przynajmniej 10 sekund przed ponownym rozpoczęciem tej opreacji.',
			type = "atlantis", 
			queue = "global", 
			timeout = 2000, 
			layout = "atlantis"
		})
		do return end
	end
	lastTime = os.time(os.date("!*t"))

	--Sprawdź czy jest wystarczająca liczba glin
	local xPlayers = ESX.GetPlayers()
	local cops = 0
	for i=1, #xPlayers, 1 do
	 local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
	 if xPlayer.job.name == 'police' then
					cops = cops + 1
					if cops >= Config.CopsNeededForWeed then break end
			end
	end

	if cops >= Config.CopsNeededForWeed then
		TriggerClientEvent('esx_receptury:RequestStart', _source, 'seed_hybrid', lastTime)
	else
		TriggerClientEvent("pNotify:SendNotification", source, {text = "Nie ma odpowiedniej ilości LSPD na służbie", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
	end
end)


RegisterServerEvent("esx_receptury:RemoveItem")
AddEventHandler("esx_receptury:RemoveItem", function(item_name)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem(item_name, 1)
end)


RegisterServerEvent("esx_receptury:statusSuccess")
AddEventHandler("esx_receptury:statusSuccess", function(message, min, max, item)
	TriggerClientEvent('esx:showNotification', source, message)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	math.randomseed(os.time())
	local amount = math.random(min, max)
	local itemProps = xPlayer.getInventoryItem(item)
	if(itemProps.limit < itemProps.count + amount) then
		xPlayer.setInventoryItem(item, itemProps.limit)
		TriggerClientEvent("pNotify:SendNotification", source, {
		    text = 'Porzucasz część towaru, gdyż nie masz już miejsca w kieszeniach.',
			type = "atlantis", 
			queue = "global", 
			timeout = 2000, 
			layout = "atlantis"
		})
	else
		xPlayer.addInventoryItem(item, amount)
	end
end)
