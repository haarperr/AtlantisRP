ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- zdrapka1
local wygrana1 = 2000  -- lottery ticket
local wygrana2 = 1250
local wygrana3 = 750
local wygrana4 = 500
-- zdrapka2
local wygrana5 = 17500  -- lottery ticket
local wygrana6 = 10000
local wygrana7 = 7500
local wygrana8 = 5000
local wygrana9 = 3000
local wygrana10 = 2500
-- zdrapka3
local wygrana11 = 150000  -- lottery ticket
local wygrana12 = 75000
local wygrana13 = 50000
local wygrana14 = 40000
local wygrana15 = 25000
local wygrana16 = 20000
local wygrana17 = 10000
local wygrana18 = 5000

-- locales --
--local wygrana = "Wygrales ~g~$"
--local przegrana = "Zdrapka jest ~r~pusta"
-------------
-------------


ESX.RegisterUsableItem('zdrapka', function(source)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local rndm = math.random(1,11)
				--TriggerServerEvent('3dme:shareDisplayMe', 'Sprawdza zdrapkę.')
				xPlayer.removeInventoryItem('zdrapka', 1)
				TriggerClientEvent('zdrapka:anim', src)
				TriggerClientEvent("pNotify:SendNotification", src, {text = "SPRAWDZASZ ZDRAPKE", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
				Citizen.Wait(1000)
				if rndm == 1 then              -- WIN 1
					xPlayer.addMoney(wygrana1)
					--TriggerClientEvent('zdrapka:anim', src)
					TriggerClientEvent('zdrapka:Sound', src, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
					--TriggerClientEvent('esx:showNotification', src, wygrana .. wygrana1)
					TriggerClientEvent("pNotify:SendNotification", src, {text = "WYGRANA! 2000$", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
					TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: zdrapka , wygral "..wygrana1)
				end

				if rndm == 2 then              -- WIN 2
					xPlayer.addMoney(wygrana2)
					--TriggerClientEvent('zdrapka:anim', src)
					TriggerClientEvent('zdrapka:Sound', src, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
					--TriggerClientEvent('esx:showNotification', src, wygrana .. wygrana2)
					TriggerClientEvent("pNotify:SendNotification", src, {text = "WYGRANA! 1250$", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
					TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: zdrapka , wygral "..wygrana2)
				end

				if rndm == 3 then              -- WIN 3
					xPlayer.addMoney(wygrana3)
					--TriggerClientEvent('zdrapka:anim', src)
					TriggerClientEvent('zdrapka:Sound', src, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
					--TriggerClientEvent('esx:showNotification', src, wygrana .. wygrana3)
					TriggerClientEvent("pNotify:SendNotification", src, {text = "WYGRANA! 750$", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
					TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: zdrapka , wygral "..wygrana3)
				end

				if rndm == 4 then              -- WIN 4
					xPlayer.addMoney(wygrana4)
					--TriggerClientEvent('zdrapka:anim', src)
					TriggerClientEvent('zdrapka:Sound', src, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
					--TriggerClientEvent('esx:showNotification', src, wygrana .. wygrana4)
					TriggerClientEvent("pNotify:SendNotification", src, {text = "WYGRANA! 500$", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
					TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: zdrapka , wygral "..wygrana4)
				end

				if rndm >= 5 then			   -- LOSE
					--TriggerClientEvent('zdrapka:anim', src)
					TriggerClientEvent('zdrapka:Sound', src, "NO", "HUD_FRONTEND_DEFAULT_SOUNDSET")
					--TriggerClientEvent('esx:showNotification', src, przegrana)
					TriggerClientEvent("pNotify:SendNotification", src, {text = "PUSTO! SPROBUJ PONOWNIE ", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
				end
end)

ESX.RegisterUsableItem('zdrapka2', function(source)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local rndm = math.random(12,36)
				--TriggerServerEvent('3dme:shareDisplayMe', 'Sprawdza zdrapkę.')
				xPlayer.removeInventoryItem('zdrapka2', 1)
				TriggerClientEvent('zdrapka:anim', src)
				TriggerClientEvent("pNotify:SendNotification", src, {text = "SPRAWDZASZ ZDRAPKE", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
				Citizen.Wait(1000)
				if rndm == 12 then              -- WIN 1
					xPlayer.addMoney(wygrana5)
					--TriggerClientEvent('zdrapka:anim', src)
					TriggerClientEvent('zdrapka:Sound', src, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
					--TriggerClientEvent('esx:showNotification', src, wygrana .. wygrana1)
					TriggerClientEvent("pNotify:SendNotification", src, {text = "WYGRANA! 15000$", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
					TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: zdrapka , wygral "..wygrana5)
				end

				if rndm == 13 then              -- WIN 2
					xPlayer.addMoney(wygrana6)
					--TriggerClientEvent('zdrapka:anim', src)
					TriggerClientEvent('zdrapka:Sound', src, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
					--TriggerClientEvent('esx:showNotification', src, wygrana .. wygrana2)
					TriggerClientEvent("pNotify:SendNotification", src, {text = "WYGRANA! 10000$", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
					TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: zdrapka , wygral "..wygrana6)
				end

				if rndm == 14 then              -- WIN 3
					xPlayer.addMoney(wygrana7)
					--TriggerClientEvent('zdrapka:anim', src)
					TriggerClientEvent('zdrapka:Sound', src, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
					--TriggerClientEvent('esx:showNotification', src, wygrana .. wygrana3)
					TriggerClientEvent("pNotify:SendNotification", src, {text = "WYGRANA! 7500$", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
					TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: zdrapka , wygral "..wygrana7)
				end

				if rndm == 15 then              -- WIN 4
					xPlayer.addMoney(wygrana8)
					--TriggerClientEvent('zdrapka:anim', src)
					TriggerClientEvent('zdrapka:Sound', src, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
					--TriggerClientEvent('esx:showNotification', src, wygrana .. wygrana4)
					TriggerClientEvent("pNotify:SendNotification", src, {text = "WYGRANA! 5000$", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
					TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: zdrapka , wygral "..wygrana8)
				end

				if rndm == 15 then              -- WIN 4
					xPlayer.addMoney(wygrana9)
					--TriggerClientEvent('zdrapka:anim', src)
					TriggerClientEvent('zdrapka:Sound', src, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
					--TriggerClientEvent('esx:showNotification', src, wygrana .. wygrana4)
					TriggerClientEvent("pNotify:SendNotification", src, {text = "WYGRANA! 3000$",type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
					TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: zdrapka , wygral "..wygrana9)
				end

				if rndm == 15 then              -- WIN 4
					xPlayer.addMoney(wygrana10)
					--TriggerClientEvent('zdrapka:anim', src)
					TriggerClientEvent('zdrapka:Sound', src, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
					--TriggerClientEvent('esx:showNotification', src, wygrana .. wygrana4)
					TriggerClientEvent("pNotify:SendNotification", src, {text = "WYGRANA! 2500$", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
					TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: zdrapka , wygral "..wygrana10)
				end

				if rndm >= 16 then			   -- LOSE
					--TriggerClientEvent('zdrapka:anim', src)
					TriggerClientEvent('zdrapka:Sound', src, "NO", "HUD_FRONTEND_DEFAULT_SOUNDSET")
					--TriggerClientEvent('esx:showNotification', src, przegrana)
					TriggerClientEvent("pNotify:SendNotification", src, {text = "PUSTO! SPROBUJ PONOWNIE ", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
				end
end)

ESX.RegisterUsableItem('zdrapka3', function(source)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local rndm = math.random(37, 87)
				--TriggerServerEvent('3dme:shareDisplayMe', 'Sprawdza zdrapkę.')
				xPlayer.removeInventoryItem('zdrapka3', 1)
				TriggerClientEvent('zdrapka:anim', src)
				TriggerClientEvent("pNotify:SendNotification", src, {text = "SPRAWDZASZ ZDRAPKE", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
				Citizen.Wait(1000)
				if rndm == 37 then              -- WIN 1
					xPlayer.addMoney(wygrana11)
					--TriggerClientEvent('zdrapka:anim', src)
					TriggerClientEvent('zdrapka:Sound', src, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
					--TriggerClientEvent('esx:showNotification', src, wygrana .. wygrana1)
					TriggerClientEvent("pNotify:SendNotification", src, {text = "WYGRANA! 150000$", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
					TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: zdrapka , wygral "..wygrana11)
				end

				if rndm == 38 then              -- WIN 2
					xPlayer.addMoney(wygrana12)
					--TriggerClientEvent('zdrapka:anim', src)
					TriggerClientEvent('zdrapka:Sound', src, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
					--TriggerClientEvent('esx:showNotification', src, wygrana .. wygrana2)
					TriggerClientEvent("pNotify:SendNotification", src, {text = "WYGRANA! 75000$", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
					TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: zdrapka , wygral "..wygrana12)
				end

				if rndm == 39 then              -- WIN 3
					xPlayer.addMoney(wygrana13)
					--TriggerClientEvent('zdrapka:anim', src)
					TriggerClientEvent('zdrapka:Sound', src, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
					--TriggerClientEvent('esx:showNotification', src, wygrana .. wygrana3)
					TriggerClientEvent("pNotify:SendNotification", src, {text = "WYGRANA! 50000$", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
					TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: zdrapka , wygral "..wygrana12)
				end

				if rndm == 40 then              -- WIN 4
					xPlayer.addMoney(wygrana14)
					--TriggerClientEvent('zdrapka:anim', src)
					TriggerClientEvent('zdrapka:Sound', src, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
					--TriggerClientEvent('esx:showNotification', src, wygrana .. wygrana4)
					TriggerClientEvent("pNotify:SendNotification", src, {text = "WYGRANA! 40000$", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
					TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: zdrapka , wygral "..wygrana14)
				end

				if rndm == 41 then              -- WIN 4
					xPlayer.addMoney(wygrana15)
					--TriggerClientEvent('zdrapka:anim', src)
					TriggerClientEvent('zdrapka:Sound', src, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
					--TriggerClientEvent('esx:showNotification', src, wygrana .. wygrana4)
					TriggerClientEvent("pNotify:SendNotification", src, {text = "WYGRANA! 25000$", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
					TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: zdrapka , wygral "..wygrana15)
				end

				if rndm == 42 then              -- WIN 4
					xPlayer.addMoney(wygrana16)
					--TriggerClientEvent('zdrapka:anim', src)
					TriggerClientEvent('zdrapka:Sound', src, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
					--TriggerClientEvent('esx:showNotification', src, wygrana .. wygrana4)
					TriggerClientEvent("pNotify:SendNotification", src, {text = "WYGRANA! 20000$", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
					TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: zdrapka , wygral "..wygrana16)
				end

				if rndm == 43 then              -- WIN 4
					xPlayer.addMoney(wygrana17)
					--TriggerClientEvent('zdrapka:anim', src)
					TriggerClientEvent('zdrapka:Sound', src, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
					--TriggerClientEvent('esx:showNotification', src, wygrana .. wygrana4)
					TriggerClientEvent("pNotify:SendNotification", src, {text = "WYGRANA! 10000$", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
					TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: zdrapka , wygral "..wygrana17)
				end

				if rndm == 44 then              -- WIN 4
					xPlayer.addMoney(wygrana18)
					--TriggerClientEvent('zdrapka:anim', src)
					TriggerClientEvent('zdrapka:Sound', src, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
					--TriggerClientEvent('esx:showNotification', src, wygrana .. wygrana4)
					TriggerClientEvent("pNotify:SendNotification", src, {text = "WYGRANA! 5000$", type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
					TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: zdrapka , wygral "..wygrana18)
				end

				if rndm >= 45 then			   -- LOSE
					--TriggerClientEvent('zdrapka:anim', src)
					TriggerClientEvent('zdrapka:Sound', src, "NO", "HUD_FRONTEND_DEFAULT_SOUNDSET")
					--TriggerClientEvent('esx:showNotification', src, przegrana)
					TriggerClientEvent("pNotify:SendNotification", src, {text = "PUSTO! SPROBUJ PONOWNIE ",type = "atlantis", queue = "global", timeout = 2000, layout = "atlantis"})
				end
end)
