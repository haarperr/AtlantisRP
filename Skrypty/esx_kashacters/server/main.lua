---------------------------------------------------------------------------------------
-- Edit this table to all the database tables and columns
-- where identifiers are used (such as users, owned_vehicles, owned_properties etc.)
---------------------------------------------------------------------------------------
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local IdentifierTables = {
    {table = "users", column = "identifier"},
    {table = "owned_vehicles", column = "owner"},
    {table = "addon_account_data", column = "owner"},
	{table = "addon_inventory_items", column = "owner"},
	{table = "characters", column = "identifier"},
	{table = "billing", column = "identifier"},
	{table = "datastore_data", column = "owner"},
	{table = "owned_properties", column = "owner"},
	{table = "user_inventory", column = "identifier"},
	{table = "user_accounts", column = "identifier"},
	{table = "user_licenses", column = "owner"},
	{table = "user_parkings", column = "identifier"},
	{table = "vehicles_for_sale", column = "seller"},
	{table = "vehicles_garage", column = "owner"},
	{table = "solo_race", column = "user"},
	{table = "multi_race", column = "owner"},
	{table = "record_multi", column = "user"},
	{table = "jail", column = "identifier"},
	{table = "treasure", column = "identifier"},
    {table = "phone_users_contacts", column = "identifier"},
}

RegisterServerEvent("kashactersS:SetupCharacters")
AddEventHandler('kashactersS:SetupCharacters', function()
    local src = source
    local LastCharId = GetLastCharacter(src)
    SetIdentifierToChar(GetPlayerIdentifiers(src)[1], LastCharId)
    local Characters = GetPlayerCharacters(src)
    TriggerClientEvent('kashactersC:SetupUI', src, Characters)
end)
RegisterServerEvent("kashactersS:dropMe")
AddEventHandler('kashactersS:dropMe', function()
    print("dropam ".. source)
    local src = source
    DropPlayer(src, '[Atlantis] AFK Kick - 10min podczas wybierania postaci to za długo!') -- Kick player
end)
RegisterServerEvent("kashactersS:CharacterChosen")
AddEventHandler('kashactersS:CharacterChosen', function(charid, ischar)
    local src = source
    local spawn = {}
    SetLastCharacter(src, tonumber(charid))
    SetCharToIdentifier(GetPlayerIdentifiers(src)[1], tonumber(charid))
    if ischar == "true" then
        spawn = GetSpawnPos(src)
        --print(spawn)
        if not spawn then
            spawn = { x = 195.55, y = -933.36, z = 29.90 }
        end
    else
		TriggerClientEvent('skinchanger:loadDefaultModel', src, true, cb)
        local randomSpawnPoint = math.random( 0, 30 )
        if randomSpawnPoint == 1 then 
            spawn = { x = 195.55, y = -933.36, z = 29.90 } -- DEFAULT SPAWN POSITION
        elseif randomSpawnPoint == 2 then
            spawn = { x = 195.55, y = -933.36, z = 29.90 }
        elseif randomSpawnPoint == 3 then
            spawn = { x = -206.24, y = -1013.43, z = 30.14 }
        elseif randomSpawnPoint == 4 then
            spawn = { x = 305.55, y = -1204.24, z = 38.89 }
        elseif randomSpawnPoint == 5 then
            spawn = { x = -850.67, y = -127.09, z = 37.59 }
        elseif randomSpawnPoint == 6 then
            spawn = { x = -1228.79, y = -900.53, z = 12.25 }
        elseif randomSpawnPoint == 7 then
            spawn = { x = -1263.52, y = -725.45, z = 22.09 }
        elseif randomSpawnPoint == 8 then
            spawn = { x = -1390.77, y = -583.96, z = 30.23 }
        elseif randomSpawnPoint == 9 then
            spawn = { x = -1430.61, y = -285.16, z = 46.21 }
        elseif randomSpawnPoint == 10 then
            spawn = { x = -1388.86, y = -173.4, z = 47.38 }
        elseif randomSpawnPoint == 11 then
            spawn = { x = -1038.19, y = -227.56, z = 39.01 }
        elseif randomSpawnPoint == 12 then
            spawn = { x = -569.39, y = 273.89, z = 82.98 }
        elseif randomSpawnPoint == 13 then
            spawn = { x = 228.7, y = 215.13, z = 105.55 }
        elseif randomSpawnPoint == 14 then
            spawn = { x = 375.76, y = 320.98, z = 103.44 }
        elseif randomSpawnPoint == 15 then
            spawn = { x = 128.24, y = -205.83, z = 54.53 }
        elseif randomSpawnPoint == 16 then
            spawn = { x = 280.16, y = -585.57, z = 43.3 }
        elseif randomSpawnPoint == 17 then
            spawn = { x = 414.91, y = -807.85, z = 29.34 }
        elseif randomSpawnPoint == 18 then
            spawn = { x = 285.22, y = -1583.88, z = 30.53 }
        elseif randomSpawnPoint == 19 then
            spawn = { x = -64.86, y = -1746.28, z = 29.37 }
        elseif randomSpawnPoint == 20 then
            spawn = { x = -64.86, y = -1746.28, z = 29.37 }
        elseif randomSpawnPoint == 21 then
            spawn = { x = -261.2, y = -1892.19, z = 27.76 }
        elseif randomSpawnPoint == 22 then
            spawn = { x = -1037.71, y = -2737.69, z = 20.17 }
        elseif randomSpawnPoint == 23 then
            spawn = { x = -1203.02, y = -1543.61, z = 4.31 }
        elseif randomSpawnPoint == 24 then
            spawn = { x = -1179.29, y = -881.41, z = 13.89 }
        elseif randomSpawnPoint == 25 then
            spawn = { x = -888.25, y = -853.52, z = 20.57 }
        elseif randomSpawnPoint == 26 then
            spawn = { x = -463.13, y = -804.54, z = 30.54 }
        elseif randomSpawnPoint == 27 then
            spawn = { x = 156.51, y = -566.31, z = 43.89 }
        elseif randomSpawnPoint == 28 then
            spawn = { x = 59.09, y = -1569.08, z = 29.46 }
        elseif randomSpawnPoint == 29 then
            spawn = { x = 134.28, y = -1306.8, z = 29.07 }
        elseif randomSpawnPoint == 30 then
            spawn = { x = -53.69, y = -1114.76, z = 26.44 }
        elseif randomSpawnPoint == 0 then
            spawn = { x = 821.36, y = -1018.72, z = 26.09 }
        end
        
    end
    TriggerClientEvent("kashactersC:SpawnCharacter", src, spawn)
    TriggerClientEvent("esx_status:charSpawnedClient", src)
    TriggerClientEvent("esx_voice:UnlockProx", src)
   
end)

