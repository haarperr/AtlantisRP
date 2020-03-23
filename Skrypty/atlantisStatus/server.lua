ESX = nil
local debug = false -- enable command /showstatus





TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('atlantisStatus:add')
AddEventHandler('atlantisStatus:add', function(amount)
	local _amount = amount
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source) 
	local playerId = GetPlayerIdentifiers(_source)[1] 	
        MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
                ['@identifier'] = playerId
        }, function(result)
                if result[1] ~= nil then
                        MySQL.Async.execute("UPDATE users  SET statusSpoleczny = statusSpoleczny + @amount WHERE identifier = @identifier", {['@amount'] = amount, ['@identifier'] = playerId})
                end
        end)

        
end)

RegisterNetEvent('atlantisStatus:remove')
AddEventHandler('atlantisStatus:remove', function(amount)
	local _amount = amount
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source) 
	local playerId = GetPlayerIdentifiers(_source)[1] 	
        MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
                ['@identifier'] = playerId
        }, function(result)
                if result[1] ~= nil then
                        MySQL.Async.execute("UPDATE users  SET statusSpoleczny = statusSpoleczny - @amount WHERE identifier = @identifier", {['@amount'] = amount, ['@identifier'] = playerId})
                end
        end)

        
end)

ESX.RegisterServerCallback('atlantisStatus:get', function(source, cb)
  local identifiers = GetPlayerIdentifiers(source)
  local steamid = identifiers[1]
  local status = getStatus(steamid)
  cb(status.statusSpoleczny)
end)


function getStatus(steamid)
	local identifier = steamid
	local result = MySQL.Sync.fetchAll("SELECT statusSpoleczny FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]
		return {
			statusSpoleczny = identity['statusSpoleczny']
		}
	else
		return nil
	end
end


RegisterCommand("autopilot", function(source, args, raw)
    local src = source
    TriggerClientEvent("autopilot:start", src)
end)


if debug then
	RegisterCommand("showstatus", function(source, args, raw)
	    local src = source
	    TriggerClientEvent("atlantisStatus:show", src)
	end)
end

