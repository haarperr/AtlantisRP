----------------------------[[
--  CalmAI
----------------------------]]

SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_LOST"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_HILLBILLY"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_BALLAS"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MEXICAN"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_FAMILY"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MARABUNTE"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_SALVA"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_WEICHENG"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("GANG_1"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("GANG_2"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("GANG_9"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("GANG_10"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("FIREMAN"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("MEDIC"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("COP"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("ARMY"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("DEALER"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("CIVMALE"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("HEN"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("PRIVATE_SECURITY"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("SECURITY_GUARD"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AGGRESSIVE_INVESTIGATE"), GetHashKey('PLAYER'))



local playerPed = PlayerPedId()
local pos = GetEntityCoords(playerPed)
--local autorskie_xd = math.random(1,6)


--- RadarWhileDrivingACar
local hideRadar = true
local firstSpawnRadar = true
AddEventHandler("playerSpawned", function()
  Citizen.Wait(10000)
end)



-- CLIENTSIDED --
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(200)
    --autorskie_xd = math.random(1,6)
    while firstSpawnRadar do
      if not IsRadarHidden or IsRadarEnabled then
        DisplayRadar(false)
        firstSpawnRadar = false
      end
    end

  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    playerPed = PlayerPedId()
    --pos = GetEntityCoords(playerPed)
----------------------------[[
--  Enable PVP
----------------------------]]
    SetCanAttackFriendly(playerPed, true, false)
    NetworkSetFriendlyFireOption(true)

----------------------------[[
--  NPCControl
----------------------------]]
    local scenarios = {
  'WORLD_VEHICLE_ATTRACTOR',
  'WORLD_VEHICLE_AMBULANCE',
  'WORLD_VEHICLE_BOAT_IDLE',
  'WORLD_VEHICLE_BOAT_IDLE_ALAMO',
  'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',
  'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',
  'WORLD_VEHICLE_BROKEN_DOWN',
  'WORLD_VEHICLE_BUSINESSMEN',
  'WORLD_VEHICLE_HELI_LIFEGUARD',
  'WORLD_VEHICLE_CLUCKIN_BELL_TRAILER',
  'WORLD_VEHICLE_CONSTRUCTION_SOLO',
  'WORLD_VEHICLE_CONSTRUCTION_PASSENGERS',
  'WORLD_VEHICLE_DRIVE_PASSENGERS',
  'WORLD_VEHICLE_DRIVE_PASSENGERS_LIMITED',
  'WORLD_VEHICLE_DRIVE_SOLO',
  'WORLD_VEHICLE_FARM_WORKER',
  'WORLD_VEHICLE_FIRE_TRUCK',
  'WORLD_VEHICLE_EMPTY',
  'WORLD_VEHICLE_MARIACHI',
  'WORLD_VEHICLE_MECHANIC',
  'WORLD_VEHICLE_MILITARY_PLANES_BIG',
  'WORLD_VEHICLE_MILITARY_PLANES_SMALL',
  'WORLD_VEHICLE_PARK_PARALLEL',
  'WORLD_VEHICLE_PARK_PERPENDICULAR_NOSE_IN',
  'WORLD_VEHICLE_PASSENGER_EXIT',
  'WORLD_VEHICLE_POLICE_BIKE',
  'WORLD_VEHICLE_POLICE_CAR',
  'WORLD_VEHICLE_POLICE',
  'WORLD_VEHICLE_POLICE_NEXT_TO_CAR',
  'WORLD_VEHICLE_QUARRY',
  'WORLD_VEHICLE_SALTON',
  'WORLD_VEHICLE_SALTON_DIRT_BIKE',
  'WORLD_VEHICLE_SECURITY_CAR',
  'WORLD_VEHICLE_STREETRACE',
  'WORLD_VEHICLE_TOURBUS',
  'WORLD_VEHICLE_TOURIST',
  'WORLD_VEHICLE_TANDL',
  'WORLD_VEHICLE_TRACTOR',
  'WORLD_VEHICLE_TRACTOR_BEACH',
  'WORLD_VEHICLE_TRUCK_LOGS',
  'WORLD_VEHICLE_TRUCKS_TRAILERS',
  'WORLD_VEHICLE_DISTANT_EMPTY_GROUND'
}

for i, v in ipairs(scenarios) do
  SetScenarioTypeEnabled(v, false)
end

    if IsPedInAnyVehicle(playerPed, true) then

    --  No helmet on bikes  
    SetPedHelmet(playerPed, false)

        --if IsPedSittingInAnyVehicle(playerPed) then
          if not hideRadar then
            DisplayRadar(true)
            hideRadar = true
          end
            if GetPedInVehicleSeat(GetVehiclePedIsIn(playerPed,false),-1) == playerPed then --and autorskie_xd == 6
              --SetVehicleDensityMultiplierThisFrame(0.04) --(0.04)
              --SetParkedVehicleDensityMultiplierThisFrame(0.06) --(0.06)
              --SetPedDensityMultiplierThisFrame(1.0) --(1.0)
              SetRandomVehicleDensityMultiplierThisFrame(0.12) --(0.06)
        --SetSomeVehicleDensityMultiplierThisFrame(0.0)
            else
              SetVehicleDensityMultiplierThisFrame(0.0)
              SetParkedVehicleDensityMultiplierThisFrame(0.0)
              SetPedDensityMultiplierThisFrame(0.0)
              SetRandomVehicleDensityMultiplierThisFrame(0.0)
        --SetSomeVehicleDensityMultiplierThisFrame(0.0)
            end
        else
          
          if hideRadar then
            DisplayRadar(false)
            hideRadar = false
          end
      
              --SetVehicleDensityMultiplierThisFrame(1.0) --(0.04)
              --SetParkedVehicleDensityMultiplierThisFrame(1.0) --(0.06)
              --SetPedDensityMultiplierThisFrame(1.0) --(1.0)
              SetRandomVehicleDensityMultiplierThisFrame(0.12) --(0.06)
        
        end
        --SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
    --SetGarbageTrucks(0)
    --SetRandomBoats(0)
    SetGarbageTrucks(false) -- Stop garbage trucks from randomly spawning
    SetRandomBoats(false) -- Stop random boats from spawning in the water.
    SetCreateRandomCops(false) -- disable random cops walking/driving around.
    SetCreateRandomCopsNotOnScenarios(false) -- stop random cops (not in a scenario) from spawning.
    SetCreateRandomCopsOnScenarios(false) -- stop random cops (in a scenario) from spawning.
    --ClearAreaOfCops(pos.x, pos.y, pos.z, 400.0)
    ClearAreaOfPeds(1680.07, 2512.8, 45.4649, 100.0001)
    --ClearAreaOfPeds(-2080.90, 3258.49, 32.81, 450.0001)
    ClearAreaOfVehicles(-2080.90, 3258.49, 32.81, 450.0001, false, false, false, false, false)
    ClearAreaOfVehicles(-1862.6, 2801.67, 36.58, 100.0001, false, false, false, false, false)
    ClearAreaOfVehicles(-1748.92, 2864.67, 36.58, 100.0001, false, false, false, false, false)
    --ClearAreaOfVehicles(187.00, -343.49, 44.06, 50.0001, false, false, false, false, false)
    --RemoveVehiclesFromGeneratorsInArea(-2920.23, 3168.61, 31.81, -1526.15, 3144.96 100.81);
    --RemoveVehiclesFromGeneratorsInArea(39.00, -453.49, -222.00, 462.22, -248.49, 85.59);      ---- sąd
    RemoveVehiclesFromGeneratorsInArea(-1478.426,-1035.627,5.29558,-1478.426,-1035.627,5.29558)   -- LSL Lranger 1
    RemoveVehiclesFromGeneratorsInArea(-1473.324,-1029.541,5.29558,-1473.324,-1029.541,5.29558)   -- LSL Lranger 2
    RemoveVehiclesFromGeneratorsInArea(-1487.368,-1019.312,5.29558,-1487.368,-1019.312,5.29558)   -- LSL Lranger inside
    --SetAllLowPriorityVehicleGeneratorsActive(false)
    SetNumberOfParkedVehicles(-1)
----------------------------[[
--  Remove PickUps
----------------------------]]

      RemoveAllPickupsOfType(0xDF711959) -- carbine rifle
      RemoveAllPickupsOfType(0xF9AFB48F) -- pistol
      RemoveAllPickupsOfType(0xA9355DCD) -- pumpshotgun
      RemoveAllPickupsOfType(0x88EAACA7)

----------------------------[[
--  Remove Crosshair
----------------------------]]
    if ( DoesEntityExist( playerPed ) and not IsEntityDead( playerPed ) ) then
      
      
          --if ( not IsPlayerFreeAiming(PlayerId()) or  IsPedInAnyVehicle(playerPed, true)) then 
            
              
                HideHudComponentThisFrame( 14 )
                DisplayAmmoThisFrame(false)
        
          --end 
      end
----------------------------[[
--  Disable Player Veh Rewards
----------------------------]]
      DisablePlayerVehicleRewards(playerPed)  
----------------------------[[
--  Disable dispatch
----------------------------]]
      for i = 1, 12 do
      EnableDispatchService(i, false)
      --Citizen.InvokeNative(0xDC0F817884CDD856, i, false)
    end
    --SetPlayerWantedLevel(PlayerId(), 0, false)
    --SetPlayerWantedLevelNow(PlayerId(), false)
    --SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)

----------------------------[[
--  WeaponBlock (anti KO)
----------------------------]]
    if IsPedArmed(playerPed, 6) then
            DisableControlAction(1, 140, true)
              DisableControlAction(1, 141, true)
              DisableControlAction(1, 142, true)
        end


  end
end)