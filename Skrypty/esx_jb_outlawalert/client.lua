ESX                           = nil
local PlayerData              = {}
Citizen.CreateThread(function()

	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

--Config
local timer = 1 --in minutes - Set the time during the player is outlaw
local showOutlaw = true --Set if show outlaw act on map
local gunshotAlert = true --Set if show alert when player use gun
local carJackingAlert = true --Set if show when player do carjacking
local meleeAlert = true --Set if show when player fight in melee
local robberiesAlert = true --Set if show when player start robbery
local drugsAlert = true
local fastDriving = true
local emsAlert = true
local fastDrivingBlip = true
local blipEmsTime = 45
local blipGunTime = 45 --in second
local blipMeleeTime = 45 --in second
local blipJackingTime = 60 -- in second
local blipRobberyTime = 120 -- in second
local drugBlipTime = 60 -- in second
local fastDrivingBlipTime = 45
local showcopsmisbehave = true  --show notification when cops steal too
--End config

local timing = timer * 60000 --Don't touche it

GetPlayerName()
RegisterNetEvent('outlawNotify')
AddEventHandler('outlawNotify', function(alert)
		if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
            TriggerEvent('chat:addMessage',  { templateId = 'police', multiline = true, args = { "^1[^7911^1]^7", alert } })
        end
end)

function Notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if NetworkIsSessionStarted() then
            DecorRegister("IsOutlaw",  3)
            DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 1)
            return
        end
    end
end)

RegisterNetEvent('thiefPlace')
AddEventHandler('thiefPlace', function(tx, ty, tz)
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		if carJackingAlert then
			local transT = 250
			local fakeOffSetX = math.random(50,99)
			local fakeOffSetY = math.random(50,99)
			local fakeOffSetZ = math.random(50,99)
			local thiefBlip = AddBlipForCoord(tx + fakeOffSetX + 0.0, ty + fakeOffSetY + 0.0 , tz+ fakeOffSetZ + 0.0)
			SetBlipSprite(thiefBlip,  10)
			SetBlipColour(thiefBlip,  1)
			SetBlipAlpha(thiefBlip,  transT)
			SetBlipAsShortRange(thiefBlip,  1)
			while transT ~= 0 do
				Wait(blipJackingTime * 4)
				transT = transT - 1
				SetBlipAlpha(thiefBlip,  transT)
				if transT == 0 then
					SetBlipSprite(thiefBlip,  2)
					return
				end
			end
			
		end
	end
end)

RegisterNetEvent('gunshotPlace')
AddEventHandler('gunshotPlace', function(gx, gy, gz, pjob)
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		if gunshotAlert then
			local transG = 250
			local robberyBlip = AddBlipForCoord(gx, gy, gz)
			SetBlipSprite(robberyBlip,  304)
			if pjob == "police" then
				SetBlipColour(robberyBlip,  38)
			else
				SetBlipColour(robberyBlip,  1)
			end
			SetBlipAlpha(robberyBlip,  transG)
			SetBlipAsShortRange(robberyBlip,  1)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Strzały!")
			EndTextCommandSetBlipName(robberyBlip)
			while transG ~= 0 do
				Wait(blipGunTime * 4)
				transG = transG - 1
				SetBlipAlpha(robberyBlip,  transG)
				if transG == 0 then
					SetBlipSprite(robberyBlip,  2)
					return
				end
			end
		   
		end
	end
end)

RegisterNetEvent('meleePlace')
AddEventHandler('meleePlace', function(mx, my, mz)
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		if meleeAlert then
			local transM = 250
			local meleeBlip = AddBlipForCoord(mx, my, mz)
			SetBlipSprite(meleeBlip,  270)
			SetBlipColour(meleeBlip,  17)
			SetBlipAlpha(meleeBlip,  transG)
			SetBlipAsShortRange(meleeBlip,  1)
			while transM ~= 0 do
				Wait(blipMeleeTime * 4)
				transM = transM - 1
				SetBlipAlpha(meleeBlip,  transM)
				if transM == 0 then
					SetBlipSprite(meleeBlip,  2)
					return
				end
			end
			
		end
	end
end)

