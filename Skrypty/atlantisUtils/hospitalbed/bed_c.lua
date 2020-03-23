bedNames = { 'v_med_bed1', 'v_med_bed2', 'v_med_emptybed', 'v_med_cor_emblmtable'} -- Add more model strings here if you'd like
bedHashes = {}
animDict = 'mini@cpr@char_b@cpr_def'
animName = 'cpr_pumpchest_idle'
isOnBed = false

ESX = nil

local HealingProcent = false
local disablecontrols = false
local badcondition = false
local currentTattoos = {}
local newTattoos = {}


CreateThread(function()
    for k,v in ipairs(bedNames) do
        table.insert( bedHashes, GetHashKey(v))
    end
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('hospital:mario')
AddEventHandler('hospital:mario', function()
    HospitalMenu()
end)

RegisterNetEvent('hospital:accept')
AddEventHandler('hospital:accept', function()
    if IsEntityDead(PlayerPedId()) then
        badcondition = true
        TriggerServerEvent('hospital:heal', 1000)
    else
        payAnim()
        Wait(2800)
        TriggerEvent('revived')
        Wait(1000)
        TriggerServerEvent('hospital:heal', 500)
        badcondition = false
    end
end)

RegisterNetEvent('hospital:decline')
AddEventHandler('hospital:decline', function()
    TriggerEvent("pNotify:SendNotification", {text = "Dostępna jest odpowiednia ilość służb medycznych ktore mogą ci pomóc.", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
end)

RegisterCommand("bed", function(source, args, raw)
							bed()
end, false)

--RegisterCommand("xdtest", function(source, args, raw)
--        TriggerEvent('esx_addonaccount:sendmoney', 'mechanic', 100)
--end, false)


RegisterNetEvent('hospital:startheal')
AddEventHandler('hospital:startheal', function(price)

            TriggerEvent("pNotify:SendNotification", {text = "Zapłaciłeś <b style='color:red;'>"..price.."$</b> za usługę.", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
			SetEntityCoords(PlayerPedId(), 328.3493, -576.2059, 42.20)
            DoScreenFadeOut(0)
            cameralock()
			bedpatientstart()
            TriggerEvent('hospital:controllock')
            spawnDoc()
            TriggerEvent("pNotify:SendNotification", {text = "Dr. <b style='color:lightblue;'>Mario Sanitario</b> sprawdza co Ci dolega.", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
            TriggerEvent('3d:procentbar', 180, 'Badanie w toku...')
			Wait(20000)
			bedpatientstop()
			TriggerServerEvent('hospital:end')
            Wait(1000)
            TriggerEvent('esx_ambulancejob:revive')
            Wait(500)
            if not badcondition then
                TriggerEvent("pNotify:SendNotification", {text = "Tym razem to nic poważnego, ale uważaj na siebie.", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
            else
                TriggerEvent("pNotify:SendNotification", {text = "Obrażenia były poważne, otrzymałeś mocne środki znieczulające.", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
            end
end)

RegisterNetEvent('hospital:busy')
AddEventHandler('hospital:busy', function()
    TriggerEvent("pNotify:SendNotification", {text = "Doktor <b style='color:lightblue;'>Mario Sanitario</b> jest <b style='color:red;'>zajęty</b> poczekaj w kolejce.", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
end)

RegisterNetEvent('hospital:controllock')
AddEventHandler('hospital:controllock', function()
    disablecontrols = true
    while disablecontrols do
    Citizen.Wait(0)
     DisableAllControlActions(0)
     EnableControlAction(0, 166, true)
     EnableControlAction(0, 249, true)
    end
end)

function bed()
	local playerPed = PlayerPedId()
        if isOnBed then
            ClearPedTasksImmediately(playerPed)
            isOnBed = false
            return
        end

        local playerPos = GetEntityCoords(playerPed, true)

        local bed = nil

        for k,v in ipairs(bedHashes) do
            bed = GetClosestObjectOfType(playerPos.x, playerPos.y, playerPos.z, 4.0, v, false, false, false)
            if bed ~= 0 then
                break
            end
        end

        if bed ~= nil and DoesEntityExist(bed) then
            loadAnimDict(animDict)
            local bedCoords = GetEntityCoords(bed)
            local bedtype = GetEntityModel(bed)
            if bedtype == GetHashKey('v_med_cor_emblmtable') then
                SetEntityCoords(playerPed, bedCoords.x , bedCoords.y, bedCoords.z+0.5, 1, 1, 0, 0)
                SetEntityHeading(playerPed, GetEntityHeading(bed) + 180.0)
                TaskPlayAnim(playerPed,animDict, animName, 8.0, 1.0, -1, 45, 1.0, 0, 0, 0)
                isOnBed = true
            else
                SetEntityCoords(playerPed, bedCoords.x , bedCoords.y, bedCoords.z, 1, 1, 0, 0)
                SetEntityHeading(playerPed, GetEntityHeading(bed) + 180.0)
                TaskPlayAnim(playerPed,animDict, animName, 8.0, 1.0, -1, 45, 1.0, 0, 0, 0)
                isOnBed = true
            end
        end
end

function payAnim()
    if not IsEntityPlayingAnim(PlayerPedId(), "missarmenian2", "drunk_loop", 3) then
        loadAnimDict('random@atmrobberygen')
        TaskPlayAnim(PlayerPedId(),'random@atmrobberygen', 'a_atm_mugging', 8.0, 1.0, -1, 15, 1.0, 0, 0, 0)
    end
end

function bedpatientstart()
		local playerPed = PlayerPedId()
        local playerPos = GetEntityCoords(playerPed, true)
        local bed = nil

        for k,v in ipairs(bedHashes) do
            bed = GetClosestObjectOfType(playerPos.x, playerPos.y, playerPos.z, 4.0, v, false, false, false)
            if bed ~= 0 then
                break
            end
        end

        if bed ~= nil and DoesEntityExist(bed) then
            loadAnimDict(animDict)
            local bedCoords = GetEntityCoords(bed)

            SetEntityCoords(playerPed, bedCoords.x , bedCoords.y, bedCoords.z, 1, 1, 0, 0)
            SetEntityHeading(playerPed, GetEntityHeading(bed) + 180.0)
            TaskPlayAnim(playerPed,animDict, animName, 8.0, 1.0, -1, 45, 1.0, 0, 0, 0)           

            isOnBed = true
            blackscreen()
        end
end

function cameralock()
    SetFollowPedCamViewMode(2)
    SetGameplayCamRelativePitch(-30.00, 1.000000)
    SetGameplayCamRelativeHeading(180.00)
end

function bedpatientstop()
		DoScreenFadeOut(100)
        SetEntityHealth(GetPlayerPed(-1), 200)
        ClearPedTasks(PlayerPedId())
        disablecontrols = false
        isOnBed = false
        DeleteEntity(doktor)
       	blackscreen()
        SetEntityCoords(PlayerPedId(), 328.3493, -576.2059, 42.20)
end

function spawnDoc()  
    loadModel("S_M_M_Doctor_01")
    doktor = CreatePed(4, "S_M_M_Doctor_01", 329.86, -576.76, 43.29, 68.50, true, true)
    TaskStartScenarioInPlace(doktor, 'WORLD_HUMAN_CLIPBOARD', 0, true)
end

function blackscreen()
	Wait(1200)
	DoScreenFadeIn(800)
end

-- visual 
function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

function loadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(5)
    end
end

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 0, -1)
end


function HospitalMenu()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'hospital',
    {
        title    = 'Usługi szpitala',
        align    = 'right',
        elements = {
            {label = "Skorzystaj z pomocy Doktora. <span style='color:red;'>Koszt: 500$", value = 'doctor'},
            {label = "Ubezpieczenie (Tydzień). <span style='color:red;'>Koszt: 2200$", value = '7days'},
            {label = "Ubezpieczenie (2 tygodnie). <span style='color:red;'>Koszt: 3000$", value = '14days'},
            --{label = 'Zabieg usunięcia tatuażu.', value = 'tattoo'},
        }
    }, function(data, menu)

            local action = data.current.value

            if action == 'doctor' then
                TriggerServerEvent('hospital:emscheck')
                menu.close()
            elseif action == '7days' then
                menu.close()
                sevendaysmenu()
            elseif action == '14days' then
                menu.close()
                twoweeksmenu()
            elseif action == 'tattoo' then
                menu.close()
                tattoomenu()
            end
    end, function(data, menu)
        menu.close()
    end)
end


function sevendaysmenu()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), '7daysmenu',
    {
        title    = 'Przedłużenie ubezpieczenia się nie sumuje, możesz przedłużyć o 7 dni od dnia dzisiejszego. Czy chcesz przedłuć ubezpieczenie o 7 dni?',
        align    = 'right',
        elements = {
            {label = 'Tak', value = 'yes'},
            {label = 'Nie', value = 'no'},
        }
    }, function(data, menu)

            local action = data.current.value
            if action == 'yes' then
                TriggerServerEvent('hospital:insurance7days')
                TriggerEvent('show:money', 1.5)
                menu.close()
                TriggerEvent("pNotify:SendNotification", {text = "Ubezpieczenie przedłużone o 7 dni.", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
            elseif action == 'no' then
                menu.close()
            end
    end, function(data, menu)
        menu.close()
    end)
end

function twoweeksmenu()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), '14daysmenu',
    {
        title    = 'Przedłużenie ubezpieczenia się nie sumuje, możesz przedłużyć o 14 dni od dnia dzisiejszego. Czy chcesz przedłuć ubezpieczenie o 14 dni?',
        align    = 'right',
        elements = {
            {label = 'Tak', value = 'yes'},
            {label = 'Nie', value = 'no'},
        }
    }, function(data, menu)

            local action = data.current.value

            if action == 'yes' then
                TriggerServerEvent('hospital:insurance14days')
                TriggerEvent('show:money', 1.5)
                TriggerEvent("pNotify:SendNotification", {text = "Ubezpieczenie przedłużone o 14 dni.", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
            elseif action == 'no' then
                menu.close()
            end
    end, function(data, menu)
        menu.close()
    end)
end

function tattoomenu()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'tattoomenu',
    {
        title    = 'Zabieg usuwanięcia tatuażu.',
        align    = 'right',
        elements = {
        {label = 'Głowa', value = 'glowa'},
        {label = 'Szyja', value = 'szyja'},
        {label = 'Tors', value = 'tors'},
        {label = 'Plecy', value = 'plecy'},
        {label = 'Lewa ręka', value = 'lewa_reka'},
        {label = 'Prawa ręka', value = 'prawa_reka'},
        {label = 'Lewa noga', value = 'lewa_noga'},
        {label = 'Prawa noga', value = 'prawa_noga'},
        }
    }, function(data, menu)

            local action = data.current.value
            if action == 'glowa' then

            elseif action == 'szyja' then

            elseif action == 'tors' then

            elseif action == 'plecy' then

            elseif action == 'lewa_reka' then

            elseif action == 'prawa_reka' then

            elseif action == 'lewa_noga' then

            elseif action == 'prawa_noga' then

            end
    end, function(data, menu)
        menu.close()
    end)
end


RegisterNetEvent('hospital:sendtofraction')
AddEventHandler('hospital:sendtofraction', function(price)
    TriggerServerEvent('esx_society:depositMoney', 'ambulance', price *2, 1)
end)
                         --before--
---------------------------------------------------------------------

--[[Citizen.CreateThread(function()
    for k,v in ipairs(bedNames) do
        table.insert( bedHashes, GetHashKey(v))
    end

    while true do
    Citizen.Wait(0)
        if IsControlJustReleased(0, 38) and GetDistanceBetweenCoords(309.9198, -595.3167, 43.29182, GetEntityCoords(PlayerPedId()), true) < 5 then 
            if IsEntityDead(PlayerPedId()) then
            TriggerEvent('esx_ambulancejob:revive')
            Wait(1000)
            TriggerServerEvent('hospital:heal')
            else
            TriggerServerEvent('hospital:heal')
            end
        end
    end
end)]]



                         --original--
---------------------------------------------------------------------


--[[RegisterCommand('bed', function()
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        if isOnBed then
            ClearPedTasksImmediately(playerPed)
            isOnBed = false
            return
        end

        local playerPos = GetEntityCoords(playerPed, true)

        local bed = nil

        for k,v in ipairs(bedHashes) do
            bed = GetClosestObjectOfType(playerPos.x, playerPos.y, playerPos.z, 4.0, v, false, false, false)
            if bed ~= 0 then
                break
            end
        end

        if bed ~= nil and DoesEntityExist(bed) then
            loadAnimDict(animDict)
            local bedCoords = GetEntityCoords(bed)

            SetEntityCoords(playerPed, bedCoords.x , bedCoords.y, bedCoords.z, 1, 1, 0, 0)
            SetEntityHeading(playerPed, GetEntityHeading(bed) + 180.0)
            TaskPlayAnim(playerPed,animDict, animName, 8.0, 1.0, -1, 45, 1.0, 0, 0, 0)

            isOnBed = true
        end
    end)
end, false)

RegisterCommand('end', function()
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed, true)
    local bedHash = GetHashKey('v_med_bed1')
    CreateObject(bedHash, playerPos.x, playerPos.y + 1.0, playerPos.z - 0.95, true, true, true)
end, false)]]

