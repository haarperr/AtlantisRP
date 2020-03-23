--[[
 ___________________________________________________________________________________
|																					|
|							Script Created by: Johnny2525							|
|						Mail: johnny2525.contact@gmail.com							|
|		Linked-In: https://www.linkedin.com/in/jakub-barwi%C5%84ski-09617b164/		|
|___________________________________________________________________________________|

--]]

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
			phone = identity['phone_number'],
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

function LoadLicenses (source)
  TriggerEvent('esx_license:getLicenses', source, function (licenses)
    TriggerClientEvent('showid:loadLicenses', source, licenses)
  end)
end

function getJobName(jobname)
	local result = MySQL.Sync.fetchAll("SELECT * FROM jobs WHERE name = @identifier", {['@identifier'] = jobname})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			name = identity['name'],
			label = identity['label'],
		}
	else
		return nil
	end
end

--[[TriggerEvent('es:addCommand', 'showid', function(source, args, user)
	local _source = source
	
	local driving = nil
	local weapon  = nil
	
	--LoadLicenses(_source)
	TriggerEvent('esx_license:checkLicense', _source, "drive", function(stat)
		if (stat) then driving = "TAK" else driving = "NIE" end
	end)
	Citizen.Wait(300)
	
	TriggerEvent('esx_license:checkLicense', _source, "weapon", function(stat)
		if (stat) then weapon = "TAK" else weapon = "NIE" end
	end)
	Citizen.Wait(300)
	
	local xPlayer = ESX.GetPlayerFromId(_source)
	

	local name = getIdentity(_source)
	local rname = name.firstname.. " " ..name.lastname
	local rawjob = xPlayer.getJob()
	local job = getJobName(rawjob.name)
	local addon = ""
	
	if(rawjob.name == "mecano" and rawjob.grade_name == "boss") then
		addon = " Główny"
	end
	
	if(driving ~= nil and weapon ~= nil) then
		TriggerClientEvent("showid:DisplayId", -1, _source, name.firstname, name.lastname, driving, weapon, job.label .. addon)
	else
		TriggerClientEvent("showid:DisplayId", -1, _source, name.firstname, name.lastname, "N/A", "N/A", job.label)
	end
end)]]
function convertDate(vardate)
    y,m,d,h,i,s = string.match(vardate, '(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)')
    return string.format('%s-%s-%s', y,m,d)
end

RegisterServerEvent('showid:stresstest')
AddEventHandler('showid:stresstest', function()
local xPlayer2 = ESX.GetPlayerFromId(source)
MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier',{
    ['@identifier'] = xPlayer2.identifier
  }, function(result)

    local phoneNumber = result[1].phone_number
end)
local _source = source
	
	local driving = nil
	local weapon  = nil
	
	--LoadLicenses(_source)
	TriggerEvent('esx_license:checkLicense', _source, "drive", function(stat)
		if (stat) then driving = "TAK" else driving = "NIE" end
	end)
	
	
	TriggerEvent('esx_license:checkLicense', _source, "weapon", function(stat)
		if (stat) then weapon = "TAK" else weapon = "NIE" end
	end)
	
	
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	local name = getIdentity(_source)
	local rname = name.firstname.. " " ..name.lastname
	local rawjob = xPlayer.getJob()
	local job = getJobName(rawjob.name)
	--local ubezpieczenie = convertDate(name.ubezpieczenie)
	
	
	local data = os.date('%d-%m-%Y', name.ubezpieczenie / 1000)

	


	local addon = ""
	
	if(rawjob.name == "mecano" and rawjob.grade_name == "boss") then
		addon = " Główny"
	end
	
	if(driving ~= nil and weapon ~= nil) then
		--TriggerClientEvent("showid:DisplayId", -1, _source, name.firstname, name.lastname, driving, weapon, job.label .. addon,data)
	else
		--TriggerClientEvent("showid:DisplayId", -1, _source, name.firstname, name.lastname, "N/A", "N/A", job.label,data)
	end

	---print( name.lastname, driving, weapon, job.label .. addon,data)
end)

