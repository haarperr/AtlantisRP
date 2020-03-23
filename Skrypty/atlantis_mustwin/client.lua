ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local weapons = {
	"WEAPON_FLASHLIGHT",
	"WEAPON_STUNGUN",
	"WEAPON_UNARMED",
}

local stuntime = 4500 -- in miliseconds >> 1000 ms = 1s
local TackleKey = 45 
local TackleTime = 3000 -- In milliseconds
local used = false
local prawelisjumper = false

Citizen.CreateThread(function()
    while true do
      N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MUSKET"), 0.25)
      N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PUMPSHOTGUN"), 3.5)
	  N_0x4757f00bc6323cfe(GetHashKey("WEAPON_DBSHOTGUN"), 1.9)
	  N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SAWNOFFSHOTGUN"), 2.6)
      N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BAT"), 0.15)
      N_0x4757f00bc6323cfe(GetHashKey("WEAPON_CROWBAR"), 0.15)
      N_0x4757f00bc6323cfe(GetHashKey("WEAPON_FLASHLIGHT"), 0.15)
      N_0x4757f00bc6323cfe(GetHashKey("WEAPON_GOLFCLUB"), 0.15)
      N_0x4757f00bc6323cfe(GetHashKey("WEAPON_KNUCKLE"), 0.15)
      N_0x4757f00bc6323cfe(GetHashKey("WEAPON_HAMMER"), 0.15)
      N_0x4757f00bc6323cfe(GetHashKey("WEAPON_WRENCH"), 0.15)
      N_0x4757f00bc6323cfe(GetHashKey("WEAPON_POOLCUE"), 0.15)
      N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"), 0.15)
      N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.1)
      N_0x4757f00bc6323cfe(GetHashKey("WEAPON_HIT_BY_WATER_CANNON"), 0.0)
	  N_0x4757f00bc6323cfe(GetHashKey("WEAPON_KNIFE"), 0.85)   
      Wait(0)
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedBeingStunned(GetPlayerPed(-1)) then
		    SetPedMinGroundTimeForStungun(GetPlayerPed(-1), stuntime)
			TriggerEvent('esx_ambulancejob:damagedwalkmode')
		end

		if IsControlJustReleased(0, TackleKey) then
			if IsPedJumping(PlayerPedId()) then
				if IsPedInAnyVehicle(PlayerPedId()) then
					TriggerEvent("pNotify:SendNotification", {text = "Nie możesz wykonać tej akcji będąc w pojezdzie bedąc w pojezdzie.", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"}) 
				else
					local ForwardVector = GetEntityForwardVector(PlayerPedId())
					local Tackled = {}
					
					SetPedToRagdollWithFall(PlayerPedId(), 1500, 2000, 0, ForwardVector, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)

					while IsPedRagdoll(PlayerPedId()) do
						Citizen.Wait(0)
						for Key, Value in ipairs(GetTouchedPlayers()) do
							if not Tackled[Value] then
								used = true
								Tackled[Value] = true
								TriggerServerEvent('Tackle:Server:TacklePlayer', GetPlayerServerId(Value), ForwardVector.x, ForwardVector.y, ForwardVector.z, GetPlayerName(PlayerId()))
							end
						end
					end
					if used then 
						Wait(30000)
						used = false
					end
				end
			end
		end

		if IsPedDoingDriveby(PlayerPedId()) and not CheckWeapon(PlayerPedId()) then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1) == GetPlayerPed(-1) and not IsVehicleStopped(GetVehiclePedIsIn(GetPlayerPed(-1), false))then
				local action = math.random(7,11)
				Wait(100)
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05) 
				TaskVehicleTempAction(PlayerPedId(), GetVehiclePedIsIn(GetPlayerPed(-1), false), action, 750)
			end
		end
		if IsPedInAnyVehicle(PlayerPedId(), true) then
			if IsPedShooting(PlayerPedId()) and not CheckWeapon(PlayerPedId()) then
				if GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) > 23 then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.135) 
					p = GetGameplayCamRelativePitch()
					if GetFollowPedCamViewMode() ~= 4 then
						SetGameplayCamRelativePitch(p-0.1, 0.2)
					elseif GetFollowPedCamViewMode() == 4 then
						SetGameplayCamRelativePitch(p-0.25, 0.2)
					end
				else
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.35) 
					p = GetGameplayCamRelativePitch()
					if GetFollowPedCamViewMode() ~= 4 then
						SetGameplayCamRelativePitch(p-0.1, 0.2)
					elseif GetFollowPedCamViewMode() == 4 then
						SetGameplayCamRelativePitch(p-0.25, 0.2)
					end
				end
			elseif not prawelisjumper and IsEntityInAir(GetVehiclePedIsIn(GetPlayerPed(-1), false)) and GetEntityHeightAboveGround(GetVehiclePedIsUsing(PlayerPedId())) > 9.0 and GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1), false)) == 8 then
				paweljumper(GetVehiclePedIsIn(GetPlayerPed(-1), false)) -- xd kurwa
			end
		end
		--[[if IsPedShooting(PlayerPedId()) and IsPedInAnyVehicle(PlayerPedId(), true) then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1) == GetPlayerPed(-1) and not IsVehicleStopped(GetVehiclePedIsIn(GetPlayerPed(-1), false))then
				local action = math.random(7,11)
				Wait(100)
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05) 
				TaskVehicleTempAction(PlayerPedId(), GetVehiclePedIsIn(GetPlayerPed(-1), false), action, 750)
			else
				if GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) > 23 then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.075) 
				else
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05) 
				end
			end
		elseif not prawelisjumper and IsEntityInAir(GetVehiclePedIsIn(GetPlayerPed(-1), false)) and GetEntityHeightAboveGround(GetVehiclePedIsUsing(PlayerPedId())) > 9.0 and GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1), false)) == 8 then
			paweljumper(GetVehiclePedIsIn(GetPlayerPed(-1), false)) -- xd kurwa
		end]]
	end
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(500)
		local p1coords = GetEntityCoords(PlayerPedId())
		for i=1, #Config.Coords do
	        local xCoords = Config.Coords[i]
			if GetDistanceBetweenCoords(xCoords.Pos.x, xCoords.Pos.y, xCoords.Pos.z, p1coords, true) < 4.5 and not IsPedRagdoll(PlayerPedId()) then
				if IsPedInAnyVehicle(PlayerPedId(), true) then
					if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1) == GetPlayerPed(-1) then	
						if GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1), false)) == 18 then
							Wait(500)
						else
							if GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1), false)) == 8 then
								ShakeGameplayCam('VIBRATE_SHAKE', 1.0)
                                --SetPedToRagdoll(PlayerPedId(), 15000, 15000, 0, 0, 0, 0)
								if IsVehicleTyreBurst(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1, 0) == false then 
									SetVehicleTyreBurst(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1, 0, 200.0)
									SetVehicleTyreBurst(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0, 0, 200.0)
									TriggerServerEvent('3dme:shareDisplayDo', xCoords.Text)
								end
								Wait(1000)
								local ForwardVector = GetEntityForwardVector(PlayerPedId())
								SetPedToRagdollWithFall(PlayerPedId(), 3000, 3000, 0, ForwardVector, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
							else
								if IsVehicleTyreBurst(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1, 0) == false then 
									SetVehicleTyreBurst(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1, 0, 200.0)
									SetVehicleTyreBurst(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0, 0, 200.0)
									TriggerServerEvent('3dme:shareDisplayDo', xCoords.Text)
								end
							end
						end
					end
				end
			elseif GetDistanceBetweenCoords(329.64, -585.20, 43.29, p1coords, true) < 30 or GetDistanceBetweenCoords(260.69, -1352.79, 24.54, p1coords, true) < 30  then
				if IsPedArmed(PlayerPedId(), 7) and not CheckWeapon(PlayerPedId()) and not IsPedRagdoll(PlayerPedId()) then
					SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), equipNow)
					local ForwardVector = GetEntityForwardVector(PlayerPedId())
					SetPedToRagdollWithFall(PlayerPedId(), 3000, 3000, 0, ForwardVector, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		if IsPedSwimming(PlayerPedId()) then
			dupcia()
		end
	end
end)

