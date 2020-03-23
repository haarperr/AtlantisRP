local HoldingDrink = false
local barmanWorking = false
local Drink = nil

DrinkName = {
[1] = 'Podajesz klientowi piwo',
[2] = 'Podajesz klientowi wódkę',
[3] = 'Podajesz klientowi shoty kamikadze',
[4] = 'Podajesz klientowi whiskey z colą',
[5] = 'Podajesz klientowi mojito',
[6] = 'Podajesz klientowi martini',
[7] = 'Podajesz klientowi krwawą mary',
[8] = 'Podajesz klientowi rum',
[9] = 'Podajesz klientowi szampana',
[10] = 'Podajesz klientowi kieliszek wina',
}

DrinkProp = {
[1] = "prop_drink_champ",
[2] = "prop_drink_whisky",
[3] = "prop_drink_redwine",
[4] = "prop_drink_whtwine",

}


DropDrink = {
    [1] = {x = 124.98, y = -1283.47, z = 29.28},
    [2] = {x = 125.41, y = -1285.15, z = 29.28},
    [3] = {x = 125.75, y = -1286.64, z = 29.28},
    [4] = {x = 121.71, y = -1288.39, z = 28.28},
    [5] = {x = 121.27, y = -1287.12, z = 28.28},
    [6] = {x = 120.38, y = -1285.51, z = 28.28},
    [7] = {x = 118.41, y = -1283.24, z = 28.28},
    [8] = {x = 106.52, y = -1283.95, z = 28.28},
    [9] = {x = 102.81, y = -1286.12, z = 28.28},
    [10] = {x = 111.67, y = -1292.95, z = 28.28},
    [11] = {x = 107.78, y = -1295.47, z = 28.28},
}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

--[[RegisterCommand("drink", function(source, args, raw)
                GotDrink()
end, false)]]

--[[RegisterCommand("drink2", function(source, args, raw)
                RemoveDrink()
end, false)]]

RegisterNetEvent('barman:start')
AddEventHandler('barman:start', function()
    if not HoldingDrink then
        TriggerEvent('2d:ProgressBar', 'Trwa pobieranie zamówienia', 1)
        Wait(1000)
        TriggerEvent('barman:barmanWorking')
    else
        TriggerEvent("pNotify:SendNotification", {text = "Najpierw dostarcz poprzednie zamówienie", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
        --ESX.ShowNotification('Najpierw dostarcz poprzednie zamówienie.')
    end
end)

RegisterNetEvent('barman:barmanWorking')
AddEventHandler('barman:barmanWorking', function()
    GotDrink()
    barmanWorking = true 
    HoldingDrink = true
    local DropDrinkCoords = DropDrink[math.random(#DropDrink)]
    local DropDrinkName = DrinkName[math.random(#DrinkName)]
    while barmanWorking do 
    Citizen.Wait(0)
        DrawText3Ds(DropDrinkCoords.x, DropDrinkCoords.y, DropDrinkCoords.z, "~b~[E] ~s~Aby dostarczyć zamówienie")
        DisableControlAction(0, 73, true) -- X
        if IsControlJustReleased(0, 38) then
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), DropDrinkCoords.x, DropDrinkCoords.y, DropDrinkCoords.z, true) < 1.5 then
                barmansucces(DropDrinkName)
            end
        end
    end
end)

function barmansucces(drink)
    --[[local failRandom = math.random(0,10)
    if failRandom > 1 then]]
        TriggerEvent("pNotify:SendNotification", {text = drink, type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
        --TriggerEvent('2d:HelpText', 0.65,0.050, drink)
        RemoveDrink()
        TriggerEvent('show:money', 2.5)
        TriggerServerEvent('barman:pay')
        barmanWorking = false
        HoldingDrink = false
    --[[else 
        TriggerEvent("pNotify:SendNotification", {text = "Ty ciamajdo! Rozlewasz drinka, nie ma napiwku", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
        --TriggerEvent('2d:HelpText', 0.82,0.050, 'Ty ciamajdo! Rozlewasz drinka, nie ma napiwku')
        RemoveDrink()
        barmanWorking = false
        HoldingDrink = false
    end]]
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

function GotDrink()
    local ad = "anim@heists@box_carry@"
    local anim = "idle"
    local player = PlayerPedId()
    local randomprop = DrinkProp[math.random(#DrinkProp)]


    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, anim, 8 ) ) then
            TaskPlayAnim( player, ad, "exit", 8.0, 8.0, 1.0, 51, 1, 0, 0, 0 )
            ClearPedSecondaryTask(player)
        else
            SetCurrentPedWeapon( player, GetHashKey("WEAPON_UNARMED"), equipNow)
            Drink = CreateObject(GetHashKey("prop_cs_silver_tray"), 0, 0, 0, true, true, true) -- creates object
            Drink2 = CreateObject(GetHashKey(randomprop), 0, 0, 0, true, true, true) -- creates object
            AttachEntityToEntity(Drink, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 28422), 0.0, -0.25, -0.15, 0, 0, 0, true, true, false, true, 1, true)
            AttachEntityToEntity(Drink2, Drink, GetPedBoneIndex(GetPlayerPed(-1), 28422), 0.0, 0.0, 0.0, 0, 0, 0, true, true, false, true, 1, true)
            Citizen.Wait(50)
            TaskPlayAnim( player, ad, anim, 8.0, 8.0, 1.0, 51, 1, 0, 0, 0 )
        end
    end
end

function RemoveDrink()
    DeleteEntity(Drink)
    DeleteEntity(Drink2)
    Drink = nil
    Drink2 = nil
    ClearPedSecondaryTask(PlayerPedId())
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

-- Funkcja na kurwy
function Icoterazkurwy()
    local ForwardVector = GetEntityForwardVector(PlayerPedId())
    Citizen.Wait(500)
    TriggerEvent("pNotify:SendNotification", {text = "Ty ciamajdo! Rozlewasz drinka, nie ma napiwku", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
    SetPedToRagdollWithFall(PlayerPedId(), 3000, 3000, 0, ForwardVector, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
    RemoveDrink()
    barmanWorking = false
    HoldingDrink = false
end

-- Loop na kurwy

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local ped = PlayerPedId()
        
        if HoldingDrink then
            if IsPedJumping(ped) or IsPedVaulting(ped) then
                Icoterazkurwy()
            end
        end
    end
end)