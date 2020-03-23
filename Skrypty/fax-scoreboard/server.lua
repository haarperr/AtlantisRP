ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('fax-scoreboard:getHex', function(source,cb, userID)
  local user = userID

  local identifiers = GetPlayerIdentifiers(user)
  if identifiers ~= nil then
    local steamid = identifiers[1]
    cb(steamid,source)
  else
    cb("ładuje", source)
  end

  
end)

RegisterServerEvent('fax-scoreboard:ShowJobs')
AddEventHandler('fax-scoreboard:ShowJobs', function()

        local lspd = 0
        local ems = 0
        local mecano = 0
        local ds = 0
        local taxi = 0
        local city = 0
 local xPlayers = ESX.GetPlayers()
                for i=1, #xPlayers, 1 do
                         local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                         --print(xPlayer.job.name)
                 if xPlayer.job.name == 'police' then
                         lspd = lspd +1
                 elseif  xPlayer.job.name == 'ambulance' then
                         ems = ems + 1
                 elseif  xPlayer.job.name == 'mechanic' then --dumy update for fix
                         mecano = mecano +1
				elseif  xPlayer.job.name == 'fib' then
                         ds = ds +1
                 elseif  xPlayer.job.name == 'taxi' then
                         taxi = taxi +1
                         elseif  xPlayer.job.name == 'city' then
                         city = city +1

                 end

         end
			--print("EMS: "..taxi)
                         TriggerClientEvent('fax-scoreboard:getJobs', source, lspd, ems, mecano, ds, taxi, city)


end)

RegisterServerEvent('fax-scoreboard:getHex')
AddEventHandler('fax-scoreboard:getHex', function(userID)
    
local user = userID

  local identifiers = GetPlayerIdentifiers(user)
  if identifiers ~= nil then
    local steamid = identifiers[1]
    local playerid = source
   
    TriggerClientEvent('fax-scoreboard:setHex', source, steamid, userID)
  end
       
                         


end)

RegisterServerEvent('fax-scoreboard:sendMe')
AddEventHandler('fax-scoreboard:sendMe', function()
   TriggerClientEvent("sendProximityMessageMe", -1, source, source, "rozgląda się uważnie")

end)
