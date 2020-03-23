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

ESX = nil
--local radioChannel = 100
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
--local radioChannel = 100
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
			height = identity['height']
		}
	else
		return nil
	end
end
RegisterServerEvent("esx_rpchat:isAllowedToReport")
AddEventHandler("esx_rpchat:isAllowedToReport", function()
    if IsPlayerAceAllowed(source, "atlantisreport") then
        TriggerClientEvent("esx_rpchat:returnIsAllowed", source, true)
    else
        TriggerClientEvent("esx_rpchat:returnIsAllowed", source, false)
    end
end)
  AddEventHandler('chatMessage', function(source, name, message)
	local args = stringsplit(message, " ")
      if string.sub(message, 1, string.len("/")) ~= "/" then
		TriggerClientEvent("sendProximityMessage", -1, source, name, message)
      end
	  
	if args[1] == '/tweet' then
		CancelEvent()
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)
		local phone = xPlayer.getInventoryItem("phone")
		if(phone.count <= 0) then
			TriggerClientEvent("esx:showNotification", source, "~y~Nie możesz wysłać tweeta!\n~r~Nie posiadasz telefonu!")
		else
			local msg = args
			table.remove(msg, 1)
			local test = table.concat(msg, " ")
			test = test:gsub("%^1", "")
			test = test:gsub("%^2", "")
			test = test:gsub("%^3", "")
			test = test:gsub("%^4", "")
			test = test:gsub("%^5", "")
			test = test:gsub("%^6", "")
			test = test:gsub("%^7", "")
			test = test:gsub("%^8", "")
			test = test:gsub("%^9", "")
			local name = getIdentity(source)
			--TriggerClientEvent('chat:addTemplate', -1, 'defalt2', "<img src='data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+Cjxz%0D%0AdmcKICB2aWV3Ym94PSIwIDAgMjAwMCAxNjI1LjM2IgogIHdpZHRoPSIyMDAwIgogIGhlaWdodD0i%0D%0AMTYyNS4zNiIKICB2ZXJzaW9uPSIxLjEiCiAgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAv%0D%0Ac3ZnIj4KICA8cGF0aAogICAgZD0ibSAxOTk5Ljk5OTksMTkyLjQgYyAtNzMuNTgsMzIuNjQgLTE1%0D%0AMi42Nyw1NC42OSAtMjM1LjY2LDY0LjYxIDg0LjcsLTUwLjc4IDE0OS43NywtMTMxLjE5IDE4MC40%0D%0AMSwtMjI3LjAxIC03OS4yOSw0Ny4wMyAtMTY3LjEsODEuMTcgLTI2MC41Nyw5OS41NyBDIDE2MDku%0D%0AMzM5OSw0OS44MiAxNTAyLjY5OTksMCAxMzg0LjY3OTksMCBjIC0yMjYuNiwwIC00MTAuMzI4LDE4%0D%0AMy43MSAtNDEwLjMyOCw0MTAuMzEgMCwzMi4xNiAzLjYyOCw2My40OCAxMC42MjUsOTMuNTEgLTM0%0D%0AMS4wMTYsLTE3LjExIC02NDMuMzY4LC0xODAuNDcgLTg0NS43MzksLTQyOC43MiAtMzUuMzI0LDYw%0D%0ALjYgLTU1LjU1ODMsMTMxLjA5IC01NS41NTgzLDIwNi4yOSAwLDE0Mi4zNiA3Mi40MzczLDI2Ny45%0D%0ANSAxODIuNTQzMywzNDEuNTMgLTY3LjI2MiwtMi4xMyAtMTMwLjUzNSwtMjAuNTkgLTE4NS44NTE5%0D%0ALC01MS4zMiAtMC4wMzksMS43MSAtMC4wMzksMy40MiAtMC4wMzksNS4xNiAwLDE5OC44MDMgMTQx%0D%0ALjQ0MSwzNjQuNjM1IDMyOS4xNDUsNDAyLjM0MiAtMzQuNDI2LDkuMzc1IC03MC42NzYsMTQuMzk1%0D%0AIC0xMDguMDk4LDE0LjM5NSAtMjYuNDQxLDAgLTUyLjE0NSwtMi41NzggLTc3LjIwMywtNy4zNjQg%0D%0ANTIuMjE1LDE2My4wMDggMjAzLjc1LDI4MS42NDkgMzgzLjMwNCwyODQuOTQ2IC0xNDAuNDI5LDEx%0D%0AMC4wNjIgLTMxNy4zNTEsMTc1LjY2IC01MDkuNTk3MiwxNzUuNjYgLTMzLjEyMTEsMCAtNjUuNzg1%0D%0AMSwtMS45NDkgLTk3Ljg4MjgsLTUuNzM4IDE4MS41ODYsMTE2LjQxNzYgMzk3LjI3LDE4NC4zNTkg%0D%0ANjI4Ljk4OCwxODQuMzU5IDc1NC43MzIsMCAxMTY3LjQ2MiwtNjI1LjIzOCAxMTY3LjQ2MiwtMTE2%0D%0ANy40NyAwLC0xNy43OSAtMC40MSwtMzUuNDggLTEuMiwtNTMuMDggODAuMTc5OSwtNTcuODYgMTQ5%0D%0ALjczOTksLTEzMC4xMiAyMDQuNzQ5OSwtMjEyLjQxIgogICAgc3R5bGU9ImZpbGw6IzAwYWNlZCIv%0D%0APgo8L3N2Zz4K' height='16'> <b>{0}</b>: {1}")
			TriggerClientEvent('chat:addMessage', -1, { templateId = 'tweet', multiline = true, args = { name.firstname .. " " .. name.lastname, test } })

			--TriggerClientEvent('chatMessage', -1, "^4tweet@" .. name.firstname .. " " .. name.lastname .. "", {30, 144, 255}, test)
		end
    elseif args[1] == '/anon' then
		CancelEvent()
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        local phone = xPlayer.getInventoryItem("phone")
		local statusSpoleczny = getStatus(source)
		local price = 150
		
		
		
		if statusSpoleczny < -4000 then
		
		price = 0
		end
		
        if(phone.count <= 0) then
                TriggerClientEvent("esx:showNotification", source, "~y~Nie możesz korzystac z DarkWebu!\n~r~Nie posiadasz telefonu!")
        else
			if(xPlayer.get('money') >= price) then
            	local msg = args
            	table.remove(msg, 1)
            	local name = getIdentity(source)
				TriggerClientEvent("anonTweet", -1, source, name.firstname .. " " .. name.lastname, table.concat(msg, " "),xPlayer.job.name)
			 	xPlayer.removeMoney(price)
			 	removeStatus(source, 1)

			else
				TriggerClientEvent("esx:showNotification", source, "~y~Nie masz gotówki!\n~r~Koszt wiadomości: "..price.."$!")
			end
        end
	elseif args[1] == '/me' then
		CancelEvent()
		local msg = args
		table.remove(msg, 1)
		local name = getIdentity(source)
		TriggerClientEvent("sendProximityMessageMe", -1, source, name.firstname .. " " .. name.lastname, table.concat(msg, " "))
	elseif args[1] == '/do' then
		CancelEvent()
		local msg = args
		table.remove(msg, 1)
		local name = getIdentity(source)
		TriggerClientEvent("sendProximityMessageDo", -1, source, name.firstname .. " " .. name.lastname, table.concat(msg, " "))
	elseif args[1] == '/ooc' then
		CancelEvent()
		local msg = args
		table.remove(msg, 1)
		local name = getIdentity(source)
		TriggerClientEvent("esx:showNotification", source, "Użyj komendy /report do kontaktu z adminem.")
	elseif args[1] == '/report' then
		CancelEvent()
		local msg = args
		table.remove(msg, 1)
		local name = getIdentity(source)
		TriggerClientEvent("sendOOC", -1, source, GetPlayerName(source), table.concat(msg, " "))
	elseif args[1] == '/reply' then
		CancelEvent()
		local reportId = tonumber(args[2])
		local msg = args
		table.remove(msg, 1)
		table.remove(msg, 1)
		local name = getIdentity(source)
		TriggerClientEvent("sendReplyReport", -1, reportId, GetPlayerName(source), table.concat(msg, " "))
    elseif args[1] == '/med' then
        		CancelEvent()
                local msg = args
                table.remove(msg, 1)
                local name = getIdentity(source)
                TriggerClientEvent("sendProximityMessageMed", -1, source, name.firstname .. " " .. name.lastname, table.concat(msg, " "))

	end
    CancelEvent()
  end)

  -- TriggerEvent('es:addCommand', 'me', function(source, args, user)
      -- local name = getIdentity(source)
      -- TriggerClientEvent("sendProximityMessageMe", -1, source, name.firstname, table.concat(args, " "))
  -- end)

  -- TriggerEvent('es:addCommand', 'do', function(source, args, user)
      -- local name = getIdentity(source)
	  -- local msg = table.concat(args, " ")
      -- TriggerClientEvent("sendProximityMessageDo", -1, source, name.firstname, msg)
  -- end)
  
   --TriggerEvent('es:addCommand', 'tweet', function(source, args, user)
	--local name = getIdentity(source)
	--table.remove(args, 1)
	--local msg = table.concat(args, " ")
	--print(msg)
	--TriggerClientEvent('chatMessage', -1, "^4tweet | " .. name.firstname .. " " .. name.lastname .. "", {30, 144, 255}, msg)
  --end, {help = 'Send a tweet. [IC]'})

  -- TriggerEvent('es:addCommand', 'ooc', function(source, args, user)
	-- local msg = table.concat(args, " ")
  	-- TriggerClientEvent('chatMessage', -1, "OOC | " .. GetPlayerName(source), {128, 128, 128}, msg)
  -- end, {help = 'Send an out of character message to the whole server.'})

RegisterServerEvent('srvsendProximityCmdMessage')
AddEventHandler('srvsendProximityCmdMessage', function(name, message)
	TriggerClientEvent("sendProximityCmdMessage", -1, source, name, message)
end)
RegisterServerEvent('esx_rpchat:kick')
AddEventHandler('esx_rpchat:kick', function()
	DropPlayer(source, 'AutoKick: Nadużywanie local/ooc. ') -- Kick player
end)
RegisterServerEvent('srvsendnoPoliceDark')
AddEventHandler('srvsendnoPoliceDark', function(name, message)
        TriggerClientEvent("noPoliceDark", -1, source, name, message,police)
end)

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end
function getStatus(source)
    local identifiers = GetPlayerIdentifiers(source)
    local steamid = identifiers[1]
    local identifier = steamid
    local result = MySQL.Sync.fetchAll("SELECT statusSpoleczny FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
    if result[1] ~= nil then
        local identity = result[1]
        return identity['statusSpoleczny']
    else
        return 0
    end
end


function removeStatus(source, amount)
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
end

function addStatus(source, amount)
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
end