RegisterNetEvent('robberyPlace')
AddEventHandler('robberyPlace', function(rx, ry, rz)
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		if robberiesAlert then
			local transR = 250
			local shopRobberyBlip = AddBlipForCoord(rx, ry, rz)
			SetBlipSprite(shopRobberyBlip, 351)
			SetBlipColour(shopRobberyBlip,  1)
			SetBlipAlpha(shopRobberyBlip,  transR)
			SetBlipAsShortRange(shopRobberyBlip,  1)
			SetBlipScale(shopRobberyBlip, 2.0)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Napad!")
			EndTextCommandSetBlipName(shopRobberyBlip)
			while transR ~= 0 do
				Wait(blipRobberyTime * 4)
				transR = transR - 1
				SetBlipAlpha(shopRobberyBlip,  transR)
				if transR == 0 then
					SetBlipSprite(shopRobberyBlip,  2)
					return
				end
			end
			
		end
	end
end)
RegisterNetEvent('kolizjablip')
AddEventHandler('kolizjablip', function(rx, ry, rz)
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		if robberiesAlert then
			local transR = 250
			local shopKolizjaBlip = AddBlipForCoord(rx, ry, rz)
			SetBlipSprite(shopKolizjaBlip, 380)
			SetBlipColour(shopKolizjaBlip,  1)
			SetBlipAlpha(shopKolizjaBlip,  transR)
			SetBlipAsShortRange(shopKolizjaBlip,  1)
			SetBlipScale(shopKolizjaBlip, 2.0)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Kolizja drogowa")
			EndTextCommandSetBlipName(shopKolizjaBlip)
			while transR ~= 0 do
				Wait(blipRobberyTime * 4)
				transR = transR - 1
				SetBlipAlpha(shopKolizjaBlip,  transR)
				if transR == 0 then
					SetBlipSprite(shopKolizjaBlip,  2)
					return
				end
			end
			
		end
	end
end)

RegisterNetEvent('emsAlert')
AddEventHandler('emsAlert', function(rx, ry, rz)
	if PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' then
		if emsAlert then
			local transR = 250
			local emsAlertBlip = AddBlipForCoord(rx, ry, rz)
			SetBlipSprite(emsAlertBlip, 153)
			SetBlipColour(emsAlertBlip,  9)
			SetBlipAlpha(emsAlertBlip,  transR)
			SetBlipAsShortRange(emsAlertBlip,  1)
			SetBlipScale(emsAlertBlip, 2.0)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Ostatnie zgłoszenie EMS!")
			EndTextCommandSetBlipName(emsAlertBlip)
			Citizen.Wait(5000)
			while transR ~= 0 do
				Wait(blipEmsTime * 4)
				transR = transR - 1
				SetBlipAlpha(emsAlertBlip,  transR)
				if transR == 0 then
					SetBlipSprite(emsAlertBlip,  2)
					return
				end
			end
		end
	end
end)

RegisterNetEvent('drugsPlace')
AddEventHandler('drugsPlace', function(dx, dy, dz)
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		if drugsAlert then
			local transD = 250
			local fakeOffSetX = math.random(50,99)
			local fakeOffSetY = math.random(50,99)
			local fakeOffSetZ = math.random(50,99)
			local drugsBlip = AddBlipForCoord(dx + fakeOffSetX + 0.0, dy + fakeOffSetY + 0.0 , dz+ fakeOffSetZ + 0.0)
			SetBlipSprite(drugsBlip, 140)
			SetBlipColour(drugsBlip,  1)
			SetBlipAlpha(drugsBlip,  transR)
			SetBlipAsShortRange(drugsBlip,  1)
			SetBlipScale(drugsBlip, 1.5)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Diler narkotyków")
			EndTextCommandSetBlipName(drugsBlip)
			while transD ~= 0 do
				Wait(drugBlipTime * 4)
				transD = transD - 1
				SetBlipAlpha(drugsBlip,  transD)
				if transD == 0 then
					SetBlipSprite(drugsBlip,  2)
					return
				end
			end
			
		end
	end
end)

RegisterNetEvent('fastDriving')
AddEventHandler('fastDriving', function(fdx, fdy, fdz)
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		if fastDriving then
			local transFD = 250
			local fastDrivingBlip = AddBlipForCoord(fdx, fdy, fdz)
			SetBlipSprite(fastDrivingBlip, 523)
			SetBlipColour(fastDrivingBlip,  1)
			SetBlipAlpha(fastDrivingBlip,  transFD)
			SetBlipAsShortRange(fastDrivingBlip,  1)
			SetBlipScale(fastDrivingBlip, 1.5)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Niebezpieczna jazda")
			EndTextCommandSetBlipName(fastDrivingBlip)
			while transFD ~= 0 do
				Wait(fastDrivingBlipTime * 4)
				transFD = transFD - 1
				SetBlipAlpha(fastDrivingBlip,  transFD)
				if transD == 0 then
					SetBlipSprite(fastDrivingBlip,  2)
					return
				end
			end
			
		end
	end
end)

