local enabled = false

RegisterNetEvent('atlantisCam:display')
AddEventHandler('atlantisCam:display', function(name,value)
	if value then
		enabled = true
	else
		enabled = false
	end
  SendNUIMessage({
    officer = name,
    display = value
  })
end)

RegisterNetEvent('atlantisCam:displayZ')
AddEventHandler('atlantisCam:displayZ', function(press)
	if enabled then 
		SendNUIMessage({ pressz = press, wasenabled = enabled })
	end
end)
