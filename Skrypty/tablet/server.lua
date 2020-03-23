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

function getVehicleInfo(plates)
	--local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM owned_vehicles")
	
	for i=1, #result, 1 do
		
		if(result[i] ~= nil) then
			local ident = result[i]
			local info  = json.decode(ident['vehicle'])
			
			if(info ~= nil) then
				if(info.plate == plates) then
					--print("DBG PLATE: ".. info.plate)
					return {plate = info.plate, model = info.model, owner = ident['owner']}
				end
			else
				return nil
			end
		else
			return nil
		end
	
	end
	
	return nil
end

function getVehicleInfoSteam(plates, steamid)
	--local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM owned_vehicles WHERE `identifier` = @steam", {['@steam'] = steamid})
	
	for i=1, #result, 1 do
		
		if(result[i] ~= nil) then
			local ident = result[i]
			local info  = json.decode(ident['vehicle'])
			
			if(info ~= nil) then
				if(info.plate == plates) then
					--print("DBG PLATE: ".. info.plate)
					return {plate = info.plate, model = info.model, owner = ident['owner']}
				end
			else
				return nil
			end
		else
			return nil
		end
	
	end
	
	return nil
end

------------------------------------------------------------------------------------------------------------------
-- endFunc
------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('tablet:finePlayer')
AddEventHandler('tablet:finePlayer', function(target, amount, offenses, jailtime)
	


	local _source = source
	local _target = tonumber(target)
	local _amount = tonumber(amount)
	local _offenses = offenses
	local _jailtime = jailtime

	local sourcexPlayer = ESX.GetPlayerFromId(_source)
	local targetxPlayer = ESX.GetPlayerFromId(_target)
	local lspd = getIdentity(_source)
	local citizen = getIdentity(_target)
	
	local full = "Grzywna: ".._amount .. "$ Odsiadka: " .. tostring(_jailtime) .. "msc. Wykroczenie: " .. _offenses
	 
	Citizen.Wait(500)
	
	if(sourcexPlayer ~= nil and targetxPlayer ~= nil) then
		targetxPlayer.removeAccountMoney('bank', _amount)
		MySQL.Async.execute("INSERT INTO bazalspd (citizen, offenses, lspd) VALUES (@citizen, @offenses, @lspd)", {['@citizen'] = citizen.firstname.." " .. citizen.lastname, ['@offenses'] = full, ['@lspd'] = lspd.firstname .. " " .. lspd.lastname})
		TriggerClientEvent("esx:showNotification", _source, "Mandat wystawiony!")
		TriggerClientEvent("esx:showNotification", _target, "Dostałeś mandat w wysokości: ".. _amount .."$")
	end

end)


RegisterServerEvent('tablet:getOwner')
AddEventHandler('tablet:getOwner', function(plate)
	


	local _source = source
	local sname = ESX.GetPlayerFromId(_source)
	local sjob = sname.getJob()
	Citizen.Wait(500)
	
	if(sname ~= nil) then
		if(sjob.name == "police" or (sjob.name == "mecano" and sjob.grade_name == "boss")) then
			TriggerClientEvent("esx:showNotification", _source, "Sprawdzanie rejestracji pojazdu ~y~"..plate.."~w~...")
			Citizen.Wait(500)
		
			local veh = getVehicleInfo(plate)
			Citizen.Wait(1000)
		 
			if(veh ~= nil) then
				local name = getIdentity(veh.owner)
				Citizen.Wait(1000)
				if(name ~= nil) then
					local rname = name.firstname .. " " .. name.lastname
					TriggerClientEvent("tablet:showOwner", _source, veh.plate, veh.model, rname)
				else
					--TriggerClientEvent("plates:showInfo", source, veh.owner, "Not found")
				end
			else
				if(string.sub(args[1], 1, 3) == "WAL") then
					TriggerClientEvent("plates:showInfo2", _source, args[1], "Boxville", "Firma Kurierska")
				else
					TriggerClientEvent("tablet:showOwner", _source, veh.plate, "Brak informacji", "Brak informacji")
				end
				--TriggerClientEvent("plates:showInfo", _source, args[1], "Nieznany")
			end
		end
	end

end)

ESX.RegisterServerCallback('tablet:getVehicleInfos', function(source, cb, plate)

	local oldDatabaseFound = false
	MySQL.Async.fetchAll('SELECT owner,vehicle FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)

		local retrivedInfo = {
			plate = plate
		}

		if result[1] then

			MySQL.Async.fetchAll('SELECT name, firstname, lastname FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				
					retrivedInfo.owner = result2[1].firstname .. ' ' .. result2[1].lastname
					local infoVeh  = json.decode(result[1].vehicle)
					retrivedInfo.model = infoVeh.model
				

				cb(retrivedInfo)
			end)
		else

			MySQL.Async.fetchAll('SELECT owner,vehicle FROM vehicles_garage WHERE JSON_EXTRACT(vehicle, "$.Plate") = @plate LIMIT 1', {
				['@plate'] = plate
			}, function(result)

			local retrivedInfo = {
				plate = plate
			}

			if result[1] then
				
				MySQL.Async.fetchAll('SELECT name, firstname, lastname FROM users WHERE identifier = @identifier',  {
					['@identifier'] = result[1].owner
				}, function(result2)

					
						retrivedInfo.owner = result2[1].firstname .. ' ' .. result2[1].lastname
						local infoVeh  = json.decode(result[1].vehicle)
						retrivedInfo.model = infoVeh.Model
					

					cb(retrivedInfo)
				end)
			else
				cb(retrivedInfo)
				
			end
			end)
			
		end
	end)
end)

ESX.RegisterServerCallback('tablet:getDatabase', function(source, cb)
	local allCrimes = {}
	

	local result = MySQL.Sync.fetchAll('SELECT * FROM bazalspd')

	for i=1, #result, 1 do
		local citizen   = result[i].citizen
		local offenses  = result[i].offenses
		local lspd = result[i].lspd
		local datex = os.date('%d-%m-%Y', result[i].date / 1000)
		
		table.insert(allCrimes,{citizen, offenses,lspd,datex})
	end
	cb(allCrimes)

end)



