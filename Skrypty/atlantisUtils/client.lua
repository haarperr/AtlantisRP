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
local drift = false

local p1coords = GetEntityCoords(PlayerPedId())
--local drzwikurwy = GetClosestObjectOfType(p1coords, 10.0, GetHashKey("vb_35_lifegaurddoor2"), false, false, false)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)
		p1coords = GetEntityCoords(PlayerPedId())
		--drzwikurwy = GetClosestObjectOfType(p1coords, 10.0, GetHashKey("vb_35_lifegaurddoor2"), false, false, false)
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for i=1, #Config.Marker do
	        local markerID   = Config.Marker[i]
			local dystans = GetDistanceBetweenCoords(markerID.Pos.x, markerID.Pos.y, markerID.Pos.z, p1coords, true)

			if dystans < Config.DrawDistance then
				DrawText3Ds(markerID.Pos.x, markerID.Pos.y, markerID.Pos.z, markerID.text)
				if IsControlJustReleased(0, 38) and dystans < 1.25 and not spamLock then
					TriggerEvent(markerID.event)
					spamlock()
				end
			end
		end
	end
end)

--[[Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        --local playerPedPos = GetEntityCoords(GetPlayerPed(-1), true)
        
        
        if (IsPedActiveInScenario(GetPlayerPed(-1)) == false) then
            SetEntityAsMissionEntity(drzwikurwy, 1, 1)
            DeleteEntity(drzwikurwy)
        end
    end
end)]]

--[[Citizen.CreateThread( function()
    while true do
    Citizen.Wait(0)
		if IsControlJustPressed(0, 137) then
			if IsPedInAnyVehicle(PlayerPedId()) then
				if not shitCar() then
					local vehicle = GetVehiclePedIsUsing(PlayerPedId())
					if not drift then
						SetVehicleReduceGrip(vehicle, true)
						drift = true
            ESX.ShowNotification('~g~Drift-Mode')
					elseif drift then 
						SetVehicleReduceGrip(vehicle, false)
						drift = false
            ESX.ShowNotification('~r~Drift-Mode')
					end
				end
			end
		end
    end
end)

function shitCar()
	if GetEntityModel(GetVehiclePedIsUsing(PlayerPedId())) == GetHashKey('sentinel4') then
		return false
	end
	if GetEntityModel(GetVehiclePedIsUsing(PlayerPedId())) == GetHashKey('tampa2') then
		return false
	end
	if GetEntityModel(GetVehiclePedIsUsing(PlayerPedId())) == GetHashKey('elegy4') then
		return false
	end
	if GetEntityModel(GetVehiclePedIsUsing(PlayerPedId())) == GetHashKey('futo2') then
		return false
	end
	if GetEntityModel(GetVehiclePedIsUsing(PlayerPedId())) == GetHashKey('ruinerfd') then
		return false
	end
	if GetEntityModel(GetVehiclePedIsUsing(PlayerPedId())) == GetHashKey('schwarzer2') then
		return false
	end
	if GetEntityModel(GetVehiclePedIsUsing(PlayerPedId())) == GetHashKey('sentigp') then
		return false
	end
	if GetEntityModel(GetVehiclePedIsUsing(PlayerPedId())) == GetHashKey('zr') then
		return false
	end
	if GetEntityModel(GetVehiclePedIsUsing(PlayerPedId())) == GetHashKey('zr380s') then
		return false
	end
	if GetEntityModel(GetVehiclePedIsUsing(PlayerPedId())) == GetHashKey('sultanrsv8') then
		return false
	end
    return true
end]]

