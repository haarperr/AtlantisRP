local HoldingPackage = false
local wroking = false
local Package = nil
local storekeeperblips = {}

DropPackage = {
    [1] = {x = -155.16593933106, y = 6160.0708007812, z = 31.20629310608},
    [2] = {x = -159.0747680664, y = 6163.9545898438, z = 31.206336975098},
    [3] = {x = -162.43560791016, y = 6167.4243164062, z = 31.206377029418},
    [4] = {x = -167.56971740722, y = 6173.767578125, z = 31.206377029418},
    [5] = {x = -174.94288635254, y = 6170.501953125, z = 31.206377029418},
    [6] = {x = -165.9246673584, y = 6167.544921875, z = 31.206377029418},
    [7] = {x = -162.52703857422, y = 6164.1640625, z = 31.206377029418},
    [8] = {x = -159.27072143554, y = 6160.828125, z = 31.206369400024},
    [9] = {x = -155.8184967041, y = 6157.1220703125, z = 31.206329345704},
    [10] = {x = -158.9640197754, y = 6155.357421875, z = 31.206369400024},
    [11] = {x = -163.35583496094, y = 6159.55078125, z = 31.206373214722},
    [12] = {x = -166.27574157714, y = 6162.8330078125, z = 31.206373214722},
    [13] = {x = -170.1257019043, y = 6164.3515625, z = 31.206373214722},
    [14] = {x = -168.8794555664, y = 6161.7504882812, z = 31.206373214722},
    [15] = {x = -166.97863769532, y = 6159.998046875, z = 31.206373214722},
    [16] = {x = -165.0838317871, y = 6158.0200195312, z = 31.206373214722},
    [17] = {x = -161.59371948242, y = 6154.6606445312, z = 31.20637512207},
    [18] = {x = -154.33053588868, y = 6140.3715820312, z = 32.335117340088},
    [19] = {x = -163.17112731934, y = 6148.5170898438, z = 31.206380844116},
    [20] = {x = -162.78942871094, y = 6150.9814453125, z = 31.206380844116},
    [21] = {x = -165.0982055664, y = 6150.962890625, z = 31.206380844116},
    [22] = {x = -166.234375, y = 6154.529296875, z = 31.206380844116},
    [23] = {x = -169.3826751709, y = 6154.5400390625, z = 31.206380844116},
    [24] = {x = -169.40893554688, y = 6157.7172851562, z = 31.206380844116},
    [25] = {x = -172.60929870606, y = 6157.7802734375, z = 31.206380844116},
    [26] = {x = -172.34748840332, y = 6160.6704101562, z = 31.206380844116},
    [27] =  {x = -176.64399719238, y = 6156.9711914062, z = 31.206380844116},
    [28] = {x = -178.20692443848, y = 6153.3276367188, z = 31.206380844116},
    [29] = {x = -173.50489807128, y = 6154.0200195312, z = 31.206380844116},
    [30] = {x = -173.0647277832, y = 6149.8471679688, z = 31.206380844116},
    [31] = {x = -169.8807220459, y = 6150.2055664062, z = 31.206380844116},
    [32] = {x = -167.69119262696, y = 6147.6088867188, z = 31.206380844116},
    [33] = {x = -168.10168457032, y = 6144.2026367188, z = 31.206380844116},
    [34] = {x = -138.84101867676, y = 6155.3046875, z = 31.20618057251},
    [35] = {x = -136.40264892578, y = 6117.9091796875, z = 31.18124961853},
    [36] = {x = -147.11882019042, y = 6105.0795898438, z = 31.240461349488}
}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('storekeeper:start')
AddEventHandler('storekeeper:start', function()
    if checkifincar() then
            TriggerEvent("pNotify:SendNotification", {text = "Nie mozesz byc w pojezdzie", type =      "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})  
    else
        if not HoldingPackage then
            TriggerEvent('storekeeper:working')
        else
            TriggerEvent("pNotify:SendNotification", {text = "Najpierw odstaw poprzednia paczke", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
            --ESX.ShowNotification('Najpierw odstaw poprzednia paczke.')
        end
    end
end)

RegisterNetEvent('storekeeper:working')
AddEventHandler('storekeeper:working', function()
    GotPackage()
    working = true 
    HoldingPackage = true
    local DropCoords = DropPackage[math.random(#DropPackage)]
    while working do 
    Citizen.Wait(0)
        DrawText3Ds(DropCoords.x, DropCoords.y, DropCoords.z, "~b~[E] ~s~Aby odstawić paczkę")
        DisableControlAction(0, 73, true) -- X
        if IsControlJustReleased(0, 38) then
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), DropCoords.x, DropCoords.y, DropCoords.z, true) < 1.5 then
                storekeepersuccess()
            end
        end
    end
end)

function storekeepersuccess()
    if checkifincar() then
            TriggerEvent("pNotify:SendNotification", {text = "Nie mozesz byc w pojezdzie", type =      "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})  
    else
        RemovePackage()
        TriggerEvent('show:money', 2.5)
        TriggerServerEvent('storekeeper:pay')
        --print('dziala')
        working = false
        HoldingPackage = false
    end
end

function checkifincar()
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        return true
    elseif IsPedOnAnyBike(PlayerPedId()) then
        return true
    else
        return false 
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

function storekeeperblip()
    local storeblippos = {x = -123.4133, y = 6174.798, z = 31.00}
  local storekeeperblip = AddBlipForCoord(storeblippos.x, storeblippos.y, storeblippos.z)

  SetBlipSprite (storekeeperblip, 501)
  SetBlipDisplay(storekeeperblip, 4)
  SetBlipScale  (storekeeperblip, 1.0)
  SetBlipColour (storekeeperblip, 5)
  SetBlipAsShortRange(storekeeperblip, true)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName('Magazynier')
  EndTextCommandSetBlipName(storekeeperblip)
  table.insert(storekeeperblips, storekeeperblip)
end

function GotPackage()
    local ad = "anim@heists@box_carry@"
    local anim = "idle"
    local player = PlayerPedId()


    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, anim, 8 ) ) then
            TaskPlayAnim( player, ad, "exit", 8.0, 8.0, 1.0, 50, 1, 0, 0, 0 )
            ClearPedSecondaryTask(player)
        else
            SetCurrentPedWeapon( player, GetHashKey("WEAPON_UNARMED"), equipNow)
            Package = CreateObject(GetHashKey("v_ind_cf_chckbox1"), 0, 0, 0, true, true, true) -- creates object
            AttachEntityToEntity(Package, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 28422), 0.0, -0.25, -0.15, 0, 0, 0, true, true, false, true, 1, true)
            Citizen.Wait(50)
            TaskPlayAnim( player, ad, anim, 8.0, 8.0, 1.0, 50, 1, 0, 0, 0 )
        end
    end
end

function RemovePackage()
    DetachEntity(Package)
    ClearPedSecondaryTask(PlayerPedId())
    Wait(1000)
    DeleteEntity(Package)
    Package = nil
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        storekeeperblip()
    end
end)

AddEventHandler('onClientMapStart', function()
    storekeeperblip() 
end)