--Star color
--[[1- White
2- Black
3- Grey
4- Clear grey
5-
6-
7- Clear orange
8-
9-
10-
11-
12- Clear blue]]

-- Citizen.CreateThread( function()
    -- while true do
        -- Wait(0)
        -- if showOutlaw then
            -- for i = 0, 31 do
				-- if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
					-- if DecorGetInt(GetPlayerPed(i), "IsOutlaw") == 2 and GetPlayerPed(i) ~= GetPlayerPed(-1) then
						-- gamerTagId = Citizen.InvokeNative(0xBFEFE3321A3F5015, GetPlayerPed(i), ".", false, false, "", 0 )
						-- Citizen.InvokeNative(0xCF228E2AA03099C3, gamerTagId, 0) --Show a star
						-- Citizen.InvokeNative(0x63BB75ABEDC1F6A0, gamerTagId, 7, true) --Active gamerTagId
						-- Citizen.InvokeNative(0x613ED644950626AE, gamerTagId, 7, 1) --White star
					-- elseif DecorGetInt(GetPlayerPed(i), "IsOutlaw") == 1 then
						-- Citizen.InvokeNative(0x613ED644950626AE, gamerTagId, 7, 255) -- Set Color to 255
						-- Citizen.InvokeNative(0x63BB75ABEDC1F6A0, gamerTagId, 7, false) --Unactive gamerTagId
					-- end
				-- end
            -- end
        -- end
    -- end
-- end)

Citizen.CreateThread( function()
    while true do
        Wait(0)
        if DecorGetInt(GetPlayerPed(-1), "IsOutlaw") == 2 then
            Wait( math.ceil(timing) )
            DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 1)
        end
    end
end)

RegisterNetEvent('esx:wytrychalert')
AddEventHandler('esx:wytrychalert', function()
		--if PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'ambulance' and PlayerData.job.name ~= 'mechanic'  then
        	local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
        	local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
        	local street1 = GetStreetNameFromHashKey(s1)
        	local street2 = GetStreetNameFromHashKey(s2)
			TriggerServerEvent('eden_garage:debug', "carjacking!")
			Wait(3000)
			DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 2)
			local playerPed = GetPlayerPed(-1)
			local coords    = GetEntityCoords(playerPed)
			local vehicle = GetVehiclePedIsIn(playerPed,false)
			local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
			if PlayerData.job ~= nil and PlayerData.job.name == 'police' and showcopsmisbehave == false then
			elseif PlayerData.job ~= nil and PlayerData.job.name == 'police' and showcopsmisbehave then
				ESX.TriggerServerCallback('esx_outlawalert:ownvehicle',function(valid)
					if (valid) then
					else
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
							local sex = nil
							if skin.sex == 0 then
								sex = "Mężczyzna"
							else
								sex = "Kobieta"
							end
							TriggerServerEvent('thiefInProgressPos', plyPos.x, plyPos.y, plyPos.z)
							local veh = GetClosestVehicle(plyPos.x, plyPos.y, plyPos.z, 6.0, 0)
							if not(IsEntityAVehicle(veh)) then veh = nil end
							local veh = GetVehiclePedIsIn(GetPlayerPed(-1))
							local vehName = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
							local vehName2 = GetLabelText(vehName)
							local plate = GetVehicleNumberPlateText(veh)
							if s2 == 0 then
								if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
									TriggerServerEvent('thiefInProgressS1police', street1, vehName2, sex, plate)
								else
									TriggerServerEvent('thiefInProgressS1', street1, vehName2, sex, plate)
								end
							elseif s2 ~= 0 then
								if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
									TriggerServerEvent('thiefInProgressPolice', street1, street2, vehName2, sex, plate)
								else
									TriggerServerEvent('thiefInProgress', street1, street2, vehName2, sex, plate)
								end
							end
						end)
					end
				end,vehicleProps)
			else
				ESX.TriggerServerCallback('esx_outlawalert:ownvehicle',function(valid)
					if (valid) then
					else
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
							local sex = nil
							if skin.sex == 0 then
								sex = "Mężczyzna"
							else
								sex = "Kobieta"
							end
							TriggerServerEvent('thiefInProgressPos', plyPos.x, plyPos.y, plyPos.z)
							local veh = GetClosestVehicle(plyPos.x, plyPos.y, plyPos.z, 6.0, 0)
							if not(IsEntityAVehicle(veh)) then veh = nil end
							local veh = GetVehiclePedIsTryingToEnter(GetPlayerPed(-1))
							local vehName = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
							local vehName2 = GetLabelText(vehName)
							local plate = GetVehicleNumberPlateText(veh)
							if s2 == 0 then
								TriggerServerEvent('thiefInProgressS1', street1, vehName2, sex, plate)
							elseif s2 ~= 0 then
								TriggerServerEvent('thiefInProgress', street1, street2, vehName2, sex, plate)
							end
						end)
					end
				end,vehicleProps)
			end
		--end
