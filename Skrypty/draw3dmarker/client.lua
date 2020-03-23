ESX                           = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local showPro = false
local spamLock = false
local drawBar = false
local notify = false
local exist = false


local p1coords = GetEntityCoords(PlayerPedId())
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)
		p1coords = GetEntityCoords(PlayerPedId())
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		for i=1, #Config.Marker do
	        local markerID   = Config.Marker[i]
			local dystans = GetDistanceBetweenCoords(markerID.Pos.x, markerID.Pos.y, markerID.Pos.z, p1coords, true)

			if dystans < Config.DrawDistance then
				DrawText3Ds(markerID.Pos.x, markerID.Pos.y, markerID.Pos.z, markerID.text)
				if IsControlJustReleased(0, 38) and not spamLock then
					TriggerEvent(markerID.event)
					spamlock()
				end
			end
		end
	end
end)

--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for i=1, #Config.Marker do
	        local markerID   = Config.Marker[i]
			local pozycja = GetEntityCoords(PlayerPedId())
			local dystans = GetDistanceBetweenCoords(markerID.Pos.x, markerID.Pos.y, markerID.Pos.z, GetEntityCoords(PlayerPedId()), true)

			if dystans < Config.DrawDistance then
				DrawText3Ds(markerID.Pos.x, markerID.Pos.y, markerID.Pos.z, markerID.text)
				if IsControlJustReleased(0, 38) and not spamLock then
					TriggerEvent(markerID.event)
					spamlock()
				end
			end
		end
	end
end)]]

RegisterNetEvent('show:money')
AddEventHandler('show:money', function(time)
	TriggerEvent('es:setMoneyDisplay', 1.0)
	Citizen.Wait(time * 1000)
	TriggerEvent('es:setMoneyDisplay', 0.0)
end)

--------------------3d procent----------------------------------

RegisterNetEvent('3d:procentbar')
AddEventHandler('3d:procentbar', function(time, text)
	procent(time, text)
end)

RegisterNetEvent('3dtext:procenty')
AddEventHandler('3dtext:procenty', function(text)
  showPro = true
    while (showPro) do
      Citizen.Wait(10)
      local playerPed = PlayerPedId()
      local coords = GetEntityCoords(playerPed)
      DisableControlAction(0, 73, true) -- X
      DrawText3Ds(coords.x, coords.y, coords.z+0.1, text .. ' - ' .. TimeLeft .. '~b~%')
    end
end)


function procent(time, text)
  TriggerEvent('3dtext:procenty', text)
  TimeLeft = 0
  repeat
  TimeLeft = TimeLeft + 1
  Citizen.Wait(time)
  until(TimeLeft == 100)
  showPro = false
end

function spamlock()
	spamLock = true
	Wait(5000)
	spamLock = false
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
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

---------------------------------------------------------------

--------------------help notification--------------------------

RegisterNetEvent('2d:HelpText')
AddEventHandler('2d:HelpText', function(x,y, text)
  AtlantisHelpText(x, y, text, 500)
end)

RegisterNetEvent('2d:notificationloop')
AddEventHandler('2d:notificationloop', function(x,y, text)
notify = true 
  while notify do 
  Citizen.Wait(0)
    notification(x, y, text, numerek)
  end
end)

function AtlantisHelpText(x,y, text, time)
  TriggerEvent('2d:notificationloop',x, y, text)
  numerek = 255
  repeat
  numerek = numerek - 5
  Citizen.Wait(time)
  until(numerek < 150)
  notify = false
end

function notification(x,y,text,alpha)
  exist = true
  SetTextScale(0.39, 0.39)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, alpha)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(x,y)
    local textwidth = (string.len(text)) / 370
    DrawRect(x,y+0.0125 ,0.030+ textwidth,0.03,0,153,204,alpha)
    DrawRect(x,y+0.0125 ,0.035+ textwidth,0.04,0,0,0,20)
end

---------------------------------------------------------------

--------------------2d procentbar------------------------------
RegisterNetEvent('2d:ProgressBar')
AddEventHandler('2d:ProgressBar', function(text, time)
  progressbar(text, time)
end)

RegisterNetEvent('2d:progressbar')
AddEventHandler('2d:progressbar', function(text)
  drawBar = true
  while drawBar do 
    Citizen.Wait(0)
    local progressW = (progress * 2) / 1000
    local backgroundW = (100 * 2) / 1000
      DrawRect(0.5,0.83,backgroundW,0.032,0,0,0,120) -- header
      DrawRect(0.5,0.83,progressW,0.030,0,153,204,150) -- header
      txt(0.5,0.815,text)
  end
end)

