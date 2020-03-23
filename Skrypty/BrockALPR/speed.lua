--[[------------------------------------------------------------------------

	Radar/ALPR 
	Created by Brock =]
	Uses Numpad5 to turn on
    Uses Numpad8 to freeze	

------------------------------------------------------------------------]]--
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job

	Citizen.Wait(5000)
	TriggerServerEvent('esx_policejob:forceBlip')
end)

local enteredPolice = false
local radar =
{
	shown = false,
	freeze = false,
	info = "~y~Inicjalizacja ALPR...~w~321...~y~Załadowany! ",
	info2 = "~y~Inicjalizacja ALPR...~w~321...~y~Załadowany! ",
	minSpeed = 5.0,
	maxSpeed = 75.0,
}
--local distanceToCheckFront = 50

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(1)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end
local fplate = "" -- potrzebne do tabletu
Citizen.CreateThread( function()
	
	while true do
		Citizen.Wait(0)
		if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
			if IsControlJustPressed(1, 314) then 
				if radar.shown then 
					radar.shown = false 
					radar.info = string.format("~y~Inicjalizacja ALPR...~w~321...~y~Załadowany! ")
					radar.info2 = string.format("~y~Inicjalizacja ALPR...~w~321...~y~Załadowany! ")
				else 
					radar.shown = true 
				end		
	                Citizen.Wait(75)
	        end
			
		end
		if IsPedInAnyPoliceVehicle(PlayerPedId()) then
			if IsControlJustPressed(1, 127) then 
				if radar.freeze then radar.freeze = false else radar.freeze = true end
			end
			if IsControlJustPressed(1, 126) and PlayerData.job.name == 'police' then 
				--if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(),false),-1) ~= PlayerPedId() then
					if fplate ~= nil then 
						TriggerEvent('tablet:showOwner',fplate)
					--end
				end
			end
	
		end
		if radar.shown  then
			if radar.freeze == false then
					local veh = GetVehiclePedIsIn(PlayerPedId(), false)
					local coordA = GetOffsetFromEntityInWorldCoords(veh, 0.0, 1.0, 1.0)
					local coordB = GetOffsetFromEntityInWorldCoords(veh, 0.0, 105.0, 0.0)
					local frontcar = StartShapeTestCapsule(coordA, coordB, 3.0, 10, veh, 7)
					local a, b, c, d, e = GetShapeTestResult(frontcar)
					
					if IsEntityAVehicle(e) then
						
						local fmodel = GetDisplayNameFromVehicleModel(GetEntityModel(e))
						local fvspeed = GetEntitySpeed(e)*2.236936
						fplate = GetVehicleNumberPlateText(e)
						radar.info = string.format("~g~T: ~w~%s  ~g~M: ~w~%s  ~g~P: ~w~%s mph", fplate, fmodel, math.ceil(fvspeed))
					end
					
					local bcoordB = GetOffsetFromEntityInWorldCoords(veh, 0.0, -105.0, 0.0)
					local rearcar = StartShapeTestCapsule(coordA, bcoordB, 3.0, 10, veh, 7)
					local f, g, h, i, j = GetShapeTestResult(rearcar)
					
					if IsEntityAVehicle(j) then
					
						local bmodel = GetDisplayNameFromVehicleModel(GetEntityModel(j))
						local bvspeed = GetEntitySpeed(j)*2.236936
						local bplate = GetVehicleNumberPlateText(j)
						radar.info2 = string.format("~g~T: ~w~%s  ~g~M: ~w~%s  ~g~P: ~w~%s mph", bplate, bmodel, math.ceil(bvspeed))
					
					
					end
					
			end
			
			DrawRect(0.0855, 0.83, 0.142, 0.05, 0, 0, 0, 150)
			DrawAdvancedText(0.111, 0.824, 0.005, 0.0028, 0.38, "/\\ ", 0, 191, 255, 255, 6, 1)
			DrawAdvancedText(0.111, 0.845, 0.005, 0.0028, 0.38, "\\/ ", 0, 191, 255, 255, 6, 1)
			if radar.freeze then
				DrawAdvancedText(0.12, 0.824, 0.005, 0.0028, 0.38, "~r~! " .. radar.info.. " ~r~!", 255, 255, 255, 255, 6, 1)
				DrawAdvancedText(0.12, 0.845, 0.005, 0.0028, 0.38,"~r~! " .. radar.info2.. " ~r~!", 255, 255, 255, 255, 6, 1)
			else
				DrawAdvancedText(0.12, 0.824, 0.005, 0.0028, 0.38, radar.info, 255, 255, 255, 255, 6, 1)
				DrawAdvancedText(0.12, 0.845, 0.005, 0.0028, 0.38, radar.info2, 255, 255, 255, 255, 6, 1)
			end

			
		end
		
		if(not IsPedInAnyVehicle(GetPlayerPed(-1))) then
			radar.shown = false
			radar.info = string.format("~y~Inicjalizacja ALPR...~w~321...~y~Załadowany! ")
			radar.info2 = string.format("~y~Inicjalizacja ALPR...~w~321...~y~Załadowany! ")
			Citizen.Wait(5000)
		end
					
	end
	
	
end)

