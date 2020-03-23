local dpdwork = false
local dpdjob = false
local dpdblips = {}
local dpdblips2 = {}
local DeliveryBlips = {}

Delivery = {
[1] = {x = -3249.69, y = 991.84, z = 12.49},
[2] = {x = -3141.86, y = 1116.4, z = 20.7},
[3] = {x = -3048.62, y = 598.22, z = 7.42},
[4] = {x = -3052.72, y = 608.82, z = 7.2},
[5] = {x = -2960.26, y = 441.72, z = 15.26},
[6] = {x = -2966.45, y = 372.07, z = 14.78},
[7] = {x = -3013.82, y = 86.62, z = 11.61},
[8] = {x = -2187.08, y = -411.85, z = 13.12},
[9] = {x = -1591.04, y = -836.88, z = 10.01},
[10] = {x = -1489.51, y = -201.69, z = 50.4},
[11] = {x = -1415.55, y = -281.08, z = 46.27},
[12] = {x = -1324.8, y = -396.02, z = 36.43},
[13] = {x = -1371.65, y = -582.81, z = 29.82},
[14] = {x = -1302.11, y = -695.43, z = 24.94},
[15] = {x = -1172.59, y = -881.3, z = 14.06},
[16] = {x = -1018.71, y = -1350.96, z = 5.48},
[17] = {x = -1026.38, y = -1516.28, z = 5.59},
[18] = {x = -1198.63, y = -1486.33, z = 4.38},
[19] = {x = -847.52, y = -1137.95, z = 6.78},
[20] = {x = -1378.17, y = 45.18, z = 53.68},
[21] = {x = -1053.35, y = -511.32, z = 36.04},
[22] = {x = -1053.35, y = -511.32, z = 36.04},
[23] = {x = -639.89, y = -236.83, z = 37.93},
[24] = {x = -703.45, y = -870.15, z = 23.49},
[25] = {x = -595.99, y = -1131.03, z = 22.17},
[26] = {x = -607.44, y = -1034.58, z = 21.79},
[27] = {x = -494.55, y = -62.46, z = 39.96},
[28] = {x = -561.57, y = 302.25, z = 83.17},
[29] = {x = -360.04, y = -228.26, z = 37.26},
[30] = {x = -421.47, y = 293.31, z = 83.23},
[31] = {x = 898.96, y = -2486.16, z = 28.48},
[32] = {x = 1088.78, y = -2281.31, z = 30.18},
[33] = {x = 829.92, y = -1984.24, z = 29.3},
[34] = {x = 846.75, y = -1863.51, z = 29.03},
[35] = {x = 869.68, y = -1714.38, z = 30.19},
[36] = {x = 748.31, y = -1695.25, z = 29.29},
[37] = {x = 979.83, y = -1584.06, z = 30.82},
[38] = {x = 1142.43, y = -1334.1, z = 34.66},
[39] = {x = 917.15, y = -1262.64, z = 25.56},
[40] = {x = 914.79, y = -1139.03, z = 24.57},
[41] = {x = 876.2, y = -962.9, z = 26.29},
[42] = {x = 748.95, y = -1260.36, z = 26.32},
[43] = {x = 531.44, y = -1919.94, z = 24.97},
}

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('dpd:start')
AddEventHandler('dpd:start', function()
  ESX.PlayerData = ESX.GetPlayerData()
  if ESX.PlayerData.job and ESX.PlayerData.job.name == 'curier' then
    if not dpdjob then
        TriggerEvent('dpd:job') 
        spawncar()
    else
      TriggerEvent("pNotify:SendNotification", {text = "Najpierw odstaw poprzednia paczke", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
       -- ESX.ShowNotification('Najpierw odstaw poprzednia paczke.')
    end
  else
    TriggerEvent("pNotify:SendNotification", {text = "Nie jestes zatrudniony w tej firmie", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
    --ESX.ShowNotification('Nie jestes zatrudniony w tej firmie.')
  end
end)

RegisterNetEvent('dpd:end')
AddEventHandler('dpd:end', function()
    removecar()
    removeDPDBlips()
    dpdwork = false
    dpdjob = false    
end)

RegisterNetEvent('dpd:job')
AddEventHandler('dpd:job', function()
    dpdjob = true
    dpdwork = true 
    DeliveryCoords = Delivery[math.random(#Delivery)]
    CreateDeliveryBlip(DeliveryCoords.x, DeliveryCoords.y, DeliveryCoords.z)
    SetNewWaypoint(DeliveryCoords.x, DeliveryCoords.y)
    while dpdwork do 
    Citizen.Wait(0)
    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), DeliveryCoords.x, DeliveryCoords.y, DeliveryCoords.z, true) < 10.0 then
        DrawText3Ds(DeliveryCoords.x, DeliveryCoords.y, DeliveryCoords.z, "~b~[E] ~s~Aby dostarczyć przesyłkę")
        if IsControlJustReleased(0, 38) then 
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), DeliveryCoords.x, DeliveryCoords.y, DeliveryCoords.z, true) < 2.0 then
                dpdsuccess()
                return
            end
        end
     end
    end
end)

function dpdsuccess()
	local currentcar = GetVehiclePedIsIn(PlayerPedId(), false)
	local currentcarmodel = GetEntityModel(currentcar)
	if currentcarmodel == GetHashKey('steed2') then
	    dpdwork = false
	    dpdjob = false
	    TriggerEvent('show:money', 2.5)
	    TriggerServerEvent('dpd:pay')
	    --print('dziala')
	    next()
	else
      	TriggerEvent("pNotify:SendNotification", {text = "Nieautoryzowany pojazd", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
	end
end

function next()
    TriggerEvent('dpd:job') 
end

function removecar()
    local currentcar = GetVehiclePedIsIn(PlayerPedId(), false)
    local currentcarmodel = GetEntityModel(currentcar)
    if currentcarmodel == GetHashKey('steed2') then
        ESX.Game.DeleteVehicle(currentcar)
    else
      TriggerEvent("pNotify:SendNotification", {text = "Nieautoryzowany pojazd", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
       -- ESX.ShowNotification('Zly pojazd')
    end
end

RegisterCommand("stopdpd", function(source, args, raw)
                dpdwork = false
                dpdjob = false
end, false)

function spawncar()
    local spawnpoint = {x = -64.96, y = -2500.43, z = 5.2}
    if not ESX.Game.IsSpawnPointClear(spawnpoint, 5.0) then
        ESX.ShowNotification('blocked')
        dpdwork = false
        dpdjob = false 
    else
        ESX.Game.SpawnVehicle('steed2', spawnpoint, 250, function(vehicle)
        ESX.Game.SetVehicleProperties(vehicle, 'steed2')
        SetVehicleLivery(vehicle, 12)
        local playerPed = PlayerPedId()
        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
        dpdblip2()
        end)
    end
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

function dpdblip()
    local blippos = {x = -63.34, y = -2517.15, z = 7.5}
    --local blippos2 = {x = -64.96, y = -2500.43, z = 5.2}
    local dpdblip = AddBlipForCoord(blippos.x, blippos.y, blippos.z)
    --local dpdblip2 = AddBlipForCoord(blippos2.x, blippos2.y, blippos2.z)

  SetBlipSprite (dpdblip, 616)
  SetBlipDisplay(dpdblip, 4)
  SetBlipScale  (dpdblip, 1.0)
  SetBlipColour (dpdblip, 5)
  SetBlipAsShortRange(dpdblip, true)

  --[[SetBlipSprite (dpdblip2, 616)
  SetBlipDisplay(dpdblip2, 4)
  SetBlipScale  (dpdblip2, 1.0)
  SetBlipColour (dpdblip2, 5)
  SetBlipAsShortRange(dpdblip2, true)]]

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName('Stacja kurierska')
  EndTextCommandSetBlipName(dpdblip)
  table.insert(dpdblips, dpdblip)

  --[[BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName('Zwrot pojazdu')
  EndTextCommandSetBlipName(dpdblip2)
  table.insert(dpdblips, dpdblip2)]]
end

function dpdblip2()
if ESX.PlayerData.job and ESX.PlayerData.job.name == 'curier' then
    local blippos2 = {x = -64.96, y = -2500.43, z = 5.2}
    local dpdblip2 = AddBlipForCoord(blippos2.x, blippos2.y, blippos2.z)

  SetBlipSprite (dpdblip2, 616)
  SetBlipDisplay(dpdblip2, 4)
  SetBlipScale  (dpdblip2, 1.0)
  SetBlipColour (dpdblip2, 5)
  SetBlipAsShortRange(dpdblip2, true)

    BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName('Zwrot pojazdu')
  EndTextCommandSetBlipName(dpdblip2)
  table.insert(dpdblips, dpdblip2)
end
end

function CreateDeliveryBlip(x,y,z)
    removeDPDBlips()
    Wait(500)
    local blipDelivery = AddBlipForCoord(x,y,z)

  SetBlipSprite (blipDelivery, 616)
  SetBlipDisplay(blipDelivery, 4)
  SetBlipScale  (blipDelivery, 1.0)
  SetBlipColour (blipDelivery, 5)
  SetBlipAsShortRange(blipDelivery, true)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName('Miejsce dostarczenia przesyłki')
  EndTextCommandSetBlipName(blipDelivery)
  table.insert(DeliveryBlips, blipDelivery)
end

function removeDPDBlips()
      if DeliveryBlips[1] ~= nil then
        for i=1, #DeliveryBlips, 1 do
            RemoveBlip(DeliveryBlips[i])
            DeliveryBlips[i] = nil
        end
    end
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        dpdblip()
    end
end)

AddEventHandler('onClientMapStart', function()
    dpdblip()
end)