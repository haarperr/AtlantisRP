ESX = nil

local quickmafs = 0
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--if Config.MaxInService ~= -1 then
	--TriggerEvent('esx_service:activateService', 'scrap', Config.MaxInService)
--end

--TriggerEvent('esx_phone:registerNumber', 'scrap', _U('scrap_client'), true, true)
TriggerEvent('esx_society:registerSociety', 'scrap', 'scrap', 'society_scrap', 'society_scrap', 'society_scrap', {type = 'public'})

RegisterServerEvent('esx_jobscrap:success')
AddEventHandler('esx_jobscrap:success', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'scrap' then
		print(('esx_jobscrap: %s attempted to trigger success!'):format(xPlayer.identifier))
		return
	end

	math.randomseed(os.time())

	local total = Config.Dniowka
	local societyAccount

	--[[if xPlayer.job.grade >= 3 then
		total = total * 2
	end]]

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_scrap', function(account)
		societyAccount = account
	end)

	if societyAccount then
		local playerMoney  = ESX.Math.Round(total / 100 * 30)
		local societyMoney = ESX.Math.Round(total / 100 * 70)

		xPlayer.addMoney(playerMoney)
		societyAccount.addMoney(societyMoney)

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned', societyMoney, playerMoney))
	else
		xPlayer.addMoney(total)
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_earned', total))
	end

end)

RegisterServerEvent('esx_jobscrap:getStockItem')
AddEventHandler('esx_jobscrap:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'scrap' then
		print(('esx_jobscrap: %s attempted to trigger getStockItem!'):format(xPlayer.identifier))
		return
	end

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_scrap', function(inventory)
		local item = inventory.getItem(itemName)
		local sourceItem = xPlayer.getInventoryItem(itemName)

		-- is there enough in the society?
		if count > 0 and item.count >= count then

			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('player_cannot_hold'))
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn', count, item.label))
			end
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end
	end)
end)

ESX.RegisterServerCallback('esx_jobscrap:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_scrap', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterServerEvent('esx_jobscrap:putStockItems')
AddEventHandler('esx_jobscrap:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'scrap' then
		print(('esx_jobscrap: %s attempted to trigger putStockItems!'):format(xPlayer.identifier))
		return
	end

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_scrap', function(inventory)
		local item = inventory.getItem(itemName)

		if item.count >= 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', count, item.label))
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

	end)

end)


