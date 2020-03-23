ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('moneywash:pay')
AddEventHandler('moneywash:pay', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer ~= nil then
    	local money = ESX.Math.Round(xPlayer.getAccount('black_money').money)
    	local moneytowash = ESX.Math.Round(math.random(300, 1000))
    	if money <= 0 then 
 			TriggerClientEvent("pNotify:SendNotification", _source, {text = "Nie masz wystarczająco towaru który nas interesuje", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
 			Citizen.Wait(1000)
 			TriggerClientEvent('moneywash:end', _source)
    	elseif money > 500 then
 			xPlayer.removeAccountMoney('black_money', moneytowash) -- Removes Dirty Money
            xPlayer.addMoney(moneytowash) -- Add Clean Money
			TriggerEvent("esx:washingmoneyalert",xPlayer.name,moneytowash)
 			--TriggerClientEvent("pNotify:SendNotification", _source, {text = "Wyprano <span style='color:#2FCC34;'>" ..moneytowash.. " $", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
 		elseif money < 500 then
            xPlayer.removeAccountMoney('black_money', money) -- Removes Dirty Money
 			xPlayer.addMoney(money) -- Add Clean Money
			TriggerEvent("esx:washingmoneyalert",xPlayer.name,moneytowash)
 			--TriggerClientEvent("pNotify:SendNotification", _source, {text = "Wyprano <span style='color:#2FCC34;'>" ..money.. " $", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
 			Citizen.Wait(1000)
 			TriggerClientEvent('moneywash:end', _source)
 		end
    end
end)

ESX.RegisterServerCallback('moneywash:chcekinventory', function(source, cb, target)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
	local burnercount = xPlayer.getInventoryItem('burner').count

	if burnercount > 0 then
		cb(burnercount, _source)
	else
		cb(0, _source)
	end
end)

ESX.RegisterUsableItem('burner', function(source)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
		TriggerClientEvent('moneywash:checkxd', _source)
end)

RegisterServerEvent('moneywash:notify')
AddEventHandler('moneywash:notify', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
        TriggerClientEvent("esx_animations:playtelefonanim", _source, "amb@world_human_stand_mobile@male@text@base", "base", 51, 0)
		TriggerClientEvent("pNotify:SendNotification", _source, {
		text = "Przytrzymujesz klawisz blokady..",
		type = "atlantis",
		queue = "global",
		timeout = 2000,
		layout = "atlantis"
	})
        Citizen.Wait(2000)
		TriggerClientEvent("pNotify:SendNotification", _source, {
		text = "<span style='color:#2FCC34;'>Włączasz <span style='color:white;'>telefon..",
		type = "atlantis",
		queue = "global",
		timeout = 2000,
		layout = "atlantis"
	})
        Citizen.Wait(2000)
		TriggerClientEvent("pNotify:SendNotification", _source, {
		text = "Przeglądasz menu telefonu i widzisz, że nie jest on połączony z żadną publiczną siecią komórkową",
		type = "atlantis",
		queue = "global",
		timeout = 16000,
		layout = "atlantis"
	})
        Citizen.Wait(7000)
    	TriggerClientEvent("pNotify:SendNotification", _source, {
		text = "Wchodzisz w <span style='color:orange;'>'Kontakty' <span style='color:white;'>i widzisz jeden zaszyfrowany numer zapisany jako <span style='color:red;'>'Konsultant'",
		type = "atlantis",
		queue = "global",
		timeout = 16000,
		layout = "atlantis"
	})
        Citizen.Wait(7000)
        TriggerClientEvent("pNotify:SendNotification", _source, {
		text = "Wchodzisz w <span style='color:#2FCC34;'>'Wiadomości' <span style='color:white;'>i widzisz <span style='color:yellow;'>'Ranczo zostało sprzedane. Właściciel wprowadził nowe regulacje oraz zmiany w firmie. Proszę kontaktować się przez ten telefon'",
		type = "atlantis",
		queue = "global",
		timeout = 16000,
		layout = "atlantis"
	})
        Citizen.Wait(7000)
        TriggerClientEvent("pNotify:SendNotification", _source, {
		text = "Patrzysz na stan baterii i widzisz <span style='color:#2FCC34;'>'Naładowany'<span style='color:white;'>, po czym telefon samoistnie <span style='color:red;'>wyłącza się <span style='color:white;'>po 30 sekundach",
		type = "atlantis",
		queue = "global",
		timeout = 16000,
		layout = "atlantis"
	})
end)