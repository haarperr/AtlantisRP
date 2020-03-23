ESX                           = nil
local PlayerData = {}
local cachedBins = {}
local searchedBins = 0
local drinking = false
local IsDead = false
local used = false

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
            ESX = obj 
        end)

        Citizen.Wait(5)
    end

    while ESX.GetPlayerData().job == nil do
      Citizen.Wait(100)
    end

    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)


Citizen.CreateThread(function()
    Citizen.Wait(100)

    for locationIndex = 1, #Config.SellBottleLocations do
        local locationPos = Config.SellBottleLocations[locationIndex]

        local blip = AddBlipForCoord(locationPos)

        SetBlipSprite (blip, 499)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.8)
        SetBlipColour (blip, 56)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Skup butelek")
        EndTextCommandSetBlipName(blip)
    end

    while true do
        local sleepThread = 500

        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)

        for locationIndex = 1, #Config.SellBottleLocations do
            local locationPos = Config.SellBottleLocations[locationIndex]

            local dstCheck = GetDistanceBetweenCoords(pedCoords, locationPos, true)

            if dstCheck <= 5.0 then
                sleepThread = 5

                local text = "Skup butelek"

                if dstCheck <= 1.5 then
                    text = "[~g~E~s~] aby sprzedać butelki"

                    if IsControlJustReleased(0, 38) then
                        TriggerServerEvent("esx-ecobottles:sellBottles")
                    end
                end
                
                ESX.Game.Utils.DrawText3D(locationPos, text, 0.8)
            end
        end

        Citizen.Wait(sleepThread)
    end
end)

RegisterCommand("kosz", function(source, args, raw)
    if searchedBins >= 10 then
        cachedBins = {}
    end

    local entity, entityDst = ESX.Game.GetClosestObject(Config.BinsAvailable)

    if DoesEntityExist(entity) and entityDst <= 1.5 and not IsDead then
        NetworkRequestControlOfEntity(entity)
        if not cachedBins[entity] then
            cachedBins[entity] = true
            searchedBins = searchedBins + 1
            OpenTrashCan()
            
        else
            ESX.ShowNotification("Już sprawdzałeś ten smietnik!")
        end
    end
end, false)

RegisterCommand("wozek", function(source, args)
  if PlayerData.job.name == 'kloszard' and not used then
    if args[1] == nil then
      PickUp()
      used = true
    elseif args[1] == 'craft' then
      TriggerServerEvent("craft:vine")
      used = true
    end
  end
end, false)

PickUp = function() 
   local ped = PlayerPedId()
   local pedCoords = GetEntityCoords(ped)
   local closestObject = GetClosestObjectOfType(pedCoords, 10.0, GetHashKey('prop_skid_trolley_1'), false)

   if DoesEntityExist(closestObject) then
     NetworkRequestControlOfEntity(closestObject)

    while not NetworkHasControlOfEntity(closestObject) do
      Wait(10)
      NetworkRequestControlOfEntity(closestObject)
    end

  LoadAnim("anim@heists@box_carry@")

  AttachEntityToEntity(closestObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.45, -0.75, 195.0, 180.0, 180.0, 0.0, false, false, true, false, 2, true)

  while IsEntityAttachedToEntity(closestObject, PlayerPedId()) do
    Citizen.Wait(0)
      DisableControlAction(0,21,true) -- disable sprint
      DisableControlAction(0,22,true) -- disable sprint
      DisableControlAction(0,24,true) -- disable attack
      DisableControlAction(0,25,true) -- disable aim
      DisableControlAction(0,47,true) -- disable weapon
      DisableControlAction(0,58,true) -- disable weapon
      DisableControlAction(0,263,true) -- disable melee
      DisableControlAction(0,264,true) -- disable melee
      DisableControlAction(0,257,true) -- disable melee
      DisableControlAction(0,140,true) -- disable melee
      DisableControlAction(0,141,true) -- disable melee
      DisableControlAction(0,142,true) -- disable melee
      DisableControlAction(0,143,true) -- disable melee
      DisableControlAction(0,75,true) -- disable exit vehicle
      DisableControlAction(27,75,true) -- disable exit vehicle
    if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 3) then
      TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
    end

    if IsPedDeadOrDying(PlayerPedId()) then
      DetachEntity(closestObject, true, true)
      used = false
    end

    if IsPedInAnyVehicle(PlayerPedId(), true) then
      DetachEntity(closestObject, true, true)
      used = false    
    end

    if IsControlJustPressed(0, 73) then
      DetachEntity(closestObject, true, true)
      used = false
    end
  end
end
end

LoadAnim = function(dict)
  while not HasAnimDictLoaded(dict) do
    RequestAnimDict(dict)
    
    Citizen.Wait(1)
  end
end

function OpenTrashCan()
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
    keylock()
end

