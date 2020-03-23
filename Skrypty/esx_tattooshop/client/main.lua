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

ESX								= nil
local currentTattoos			= {}
local cam						= -1
local HasAlreadyEnteredMarker	= false
local CurrentAction				= nil
local CurrentActionMsg			= ''
local CurrentActionData			= {}
local LastSkin = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
AddEventHandler('playerSpawned', function(spawn)
	Citizen.Wait(5000)
	--print('laduje tattoo')
	--TriggerEvent('skinchanger:modelLoaded')
	ESX.TriggerServerCallback('esx_tattooshop:requestPlayerTattoos', function(tattooList)
		
		if tattooList then
			for _,k in pairs(tattooList) do
				ApplyPedOverlay(PlayerPedId(), GetHashKey(k.collection), GetHashKey(Config.TattooList[k.typ][k.texture].nameHash))
			end

			currentTattoos = tattooList
		end
	end)
	


	--ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
	--			if skin ~= nil then
					--TriggerEvent('skinchanger:loadSkin', {sex = 0}, OpenSaveableMenu)
				--else
					
	--			end
	--		end)

end)

AddEventHandler('skinchanger:modelLoaded', function()
	ESX.TriggerServerCallback('esx_tattooshop:requestPlayerTattoos', function(tattooList)
		
		if tattooList then
			for _,k in pairs(tattooList) do
				ApplyPedOverlay(PlayerPedId(), GetHashKey(k.collection), GetHashKey(Config.TattooList[k.typ][k.texture].nameHash))
			end

			currentTattoos = tattooList
		end
	end)
end)

function OpenShopMenu()

	local elements = {}

	for _,k in pairs(Config.TattooCategories) do
		table.insert(elements, {label= k.name, value = k.value})
	end

	if DoesCamExist(cam) then
		RenderScriptCams(false, false, 0, 1, 0)
		DestroyCam(cam, false)
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'tattoo_shop', {
		title    = _U('tattoos'),
		align    = 'right',
		elements = elements
	}, function(data, menu)
		local currentLabel, currentValue = data.current.label, data.current.value

		if data.current.value ~= nil then
			elements = { }
			FreezeEntityPosition(GetPlayerPed(-1), true)
			for i,k in pairs(Config.TattooList[data.current.value]) do
				table.insert(elements, {
					label = _U('tattoo_item', i, _U('money_amount', ESX.Math.GroupDigits(k.price))),
					value = i,
					cat = k.cat,
					price = k.price
				})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'tattoo_shop_categories', {
				title    = _U('tattoos') .. ' | '..currentLabel,
				align    = 'right',
				elements = elements
			}, function(data2, menu2)
				local price = data2.current.price
				local cat = data2.current.cat
				local typ = data.current.value
				
				if data2.current.value ~= nil then

					ESX.TriggerServerCallback('esx_tattooshop:purchaseTattoo', function(success)
						if success then
							table.insert(currentTattoos, {typ = data.current.value, collection = cat, texture = data2.current.value})
						end
					end, currentTattoos, price, {typ = data.current.value, collection = cat, texture = data2.current.value})

				else
					FreezeEntityPosition(GetPlayerPed(-1), true)
					OpenShopMenu()
					RenderScriptCams(false, false, 0, 1, 0)
					DestroyCam(cam, false)
					cleanPlayer()
				end

			end, function(data2, menu2)
				FreezeEntityPosition(GetPlayerPed(-1), false)
				menu2.close()
				RenderScriptCams(false, false, 0, 1, 0)
				DestroyCam(cam, false)
				setPedSkin()
			end, function(data2, menu2) -- when highlighted
				if data2.current.value ~= nil then
					drawTattoo(data2.current.value, data2.current.cat, data.current.value)
				end
			end)
		end
	end, function(data, menu)
		FreezeEntityPosition(GetPlayerPed(-1), false)
		menu.close()
		setPedSkin()
	end)
end

Citizen.CreateThread(function()
	for k,v in pairs(Config.Zones) do
		local blip = AddBlipForCoord(v)
		SetBlipSprite(blip, 75)
		SetBlipColour(blip, 0)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(_U('tattoo_shop'))
		EndTextCommandSetBlipName(blip)
	end
end)

RegisterNetEvent('tattoo:menu')
AddEventHandler('tattoo:menu', function()
	OpenShopMenu()
end)


-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords, canSleep = GetEntityCoords(PlayerPedId()), true

		for k,v in pairs(Config.Zones) do

			if (Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v, true) < Config.DrawDistance) then
				DrawMarker(Config.Type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
				canSleep = false
			end

		end

		if canSleep then
			Citizen.Wait(500)
		end
	end
  end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)

		local coords = GetEntityCoords(PlayerPedId())
		local isInMarker = false
		local currentZone, LastZone

		for k,v in pairs(Config.Zones) do
			if GetDistanceBetweenCoords(coords, v, true) < Config.Size.x then
				isInMarker  = true
				currentZone = 'TattooShop'
				LastZone    = 'TattooShop'
			end
		end

		if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('esx_tattooshop:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_tattooshop:hasExitedMarker', LastZone)
		end
	end
