ESX                           = nil
local enabled = false
local PlayerData              = {}
Citizen.CreateThread(function()

        while ESX == nil do
                TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
                Citizen.Wait(0)
        end

end)


RegisterNetEvent('tablet:toggle')
AddEventHandler('tablet:toggle', function(value)
  SendNUIMessage({
    display = value
  })
  	SetNuiFocus( true, true )
	if not enabled then
		enabled = true
		TabletAnimProp()
	end
end)

RegisterNUICallback('exit', function() 
	SendNUIMessage({
    display = false
  })
	SetNuiFocus( false, false )
	enabled = false
	ClearPedTasks(PlayerPedId())
	DeleteObject(tablet)
end)

function TabletAnimProp()
	local ad = "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a"

	DeleteObject(tablet)
	SetCurrentPedWeapon(PlayerPedId(), -1569615261,true)
	Citizen.Wait(1)
	loadAnimDict(ad)
	TaskPlayAnim(PlayerPedId(), ad, "idle_a", 8.0, 3.0, -1, 58, 1, false, false, false)
	tablet = CreateObject(GetHashKey('hei_prop_dlc_tablet'), 1.0, 1.0, 1.0, 1, 1, 0)
	AttachEntityToEntity(tablet, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), -0.05, -0.007, -0.04, 0.0, 0.0, 0.0, 1, 1, 0, 1, 1, 1)

end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

--------------------------------------------------------------------------------------------
-- Set Fines/Send to jail/Fuck'em all

RegisterNUICallback('sendtToJail', function(data, cb)
	local id = data.id 
	local fineAmount = tonumber(data.fineAmount)
	local jailTime = data.jailTime
	local descr = data.descr
	local sendPlayerToJail = false
	print(jailTime)
	if jailTime ~= nil and jailTime ~= "" then
		if tonumber(jailTime) > 0 then
			print("jail > 0")
			sendPlayerToJail = true
		else
			print("jail < 0")
			sendPlayerToJail = false
		end
	else
		print("nil")
		jailTime = 0
		sendPlayerToJail = false
	end
		TriggerServerEvent("tablet:finePlayer", tonumber(id), fineAmount,descr,jailTime)
		TriggerServerEvent('esx_society:depositMoney', 'police', fineAmount *2, 1)
	if sendPlayerToJail then
		TriggerServerEvent("esx_jail:sendToJail", tonumber(id), tonumber(jailTime) * 60)
    end
	
end)

--------------------------------------------------------------------------------------------
-- Plates

RegisterNUICallback('checkPlate', function(data, cb)
	local _plate = string.upper(data.plate)
	--TriggerServerEvent("tablet:getOwner", _plate)
	ESX.TriggerServerCallback('tablet:getVehicleInfos', function(retrivedInfo)
		local vehname = "brak informacji"
		if(retrivedInfo.model ~= nil) then
			local prevehname = GetDisplayNameFromVehicleModel(retrivedInfo.model)
			vehname = GetLabelText(prevehname)
		end
		local owner = "brak informacji"
		if (retrivedInfo.owner ~= nil) then
			owner = retrivedInfo.owner
		end
		local buildPage = {}
		table.insert( buildPage, "<center>Wyniki wyszukiwania pojazdu dla rejestracji: <B><U>".._plate.. "</U></B></center>")
		table.insert( buildPage, "<BR><B>Informacje o właścicielu -></B>")
		table.insert( buildPage, "<BR>Imię i nazwisko: " .. owner)
		table.insert( buildPage, "<BR>Model: ".. vehname)
		SendNUIMessage({
	    section = "plates",
	    plate = table.concat( buildPage ),
	    display = true 
    })

		

	end, _plate)
  
	
end)
--------------------------------------------------------------------------------------------
-- Database

RegisterNUICallback('openDatabase', function()

	ESX.TriggerServerCallback('tablet:getDatabase', function(allCrimes)
		local buildPage = {}
		table.insert( buildPage, '<table id="table_id" class="display"><thead><tr><th>Obywatel</th><th>Opis</th><th>LSPD</th><th>Data</th></tr></thead><tbody>')
		for i=1, #allCrimes, 1 do

			table.insert( buildPage, '<tr><td>'..allCrimes[i][1]..'</td><td>'..allCrimes[i][2]..'</td><td>'.. allCrimes[i][3] ..'</td><td>'.. allCrimes[i][4] ..'</td></tr>')
		end
		table.insert( buildPage, '</tbody></table>')
		SendNUIMessage({
	    section = "browse",
			browse = table.concat( buildPage ),
			display = true 
    	})	

	end)
  
	
end)
RegisterNetEvent('tablet:showOwner')
AddEventHandler('tablet:showOwner', function(plate)
	SendNUIMessage({ display = false })
    SetNuiFocus( false, false )
    local _plate = plate
    ESX.TriggerServerCallback('tablet:getVehicleInfos', function(retrivedInfo)
		local vehname = "brak informacji"
		if(retrivedInfo.model ~= nil) then
			local prevehname = GetDisplayNameFromVehicleModel(retrivedInfo.model)
			vehname = GetLabelText(prevehname)
		end
		local owner = "brak informacji"
		if (retrivedInfo.owner ~= nil) then
			owner = retrivedInfo.owner
		end
		local buildPage = {}
		table.insert( buildPage, "<center>Wyniki wyszukiwania pojazdu dla rejestracji: <B><U>".._plate.. "</U></B></center>")
		table.insert( buildPage, "<BR><B>Informacje o właścicielu -></B>")
		table.insert( buildPage, "<BR>Imię i nazwisko: " .. owner)
		table.insert( buildPage, "<BR>Model: ".. vehname)
		SendNUIMessage({
	    section = "plates",
	    plate = table.concat( buildPage ),
	    display = false 

    })
		ESX.ShowNotification("NR [~r~".._plate.."~s~]".. "~n~Właściciel: ~r~".. owner .. "~n~~s~Model: ~r~" .. vehname)
		

	end, _plate)
end)

--------------------------------------------------------------------------------------------