-- Barbie was here --
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

local PlayerData              = {}

local isCarry 				  = false
local isCarry1 				  = false
local isCarry2 				  = false
local isDead 				  = false

ESX                     = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

function LoadAnimationDictionary(animationD)
	while(not HasAnimDictLoaded(animationD)) do
		RequestAnimDict(animationD)
		Citizen.Wait(1)
	end
end

RegisterNetEvent('esx_barbie_lyftupp:upplyft')
AddEventHandler('esx_barbie_lyftupp:upplyft', function(target)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	local lPed = GetPlayerPed(-1)
	local dict = "amb@world_human_bum_slumped@male@laying_on_left_side@base"
	if not IsPedInAnyVehicle(PlayerPedId(), true) then
		if isCarry == false then
			SetCurrentPedWeapon(PlayerPedId(), -1569615261,true)
			Citizen.Wait(1)	
			LoadAnimationDictionary("amb@world_human_bum_slumped@male@laying_on_left_side@base")
			TaskPlayAnim(lPed, "amb@world_human_bum_slumped@male@laying_on_left_side@base", "base", 8.0, -8, -1, 33, 0, 0, 40, 0)

	AttachEntityToEntity(GetPlayerPed(-1), targetPed, GetPedBoneIndex(PlayerPedId(), 40269), -0.1, -0.05, 0.8, 0.9, 0.30, 220.0,1, 0, 0, 0, 0, 1)
			
			isCarry = true
			isCarry2 = true
		else
			DetachEntity(GetPlayerPed(-1), true, false)
			ClearPedTasksImmediately(targetPed)
			ClearPedTasksImmediately(GetPlayerPed(-1))
			
			isCarry = false
			isCarry2 = false
		end
	end
end)

RegisterCommand("podnies", function(source, args, raw)
	if not IsPedCuffed(PlayerPedId()) and not IsDead and not isCarry1 or not isCarry2 then
			local player, distance = ESX.Game.GetClosestPlayer()
			ESX.ShowNotification('Podnosisz osobe...')
			TriggerServerEvent('esx_barbie_lyftupp:lyfteruppn', GetPlayerServerId(player))
			Citizen.Wait(2000)
			local dict = "rcmpaparazzo_4"
				
				RequestAnimDict(dict)
				while not HasAnimDictLoaded(dict) do
					Citizen.Wait(100)
				end
				local player, distance = ESX.Game.GetClosestPlayer()
				local targetPed = GetPlayerPed(GetPlayerFromServerId(player))
				
				if distance ~= -1 and distance <= 3.0 then
					if not IsPedInAnyVehicle(PlayerPedId(), true) then
						if isCarry == false then
							local closestPlayer, distance = ESX.Game.GetClosestPlayer()
							TriggerServerEvent('esx_barbie_lyftupp:lyfter', GetPlayerServerId(closestPlayer))		
							SetCurrentPedWeapon(PlayerPedId(), -1569615261,true)
							Citizen.Wait(1)	
							TaskPlayAnim(GetPlayerPed(-1), dict, "gesture_to_cam_camman", 8.0, 8.0, -1, 50, 0, false, false, false)
							isCarry = true
							isCarry1 = true
						elseif isCarry == true then
							local closestPlayer, distance = ESX.Game.GetClosestPlayer()
							TriggerServerEvent('esx_barbie_lyftupp:lyfter', GetPlayerServerId(closestPlayer))		
							isCarry = false
							isCarry1 = false
						end
					end
				else
					ESX.ShowNotification("Nikogo nie ma w pobliżu...")
				end
		end

end, false)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
		if isCarry1 then
			if not IsEntityPlayingAnim(PlayerPedId(), 'rcmpaparazzo_4', 'gesture_to_cam_camman', 3) then
				LoadAnimationDictionary('rcmpaparazzo_4')
				ClearPedSecondaryTask(PlayerPedId())
				TaskPlayAnim(GetPlayerPed(-1), 'rcmpaparazzo_4', "gesture_to_cam_camman", 8.0, 8.0, -1, 50, 0, false, false, false)
          	end
		elseif isCarry2 then
			if not IsEntityPlayingAnim(PlayerPedId(), 'amb@world_human_bum_slumped@male@laying_on_left_side@base', 'base', 3) then
				LoadAnimationDictionary("amb@world_human_bum_slumped@male@laying_on_left_side@base")
				ClearPedSecondaryTask(PlayerPedId())
				TaskPlayAnim(PlayerPedId(), "amb@world_human_bum_slumped@male@laying_on_left_side@base", "base", 8.0, -8, -1, 33, 0, 0, 40, 0)
          	end
		else
			Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
		if isCarry then
    DisableControlAction(2, 199, true) -- Disable pause screen
    DisableControlAction(2, 200, true) -- Disable pause screen alternate
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
		end
    end
end)

RegisterNetEvent('esx_barbie_lyftupp:free')
AddEventHandler('esx_barbie_lyftupp:free', function()
	if isCarry then
		DetachEntity(GetPlayerPed(-1), true, false)
		ClearPedTasksImmediately(GetPlayerPed(-1))
		isCarry = false
		isCarry1 = false
		isCarry2 = false
	end
end)

RegisterCommand("uwolnij", function(source, args, raw)
local player, distance = ESX.Game.GetClosestPlayer()
	if isCarry and not IsDead then
		TriggerServerEvent('esx_barbie_lyftupp:setfree', GetPlayerServerId(player))
	end
end)

AddEventHandler('playerSpawned', function()
	IsDead = false
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	ExecuteCommand("uwolnij")
	IsDead = true
end)
