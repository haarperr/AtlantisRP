--[[
 ___________________________________________________________________________________
|																					|
|							Script Created by: Johnny2525							|
|						Mail: johnny2525.contact@gmail.com							|
|		Linked-In: https://www.linkedin.com/in/jakub-barwi%C5%84ski-09617b164/		|
|___________________________________________________________________________________|

--]]

local LicenseList = {}
Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end

  while ESX.GetPlayerData().job == nil do
    Citizen.Wait(10)
  end

 
end)
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsControlJustPressed(0, 316) then
      TriggerServerEvent('showid:blachaKey')
      Citizen.Wait(500)
    end
    if IsControlJustPressed(0,317) then 
      TriggerServerEvent('showid:dowodKey')
      Citizen.Wait(500)
    end 
      
  end

 
end)
RegisterNetEvent('showid:loadLicenses')
AddEventHandler('showid:loadLicenses', function (licenses)
	LicenseList = {}

  for i = 1, #licenses, 1 do
    LicenseList[licenses[i].type] = true
  end
end)
RegisterNetEvent('showid:DisplayCard')
AddEventHandler('showid:DisplayCard', function(id, playerName1, playerName2, phone)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  
  if pid == myId then
	TriggerEvent("pNotify:SendNotification", {
        text = "<div style='min-width: 403px; min-height: 200px; background-image: url(https://i.imgur.com/JKhxPqC.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'><div style='position: relative; top: 55px; left: 0px; color:#1c1c1c;font-family: courier;font-size: 25px'><center>"..playerName1 .. " " .. playerName2 .. "<BR><BR><font style='font-size: 18px'> <i>".. phone .."</i></font></center></div>  </div>",
          type = "dowod",
          queue = "global",
          timeout = 15000,
          layout = "dowod"
        }) 

		chowaniebronianim()
		pokazdowodanim()
		portfeldowodprop1()

  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 4.9999 then
       TriggerEvent("pNotify:SendNotification", {
         text = "<div style='min-width: 403px; min-height: 200px; background-image: url(https://i.imgur.com/JKhxPqC.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'><div style='position: relative; top: 55px; left: 0px; color:#1c1c1c;font-family: courier;font-size: 25px'><center>"..playerName1 .. " " .. playerName2 .. "<BR><BR><font style='font-size: 18px'> <i>".. phone .."</i></font></center></div>  </div>",
          type = "dowod",
          queue = "global",
          timeout = 15000,
          layout = "dowod"
        })
  end
end)
RegisterNetEvent('showid:DisplayId')
AddEventHandler('showid:DisplayId', function(id, playerName1, playerName2, license, weapon, job, ubezpieczenie)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  
  if pid == myId then
	TriggerEvent("pNotify:SendNotification", {
          text = "<font style='font-size: 13px'><div style='min-width: 403px; min-height: 200px; background-image: url(https://i.imgur.com/i9nN9Lw.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'><div style='position: absolute; top: 50px; left: 16px; color:#094a7d; text-shadow: 1px 1px 2px rgba(0,0,0,0.2);font-family: courier;font-size: 13px'><table><tr><td align='right'><B><font style='font-size: 13px;color:#07375c;'>Imię:<BR>Nazwisko:<BR>Zawód:<BR><BR>Prawo jazdy:<BR>Ubezpieczenie:<BR>Pozwolenie na broń:</td><td><B><font style='font-size: 13px;color:#094a7d;'>" ..playerName1.."<BR>"..playerName2.."<BR>".. job .. "<BR><BR>" ..license.."<BR>"..ubezpieczenie.."<BR>".. weapon .."</td></tr></table>  </div>",
          type = "dowod",
          queue = "global",
          timeout = 15000,
          layout = "dowod"
        }) 

		chowaniebronianim()
		pokazdowodanim()
		portfeldowodprop1()

  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 4.9999 then
       TriggerEvent("pNotify:SendNotification", {
          text = "<font style='font-size: 13px'><div style='min-width: 403px; min-height: 200px; background-image: url(https://i.imgur.com/i9nN9Lw.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'><div style='position: absolute; top: 50px; left: 16px; color:#094a7d; text-shadow: 1px 1px 2px rgba(0,0,0,0.2);font-family: courier;font-size: 13px'><table><tr><td align='right'><B><font style='font-size: 13px;color:#07375c;'>Imię:<BR>Nazwisko:<BR><BR>Prawo jazdy:<BR>Ubezpieczenie:<BR>Pozwolenie na broń:</td><td><B><font style='font-size: 13px;color:#094a7d;'>" ..playerName1.."<BR>"..playerName2.."<BR><BR>" ..license.."<BR>"..ubezpieczenie.."<BR>".. weapon .."</td></tr></table>  </div>",
          type = "dowod",
          queue = "global",
          timeout = 15000,
          layout = "dowod"
        })
  end
end)
RegisterNetEvent('showid:DisplayIdPrzeszukanie')
AddEventHandler('showid:DisplayIdPrzeszukanie', function(id, playerName1, playerName2, license, weapon, job, ubezpieczenie)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  
  if pid == myId then
  TriggerEvent("pNotify:SendNotification", {
          text = "<font style='font-size: 13px'><div style='min-width: 403px; min-height: 200px; background-image: url(https://i.imgur.com/i9nN9Lw.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'><div style='position: absolute; top: 50px; left: 16px; color:#094a7d; text-shadow: 1px 1px 2px rgba(0,0,0,0.2);font-family: courier;font-size: 13px'><table><tr><td align='right'><B><font style='font-size: 13px;color:#07375c;'>Imię:<BR>Nazwisko:<BR><BR>Prawo jazdy:<BR>Ubezpieczenie:<BR>Pozwolenie na broń:</td><td><B><font style='font-size: 13px;color:#094a7d;'>" ..playerName1.."<BR>"..playerName2.."<BR><BR>" ..license.."<BR>"..ubezpieczenie.."<BR>".. weapon .."</td></tr></table>  </div>",
          type = "dowod",
          queue = "global",
          timeout = 15000,
          layout = "dowod"
        }) 

  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 4.9999 then
       TriggerEvent("pNotify:SendNotification", {
                  text = "<font style='font-size: 13px'><div style='min-width: 403px; min-height: 200px; background-image: url(https://i.imgur.com/i9nN9Lw.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'><div style='position: absolute; top: 50px; left: 16px; color:#094a7d; text-shadow: 1px 1px 2px rgba(0,0,0,0.2);font-family: courier;font-size: 13px'><table><tr><td align='right'><B><font style='font-size: 13px;color:#07375c;'>Imię:<BR>Nazwisko:<BR>Zawód:<BR><BR>Prawo jazdy:<BR>Ubezpieczenie:<BR>Pozwolenie na broń:</td><td><B><font style='font-size: 13px;color:#094a7d;'>" ..playerName1.."<BR>"..playerName2.."<BR>".. job .. "<BR><BR>" ..license.."<BR>"..ubezpieczenie.."<BR>".. weapon .."</td></tr></table>  </div>",

          type = "dowod",
          queue = "global",
          timeout = 15000,
          layout = "dowod"
        })
  end
end)
RegisterNetEvent('showid:DisplayLSPD')
AddEventHandler('showid:DisplayLSPD', function(id, playerName1, playerName2, license, weapon, job, badge)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id) 

  if pid == myId then
        TriggerEvent("pNotify:SendNotification", {
          text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/aT7I4LH.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'><div style='position: relative; top:86px; color:#fff; text-shadow: 0px 0px 5px rgba(0, 0, 0, 1); line-height: 20px; font-family: courier;'><CENTER><font style='font-size: 24px; margin-left: 60px;'>" ..playerName1.."</font><BR><font style='font-size: 16px; margin-left: 60px;'>" ..playerName2.."</font><B><p style='font-size: 14px; margin-left: 60px;'>".. job .. "</p><BR></b><font style='font-size: 32px;'>"..badge.."</font><BR>nr. odznaki</CENTER></div></div>",
          type = "dowod",
          queue = "global",
          timeout = 15000,
          layout = "dowod"
        })
			
		chowaniebronianim()
		pokazblachaanim()
		blachaprop1()

  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 4.9999 then
       TriggerEvent("pNotify:SendNotification", {
          text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/aT7I4LH.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'><div style='position: relative; top:86px; color:#fff; text-shadow: 0px 0px 5px rgba(0, 0, 0, 1); line-height: 20px; font-family: courier;'><CENTER><font style='font-size: 24px; margin-left: 60px;'>" ..playerName1.."</font><BR><font style='font-size: 16px; margin-left: 60px;'>" ..playerName2.."</font><B><p style='font-size: 14px; margin-left: 60px;'>".. job .. "</p><BR></b><font style='font-size: 32px;'>"..badge.."</font><BR>nr. odznaki</CENTER></div></div>",
          type = "dowod",
          queue = "global",
          timeout = 15000,
          layout = "dowod"
        })

  end
