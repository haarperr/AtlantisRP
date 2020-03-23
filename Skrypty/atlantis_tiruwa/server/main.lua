ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--if Config.MaxInService ~= -1 then
	--TriggerEvent('esx_service:activateService', 'trucker', Config.MaxInService)
--end

--TriggerEvent('esx_phone:registerNumber', 'trucker', _U('trucker_client'), true, true)
TriggerEvent('esx_society:registerSociety', 'trucker', 'trucker', 'society_trucker', 'society_trucker', 'society_trucker', {type = 'public'})

RegisterServerEvent('esx_trucker:getStockItem')
AddEventHandler('esx_trucker:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'trucker' then
		print(('esx_trucker: %s attempted to trigger getStockItem!'):format(xPlayer.identifier))
		return
	end
	
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_trucker', function(inventory)
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

ESX.RegisterServerCallback('esx_trucker:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_trucker', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterServerEvent('esx_trucker:putStockItems')
AddEventHandler('esx_trucker:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'trucker' then
		print(('esx_trucker: %s attempted to trigger putStockItems!'):format(xPlayer.identifier))
		return
	end

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_trucker', function(inventory)
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


RegisterServerEvent('esx_trucker:job1')
AddEventHandler('esx_trucker:job1', function(itemname)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local itemcount = xPlayer.getInventoryItem(itemname).count
    if itemcount < 10 then
    	xPlayer.addInventoryItem(itemname, 1)
    end
end)

RegisterServerEvent('esx_trucker:job2')
AddEventHandler('esx_trucker:job2', function()
	local societyAccount

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_trucker', function(account)
        societyAccount = account
    end)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local truckerCheck = xPlayer.getInventoryItem('trucker_check')
	local truckerCheckcount = xPlayer.getInventoryItem('trucker_check').count
	local total = math.random(Config.JobPay.min, Config.JobPay.max)
	local playerMoney  = ESX.Math.Round(total / 100 * 85)
	local societyMoney = ESX.Math.Round(total / 100 * 15)
	
	if truckerCheckcount > 0 then
		xPlayer.removeInventoryItem('trucker_check', 1)
		if Config.EnablePlayerManagement then
			if societyAccount then
				xPlayer.addMoney(playerMoney)
				societyAccount.addMoney(societyMoney)
				TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: trucker:job2 , dodanie pieniedzy "..playerMoney)
			else
				xPlayer.addMoney(total)
				TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: trucker:job2 , dodanie pieniedzy "..total)
			end	
		else
			xPlayer.addMoney(total)
			TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: trucker:job2 , dodanie pieniedzy "..total)
		end
	else
		TriggerClientEvent("pNotify:SendNotification", _source, {text = "Nie posiadasz pokwitowań.", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
	end
end)

RegisterServerEvent('esx_trucker:job3')
AddEventHandler('esx_trucker:job3', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
      xPlayer.removeInventoryItem('bread', 1)
    xPlayer.addInventoryItem('weed', 1)

end)

ESX.RegisterServerCallback('esx_trucker:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)
