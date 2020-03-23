ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--TriggerEvent('esx_phone:registerNumber', 'boiler', _U('boiler_client'), true, true)
TriggerEvent('esx_society:registerSociety', 'woodsman', 'Woodsman', 'society_woodsman', 'society_woodsman', 'society_woodsman', {type = 'public'})

RegisterServerEvent('esx_woodsman:getStockItem')
AddEventHandler('esx_woodsman:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'woodsman' then
		print(('esx_woodsman: %s attempted to trigger getStockItem!'):format(xPlayer.identifier))
		return
	end
	
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_woodsman', function(inventory)
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

ESX.RegisterServerCallback('esx_woodsman:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_woodsman', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterServerEvent('esx_woodsman:putStockItems')
AddEventHandler('esx_woodsman:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'woodsman' then
		print(('esx_woodsman: %s attempted to trigger putStockItems!'):format(xPlayer.identifier))
		return
	end

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_woodsman', function(inventory)
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

RegisterServerEvent('esx_woodsman:job1')
AddEventHandler('esx_woodsman:job1', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local leather = xPlayer.getInventoryItem('leather')
    if leather.count < 10 then
    	xPlayer.addInventoryItem('leather', 3)
    else
    	TriggerClientEvent('esx:showNotification', _source, 'za duzo skór')
    end
end)

RegisterServerEvent('esx_woodsman:job2')
AddEventHandler('esx_woodsman:job2', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local leather = xPlayer.getInventoryItem('leather')
    local wleather = xPlayer.getInventoryItem('wleather')
    if leather.count > 0 and wleather.count < 10 then
      	xPlayer.removeInventoryItem('leather', 1)
   		xPlayer.addInventoryItem('wleather', 1)
   	end
end)

RegisterServerEvent('esx_woodsman:job3')
AddEventHandler('esx_woodsman:job3', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local wleather = xPlayer.getInventoryItem('wleather')
    local rleather = xPlayer.getInventoryItem('rleather')
    if wleather.count > 0 and rleather.count < 10 then
      	xPlayer.removeInventoryItem('wleather', 1)
   		xPlayer.addInventoryItem('rleather', 1)
   	end
end)

ESX.RegisterServerCallback('esx_woodsman:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)

RegisterServerEvent('esx_woodsman:alert')
AddEventHandler('esx_woodsman:alert', function(x, y, z)
	TriggerClientEvent('ALARM', -1, x, y, z)
end)


RegisterServerEvent('esx_woodsman:shop')
AddEventHandler('esx_woodsman:shop', function()
	local societyAccount

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_woodsman', function(account)
        societyAccount = account
    end)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local rleather = xPlayer.getInventoryItem('rleather')
	local rleathercount = xPlayer.getInventoryItem('rleather').count
	local total = Config.LeatherPrice * rleathercount
	local playerMoney  = ESX.Math.Round(total / 100 * 85)
	local societyMoney = ESX.Math.Round(total / 100 * 15)
	
	if rleathercount > 0 then
		xPlayer.removeInventoryItem('rleather', rleathercount)
			if societyAccount then
				xPlayer.addMoney(playerMoney)
				societyAccount.addMoney(societyMoney)
				TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: woodsman:shop , dodanie pieniedzy "..playerMoney)
			else
				xPlayer.addMoney(total)
				TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: woodsman:shop , dodanie pieniedzy "..total)
			end		
	else
		TriggerClientEvent("pNotify:SendNotification", _source, {text = "Nie posiadasz skór na sprzedaż.", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
	end
end)