end)

RegisterNetEvent('showid:DisplayEMS')
AddEventHandler('showid:DisplayEMS', function(id, playerName, license, weapon, job, badge)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)

  if pid == myId then
        TriggerEvent("pNotify:SendNotification", {
                  text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/KTULXPB.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'><div style='position: relative; top:155px; left: 60px; font-size: 24px; text-shadow: 0px 0px 0px rgba(0, 0, 0, 0); text-transform: uppercase; line-height: 20px; font-family: Lato; color: #cf3c56 !important;'><CENTER><B>NR" ..badge.." <BR></B></div><div style='position: relative; top:215px;  font-size: 20px; text-shadow: 0px 0px 0px rgba(0, 0, 0, 0); text-transform: uppercase; line-height: 20px; font-family: Lato; color: #fff !important;'><CENTER><B>".. job .. "<BR><BR><font style='font-family: courier; font-size: 20px;'>"..playerName.."</CENTER></font></div></div>", 
          type = "info",
          queue = "global",
          timeout = 15000,
          layout = "dowod"
        })
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 2.9999 then
       TriggerEvent("pNotify:SendNotification", {
                  text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/KTULXPB.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'><div style='position: relative; top:155px; left: 60px; font-size: 24px; text-shadow: 0px 0px 0px rgba(0, 0, 0, 0); text-transform: uppercase; line-height: 20px; font-family: Lato; color: #cf3c56 !important;'><CENTER><B>NR" ..badge.." <BR></B></div><div style='position: relative; top:215px;  font-size: 20px; text-shadow: 0px 0px 0px rgba(0, 0, 0, 0); text-transform: uppercase; line-height: 20px; font-family: Lato; color: #fff !important;'><CENTER><B>".. job .. "<BR><BR><font style='font-family: courier; font-size: 20px;'>"..playerName.."</CENTER></font></div></div>",          
          type = "info",
          queue = "global",
          timeout = 15000,
          layout = "dowod"
        })
  end
