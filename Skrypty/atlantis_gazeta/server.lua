ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('gazeta:payforuse')
AddEventHandler('gazeta:payforuse', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local payrand = math.random(2,10)
    local moneyy = xPlayer.getMoney()
    if moneyy >= payrand then
    	xPlayer.removeMoney(payrand)
    	TriggerClientEvent('gazeta:havemoney', _source)
    else
    	TriggerClientEvent("pNotify:SendNotification", _source, {text = "Nie masz na tyle gotówki.", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
    end
end)
