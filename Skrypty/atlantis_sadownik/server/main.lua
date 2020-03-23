ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--if Config.MaxInService ~= -1 then
	--TriggerEvent('esx_service:activateService', 'orchard', Config.MaxInService)
--end

--TriggerEvent('esx_phone:registerNumber', 'orchard', _U('orchard_client'), true, true)
TriggerEvent('esx_society:registerSociety', 'orchard', 'Orchard', 'society_orchard', 'society_orchard', 'society_orchard', {type = 'public'})

RegisterServerEvent('esx_orchard:success')
AddEventHandler('esx_orchard:success', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'orchard' then
		print(('esx_orchard: %s attempted to trigger success!'):format(xPlayer.identifier))
		return
	end

	math.randomseed(os.time())

	local total = math.random(Config.NPCJobEarnings.min, Config.NPCJobEarnings.max)
	local societyAccount

	if xPlayer.job.grade >= 3 then
		total = total * 2
	end

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_orchard', function(account)
		societyAccount = account
	end)

	if societyAccount then
		local playerMoney  = ESX.Math.Round(total / 100 * 30)
		local societyMoney = ESX.Math.Round(total / 100 * 70)

		xPlayer.addMoney(playerMoney)
		societyAccount.addMoney(societyMoney)
		TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: esx_orchard:success , zarobek "..playerMoney.." dla society "..societyMoney)

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned', societyMoney, playerMoney))
	else
		xPlayer.addMoney(total)
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_earned', total))
	end

end)

