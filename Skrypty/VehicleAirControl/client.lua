local blacklistedModels = {
	"deluxo",
	"ruiner2",
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if  IsPedInAnyVehicle(GetPlayerPed(-1), true) then
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            if DoesEntityExist(veh) and not IsEntityDead(veh) then
                local model = GetEntityModel(veh)
                -- If it's not a boat, plane or helicopter, and the vehilce is off the ground with ALL wheels, then block steering/leaning left/right/up/down.
                if not IsThisModelBlacklisted(veh) and not IsThisModelABoat(model) and not IsThisModelAHeli(model) and not IsThisModelAPlane(model) and not IsThisModelABike(model) and not IsThisModelABicycle(model) and IsEntityInAir(veh) then
                    DisableControlAction(0, 59) -- leaning left/right
                    DisableControlAction(0, 60) -- leaning up/down
                end
            end
        else
            Citizen.Wait(5000)
        end
    end
end)

function IsThisModelBlacklisted(veh)
	local model = GetEntityModel(veh)

	for i = 1, #blacklistedModels do
		if model == GetHashKey(blacklistedModels[i]) then
			return true
		end
	end
	return false
end