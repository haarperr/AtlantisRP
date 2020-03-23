local moneyWashing = false
local onMoneyWash = false
local MoneywashWaypointBlips = {}
local AntyDebilSpam = 0
local counting = false

MoneyDelivery = {
[1] = {x = -791.15, y = 41.88, z = 48.56},
[2] = {x = -1378.66, y = 55.59, z = 53.69},
[3] = {x = -1669.99, y = -305.92, z = 51.62},
[4] = {x = -1333.71, y = -394.39, z = 36.55},
[5] = {x = -1398.51, y = -644.38, z = 28.67},
[6] = {x = -1816.54, y = 789.06, z = 137.91},
[7] = {x = -2544.25, y = 2322.61, z = 33.06},
[8] = {x = -3145.85, y = 1091.72, z = 20.69},
[9] = {x = -3049.37, y = 603.15, z = 7.26},
[10] = {x = -2958.8, y = 442.01, z = 15.26},
[11] = {x = -3010.3, y = 89.01, z = 11.61},
[12] = {x = -2065.65, y = -307.72, z = 13.14},
[13] = {x = -544.00, y = -1219.65, z = 18.27},
[14] = {x = 1162.03, y = -330.57, z = 68.96},
[15] = {x = 920.81, y = 50.23, z = 80.76},
[16] = {x = 639.62, y = 264.99, z = 103.12},
[17] = {x = -1104.02, y = 2691.78, z = 18.87},
[18] = {x = 611.31, y = 2739.28, z = 41.9},
[19] = {x = 2567.13, y = 379.25, z = 108.46},
[20] = {x = -1126.15, y = -1609.88, z = 4.4},
}

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('moneywash:checkxd')
AddEventHandler('moneywash:checkxd', function()
    if carcheck() then
        if AntyDebilSpam >= 2 then
            TriggerEvent("pNotify:SendNotification", {text = "Blokada antyspam, spróbój ponownie za 5 minut", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})  
            TriggerEvent('moneywash:end')
            antydebilspamunlock()
        else
            TriggerEvent('moneywash:start')
        end
    end
end)


