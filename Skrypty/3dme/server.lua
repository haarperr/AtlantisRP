local logEnabled = false


RegisterServerEvent('3dme:shareDisplayMe')
AddEventHandler('3dme:shareDisplayMe', function(text)
	TriggerClientEvent('3dme:triggerDisplayMe', -1, text, source)
	TriggerEvent("esx:medoalert",source,"/me"..text)
	TriggerClientEvent("sendProximityMessageMe", -1, source, source, text)
	
	if logEnabled then
		setLog(text, source)
	end
end)
RegisterServerEvent('3dme:shareDisplayDo')
AddEventHandler('3dme:shareDisplayDo', function(text)
		TriggerEvent("esx:medoalert",source,"/do" .. text)
        TriggerClientEvent('3dme:triggerDisplayDo', -1, text, source)
        TriggerClientEvent("sendProximityMessageDo", -1, source, source, text)
        if logEnabled then
                setLog(text, source)
        end
end)

function setLog(text, source)
	local time = os.date("%d/%m/%Y %X")
	local name = GetPlayerName(source)
	local identifier = GetPlayerIdentifiers(source)
	local data = time .. ' : ' .. name .. ' - ' .. identifier[1] .. ' : ' .. text

	local content = LoadResourceFile(GetCurrentResourceName(), "log.txt")
	local newContent = content .. '\r\n' .. data
	SaveResourceFile(GetCurrentResourceName(), "log.txt", newContent, -1)
end
