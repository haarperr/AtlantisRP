-- Local
local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
  Citizen.Wait(10000)
  TriggerEvent('fax-scoreboard:getHexOnStart')

end)
local userID = nil
local listOn = false
local hexUser = "ładuje"
local t = {}
local curUser = 0
local count = 0
local _lspd = 0
local _ems = 0
local _mecano = 0
local _ds = 0
local _taxi = 0
local _city = 0

RegisterNetEvent('fax-scoreboard:getJobs')
AddEventHandler('fax-scoreboard:getJobs', function(lspd, ems, mecano, ds, taxi, city)
       _lspd = lspd
       _ems = ems
       _mecano = mecano
       _ds = ds
       _taxi = taxi
       _city = city

end)

RegisterNetEvent('fax-scoreboard:getHexOnStart')
AddEventHandler('fax-scoreboard:getHexOnStart', function()
    
    local players = {}
    ptable = GetPlayers()
    for _, i in ipairs(ptable) do
      userID = GetPlayerServerId(i)
      if t[userID] == nil then
        t[userID] = "ładuję"
        TriggerServerEvent('fax-scoreboard:getHex', userID)
        Citizen.Wait(200)
      end
    end
end)

RegisterNetEvent('fax-scoreboard:setHex')
AddEventHandler('fax-scoreboard:setHex', function(hex, userID)
       t[userID] = hex
end)
Citizen.CreateThread(function()
    
    while true do
        Wait(0)

        if IsControlJustPressed(0, 48)--[[ INPUT_PHONE ]] then
            TriggerServerEvent('fax-scoreboard:sendMe')
            Citizen.Wait(2000)
        end
    end
end)
Citizen.CreateThread(function()
    listOn = false
    while true do
        Wait(0)

        if IsControlPressed(0, 48)--[[ INPUT_PHONE ]] then
            TriggerEvent('atlantisCam:displayZ', true)
            TriggerServerEvent('fax-scoreboard:ShowJobs')
            if not listOn then
                
                local players = {}
                ptable = GetPlayers()
                local kolumna = 1
                local count = 0
                for _ in pairs(players) do count = count + 1 end
                for _, i in ipairs(ptable) do

                    userID = GetPlayerServerId(i)
                    if t[userID] == nil then
                      t[userID] = "ładuję"
                      
                      TriggerServerEvent('fax-scoreboard:getHex', userID)
                      Citizen.Wait(200)
                    end

                   -- while true do
                     --   Citizen.Wait(10)
                     --   if t[userID] == nil then
                     --       print("pobieram hexa dla : ")
                      --      print(userID)
                      --      print(t[userID])
                            

                           -- ESX.TriggerServerCallback('fax-scoreboard:getHex', function(hex, id)
                             --   t[userID] = hex
                           --     print("dla ".. userID .. " przypisuje hexa: " .. hex)
                           --     if GetPlayerServerId(i) == id then
                           --         curUser = id
                            --    end
                           -- end, userID)
                     ------------   else
                   --         print("dla ".. userID .. " przypisany juz hexa: " .. tostring(hex))
                    --        break
                       -- end
                   -- end
                    local bg = ""
                    if (i % 2 == 0) then
                      --  print(i)
                        bg = "background: rgba(18, 105, 202, 0.1)"
                    else
                      --  print(i)
                        bg = "background: rgba(18, 105, 202, 0.3)"
                    end
                    if kolumna == 1 then
                        if GetPlayerServerId(i) == GetPlayerServerId(PlayerId()) then
                            table.insert(players, '<tr><td class="rowme">' .. userID .. ' &nbsp;&nbsp;&nbsp; ' .. tostring(t[userID]) ..' </td>' )
                        else
                            table.insert(players, '<tr><td class="row">' .. userID .. ' &nbsp;&nbsp;&nbsp; ' .. tostring(t[userID]) ..'</td>' )
                        end
                        kolumna = 2
                    else
                        if GetPlayerServerId(i) == GetPlayerServerId(PlayerId()) then
                            table.insert(players, '<td class="rowme">' .. userID .. ' &nbsp;&nbsp;&nbsp; ' .. tostring(t[userID]) ..' </td></tr>' )
                        else
                            table.insert(players, '<td class="row">' .. userID .. ' &nbsp;&nbsp;&nbsp; ' .. tostring(t[userID]) ..'</td></tr>' )
                        end
                        kolumna = 1
                    end
                    
                   
                end
                if (count % 2 == 0) then
                      --  print(i)
                      table.insert(players, '</td></tr>')        
                else
                    table.insert(players, '</td>ssssssssssssssssssssss</tr>') 

                    end
                local lspdinfo = "nie"
                if _lspd > 0 then
                    lspdinfo = "<b>+</b>"
                else
                    lspdinfo = "<b>-</b>"
                end
               -- table.insert(players, '<tr style="line-height: 32px;color: rgb(255, 255, 255); font-weight: 500;"><td colspan="2"><BR><BR><BR><BR><div style="line-height: 32px; text-align: center;/* display: inline; */bottom: 2px;position: absolute;opacity: 1;width: 20%;padding: 2%;min-height: 70px;left: 30%;    background: rgba(30, 57, 82, 0.33);border-radius: 10px;width: 65%;/* overflow: hidden; */font-family: Ubuntu;"> <span class="label label-primary">LSPD: '.. lspdinfo..'</span> <span class="label label-info">TAXI: '.. _taxi..'</span> <span class="label label-danger">EMS: '.. _ems..'</span>  <span class="label label-warning">MECHANIK: '.. _mecano..'</span> <span class="label label-city">Urząd: '.. _city..'</span> <span class="label label-success">OBYWATELI: '..count..'</span> </div></td></tr>' )
               
                SendNUIMessage({ text = table.concat(players) })

                listOn = true
                while listOn do
                    Wait(0)
                    if(IsControlPressed(0, 48) == false) then
                        TriggerEvent('atlantisCam:displayZ', false)
                        listOn = false
                        SendNUIMessage({
                            meta = 'close'
                        })
                        break
                    end
                end
            end
        end
    end
end)

