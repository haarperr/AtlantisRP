ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('lombard:sell')
AddEventHandler('lombard:sell', function(itemname, price)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local itemcount = xPlayer.getInventoryItem(itemname).count
    if itemcount > 0 then
        xPlayer.removeInventoryItem(itemname, 1)
        xPlayer.addMoney(price)
        TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: lombard:sell , sprzedal "..itemname.." za "..price)
    else
        TriggerClientEvent("pNotify:SendNotification", _source, {text = "Nie posiadasz przedmiotu na sprzedaż.", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
    end
end)

RegisterServerEvent('lombard:buy')
AddEventHandler('lombard:buy', function(itemname, price)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getMoney() >= price then
        xPlayer.addInventoryItem(itemname, 1)
        xPlayer.removeMoney(price)
    end
end)

RegisterServerEvent('lombard:exchange')
AddEventHandler('lombard:exchange', function(itemname, itemname2, price)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local itemcount = xPlayer.getInventoryItem(itemname).count
    if itemcount > 0 then
        xPlayer.removeInventoryItem(itemname, 1)
        xPlayer.addInventoryItem(itemname2, 1)
        TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: lombard:exchange , wymienil "..itemname.." na "..itemname2)
    else
        TriggerClientEvent("pNotify:SendNotification", _source, {text = "Nie posiadasz przedmiotu na wymianę.", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
    end
end)

RegisterServerEvent('lombard:cashexchange')
AddEventHandler('lombard:cashexchange', function(price)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local cashcount = xPlayer.getAccount('black_money').money
    local _price = price
    local cleanprice = ESX.Math.Round(_price - 1250)
    if cashcount >= price then
        xPlayer.removeAccountMoney('black_money', _price) -- Removes Dirty Money
        xPlayer.addMoney(cleanprice) -- Add Clean Money
        TriggerClientEvent("pNotify:SendNotification", _source, {text = "Po odliczeniu prowizji wymieniłeś ".._price.." brudnych na "..cleanprice.." $.", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
        TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: lombard:cashexchange , wymienil ".._price.." na "..cleanprice)
    else
        TriggerClientEvent("pNotify:SendNotification", _source, {text = "Drobnych nie wymieniam wróc jak będziesz mial konkretniejszą kwotę przy sobie.", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
    end
end)