end)
RegisterNetEvent('showid:DisplayZlodzieje')
AddEventHandler('showid:DisplayZlodzieje', function(id, playerName1, playerName2, license, weapon, job, badge)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id) 

  if pid == myId then
        TriggerEvent("pNotify:SendNotification", {
          text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/X91T4gb.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'><div style='position: relative; top:86px; color:#fff; text-shadow: 0px 0px 5px rgba(0, 0, 0, 1); line-height: 20px; font-family: courier;'><CENTER><font style='font-size: 24px; margin-left: 0px;'>" ..playerName1.."</font><BR><font style='font-size: 16px; margin-left: 0px;'>" ..playerName2.."</font></CENTER></div></div>",
          type = "dowod",
          queue = "global",
          timeout = 15000,
          layout = "dowod"
        })
			
		chowaniebronianim()
		pokazblachaanim()
		blachaprop1()

  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 4.9999 then
       TriggerEvent("pNotify:SendNotification", {
          text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/X91T4gb.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'><div style='position: relative; top:86px; color:#fff; text-shadow: 0px 0px 5px rgba(0, 0, 0, 1); line-height: 20px; font-family: courier;'><CENTER><font style='font-size: 24px; margin-left: 0px;'>" ..playerName1.."</font><BR><font style='font-size: 16px; margin-left: 0px;'>" ..playerName2.."</font></CENTER></div></div>",
          type = "dowod",
          queue = "global",
          timeout = 15000,
          layout = "dowod"
        })

  end