ESX.RegisterServerCallback('scrap:buyJobVehicle', function(source, cb, vehicleProps, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		print(('esx_ambulancejob: %s attempted to exploit the shop! (invalid vehicle model)'):format(xPlayer.identifier))
		cb(false)
	end

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`) VALUES (@owner, @vehicle, @plate, @type, @job, @stored)', {
			['@owner'] = xPlayer.identifier,
			['@vehicle'] = json.encode(vehicleProps),
			['@plate'] = vehicleProps.plate,
			['@type'] = type,
			['@job'] = xPlayer.job.name,
			['@stored'] = true
		}, function (rowsChanged)
			cb(true)
		end)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('scrap:storeNearbyVehicle', function(source, cb, nearbyVehicles)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundPlate, foundNum

	for k,v in ipairs(nearbyVehicles) do
		local result = MySQL.Sync.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = v.plate,
			['@job'] = xPlayer.job.name
		})

		if result[1] then
			foundPlate, foundNum = result[1].plate, k
			break
		end
	end

	if not foundPlate then
		cb(false)
	else
		MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = foundPlate,
			['@job'] = xPlayer.job.name
		}, function (rowsChanged)
			if rowsChanged == 0 then
				print(('esx_ambulancejob: %s has exploited the garage!'):format(xPlayer.identifier))
				cb(false)
			else
				cb(true, foundNum)
			end
		end)
	end

end)

RegisterServerEvent('scrap:job1')
AddEventHandler('scrap:job1', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local scrap = xPlayer.getInventoryItem('scrap1')
		if scrap.count >= 40 then
			TriggerClientEvent("pNotify:SendNotification", _source, {text = "Masz juz maksymalna ilosc zlomu", type = "info", timeout = 1000, layout = "centerLeft"})
			TriggerClientEvent('zlom:toomuch', _source)
		else
			if scrap.count > 30 then
				quickmafs = math.abs(scrap.count - 40) 
				xPlayer.addInventoryItem('scrap1', quickmafs)
				TriggerClientEvent('zlom:anim', _source)
			else
				xPlayer.addInventoryItem('scrap1', 10)
				TriggerClientEvent('zlom:anim', _source)
			end
		end
end)

RegisterServerEvent('scrap:job1a')
AddEventHandler('scrap:job1a', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local scrap1a = xPlayer.getInventoryItem('scrap1')
		if scrap1a.count >= 40 then
			TriggerClientEvent("pNotify:SendNotification", _source, {text = "Masz juz maksymalna ilosc zlomu", type = "info", timeout = 1000, layout = "centerLeft"})
			TriggerClientEvent('zlom:toomuch', _source)
		else
			if scrap1a.count > 30 then
			quickmafs = math.abs(scrap1a.count - 40) 
				xPlayer.addInventoryItem('scrap1', quickmafs)
				TriggerClientEvent('zlom:anim', _source)
			else
				xPlayer.addInventoryItem('scrap1', 10)
				TriggerClientEvent('zlom:anim', _source)
			end
		end
end)

RegisterServerEvent('scrap:job1b')
AddEventHandler('scrap:job1b', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local scrap1b = xPlayer.getInventoryItem('scrap1')
		if scrap1b.count >= 40 then
			TriggerClientEvent("pNotify:SendNotification", _source, {text = "Masz juz maksymalna ilosc zlomu", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
			TriggerClientEvent('zlom:toomuch', _source)
		else
			if scrap1b.count > 30 then
			quickmafs = math.abs(scrap1b.count - 40) 
				xPlayer.addInventoryItem('scrap1', quickmafs)
				TriggerClientEvent('zlom:anim', _source)
			else
				xPlayer.addInventoryItem('scrap1', 10)
				TriggerClientEvent('zlom:anim', _source)
			end
		end
end)

RegisterServerEvent('scrap:job2')
AddEventHandler('scrap:job2', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local scrap1 = xPlayer.getInventoryItem('scrap1')
	local scrap2 = xPlayer.getInventoryItem('scrap2')

	if scrap2.count > 0 then 
		TriggerClientEvent("pNotify:SendNotification", _source, {text = "Masz już sprasowany złom który musisz oddać na bazę", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
	else
		if scrap1.count == 40 then
			xPlayer.removeInventoryItem('scrap1', 40)
			xPlayer.addInventoryItem('scrap2', 40)
		else 
			TriggerClientEvent("pNotify:SendNotification", _source, {text = "Do uruchomienia prasy potrzebujesz wiecej zlomu "..scrap1.count.."/40", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
		end
	end
end)

RegisterServerEvent('scrap:job3')
AddEventHandler('scrap:job3', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local randomnumber = math.random(1,20)
    local randomilosc = math.random(1,5)
	local gowno2 = xPlayer.getInventoryItem('scrap3').count
	local scrap2 = xPlayer.getInventoryItem('scrap2')
	local number2 = xPlayer.getInventoryItem('scrap2').count
	local aluminium_ammount = xPlayer.getInventoryItem('aluminium').count
			if number2 >= 40 then
				xPlayer.removeInventoryItem('scrap2', number2)
				xPlayer.addInventoryItem('scrapcheck', 1)
				if randomnumber >= 5 and aluminium_ammount < 50 then
					xPlayer.addInventoryItem('aluminium', 5)
				elseif randomnumber <= 2 and gowno2 <= 35 then
					xPlayer.addInventoryItem('scrap3', 5)
				end
			else
				TriggerClientEvent("pNotify:SendNotification", _source, {text = "Nie masz odpowiedniej ilosci sprasowanego zlomu. Potrzebne jest 40 sztuk", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
			end
end)

RegisterServerEvent('scrap:job4')
AddEventHandler('scrap:job4', function()
	local societyAccount

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_scrap', function(account)
        societyAccount = account
    end)

	local total = Config.Dniowka
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local scrapcheck = xPlayer.getInventoryItem('scrapcheck')
	local playerMoney  = ESX.Math.Round(total / 100 * 85)
	local societyMoney = ESX.Math.Round(total / 100 * 15)


	if scrapcheck.count > 0 then
		xPlayer.removeInventoryItem('scrapcheck', 1)
		if Config.EnablePlayerManagement then
			if societyAccount then
				xPlayer.addMoney(playerMoney)
				societyAccount.addMoney(societyMoney)
				TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: scrap:job4 , dodanie pieniedzy "..playerMoney)
			else
				xPlayer.addMoney(total)
				TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: scrap:job4 , dodanie pieniedzy "..total)
			end
		else
			xPlayer.addMoney(total)
			TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: scrap:job4 , dodanie pieniedzy "..total)
		end
	else
TriggerClientEvent("pNotify:SendNotification", _source, {text = "Nie posiadasz czeku aby pobrać dniówke", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
	end
end)

RegisterServerEvent('scrap:kara')
AddEventHandler('scrap:kara', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
		xPlayer.removeMoney(Config.Kara)
end)

RegisterServerEvent('scrap:nagroda')
AddEventHandler('scrap:nagroda', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
		xPlayer.addMoney(Config.Nagroda)
end)

ESX.RegisterServerCallback('esx_jobscrap:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)
