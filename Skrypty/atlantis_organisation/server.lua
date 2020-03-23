ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	if identifier == nil then
		DropPlayer(source, "Wystąpił problem z Twoją postacią. Połącz się z serwerem ponownie lub napisz na discord do Przewodnik Atlantis")
	else
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
				job2 = identity['job2'],
				job2_grade = identity['job2_grade']
			}
		else
			return nil
		end
	end
end


TriggerEvent('esx_society:registerSociety', 'organisation', 'Organizacja', 'society_organisation', 'society_organisation', 'society_organisation', {type = 'public'})

TriggerEvent('esx_society:registerSociety', 'organisation_garage', 'Organizacja Garaż', 'society_organisation_garage', 'society_organisation_garage', 'society_organisation_garage', {type = 'public'})

ESX.RegisterServerCallback('organisation:getArmoryWeapons', function(source, cb)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_organisation', function(store)
		if store ~= nil then
			local weapons = store.get('weapons')

			if weapons == nil then
				weapons = {}
			end

			cb(weapons)
		end
	end)

end)

ESX.RegisterServerCallback('organisation:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)

	local xPlayer = ESX.GetPlayerFromId(source)


	TriggerEvent('esx_datastore:getSharedDataStore', 'society_organisation', function(store)
		if store ~= nil then
			havenil = false
			local weapons = store.get('weapons')

			if weapons == nil then
				weapons = {}
			end

			local foundWeapon = false

			for i=1, #weapons, 1 do
				if weapons[i].name == weaponName then
					weapons[i].count = weapons[i].count + 1
					foundWeapon = true
					break
				end
			end

			if not foundWeapon then
				table.insert(weapons, {
					name  = weaponName,
					count = 1
				})
			end

			store.set('weapons', weapons)
			if removeWeapon then
				xPlayer.removeWeapon(weaponName)
			end
			cb(havenil)
		else
			havenil = true
			cb(havenil)
		end
	end)

end)

ESX.RegisterServerCallback('organisation:removeArmoryWeapon', function(source, cb, weaponName)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_organisation', function(store)
		if store ~= nil then
			havenil = false
			local weapons = store.get('weapons')

			if weapons == nil then
				weapons = {}
			end

			local foundWeapon = false

			for i=1, #weapons, 1 do
				if weapons[i].name == weaponName then
					weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
					foundWeapon = true
					break
				end
			end

			if not foundWeapon then
				table.insert(weapons, {
					name  = weaponName,
					count = 0
				})
			end

			store.set('weapons', weapons)
			xPlayer.addWeapon(weaponName, 250)
			cb(havenil)
		else
			havenil = true
			cb(havenil)
		end
	end)
end)

ESX.RegisterServerCallback('organisation:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_organisation', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('organisation:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)

RegisterServerEvent('organisation:getStockItem')
AddEventHandler('organisation:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_organisation', function(inventory)

		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then

			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then

			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)

			end
		else
	
		end
	end)

end)

RegisterServerEvent('organisation:putStockItems')
AddEventHandler('organisation:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_organisation', function(inventory)

		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else

		end

	end)

end)

RegisterServerEvent('organisation:takemoneyclean')
AddEventHandler('organisation:takemoneyclean', function(count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_organisation', function(account)
		local organisationAccountMoney = account.money

		if organisationAccountMoney >= count then
			account.removeMoney(count)
			xPlayer.addMoney(count)
			ESX.SavePlayer(xPlayer)
		else
			TriggerClientEvent('esx:showNotification', _source, 'Nie możesz pobrać takiej kwoty.')
		end
	end)
end)

RegisterServerEvent('organisation:putmoneyclean')
AddEventHandler('organisation:putmoneyclean', function(count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)

	local playerAccountMoney = xPlayer.getMoney()

		if playerAccountMoney >= count and count > 0 then
			xPlayer.removeMoney(count)

		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_organisation', function(account)
			account.addMoney(count)
			ESX.SavePlayer(xPlayer)
		end)
		else
			TriggerClientEvent('esx:showNotification', _source, 'Nie masz takie kwoty.')
		end
end)


RegisterServerEvent('organisation:takemoney')
AddEventHandler('organisation:takemoney', function(count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_organisation_garage', function(account)
		local organisationAccountMoney = account.money

		if organisationAccountMoney >= count then
			account.removeMoney(count)
			xPlayer.addAccountMoney('black_money', count)
			ESX.SavePlayer(xPlayer)
		else
			TriggerClientEvent('esx:showNotification', _source, 'Nie możesz pobrać takiej kwoty.')
		end
	end)
end)

RegisterServerEvent('organisation:putmoney')
AddEventHandler('organisation:putmoney', function(count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)

	local playerAccountMoney = xPlayer.getAccount('black_money').money

		if playerAccountMoney >= count and count > 0 then
			xPlayer.removeAccountMoney('black_money', count)

		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_organisation_garage', function(account)
			account.addMoney(count)
			ESX.SavePlayer(xPlayer)
		end)
		else
			TriggerClientEvent('esx:showNotification', _source, 'Nie masz takie kwoty.')
		end
end)

RegisterServerEvent('organisation:showmoney')
AddEventHandler('organisation:showmoney', function()
	local clean
	local dirty
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_organisation_garage', function(account)
		dirty = tonumber(account.money)		
	end)
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_organisation', function(account)
		clean = tonumber(account.money)		
	end)

	TriggerClientEvent('organisation:safe', source, clean, dirty)	
end)

ESX.RegisterServerCallback('organisation:grade', function(source, cb)
	local player = getIdentity(source)
	local jobGrade = player.job2_grade

	cb(jobGrade)
end)
