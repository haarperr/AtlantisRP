ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],	
			sex = identity['sex'],
			height = identity['height'],
			job = identity['job'],
			ubezpieczenie = identity['ubezpieczenie']
		}
	else
		return nil
	end
end

local DiscordWebHook = ""

--Send the message to your discord server
function sendToDiscord (name, message,color, content)
  
  -- Modify here your discordWebHook username = name, content = message,embeds = embeds
if content == nil then
  content = ""
end
local embeds = {
    {
        ["title"]=message,
        ["type"]="rich",
        ["color"] =color,
        ["footer"]=  {
            ["text"]= "",
       },
    }
}

  if message == nil or message == '' then return FALSE end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name, content = content, embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

TriggerEvent('es:addCommand', 'aiadcar', function(source, args, user)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local identifier = GetPlayerIdentifiers(_source)[1]
	local _args = args[1]
    

	if identifier == "steam:x" or identifier == "steam:x" or identifier == "steam:x" or identifier == "steam:x" or identifier ==  "steam:x" or identifier == "steam:x" then
		if _args == 'suv' then
        	TriggerClientEvent('AIAD:spawnVehicle', _source, 'apoliceu4')
		elseif _args == 'sedan' then
			TriggerClientEvent('AIAD:spawnVehicle', _source, 'apoliceu9')
		elseif _args == 'schowaj' then
			TriggerClientEvent('AIAD:hideVehicle', _source)
		end
	end
end)

TriggerEvent('es:addCommand', 'aiadjob', function(source, args, user)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local identifier = GetPlayerIdentifiers(_source)[1]
	local _args = args[1]
    

	if identifier == "steam:X" then
		if _args == 'on' then
        	xPlayer.setJob('police', 15)
		elseif _args == 'off' then
			xPlayer.setJob('police', 8)
		end
	elseif identifier == "steam:X" then
		if _args == 'on' then
        	xPlayer.setJob('police', 15)
		elseif _args == 'off' then
			xPlayer.setJob('police', 1)
		end
	end
end)

RegisterServerEvent('odholowanko:wpierdoldobunkra')
AddEventHandler('odholowanko:wpierdoldobunkra', function(plate)
	local _plate = plate
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local _state = 0

	if xPlayer.job.name == "police" then
		_state = 2
	elseif xPlayer.job.name == "mechanic" then
		_state = 0
	--elseif xPlayer.job.name == "lostmechanic" then
		--_state = 0
	end
	MySQL.Async.fetchAll('SELECT * FROM vehicles_garage WHERE plate = @plate', {
                ['@plate'] = _plate
        }, function(result)
                if result[1] ~= nil then
                        MySQL.Async.execute("UPDATE vehicles_garage  SET state = @state WHERE plate = @plate", {['@plate'] = _plate, ['@state'] = _state}) 
						TriggerClientEvent("pNotify:SendNotification", _source, {text = "Henry potwierdza odbiór pojazdu.", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})                     
                end
    end)
end)

RegisterServerEvent('mechanic:check')
AddEventHandler('mechanic:check', function()
local mechanicCount = 0
local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'mechanic' then
            mechanicCount = mechanicCount + 1
        end
    end
  	if mechanicCount == 0 then
   		TriggerClientEvent('police:odholuj', source)
   	else
   		TriggerClientEvent("pNotify:SendNotification", _source, {text = "Są mechanicy na slużbie możesz ich wezwać..", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
   	end
end)

RegisterServerEvent('aiad:raport')
AddEventHandler('aiad:raport', function(message)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local name = getIdentity(_source)
	local nameone = name.firstname
	local nametwo = name.lastname


	 if xPlayer.job.name == 'police' then
		sendToDiscord (nameone.." "..nametwo, message)
	 end
end)


local cokeinshop = 30

RegisterServerEvent('cokeshop:buycoke')
AddEventHandler('cokeshop:buycoke', function(itemname, price, amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local item = xPlayer.getInventoryItem(itemname)
    if cokeinshop > 0 and amount <= cokeinshop then
	    if xPlayer.getMoney() >= price and item.count == 0 then
	    	cokeinshop = cokeinshop - amount
	        xPlayer.addInventoryItem(itemname, amount)
	        xPlayer.removeMoney(price)
	        TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: cokeshop:buycoke , kupil "..itemname..' za '..price..' ilosc '..amount..' w sklepie zostalo '..cokeinshop)
	    end
	else
   		TriggerClientEvent("pNotify:SendNotification", _source, {text = "Jestem pusty. Wróć za jakiś czas.", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3600000)
		if cokeinshop <= 120 then
			cokeinshop = cokeinshop + 15
			--print(cokeinshop)
		end
	end
end)

RegisterCommand('kickall', function(source, args)
    if source ~= 0 then
    	--print('uzycie komendy')
    else
		TriggerClientEvent('kickForRestartC', -1)
    end
end)

RegisterServerEvent("kickForRestart")
AddEventHandler("kickForRestart", function()
	DropPlayer(source, 'Przywracanie zasilania w toku...')
end)

TriggerEvent('es:addGroupCommand', 'forcedo', 'admin', function(source, args, user)
local msg = args
local id = args[1]
table.remove(msg, 1)
TriggerClientEvent('force:do', id, table.concat(msg, " "))
end)