end)

AddEventHandler('esx_tattooshop:hasEnteredMarker', function(zone)
	if zone == 'TattooShop' then
		CurrentAction     = 'tattoo_shop'
		CurrentActionMsg  = _U('tattoo_shop_prompt')
		CurrentActionData = {zone = zone}
	end
end)

AddEventHandler('esx_tattooshop:hasExitedMarker', function(zone)
	ClearPedDecorations(PlayerPedId())
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
			TriggerEvent('skinchanger:loadSkin', skin) 
		end)
	ESX.TriggerServerCallback('esx_tattooshop:requestPlayerTattoos', function(tattooList)
		if tattooList then
			for _,k in pairs(tattooList) do
				--print(Config.TattooList[k.typ][k.texture].cat)
				ApplyPedOverlay(PlayerPedId(), GetHashKey(k.collection), GetHashKey(Config.TattooList[k.typ][k.texture].nameHash))
			end

			currentTattoos = tattooList
		end
	end)

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) then
				if CurrentAction == 'tattoo_shop' then
					OpenShopMenu()
				end
				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function setPedSkin()
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)

	Citizen.Wait(1000)

	for _,k in pairs(currentTattoos) do
		--print("aaaaaaaaaaaaaaaaaaaaaaa")
		--print(Config.TattooList[k.typ][k.texture].cat)
		ApplyPedOverlay(PlayerPedId(), GetHashKey(k.collection), GetHashKey(Config.TattooList[k.typ][k.texture].nameHash))
	end
end

function drawTattoo(current, collection, typ)
	SetEntityHeading(PlayerPedId(), 297.7296)
	ClearPedDecorations(PlayerPedId())

	for _,k in pairs(currentTattoos) do
		--print(Config.TattooList[k.typ][k.texture].cat)
		ApplyPedOverlay(PlayerPedId(), GetHashKey(k.collection), GetHashKey(Config.TattooList[k.typ][k.texture].nameHash))
	end

	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			TriggerEvent('skinchanger:loadSkin', {
				sex      = 0,
				tshirt_1 = 15,
				tshirt_2 = 0,
				arms     = 15,
				torso_1  = 91,
				torso_2  = 0,
				pants_1  = 61,
				pants_2  = 1
			})
		else
			TriggerEvent('skinchanger:loadSkin', {
				sex      = 1,
				tshirt_1 = 14,
				tshirt_2 = 0,
				arms     = 15,
				torso_1  = 15,
				torso_2  = 0,
				pants_1  = 15,
				pants_2  = 0
			})
		end
	end)
	--print(collection)
	--print(GetHashKey(collection))
	--print(Config.TattooList[typ][current].nameHash)
	ApplyPedOverlay(PlayerPedId(), GetHashKey(collection), GetHashKey(Config.TattooList[typ][current].nameHash))

	if not DoesCamExist(cam) then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
		
		SetCamCoord(cam, GetEntityCoords(PlayerPedId()))
		SetCamRot(cam, 0.0, 0.0, 0.0)
		SetCamActive(cam, true)
		RenderScriptCams(true, false, 0, true, true)
		SetCamCoord(cam, GetEntityCoords(PlayerPedId()))
	end
	
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))

	SetCamCoord(cam, x + Config.TattooList[typ][current].addedX, y + Config.TattooList[typ][current].addedY, z + Config.TattooList[typ][current].addedZ)
	SetCamRot(cam, 0.0, 0.0, Config.TattooList[typ][current].rotZ)
end

function cleanPlayer()
	ClearPedDecorations(PlayerPedId())

	for _,k in pairs(currentTattoos) do
		ApplyPedOverlay(PlayerPedId(), GetHashKey(k.collection), GetHashKey(Config.TattooList[k.typ][k.texture].nameHash))
	end
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
			TriggerEvent('skinchanger:loadSkin', skin) 
		end)
end

RegisterNetEvent('esx_tattooshop:refreshTattoos')
AddEventHandler('esx_tattooshop:refreshTattoos', function()
	ESX.TriggerServerCallback('esx_tattooshop:requestPlayerTattoos', function(tattooList)
		
		if tattooList then
			for _,k in pairs(tattooList) do
				ApplyPedOverlay(PlayerPedId(), GetHashKey(k.collection), GetHashKey(Config.TattooList[k.typ][k.texture].nameHash))
			end

			currentTattoos = tattooList
		end
	end)
end)