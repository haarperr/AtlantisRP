-- ESX
ESX               = nil

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1)
    end

    while ESX.GetPlayerData() == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end) 

RegisterNetEvent('zdrapka:anim')
AddEventHandler('zdrapka:anim', function()
 	local ad = "amb@code_human_wander_texting@male@base"
	local anim = "base"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 8 ) ) then 
			TaskPlayAnim( player, ad, "exit", 8.0, 8.0, 0.2, 48, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			SetCurrentPedWeapon( player, GetHashKey("WEAPON_UNARMED"), equipNow)
			Citizen.Wait(50) 
			TaskPlayAnim( player, ad, anim, 8.0, 8.0, 0.2, 48, 0, 0, 0, 0 )
		end       
	end
end)

RegisterNetEvent('zdrapka:Sound')
AddEventHandler('zdrapka:Sound', function(sound1, sound2)
  PlaySoundFrontend(-1, sound1, sound2)
end)


function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