RegisterServerEvent("kashactersS:DeleteCharacter")
AddEventHandler('kashactersS:DeleteCharacter', function(charid)
    local src = source
    DeleteCharacter(GetPlayerIdentifiers(src)[1], charid)
    TriggerClientEvent("kashactersC:ReloadCharacters", src)
end)

function GetPlayerCharacters(source)
    local identifier = GetIdentifierWithoutSteam(GetPlayerIdentifiers(source)[1])
    local Chars = MySQLAsyncExecute("SELECT * FROM `users` WHERE identifier LIKE '%"..identifier.."%'")
    return Chars
end

function GetLastCharacter(source)
    local LastChar = MySQLAsyncExecute("SELECT `charid` FROM `user_lastcharacter` WHERE `steamid` = '"..GetPlayerIdentifiers(source)[1].."'")
    if LastChar[1] ~= nil and LastChar[1].charid ~= nil then
        return tonumber(LastChar[1].charid)
    else
        MySQLAsyncExecute("INSERT INTO `user_lastcharacter` (`steamid`, `charid`) VALUES('"..GetPlayerIdentifiers(source)[1].."', 1)")
        return 1
    end
end

function SetLastCharacter(source, charid)
    MySQLAsyncExecute("UPDATE `user_lastcharacter` SET `charid` = '"..charid.."' WHERE `steamid` = '"..GetPlayerIdentifiers(source)[1].."'")
end

function SetIdentifierToChar(identifier, charid)
    for _, itable in pairs(IdentifierTables) do
        MySQLAsyncExecute("UPDATE `"..itable.table.."` SET `"..itable.column.."` = 'Char"..charid..GetIdentifierWithoutSteam(identifier).."' WHERE `"..itable.column.."` = '"..identifier.."'")
    end
end

function SetCharToIdentifier(identifier, charid)
    for _, itable in pairs(IdentifierTables) do
        MySQLAsyncExecute("UPDATE `"..itable.table.."` SET `"..itable.column.."` = '"..identifier.."' WHERE `"..itable.column.."` = 'Char"..charid..GetIdentifierWithoutSteam(identifier).."'")
    end
end

function DeleteCharacter(identifier, charid)
    for _, itable in pairs(IdentifierTables) do
        MySQLAsyncExecute("DELETE FROM `"..itable.table.."` WHERE `"..itable.column.."` = 'Char"..charid..GetIdentifierWithoutSteam(identifier).."'")
    end
end

function GetSpawnPos(source)
    local SpawnPos = MySQLAsyncExecute("SELECT `position` FROM `users` WHERE `identifier` = '"..GetPlayerIdentifiers(source)[1].."'")
    if SpawnPos[1].position ~= nil  then
        return json.decode(SpawnPos[1].position)
    else
        return false
    end
end

function GetIdentifierWithoutSteam(Identifier)
    return string.gsub(Identifier, "steam", "")
end

function MySQLAsyncExecute(query)
    local IsBusy = true
    local result = nil
    MySQL.Async.fetchAll(query, {}, function(data)
        result = data
        IsBusy = false
    end)
    while IsBusy do
        Citizen.Wait(0)
    end
    return result
end