--[[RegisterCommand("extras", function(source, args, raw)
	PlayerData = ESX.GetPlayerData()
  local extras = tonumber(args[1])
  local toogle = tonumber(args[2])
  if extras ~= nil and toogle ~= nil then
    if PlayerData.job.name == 'mechanic' and (PlayerData.job.grade_name == 'chief' or PlayerData.job.grade_name == 'boss') then
      setextras(extras, toogle)
	else
      ESX.ShowNotification('Brak uprawnień')
    end
  end
end, false)

function setextras(extra, toggle)
  if IsPedInAnyVehicle(PlayerPedId(), false) then
      local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        --SetVehicleAutoRepairDisabled(vehicle, true)
        SetVehicleExtra(vehicle, extra, toggle)
  end
end

RegisterCommand("malowanie", function(source, args, raw)
	PlayerData = ESX.GetPlayerData()
  local livery = tonumber(args[1])
  if livery ~= nil then
    if PlayerData.job.name == 'mechanic' and (PlayerData.job.grade_name == 'chief' or PlayerData.job.grade_name == 'boss') then
       setlivery(livery)
	else
      ESX.ShowNotification('Brak uprawnień')
    end
  end
end, false)

function setlivery(livery)
  if IsPedInAnyVehicle(PlayerPedId(), false) then
      local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        --SetVehicleAutoRepairDisabled(vehicle, true)
        SetVehicleLivery(vehicle, livery)
  end
end]]

RegisterCommand("odholuj", function(source, args, raw)
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job.name == 'mechanic' then 
      removeClosestCar()
  elseif PlayerData.job.name == 'police' then
      TriggerServerEvent('mechanic:check')
  else
      ESX.ShowNotification('Brak uprawnień')
  end
end, false)

function removeClosestCar()
  player = PlayerPedId()
  local plyCoords = GetEntityCoords(player, false)
  local vehicle = GetClosestVehicle(plyCoords.x, plyCoords.y, plyCoords.z, 2.0, 0, 70)
  local plate = GetVehicleNumberPlateText(vehicle)
  NetworkRequestControlOfEntity(vehicle)
  while not NetworkHasControlOfEntity(vehicle) do
    Wait(10)
  end
  SetEntityAsMissionEntity(vehicle, 1, 1)
  while not IsEntityAMissionEntity(vehicle) do
    Wait(10)
  end
  SetVehicleAsNoLongerNeeded(vehicle)
  Wait(1000)
  DeleteEntity(vehicle)
  Wait(1000)
  if not DoesEntityExist(vehicle) then
    TriggerServerEvent("odholowanko:wpierdoldobunkra", plate)
  end
end
 
RegisterNetEvent('police:odholuj')
AddEventHandler('police:odholuj', function()
      removeClosestCar()
end)

RegisterNetEvent('show:money')
AddEventHandler('show:money', function(time)
	TriggerEvent('es:setMoneyDisplay', 1.0)
	Citizen.Wait(time * 1000)
	TriggerEvent('es:setMoneyDisplay', 0.0)
end)

--[[RegisterCommand("try", function(source, args, raw)
  local random = math.random(0,10)
  TriggerServerEvent('3dme:shareDisplayMe', "PRÓBA: "..args[1])
  Wait(2000)
  if random > 5 then
    TriggerServerEvent('3dme:shareDisplayDo', "PRÓBA: Udane")
  elseif random < 5 then
    TriggerServerEvent('3dme:shareDisplayDo', "PRÓBA: Nieudane")
  end
end, false)]]

RegisterCommand("aiadraport", function(source, args, raw)
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job.name == 'police' then 
    TriggerServerEvent('aiad:raport', args[1])
  end
end, false)