end)
RegisterNetEvent('showid:DisplayZlodziejeInspektor')
AddEventHandler('showid:DisplayZlodziejeInspektor', function(id, playerName1, playerName2, license, weapon, job, badge)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id) 

  if pid == myId then
        TriggerEvent("pNotify:SendNotification", {
          text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 330px; background-image: url(https://i.imgur.com/7hTlk3v.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'><div style='position: relative; top:291px; color:#000000; text-shadow: 0px 0px 0px rgba(0, 0, 0, 1); line-height: 15px; font-family: courier;'><CENTER><font style='font-size: 16px; margin-left: 0px;'>" ..playerName1.."</font><BR><font style='font-size: 16px; margin-left: 0px;'>" ..playerName2.."</font></CENTER></div></div>",
          type = "dowod",
          queue = "global",
          timeout = 15000,
          layout = "dowod"
        })
			
		chowaniebronianim()
		pokazblachaanim()
		blachaprop1()

  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 4.9999 then
        TriggerEvent("pNotify:SendNotification", {
          text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 330px; background-image: url(https://i.imgur.com/7hTlk3v.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'><div style='position: relative; top:291px; color:#000000; text-shadow: 0px 0px 0px rgba(0, 0, 0, 1); line-height: 15px; font-family: courier;'><CENTER><font style='font-size: 16px; margin-left: 0px;'>" ..playerName1.."</font><BR><font style='font-size: 16px; margin-left: 0px;'>" ..playerName2.."</font></CENTER></div></div>",
          type = "dowod",
          queue = "global",
          timeout = 15000,
          layout = "dowod"
        })

  end

  --[[if pid == myId then
        TriggerEvent("pNotify:SendNotification", {
          text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/m5EqteR.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'><div style='position: relative; top:86px; color:#fff; text-shadow: 0px 0px 5px rgba(0, 0, 0, 1); line-height: 20px; font-family: courier;'><CENTER><font style='font-size: 24px; margin-left: 0px;'></font><BR><font style='font-size: 16px; margin-left: 0px;'></font></CENTER></div></div>",
          type = "dowod",
          queue = "global",
          timeout = 15000,
          layout = "dowod"
        })
			
		chowaniebronianim()
		pokazblachaanim()
		blachaprop1()

  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 4.9999 then
       TriggerEvent("pNotify:SendNotification", {
          text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/m5EqteR.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'><div style='position: relative; top:86px; color:#fff; text-shadow: 0px 0px 5px rgba(0, 0, 0, 1); line-height: 20px; font-family: courier;'><CENTER><font style='font-size: 24px; margin-left: 0px;'></font><BR><font style='font-size: 16px; margin-left: 0px;'></font></CENTER></div></div>",
          type = "dowod",
          queue = "global",
          timeout = 15000,
          layout = "dowod"
        })

  end]]
end)


-------------------------------------------------------
-- gze

RegisterNetEvent('showid:DisplayGZE')
AddEventHandler('showid:DisplayGZE', function(id, steamid)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id) 
  local _steamid = steamid
if ( _steamid == "steam:x") then
    if pid == myId then
          TriggerEvent("pNotify:SendNotification", {
            text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/H6nIBsx.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'></div>",
            type = "dowod",
            queue = "global",
            timeout = 15000,
            layout = "dowod"
          })
        
      chowaniebronianim()
      pokazblachaanim()
      blachaprop1()

    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 4.9999 then
        TriggerEvent("pNotify:SendNotification", {
          text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/H6nIBsx.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'></div>",
            type = "dowod",
            queue = "global",
            timeout = 15000,
            layout = "dowod"
          })
    end
  elseif ( _steamid == "steam:x") then
    if pid == myId then
          TriggerEvent("pNotify:SendNotification", {
            text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/MFOD46g.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'></div>",
            type = "dowod",
            queue = "global",
            timeout = 15000,
            layout = "dowod"
          })
        
      chowaniebronianim()
      pokazblachaanim()
      blachaprop1()

    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 4.9999 then
        TriggerEvent("pNotify:SendNotification", {
          text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/MFOD46g.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'></div>",
            type = "dowod",
            queue = "global",
            timeout = 15000,
            layout = "dowod"
          })
    end
  elseif ( _steamid == "steam:X") then
    if pid == myId then
          TriggerEvent("pNotify:SendNotification", {
            text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/22m2wvX.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'></div>",
            type = "dowod",
            queue = "global",
            timeout = 15000,
            layout = "dowod"
          })
        
      chowaniebronianim()
      pokazblachaanim()
      blachaprop1()

    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 4.9999 then
        TriggerEvent("pNotify:SendNotification", {
          text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/22m2wvX.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'></div>",
            type = "dowod",
            queue = "global",
            timeout = 15000,
            layout = "dowod"
          })
    end
  --[[elseif ( _steamid == "steam:x") then
    if pid == myId then
          TriggerEvent("pNotify:SendNotification", {
            text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/FxJMVuj.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'></div>",
            type = "dowod",
            queue = "global",
            timeout = 15000,
            layout = "dowod"
          })
        
      chowaniebronianim()
      pokazblachaanim()
      blachaprop1()

    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 4.9999 then
        TriggerEvent("pNotify:SendNotification", {
          text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/FxJMVuj.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'></div>",
            type = "dowod",
            queue = "global",
            timeout = 15000,
            layout = "dowod"
          })
    end
  elseif ( _steamid == "steam:X") then
    if pid == myId then
          TriggerEvent("pNotify:SendNotification", {
            text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/FxJMVuj.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'></div>",
            type = "dowod",
            queue = "global",
            timeout = 15000,
            layout = "dowod"
          })
        
      chowaniebronianim()
      pokazblachaanim()
      blachaprop1()

    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 4.9999 then
        TriggerEvent("pNotify:SendNotification", {
          text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/FxJMVuj.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'></div>",
            type = "dowod",
            queue = "global",
            timeout = 15000,
            layout = "dowod"
          })
    end]]
  --[[elseif ( _steamid == "steam:X") then
    if pid == myId then
          TriggerEvent("pNotify:SendNotification", {
            text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/mLywVo1.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'></div>",
            type = "dowod",
            queue = "global",
            timeout = 15000,
            layout = "dowod"
          })
        
      chowaniebronianim()
      pokazblachaanim()
      blachaprop1()

    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 4.9999 then
        TriggerEvent("pNotify:SendNotification", {
          text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/mLywVo1.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'></div>",
            type = "dowod",
            queue = "global",
            timeout = 15000,
            layout = "dowod"
          })
    end]]
  --[[elseif ( _steamid == "steam:X") then
    if pid == myId then
          TriggerEvent("pNotify:SendNotification", {
            text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/982moQO.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'></div>",
            type = "dowod",
            queue = "global",
            timeout = 15000,
            layout = "dowod"
          })
        
      chowaniebronianim()
      pokazblachaanim()
      blachaprop1()

    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 4.9999 then
        TriggerEvent("pNotify:SendNotification", {
          text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/982moQO.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'></div>",
            type = "dowod",
            queue = "global",
            timeout = 15000,
            layout = "dowod"
          })
    end]]
  end
end)


