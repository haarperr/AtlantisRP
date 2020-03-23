local foundit = false
local gotBuyer = false
local time = math.random(2000,10000)
local rped = nil
local weed_bag = nil
local cashprop = nil
local check = false
local searchtrynumber = 0
local commandused = false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
		if IsEntityPlayingAnim(PlayerPedId(), "mp_common", "givetake1_a", 3) then
    --[[DisableControlAction(2, 199, true) -- Disable pause screen
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
	DisableControlAction(0, 82, true) -- .]]
	DisableAllControlActions()
		end
    end
end)

RegisterCommand("dealer", function(source, args, raw)
	if not IsEntityDead(PlayerPedId()) then
		if commandused then
			TriggerEvent("pNotify:SendNotification", {text = "Poczekaj aż znajdzie klienta", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
		else
			TriggerServerEvent('drugdealer:policeCheck')
		end
	end
end, false)

RegisterNetEvent('drug:dealer_gostart')
AddEventHandler('drug:dealer_gostart', function()
commandused = true
	if IsPedInAnyVehicle(PlayerPedId(), false) then
    	TriggerEvent("pNotify:SendNotification", {text = "Wysiądź z pojazdu", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
		commandused = false
    else
		if gotBuyer then
			TriggerEvent("pNotify:SendNotification", {text = "Musisz poczekać aby ponownie spróbować", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
			commandused = false
		else
			ESX.TriggerServerCallback('drugdealer:chcekinventory', function(data)
				if data > 0 then
					searchinganim()
					findped()
				else
					TriggerEvent("pNotify:SendNotification", {text = "Nie masz nic ciekawego na sprzedaż", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
					commandused = false
					Citizen.Wait(250)
				end
			end, GetPlayerServerId(source))
		end
	end
end)

function findped()
	if searchtrynumber > 3 then
		ClearPedTasks(PlayerPedId())
		TriggerEvent("pNotify:SendNotification", {text = "Nie ma chętnych w pobliżu możesz spróbować jeszcze raz albo zmienić miejsce", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
		searchtrynumber = 0
		commandused = false
	else
		Wait(time)
		local pos = GetEntityCoords(PlayerPedId())
		--rped = GetRandomWalkingNPC()
		rped = getAnyClosestPed()
			if not IsPedInAnyVehicle(PlayerPedId(), false) and canPedBeUsed(rped) and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),GetEntityCoords(rped), true) < 60 then
				TriggerEvent("pNotify:SendNotification", {text = "Jest jakiś chętny, pogadaj z nim", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
				SetEntityAsMissionEntity(rped, true, false)
				gotBuyer = true
				TriggerEvent('drug:dealer_found')
				TaskGoToEntity(rped, PlayerPedId(), -1, 5.0, 1.0, 1073741824.0, 0)
				local coords = GetEntityCoords(rped)

			elseif IsPedInAnyVehicle(PlayerPedId(), false) then
				ClearPedTasks(PlayerPedId())
				TriggerEvent("pNotify:SendNotification", {text = "Wysiądź z pojazdu", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
				searchtrynumber = 0
				commandused = false		
			else
				searchtrynumber = searchtrynumber + 1
				Wait(5000)
				findped()
				
		end
	end
end

function CheckIfPlayerIsJebanyDebil()
	CheckIfDebil = true
	repeat

	Citizen.Wait(0)
	until(CheckIfDebil == false)
end

RegisterNetEvent('drug:dealer_found')
AddEventHandler('drug:dealer_found', function()
ClearPedTasks(PlayerPedId())
searchtrynumber = 0 
foundit = true
	while (foundit) do
	Citizen.Wait(0)
		if DoesEntityExist(rped) then
			local coords = GetEntityCoords(rped)
			DrawText3Ds(coords.x, coords.y, coords.z, 'Nacisnij ~g~E ~s~aby zaproponować zakup narkotyków')
			if IsControlJustReleased(0, 38) and not IsEntityDead(rped) then
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),GetEntityCoords(rped), true) < 2 and not IsPedInAnyVehicle(PlayerPedId()) then
					foundbuyer()
					alarmpolice()
				elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),GetEntityCoords(rped), true) < 2 and IsPedInAnyVehicle(PlayerPedId()) then
					SetPedToRagdoll(PlayerPedId(), 15000, 15000, 0, 0, 0, 0)
					alarmpolice2()
					forcestop2()
				end
			end
		else
			forcestop()
		end
	end
end)

function searchinganim()
	loadAnimDict('missfbi3_party_b')
    TaskPlayAnim(PlayerPedId(), 'missfbi3_party_b', 'talk_balcony_loop_male1', 8.0, 3.0, -1, 1, 1, false, false, false)
end

--[[function sellanim()
	weed_bag = CreateObject(GetHashKey('p_amb_joint_01'), 0, 0, 0, true)
	AttachEntityToEntity(weed_bag, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)
	loadAnimDict('mp_common')
	TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake2_b', 8.0, 8.0, -1, 0, 0, false, false, false)
	Wait(2000)
	DeleteEntity(weed_bag)
	weed_bag = nil 
end]]

function payanim()
	ClearPedTasks(rped)
	Wait(50)
	FreezeEntityPosition(PlayerPedId(), true)
	weed_bag = CreateObject(GetHashKey('prop_meth_bag_01'), 0, 0, 0, true)
	AttachEntityToEntity(weed_bag, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)
	loadAnimDict('mp_common')
	TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 0, false, false, false)
	cashprop = CreateObject(GetHashKey('prop_anim_cash_pile_01'), 0, 0, 0, true)
	AttachEntityToEntity(cashprop, rped, GetPedBoneIndex(PlayerPedId(),  60309), 0.0, 0.0, 0.0, 0.0, 0, 0, 1, 1, 0, 1, 0, 1)
	loadAnimDict('mp_common')
	TaskPlayAnim(rped, 'mp_common', 'givetake2_b', 8.0, 8.0, -1, 0, 0, false, false, false)
	Wait(2000)
	FreezeEntityPosition(PlayerPedId(), false)	
	DeleteEntity(cashprop)
    DeleteEntity(weed_bag)
    weed_bag = nil 
	cashprop = nil
end

function check()
	check = true
	while check do 
		Citizen.Wait(0)
		local distancepedtoplayer = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),GetEntityCoords(rped), true)
		if distancepedtoplayer < 2 then
			ClearPedTasks(rped)
			TaskStandStill(rped, 10000)
			check = false
		end
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),GetEntityCoords(rped), true) > 100 then
			forcestop()
			check = false
		end
	end
end

RegisterNetEvent('drug:dealer_sell')
AddEventHandler('drug:dealer_sell', function(statuspoints)
	--print(statuspoints)
	TriggerServerEvent('atlantisStatus:remove', statuspoints)
	foundit = false
	commandused = false
	--sellanim()
	payanim()
	Wait(3500)
	SetPedAsNoLongerNeeded(rped)
	Wait(20000)
	gotBuyer = false
	DeleteEntity(rped)
	rped = nil
end)

RegisterNetEvent('drug:dealer_reject')
AddEventHandler('drug:dealer_reject', function()
	PlayAmbientSpeech1(rped, "Generic_Fuck_You", "Speech_Params_Force")
	foundit = false
	commandused = false
	SetPedAsNoLongerNeeded(rped)
	Wait(20000)
	gotBuyer = false
	DeleteEntity(rped)
	rped = nil
end)

function attack()
	TriggerEvent("pNotify:SendNotification", {text = "Gardze takimi jak ty, nauczę cię uczciwie zarabiać.", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
    PlayAmbientSpeech1(rped, "Generic_Fuck_You", "Speech_Params_Force")
	ClearPedTasks(rped)
	TaskCombatPed(rped, PlayerPedId(), 0, 16)
	commandused = false
	Wait(20000)
	foundit = false
	gotBuyer = false
	DeleteEntity(rped)
	rped = nil
end

function foundbuyer()
	local chance = math.random(0, 20)
	foundit = false
	commandused = false
	if chance < 1 then
		attack()
	else
		local drugtype = math.random(1, 3)
		--print(drugtype)
		if drugtype == 1 then
			TriggerServerEvent('drugdealer:succes_weed')
		elseif drugtype == 2 then 
			TriggerServerEvent('drugdealer:succes_meth')
		elseif drugtype == 3 then
			TriggerServerEvent('drugdealer:succes_coke')
		end
	end
end

function forcestop()
	commandused = false
	foundit = false
	gotBuyer = false
	findped()
end

function forcestop2()
	commandused = false
	foundit = false
	gotBuyer = false
end

function canPedBeUsed(ped)
    if rped == nil then
        return false
    end
    if rped == GetPlayerPed(-1) then
        return false
    end
    if not DoesEntityExist(rped) then
        return false
    end
    if GetPedType(ped) == 28 then
    	return false
    end
    if IsPedInAnyVehicle(ped, false) then
    	return false
    end
    return true
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


function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

function GetRandomWalkingNPC()
	local search = {}
	local peds   = ESX.Game.GetPeds()

	for i=1, #peds, 1 do
		if IsPedHuman(peds[i]) and IsPedWalking(peds[i]) and not IsPedAPlayer(peds[i]) then
			table.insert(search, peds[i])
		end
	end

	if #search > 0 then
		return search[GetRandomIntInRange(1, #search)]
	end

	for i=1, 250, 1 do
		local ped = GetRandomPedAtCoord(0.0, 0.0, 0.0, math.huge + 0.0, math.huge + 0.0, math.huge + 0.0, 26)

		if DoesEntityExist(ped) and IsPedHuman(ped) and IsPedWalking(ped) and not IsPedAPlayer(ped) then
			table.insert(search, ped)
		end
	end

	if #search > 0 then
		return search[GetRandomIntInRange(1, #search)]
	end
end

function getAnyClosestPed()
  local pedToReturn = nil
  local player = GetPlayerPed(-1)
  local playerloc = GetEntityCoords(player, 0)
  local handle, ped = FindFirstPed()
  repeat
    success, ped = FindNextPed(handle)
    local pos = GetEntityCoords(ped)
    local distance = GetDistanceBetweenCoords(pos, playerloc, true)
    if DoesEntityExist(ped) and ped ~= GetPlayerPed(-1) and distance < 60 and not IsPedInAnyVehicle(ped) and GetPedType(ped) ~= 28 and not IsPedAPlayer(ped) then
            pedToReturn = ped
    end
  until not success
  EndFindPed(handle)

    return pedToReturn
end


function alarmpolice()
local rand = math.random(1,10)
--print (rand)
	if rand <= 3 then
		local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
	    local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
	    local street1 = GetStreetNameFromHashKey(s1)
	    local street2 = GetStreetNameFromHashKey(s2)
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
			local sex = nil
			if skin.sex == 0 then
				sex = "Mężczyzna"
				TriggerServerEvent('drugdealer:notification', 1, street1, street2, sex)
				TriggerServerEvent('drugdealer:blip', plyPos.x, plyPos.y, plyPos.z)
			else
				sex = "Kobieta"
				TriggerServerEvent('drugdealer:notification', 2, street1, street2, sex, plyPos.x, plyPos.y, plyPos.z)
				TriggerServerEvent('drugdealer:blip', plyPos.x, plyPos.y, plyPos.z)
			end
		end)
	end
end

function alarmpolice2()
		local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
	    local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
	    local street1 = GetStreetNameFromHashKey(s1)
	    local street2 = GetStreetNameFromHashKey(s2)
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
			local sex = nil
			if skin.sex == 0 then
				sex = "Mężczyzna"
				TriggerServerEvent('drugdealer:notification', 1, street1, street2, sex)
				TriggerServerEvent('drugdealer:blip', plyPos.x, plyPos.y, plyPos.z)
			else
				sex = "Kobieta"
				TriggerServerEvent('drugdealer:notification', 2, street1, street2, sex, plyPos.x, plyPos.y, plyPos.z)
				TriggerServerEvent('drugdealer:blip', plyPos.x, plyPos.y, plyPos.z)
			end
		end)
	end



--[[function ()
	local ad = "missmic3"
	local anim = "newspaper_idle_loop_dave"
	local player = PlayerPedId()

	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 8 ) ) then
			TaskPlayAnim( player, ad, "exit", 8.0, -8, -1, 01, 0, 0, 0, 0)
			ClearPedSecondaryTask(player)
		else
			SetCurrentPedWeapon( player, GetHashKey("WEAPON_UNARMED"), equipNow)
			Wait(50)
			TaskPlayAnim( player, ad, anim, 8.0, -8, -1, 01, 0, 0, 0, 0)
		end
	end
end]]

--[[RegisterNetEvent('drug:dealer_search')
AddEventHandler('drug:dealer_search', function()
local pedzik = getNPC()
local rand = math.random(1,6)
local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),GetEntityCoords(pedzik), true)
	if distance < 10 then
		if rand <= 3 then 
			print('znalazlem')
			TaskGoToEntity(pedzik, GetPlayerPed(-1), -1, 1.0, 10.0, 1073741824.0, 0)
			foundit = true 
			gotBuyer = true
		else
			print('szukam dalej')
			Wait(5000)
			TriggerEvent('drug:dealer_search')
		end
	else 
		Wait(5000)
		TriggerEvent('drug:dealer_search')
	end
	while (foundit) do
		Citizen.Wait(0)
		local ped = GetEntityModel(pedzik)
		local coords = GetEntityCoords(pedzik)
		DrawText3Ds(coords.x, coords.y, coords.z, 'Press ~g~E')
		if IsControlJustReleased(0, 38) then
			Wait(1000)
			if ped == oldpedzik then
				print('juz kupil')
				gotBuyer = false
				foundit = false
			else
				oldpedzik = GetEntityModel(pedzik)
				TaskStandStill(pedzik, 5000)
				foundbuyer()
				print('kupuje')
			end
		end
	end
end)



function getNPC()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if canPedBeUsed(ped) and distance < 20.0 and not IsEntityDead(ped) then
           		rped = ped
        end
        success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return rped
end]]
