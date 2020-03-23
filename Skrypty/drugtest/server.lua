ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('drugtest:giveitem')
AddEventHandler('drugtest:giveitem', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tester = xPlayer.getInventoryItem('drugtest').count
    if tester < 1 then
        xPlayer.addInventoryItem('drugtest', 1)
    end
end)

RegisterServerEvent('drugtest:removetestitem')
AddEventHandler('drugtest:removetestitem', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local drug1 = xPlayer.getInventoryItem('seed_weed').count
	local drug2 = xPlayer.getInventoryItem('seed_hybrid').count
	local drug3 = xPlayer.getInventoryItem('seed_sativa').count
	local drug4 = xPlayer.getInventoryItem('seed_coke100').count
	local drug5 = xPlayer.getInventoryItem('seed_coke90').count
	local drug6 = xPlayer.getInventoryItem('seed_coke70').count
	local drug7 = xPlayer.getInventoryItem('meth_sudo').count
    local drugtester = xPlayer.getInventoryItem('drugtest').count

    if drugtester > 0 then
        if drug1 > 0 then
            xPlayer.removeInventoryItem('seed_weed', 1)
            xPlayer.removeInventoryItem('drugtest', 1)
            TriggerClientEvent('drugtest:dotest', _source, 'Marichuana Rodzaj: Indica')
        elseif drug2 > 0 then
            xPlayer.removeInventoryItem('seed_hybrid', 1)
            xPlayer.removeInventoryItem('drugtest', 1)
            TriggerClientEvent('drugtest:dotest', _source, 'Marichuana Rodzaj: Hybrid')
        elseif drug3 > 0 then
            xPlayer.removeInventoryItem('seed_sativa', 1)
            xPlayer.removeInventoryItem('drugtest', 1)
            TriggerClientEvent('drugtest:dotest', _source, 'Marichuana Rodzaj: Sativa')
        elseif drug4 > 0 then
            xPlayer.removeInventoryItem('seed_coke100', 1)
            xPlayer.removeInventoryItem('drugtest', 1)
            TriggerClientEvent('drugtest:dotest', _source, 'Kokaina Czystość: 100%')
        elseif drug5 > 0 then
            xPlayer.removeInventoryItem('seed_coke90', 1)
            xPlayer.removeInventoryItem('drugtest', 1)
            TriggerClientEvent('drugtest:dotest', _source, 'Kokaina Czystość: 90%')
        elseif drug6 > 0 then
            xPlayer.removeInventoryItem('seed_coke70', 1)
            xPlayer.removeInventoryItem('drugtest', 1)
            TriggerClientEvent('drugtest:dotest', _source, 'Kokaina Czystość: 70%')
        --[[elseif drug7 > 0 then
            xPlayer.removeInventoryItem('meth_sudo', 1)
            xPlayer.removeInventoryItem('drugtest', 1)]]
        else
            TriggerClientEvent("pNotify:SendNotification", _source, {text = "Nie posiadasz zadnych ziaren do testow.", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
        end
    else
        TriggerClientEvent("pNotify:SendNotification", _source, {text = "Nie posiadasz testera do nakortyków.", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
    end
end)