RegisterServerEvent('showid:dowodKey')
AddEventHandler('showid:dowodKey', function()
	local _source = source
	
	local driving = nil
	local weapon  = nil
	
	--LoadLicenses(_source)
	TriggerEvent('esx_license:checkLicense', _source, "drive", function(stat)
		if (stat) then driving = "TAK" else driving = "NIE" end
	end)
	Citizen.Wait(300)
	
	TriggerEvent('esx_license:checkLicense', _source, "weapon", function(stat)
		if (stat) then weapon = "TAK" else weapon = "NIE" end
	end)
	Citizen.Wait(300)
	
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	local name = getIdentity(_source)
	local rname = name.firstname.. " " ..name.lastname
	local rawjob = xPlayer.getJob()
	local job = getJobName(rawjob.name)
	--local ubezpieczenie = convertDate(name.ubezpieczenie)
	
	
	local data = os.date('%d-%m-%Y', name.ubezpieczenie / 1000)




	local addon = ""
	
	if(rawjob.name == "mecano" and rawjob.grade_name == "boss") then
		addon = " Główny"
	end
	
	if(driving ~= nil and weapon ~= nil) then
		TriggerClientEvent("showid:DisplayId", -1, _source, name.firstname, name.lastname, driving, weapon, job.label .. addon,data)
	else
		TriggerClientEvent("showid:DisplayId", -1, _source, name.firstname, name.lastname, "N/A", "N/A", job.label,data)
	end
end)
TriggerEvent('es:addCommand', 'wizytowka', function(source, args, user)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local name = getIdentity(_source)
	local rname = name.firstname.. " " ..name.lastname
	local phone = name.phone
	TriggerClientEvent("showid:DisplayCard", -1, _source, name.firstname, name.lastname,phone)
end)
TriggerEvent('es:addCommand', 'dowod', function(source, args, user)
	local _source = source
	
	local driving = nil
	local weapon  = nil
	
	--LoadLicenses(_source)
	TriggerEvent('esx_license:checkLicense', _source, "drive", function(stat)
		if (stat) then driving = "TAK" else driving = "NIE" end
	end)
	Citizen.Wait(300)
	
	TriggerEvent('esx_license:checkLicense', _source, "weapon", function(stat)
		if (stat) then weapon = "TAK" else weapon = "NIE" end
	end)
	Citizen.Wait(300)
	
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	local name = getIdentity(_source)
	local rname = name.firstname.. " " ..name.lastname
	local rawjob = xPlayer.getJob()
	local job = getJobName(rawjob.name)
	--local ubezpieczenie = convertDate(name.ubezpieczenie)
	
	
	local data = os.date('%d-%m-%Y', name.ubezpieczenie / 1000)




	local addon = ""
	
	if(rawjob.name == "mecano" and rawjob.grade_name == "boss") then
		addon = " Główny"
	end
	
	if(driving ~= nil and weapon ~= nil) then
		TriggerClientEvent("showid:DisplayId", -1, _source, name.firstname, name.lastname, driving, weapon, job.label .. addon,data)
	else
		TriggerClientEvent("showid:DisplayId", -1, _source, name.firstname, name.lastname, "N/A", "N/A", job.label,data)
	end
end)

TriggerEvent('es:addCommand', 'ustawblache', function(source, args, user)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source) 

	local playerId = GetPlayerIdentifiers(args[1])[1] 
	local rawjob = xPlayer.getJob()
	local blacha = tonumber(args[2])	
	if (rawjob.name == "police" and rawjob.grade_name == "boss") then
        MySQL.Async.fetchAll('SELECT * FROM blachy WHERE identifier = @identifier', {
                ['@identifier'] = playerId
        }, function(result)
                if result[1] ~= nil then
                        MySQL.Async.execute("UPDATE blachy  SET number = @blacha WHERE identifier = @identifier", {['@blacha'] = blacha, ['@identifier'] = playerId})
                else
                        
                        MySQL.Async.execute("INSERT INTO blachy (identifier, number) VALUES (@identifier, @blacha)", {['@identifier'] = playerId, ['@blacha'] = blacha})
                       
                end
        end)
	end
end)


--[[
TriggerEvent('es:addCommand', 'mietek', function(source, args, user)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source) 

	local playerId = GetPlayerIdentifiers(args[1])[1] 
	
	
	--if (rawjob.name == "police" and rawjob.grade_name == "boss") then
        MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
                ['@identifier'] = playerId
        }, function(result)
                if result[1] ~= nil then
                        MySQL.Async.execute("UPDATE users  SET ubezpieczenie = DATE_ADD(NOW(), INTERVAL 7 DAY) WHERE identifier = @identifier", {['@identifier'] = playerId})
                        print("OK")
                else
                        
                        --MySQL.Async.execute("INSERT INTO blachy (identifier, number) VALUES (@identifier, @blacha)", {['@identifier'] = playerId, ['@blacha'] = blacha})
                       
                end
        end)
	--end