function progressbar(text, time)
  TriggerEvent('2d:progressbar', text)
  progress = 0
  repeat
  progress = progress + 1
  Citizen.Wait(time)
  until(progress == 100)
  drawBar = false
end

function txt(x,y, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(x,y)
end

---------------------------------------------------------------

--[[function mainblip()
  local blipOrchard = AddBlipForCoord(Config.Zones.Cloakroom.Pos.x, Config.Zones.Cloakroom.Pos.y, Config.Zones.Cloakroom.Pos.z)

  SetBlipSprite (blipOrchard, Config.Blips.Cloakroom.Sprite)
  SetBlipDisplay(blipOrchard, 4)
  SetBlipScale  (blipOrchard, 2.0)
  SetBlipColour (blipOrchard, 5)
  SetBlipAsShortRange(blipOrchard, true)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName(_U('blip_orchard'))
  EndTextCommandSetBlipName(blipOrchard)
  table.insert(JobBlips, blipOrchard)
end

-- wejscie na sluzbe i dodanie blipow
function onduty()
  onDuty = true
  local blipOrchard2 = AddBlipForCoord(Config.Zones.Job1.Pos.x, Config.Zones.Job1.Pos.y, Config.Zones.Job1.Pos.z)
  local blipOrchard3 = AddBlipForCoord(Config.Zones.Job1b.Pos.x, Config.Zones.Job1b.Pos.y, Config.Zones.Job1b.Pos.z)
  local blipOrchard4 = AddBlipForCoord(Config.Zones.Job2.Pos.x, Config.Zones.Job2.Pos.y, Config.Zones.Job2.Pos.z)
  local blipOrchard5 = AddBlipForCoord(Config.Zones.Job3.Pos.x, Config.Zones.Job3.Pos.y, Config.Zones.Job3.Pos.z)
  local blipOrchard6 = AddBlipForCoord(Config.Zones.Job3a.Pos.x, Config.Zones.Job3a.Pos.y, Config.Zones.Job3a.Pos.z)

  SetBlipSprite (blipOrchard2, Config.Blips.Apple.Sprite)
  SetBlipDisplay(blipOrchard2, 4)
  SetBlipScale  (blipOrchard2, 2.0)
  SetBlipColour (blipOrchard2, 5)
  SetBlipAsShortRange(blipOrchard2, true)

  SetBlipSprite (blipOrchard3, Config.Blips.Orange.Sprite)
  SetBlipDisplay(blipOrchard3, 4)
  SetBlipScale  (blipOrchard3, 2.0)
  SetBlipColour (blipOrchard3, 5)
  SetBlipAsShortRange(blipOrchard3, true)

  SetBlipSprite (blipOrchard4, Config.Blips.Juice.Sprite)
  SetBlipDisplay(blipOrchard4, 4)
  SetBlipScale  (blipOrchard4, 2.0)
  SetBlipColour (blipOrchard4, 5)
  SetBlipAsShortRange(blipOrchard4, true)

  SetBlipSprite (blipOrchard5, Config.Blips.SellJuice.Sprite)
  SetBlipDisplay(blipOrchard5, 4)
  SetBlipScale  (blipOrchard5, 2.0)
  SetBlipColour (blipOrchard5, 5)
  SetBlipAsShortRange(blipOrchard5, true)

  SetBlipSprite (blipOrchard6, Config.Blips.SellFruits.Sprite)
  SetBlipDisplay(blipOrchard6, 4)
  SetBlipScale  (blipOrchard6, 2.0)
  SetBlipColour (blipOrchard6, 5)
  SetBlipAsShortRange(blipOrchard6, true)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName('Zbieranie owoców')
  EndTextCommandSetBlipName(blipOrchard2)
  table.insert(JobBlips, blipOrchard2)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName('Zbieranie owoców')
  EndTextCommandSetBlipName(blipOrchard3)
  table.insert(JobBlips, blipOrchard3)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName('Hurtownia soków')
  EndTextCommandSetBlipName(blipOrchard4)
  table.insert(JobBlips, blipOrchard4)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName('Sprzedaż owoców')
  EndTextCommandSetBlipName(blipOrchard5)
  table.insert(JobBlips, blipOrchard5)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName('Skup soków')
  EndTextCommandSetBlipName(blipOrchard6)
  table.insert(JobBlips, blipOrchard6)

end

-- usuwanie blipow pracy oraz zejscie ze sluzby.
function offduty()
  onDuty = false
  if JobBlips[1] ~= nil then
		for i=1, #JobBlips, 1 do
			RemoveBlip(JobBlips[i])
			JobBlips[i] = nil
		end
	end
end]]
