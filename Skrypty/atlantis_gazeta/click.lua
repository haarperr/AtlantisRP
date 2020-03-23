local servername = "Atlantis RP"; 
local menuEnabled = false 
local newspaperBox = nil
local boxcoords = GetEntityCoords(newspaperBox)
local distance = GetDistanceBetweenCoords(boxcoords.x, boxcoords.y, boxcoords.z, playerPos, true)
local Newspaperprop = nil
local checking = false

Citizen.CreateThread(function()
	while true do
	    local playerPed = PlayerPedId()
		local playerPos = GetEntityCoords(playerPed, true)
    	newspaperBox = GetClosestObjectOfType(playerPos.x, playerPos.y, playerPos.z, 4.0, GetHashKey('prop_news_disp_02a'), false, false, false)
    	boxcoords = GetEntityCoords(newspaperBox)
    	distance = GetDistanceBetweenCoords(boxcoords.x, boxcoords.y, boxcoords.z, playerPos, true)
		Citizen.Wait(5000)
	end
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(0)
		if distance < 2 then
			DrawText3Ds(boxcoords.x, boxcoords.y, boxcoords.z+1.0, '~b~[E] ~s~aby wyciągnąc gazetę.')
			if IsControlJustReleased(0, 38) and cantakenewspaper() then
				TriggerServerEvent('gazeta:payforuse')
			end
		end
	end
end)

function cantakenewspaper()
	if not IsPedInAnyVehicle(PlayerPedId(), false) and not IsEntityDead(PlayerPedId()) then
		return true
	else 
		return false
	end
end

RegisterNetEvent('gazeta:havemoney')
AddEventHandler('gazeta:havemoney', function()
	newspaperTakeAnim()
end)

--[[RegisterCommand('gazeta', function()
    Citizen.CreateThread(function()
    	local playerPed = PlayerPedId()
		local playerPos = GetEntityCoords(playerPed, true)
		local newspaperBox = nil

        for k,v in ipairs(newspaperBoxHashes) do
            newspaperBox = GetClosestObjectOfType(playerPos.x, playerPos.y, playerPos.z, 4.0, v, false, false, false)
            if newspaperBox ~= 0 then
                break
            end
        end

        if newspaperBox ~= nil and DoesEntityExist(newspaperBox) then
			newspaperTakeAnim()
        end
	end)
end, false)]]

function newspaperTakeAnim()
	local ad = "amb@prop_human_bum_bin@idle_b"
	local anim = "idle_d"
	local player = PlayerPedId()

	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 8 ) ) then
			TaskPlayAnim( player, ad, "exit", 100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
			ClearPedSecondaryTask(player)
		else
			DeleteObject(Newspaperprop)
			SetCurrentPedWeapon( player, GetHashKey("WEAPON_UNARMED"), equipNow)
			Wait(50)
			TaskPlayAnim( player, ad, anim, 100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
			Wait(750)
			StopAnimTask( player, ad, anim, 1.0)
			newspaperReadAnim()
		end
	end
end

function newspaperReadAnim()
	local ad = "missmic3"
	local anim = "newspaper_idle_loop_dave"
	local player = PlayerPedId()

	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 8 ) ) then
			TaskPlayAnim( player, ad, "exit", 8.0, -8, -1, 01, 0, 0, 0, 0)
			ClearPedSecondaryTask(player)
		else
			DeleteObject(Newspaperprop)
			SetCurrentPedWeapon( player, GetHashKey("WEAPON_UNARMED"), equipNow)
			Wait(50)
			TaskPlayAnim( player, ad, anim, 8.0, -8, -1, 01, 0, 0, 0, 0)
			Newspaperprop = CreateObject(GetHashKey("prop_cs_newspaper"), 0, 0, 0, true, true, true)
			AttachEntityToEntity(Newspaperprop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 6286), 0.11, 0.248, -0.351, 14.0, 100.0, 15.0, true, true, false, true, 1, true)
			ToggleActionMenu()
		end
	end
end

RegisterNUICallback('exit', function() 
	killTutorialMenu() 
	ClearPedTasks(PlayerPedId())
    DeleteObject(Newspaperprop)
    DetachEntity(Newspaperprop, true, false) 
    Newspaperprop = nil
end)

function ToggleActionMenu()
	menuEnabled = not menuEnabled
	if ( menuEnabled ) then 
		SetNuiFocus( true, true ) 
		SendNUIMessage({
			showPlayerMenu = true 
		})
	else 
		SetNuiFocus( false )
		SendNUIMessage({
			showPlayerMenu = false
		})
		DeleteObject(Newspaperprop)
    	DetachEntity(Newspaperprop, true, false) 
    	Newspaperprop = nil
	end 
end 

function killTutorialMenu() 
SetNuiFocus( false )
		SendNUIMessage({
			showPlayerMenu = false
		})
		DeleteObject(Newspaperprop)
    	DetachEntity(Newspaperprop, true, false) 
    	Newspaperprop = nil
		menuEnabled = false
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
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