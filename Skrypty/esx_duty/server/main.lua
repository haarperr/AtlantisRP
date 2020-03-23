ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
function getIdentity(source)
  local identifier = GetPlayerIdentifiers(source)[1]
  local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
  if result[1] ~= nil then
    local identity = result[1]

    return {
      identifier = identity['identifier'],
      firstname = identity['firstname'],
      lastname = identity['lastname'],
      dateofbirth = identity['dateofbirth'],  
      sex = identity['sex'],
      height = identity['height'],
      job = identity['job'],
      ubezpieczenie = identity['ubezpieczenie']
    }
  else
    return nil
  end
end

function getLSPD(source)
        local identifier = GetPlayerIdentifiers(source)[1]
        local result = MySQL.Sync.fetchAll("SELECT * FROM blachy WHERE identifier = @identifier", {['@identifier'] = identifier})
        if result[1] ~= nil then
                local identity = result[1]

                return {
                        identifier = identity['identifier'],
                        number = identity['number']
                        
                }
        else
                return nil
        end
end
RegisterServerEvent('duty:spawnDuty')
AddEventHandler('duty:spawnDuty', function(job)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local job = xPlayer.job.name
  local grade = xPlayer.job.grade

  if job == 'police' then
    xPlayer.setJob('off' ..job, grade)
  end 
  if job == 'ambulance' then
    xPlayer.setJob('off' ..job, grade)
  end
  if job == 'mechanic' then
    xPlayer.setJob('off' ..job, grade)
  end
end)

RegisterServerEvent('duty:forceOff')
AddEventHandler('duty:forceOff', function(job)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local job = xPlayer.job.name
  local grade = xPlayer.job.grade

  if job == 'police' then
    xPlayer.setJob('off' ..job, grade)
    TriggerClientEvent("atlantisCam:display", _source, "CAM-OFF", false)
  end 
end)

RegisterServerEvent('duty:onoff')
AddEventHandler('duty:onoff', function(job)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local job = xPlayer.job.name
  local grade = xPlayer.job.grade

  if job == 'police' or job == 'ambulance' or job == "mechanic" then
    xPlayer.setJob('off' ..job, grade)
    if job == "police" then
      local gpsItem = xPlayer.getInventoryItem("policegps")
      if gpsItem.count > 0 then
        xPlayer.removeInventoryItem("policegps", 1)
      end
      TriggerClientEvent("atlantisCam:display", _source, "CAM-OFF", false)
    end

    TriggerClientEvent("pNotify:SendNotification", _source, { text = _U('offduty'),type = "atlantisError", queue = "lmao", timeout = 2500, layout = "atlantis" })
    -- TriggerClientEvent('esx:showNotification', _source, _U('offduty'))
  elseif job == 'offpolice' then
    xPlayer.setJob('police', grade)
    local name = getIdentity(_source)
    local rname = name.firstname.. " " ..name.lastname
    local gpsItem = xPlayer.getInventoryItem("policegps")
    if gpsItem.count == 0 then
      xPlayer.addInventoryItem("policegps", 1)
    end
    TriggerClientEvent("atlantisCam:display", _source, "CAM-OFF", false)
    TriggerClientEvent("atlantisCam:display", _source, rname, true)

    TriggerClientEvent("pNotify:SendNotification", _source, { text = _U('onduty'),type = "atlantis", queue = "lmao", timeout = 2500, layout = "atlantis" })
    --  TriggerClientEvent('esx:showNotification', _source, _U('onduty'))
  elseif job == 'offambulance' then
    xPlayer.setJob('ambulance', grade)
    TriggerClientEvent("pNotify:SetQueueMax", _source, "lmao", 4)
    TriggerClientEvent("pNotify:SendNotification", _source, { text = _U('onduty'),type = "atlantis", queue = "lmao", timeout = 2500, layout = "atlantis" })
  elseif job == 'offmechanic' then
    xPlayer.setJob('mechanic', grade)
    TriggerClientEvent("pNotify:SetQueueMax", _source, "lmao", 4)
    TriggerClientEvent("pNotify:SendNotification", _source, { text = _U('onduty'),type = "atlantis", queue = "lmao", timeout = 2500, layout = "atlantis" })


    -- TriggerClientEvent('esx:showNotification', _source, _U('onduty'))
  else
    TriggerClientEvent("pNotify:SetQueueMax", _source, "lmao", 4)
    TriggerClientEvent("pNotify:SendNotification", _source, { text = "Nie pracujesz tutaj!" ,type = "atlantis", queue = "lmao", timeout = 2500, layout = "atlantis" })
  end

end)