end)


TriggerEvent('es:addCommand', 'gowno', function(source, args, user)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source) 
	local name = getIdentity(_source)
	local rname = name.firstname.. " " ..name.lastname
	local body = "zmienna body"
	--PerformHttpRequest("https://atlantisrp.pl/lsn/test.php", function(err, text, headers) end, 'POST', 'title='.. rname ..' trafia do pudŁa!&body='..body, { ["Content-Type"] = 'application/x-www-form-urlencoded' })
	TriggerClientEvent("showid:gowno", -1)
	--TriggerClientEvent("atlantisCam:display", -1, rname, true)
end)
--]]

RegisterServerEvent('showid:blachaKey')
AddEventHandler('showid:blachaKey', function()
	local _source = source

        local driving = nil
        local weapon  = nil

        --LoadLicenses(_source)
        TriggerEvent('esx_license:checkLicense', _source, "drive", function(stat)
                if (stat) then driving = "TAK" else driving = "NIE" end
        end)
        Citizen.Wait(300)

        TriggerEvent('esx_license:checkLicense', _source, "weapon", function(stat)
                if (stat) then weapon = "TAK" else weapon = "NIE" end
        end)
        Citizen.Wait(300)

        local xPlayer = ESX.GetPlayerFromId(_source)
	local badgeNumber = getLSPD(_source)
	
        local badge = badgeNumber.number
       print("badge: "..badge)

	local name = getIdentity(_source)
        local rname = name.firstname.. " " ..name.lastname
        local rawjob = xPlayer.getJob()
        local job = getJobName(rawjob.name)
        local addon = ""
	local numerOdznaki = ""
	local kodOdznaki = ""
	if rawjob.grade_name == "kadet" then
		kodOdznaki = "Kadet<BR>LSPD"
	elseif rawjob.grade_name == "oficer1" then
		kodOdznaki = "Funkcjonariusz<BR>I Stopnia"
	elseif rawjob.grade_name == "oficer2" then
                kodOdznaki = "Funkcjonariusz<BR>II Stopnia"
	elseif rawjob.grade_name == "oficer3" then
                kodOdznaki = "Funkcjonariusz<BR>III Stopnia"
	elseif rawjob.grade_name == "sierzant1" then
                kodOdznaki = "Sierżant<BR>I Stopnia"
	elseif rawjob.grade_name == "sierzant2" then
                kodOdznaki = "Sierżant<BR>II Stopnia"
	elseif rawjob.grade_name == "sierzant3" then
                kodOdznaki = "Sierżant<BR>III Stopnia"
	elseif rawjob.grade_name == "porucznik1" then
                kodOdznaki = "Porucznik<BR>I Stopnia"
	elseif rawjob.grade_name == "porucznik2" then
                kodOdznaki = "Porucznik<BR>II Stopnia"
	elseif rawjob.grade_name == "porucznik3" then
                kodOdznaki = "Porucznik<BR>III Stopnia"
	elseif rawjob.grade_name == "kapitan1" then
                kodOdznaki = "Kapitan<BR>I Stopnia"
	elseif rawjob.grade_name == "kapitan2" then
                kodOdznaki = "Kapitan<BR>II Stopnia"
	elseif rawjob.grade_name == "kapitan3" then
                kodOdznaki = "Kapitan<BR>III Stopnia"
    elseif rawjob.grade_name == "zcakomenda" then
                kodOdznaki = "Zastępca<BR>Komendanta"
	elseif rawjob.grade_name == "boss" and rawjob.name == "police" then
                kodOdznaki = "Komendant<BR>LSPD"
        --[[elseif rawjob.grade_name == "pielegniarz" then
                kodOdznaki = "Pielęgniarz"
        elseif rawjob.grade_name == "lekarz" then
                kodOdznaki = "Lekarz Pogotowia"
        elseif rawjob.grade_name == "ratmedyczny" then
                kodOdznaki = "Ratownik Medyczny"
        elseif rawjob.grade_name == "doktor" then
                kodOdznaki = "Doktor I Stopnia"
        elseif rawjob.grade_name == "doktor2" then
                kodOdznaki = "Doktor II Stopnia"
        elseif rawjob.grade_name == "zcaordynatora" then
                kodOdznaki = "Zastępca Ordynatora"
        elseif rawjob.grade_name == "boss" and rawjob.name == "ambulance" then
                kodOdznaki = "Ordynator"]]



	end
        if(rawjob.name == "mecano" and rawjob.grade_name == "boss") then
                addon = " Główny"
        end
	if(rawjob.name == "police") then
        	if(driving ~= nil and weapon ~= nil) then
                	TriggerClientEvent("showid:DisplayLSPD", -1, _source, name.firstname, name.lastname, driving, weapon, kodOdznaki .. addon, badge)
        	else
                	TriggerClientEvent("showid:DisplayLSPD", -1, _source, name.firstname, name.lastname, "N/A", "N/A", kodOdznaki, badge)
        	end
	end
	        if(rawjob.name == "ambulance") then
                if(driving ~= nil and weapon ~= nil) then
                        TriggerClientEvent("showid:DisplayEMS", -1, _source, rname, driving, weapon, kodOdznaki .. addon, badge)
                else
                        TriggerClientEvent("showid:DisplayEMS", -1, _source, rname, "N/A", "N/A", kodOdznaki, badge)
                end
        end
	if(rawjob.name == "city") then
		if rawjob.grade_name == "urzednik7" then
			if(driving ~= nil and weapon ~= nil) then
				--local firstname = string.sub(name.firstname, 1, 1)
				TriggerClientEvent("showid:DisplayZlodziejeInspektor", -1, _source, name.firstname, name.lastname, driving, weapon, kodOdznaki .. addon, badge)
			else
				TriggerClientEvent("showid:DisplayZlodziejeInspektor", -1, _source, name.firstname, name.lastname, "N/A", "N/A", kodOdznaki, badge)
			end
		else
			if(driving ~= nil and weapon ~= nil) then
				TriggerClientEvent("showid:DisplayZlodzieje", -1, _source, name.firstname, name.lastname, driving, weapon, kodOdznaki .. addon, badge)
			else
				TriggerClientEvent("showid:DisplayZlodzieje", -1, _source, name.firstname, name.lastname, "N/A", "N/A", kodOdznaki, badge)
			end
		end
        end
end)
TriggerEvent('es:addCommand', 'blacha', function(source, args, user)
        local _source = source

        local driving = nil
        local weapon  = nil

        --LoadLicenses(_source)
        TriggerEvent('esx_license:checkLicense', _source, "drive", function(stat)
                if (stat) then driving = "TAK" else driving = "NIE" end
        end)
        Citizen.Wait(300)

        TriggerEvent('esx_license:checkLicense', _source, "weapon", function(stat)
                if (stat) then weapon = "TAK" else weapon = "NIE" end
        end)
        Citizen.Wait(300)

        local xPlayer = ESX.GetPlayerFromId(_source)
	local badgeNumber = getLSPD(_source)
	
        local badge = badgeNumber.number
       print("badge: "..badge)

	local name = getIdentity(_source)
        local rname = name.firstname.. " " ..name.lastname
        local rawjob = xPlayer.getJob()
        local job = getJobName(rawjob.name)
        local addon = ""
	local numerOdznaki = ""
	local kodOdznaki = ""
	if rawjob.grade_name == "kadet" then
		kodOdznaki = "Kadet<BR>LSPD"
	elseif rawjob.grade_name == "oficer1" then
		kodOdznaki = "Funkcjonariusz<BR>I Stopnia"
	elseif rawjob.grade_name == "oficer2" then
                kodOdznaki = "Funkcjonariusz<BR>II Stopnia"
	elseif rawjob.grade_name == "oficer3" then
                kodOdznaki = "Funkcjonariusz<BR>III Stopnia"
	elseif rawjob.grade_name == "sierzant1" then
                kodOdznaki = "Sierżant<BR>I Stopnia"
	elseif rawjob.grade_name == "sierzant2" then
                kodOdznaki = "Sierżant<BR>II Stopnia"
	elseif rawjob.grade_name == "sierzant3" then
                kodOdznaki = "Sierżant<BR>III Stopnia"
	elseif rawjob.grade_name == "porucznik1" then
                kodOdznaki = "Porucznik<BR>I Stopnia"
	elseif rawjob.grade_name == "porucznik2" then
                kodOdznaki = "Porucznik<BR>II Stopnia"
	elseif rawjob.grade_name == "porucznik3" then
                kodOdznaki = "Porucznik<BR>III Stopnia"
	elseif rawjob.grade_name == "kapitan1" then
                kodOdznaki = "Kapitan<BR>I Stopnia"
	elseif rawjob.grade_name == "kapitan2" then
                kodOdznaki = "Kapitan<BR>II Stopnia"
	elseif rawjob.grade_name == "kapitan3" then
                kodOdznaki = "Kapitan<BR>III Stopnia"
    	elseif rawjob.grade_name == "zcakomenda" then
                kodOdznaki = "Zastępca<BR>Komendanta"
	elseif rawjob.grade_name == "boss" and rawjob.name == "police" then
                kodOdznaki = "Komendant<BR>LSPD"
    	--[[elseif rawjob.grade_name == "szefp" then
                kodOdznaki = "Szef<BR>Policji"
        elseif rawjob.grade_name == "pielegniarz" then
                kodOdznaki = "Pielęgniarz"
        elseif rawjob.grade_name == "lekarz" then
                kodOdznaki = "Lekarz Pogotowia"
        elseif rawjob.grade_name == "ratmedyczny" then
                kodOdznaki = "Ratownik Medyczny"
        elseif rawjob.grade_name == "doktor" then
                kodOdznaki = "Doktor I Stopnia"
        elseif rawjob.grade_name == "doktor2" then
                kodOdznaki = "Doktor II Stopnia"
        elseif rawjob.grade_name == "zcaordynatora" then
                kodOdznaki = "Zastępca Ordynatora"
        elseif rawjob.grade_name == "boss" and rawjob.name == "ambulance" then
                kodOdznaki = "Ordynator"]]



	end
        if(rawjob.name == "mecano" and rawjob.grade_name == "boss") then
                addon = " Główny"
        end
	if(rawjob.name == "police") then
        	if(driving ~= nil and weapon ~= nil) then
                	TriggerClientEvent("showid:DisplayLSPD", -1, _source, name.firstname, name.lastname, driving, weapon, kodOdznaki .. addon, badge)
        	else
                	TriggerClientEvent("showid:DisplayLSPD", -1, _source, name.firstname, name.lastname, "N/A", "N/A", kodOdznaki, badge)
        	end
	end
	if(rawjob.name == "ambulance") then
                if(driving ~= nil and weapon ~= nil) then
                        TriggerClientEvent("showid:DisplayEMS", -1, _source, rname, driving, weapon, kodOdznaki .. addon, badge)
                else
                        TriggerClientEvent("showid:DisplayEMS", -1, _source, rname, "N/A", "N/A", kodOdznaki, badge)
                end
        end
	if(rawjob.name == "city") then
                if(driving ~= nil and weapon ~= nil) then
                        TriggerClientEvent("showid:DisplayZlodzieje", -1, _source, name.firstname, name.lastname, driving, weapon, kodOdznaki .. addon, badge)
                else
                        TriggerClientEvent("showid:DisplayZlodzieje", -1, _source, name.firstname, name.lastname, "N/A", "N/A", kodOdznaki, badge)
                end
        end
end)
RegisterNetEvent('showid:buyLicense')
AddEventHandler('showid:buyLicense', function()
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        TriggerEvent('esx_license:checkLicense', _source, "tempdrive", function(stat)
                if not(stat) then
                        if(xPlayer.getMoney() >= 200) then
                                TriggerEvent('esx_license:addLicense', _source, "tempdrive", function() end)
                                TriggerEvent('esx_license:addLicense', _source, "drive", function() end)
                                TriggerClientEvent("esx:showNotification", _source, "~g~Kupiles/as prawo jazdy!")
                                xPlayer.removeMoney(200)
                        else
                                TriggerClientEvent("esx:showNotification", _source, "~r~Nie masz tyle pieniedzy!")
                        end
                else
                        TriggerClientEvent("esx:showNotification", _source, "~y~Aby otrzymać nowe prawo jazdy udaj się na nauki jazdy!")
                end
        end)
end)


