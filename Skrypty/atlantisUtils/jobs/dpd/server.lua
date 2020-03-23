ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('dpd:pay')
AddEventHandler('dpd:pay', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local pay = math.random(200,220)
    		xPlayer.addMoney(pay)
    	TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: dpd:pay , zarobek "..pay)
end)