RegisterNetEvent('moneywash:start')
AddEventHandler('moneywash:start', function()
ESX.TriggerServerCallback('moneywash:chcekinventory', function(data)
	if data > 0 then
        if not onMoneyWash then
        AntyDebilSpam = AntyDebilSpam + 1
        TriggerEvent("pNotify:SendNotification", {text = "<span style='color:yellow;'>Wykrywanie <span style='color:white;'>chipa..", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
        Citizen.Wait(3000)
        TriggerEvent("pNotify:SendNotification", {text = "<span style='color:#2FCC34;'>Wykryto <span style='color:white;'>chip!", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
        Citizen.Wait(1500)
        TriggerEvent("pNotify:SendNotification", {text = "<span style='color:yellow;'>Deszyfrowanie <span style='color:white;'>oraz <span style='color:yellow;'>logowanie..", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
        Citizen.Wait(1500)
        TriggerEvent("pNotify:SendNotification", {text = "<span style='color:#2FCC34;'>Pomyślne <span style='color:white;'>zalogowano do systemu!", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
        Citizen.Wait(3000)
        TriggerEvent('moneywash:job') 
        ESX.ShowAdvancedNotification('Konsultant', 'Biuro', 'GPS został zaktualizowany. Odbiór osobisty. Bezpiecznej drogi!', 'CHAR_BLANK_ENTRY', 8)
    else
        TriggerEvent("pNotify:SendNotification", {text = "<span style='color:#2FCC34;'>Zaszyfrowano <span style='color:white;'>połączenie. Nastąpiło <span style='color:red;'>wylogowanie <span style='color:white;'>z systemu!", type = "atlantis", queue = "global", timeout = 6000, layout = "atlantis"})
        TriggerEvent('moneywash:end')
           end
        end
    end)
end)

function antydebilspamunlock()
    if AntyDebilSpam >= 2 and not counting then
        counting = true
        Wait(300000)
        AntyDebilSpam = 0
        counting = false
    end
end

RegisterNetEvent('moneywash:end')
AddEventHandler('moneywash:end', function()
    removeBlips()
    ClearGpsPlayerWaypoint()
    SetWaypointOff()
    moneyWashing = false
    onMoneyWash = false    
end)

RegisterNetEvent('moneywash:job')
AddEventHandler('moneywash:job', function()
    onMoneyWash = true
    moneyWashing = true 
    MoneyExchangeCoords = MoneyDelivery[math.random(#MoneyDelivery)]
    CreateMoneywashWaypointBlip(MoneyExchangeCoords.x, MoneyExchangeCoords.y, MoneyExchangeCoords.z)
    SetNewWaypoint(MoneyExchangeCoords.x, MoneyExchangeCoords.y)
    while moneyWashing do 
    Citizen.Wait(0)
    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), MoneyExchangeCoords.x, MoneyExchangeCoords.y, MoneyExchangeCoords.z, true) < 10.0 then
        DrawText3Ds(MoneyExchangeCoords.x, MoneyExchangeCoords.y, MoneyExchangeCoords.z, "~b~[E] ~s~Aby dostarczyć przesyłkę")
        if IsControlJustReleased(0, 38) then 
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), MoneyExchangeCoords.x, MoneyExchangeCoords.y, MoneyExchangeCoords.z, true) < 2.0 then
                moneywashed()
                return
            end
        end
     end
    end
end)

function moneywashed()
    if carcheck() then
        moneyWashing = false
        onMoneyWash = false
        TriggerEvent('show:money', 1.5)
        TriggerServerEvent('moneywash:pay')
        TriggerServerEvent('atlantisStatus:remove', 10)
        nextwaypoint()
    else
        TriggerEvent("pNotify:SendNotification", {text = "Chciałeś wyjebać Freda, teraz Fred wyjebie ciebie...", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})  
        TriggerEvent('moneywash:end')
        --spawnNPC()
        --Wait(15000)
        --removeNPC()
    end
end

RegisterNetEvent('moneywash:NSA')
AddEventHandler('moneywash:NSA', function(amount)
TriggerServerEvent("esx:washingmoneyalert", amount)
end)

function nextwaypoint()
    TriggerEvent('moneywash:job') 
end

function carcheck()
    local player = GetPlayerPed(-1)
    local car = GetVehiclePedIsIn(PlayerPedId())
    local playerCar = GetVehiclePedIsIn(PlayerPedId(), false)
    local playerCarModel = GetEntityModel(playerCar)
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
        TriggerServerEvent('moneywash:notify')
        return false
    else
        if playerCarModel == GetHashKey('speedo') and GetPedInVehicleSeat(car, -1) == player and not IsEntityDead(PlayerPedId()) then
            return true
        else
            jebanyfrajerzesiedziszwzlejfurze() 
            return false   
        end
    end
end

function jebanyfrajerzesiedziszwzlejfurze()
   TriggerEvent("pNotify:SendNotification", {text = "<span style='color:yellow;'>Wykrywanie <span style='color:white;'>chipa..", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
   Citizen.Wait(3000)
   TriggerEvent("pNotify:SendNotification", {text = "<span style='color:red;'>Nie wykryto <span style='color:white;'>chipa!", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
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

function CreateMoneywashWaypointBlip(x,y,z)
    removeBlips()
    Wait(500)
    local blipMoneywash = AddBlipForCoord(x,y,z)

  SetBlipSprite (blipMoneywash, 431)
  SetBlipDisplay(blipMoneywash, 4)
  SetBlipScale  (blipMoneywash, 1.0)
  SetBlipColour (blipMoneywash, 5)
  SetBlipAsShortRange(blipMoneywash, true)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName('Miejsce dostarczenia przesyłki')
  EndTextCommandSetBlipName(blipMoneywash)
  table.insert(MoneywashWaypointBlips, blipMoneywash)
end

function removeBlips()
      if MoneywashWaypointBlips[1] ~= nil then
        for i=1, #MoneywashWaypointBlips, 1 do
            RemoveBlip(MoneywashWaypointBlips[i])
            MoneywashWaypointBlips[i] = nil
        end
    end
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

----------------------------------------

local NPC = 0

function spawnNPC()
    local coords = GetEntityCoords(PlayerPedId())
    loadModel('s_m_y_blackops_01')
    NPC = CreatePed(4, 's_m_y_blackops_01', coords.x, coords.y+12, coords.z, 100.00, true, true)
    Wait(500)
    --GiveWeaponToPed(NPC, GetHashKey("weapon_assaultsmg"), 1, false, true)
    --SetCurrentPedWeapon(NPC, GetHashKey("weapon_assaultsmg"), true)
    SetPedDropsWeaponsWhenDead(NPC, false)
    TaskCombatPed(NPC, PlayerPedId(), 0, 16)
end

function removeNPC()
    DeleteEntity(NPC)
    NPC = 0 
end
