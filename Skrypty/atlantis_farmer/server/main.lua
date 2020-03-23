ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--if Config.MaxInService ~= -1 then
	--TriggerEvent('esx_service:activateService', 'boiler', Config.MaxInService)
--end

--TriggerEvent('esx_phone:registerNumber', 'boiler', _U('boiler_client'), true, true)
TriggerEvent('esx_society:registerSociety', 'farmer', 'Farmer', 'society_farmer', 'society_farmer', 'society_farmer', {type = 'public'})

RegisterServerEvent('esx_farmer:success')
AddEventHandler('esx_farmer:success', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'farmer' then
		print(('esx_farmer: %s attempted to trigger success!'):format(xPlayer.identifier))
		return
	end

	math.randomseed(os.time())

	local total = math.random(Config.NPCJobEarnings.min, Config.NPCJobEarnings.max)
	local societyAccount

	if xPlayer.job.grade >= 3 then
		total = total * 2
	end

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_farmer', function(account)
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

RegisterServerEvent('esx_farmer:getStockItem')
AddEventHandler('esx_farmer:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'farmer' then
		print(('esx_farmer: %s attempted to trigger getStockItem!'):format(xPlayer.identifier))
		return
	end
	
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_farmer', function(inventory)
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

ESX.RegisterServerCallback('esx_farmer:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_farmer', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterServerEvent('esx_farmer:putStockItems')
AddEventHandler('esx_farmer:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'farmer' then
		print(('esx_farmer: %s attempted to trigger putStockItems!'):format(xPlayer.identifier))
		return
	end

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_farmer', function(inventory)
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


RegisterServerEvent('farmer:job1')
AddEventHandler('farmer:job1', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
   	local wheat	  = xPlayer.getInventoryItem('wheat')
	local rng 	  = math.random(0, 100)
    if wheat.count >= 40 then
    	TriggerClientEvent('farmer:limit', _source)
    else
   	 	xPlayer.addInventoryItem('wheat', 1)
		if rng > 95 then
			xPlayer.addInventoryItem('ergot', 1)
		end
   	end
end)

RegisterServerEvent('farmer:job2')
AddEventHandler('farmer:job2', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local milk	  = xPlayer.getInventoryItem('milk')

    if milk.count >= 40 then
    	TriggerClientEvent('farmer:limit', _source)
    else
   	 	xPlayer.addInventoryItem('milk', 1)
   	end
end)

RegisterServerEvent('farmer:job3')
AddEventHandler('farmer:job3', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local wheat1 = xPlayer.getInventoryItem('bakedbread')
	local wheatcount = xPlayer.getInventoryItem('bakedbread').count
			if wheat1.count > 0 then 
				xPlayer.removeInventoryItem('bakedbread', wheatcount)
				xPlayer.addMoney(wheatcount * Config.WheatSellEarnings)
				TriggerClientEvent('farmer:pieniazki', _source)
			else
				TriggerClientEvent('farmer:empty', _source)
			end   	
end)

RegisterServerEvent('farmer:job3a_pre')
AddEventHandler('farmer:job3a_pre', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local wheatcount = xPlayer.getInventoryItem('wheat')
	local breadcount = xPlayer.getInventoryItem('bakedbread')
			if breadcount.count > 0 then
				TriggerClientEvent('farmer:maszchleb', _source)
			elseif wheatcount.count > 0 then 
				TriggerClientEvent('farmer:przerobkawheat', _source)
			else
				TriggerClientEvent('farmer:empty', _source)
			end   	
end)

RegisterServerEvent('farmer:job3a')
AddEventHandler('farmer:job3a', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local wheatcount = xPlayer.getInventoryItem('wheat')
	local wheatxd = wheatcount.count
			if wheatcount.count > 0 then 
				xPlayer.removeInventoryItem('wheat', wheatxd)
				xPlayer.addInventoryItem('bakedbread', wheatxd)
				--TriggerClientEvent('dajplatki', _source)
			else
				TriggerClientEvent('farmer:empty', _source)
			end   	
end)

ESX.RegisterServerCallback('esx_farmer:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)
