-------------------------------------------------------------------------------
-- Title: Speed limiter.
-- Author: Serpico -- twitch.tv/SerpicoTV
-- Description: This script will restict the speed of the vehicle when
--              INPUT_MP_TEXT_CHAT_TEAM is pressed. To disable, press
--              INPUT_VEH_SUB_ASCEND + INPUT_MP_TEXT_CHAT_TEAM
-------------------------------------------------------------------------------
local useMph = false -- if false, it will display speed in kph
local minSpeed = 20
local lockSpeed = false
local checkCruiseLock = 0
local enabled = false


Citizen.CreateThread(function()
  local resetSpeedOnEnter = true
  while true do
    Citizen.Wait(0)
    local playerPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(playerPed,false)
    if GetPedInVehicleSeat(vehicle, -1) == playerPed and IsPedInAnyVehicle(playerPed, false) and GetVehicleClass(vehicle) ~= 14 and GetVehicleClass(vehicle) ~= 15 and GetVehicleClass(vehicle) ~= 16 and GetVehicleClass(vehicle) ~= 13 and GetVehicleClass(vehicle) ~= 8 then
      if IsControlJustReleased(0,313) and IsControlPressed(0,131) then
        if not enabled then
          if lockSpeed then
            showHelpNotification("Tempomat: Tryb 1")
            lockSpeed = false
        --  else
        --    showHelpNotification("Tempomat: Tryb 2")
        --    lockSpeed = true
          end
      else
          showHelpNotification("Wyłacz tempomat, aby zmienić tryb.")
   		 end
 	end
      -- This should only happen on vehicle first entry to disable any old values
      if resetSpeedOnEnter then
        maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
        SetEntityMaxSpeed(vehicle, maxSpeed)
        resetSpeedOnEnter = false
       
      end
      --if lockSpeed and enabled and IsVehicleOnAllWheels(vehicle)  then
     --   SetVehicleForwardSpeed(vehicle, checkCruiseLock)
     -- end
      if (checkCruiseLock > GetEntitySpeed(vehicle) + 0.5  )  and lockSpeed and enabled then
      	maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
        SetEntityMaxSpeed(vehicle, maxSpeed)
        showHelpNotification("Tempomat wyłączony")
        enabled = false
        Citizen.Wait(2000)
   	  end
      if IsControlJustPressed(2, 72) and enabled and lockSpeed and not IsControlPressed(0,131) then
        maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
        SetEntityMaxSpeed(vehicle, maxSpeed)
        showHelpNotification("Tempomat wyłączony")
        enabled = false	
        Citizen.Wait(2000)
      end
      -- Disable speed limiter
      if IsControlJustReleased(0,313) and enabled and not lockSpeed and not IsControlPressed(0,131) then
        maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
        SetEntityMaxSpeed(vehicle, maxSpeed)
        showHelpNotification("Tempomat wyłączony")
        enabled = false
        Citizen.Wait(2000)
        
      -- Enable speed limiter

      elseif IsControlJustReleased(0,313) and not enabled and not IsControlPressed(0,131) then
        
        cruise = GetEntitySpeed(vehicle)
        checkCruiseLock = GetEntitySpeed(vehicle)
        --local checkCruise = math.floor(cruise * 3.6 + 0.5) -- kmh
        local checkCruise = math.floor(cruise * 2.236936 + 0.5) -- mph
        if checkCruise > minSpeed then
          SetEntityMaxSpeed(vehicle, cruise)
          enabled = true
          if useMph then
            cruise = math.floor(cruise * 2.236936 + 0.5)
            showHelpNotification("Tempomat ustawiony na "..cruise.." mph.")
            Citizen.Wait(2000)
          else

            cruise = math.floor(cruise * 2.236936 + 0.5)
            showHelpNotification("Tempomat ustawiony na "..cruise.." mph.")
            --cruise = math.floor(cruise * 3.6 + 0.5) + 1
            --showHelpNotification("Tempomat ustawiony na "..cruise.." km/h.")
            Citizen.Wait(2000)
            
           -- SetVehicleForwardSpeed(vehicle, 75.0)
          end
        else
          showHelpNotification("Minimalna prędkość to: "..minSpeed.." mph.")
        end
      end
    else
      resetSpeedOnEnter = true
      enabled = false
    end
  end
end)

function showHelpNotification(msg)
TriggerEvent("pNotify:SendNotification", {
          text = msg,
          type = "atlantis",
          queue = "global",
          timeout = 2000,
          layout = "atlantis"
        })


end

