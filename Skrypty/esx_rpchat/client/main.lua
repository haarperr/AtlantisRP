--[[
 ___________________________________________________________________________________
|																					|
|							Code Edited by: Johnny2525								|
|						Mail: johnny2525.contact@gmail.com							|
|		Linked-In: https://www.linkedin.com/in/jakub-barwi%C5%84ski-09617b164/		|
|___________________________________________________________________________________|

--]]

--[[

  ESX RP Chat

--]]

--ESX               = nil

--local playerChannel = {101,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100}

ESX                           = nil
local PlayerData              = {}
-----------------------------------------------
--- Report System
local hasPermission  = false
-----------------------------------------------
Citizen.CreateThread(function()

        while ESX == nil do
                TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
                Citizen.Wait(0)
        end
        TriggerServerEvent("esx_rpchat:isAllowedToReport")

end)
RegisterNetEvent("esx_rpchat:returnIsAllowed")
AddEventHandler("esx_rpchat:returnIsAllowed", function(isAllowed)
    hasPermission = isAllowed
    print( hasPermission )
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)



TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)




RegisterNetEvent('anonTweet')
AddEventHandler('anonTweet', function(id, name, message, police)


  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if(pid == myId) then --and  PlayerData.job.name ~= "police" and PlayerData.job.name ~= "sedzia" and PlayerData.job.name ~= "ambulance" and PlayerData.job.name ~= "fib" and PlayerData.job.name ~= "prokurator" ) then 
    TriggerEvent('chatMessage', "", {30, 144,255}, " Anonim ~> ^7  ".."^7 " .. message)
  elseif(pid ~= myId) then -- and  PlayerData.job.name ~= "police" and PlayerData.job.name ~= "sedzia" and PlayerData.job.name ~= "ambulance" and PlayerData.job.name ~= "fib" and PlayerData.job.name ~= "prokurator" ) then
    TriggerEvent('chatMessage', "", {30, 144, 255}," Anonim ~> ^7  ".."^7 " .. message) 
  end


	--local xPlayer  = ESX.GetPlayerFromId(_source)
--	if xPlayer.job.name == 'police' then
	--Notify(alert)

--	else
--		TriggerEvent("chatMessage", "asd ", {255,255,255}, message)
--	end

end)
--[[
RegisterNetEvent('radioTextMessage')
AddEventHandler('radioTextMessage', function(id, name, message, radio)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', "", {128, 128, 128},  "Radio (CH"..playerChannel[pid+1]..") ^7 " .. message .. " UserID:".. GetPlayerFromServerId(id) .. "radio: "..radio .. " playerid ".. playerChannel[myId+1]) 
  elseif playerChannel[pid+1] == playerChannel[myId+1] then
    TriggerEvent('chatMessage', "", {128, 128, 128},  "Radio (CH"..playerChannel[pid+1]..") ^7 " .. message .. " UserID:".. id .. "radio: "..radio .. " playerid".. PlayerId()) 
  end
end)
RegisterNetEvent('changeRadio')
AddEventHandler('changeRadio', function(id, radio)
  playerChannel[GetPlayerFromServerId(id)+1] = radio
end)

]]
function string.starts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end
RegisterNetEvent('sendProximityMessage')
AddEventHandler('sendProximityMessage', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  
    if pid == myId then
      if string.starts(string.lower(message), "xd") or string.starts(string.lower(message), "essa") or string.starts(string.lower(message), "masno") or string.starts(string.lower(message), "pogchamp") or string.starts(string.lower(message), "poggers")  or string.starts(string.lower(message), "stop spam") then
        TriggerServerEvent("esx_rpchat:kick")
      end
      TriggerEvent('chat:addMessage',  { templateId = 'localooc', multiline = true, args = {  "[ LOCAL OOC ] " .. name, message } })

      --TriggerEvent('chatMessage', "", {128, 128, 128},  "LOCAL OOC | " .. name .. "^7 " .. message)
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
      TriggerEvent('chat:addMessage',  { templateId = 'localooc', multiline = true, args = {  "[ LOCAL OOC ] " .. name, message } })
      --TriggerEvent('chatMessage', "", {128, 128, 128},  "LOCAL OOC | " .. name .. "^7 " .. message)
    end
end)

RegisterNetEvent('sendProximityMessageMe')
AddEventHandler('sendProximityMessageMe', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chat:addMessage',  { templateId = 'me', multiline = true, args = {  "" .. name, message } })
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
    TriggerEvent('chat:addMessage',  { templateId = 'me', multiline = true, args = {  "" .. name, message } })
  end
end)
RegisterNetEvent('sendProximityMessageDo')
AddEventHandler('sendProximityMessageDo', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
   TriggerEvent('chat:addMessage',  { templateId = 'dom', multiline = true, args = {  "" .. name, message } })
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
    TriggerEvent('chat:addMessage',  { templateId = 'dom', multiline = true, args = {  "" .. name, message } })
  end
end)
--[[
old ooc
RegisterNetEvent('sendOOC')
AddEventHandler('sendOOC', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  TriggerEvent('chat:addMessage',  { templateId = 'ooc', multiline = true, args = {  "OOC | " .. name, message } })
    if pid == myId then
      if string.starts(string.lower(message), "xd") or string.starts(string.lower(message), "essa") or string.starts(string.lower(message), "masno") or string.starts(string.lower(message), "pogchamp") or string.starts(string.lower(message), "poggers")  or string.starts(string.lower(message), "stop spam") then
        TriggerServerEvent("esx_rpchat:kick")
      end
    end
    
end)
]]
RegisterNetEvent('sendOOC')
AddEventHandler('sendOOC', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if hasPermission then
    TriggerEvent('chat:addMessage',  { templateId = 'ooc', multiline = true, args = {  "REPORT | " .. name .. " ("..id..")", message } })
  end
  if pid == myId then
    TriggerEvent('chat:addMessage',  { templateId = 'ooc', multiline = true, args = {  "REPORT | " .. name .. " ("..id..")", message } })
  end
end)

RegisterNetEvent('sendReplyReport')
AddEventHandler('sendReplyReport', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if hasPermission then
    TriggerEvent('chat:addMessage',  { templateId = 'ooc', multiline = true, args = {  "REPORT-Odp. | " .. name, message } })
  end
  print(pid)
  print(myId)
  if pid == myId then
    TriggerEvent('chat:addMessage',  { templateId = 'ooc', multiline = true, args = {  "REPORT-Odp. | " .. name, message } })
  end
end)

RegisterNetEvent('sendProximityMessageMed')
AddEventHandler('sendProximityMessageMed', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chat:addMessage',  { templateId = 'med', multiline = true, args = {  " [" .. id .."] " .. name.. ":", message } })
   -- TriggerEvent('chatMessage', "", {255, 0, 0}, " ^2 [" .. id .."] " .. name .. "^2 " .. message)
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 10.999 then
    TriggerEvent('chat:addMessage',  { templateId = 'med', multiline = true, args = {  " [" .. id .."] " .. name ..":", message } })
    --TriggerEvent('chatMessage', "", {255, 0, 0}, " ^2 [" .. id .."] " .. name .. "^2 " .. message)
  end
end)

RegisterNetEvent('sendProximityCmdMessage')
AddEventHandler('sendProximityCmdMessage', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6 " .. name .." ".."^6 " .. message)
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
    TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6 " .. name .." ".."^6 " .. message)
  end
end)