TriggerEvent('es:addCommand', 'buylicense', function(source, args, user)
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        TriggerEvent('esx_license:checkLicense', _source, "tempdrive", function(stat)
                if not(stat) then
                        if(xPlayer.getMoney() >= 200) then
                                TriggerEvent('esx_license:addLicense', _source, "tempdrive", function() end)
                                TriggerEvent('esx_license:addLicense', _source, "drive", function() end)
                                TriggerClientEvent("esx:showNotification", _source, "~g~Kupiles/as prawo jazdy!")
                                xPlayer.removeMoney(200)
                        else
                                TriggerClientEvent("esx:showNotification", _source, "~r~Nie masz tyle pieniedzy!")
                        end
                else
                        TriggerClientEvent("esx:showNotification", _source, "~y~Aby otrzymać nowe prawo jazdy udaj się na nauki jazdy!")
                end
        end)
end)
TriggerEvent('es:addCommand', 'gze', function(source, args, user)
	local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
	local identifier = GetPlayerIdentifiers(_source)[1]
        local rawjob = xPlayer.getJob()

	--if(rawjob.name == "police") then
        	TriggerClientEvent("showid:DisplayGZE", -1, _source, identifier)
	--end
end)

TriggerEvent('es:addCommand', 'aiad', function(source, args, user)
	local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
	local identifier = GetPlayerIdentifiers(_source)[1]
        local rawjob = xPlayer.getJob()

	if(rawjob.name == "police") then
        	TriggerClientEvent("showid:DisplayAIAD", -1, _source, identifier)
	end
end)


