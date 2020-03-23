ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--[[

	Blood Red - 10-71 strzaly 
Biale napady
Light Yellow - 10-37 kradziez pojazdu
]]--

RegisterServerEvent('esx_jb_outlawalert:kolizjaalert')
AddEventHandler('esx_jb_outlawalert:kolizjaalert', function(street1, street2, veh, current_zone, direction, plate, primary, secondary)
	if veh == "NULL" then
		TTriggerClientEvent("outlawNotify", -1, "^7[10-50] Otrzymaliśmy zgłoszenie o kolizji drogowej - pojazd ^_"..veh.."^r ( ^_" .. plate .. "^r | ".. primary ..", ".. secondary .. "^r) |  Ulica: ^_"..street1.." ^r-^_ "..street2 .. "^r [" .. current_zone .. "] | Kierunek:^_ "..direction)
	else
		TriggerClientEvent("outlawNotify", -1, "^7[10-50] Otrzymaliśmy zgłoszenie o kolizji drogowej - pojazd ^_"..veh.."^r ( ^_" .. plate .. "^r | ".. primary ..", ".. secondary .. "^r) |  Ulica: ^_"..street1.." ^r-^_ "..street2 .. "^r [" .. current_zone .. "] | Kierunek:^_ "..direction)
	end
end)
RegisterServerEvent('esx_outlawalert:kolizjaalertS1')
AddEventHandler('esx_outlawalert:kolizjaalertS1', function(street1, veh, current_zone, direction, plate, primary, secondary)
	if veh == "NULL" then
		TriggerClientEvent("outlawNotify", -1, "^7[10-50] Otrzymaliśmy zgłoszenie o kolizji drogowej - pojazd ^_"..veh.."^r ( ^_" .. plate .. "^r | ".. primary ..", ".. secondary .. "^r) |  Ulica: ^_"..street1 .. "^r [" .. current_zone .. "] | Kierunek: "..direction)
	else
		TriggerClientEvent("outlawNotify", -1, "^7[10-50] Otrzymaliśmy zgłoszenie o kolizji drogowej - pojazd ^_"..veh.."^r ( ^_" .. plate .. "^r | ".. primary ..", ".. secondary .. "^r) |  Ulica: ^_"..street1 .. "^r [" .. current_zone .. "] | Kierunek: "..direction)
	end
end)

RegisterServerEvent('thiefInProgress')
AddEventHandler('thiefInProgress', function(street1, street2, veh, sex, plate)
	if veh == "NULL" then
		TriggerClientEvent("outlawNotify", -1, "^7[^310-37^7] Zgłoszenie kradzieży pojazdu, podejrzana osoba to ^_"..sex.."^r. Okolice: ^_"..street1.."^r/^_"..street2)
	else
		TriggerClientEvent("outlawNotify", -1, "^7[^310-37^7] Zgłoszenie kradzieży pojazdu ^_"..veh.."^r (^_"..plate.."^r), podejrzana osoba to ^_"..sex.."^r. Okolice: "..street1.."^r/^_"..street2)
	end
end)

RegisterServerEvent('thiefInProgressS1')
AddEventHandler('thiefInProgressS1', function(street1, veh, sex, plate)
	if veh == "NULL" then
		TriggerClientEvent("outlawNotify", -1, "^7[^310-37^7] Zgłoszenie kradzieży pojazdu, podejrzana osoba to ^_"..sex.."^r. Okolice: ^_"..street1)
	else
		TriggerClientEvent("outlawNotify", -1, "^7[^310-37^7] Zgłoszenie kradzieży pojazdu ^_"..veh.."^r(^_"..plate.."^r), podejrzana osoba to ^_"..sex.."^r. Okolice: "..street1)
	end
end)
RegisterServerEvent('thiefInProgressPolice')
AddEventHandler('thiefInProgressPolice', function(street1, street2, veh, sex, plate)
	if veh == "NULL" then
		TriggerClientEvent("outlawNotify", -1, "^7[^310-37^7] Zgłoszenie kradzieży radiowozu, podejrzana osoba to ^_"..sex.."^r^7. Ulica: ^_"..street1.."^r^7/^_"..street2)
	else
		TriggerClientEvent("outlawNotify", -1, "^7[^310-37^7] Zgłoszenie kradzieży radiowozu ^_"..veh.."^7(^_"..plate.."^7), podejrzana osoba to ^_"..sex.."^7. Ulica: "..street1.."^7/^1"..street2)
	end
end)
RegisterServerEvent('thiefInProgressS1Police')
AddEventHandler('thiefInProgressS1Police', function(street1, veh, sex, plate)
	if veh == "NULL" then
		TriggerClientEvent("outlawNotify", -1, "^7[^310-37^7] Zgłoszenie kradzieży radiowozu, podejrzana osoba to ^1"..sex.."^7. Ulica: "..street1)
	else
		TriggerClientEvent("outlawNotify", -1, "^7[^310-37^7] Zgłoszenie kradzieży radiowozu ^1"..veh.."^7(^1"..plate.."^7), podejrzana osoba to ^1"..sex.."^7. Ulica: "..street1)
	end
end)

