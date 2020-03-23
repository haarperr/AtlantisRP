ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('storekeeper:pay')
AddEventHandler('storekeeper:pay', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local pay = math.random(30,34)
    		xPlayer.addMoney(pay)
    		TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: storekeeper:pay , zarobek "..pay)
end)