--[[
RegisterNetEvent('showid:buyLicense')
AddEventHandler('showid:buyLicense', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerEvent('esx_license:checkLicense', _source, "drive", function(stat)
		if not(stat) then
			if(xPlayer.getMoney() >= 15000) then
				TriggerEvent('esx_license:addLicense', _source, "drive", function() end)
				TriggerClientEvent("esx:showNotification", _source, "~g~Kupiles/as prawo jazdy!")
				xPlayer.removeMoney(15000)
			else
				TriggerClientEvent("esx:showNotification", _source, "~r~Nie masz tyle pieniedzy!")
			end
		else
			TriggerClientEvent("esx:showNotification", _source, "~y~Posiadasz juz prawo jazdy!")
		end
	end)
end)
]]
RegisterNetEvent('showid:ShowId')
AddEventHandler('showid:ShowId', function()
	local _source = source
	
	local driving = nil
	local weapon  = nil
	
	--LoadLicenses(_source)
	TriggerEvent('esx_license:checkLicense', _source, "drive", function(stat)
		if (stat) then driving = "TAK" else driving = "NIE" end
	end)
	Citizen.Wait(300)
	
	TriggerEvent('esx_license:checkLicense', _source, "weapon", function(stat)
		if (stat) then weapon = "TAK" else weapon = "NIE" end
	end)
	Citizen.Wait(300)
	
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	local name = getIdentity(_source)
	local rname = name.firstname.. " " ..name.lastname
	local rawjob = xPlayer.getJob()
	local job = getJobName(rawjob.name)
	local addon = ""
	
	if(rawjob.name == "mecano" and rawjob.grade_name == "boss") then
		addon = " Główny"
	end
	
	if(driving ~= nil and weapon ~= nil) then
		TriggerClientEvent("showid:DisplayId", -1, _source, name.firstname, name.lastname, driving, weapon, job.label .. addon)
	else
		TriggerClientEvent("showid:DisplayId", -1, _source, name.firstname, name.lastname, "N/A", "N/A", job.label)
	end
end)

