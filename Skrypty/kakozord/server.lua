ESX = nil
local server = GetConvar("atlantisServer", "1")
local DiscordWebHook = ""
  if server == "1" then
      DiscordWebHook = "x"
  elseif server == "2" then
      DiscordWebHook = "x"
  end
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--Send the message to your discord server
function sendToDiscord (name, message,color, content)
  
  -- Modify here your discordWebHook username = name, content = message,embeds = embeds
if content == nil then
  content = ""
end
local embeds = {
    {
        ["title"]=message,
        ["type"]="rich",
        ["color"] =color,
        ["footer"]=  {
            ["text"]= "Kakozord donosiciel",
       },
    }
}

if message == nil or message == '' then return FALSE end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name, content = content, embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent("kakozord:donies")
AddEventHandler('kakozord:donies', function(user, text)
    sendToDiscord("EVENT TRIGGERED", user .." ".. text)
end)