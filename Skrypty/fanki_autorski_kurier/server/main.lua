ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--if Config.MaxInService ~= -1 then
	--TriggerEvent('esx_service:activateService', 'curier', Config.MaxInService)
--end

--TriggerEvent('esx_phone:registerNumber', 'curier', _U('curier_client'), true, true)
TriggerEvent('esx_society:registerSociety', 'curier', 'Curier', 'society_curier', 'society_curier', 'society_curier', {type = 'public'})

RegisterServerEvent('give:box')
AddEventHandler('give:box', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local itemname = xPlayer.getInventoryItem('water')

    if itemname.count >= 40 then
        TriggerClientEvent('esx:showNotification', xPlayer.source, _U('too_much_boxes'))
    else
            xPlayer.addInventoryItem('water', 40)
   end
end)

RegisterServerEvent('esx_curier:success')
AddEventHandler('esx_curier:success', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'curier' then
		print(('esx_curier: %s attempted to trigger success!'):format(xPlayer.identifier))
		return
	end

	math.randomseed(os.time())

	local total = math.random(Config.NPCJobEarnings.min, Config.NPCJobEarnings.max)
	local societyAccount

	if xPlayer.job.grade >= 3 then
		total = total * 2
	end

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_curier', function(account)
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

RegisterServerEvent('esx_curier:getStockItem')
AddEventHandler('esx_curier:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'curier' then
		print(('esx_curier: %s attempted to trigger getStockItem!'):format(xPlayer.identifier))
		return
	end
	
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_curier', function(inventory)
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

ESX.RegisterServerCallback('esx_curier:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_curier', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterServerEvent('esx_curier:putStockItems')
AddEventHandler('esx_curier:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'curier' then
		print(('esx_curier: %s attempted to trigger putStockItems!'):format(xPlayer.identifier))
		return
	end

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_curier', function(inventory)
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


RegisterServerEvent('curier:job1')
AddEventHandler('curier:job1', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addInventoryItem('bread', 1)

end)

RegisterServerEvent('curier:job2')
AddEventHandler('curier:job2', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
      xPlayer.removeInventoryItem('bread', 1)
    xPlayer.addInventoryItem('weed', 1)

end)

RegisterServerEvent('curier:job3')
AddEventHandler('curier:job3', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
      xPlayer.removeInventoryItem('bread', 1)
    xPlayer.addInventoryItem('weed', 1)

end)

RegisterServerEvent('curier:job4')
AddEventHandler('curier:job4', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
     -- xPlayer.removeInventoryItem('bread', 1)
    xPlayer.addInventoryItem('bread', 1)

end)

RegisterServerEvent('curier:job5')
AddEventHandler('curier:job5', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
     -- xPlayer.removeInventoryItem('bread', 1)
    xPlayer.addInventoryItem('bread', 1)

end)

RegisterServerEvent('curier:job6')
AddEventHandler('curier:job6', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
      --xPlayer.removeInventoryItem('bread', 1)
    xPlayer.addInventoryItem('bread', 1)

end)

RegisterServerEvent('curier:job7')
AddEventHandler('curier:job7', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
      --xPlayer.removeInventoryItem('bread', 1)
    xPlayer.addInventoryItem('bread', 1)

end)



ESX.RegisterServerCallback('esx_curier:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)
