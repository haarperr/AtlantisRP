local rob = false
local robbers = {}
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function get3DDistance(x1, y1, z1, x2, y2, z2)
    return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('esx_humanelabs:toofar')
AddEventHandler('esx_humanelabs:toofar', function(robb)
    local source = source
    local xPlayers = ESX.GetPlayers()
    rob = false
    for i=1, #xPlayers, 1 do
         local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
         if xPlayer.job.name == 'police' then
            TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_cancelled_at') .. Banks[robb].nameofbank)
            TriggerClientEvent('esx_humanelabs:killblip', xPlayers[i])
        end
    end
    if(robbers[source])then
        TriggerClientEvent('esx_humanelabs:toofarlocal', source)
        robbers[source] = nil
        TriggerClientEvent('esx:showNotification', source, _U('robbery_has_cancelled') .. Banks[robb].nameofbank)
    end
end)


ESX.RegisterUsableItem('humane_case', function(source)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)
  local prizeCase = "nic"
  xPlayer.removeInventoryItem('humane_case', 1)

  local chance = math.random(0,100)

  if(chance < 3) then
	  prizeCase = "złoty rewolwer"
	  xPlayer.addWeapon('weapon_doubleaction', 200)
  else
	  prizeCase = "50.000$ brudnego siana!"
	  xPlayer.addAccountMoney('black_money', 50000) 
  end
  --
  --TriggerClientEvent('esx_mecanojob:onHijack', _source)
    TriggerClientEvent('esx:showNotification', _source, "Otwierasz Humane Labs Suitcase, znajdujesz w niej: " .. prizeCase)

end)

RegisterServerEvent('esx_humanelabs:rob')
AddEventHandler('esx_humanelabs:rob', function(robb)

    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()

    if Banks[robb] then

        local bank = Banks[robb]

        if (os.time() - bank.lastrobbed) < Config.TimerBeforeNewRob and bank.lastrobbed ~= 0 then

            TriggerClientEvent('esx:showNotification', source, _U('already_robbed') .. (Config.TimerBeforeNewRob - (os.time() - bank.lastrobbed)) .. _U('seconds'))
            return
        end
	
	local wiertlo = xPlayer.getInventoryItem("wiertlo")
	local sygnet = xPlayer.getInventoryItem("sygnet")
	local kody = xPlayer.getInventoryItem("kody_dostepu")

	

        local cops = 0
        for i=1, #xPlayers, 1 do
         local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
         if xPlayer.job.name == 'police' and xPlayer.job.grade_name ~= 'recruit' then
                cops = cops + 1
            end
        end


        if rob == false then

            if(cops >= Config.PoliceNumberRequired)then

               
                    
        	if(wiertlo.count == 0 or sygnet.count == 0 or kody.count == 0) then

                	TriggerClientEvent('esx:showNotification', source, "Nie posiadasz wszystkich elementów potrzebnych do wykonania tej roboty!")
                	return
        	else
                	xPlayer.removeInventoryItem("wiertlo",1)
                	xPlayer.removeInventoryItem("sygnet", 1)
        	        xPlayer.removeInventoryItem("kody_dostepu",1)
	        end
		
                for i=1, #xPlayers, 1 do
                     local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                     if xPlayer.job.name == 'police' and xPlayer.job.grade_name ~= 'recruit' then
                            TriggerClientEvent('esx:showNotification', xPlayers[i], _U('rob_in_prog') .. bank.nameofbank)
                            TriggerClientEvent('esx_humanelabs:setblip', xPlayers[i], Banks[robb].position)
                    end
                end		
		rob = true	
                TriggerClientEvent('esx:showNotification', source, _U('started_to_rob') .. bank.nameofbank .. _U('do_not_move'))
                TriggerClientEvent('esx:showNotification', source, _U('alarm_triggered'))
                TriggerClientEvent('esx:showNotification', source, _U('hold_pos') .. bank.secondsRemaining/60 .. _U('min_to_take_money'))
                
                TriggerClientEvent('esx_humanelabs:currentlyrobbing', source, robb)
                TriggerClientEvent('esx_humanelabs:starttimer', source)
                
                
                Banks[robb].lastrobbed = os.time()
                robbers[source] = robb
                local savedSource = source
                SetTimeout(bank.secondsRemaining*1000, function()

                    if(robbers[savedSource])then

                        rob = false
                        TriggerClientEvent('esx_humanelabs:robberycomplete', savedSource, job)
                        if(xPlayer)then

                            xPlayer.addMoney(bank.reward)
			    xPlayer.addInventoryItem('humane_case', 1)
                            local xPlayers = ESX.GetPlayers()
                            for i=1, #xPlayers, 1 do
                                 local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                                 if xPlayer.job.name == 'police' and xPlayer.job.grade_name ~= 'recruit' then
                                        TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_complete_at') .. bank.nameofbank)
                                        TriggerClientEvent('esx_humanelabs:killblip', xPlayers[i])
                                end
                            end
                        end
                    end
                end)
            else
                TriggerClientEvent('esx:showNotification', source, _U('min_police') .. Config.PoliceNumberRequired .. _U('in_city'))
            end
        else
            TriggerClientEvent('esx:showNotification', source, _U('robbery_already'))
        end
    end
end)