--------------------------------------------------------------------------------





RegisterNetEvent('showid:DisplayAIAD')
AddEventHandler('showid:DisplayAIAD', function(id, steamid)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id) 
  local _steamid = steamid
if ( _steamid == "steam:X") then
    if pid == myId then
          TriggerEvent("pNotify:SendNotification", {
            text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/vBZnQ5t.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'></div>",
            type = "dowod",
            queue = "global",
            timeout = 15000,
            layout = "dowod"
          })
        
      chowaniebronianim()
      pokazblachaanim()
      blachaprop1()

    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 4.9999 then
        TriggerEvent("pNotify:SendNotification", {
          text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/vBZnQ5t.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'></div>",
            type = "dowod",
            queue = "global",
            timeout = 15000,
            layout = "dowod"
          })
    end
  elseif ( _steamid == "steam:X") then
    if pid == myId then
          TriggerEvent("pNotify:SendNotification", {
            text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/VeVhCvm.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'></div>",
            type = "dowod",
            queue = "global",
            timeout = 15000,
            layout = "dowod"
          })
        
      chowaniebronianim()
      pokazblachaanim()
      blachaprop1()

    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 4.9999 then
        TriggerEvent("pNotify:SendNotification", {
          text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/VeVhCvm.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'></div>",
            type = "dowod",
            queue = "global",
            timeout = 15000,
            layout = "dowod"
          })
    end
  --[[elseif ( _steamid == "steam:X") then
    if pid == myId then
          TriggerEvent("pNotify:SendNotification", {
            text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/LoAjTAi.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'></div>",
            type = "dowod",
            queue = "global",
            timeout = 15000,
            layout = "dowod"
          })
        
      chowaniebronianim()
      pokazblachaanim()
      blachaprop1()

    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 4.9999 then
        TriggerEvent("pNotify:SendNotification", {
          text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/LoAjTAi.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'></div>",
            type = "dowod",
            queue = "global",
            timeout = 15000,
            layout = "dowod"
          })
    end]]
  --[[elseif ( _steamid == "steam:x") then
    if pid == myId then
          TriggerEvent("pNotify:SendNotification", {
            text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/FxJMVuj.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'></div>",
            type = "dowod",
            queue = "global",
            timeout = 15000,
            layout = "dowod"
          })
        
      chowaniebronianim()
      pokazblachaanim()
      blachaprop1()

    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 4.9999 then
        TriggerEvent("pNotify:SendNotification", {
          text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/FxJMVuj.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'></div>",
            type = "dowod",
            queue = "global",
            timeout = 15000,
            layout = "dowod"
          })
    end]]
  --[[elseif ( _steamid == "steam:x") then
    if pid == myId then
          TriggerEvent("pNotify:SendNotification", {
            text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/FxJMVuj.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'></div>",
            type = "dowod",
            queue = "global",
            timeout = 15000,
            layout = "dowod"
          })
        
      chowaniebronianim()
      pokazblachaanim()
      blachaprop1()

    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 4.9999 then
        TriggerEvent("pNotify:SendNotification", {
          text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/FxJMVuj.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'></div>",
            type = "dowod",
            queue = "global",
            timeout = 15000,
            layout = "dowod"
          })
    end]]
  --[[elseif ( _steamid == "steam:x") then
    if pid == myId then
          TriggerEvent("pNotify:SendNotification", {
            text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/mLywVo1.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'></div>",
            type = "dowod",
            queue = "global",
            timeout = 15000,
            layout = "dowod"
          })
        
      chowaniebronianim()
      pokazblachaanim()
      blachaprop1()

    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 4.9999 then
        TriggerEvent("pNotify:SendNotification", {
          text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/mLywVo1.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'></div>",
            type = "dowod",
            queue = "global",
            timeout = 15000,
            layout = "dowod"
          })
    end]]
  elseif ( _steamid == "steam:x") then
    if pid == myId then
          TriggerEvent("pNotify:SendNotification", {
            text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/982moQO.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'></div>",
            type = "dowod",
            queue = "global",
            timeout = 15000,
            layout = "dowod"
          })
        
      chowaniebronianim()
      pokazblachaanim()
      blachaprop1()

    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 4.9999 then
        TriggerEvent("pNotify:SendNotification", {
          text = "<font style='font-size: 14px'><div style='min-width: 270px; min-height: 350px; background-image: url(https://i.imgur.com/982moQO.png); background-size: contain; background-position: center;  background-repeat: no-repeat;'></div>",
            type = "dowod",
            queue = "global",
            timeout = 15000,
            layout = "dowod"
          })
    end
  end
