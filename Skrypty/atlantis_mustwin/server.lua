ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('atlantis:removeitem')
AddEventHandler('atlantis:removeitem', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xphone = xPlayer.getInventoryItem('phone').count
	local xweed1 = xPlayer.getInventoryItem('rweed').count
	local xweed2 = xPlayer.getInventoryItem('rhybrid').count
	local xweed3 = xPlayer.getInventoryItem('rsativa').count
	local xcoke1 = xPlayer.getInventoryItem('rcoke100').count
	local xcoke2 = xPlayer.getInventoryItem('rcoke90').count
	local xcoke3 = xPlayer.getInventoryItem('rcoke70').count
	local xmeth = xPlayer.getInventoryItem('meth_sudo').count
    local gps = xPlayer.getInventoryItem('policegps').count
    local dirtycash = tonumber(xPlayer.getAccount('black_money').money)
    local waterproof = xPlayer.getInventoryItem('waterproof').count


    if xphone > 0 and waterproof <= 0 then
        xPlayer.removeInventoryItem('phone', xphone)
    end

    if xweed1 > 0 then
        xPlayer.removeInventoryItem('rweed', xweed1)
    end

    if xweed2 > 0 then
        xPlayer.removeInventoryItem('rhybrid', xweed2)
    end

    if xweed3 > 0 then
        xPlayer.removeInventoryItem('rsativa', xweed3)
    end

    if xcoke1 > 0 then
        xPlayer.removeInventoryItem('rcoke100', xcoke1)
    end

    if xcoke2 > 0 then
        xPlayer.removeInventoryItem('rcoke90', xcoke2)
    end

    if xcoke3 > 0 then
        xPlayer.removeInventoryItem('rcoke70', xcoke3)
    end

    if xmeth > 0 then
        xPlayer.removeInventoryItem('meth_sudo', xmeth)
    end

    if gps > 0 then
        xPlayer.removeInventoryItem('policegps', gps)
    end

    if dirtycash > 0 then
        xPlayer.removeAccountMoney('black_money', dirtycash / 2)
    end
end)

RegisterServerEvent('Tackle:Server:TacklePlayer')
AddEventHandler('Tackle:Server:TacklePlayer', function(Tackled, ForwardVectorX, ForwardVectorY, ForwardVectorZ, Tackler)
	TriggerClientEvent("Tackle:Client:TacklePlayer", Tackled, ForwardVectorX, ForwardVectorY, ForwardVectorZ, Tackler)
end)