function dupcia()
	TriggerServerEvent("atlantis:removeitem")
end 

function CheckWeapon(ped)
	for i = 1, #weapons do

		if GetHashKey(weapons[i]) == GetSelectedPedWeapon(ped) then
			return true
		end
	end
	return false
end

RegisterNetEvent('Tackle:Client:TacklePlayer')
AddEventHandler('Tackle:Client:TacklePlayer', function(ForwardVectorX, ForwardVectorY, ForwardVectorZ, Tackler)
	if not IsPedRagdoll(PlayerPedId()) then
		SetPedToRagdollWithFall(PlayerPedId(), TackleTime, TackleTime, 0, ForwardVectorX, ForwardVectorY, ForwardVectorZ, 10.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
	end
end)

function paweljumper(vehicle)
	prawelisjumper = true
	_vehicle = vehicle
	repeat
	pawelInTheAir = IsEntityInAir(_vehicle)
	Citizen.Wait(0)
	until(pawelInTheAir == false)
	local ForwardVector = GetEntityForwardVector(PlayerPedId())
	Wait(500)
	SetPedToRagdollWithFall(PlayerPedId(), 3000, 3000, 0, ForwardVector, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
	prawelisjumper = false
end

function GetPlayers()
    local Players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(Players, i)
        end
    end

    return Players
end

function GetTouchedPlayers()
    local TouchedPlayer = {}
    for Key, Value in ipairs(GetPlayers()) do
		if IsEntityTouchingEntity(PlayerPedId(), GetPlayerPed(Value)) then
			table.insert(TouchedPlayer, Value)
		end
    end
    return TouchedPlayer
end
