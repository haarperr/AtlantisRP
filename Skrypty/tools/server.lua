ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



local logEnabled = true
local displayClientDebug = false
RegisterServerEvent('tools:saveCoords')
AddEventHandler('tools:saveCoords', function(x,y,z,h)
	TriggerClientEvent('chatMessage', source, "Coords: ", {128, 128, 128}, "\nX: " .. x .. "\nY: " .. y .. "\nZ: " .. z.. "\nHeading: "..h )
	local text = ""
	text = "X: " .. x .. " Y: " .. y .. " Z: " .. z.. " Heading: "..h
	if logEnabled then
		setLog(text, source)
	end
	--local pedId = PedToNet(source)
	TriggerClientEvent('chatMessage', source, "Coords: ", {128, 128, 128}, "\nX: " )
	
end)
RegisterServerEvent('tools:saveClientLog')
AddEventHandler('tools:saveClientLog', function(message)
	local text = message
	if displayClientDebug then TriggerClientEvent('tools:displayClientLog', source, text) end
	saveClientLog(text, source)
	
end)

function setLog(text, source)
	local time = os.date("%d/%m/%Y %X")
	local name = GetPlayerName(source)
	-- SteamID
	-- local identifier = GetPlayerIdentifiers(source)
	-- local data = time .. ' : ' .. name .. ' - ' .. identifier[1] .. ' : ' .. text
	local data = time .. ' : ' .. name .. ' : ' .. text

	local content = LoadResourceFile(GetCurrentResourceName(), "coords.txt")
	local newContent = content .. '\r\n' .. data
	SaveResourceFile(GetCurrentResourceName(), "coords.txt", newContent, -1)
end

function saveClientLog(text, source)
	local time = os.date("%d/%m/%Y %X")
	local name = GetPlayerName(source)
	-- SteamID
	-- local identifier = GetPlayerIdentifiers(source)
	-- local data = time .. ' : ' .. name .. ' - ' .. identifier[1] .. ' : ' .. text
	local data = time .. ' : ' .. name .. ' : ' .. text

	local content = LoadResourceFile(GetCurrentResourceName(), "debuglog.txt")
	local newContent = content .. '\r\n' .. data
	SaveResourceFile(GetCurrentResourceName(), "debuglog.txt", newContent, -1)
end


RegisterServerEvent('tools:setHp')
AddEventHandler('tools:setHp', function(ped, hp)
	local _ped = ped
	local _hp = hp
	TriggerClientEvent('tools:setHpClient', _ped, _hp)
end)


RegisterServerEvent('tools:checkMalcolm')
AddEventHandler('tools:checkMalcolm', function()
	local identifier = GetPlayerIdentifiers(source)[1]
	TriggerClientEvent('tools:setMalcolm', source, identifier)
	print(identifier)
end)
