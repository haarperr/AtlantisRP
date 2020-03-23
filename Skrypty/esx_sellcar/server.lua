ESX               = nil
local cars 		  = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_sellcar:requestPlayerCars', function(source, cb, plate)

	local xPlayer = ESX.GetPlayerFromId(source)
--SELECT owner,vehicle FROM vehicles_garage WHERE JSON_EXTRACT(vehicle, "$.Plate") = @plate LIMIT 1
	MySQL.Async.fetchAll(
		'SELECT * FROM vehicles_garage WHERE owner = @identifier', 
		{
			['@identifier'] = xPlayer.identifier
		},
		function(result)

			local found = false

			for i=1, #result, 1 do

				local vehicleProps = json.decode(result[i].vehicle)
				--print(plate .. vehicleProps.plate)
				
				local test = tostring(vehicleProps.Plate)
				local test2 = tostring(plate)
				
				if (test == test2) then
					found = true
					break
				end
				
			end

			if found then
				cb(true)
			else
				cb(false)
			end

		end
	)
end)
RegisterServerEvent('esx_sellcar:setVehicleOwnedPlayerIdAsk')
AddEventHandler('esx_sellcar:setVehicleOwnedPlayerIdAsk', function (playerId, vehicleProps, price)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	TriggerClientEvent('esx_sellcar:Ask', playerId, vehicleProps.plate, price)

	 
end)
RegisterServerEvent('esx_sellcar:CancelOffer')
AddEventHandler('esx_sellcar:CancelOffer', function (playerId)
	TriggerClientEvent('esx:showNotification', playerId, 'Oferta odrzucona')
end)
RegisterServerEvent('esx_sellcar:setVehicleOwnedPlayerId')
AddEventHandler('esx_sellcar:setVehicleOwnedPlayerId', function (playerId, vehicleProps, price, zplayer)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	local zPlayer = ESX.GetPlayerFromId(zplayer)
	print( price )
	xPlayer.removeAccountMoney('bank', price)
	zPlayer.addAccountMoney('bank', price)
	MySQL.Async.execute('UPDATE vehicles_garage SET owner=@owner WHERE JSON_EXTRACT(vehicle, "$.Plate") = @plate',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps
	},
	
	function (rowsChanged)
		TriggerClientEvent('esx:showNotification', playerId, 'Kupiłeś nowe auto: ~g~' ..vehicleProps..'!', vehicleProps)
		TriggerClientEvent('esx:showNotification', zplayer, 'Auto sprzedane: ~g~' ..vehicleProps..'!', vehicleProps)
		TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: esx_sellcar:setVehicleOwnedPlayerId , kupno auta "..xPlayer.name.." kupil auto "..vehicleProps.." od "..zPlayer.name.." za "..price)
	end) 
end)

TriggerEvent('es:addGroupCommand', 'sprzedaj', 'user', function(source, args, user)
	local price = tonumber(args[1])
	TriggerClientEvent('esx_sellcar:Sell', source, price)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'ERROR - Check codeina.pro for information.' } })
end)
ESX.RegisterServerCallback('esx_sellcar:checkMoney', function(source, cb, playerId, price)
  local xPlayer = ESX.GetPlayerFromId(playerId)
  local bank = xPlayer.getAccount('bank').money
  local _price = tonumber(price)
  if bank >= price then
  	cb(true)
  else
  	cb(false)
  	TriggerClientEvent('esx:showNotification', playerId, 'Nie posiadasz tyle pieniędzy w banku')
  end
end)