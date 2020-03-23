ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local healing = false
local resthouselocked = false

RegisterServerEvent("hospital:heal")
AddEventHandler("hospital:heal", function(price)
	local _source = source
  local _price = price
  local xPlayer = ESX.GetPlayerFromId(_source)
  --if xPlayer.getMoney() >= _price then
  	if healing == false then 
  		TriggerClientEvent('hospital:startheal', source, _price)
  		--xPlayer.removeMoney(_price)
      xPlayer.removeAccountMoney('bank', _price)
      TriggerClientEvent('hospital:sendtofraction', _source, _price)
  		healing = true
  	else
  		TriggerClientEvent('hospital:busy', source)
  	end
  --[[else
    TriggerClientEvent("pNotify:SendNotification", _source, {text = "Nie masz tyle gotówki przy sobie.", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
  end]]
end)

RegisterServerEvent("hospital:end")
AddEventHandler("hospital:end", function()
	healing = false
end)

RegisterServerEvent('hospital:emscheck')
AddEventHandler('hospital:emscheck', function()
local emsCount = 0
local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
    --print(xPlayer.job.name)
        if xPlayer.job.name == 'ambulance' then
            emsCount = emsCount + 1
        end
    end
  	if emsCount <= 1 then
   		TriggerClientEvent('hospital:accept', source)
   	else
   		TriggerClientEvent('hospital:decline', source)
   	end
end)

RegisterServerEvent('hospital:insurance7days')
AddEventHandler('hospital:insurance7days', function(id)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source) 

  if xPlayer.getMoney() >= 2200 then
    local playerId = xPlayer.identifier
    
      MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
              ['@identifier'] = playerId
      }, function(result)
            if result[1] ~= nil then
                    MySQL.Async.execute("UPDATE users  SET ubezpieczenie = DATE_ADD(NOW(), INTERVAL 7 DAY) WHERE identifier = @identifier", {['@identifier'] = playerId})
                    print("OK")
            end
      end)
      xPlayer.removeMoney(2200)
      TriggerClientEvent('hospital:sendtofraction', _source, 2200)
  else
      TriggerClientEvent("pNotify:SendNotification", _source, {text = "Nie masz tyle gotówki przy sobie.", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
  end
end)

RegisterServerEvent('hospital:insurance14days')
AddEventHandler('hospital:insurance14days', function(id)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source) 
  
  if xPlayer.getMoney() >= 3000 then
    local playerId = xPlayer.identifier

      MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
              ['@identifier'] = playerId
      }, function(result)
            if result[1] ~= nil then
                    MySQL.Async.execute("UPDATE users  SET ubezpieczenie = DATE_ADD(NOW(), INTERVAL 14 DAY) WHERE identifier = @identifier", {['@identifier'] = playerId})
                    print("OK")
            end
      end)
      xPlayer.removeMoney(3000)
      TriggerClientEvent('hospital:sendtofraction', _source, 3000)
  else
      TriggerClientEvent("pNotify:SendNotification", _source, {text = "Nie masz tyle gotówki przy sobie.", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
  end
end)


RegisterServerEvent('resthouse:checkdirtymoney')
AddEventHandler('resthouse:checkdirtymoney', function(price)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local dirtymoney = ESX.Math.Round(xPlayer.getAccount('black_money').money)
    if dirtymoney >= price then
      if resthouselocked then 
        TriggerClientEvent("pNotify:SendNotification", _source, {text = "Weterynarz aktualnie udziela pomocy w innym miejscu.", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
      else
        TriggerClientEvent('resthouse:heal', _source)
        resthouselocked = true
      end
    else
      TriggerClientEvent("pNotify:SendNotification", _source, {text = "Nie masz brudnej kasy.", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
    end
end)

RegisterServerEvent('resthouse:payforheal')
AddEventHandler('resthouse:payforheal', function(healprice)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local dirtymoney = ESX.Math.Round(xPlayer.getAccount('black_money').money)
        resthouselocked = false
        xPlayer.removeAccountMoney('black_money', healprice)
        TriggerClientEvent("pNotify:SendNotification", _source, {text = "Zapłaciłeś " ..healprice.. "$ brudnego szmalu za usługę.", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
end)