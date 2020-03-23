ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("drugdealer:policeCheck")
AddEventHandler("drugdealer:policeCheck", function()
local source = source
local xPlayers = ESX.GetPlayers()
local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('es:getPlayers', function(players)
		local cops = 0
		for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
				cops = cops + 1
			end
		end
		if cops < 3 then
			TriggerClientEvent("pNotify:SendNotification", source, {text = "Nie ma odpowiedniej ilości LSPD na służbie", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
		else 
			TriggerClientEvent('drug:dealer_gostart', source)
		end
	end)
end)

RegisterServerEvent('drugdealer:succes_weed')
AddEventHandler('drugdealer:succes_weed', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local weedcount1 = xPlayer.getInventoryItem('rsativa').count
	local weedcount2 = xPlayer.getInventoryItem('rhybrid').count
	local weedcount3 = xPlayer.getInventoryItem('rweed').count
	local randamount = math.random(1,2)
	local randamount2 = math.random(1,3)
	    if weedcount3 == 1 then
	    	local price = math.random(240,330)
	    	xPlayer.removeInventoryItem('rweed', 1)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 4)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rweed',1,price)
	    elseif weedcount3 == 2 and randamount == 1 then
	    	local price = math.random(240,330)
	    	xPlayer.removeInventoryItem('rweed', 1)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 4)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rweed',1,price)
	    elseif weedcount3 == 2 and randamount == 2 then
	    	local price = math.random(480,660)
	    	xPlayer.removeInventoryItem('rweed', 2)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 8)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rweed',2,price)
	    elseif weedcount3 > 2 and randamount2 == 1 then
	    	local price = math.random(240,330)
	    	xPlayer.removeInventoryItem('rweed', 1)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 4)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rweed',1,price)
	    elseif weedcount3 > 2 and randamount2 == 2 then
	    	local price = math.random(480,660)
	    	xPlayer.removeInventoryItem('rweed', 2)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 8)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rweed',2,price)
	    elseif weedcount3 > 2 and randamount2 == 3 then
	    	local price = math.random(720,990)
	    	xPlayer.removeInventoryItem('rweed', 3)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 12)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rweed',3,price)
	    elseif weedcount2 == 1 then
	    	local price = math.random(150,240)
	    	xPlayer.removeInventoryItem('rhybrid', 1)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 3)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rhybrid',1,price)
	    elseif weedcount2 == 2 and randamount == 1 then
	    	local price = math.random(150,240)
	    	xPlayer.removeInventoryItem('rhybrid', 1)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 3)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rhybrid',1,price)
	    elseif weedcount2 == 2 and randamount == 2 then
	    	local price = math.random(300,480)
	    	xPlayer.removeInventoryItem('rhybrid', 2)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 6)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rhybrid',2,price)
	    elseif weedcount2 > 2 and randamount2 == 1 then
	    	local price = math.random(150,240)
	    	xPlayer.removeInventoryItem('rhybrid', 1)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 3)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rhybrid',1,price)
	    elseif weedcount2 > 2 and randamount2 == 2 then
	    	local price = math.random(300,480)
	    	xPlayer.removeInventoryItem('rhybrid', 2)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 6)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rhybrid',2,price)
	    elseif weedcount2 > 2 and randamount2 == 3 then
	    	local price = math.random(450,720)
	    	xPlayer.removeInventoryItem('rhybrid', 3)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 9)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rhybrid',3,price)
	    elseif weedcount1 == 1 then
	    	local price = math.random(60,150)
	    	xPlayer.removeInventoryItem('rsativa', 1)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 2)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rsativa',1,price)
	    elseif weedcount1 == 2 and randamount == 1 then
	    	local price = math.random(60,150)
	    	xPlayer.removeInventoryItem('rsativa', 1)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 2)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rsativa',1,price)
	    elseif weedcount1 == 2 and randamount == 2 then
	    	local price = math.random(120,300)
	    	xPlayer.removeInventoryItem('rsativa', 2)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 4)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rsativa',2,price)
	    elseif weedcount1 > 2 and randamount2 == 1 then
	    	local price = math.random(60,150)
	    	xPlayer.removeInventoryItem('rsativa', 1)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 2)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rsativa',1,price)
	    elseif weedcount1 > 2 and randamount2 == 2 then
	    	local price = math.random(120,300)
	    	xPlayer.removeInventoryItem('rsativa', 2)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 4)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rsativa',2,price)
	    elseif weedcount1 > 2 and randamount2 == 3 then
	    	local price = math.random(180,450)
	    	xPlayer.removeInventoryItem('rsativa', 3)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 6)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rsativa',3,price)
	    else
	    	TriggerClientEvent("pNotify:SendNotification", _source, {text = "Nie masz towaru, który mnie interesuje", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
	    	TriggerClientEvent('drug:dealer_reject', _source)
	    end
end)

RegisterServerEvent('drugdealer:succes_coke')
AddEventHandler('drugdealer:succes_coke', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local coke1count = xPlayer.getInventoryItem('rcoke70').count
	local coke2count = xPlayer.getInventoryItem('rcoke90').count
	local coke3count = xPlayer.getInventoryItem('rcoke100').count
	local randamount = math.random(1,2)
	local randamount2 = math.random(1,3)
		if coke3count == 1 then
			local price = math.random(510,600)
	    	xPlayer.removeInventoryItem('rcoke100', 1)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 6)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rcoke100',1,price)
		elseif coke3count == 2 and randamount == 1 then
			local price = math.random(510,600)
	    	xPlayer.removeInventoryItem('rcoke100', 1)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 6)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rcoke100',1,price)
		elseif coke3count == 2 and randamount == 2 then
			local price = math.random(1020,1200)
	    	xPlayer.removeInventoryItem('rcoke100', 2)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 12)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rcoke100',2,price)
		elseif coke3count > 2 and randamount2 == 1 then
			local price = math.random(510,600)
	    	xPlayer.removeInventoryItem('rcoke100', 1)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 6)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rcoke100',1,price)
		elseif coke3count > 2 and randamount2 == 2 then
			local price = math.random(1020,1200)
	    	xPlayer.removeInventoryItem('rcoke100', 2)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 12)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rcoke100',2,price)
		elseif coke3count > 2 and randamount2 == 3 then
			local price = math.random(1530,1800)
	    	xPlayer.removeInventoryItem('rcoke100', 3)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 18)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rcoke100',3,price)
		elseif coke2count == 1 then
			local price = math.random(420,510)
	    	xPlayer.removeInventoryItem('rcoke90', 1)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 5)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rcoke90',1,price)
		elseif coke2count == 2 and randamount == 1 then
			local price = math.random(420,510)
	    	xPlayer.removeInventoryItem('rcoke90', 1)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 5)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rcoke90',1,price)
		elseif coke2count == 2 and randamount == 2 then
			local price = math.random(840,1020)
	    	xPlayer.removeInventoryItem('rcoke90', 2)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 10)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rcoke90',2,price)
		elseif coke2count > 2 and randamount2 == 1 then
			local price = math.random(420,510)
	    	xPlayer.removeInventoryItem('rcoke90', 1)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 5)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rcoke90',1,price)
		elseif coke2count > 2 and randamount2 == 2 then
			local price = math.random(840,1020)
	    	xPlayer.removeInventoryItem('rcoke90', 2)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 10)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rcoke90',2,price)
		elseif coke2count > 2 and randamount2 == 3 then
			local price = math.random(1260,1530)
	    	xPlayer.removeInventoryItem('rcoke90', 3)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 15)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rcoke90',3,price)
		elseif coke1count == 1 then
			local price = math.random(375,420)
	    	xPlayer.removeInventoryItem('rcoke70', 1)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 4)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rcoke70',1,price)
		elseif coke1count == 2 and randamount == 1 then
			local price = math.random(375,420)
	    	xPlayer.removeInventoryItem('rcoke70', 1)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 4)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rcoke70',1,price)
		elseif coke1count == 2 and randamount == 2 then
			local price = math.random(750,840)
	    	xPlayer.removeInventoryItem('rcoke70', 2)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 8)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rcoke70',2,price)
		elseif coke1count > 2 and randamount2 == 1 then
			local price = math.random(375,420)
	    	xPlayer.removeInventoryItem('rcoke70', 1)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 4)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rcoke70',1,price)
		elseif coke1count > 2 and randamount2 == 2 then
			local price = math.random(750,840)
	    	xPlayer.removeInventoryItem('rcoke70', 2)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 8)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rcoke70',2,price)
		elseif coke1count > 2 and randamount2 == 3 then
			local price = math.random(1125,1260)
	    	xPlayer.removeInventoryItem('rcoke70', 3)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 12)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'rcoke70',3,price)
	    else
	    	TriggerClientEvent("pNotify:SendNotification", _source, {text = "Nie masz towaru, który mnie interesuje", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
	    	TriggerClientEvent('drug:dealer_reject', _source)
	    end
end)

RegisterServerEvent('drugdealer:succes_meth')
AddEventHandler('drugdealer:succes_meth', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local methcounter = xPlayer.getInventoryItem('meth_sudo').count
	local randamount = math.random(1,2)
	local randamount2 = math.random(1,3)
		if methcounter == 1 then
			local price = math.random(330,375)
	    	xPlayer.removeInventoryItem('meth_sudo', 1)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 6)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'meth_sudo',1,price)
		elseif methcounter == 2 and randamount == 1 then
			local price = math.random(330,375)
	    	xPlayer.removeInventoryItem('meth_sudo', 1)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 6)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'meth_sudo',1,price)
		elseif methcounter == 2 and randamount == 2 then
			local price = math.random(660,750)
	    	xPlayer.removeInventoryItem('meth_sudo', 2)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 12)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'meth_sudo',2,price)
		elseif methcounter > 2 and randamount2 == 1 then
			local price = math.random(330,375)
	    	xPlayer.removeInventoryItem('meth_sudo', 1)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 6)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'meth_sudo',1,price)
		elseif methcounter > 2 and randamount2 == 2 then
			local price = math.random(660,750)
	    	xPlayer.removeInventoryItem('meth_sudo', 2)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 12)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'meth_sudo',2,price)
		elseif methcounter > 2 and randamount2 == 3 then
			local price = math.random(990,1125)
	    	xPlayer.removeInventoryItem('meth_sudo', 3)
	    	xPlayer.addAccountMoney('black_money', price)
	    	TriggerClientEvent('drug:dealer_sell', _source, 18)
	    	TriggerClientEvent('esx:showNotification', _source, "Klient kupił towaru za ~b~" ..price.."$")
			TriggerEvent("esx:drugsellalert",xPlayer.name,'meth_sudo',3,price)
	    else
	    	TriggerClientEvent("pNotify:SendNotification", _source, {text = "Nie masz towaru, który mnie interesuje", type = "atlantis", queue = "global", timeout = 3000, layout = "atlantis"})
	    	TriggerClientEvent('drug:dealer_reject', _source)
	    end
