
-- Change this to your server name
local servername = "Sunset RP"; 

local menuEnabled = false 


RegisterCommand("gazeta", function(source, args, raw)
				ToggleActionMenu()
end, false)

RegisterCommand("gazeta2", function(source, args, raw)
				killTutorialMenu() 
end, false)


function ToggleActionMenu()
	Citizen.Trace("tutorial launch")
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
	end 
end 

function killTutorialMenu() 
SetNuiFocus( false )
		SendNUIMessage({
			showPlayerMenu = false
		})
		menuEnabled = false

end