function keylock()
  FreezeEntityPosition(PlayerPedId(), true)
  lock = 0
  repeat
  DisableControlAction(0, 73, true)
  lock = lock + 1
  Citizen.Wait(0)
  until(lock == 750)
  FreezeEntityPosition(PlayerPedId(), false)
  TriggerServerEvent("esx-ecobottles:retrieveBottle")
  ClearPedTasks(PlayerPedId())
end


RegisterNetEvent('extraluck')
AddEventHandler('extraluck', function()
    PlayerData = ESX.GetPlayerData()
    if PlayerData.job.name == 'kloszard' then
        luck = math.random(15)
    else
        luck = math.random(30)
    end
    if luck <= 2 then
        TriggerServerEvent("esx-ecobottles:extraitem")
    end
end)

RegisterNetEvent('komandos')
AddEventHandler('komandos', function()
    if not drinking and not IsDead then
        prop_name = prop_name or 'p_cs_bottle_01'
        drinking = true

        Citizen.CreateThread(function()
            local playerPed = PlayerPedId()
            local x,y,z = table.unpack(GetEntityCoords(playerPed))
            local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
            local boneIndex = GetPedBoneIndex(playerPed, 18905)
            AttachEntityToEntity(prop, playerPed, boneIndex, 0.09, -0.065, 0.045, -100.0, 0.0, -25.0, 1, 1, 0, 1, 1, 1)

            ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
                TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 8.0, 3.0, -1, 57, 1, 0, 0, 0)

                Citizen.Wait(6000)
                ClearPedSecondaryTask(playerPed)
                DeleteObject(prop)
                DrunkedTime = math.random(5000, 15000)
                WASTED(DrunkedTime)
            end)
        end)
   end
end)

function WASTED(number)
  DeStRoYeD()
  lvl = number
  RequestAnimSet("move_m@drunk@verydrunk")
  while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
    Citizen.Wait(0)
  end
  repeat
  SetPedMovementClipset(GetPlayerPed(-1), "move_m@drunk@verydrunk", 1 )
  DisableControlAction(0,21,true) -- disable sprint
  DisableControlAction(0,22,true) -- disable sprint
  DisableControlAction(0,24,true) -- disable attack
  DisableControlAction(0,25,true) -- disable aim
  DisableControlAction(0,47,true) -- disable weapon
  DisableControlAction(0,58,true) -- disable weapon
  DisableControlAction(0,263,true) -- disable melee
  DisableControlAction(0,264,true) -- disable melee
  DisableControlAction(0,257,true) -- disable melee
  DisableControlAction(0,140,true) -- disable melee
  DisableControlAction(0,141,true) -- disable melee
  DisableControlAction(0,142,true) -- disable melee
  DisableControlAction(0,143,true) -- disable melee
  DisableControlAction(0,75,true) -- disable exit vehicle
  DisableControlAction(27,75,true) -- disable exit vehicle
  lvl = lvl - 1
  Citizen.Wait(0)
  until(lvl == 0)
  stop()
end

function DeStRoYeD()
  StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
  StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
  StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
  ShakeGameplayCam("DRUNK_SHAKE", 0.8)
end

