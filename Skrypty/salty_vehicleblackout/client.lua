-- No need to modify any of this, but I tried to document what it's doing
local isBlackedOut = false
local oldBodyDamage = 0
local oldSpeed = 0
local impact = 0
local isShaking = false -- someguy
local disableIndicator = true
local speedBuffer  = {}
local velBuffer    = {}
local beltOn       = false
local wasInCar     = false
local justEntered = false
local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }

local directions = { [0] = 'N', [45] = 'NW', [90] = 'W', [135] = 'SW', [180] = 'S', [225] = 'SE', [270] = 'E', [315] = 'NE', [360] = 'N', } 




local colorNames = {
    ['0'] = "Czarny",
    ['1'] = "Czarny",
    ['2'] = "Czarny",
    ['3'] = "Szary",
    ['4'] = "Szary",
    ['5'] = "Szary",
    ['6'] = "Szary",
    ['7'] = "Szary",
    ['8'] = "Szary",
    ['9'] = "Szary",
    ['10'] = "Szary",
    ['11'] = "Szary",
    ['12'] = "czarny",
    ['13'] = "Szary",
    ['14'] = "Szary",
    ['15'] = "Czarny",
    ['16'] = "Czarny",
    ['17'] = "Szary",
    ['18'] = "Szary",
    ['19'] = "Szary",
    ['20'] = "Szary",
    ['21'] = "Czarny",
    ['22'] = "Szary",
    ['23'] = "Szary",
    ['24'] = "Szary",
    ['25'] = "Szary",
    ['26'] = "Szary",
    ['27'] = "Czerwony",
    ['28'] = "Czerwony",
    ['29'] = "Czerwony",
    ['30'] = "Czerwony",
    ['31'] = "Czerwony",
    ['32'] = "Czerwony",
    ['33'] = "Czerwony",
    ['34'] = "Czerwony",
    ['35'] = "Czerwony",
    ['36'] = "Pomarańczowy",
    ['37'] = "Złoty",
    ['38'] = "Pomarańczowy",
    ['39'] = "Czerwony",
    ['40'] = "Czerwony",
    ['41'] = "Pomarańczowy",
    ['42'] = "Żółty",
    ['43'] = "Czerwony",
    ['44'] = "Czerwony",
    ['45'] = "Czerwony",
    ['46'] = "Czerwony",
    ['47'] = "Pomarańczowy",
    ['48'] = "Brązowy",
    ['49'] = "Zielony",
    ['50'] = "Zielony",
    ['51'] = "Zielony",
    ['52'] = "Zielony",
    ['53'] = "Zielony",
    ['54'] = "Turkusowy",
    ['55'] = "Zielone",
    ['56'] = "Zielony",
    ['57'] = "Zielony",
    ['58'] = "Zielony",
    ['59'] = "Zielony",
    ['60'] = "Zielony",
    ['61'] = "Niebieski",
    ['62'] = "Niebieski",
    ['63'] = "Niebieski",
    ['64'] = "Niebieski",
    ['65'] = "Niebieski",
    ['66'] = "Niebieski",
    ['67'] = "Biały",
    ['68'] = "Niebieski",
    ['69'] = "Niebieski",
    ['70'] = "Niebieski",
    ['71'] = "Fioletowy",
    ['72'] = "Fioletowy",
    ['73'] = "Niebieski",
    ['74'] = "Niebieski",
    ['75'] = "Niebieski",
    ['76'] = "Fioletowy",
    ['77'] = "Niebieski",
    ['78'] = "Niebieski",
    ['79'] = "Niebieski",
    ['80'] = "Niebieski",
    ['81'] = "Niebieski",
    ['82'] = "Niebieski",
    ['83'] = "Niebieski",
    ['84'] = "Niebieski",
    ['85'] = "Niebieski",
    ['86'] = "Niebieski",
    ['87'] = "Niebieski",
    ['88'] = "Żółty",
    ['89'] = "Żółty",
    ['90'] = "Brązowy",
    ['91'] = "Żółty",
    ['92'] = "Zielony",
    ['93'] = "Brązowy",
    ['94'] = "Brązowy",
    ['95'] = "Brązowy",
    ['96'] = "Brązowy",
    ['97'] = "Brązowy",
    ['98'] = "Beżowy",
    ['99'] = "Zielony",
    ['100'] = "Brązowy",
    ['101'] = "Beżowy",
    ['102'] = "Brązowy",
    ['103'] = "Brązowy",
    ['104'] = "Brązowy",
    ['105'] = "Beżowy",
    ['106'] = "Beżowy",
    ['107'] = "Beżowy",
    ['108'] = "Szary",
    ['109'] = "Brązowy",
    ['110'] = "Brązowy",
    ['111'] = "Biały",
    ['112'] = "Biały",
    ['113'] = "Beżowy",
    ['114'] = "Brązowy",
    ['115'] = "Szary",
    ['116'] = "Beżowy",
    ['117'] = "Szary",
    ['118'] = "Szary",
    ['119'] = "Szary",
    ['120'] = "Chrome",
    ['121'] = "Biały",
    ['122'] = "Biały",
    ['123'] = "Żółty",
    ['124'] = "Pomarańczowy",
    ['125'] = "Zielony",
    ['126'] = "Żółty",
    ['127'] = "Niebieski",
    ['128'] = "Zielony",
    ['129'] = "Brązowy",
    ['130'] = "Pomarańczowy",
    ['131'] = "Biały",
    ['132'] = "Biały",
    ['133'] = "Zielony",
    ['134'] = "Pure White",
    ['135'] = "Różowy",
    ['136'] = "Różowy",
    ['137'] = "Różowy",
    ['138'] = "Pomarańczowy",
    ['139'] = "Zielony",
    ['140'] = "Niebieski",
    ['141'] = "Czarny",
    ['142'] = "Fioletowy",
    ['143'] = "Brązowy",
    ['144'] = "Zielony",
    ['145'] = "Fioletowy",
    ['146'] = "Niebieski",
    ['147'] = "Czarny",
    ['148'] = "Fioletowy",
    ['149'] = "Fioletowy",
    ['150'] = "Czerwony",
    ['151'] = "Zielony",
    ['152'] = "Zielony",
    ['153'] = "Beżowy",
    ['154'] = "Beżowy",
    ['155'] = "Zielony",
    ['156'] = "Zielony",
    ['157'] = "Niebieski",
}
IsCar = function(veh)
                    local vc = GetVehicleClass(veh)
                    return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
        end