RegisterNetEvent('showid:ShowIdPolice')
AddEventHandler('showid:ShowIdPolice', function(id)
        local _source = source
		local target = id
        local driving = nil
        local weapon  = nil

        --LoadLicenses(_source)
        TriggerEvent('esx_license:checkLicense', target, "drive", function(stat)
                if (stat) then driving = "TAK" else driving = "NIE" end
        end)
        Citizen.Wait(300)

        TriggerEvent('esx_license:checkLicense', target, "weapon", function(stat)
                if (stat) then weapon = "TAK" else weapon = "NIE" end
        end)
        Citizen.Wait(300)

        local xPlayer = ESX.GetPlayerFromId(target)

        local name = getIdentity(target)
        local rname = name.firstname.. " " ..name.lastname
        local rawjob = xPlayer.getJob()
        local job = getJobName(rawjob.name)
        local data = os.date('%d-%m-%Y', name.ubezpieczenie / 1000)
        local addon = ""

        if(rawjob.name == "mecano" and rawjob.grade_name == "boss") then
                addon = " Główny"
        end

        if(driving ~= nil and weapon ~= nil) then
			TriggerClientEvent("showid:DisplayIdPrzeszukanie", -1, _source, name.firstname, name.lastname, driving, weapon, job.label .. addon,data, true)
		else
			TriggerClientEvent("showid:DisplayIdPrzeszukanie", -1, _source, name.firstname, name.lastname, "N/A", "N/A", job.label,data, true)
		end
end)

RegisterServerEvent('esx_ds_jobs:checkMalcolm')
AddEventHandler('esx_ds_jobs:checkMalcolm', function()
	local identifier = GetPlayerIdentifiers(source)[1]
	TriggerClientEvent('esx_ds_jobs:setMalcolm', source, identifier)
end)