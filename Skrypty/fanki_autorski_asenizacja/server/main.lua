ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--if Config.MaxInService ~= -1 then
	--TriggerEvent('esx_service:activateService', 'cesspool', Config.MaxInService)
--end

--TriggerEvent('esx_phone:registerNumber', 'cesspool', _U('cesspool_client'), true, true)
TriggerEvent('esx_society:registerSociety', 'cesspool', 'cesspool', 'society_cesspool', 'society_cesspool', 'society_cesspool', {type = 'public'})

RegisterServerEvent('esx_cesspool:success')
AddEventHandler('esx_cesspool:success', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'cesspool' then
		print(('esx_cesspool: %s attempted to trigger success!'):format(xPlayer.identifier))
		return
	end

	math.randomseed(os.time())

	local total = math.random(Config.NPCJobEarnings.min, Config.NPCJobEarnings.max)
	local societyAccount

	if xPlayer.job.grade >= 3 then
		total = total * 2
	end

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_cesspool', function(account)
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

RegisterServerEvent('esx_cesspool:getStockItem')
AddEventHandler('esx_cesspool:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'cesspool' then
		print(('esx_cesspool: %s attempted to trigger getStockItem!'):format(xPlayer.identifier))
		return
	end
	
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_cesspool', function(inventory)
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

ESX.RegisterServerCallback('esx_cesspool:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_cesspool', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterServerEvent('esx_cesspool:putStockItems')
AddEventHandler('esx_cesspool:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'cesspool' then
		print(('esx_cesspool: %s attempted to trigger putStockItems!'):format(xPlayer.identifier))
		return
	end

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_cesspool', function(inventory)
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


RegisterServerEvent('cesspool:job1')
AddEventHandler('cesspool:job1', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addInventoryItem('cement', 25)

end)

RegisterServerEvent('cesspool:job2')
AddEventHandler('cesspool:job2', function(itemName)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local item = xPlayer.getInventoryItem('cement')

	
	if item.count > 0 then
		xPlayer.removeInventoryItem('cement', 25)
		xPlayer.addInventoryItem('weed', 25)
	else
		return
	end
end)

RegisterServerEvent('cesspool:job3')
AddEventHandler('cesspool:job3', function(itemName)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local item = xPlayer.getInventoryItem('weed')
	
	if item.count > 0 then
		xPlayer.removeInventoryItem('weed', 1)
		xPlayer.addInventoryItem('bread', 1)
	else
		return
	end
end)

ESX.RegisterServerCallback('esx_cesspool:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)
