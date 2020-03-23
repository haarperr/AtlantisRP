local listOn = false
local hex = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40}
local _lspd = 0
local _ems = 0
local _mecano = 0
local _ds = 0
local _taxi = 0
local page = 1
local pages = 1
ESX = nil
-- TriggerClientEvent('fax-scoreboard:getJobs', source, lspd, ems, mecano, ds, taxi)

--local hex = "asd"
Citizen.CreateThread(function ()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  PlayerData = ESX.GetPlayerData()
  end
end)
RegisterNetEvent('fax-scoreboard:updatehex')
AddEventHandler('fax-scoreboard:updatehex', function(identifier,idx)
       hex[idx] = identifier

end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('fax-scoreboard:getJobs')
AddEventHandler('fax-scoreboard:getJobs', function(lspd, ems, mecano, ds, taxi)
       _lspd = lspd
       _ems = ems
       _mecano = mecano
       _ds = ds
       _taxi = taxi

end)

Citizen.CreateThread(function()
    listOn = false
    while true do
        Wait(0)
	
        if IsControlPressed(0, 48)  then
		TriggerServerEvent('fax-scoreboard:ShowJobs')    
        if  _lspd > 7 then
            TriggerServerEvent("lspdLimit")
        end        
		if not listOn then
                local players = {}
                
		
		
		ptable = GetPlayers()
                local headerText = "Obywateli na wyspie: ( " .. NetworkGetNumConnectedPlayers() .. " )"
                local j = 1	
		for _, i in ipairs(ptable) do
                    --local wantedLevel = GetPlayerWantedLevel(i)
            
		    r, g, b = GetPlayerRgbColour(i)
		--   TriggerServerEvent('fax-scoreboard:gethex', GetPlayerServerId(i),i) 
		    local name = hex[i]
		   
		 
		  if name == string.lower("steam:x") or name == string.lower("steam:x") or name == string.lower("steam:x") or name == string.lower("steam:x") or name == string.lower("steam:x") then
			  name = "steam:x" 
		  end
		    local classRow = "row1"
		   
		    if (j % 2 == 0) then
			classRow = "row2"
		    else
			classRow = "row1"
	            end
		   
		    if (i == PlayerId()) then
			    
			    classRow = "rowPlayer"
			    name = "<u>" .. name .. "</u> << Twoje ID" 

	            end
                    table.insert(players, 
                    '<tr class="'.. classRow ..'" style=""rgb(255, 255, 255);"  font-weight: 500;"><td>' .. GetPlayerServerId(i) .. '</td><td>' ..name..'</td></tr>'
                    )
		    j=j+1
                end
		
		local printPage = 2
		if pages == 1 then printPage = 1 end
		if (pages == 2 and page == 2) then
		  printPage = 1
		end

		

		table.insert(players,
                    '<tr style="font-size: 110% !important; color:#ff9dd3 !important;" ><td colspan="2"><center><B>Jednostki na służbie</B></center></td></tr><tr style=""rgb(255, 255, 255);"  font-weight: 500;"><td style="font-size:110%;" align="center" colspan="2"><span class="jobEMS"><i class="fas fa-ambulance"></i> ('.. _ems ..')</span> <span class="jobLSPD"><i class="fas fa-shield-alt"></i> ('.. _lspd ..')</span>  <span class="jobDS"><i class="fas fa-gavel"></i> ('.. _ds ..') </span> <span class="jobMECANO"><i class="fas fa-car-crash"></i> ('.. _mecano ..')</span>  <span class="jobTAXI"><i class="fas fa-taxi"></i> ('.. _taxi ..')</span>  </td></tr>'
                    )
		    
                table.insert(players,
                    '<BR><BR><tr style="color: rgb(255, 255, 255); font-weight: 500;"><td colspan="2"> ' .. headerText ..' <BR><center>Strona: ' ..printPage.. '/'..pages..'</center></td></tr>'
                    )
   
                    
	 --[[ if not listOn then
                local players = {}
               -- ptable = GetPlayers()
                 for i = 0, 31
        	 do
                    
		    if (NetworkIsPlayerActive(i)) then
			--local wantedLevel = GetPlayerWantedLevel(i)
		    	local serverId = GetPlayerServerId(i)
	 	    	TriggerServerEvent('fax-scoreboard:gethex', serverId, i)
                    	local name = hex[i]
		    	print(i)
                    	r, g, b = GetPlayerRgbColour(i)
                    	table.insert(players, 
                    	'<tr style="color: rgb(255, 255, 255); font-weight: 500;"><td>' .. serverId .. '</td><td>' .. name ..'</td></tr>'
                    	)
		    end
             ]]--   end
             
    
                SendNUIMessage({ text = table.concat(players) })

                listOn = true
                while listOn do
                    Wait(0)
                    if(IsControlPressed(0, 73)) then
		--	Wait(2500)
                        listOn = false
                        SendNUIMessage({

                            meta = 'close'
                        })
			Wait(150)
                        break
                    end
                end
            end
        end
    end
end)

function GetPlayers()
    local players = {}
   
    local countPlayers = NetworkGetNumConnectedPlayers()

    if countPlayers > 15 then 
		pages = 2
    end

    if pages == 2 then
	if page == 1 then
	    	for i = 0, 14  do
        		if NetworkIsPlayerActive(i) then
	    		TriggerServerEvent('fax-scoreboard:gethex', GetPlayerServerId(i),i) 
	   	 	--print(GetPlayerServerId(i))
	    		table.insert(players, i)
        		end
   		end
		page = 2
	else
                for i = 15, 31  do
                        if NetworkIsPlayerActive(i) then
                        TriggerServerEvent('fax-scoreboard:gethex', GetPlayerServerId(i),i)
                        --print(GetPlayerServerId(i))
                        table.insert(players, i)
                        end
                end
                page = 1
        end
    else
        page = 1
        for i = 0, 31  do
                if NetworkIsPlayerActive(i) then
                TriggerServerEvent('fax-scoreboard:gethex', GetPlayerServerId(i),i)
                --print(GetPlayerServerId(i))
                table.insert(players, i)
                end
        end
    end
	
    Citizen.Wait(300)
    return players
end