end)

RegisterServerEvent('drugdealer:notification')
AddEventHandler('drugdealer:notification', function(gender, xstreet1, xstreet2, sex, xdx, xdy, xdz)
	if gender == 1 then
		TriggerEvent('drugsInProgress', " ^7Podejrzany ^1" ..sex.. " ^7w okolicach ^1"..xstreet1.. " ^7próbował mi sprzedać narkotyki." )
	elseif gender == 2 then
		TriggerEvent('drugsInProgress', " ^7Podejrzana ^1" ..sex.. " ^7w okolicach ^1"..xstreet1.. " ^7próbowała mi sprzedać narkotyki." )
	end
	
end)

RegisterServerEvent('drugdealer:blip')
AddEventHandler('drugdealer:blip', function(xdx, xdy, xdz)
	TriggerEvent('drugsInProgressPos', xdx, xdy, xdz)
end)

ESX.RegisterServerCallback('drugdealer:chcekinventory', function(source, cb, target)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)
	local weedcount1 = xPlayer.getInventoryItem('rweed').count
	local weedcount2 = xPlayer.getInventoryItem('rhybrid').count
	local weedcount3 = xPlayer.getInventoryItem('rsativa').count
	local coke1count = xPlayer.getInventoryItem('rcoke100').count
	local coke2count = xPlayer.getInventoryItem('rcoke90').count
	local coke3count = xPlayer.getInventoryItem('rcoke70').count
	local methcount = xPlayer.getInventoryItem('meth_sudo').count

	if weedcount1 > 0 then
		cb(weedcount1, _source)
	elseif weedcount2 > 0 then
		cb(weedcount2, source)
	elseif weedcount3 > 0 then
		cb(weedcount3, source)
	elseif coke1count > 0 then
		cb(coke1count, source)
	elseif coke2count > 0 then
		cb(coke2count, source)
	elseif coke3count > 0 then
		cb(coke3count, source)
	elseif methcount > 0 then
		cb(methcount, source)
	else
		cb(0, _source)
	end
end)