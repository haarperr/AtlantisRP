ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('kosiarka:pay')
AddEventHandler('kosiarka:pay', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local pay = math.random(5,10)
    	xPlayer.addMoney(pay)
    	TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: kosiarka:pay , zarobek "..pay)
end)