local spawnedaiadcars = 0
RegisterNetEvent('AIAD:spawnVehicle')
AddEventHandler('AIAD:spawnVehicle', function(model)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
  local distance  = GetDistanceBetweenCoords(447.89, -1018.94, 28.55, coords, true)

  if spawnedaiadcars < 1 then
    if distance < 15 then
      ESX.Game.SpawnVehicle(model, coords, 90.0, function(vehicle)
        TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
        spawnedaiadcars = spawnedaiadcars + 1
        Wait(1000)
        SetVehicleNumberPlateText(vehicle, 'A I A D')
      end)
    else 
      TriggerEvent("pNotify:SendNotification", {text = "Jesteś zbyt daleko od garażu policyjnego aby wyciągnąć ten pojazd.", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"}) 
    end
  else
      TriggerEvent("pNotify:SendNotification", {text = "Brak pojazdów AIAD w garażu.", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
  end
end)

RegisterNetEvent('AIAD:hideVehicle')
AddEventHandler('AIAD:hideVehicle', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
  local distance  = GetDistanceBetweenCoords(447.89, -1018.94, 28.55, coords, true)

  if IsPedInAnyVehicle(playerPed, false) and distance < 15 then
      local vehicle = GetVehiclePedIsIn(playerPed, false)
      SetEntityAsMissionEntity(vehicle, 1, 1)
      SetVehicleAsNoLongerNeeded(vehicle)
      DeleteEntity(vehicle)
      spawnedaiadcars = spawnedaiadcars - 1
      print(spawnedaiadcars)
  else
     TriggerEvent("pNotify:SendNotification", {text = "Jestesś zbyt daleko od garażu policyjnego aby schować ten pojazd.", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"}) 
  end
end)

RegisterNetEvent('force:do')
AddEventHandler('force:do', function(text)
  TriggerServerEvent('3dme:shareDisplayDo', text)
end)

RegisterCommand("pedtest", function(source, args, raw)
  local one = tonumber(args[1])
  local two = tonumber(args[2])
  local three = tonumber(args[3])
  local four = tonumber(args[4])
SetPedComponentVariation(GetPlayerPed(-1), one, two, three, four)
end, false)

RegisterCommand("customped", function(source, args, raw)
  PlayerData = ESX.GetPlayerData()
  print(PlayerData.identifier)
  if PlayerData.identifier == 'steam:asd' then
         local _model = tonumber(1650288984)
         local id = tonumber(PlayerId())
        while not HasModelLoaded(_model) do
          RequestModel(_model)

          Citizen.Wait(0)
        end

        if HasModelLoaded(_model) then
          SetPlayerModel(PlayerId(), _model)
          SetPedComponentVariation(GetPlayerPed(-1), 0, 1, 0, 0)
          SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 2, 0)
          SetPedComponentVariation(GetPlayerPed(-1), 2, 1, 0, 0)
          SetPedComponentVariation(GetPlayerPed(-1), 9, 1, 0, 0)
          TriggerEvent('esx:restoreLoadout')
          TriggerEvent('esx_tattooshop:refreshTattoos')
        else
          print("Couldn't load skin!")
        end
  else
      print("Brak dostępu " .. id)
  end
end, false)

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

    SetTextScale(0.30, 0.30)
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
  if not exist then
    AtlantisHelpText(x, y, text, 500)
  end
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
  numerek = numerek - 15
  Citizen.Wait(time)
  until(numerek < 150)
  notify = false
  exist = false
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

RegisterNetEvent('kickForRestartC')
AddEventHandler('kickForRestartC', function()
  TriggerServerEvent("kickForRestart")
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/przeszukaj', 'Przeszukaj innego gracza jeśli ten jest skuty lub ma podniesione ręce do góry.')
    TriggerEvent('chat:addSuggestion', '/worek', 'Ściągnij worek ze swojej głowy (jeśli nie jesteś skuty lub na BW).')
    TriggerEvent('chat:addSuggestion', '/uwolnij', 'Uwolnij się z komendy /podnies by stanąć na ziemię.')
    TriggerEvent('chat:addSuggestion', '/podnies', 'Weź innego gracza na ramię by go przetransportować.')
    TriggerEvent('chat:addSuggestion', '/bongo', 'Zapal sobie bongo w nagrodę.')
    TriggerEvent('chat:addSuggestion', '/papieros', 'Zapal papierosa.')
    TriggerEvent('chat:addSuggestion', '/bed', 'Połóż się na łóżku w szpitalu.')
    TriggerEvent('chat:addSuggestion', '/shuff', 'Przesiądź się w pojęździe na siedzenie kierowcy.')
    TriggerEvent('chat:addSuggestion', '/sprzedaj', '(/sprzedaj kwota) Sprzedaj swój pojazd innemu graczowi. Wsiądź na miejsce kierowcy, a kupujący na miejsce pasażera i użyj poniższej komendy by rozpocząć proces sprzedaży.')
    TriggerEvent('chat:addSuggestion', '/przelew', '(/przelew ID kwota) Wykonaj przelew dla innego gracza, np. /przelew 8 35000')
    TriggerEvent('chat:addSuggestion', '/odholuj', 'Odholowuje pojazdy, w tym również spalone wraki. Jeżeli pojazd należy do gracza to zostaje on odholowane do jego garażu, a w przypadku gdy LSPD odholuje pojazd wysyłane jest na parking policyjny')
    TriggerEvent('chat:addSuggestion', '/wizytowka', 'Pokaż swoje dane kontaktowe (imię, nazwisko, numer telefonu).')
    TriggerEvent('chat:addSuggestion', '/blacha', 'Pokaż swoją odznakę (dla służb publicznych).')
    TriggerEvent('chat:addSuggestion', '/dowod', 'Pokaż swój dowód osobisty.')
    TriggerEvent('chat:addSuggestion', '/report', 'Informacja widziana tylko przez administratorów. Służy do zgłaszania błędów, prośby o nadawanie whitelistowanej pracy czy zgłaszania innych graczy po skończonej akcji RP.')
    TriggerEvent('chat:addSuggestion', '/dealer', 'Sprzedaj narkotyki lokalnym mieszkańcom.')
    TriggerEvent('chat:addSuggestion', '/anon', 'Wyślij tweet anonimowy.')
    TriggerEvent('chat:addSuggestion', '/tweet', 'Wiadomość na twitterze, którą widzą mieszkańcy.')
    TriggerEvent('chat:addSuggestion', '/med', 'Opis stanu zdrowia i poniesionych obrażeń Waszej postaci. NA /med NIE MOŻNA KŁAMAĆ!')
    TriggerEvent('chat:addSuggestion', '/do', 'Opisuje stan otoczenia, np. widoczną krew na ścianie. NA /do NIE MOŻNA KŁAMAĆ!')
    TriggerEvent('chat:addSuggestion', '/me', 'Opisuje czynności jakie wykonywane są przez Waszą postać. NA /me NIE ODGRYWAMY MYŚLI!')
end)


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

local incokeshop = false
RegisterNetEvent('coke:seller')
AddEventHandler('coke:seller', function()
  if not incokeshop then
    opencokeshop()
    incokeshop = true
  else
    ESX.UI.Menu.CloseAll()
    incokeshop = false
  end
end)

function opencokeshop()
  hour = GetClockHours()
  minute = GetClockMinutes()

  if hour == 23 or hour == 0 or hour == 1 or hour == 2 or hour == 3 or hour == 4 then
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'coke_menu',
    {
        title    = "Mężczyzna oferuję Tobie paczkę nasion za kwotę <span style='color:red;'>3000$ <span style='color:white;'>Co robisz?",
        align    = 'right',
        elements = {
            {label = "Odmów", value = 'no'},
            {label = "Kup", value = 'yes'},
        }
    }, function(data, menu)

            local action = data.current.value
            local coords    = GetEntityCoords(PlayerPedId())
            local distancecheck  = GetDistanceBetweenCoords(-1873.58, 2140.55, 125.4, coords, true)

            if action == 'no' then
              if distancecheck <= 5 then
                no()
                menu.close()
                incokeshop = false
              else
                menu.close()
                incokeshop = false
              end
            elseif action == 'yes' then
              if distancecheck <= 5 then
                yes()
                menu.close()
                incokeshop = false
              else
                menu.close()
                incokeshop = false
              end
            end
    end, function(data, menu)
        incokeshop = false
        menu.close()
    end)
  else
    incokeshop = false
    TriggerEvent("pNotify:SendNotification", {text = "Nie teraz. Porozmiawiajmy kiedy indziej.", type = "atlantis", queue = "global", timeout = 6000, layout = "atlantis"})
  end
end

function no()
  incokeshop = false
  ESX.UI.Menu.CloseAll()
end

function yes()
  day = GetClockDayOfWeek()
  if day == 0 or day == 1 or day == 2 or day == 3 then
    TriggerServerEvent('cokeshop:buycoke', 'seed_coke70', 3000, 15)
  elseif day == 4 or day == 5 then
    TriggerServerEvent('cokeshop:buycoke', 'seed_coke90', 3000, 15)
  elseif day == 6 then
    TriggerServerEvent('cokeshop:buycoke', 'seed_coke100', 3000, 15)
  end
end