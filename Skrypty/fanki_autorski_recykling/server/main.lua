ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--if Config.MaxInService ~= -1 then
	--TriggerEvent('esx_service:activateService', 'garbage', Config.MaxInService)
--end

--TriggerEvent('esx_phone:registerNumber', 'garbage', _U('garbage_client'), true, true)
TriggerEvent('esx_society:registerSociety', 'garbage', 'Garbage', 'society_garbage', 'society_garbage', 'society_garbage', {type = 'public'})

RegisterServerEvent('esx_garbage:success')
AddEventHandler('esx_garbage:success', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'garbage' then
		print(('esx_garbage: %s attempted to trigger success!'):format(xPlayer.identifier))
		return
	end

	math.randomseed(os.time())

	local total = math.random(Config.NPCJobEarnings.min, Config.NPCJobEarnings.max)
	local societyAccount

	if xPlayer.job.grade >= 3 then
		total = total * 2
	end

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_garbage', function(account)
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

RegisterServerEvent('esx_garbage:getStockItem')
AddEventHandler('esx_garbage:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'garbage' then
		print(('esx_garbage: %s attempted to trigger getStockItem!'):format(xPlayer.identifier))
		return
	end
	
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_garbage', function(inventory)
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

ESX.RegisterServerCallback('esx_garbage:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_garbage', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterServerEvent('esx_garbage:putStockItems')
AddEventHandler('esx_garbage:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'garbage' then
		print(('esx_garbage: %s attempted to trigger putStockItems!'):format(xPlayer.identifier))
		return
	end

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_garbage', function(inventory)
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

RegisterServerEvent('garbage:job1')
-- RNG do losowania ktora trase obierzemy
AddEventHandler('garbage:job1', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local route = math.random(0, 3)
    
	if route == 0 then
		TriggerClientEvent('esx:showNotification', xPlayer.source, ('trasa0'))
	elseif route == 1 then                                            
		TriggerClientEvent('esx:showNotification', xPlayer.source, ('trasa1'))
	elseif route == 2 then                                            
		TriggerClientEvent('esx:showNotification', xPlayer.source, ('trasa2'))
	elseif route == 3 then                                            
		TriggerClientEvent('esx:showNotification', xPlayer.source, ('trasa3'))
	end
end)

RegisterServerEvent('garbage:job2')
AddEventHandler('garbage:job2', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
      xPlayer.removeInventoryItem('bread', 1)
    xPlayer.addInventoryItem('weed', 1)

end)

RegisterServerEvent('garbage:job3')
AddEventHandler('garbage:job3', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('bread', 1)

end)

ESX.RegisterServerCallback('esx_garbage:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)
