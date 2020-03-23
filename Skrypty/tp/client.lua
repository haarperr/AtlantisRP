local key_to_teleport = 38

local positions = {
    --{{1867.42, 3666.11, 33.30, 0}, {1863.09, 3673.94, 33.3, 0}, "Press [~b~E~w~] asd", true}, -- Outside the Sheriff's Station
    --{{1860.72, 3661.49, 33.00, 0}, {1855.02, 3673.86, 33.3, 0}, "Press [~b~E~w~] 2222 asd", false},
	--{{10.32, -670.94, 33.00, 0}, {6.12, -707.53, 15.5, 0}, "Naciśnij [~b~E~w~], aby zjechać do skarbca Union Depository", false},
    {{638.1805, 1.6979088, 82.78642, 0}, {2033.442, 2942.413, -61.90175, 0}, "Naciśnij [~b~E~w~], aby wejść/wyjść", false},
    {{2038.281, 2934.502, -61.901, 0}, {535.814, -21.631, 70.629, 0}, "Naciśnij [~b~E~w~], aby wejść/wyjść", false},
    {{2039.75, 2968.97, -61.90, 0}, {565.72, 4.547, 103.23, 0}, "Naciśnij [~b~E~w~], aby wejść/wyjść", false},
    {{-458.82, 284.77, 78.52, 246.88}, {-430.26, 261.41, 83.01, 350.14}, "Naciśnij [~b~E~w~], aby wejść/wyjść", false},
    --{{-1496.03, -1031.61, 10.52, 320.7}, {-1495.33, -1030.81, 10.52, 323.68}, "Naciśnij [~b~E~w~], aby wejść/wyjść.", false},
    {{-1077.94, -254.73, 37.05, 0}, {-1072.20, -246.42, 53.51, 0}, "Naciśnij [~b~E~w~], aby użyć windy", false},
	--{{983.94, -130.08, 73.00, 60.00}, {998.19, -3164.72, -38.51, 270.00}, "Naciśnij [~b~E~w~], aby wjechać do garażu", true},
	--{{-1390.5, -3258.48, 13.00, 335.00}, {-1265.37, -2969.98, -49.3, 172.00}, "Naciśnij [~b~E~w~], aby wjechać do hangaru", true},
	{{144.11, -688.92, 32.70, 0}, {136.105, -762.03, 45.12, 0}, "Naciśnij [~b~E~w~], aby użyć windy (parking)", false},
	{{138.913177, -762.8463, 45.35, 0}, {136.000567627, -761.9922, 241.851672, 0}, "Naciśnij [~b~E~w~], aby użyć windy (lobby)", false},
	{{1088.68, -3187.5, -39.10, 0}, {2855.1, 1480.2, 24.65, 0}, "Naciśnij [~b~E~w~], aby wejść/wyjść", false},
    --[[
    {{x, y, z, Heading} -od , {x, y, z, Heading} - do, "tekst do wyswietlenia", true/false - jeśli ma być to teleport dla samochodu},
    ]]
}

-----------------------------------------------------------------------------
-------------------------DO NOT EDIT BELOW THIS LINE------------------------- jakei do not edit kurwa jak tu poprawki trza
-----------------------------------------------------------------------------

local player = GetPlayerPed(-1)
local playerLoc = GetEntityCoords(player)
local isInVehicle = IsPedInAnyVehicle(player, true)
local radius = 1.5
Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(400)
        player = GetPlayerPed(-1)
        playerLoc = GetEntityCoords(player)
        isInVehicle = IsPedInAnyVehicle(player, true)
        if isInVehicle then
            radius = 10 
        else
            radius = 1.5
        end
    end
end)
Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(5)

        for i,location in ipairs(positions) do
            teleport_text = location[3]
            vehicle = location[4]
            loc1 = {
                x=location[1][1],
                y=location[1][2],
                z=location[1][3],
                heading=location[1][4]
            }
            loc2 = {
                x=location[2][1],
                y=location[2][2],
                z=location[2][3],
                heading=location[2][4]
            }
            

           -- DrawMarker(1, loc1.x, loc1.y, loc1.z, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, 0, 0, 255, 200, 0, 0, 0, 0)
            --DrawMarker(1, loc2.x, loc2.y, loc2.z, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, 0, 0, 255, 200, 0, 0, 0, 0)

            if CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc1.x, loc1.y, loc1.z, radius) then 
                --alert(teleport_text)
                DrawText3Ds(loc1.x, loc1.y, loc1.z+0.5, teleport_text)
                if IsControlJustReleased(1, key_to_teleport) then
                    if IsPedInAnyVehicle(player, true) then
                        if vehicle then
                            DoScreenFadeOut(1000)
                            Citizen.Wait(1000)
                            SetEntityCoords(GetVehiclePedIsUsing(player), loc2.x, loc2.y, loc2.z)
                            SetEntityHeading(GetVehiclePedIsUsing(player), loc2.heading)
                            Citizen.Wait(1000)
                            DoScreenFadeIn(1000)
                        end
                    else
                        DoScreenFadeOut(1000)
                        Citizen.Wait(1000)
                        SetEntityCoords(player, loc2.x, loc2.y, loc2.z)
                        SetEntityHeading(player, loc2.heading)
                        Citizen.Wait(1000)
                        DoScreenFadeIn(1000)
                    end
                end

            elseif CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc2.x, loc2.y, loc2.z, radius) then
               -- alert(teleport_text)
                DrawText3Ds(loc2.x, loc2.y, loc2.z+0.5, teleport_text)
                if IsControlJustReleased(1, key_to_teleport) then
                    if IsPedInAnyVehicle(player, true) then
                        if vehicle then
                            DoScreenFadeOut(1000)
                            Citizen.Wait(1000)
                            SetEntityCoords(GetVehiclePedIsUsing(player), loc1.x, loc1.y, loc1.z)
                            SetEntityHeading(GetVehiclePedIsUsing(player), loc1.heading)
                            Citizen.Wait(1000)
                            DoScreenFadeIn(1000)
                        end
                    else
                        DoScreenFadeOut(1000)
                        Citizen.Wait(1000)
                        SetEntityCoords(player, loc1.x, loc1.y, loc1.z)
                        SetEntityHeading(player, loc1.heading)
                        Citizen.Wait(1000)
                        DoScreenFadeIn(1000)
                    end
                end       
            end            
        end
    end
end)

function CheckPos(x, y, z, cx, cy, cz, radius)
    local t1 = x - cx
    local t12 = t1^2

    local t2 = y-cy
    local t21 = t2^2

    local t3 = z - cz
    local t31 = t3^2

    return (t12 + t21 + t31) <= radius^2
end


function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.40, 0.40)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end