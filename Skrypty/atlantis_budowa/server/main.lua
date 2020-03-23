ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--if Config.MaxInService ~= -1 then
	--TriggerEvent('esx_service:activateService', 'builder', Config.MaxInService)
--end

--TriggerEvent('esx_phone:registerNumber', 'builder', _U('builder_client'), true, true)
TriggerEvent('esx_society:registerSociety', 'builder', 'builder', 'society_builder', 'society_builder', 'society_builder', {type = 'public'})

RegisterServerEvent('esx_builder:success')
AddEventHandler('esx_builder:success', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'builder' then
		print(('esx_builder: %s attempted to trigger success!'):format(xPlayer.identifier))
		return
	end

	math.randomseed(os.time())

	local total = math.random(Config.NPCJobEarnings.min, Config.NPCJobEarnings.max)
	local societyAccount

	if xPlayer.job.grade >= 3 then
		total = total * 2
	end

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_builder', function(account)
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

RegisterServerEvent('esx_builder:getStockItem')
AddEventHandler('esx_builder:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'builder' then
		print(('esx_builder: %s attempted to trigger getStockItem!'):format(xPlayer.identifier))
		return
	end

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_builder', function(inventory)
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

ESX.RegisterServerCallback('esx_builder:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_builder', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterServerEvent('esx_builder:putStockItems')
AddEventHandler('esx_builder:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'builder' then
		print(('esx_builder: %s attempted to trigger putStockItems!'):format(xPlayer.identifier))
		return
	end

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_builder', function(inventory)
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

RegisterServerEvent('builder:job1xd')
AddEventHandler('builder:job1xd', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local betoncount = xPlayer.getInventoryItem('betontransport')
			if betoncount.count < 1 then
				xPlayer.addInventoryItem('betontransport', 1)
			elseif betoncount > 0 then
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('Masz już papiery!'))
			return
			end
end)

RegisterServerEvent('builder:job1')
AddEventHandler('builder:job1', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local betoncount = xPlayer.getInventoryItem('betontransport')
	local nailcount = xPlayer.getInventoryItem('nailpack')
			if betoncount.count == 1 and nailcount.count == 0  then
				xPlayer.removeInventoryItem('betontransport', 1)
				xPlayer.addInventoryItem('nailpack', 1)
				exports.pNotify:SendNotification({text = "To są gwoździe o które prosił szef, zawieź je gdzie trzeba.", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
			else
				exports.pNotify:SendNotification({text = "Gdzie papiery? Gdzie transport? Chcesz mnie oszukać?!", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
				return
			end
end)

RegisterServerEvent('builder:job2')
AddEventHandler('builder:job2', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local nailcount = xPlayer.getInventoryItem('nailpack')
	local hammercount = xPlayer.getInventoryItem('jackhammer')
			if nailcount.count == 1 and hammercount.count == 0  then
				xPlayer.removeInventoryItem('nailpack', 1)
				xPlayer.addInventoryItem('jackhammer', 1)
				exports.pNotify:SendNotification({text = "To są gwoździe o które prosił szef, zawieź je gdzie trzeba.", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
			else
				exports.pNotify:SendNotification({text = "Gdzie papiery? Gdzie transport?", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
				return
			end
end)

RegisterServerEvent('builder:job2b')
AddEventHandler('builder:job2b', function(itemName)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
		local hammercount = xPlayer.getInventoryItem('jackhammer')
		if hammercount.count > 0 then
				xPlayer.removeInventoryItem('jackhammer', 1)
				xPlayer.addMoney(Config.czek)
			else
			exports.pNotify:SendNotification({text = "Masz ten młot? Wracaj po niego!", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
			return
		end
end)

ESX.RegisterServerCallback('esx_builder:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)