Fwv = function (entity)
                    local hr = GetEntityHeading(entity) + 90.0
                    if hr < 0.0 then hr = 360.0 + hr end
                    hr = hr * 0.0174533
                    return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
      end

local function blackout()
	-- Only blackout once to prevent an extended blackout if both speed and damage thresholds were met
	if not isBlackedOut then
		isBlackedOut = true
		-- This thread will black out the user's screen for the specified time
		Citizen.CreateThread(function()
			--DoScreenFadeOut(100)	
--			TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 1.5, "heart", 1.0)
		--	isBlackedOut = true
			DoScreenFadeOut(50)

			local ped = GetPlayerPed(-1)
            local car = GetVehiclePedIsIn(ped)
            local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
						local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
						local street1 = GetStreetNameFromHashKey(s1)
						local street2 = GetStreetNameFromHashKey(s2)
                        local current_zone = zones[GetNameOfZone(plyPos.x, plyPos.y, plyPos.z)]
						TriggerServerEvent('esx_jb_outlawalert:kolizjablip', plyPos.x, plyPos.y, plyPos.z)
                        for k,v in pairs(directions)do
                            direction = GetEntityHeading(GetPlayerPed(-1))
                            if(math.abs(direction - k) < 22.5)then
                                direction = v
                                break;
                            end
                        end
		        		local ped = GetPlayerPed(-1)
                        local car = GetVehiclePedIsIn(ped)
                        local vehName = GetDisplayNameFromVehicleModel(GetEntityModel(car))
							local vehName2 = GetLabelText(vehName)
							local plate = GetVehicleNumberPlateText(car)
							local primary, secondary = GetVehicleColours(car)
							if primary ~= nil then
								primary = colorNames[tostring(primary)]
							else
								primary = "-"
							end
							if secondary ~= nil then 
								secondary = colorNames[tostring(secondary)]
							else
								secondary = "-"
							end
						if s2 == 0 then
								TriggerServerEvent('esx_jb_outlawalert:kolizjaalertS1', street1, vehName2, current_zone, plate, primary, secondary)
								--print(street1)
						elseif s2 ~= 0 then
								TriggerServerEvent('esx_jb_outlawalert:kolizjaalert', street1, street2, vehName2, current_zone, plate, primary, secondary)
								--print(street1)
						end
                	if car ~= 0 and (wasInCar or IsCar(car)) then
				wasInCar = true
				if beltOn then DisableControlAction(0, 75) end
				local co = GetEntityCoords(ped)
                                local fw = Fwv(ped)
			---	if beltOn then
			--		print("PASY ZAPIETE")
			--	else
			--		print("PASY odpiete "..GetEntitySpeedVector(car, true).y )
			--	end
				if  not beltOn  then
					SetEntityCoords(ped, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
                                	SetEntityVelocity(ped, velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
                                	Citizen.Wait(1)
                                	ShakeGameplayCam('VIBRATE_SHAKE', 1.0)
                                	SetPedToRagdoll(ped, 15000, 15000, 0, 0, 0, 0)	
					SetEntityHealth(GetPlayerPed(-1), 50)
					TriggerEvent('esx_ambulancejob:damagedwalkmode')
				end
                	elseif wasInCar then
                        	wasInCar = false
                        	beltOn = false 
                	end
                
			StartScreenEffect("DrugsDrivingIn",3000,false)	-- Start the injured effect
			while not IsScreenFadedOut() do
				Citizen.Wait(0)
			end
			--DoScreenFadeOut(100)
			TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 0.5, "heart", 0.4)
  			--Citizen.Wait(Config.BlackoutTime)			
  			if beltOn then
				local currentHealth = GetEntityHealth(GetPlayerPed(-1))
				if impact <= 50 then -- Blackout duration depending on impact speed, 1000 is 1 sec
					Citizen.Wait(2000)
				elseif impact > 50 and impact <= 60 then
					Citizen.Wait(3000)
					SetEntityHealth(GetPlayerPed(-1), currentHealth - 40)
				elseif impact > 60 and impact <= 70 then
					Citizen.Wait(3000)
					SetEntityHealth(GetPlayerPed(-1), currentHealth - 50)
				elseif impact > 70 and impact <= 80 then
					Citizen.Wait(3000)
					SetEntityHealth(GetPlayerPed(-1), currentHealth - 60)
				else 
					Citizen.Wait(3000)
					SetEntityHealth(GetPlayerPed(-1), currentHealth - 70) -- This setting cause death to passengers, try 100 if you want very low life.
				end
			else
				Citizen.Wait(3000)
		
			end
			ShakeGameplayCam('VIBRATE_SHAKE', 1.0)
			DoScreenFadeIn(2500)
			ShakeGameplayCam('VIBRATE_SHAKE', 1.0)
			DoScreenFadeOut(250)
			ShakeGameplayCam('VIBRATE_SHAKE', 1.0)
			DoScreenFadeIn(250)

			SetFollowVehicleCamViewMode(4) -- Force first person view in the car to increase the blinking wakening and blinking effect
			
			if not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") then -- move_m@injured or MOVE_M@DRUNK@VERYDRUNK or move_injured_generic
				RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK")
				while not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") do
					Citizen.Wait(0)
				end
			end	
			SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@VERYDRUNK", 1.0) -- Set the injured ped move, best one is verydrunk in my opinion.
			DoScreenFadeIn(1800) -- Blinking effect
			Citizen.Wait(1000)
			DoScreenFadeOut(1600)
			Citizen.Wait(800)
			DoScreenFadeIn(400)
			Citizen.Wait(600)
			DoScreenFadeOut(1100)
			isBlackedOut = false -- Release controls to the player after 2 blinks (added a disable camera mode to force FPS and a disable multiplayer talking)
			Citizen.Wait(100)
			DoScreenFadeIn(000)
			Citizen.Wait(200)
			DoScreenFadeOut(900)
			Citizen.Wait(900)
			DoScreenFadeIn(800)
			Citizen.Wait(100)
			DoScreenFadeOut(700)
			Citizen.Wait(700)
			DoScreenFadeIn(600)	
			
			if impact <= 50 then -- Injured visual effect duration, depending on impact speed
				Citizen.Wait(100)
			elseif impact > 50 and impact <= 60 then
				Citizen.Wait(500)
			elseif impact > 60 and impact <= 70 then
				Citizen.Wait(1000)
			elseif impact > 70 and impact <= 80 then
				Citizen.Wait(1500)
			else 
				Citizen.Wait(8000)
			end			
			
			StopScreenEffect("DrugsDrivingIn") -- Stop the injured effect to introduce the smooth injured effect exit
			
			if impact <= 50 then -- Smooth exit, duration depending on impact speed, again
				StartScreenEffect("DrugsDrivingOut",1000,false)
				Citizen.Wait(1200)
				ResetPedMovementClipset(GetPlayerPed(-1))
				ResetPedWeaponMovementClipset(GetPlayerPed(-1))
				ResetPedStrafeClipset(GetPlayerPed(-1))
			elseif impact > 50 and impact <= 60 then
				StartScreenEffect("DrugsDrivingOut",2000,false)
				Citizen.Wait(2200)
				ResetPedMovementClipset(GetPlayerPed(-1))
				ResetPedWeaponMovementClipset(GetPlayerPed(-1))
				ResetPedStrafeClipset(GetPlayerPed(-1))
			elseif impact > 60 and impact <= 70 then
				StartScreenEffect("DrugsDrivingOut",3000,false)
				Citizen.Wait(4200)
				ResetPedMovementClipset(GetPlayerPed(-1))
				ResetPedWeaponMovementClipset(GetPlayerPed(-1))
				ResetPedStrafeClipset(GetPlayerPed(-1))
			elseif impact > 70 and impact <= 80 then
				StartScreenEffect("DrugsDrivingOut",5000,false)
				Citizen.Wait(7200)
				ResetPedMovementClipset(GetPlayerPed(-1))
				ResetPedWeaponMovementClipset(GetPlayerPed(-1))
				ResetPedStrafeClipset(GetPlayerPed(-1))
			else 
				StartScreenEffect("DrugsDrivingOut",8000,false)
				Citizen.Wait(8200)
				ResetPedMovementClipset(GetPlayerPed(-1))
				ResetPedWeaponMovementClipset(GetPlayerPed(-1))
				ResetPedStrafeClipset(GetPlayerPed(-1))
			end
--
--isBlackedOut = false
		end)
	end