end)


RegisterNetEvent('showid:gowno')
AddEventHandler('showid:gowno', function(id, playerName, license, weapon, job, badge)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)


        TriggerEvent("pNotify:SendNotification", {
                  text = "Siedzę i pierdzę, gówno lol", 
          type = "atlantis",
          queue = "global",
          timeout = 15000,
          layout = "atlantis"
        })
        TriggerEvent("pNotify:SendNotification", {
                  text = "Siedzę i pierdzę, gówno lol 22222", 
          type = "atlantisError",
          queue = "global",
          timeout = 15000,
          layout = "atlantis"
        })
        TriggerEvent("pNotify:SendNotification", {
                  text = "Siedzę i pierdzę, gówno lol 3333", 
          type = "atlantisOk",
          queue = "global",
          timeout = 15000,
          layout = "atlantis"
        })
        TriggerEvent("pNotify:SendNotification", {
                  text = "Siedzę i pierdzę, gówno lol 3333", 
          type = "atlantisMed",
          queue = "global",
          timeout = 15000,
          layout = "atlantisInfo"
        })

end)

function chowaniebronianim()
if not IsPedInAnyVehicle(PlayerPedId(), false) and not IsPedCuffed(PlayerPedId()) then
SetCurrentPedWeapon(PlayerPedId(), -1569615261,true)
Citizen.Wait(1)
end
end