end)

--[[Citizen.CreateThread( function()
    while true do
        Wait(0)
        
        if IsPedTryingToEnterALockedVehicle(GetPlayerPed(-1)) or IsPedJacking(GetPlayerPed(-1))  then
		local randomJack = math.random(1,10)
	--	print(randomJack)
		Citizen.Wait(2000)
		if randomJack > 5 and  PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'ambulance' and PlayerData.job.name ~= 'mechanic'  then
        	local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
        	local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
        	local street1 = GetStreetNameFromHashKey(s1)
        	local street2 = GetStreetNameFromHashKey(s2)
			TriggerServerEvent('eden_garage:debug', "carjacking!")
			Wait(3000)
			DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 2)
			local playerPed = GetPlayerPed(-1)
			local coords    = GetEntityCoords(playerPed)
			local vehicle =GetVehiclePedIsIn(playerPed,false)
			local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
			if PlayerData.job ~= nil and PlayerData.job.name == 'police' and showcopsmisbehave == false then
			elseif PlayerData.job ~= nil and PlayerData.job.name == 'police' and showcopsmisbehave then
				ESX.TriggerServerCallback('esx_outlawalert:ownvehicle',function(valid)
					if (valid) then
					else
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
							local sex = nil
							if skin.sex == 0 then
								sex = "Mężczyzna"
							else
								sex = "Kobieta"
							end
							TriggerServerEvent('thiefInProgressPos', plyPos.x, plyPos.y, plyPos.z)
							local veh = GetClosestVehicle(plyPos.x, plyPos.y, plyPos.z, 6.0, 0)
							if not(IsEntityAVehicle(veh)) then veh = nil end
							local veh = GetVehiclePedIsIn(GetPlayerPed(-1))
							local vehName = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
							local vehName2 = GetLabelText(vehName)
							local plate = GetVehicleNumberPlateText(veh)
							if s2 == 0 then
								if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
									TriggerServerEvent('thiefInProgressS1police', street1, vehName2, sex, plate)
								else
									TriggerServerEvent('thiefInProgressS1', street1, vehName2, sex, plate)
								end
							elseif s2 ~= 0 then
								if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
									TriggerServerEvent('thiefInProgressPolice', street1, street2, vehName2, sex, plate)
								else
									TriggerServerEvent('thiefInProgress', street1, street2, vehName2, sex, plate)
								end
							end
						end)
					end
				end,vehicleProps)
			else
				ESX.TriggerServerCallback('esx_outlawalert:ownvehicle',function(valid)
					if (valid) then
					else
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
							local sex = nil
							if skin.sex == 0 then
								sex = "Mężczyzna"
							else
								sex = "Kobieta"
							end
							TriggerServerEvent('thiefInProgressPos', plyPos.x, plyPos.y, plyPos.z)
							local veh = GetClosestVehicle(plyPos.x, plyPos.y, plyPos.z, 6.0, 0)
							if not(IsEntityAVehicle(veh)) then veh = nil end
							local veh = GetVehiclePedIsTryingToEnter(GetPlayerPed(-1))
							local vehName = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
							local vehName2 = GetLabelText(vehName)
							local plate = GetVehicleNumberPlateText(veh)
							if s2 == 0 then
								TriggerServerEvent('thiefInProgressS1', street1, vehName2, sex, plate)
							elseif s2 ~= 0 then
								TriggerServerEvent('thiefInProgress', street1, street2, vehName2, sex, plate)
							end
						end)
					end
				end,vehicleProps)
			end
		end
        end
    end
end)]]

