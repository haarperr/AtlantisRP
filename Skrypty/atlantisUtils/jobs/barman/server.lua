ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('barman:pay')
AddEventHandler('barman:pay', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local pay = math.random(12,16)
    		xPlayer.addMoney(pay)
    	TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: barman:pay , zarobek "..pay)
end)