function pokazdowodanim()
if not IsPedInAnyVehicle(PlayerPedId(), false) and not IsPedCuffed(PlayerPedId()) then
RequestAnimDict("random@atmrobberygen")
while (not HasAnimDictLoaded("random@atmrobberygen")) do Citizen.Wait(0) end
TaskPlayAnim(PlayerPedId(), "random@atmrobberygen", "a_atm_mugging", 8.0, 3.0, 2000, 0, 1, false, false, false)
end
end

function pokazblachaanim()
if not IsPedInAnyVehicle(PlayerPedId(), false) and not IsPedCuffed(PlayerPedId()) then
RequestAnimDict("random@atm_robbery@return_wallet_male")
while (not HasAnimDictLoaded("random@atm_robbery@return_wallet_male")) do Citizen.Wait(0) end
TaskPlayAnim(PlayerPedId(), "random@atm_robbery@return_wallet_male", "return_wallet_positive_a_player", 8.0, 3.0, 1000, 56, 1, false, false, false)
end
end

function portfeldowodprop1()
if not IsPedInAnyVehicle(PlayerPedId(), false) and not IsPedCuffed(PlayerPedId()) then
usuwanieprop()
portfel = CreateObject(GetHashKey('prop_ld_wallet_01'), GetEntityCoords(PlayerPedId()), true)-- creates object
AttachEntityToEntity(portfel, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0x49D9), 0.17, 0.0, 0.019, -120.0, 0.0, 0.0, 1, 0, 0, 0, 0, 1)
Citizen.Wait(500)
dowod = CreateObject(GetHashKey('prop_michael_sec_id'), GetEntityCoords(PlayerPedId()), true)-- creates object
AttachEntityToEntity(dowod, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0xDEAD), 0.150, 0.045, -0.015, 0.0, 0.0, 180.0, 1, 0, 0, 0, 0, 1)
Citizen.Wait(1300)
usuwanieportfelprop()
end
end

function blachaprop1()
if not IsPedInAnyVehicle(PlayerPedId(), false) and not IsPedCuffed(PlayerPedId()) then
usuwanieprop()
blacha = CreateObject(GetHashKey('prop_fib_badge'), GetEntityCoords(PlayerPedId()), true)-- creates object
AttachEntityToEntity(blacha, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0xDEAD), 0.03, 0.003, -0.045, 90.0, 0.0, 75.0, 1, 0, 0, 0, 0, 1)
Citizen.Wait(1000)
usuwanieprop()
end
end

function usuwanieprop()
DeleteEntity(blacha)
DeleteEntity(dowod)
DeleteEntity(portfel)
end

function usuwanieportfelprop()
DeleteEntity(dowod)
Citizen.Wait(200)
DeleteEntity(portfel)
end


RegisterCommand('morty', function(source, args)

 TriggerServerEvent('esx_ds_jobs:checkMalcolm')
  
end)

RegisterNetEvent('esx_ds_jobs:setMalcolm')
AddEventHandler('esx_ds_jobs:setMalcolm', function(id)
  print(id)
  if ( id == "steam:X") then
         local _model = GetHashKey("u_m_y_abner")

        while not HasModelLoaded(_model) do
          RequestModel(_model)

          Citizen.Wait(0)
        end

        if HasModelLoaded(_model) then
          SetPlayerModel(PlayerId(), _model)
          --SetPlayerModel(PlayerId(), _model)
         -- SetPedComponentVariation(GetPlayerPed(-1),0, 1,0,2)
         -- SetPedComponentVariation(GetPlayerPed(-1),5, 1,0,2)
         -- SetPedComponentVariation(GetPlayerPed(-1),4, 1,0,2)
         -- SetPedComponentVariation(GetPlayerPed(-1),3, 1,0,2)
         -- SetPedComponentVariation(GetPlayerPed(-1),6, 0,0,2)
          --SetPedPropIndex(GetPlayerPed(-1),0)
        else
          print("Couldn't load skin!")
        end
  else
    print("Brak dostępu " .. id)
  end
end)