function stop()
  StopScreenEffect("DrugsMichaelAliensFightIn")
  StopScreenEffect("DrugsMichaelAliensFight")
  StopScreenEffect("DrugsMichaelAliensFightOut")
  ShakeGameplayCam("DRUNK_SHAKE", 0.0)
  drinking = false
  local zgon = math.random(10)
  if zgon <= 5 then
    local ForwardVector = GetEntityForwardVector(PlayerPedId())
    SetPedToRagdollWithFall(PlayerPedId(), 3000, 3000, 0, ForwardVector, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
        DoScreenFadeOut(800)
        while not IsScreenFadedOut() do
            Citizen.Wait(10)
        end
        while IsPedRagdoll(PlayerPedId()) do
            Citizen.Wait(10)
        end
        Citizen.Wait(2000)
        PlayerData = ESX.GetPlayerData()
        if PlayerData.job.name == 'kloszard' then
              DoScreenFadeIn(800)
              if IsScreenFadedOut() then
                  DoScreenFadeIn(800)
              end
        else
          ESX.Streaming.RequestAnimDict('amb@world_human_bum_slumped@male@laying_on_right_side@base', function()
              TaskPlayAnim(PlayerPedId(), 'amb@world_human_bum_slumped@male@laying_on_right_side@base', 'base', 8.0, 3.0, -1, 2, 1, 0, 0, 0)
              DoScreenFadeIn(800)
              if IsScreenFadedOut() then
                  DoScreenFadeIn(800)
              end
              sleeptime = math.random(1500, 2000)
              sleep(sleeptime)
          end)
        end
  end
end

function sleep(sleeptime)
    shouldsleep = sleeptime
    TriggerServerEvent('3dme:shareDisplayDo', '* Słychać odgłosy chrapania *')
    repeat
    DisableControlAction(0, 44, true) -- Cover
    DisableControlAction(0, 37, true) -- Select Weapon
    DisableControlAction(0, 311, true) -- K
    DisableControlAction(0, 59, true) -- Disable steering in vehicle
    DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
    DisableControlAction(0, 72, true) -- Disable reversing in vehicle
    DisableControlAction(0, 69, true) -- INPUT_VEH_ATTACK
    DisableControlAction(0, 92, true) -- INPUT_VEH_PASSENGER_ATTACK
    DisableControlAction(0, 114, true) -- INPUT_VEH_FLY_ATTACK
    DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
    DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
    DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
    DisableControlAction(0, 257, true) -- INPUT_ATTACK2
    DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
    DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
    DisableControlAction(0, 24, true) -- INPUT_ATTACK
    DisableControlAction(0, 25, true) -- INPUT_AIM
    DisableControlAction(0, 21, true) -- SHIFT
    DisableControlAction(0, 22, true) -- SPACE
    DisableControlAction(0, 288, true) -- F1
    DisableControlAction(0, 289, true) -- F2
    DisableControlAction(0, 170, true) -- F3
    DisableControlAction(0, 57, true) -- F10
    DisableControlAction(0, 73, true) -- X
    DisableControlAction(0, 244, true) -- M
    DisableControlAction(0, 246, true) -- Y
    DisableControlAction(0, 74, true) -- H
    DisableControlAction(0, 29, true) -- B
    DisableControlAction(0, 243, true) -- ~
    DisableControlAction(0, 244, true) -- M
    DisableControlAction(0, 81, true) -- ,
    DisableControlAction(0, 82, true) -- .

    if not IsEntityPlayingAnim(PlayerPedId(), 'amb@world_human_bum_slumped@male@laying_on_right_side@base', 'base', 3) then
        TaskPlayAnim(PlayerPedId(), 'amb@world_human_bum_slumped@male@laying_on_right_side@base', 'base', 8.0, 3.0, -1, 2, 1, 0, 0, 0)
    end
    shouldsleep = shouldsleep - 1
    Citizen.Wait(0)
    until(shouldsleep == 0)
end

AddEventHandler('playerSpawned', function()
    IsDead = false
end)


AddEventHandler('esx:onPlayerDeath', function(data)
    IsDead = true
end)


RegisterNetEvent('craftprocess')
AddEventHandler('craftprocess', function()
    TriggerEvent('2d:ProgressBar', "Trwa przygotowywanie mikstury", 90)
    RequestAnimDict("switch@franklin@cleaning_car")
    while (not HasAnimDictLoaded("switch@franklin@cleaning_car")) do Citizen.Wait(0) end
    craft(500)
end)


function craft(crafttime)
    shouldcraft = crafttime
    TriggerServerEvent('3dme:shareDisplayDo', '* Wyciska pomarancze do butelki i zalewa wódką... *')
    repeat
    DisableControlAction(0, 44, true) -- Cover
    DisableControlAction(0, 37, true) -- Select Weapon
    DisableControlAction(0, 311, true) -- K
    DisableControlAction(0, 59, true) -- Disable steering in vehicle
    DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
    DisableControlAction(0, 72, true) -- Disable reversing in vehicle
    DisableControlAction(0, 69, true) -- INPUT_VEH_ATTACK
    DisableControlAction(0, 92, true) -- INPUT_VEH_PASSENGER_ATTACK
    DisableControlAction(0, 114, true) -- INPUT_VEH_FLY_ATTACK
    DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
    DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
    DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
    DisableControlAction(0, 257, true) -- INPUT_ATTACK2
    DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
    DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
    DisableControlAction(0, 24, true) -- INPUT_ATTACK
    DisableControlAction(0, 25, true) -- INPUT_AIM
    DisableControlAction(0, 21, true) -- SHIFT
    DisableControlAction(0, 22, true) -- SPACE
    DisableControlAction(0, 288, true) -- F1
    DisableControlAction(0, 289, true) -- F2
    DisableControlAction(0, 170, true) -- F3
    DisableControlAction(0, 57, true) -- F10
    DisableControlAction(0, 73, true) -- X
    DisableControlAction(0, 244, true) -- M
    DisableControlAction(0, 246, true) -- Y
    DisableControlAction(0, 74, true) -- H
    DisableControlAction(0, 29, true) -- B
    DisableControlAction(0, 243, true) -- ~
    DisableControlAction(0, 244, true) -- M
    DisableControlAction(0, 81, true) -- ,
    DisableControlAction(0, 82, true) -- .

    if not IsEntityPlayingAnim(PlayerPedId(), 'switch@franklin@cleaning_car', '001946_01_gc_fras_v2_ig_5_base', 3) then
        TaskPlayAnim(PlayerPedId(), 'switch@franklin@cleaning_car', '001946_01_gc_fras_v2_ig_5_base', 8.0, 3.0, -1, 1, 1, 0, 0, 0)
    end
    shouldcraft = shouldcraft - 1
    Citizen.Wait(0)
    until(shouldcraft == 0)
    used = false
    TriggerServerEvent("craft:giveitem")
end