RegisterServerEvent('meleeInProgress')
AddEventHandler('meleeInProgress', function(street1, street2, sex)
	TriggerClientEvent("outlawNotify", -1, "~r~Une bagarre a éclaté par ~w~"..sex.." ~r~entre ~w~"..street1.."~r~ et ~w~"..street2)
end)

RegisterServerEvent('meleeInProgressS1')
AddEventHandler('meleeInProgressS1', function(street1, sex)
	TriggerClientEvent("outlawNotify", -1, "~r~Une bagarre a éclaté par ~w~"..sex.." ~r~à ~w~"..street1)
end)


RegisterServerEvent('gunshotInProgress')
AddEventHandler('gunshotInProgress', function(street1, street2, sex)
	TriggerClientEvent('outlawNotify', -1, "^7[^110-71^7] Otrzymaliśmy zgłoszenie o strzałach! Podejrzana osoba to ^_"..sex.." ^r na ulicy ^_"..street1.." / "..street2  )
end)

RegisterServerEvent('gunshotInProgressS1')
AddEventHandler('gunshotInProgressS1', function(street1, sex)
	TriggerClientEvent('outlawNotify', -1, "^7[^110-71^7] Otrzymaliśmy zgłoszenie o strzałach! Podejrzana osoba to ^_"..sex.." ^r na ulicy "..street1  )
end)

RegisterServerEvent('fastDrivingx')
AddEventHandler('fastDrivingx', function(car)
	TriggerClientEvent('outlawNotify', -1, "^7[^1KOD-505^7] Niebezpieczny kierowca poruszający się pojazdem "..car)
end)

RegisterServerEvent('esx_jb_outlawalert:kolizjablip')
AddEventHandler('esx_jb_outlawalert:kolizjablip', function(tx, ty, tz)
	TriggerClientEvent('kolizjablip', -1, tx, ty, tz)
end)
RegisterServerEvent('esx_jb_outlawalert:emsAlert')
AddEventHandler('esx_jb_outlawalert:emsAlert', function(tx, ty, tz)
	TriggerClientEvent('emsAlert', -1, tx, ty, tz)
end)
RegisterServerEvent('thiefInProgressPos')
AddEventHandler('thiefInProgressPos', function(tx, ty, tz)
	TriggerClientEvent('thiefPlace', -1, tx, ty, tz)
end)
RegisterServerEvent('gunshotInProgressPos')
AddEventHandler('gunshotInProgressPos', function(gx, gy, gz, pjob)
	TriggerClientEvent('gunshotPlace', -1, gx, gy, gz, pjob)
end)

RegisterServerEvent('meleeInProgressPos')
AddEventHandler('meleeInProgressPos', function(mx, my, mz)
	TriggerClientEvent('meleePlace', -1, mx, my, mz)
end)

RegisterServerEvent('drugsInProgress')
AddEventHandler('drugsInProgress', function(text)
	TriggerClientEvent("outlawNotify", -1, text)
end)

RegisterServerEvent('drugsInProgressPos')
AddEventHandler('drugsInProgressPos', function(dx, dy, dz)
	TriggerClientEvent('drugsPlace', -1, dx, dy, dz)
end)

RegisterServerEvent('robberyInProgress')
AddEventHandler('robberyInProgress', function(text)
	TriggerClientEvent("outlawNotify", -1, text)
end)

RegisterServerEvent('robberyInProgressPos')
AddEventHandler('robberyInProgressPos', function(rx, ry, rz)
	TriggerClientEvent('robberyPlace', -1, rx, ry, rz)
end)

RegisterServerEvent('fastDrivingpos')
AddEventHandler('fastDrivingpos', function(fdx, fdy, fdz)
	TriggerClientEvent('fastDriving', -1, fdx, fdy, fdz)
end)

ESX.RegisterServerCallback('esx_outlawalert:ownvehicle',function(source,cb, vehicleProps)
	local isFound = false
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = getPlayerVehicles(xPlayer.getIdentifier())
	local plate = vehicleProps.plate
	
		for _,v in pairs(vehicules) do
			if(plate == v.plate)then
				isFound = true
				break
			end		
		end
		cb(isFound)
end)

function getPlayerVehicles(identifier)
	
	local vehicles = {}
	local data = MySQL.Sync.fetchAll("SELECT * FROM owned_vehicles WHERE owner=@identifier",{['@identifier'] = identifier})	
	for _,v in pairs(data) do
		local vehicle = json.decode(v.vehicle)
		table.insert(vehicles, {id = v.id, plate = vehicle.plate})
	end
	return vehicles
end