RegisterServerEvent('esx_orchard:getStockItem')
AddEventHandler('esx_orchard:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'orchard' then
		print(('esx_orchard: %s attempted to trigger getStockItem!'):format(xPlayer.identifier))
		return
	end

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_orchard', function(inventory)
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

ESX.RegisterServerCallback('esx_orchard:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_orchard', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterServerEvent('esx_orchard:putStockItems')
AddEventHandler('esx_orchard:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'orchard' then
		print(('esx_orchard: %s attempted to trigger putStockItems!'):format(xPlayer.identifier))
		return
	end

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_orchard', function(inventory)
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

-- UWAGA OBJASNIAM CO TU SIE ODJEBALO
-- OTOZ: TO JEST PRZYKLAD GATHERINGU ITEMOW Z RNG IN PLAY CZYLI
-- MOZEMY USTALAC DROP-RATE NA ITEMY W DANYM KOLE
-- ORAZ DAWAC CRAP ITEMY JAKO "NAGRODY POCIESZENIA" W TYM PRZYPADKU SZYSZKI
-- RAZ NA 6 RAZY SREDNIO DROPI TU ZIARNO ZIOLA
-- NATOMIAST PRZEZ RESZTE RAZY DROPI MASNY TOP (oraz szyszka jako nagroda pocieszenie, crap item do opierdolenia u npc)
-- CALA METEMATYKA JEST PROSTA JAK JEBANIE, MOZECIE SIE BAWIC ZNAKAMI MNIEJSZOSCI WIEKSZOSCI I CALYMI PETLAMI
-- ZWROCCIE UWAGE NA FUNKCJE math.random(0,5) to jest roll kostka d6 (0, 1, 2, 3, 4, 5)

RegisterServerEvent('orchard:job1a')
AddEventHandler('orchard:job1a', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local total = math.random(0, 10)
	apple = xPlayer.getInventoryItem('apple')

	if apple.count >= 40 then
		TriggerClientEvent('sadownik:toomuch', _source)
	else
		if apple.count >= 30 then
			quickmafs = math.abs(apple.count - 40) 
			xPlayer.addInventoryItem('apple', quickmafs)
			TriggerClientEvent('sadownik:anim', _source)
			SeedTest()
		else 
			xPlayer.addInventoryItem('apple', 10)
			TriggerClientEvent('sadownik:anim', _source)
			SeedTest()
		end
	end
end)

RegisterServerEvent('orchard:job1b')
AddEventHandler('orchard:job1b', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local total = math.random(0, 10)
	orange = xPlayer.getInventoryItem('orange')

	if orange.count >= 40 then
		TriggerClientEvent('sadownik:toomuch', _source)
	else
		if orange.count >= 30 then
			quickmafs = math.abs(orange.count - 40) 
			xPlayer.addInventoryItem('orange', quickmafs)
			TriggerClientEvent('sadownik:anim', _source)
			SeedTest()
		else
			xPlayer.addInventoryItem('orange', 10)
			TriggerClientEvent('sadownik:anim', _source)
			SeedTest()
		end
	end
end)

RegisterServerEvent('orchard:job2')
AddEventHandler('orchard:job2', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local orangejuice = xPlayer.getInventoryItem('orange')
	local applejuice = xPlayer.getInventoryItem('apple')
	local sokcount = xPlayer.getInventoryItem('juice')
	local money = xPlayer.getMoney()

	if sokcount.count >= 30 then
		quickmafs = math.abs(sokcount.count - 40) 
		if applejuice.count >= 10 and orangejuice.count >= 10 then
			if money <= 0 then return end
			xPlayer.removeMoney(1)
			xPlayer.removeInventoryItem('orange', quickmafs)
			xPlayer.removeInventoryItem('apple', quickmafs)
			xPlayer.addInventoryItem('juice', quickmafs)
			TriggerClientEvent('sadownik:anim2', _source)
		else
			TriggerClientEvent('sadownik:niemasz', _source)
		end
	elseif sokcount.count < 30 then
		if applejuice.count > 0 and orangejuice.count > 0 then
			if money <= 0 then return end
			xPlayer.removeMoney(1)
			xPlayer.removeInventoryItem('orange', 10)
			xPlayer.removeInventoryItem('apple', 10)
			xPlayer.addInventoryItem('juice', 10)
			TriggerClientEvent('sadownik:anim2', _source)
		else
			TriggerClientEvent('sadownik:niemasz', _source)
		end
	else
		TriggerClientEvent('sadownik:toomuchj', _source)
	end
end)

RegisterServerEvent('orchard:job3orange')
AddEventHandler('orchard:job3orange', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local orange = xPlayer.getInventoryItem('orange')
			if orange.count >= 10 then
				TriggerClientEvent('pokaz:kase', _source)
				xPlayer.removeInventoryItem('orange', 10)
				xPlayer.addMoney(Config.OrangeSellEarnings * 10)
				TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: orchard:job3orange , zarobek "..Config.OrangeSellEarnings * 10)
			else
				TriggerClientEvent('sadownik:niemasz', _source)
			end
end)

RegisterServerEvent('orchard:job3apple')
AddEventHandler('orchard:job3apple', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
		local apple = xPlayer.getInventoryItem('apple')
			if apple.count >= 10 then
				TriggerClientEvent('pokaz:kase', _source)
				xPlayer.removeInventoryItem('apple', 10)
				xPlayer.addMoney(Config.AppleSellEarnings * 10)
				TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: orchard:job3apple , zarobek "..Config.AppleSellEarnings * 10)
			else
				TriggerClientEvent('sadownik:niemasz', _source)
			end
end)

RegisterServerEvent('orchard:job3')
AddEventHandler('orchard:job3', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
		local juice = xPlayer.getInventoryItem('juice')
		local liczba = juice.count
			if juice.count > 0 then
				TriggerClientEvent('sadownik:oddajsoki', _source)
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, "Nie masz soków")
			end
end)

RegisterServerEvent('orchard:job3a')
AddEventHandler('orchard:job3a', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
		local juice = xPlayer.getInventoryItem('juice')
		local liczba = juice.count
			if juice.count >= 40 then
				TriggerClientEvent('pokaz:kase', _source)
				xPlayer.removeInventoryItem('juice', liczba)
				xPlayer.addMoney(Config.JuiceSellEarnings * 1)
				TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: orchard:job3a , zarobek "..Config.JuiceSellEarnings * 1)
			end
end)

function SeedTest()
local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local trigger = math.random(0, 10)
	local rng = math.random(0, 94)
	if trigger <= 2 then
		if (rng >= 75 and rng <= 85) then
					xPlayer.addInventoryItem('seed_hybrid', 1)
			elseif (rng >= 86 and rng <= 89) then
					xPlayer.addInventoryItem('seed_weed', 1)
			elseif (rng >= 90 and rng <= 93) then
					xPlayer.addInventoryItem('seed_sativa', 1)
			--[[elseif (rng >= 94 and rng <= 96) then
					xPlayer.addInventoryItem('seed_coke70', 1)
			elseif (rng >= 97 and rng <= 99) then
					xPlayer.addInventoryItem('seed_coke90', 1)
			elseif (rng == 100) then
					xPlayer.addInventoryItem('seed_coke100', 1)]]
		end
	end
end

ESX.RegisterServerCallback('esx_orchard:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)