function GetPlayers()
    local players = {}
    count = 0
    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
            count = count +1
        end
    end

    return players
end


local showPlayerBlips = false
local ignorePlayerNameDistance = false
local playerNamesDist = 25
local displayIDHeight = 1.5 --Height of ID above players head(starts at center body mass)
--Set Default Values for Colors
local red = 255
local green = 255
local blue = 255
function DrawText3D(x,y,z, text)
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
function DrawText3SD(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(1.0*scale, 1.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(red, green, blue, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        World3dToScreen2d(x,y,z, 0) --Added Here
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function()
    while true do
          if IsControlPressed(0, 48)--[[ INPUT_PHONE ]] then
        for i=0,255 do
            N_0x31698aa80e0223f8(i)
        end
        for id = 0, 255 do
            if  ((NetworkIsPlayerActive( id )) and GetPlayerPed( id ) ~= GetPlayerPed( -1 )) then
                ped = GetPlayerPed( id )
                blip = GetBlipFromEntity( ped ) 
 
                x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
                x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( id ), true ) )
                distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))

                if(ignorePlayerNameDistance) then
                    if NetworkIsPlayerTalking(id) then
                        red = 0
                        green = 0
                        blue = 255
                        DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id))
                    else
                        red = 255
                        green = 255
                        blue = 255
                        DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id))
                    end
                end

                if ((distance < playerNamesDist)) then
                    if not (ignorePlayerNameDistance) then
                        if NetworkIsPlayerTalking(id) then
                            red = 0
                            green = 0
                            blue = 255
                            DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id))
                        else
                            red = 255
                            green = 255
                            blue = 255
                            DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id))
                        end
                    end
                end  
            end
        end
    end
        Citizen.Wait(0)
    end
end)