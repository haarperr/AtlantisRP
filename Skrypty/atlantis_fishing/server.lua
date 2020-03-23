ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('fishing:giveitem')
AddEventHandler('fishing:giveitem', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local item = xPlayer.getInventoryItem('fish')
    if item.count < 10 then
    	xPlayer.addInventoryItem('fish', amount)
    else
    	TriggerClientEvent('esx:showNotification', _source, 'za duzo ryb')
    end
end)