end

local function shake()
	

        -- Only blackout once to prevent an extended blackout if both speed and damage thresholds were met
        if not isShaking then
                isShaking = true
                -- This thread will black out the user's screen for the specified time
                Citizen.CreateThread(function()
                  --      DoScreenFadeOut(100)
                      isShaking = true
                    --    while not IsScreenFadedOut() do
                      --          Citizen.Wait(0)
                        --end
                      ShakeGameplayCam('LARGE_EXPLOSION_SHAKE', 1.0)
                --        Citizen.Wait(Config.BlackoutTime)
                  --      DoScreenFadeIn(250)
                  		local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
						local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
						local street1 = GetStreetNameFromHashKey(s1)
						local street2 = GetStreetNameFromHashKey(s2)
                        local current_zone = zones[GetNameOfZone(plyPos.x, plyPos.y, plyPos.z)]
						
                        for k,v in pairs(directions)do
                            direction = GetEntityHeading(GetPlayerPed(-1))
                            if(math.abs(direction - k) < 22.5)then
                                direction = v
                                break;
                            end
                        end
		        		local ped = GetPlayerPed(-1)
                        local car = GetVehiclePedIsIn(ped)
						Citizen.Wait(100)
						--print(GetVehicleEngineHealth(car))
						if GetVehicleEngineHealth(GetVehiclePedIsIn(GetPlayerPed(-1))) <= 100 then
							TriggerServerEvent('esx_jb_outlawalert:kolizjablip', plyPos.x, plyPos.y, plyPos.z)
							local vehName = GetDisplayNameFromVehicleModel(GetEntityModel(car))
							local vehName2 = GetLabelText(vehName)
							local plate = GetVehicleNumberPlateText(car)
							local primary, secondary = GetVehicleColours(car)
							primary = colorNames[tostring(primary)]
							secondary = colorNames[tostring(secondary)]
							if s2 == 0 then
									TriggerServerEvent('esx_jb_outlawalert:kolizjaalertS1', street1, vehName2, current_zone, direction, plate, primary, secondary)
							elseif s2 ~= 0 then
									TriggerServerEvent('esx_jb_outlawalert:kolizjaalert', street1, street2, vehName2, current_zone, direction,plate, primary, secondary)
							end                       
						end
						if car ~= 0 and (wasInCar or IsCar(car)) then
                                wasInCar = true
                                if beltOn then DisableControlAction(0, 75) end
                                local co = GetEntityCoords(ped)
                                local fw = Fwv(ped)
                                local currentHealth = GetEntityHealth(ped)
                                if beltOn then
	                                if impact <= 50 then -- Blackout duration depending on impact speed, 1000 is 1 sec
	                              	  SetEntityHealth(GetPlayerPed(-1), currentHealth - 10)
									elseif impact > 50 and impact <= 60 then									
										SetEntityHealth(GetPlayerPed(-1), currentHealth - 20)
									elseif impact > 60 and impact <= 70 then
										SetEntityHealth(GetPlayerPed(-1), currentHealth - 50)
									elseif impact > 70 and impact <= 80 then
										SetEntityHealth(GetPlayerPed(-1), currentHealth - 60)
									else 
										SetEntityHealth(GetPlayerPed(-1), 80) -- This setting cause death to passengers, try 100 if you want very low life.
									end
								else
									 if impact <= 50 then -- Blackout duration depending on impact speed, 1000 is 1 sec
	                                	SetEntityHealth(GetPlayerPed(-1), currentHealth - 30)
									elseif impact > 50 and impact <= 60 then									
										SetEntityHealth(GetPlayerPed(-1), currentHealth - 40)
									elseif impact > 60 and impact <= 70 then
										SetEntityHealth(GetPlayerPed(-1), currentHealth - 60)
									elseif impact > 70 and impact <= 80 then
										SetEntityHealth(GetPlayerPed(-1), currentHealth - 70)
									else 
										SetEntityHealth(GetPlayerPed(-1), 90) -- This setting cause death to passengers, try 100 if you want very low life.
									end
								end
								if  not beltOn and GetEntitySpeedVector(car, true).y > 2.0 then
				
                                        SetEntityCoords(ped, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
                                        SetEntityVelocity(ped, velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
                                        Citizen.Wait(1)
                                        ShakeGameplayCam('LARGE_EXPLOSION_SHAKE', 1.0)
                                        SetPedToRagdoll(ped, 5000, 5000, 0, 0, 0, 0)

                                end 
                        elseif wasInCar then
                                wasInCar = false
                                beltOn = false
                        end
                        isShaking = false

                end)
        end
end

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
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
	local factor = (string.len(text)) / 370
    --DrawRect(x-0.09,y-0.003, factor+0.020, 0.03, 0, 0, 0, 68)
end
local engineHealthFix = 0
Citizen.CreateThread(function()
	while true do
		
		engineHealthFix = GetVehicleEngineHealth(GetVehiclePedIsIn(GetPlayerPed(-1)))
		Citizen.Wait(3000)
	end 
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
			
		
		 
                        
                
    	
		HideLoadingOnFadeThisFrame() -- Hide loading logo while blackout
		-- Get the vehicle the player is in, and continue if it exists
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        
		local vehicleClass = GetVehicleClass(vehicle)
		local isCar = false
		local model_name = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
		
		if  vehicleClass ~= 13 and vehicleClass ~= 8 and vehicleClass ~= 14 and model_name ~= "POLICEB" then
			isCar = true
		end
		if DoesEntityExist(vehicle) then
            disableIndicator = true
            if not justEntered and isCar then
            TriggerEvent('esx_customui:togHealth', false)
            TriggerEvent('esx_customui:togBeltsOn', false)
            TriggerEvent('esx_customui:togBelts', true)
            
            justEntered = true
            end
			if beltOn  and isCar then
				DisableControlAction(0, 75)
				--DrawAdvancedText(0.112 , 0.807 , 0.005, 0.0028, 0.4, "P",76, 175, 80, 255, 6, 1)
                

			elseif not beltOn and isCar then 
				--DrawAdvancedText(0.112 , 0.807 , 0.005, 0.0028, 0.4, "P", 255, 67,54, 255, 6, 1)
                
			end
			if IsControlJustReleased(1, 29)   and isCar then
               			SetVehicleHasBeenOwnedByPlayer(vehicle, true)
				SetEntityAsMissionEntity(vehicle, true, true)
                                beltOn = not beltOn
                                if beltOn then 
					TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 0.5, "seaton", 0.4)
                    TriggerEvent('esx_customui:togBeltsOn', true)
                                else 
					TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 0.5, "seatoff", 0.4)                    
                    TriggerEvent('esx_customui:togBeltsOn', false)
    
				end
                        end
			velBuffer[2] = velBuffer[1]
                        velBuffer[1] = GetEntityVelocity(car)
			-- Check if damage blackout is enabled
			if Config.BlackoutFromDamage then
				local currentDamage = GetVehicleBodyHealth(vehicle)
				-- If the damage changed, see if it went over the threshold and blackout if necesary
				if currentDamage ~= oldBodyDamage then
					if not isBlackedOut and (currentDamage < oldBodyDamage) and ((oldBodyDamage - currentDamage) >= Config.BlackoutDamageRequired) then
					Citizen.Wait(50)
						if engineHealthFix ~= GetVehicleEngineHealth(GetVehiclePedIsIn(GetPlayerPed(-1))) then
						
							blackout()
							--print("Engine fixed: "..engineHealthFix)
							--print("Engine current: "..GetVehicleEngineHealth(GetVehiclePedIsIn(GetPlayerPed(-1))))
						end

					end
					oldBodyDamage = currentDamage
				end
			end
			
			-- Check if speed blackout is enabled
			if Config.BlackoutFromSpeed then
				local currentSpeed = GetEntitySpeed(vehicle) * 2.23
				-- If the speed changed, see if it went over the threshold and blackout if necesary
				if currentSpeed ~= oldSpeed then
					if not isBlackedOut and (currentSpeed < oldSpeed) and ((oldSpeed - currentSpeed) >= Config.BlackoutSpeedRequired) then
						impact = (oldSpeed - currentSpeed)
						--print("pre blackout Engine fixed: "..engineHealthFix)
							--print("pre blackout  Engine current: "..GetVehicleEngineHealth(GetVehiclePedIsIn(GetPlayerPed(-1))))
							ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 1.0)
							Citizen.Wait(200)
						if engineHealthFix ~= GetVehicleEngineHealth(vehicle) then
							blackout()
							
						end
						
					elseif not isShaking and (currentSpeed < oldSpeed) and ((oldSpeed - currentSpeed) >= Config.ShakeSpeedRequired) then
						impact = (oldSpeed - currentSpeed)
							--print("pre shake Engine fixed: "..engineHealthFix)
							--print("pre shake Engine current: "..GetVehicleEngineHealth(GetVehiclePedIsIn(GetPlayerPed(-1))))
							ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 1.0)
							Citizen.Wait(200)
						if engineHealthFix ~= GetVehicleEngineHealth(vehicle) then
							shake()
						end
						


					end
					oldSpeed = currentSpeed
				end
			end
		else
            
            if  disableIndicator  and not DoesEntityExist(vehicle) then
                
            TriggerEvent('esx_customui:togHealth', true)
            TriggerEvent('esx_customui:togBelts', false)
            TriggerEvent('esx_customui:togBeltsOn', false)
            disableIndicator = false
            end
            justEntered = false
			beltOn = false
			oldBodyDamage = 0
			oldSpeed = 0
		end
		
		if isBlackedOut and Config.DisableControlsOnBlackout then
			-- Borrowed controls from https://github.com/Sighmir/FiveM-Scripts/blob/master/vrp/vrp_hotkeys/client.lua
			DisableControlAction(0,71,true) -- veh forward
			DisableControlAction(0,72,true) -- veh backwards
			DisableControlAction(0,63,true) -- veh turn left
			DisableControlAction(0,64,true) -- veh turn right
			DisableControlAction(0,75,true) -- disable exit vehicle


		end
	end
end)