--[[
Citizen.CreateThread( function()
    while true do
        Wait(0)
        local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
        local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
        local street1 = GetStreetNameFromHashKey(s1)
        local street2 = GetStreetNameFromHashKey(s2)
        if IsPedInMeleeCombat(GetPlayerPed(-1)) then
            DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 2)
			if PlayerData.job ~= nil and PlayerData.job.name == 'police' and showcopsmisbehave == false then
			elseif PlayerData.job ~= nil and PlayerData.job.name == 'police' and showcopsmisbehave then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					local sex = nil
					if skin.sex == 0 then
						sex = "un homme"
					else
						sex = "une femme"
					end
					TriggerServerEvent('meleeInProgressPos', plyPos.x, plyPos.y, plyPos.z)
					if s2 == 0 then
						TriggerServerEvent('meleeInProgressS1', street1, sex)
					elseif s2 ~= 0 then
						TriggerServerEvent("meleeInProgress", street1, street2, sex)
					end
				end)
				Wait(3000)
			else
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					local sex = nil
					if skin.sex == 0 then
						sex = "un homme"
					else
						sex = "une femme"
					end
					TriggerServerEvent('meleeInProgressPos', plyPos.x, plyPos.y, plyPos.z)
					if s2 == 0 then
						TriggerServerEvent('meleeInProgressS1', street1, sex)
					elseif s2 ~= 0 then
						TriggerServerEvent("meleeInProgress", street1, street2, sex)
					end
				end)
				Wait(3000)
			end
        end
    end
end)
]]
Citizen.CreateThread( function()
    while true do
        Wait(0)
        
                if IsPedShooting(GetPlayerPed(-1)) and GetSelectedPedWeapon(GetPlayerPed(-1)) ~= GetHashKey("weapon_stungun") and GetSelectedPedWeapon(GetPlayerPed(-1)) ~= GetHashKey("weapon_ball") and GetSelectedPedWeapon(GetPlayerPed(-1)) ~= GetHashKey("weapon_petrolcan") and GetSelectedPedWeapon(GetPlayerPed(-1)) ~= GetHashKey("weapon_fireextinguisher") and GetSelectedPedWeapon(GetPlayerPed(-1)) ~= GetHashKey("weapon_snowball") then

        	local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
        	local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
        	local street1 = GetStreetNameFromHashKey(s1)
        	local street2 = GetStreetNameFromHashKey(s2)
            DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 2)
			if PlayerData.job ~= nil and PlayerData.job.name == 'police' and showcopsmisbehave == false then
			elseif PlayerData.job ~= nil and PlayerData.job.name == 'police' and showcopsmisbehave then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					local sex = nil
					if skin.sex == 0 then
						sex = "Mężczyzna"
					else
						sex = "Kobieta"
					end
				--	print("ulica:",s2)
					TriggerServerEvent('gunshotInProgressPos', plyPos.x, plyPos.y, plyPos.z,PlayerData.job.name)
					if s2 == 0 then
						TriggerServerEvent('gunshotInProgressS1', street1, sex)
					elseif s2 ~= 0 then
						TriggerServerEvent("gunshotInProgress", street1, street2, sex)
					end
				end)
				Wait(3000)
			else
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					local sex = nil
					if skin.sex == 0 then
						sex = "Mężczyzna"
					else
						sex = "Kobieta"
					end
					TriggerServerEvent('gunshotInProgressPos', plyPos.x, plyPos.y, plyPos.z,PlayerData.job.name)
					if s2 == 0 then
						TriggerServerEvent('gunshotInProgressS1', street1, sex)
					elseif s2 ~= 0 then
						TriggerServerEvent("gunshotInProgress", street1, street2, sex)
					end
				end)
				Wait(3000)
			end
        end
    end
end)

Citizen.CreateThread( function()
    while true do
    Wait(50)
    	local isInVehicle = IsPedInAnyVehicle(GetPlayerPed(-1), true)
        if isInVehicle then
            local playerPed = GetPlayerPed(-1)
            local currentVehicle = GetVehiclePedIsIn(playerPed, false)
            local speed = GetEntitySpeed(currentVehicle) * 2.236936
            local driverPed = GetPedInVehicleSeat(GetVehiclePedIsUsing(GetPlayerPed(-1)), -1)
            local carName = GetDisplayNameFromVehicleModel(GetEntityModel(currentVehicle))
            local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
            local class = GetVehicleClass(currentVehicle)
        --[[if class == 0 or class == 1 or class == 3 or class == 4 or class == 5 or class == 6 or class == 7 or class == 13 then
            	SetPlayerCanDoDriveBy(PlayerId(), false)
            else
            	SetPlayerCanDoDriveBy(PlayerId(), true)
            end]]
            if driverPed == GetPlayerPed(-1) then                  
                if speed > 140 and not IsPedInAnyHeli(GetPlayerPed(-1)) then
                    if math.random(1000) < 100 then
                    	if PlayerData.job ~= nil and PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'ambulance' then
	                    	TriggerServerEvent('fastDrivingx', carName)
	                        TriggerServerEvent('fastDrivingpos', plyPos.x, plyPos.y, plyPos.z)
	                        Wait(60000)
	                    end
                    end
                end
            else
                Citizen.Wait(1000)
            end
        else
             Citizen.Wait(5000)
        end
    end
end)