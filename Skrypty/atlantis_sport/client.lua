local football = false
local rugby = false

RegisterCommand("sport", function(source, args)
    if args[1] == '1' then
      if not rugby then
        DisplayHelpText('~r~Rugby ~w~| ~g~Football')
        football = true
      end
    elseif args[1] == '2' then
      if not football then
        DisplayHelpText('~r~Football ~w~| ~g~Rugby')
        rugby = true
      end
    elseif args[1] == '3' then
      football = false
      rugby = false
      DisplayHelpText('~r~Football ~w~| ~r~Rugby')
    elseif args[1] == 'ball' then
      if args[2] == 'football' then
        LoadModel('p_ld_soc_ball_01')
        local ball = CreateObject(GetHashKey('p_ld_soc_ball_01'), GetEntityCoords(PlayerPedId()), true)
        NetworkRequestControlOfEntity(ball)
      elseif args[2] == 'rugby' then
        LoadModel('p_ld_am_ball_01')
        local ball = CreateObject(GetHashKey('p_ld_am_ball_01'), GetEntityCoords(PlayerPedId()), true)
        NetworkRequestControlOfEntity(ball)
      end
    end
end, false)

Citizen.CreateThread(function()
  while true do
    local sleep = 500
    if football == true then
      local ped = PlayerPedId()
      local pedCoords = GetEntityCoords(ped)
      local closestObject = GetClosestObjectOfType(pedCoords, 80.0, GetHashKey('p_ld_soc_ball_01'), false)

      if DoesEntityExist(closestObject) then
        if GetEntityLodDist(closestObject) < 100 then
          SetEntityLodDist(closestObject, 100)
        end
        sleep = 5

        local ballCoords = GetEntityCoords(closestObject)

        if GetDistanceBetweenCoords(pedCoords, ballCoords, true) <= 80.0 then
          DrawMarker(27,ballCoords.x,ballCoords.y,ballCoords.z-0.10, 0, 0, 0, 0, 0, 0, 0.35, 0.35, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0) 
        end

        if GetDistanceBetweenCoords(pedCoords, ballCoords, true) <= 1.2 then

          if IsControlJustPressed(0, 38) then
              NetworkRequestControlOfEntity(closestObject)
              dupa = GetEntityVelocity(PlayerPedId())
              power = 3.0 
              SetEntityVelocity(closestObject, dupa.x*power, dupa.y*power, dupa.z)
          end

          if IsControlJustPressed(0, 23) then
              NetworkRequestControlOfEntity(closestObject)
              dupa = GetEntityVelocity(PlayerPedId())
              power = math.random(3,5)
              zPower = math.random(15,25) 
              SetEntityVelocity(closestObject, dupa.x*power, dupa.y*power, 0.6*zPower)
          end

          if IsControlJustPressed(0, 47) then
              PickUpBall(closestObject)
          end

        end
      end
    end
    Citizen.Wait(sleep)
  end
end)

Citizen.CreateThread(function()
  while true do
    local sleep = 500
    if rugby == true then
      local ped = PlayerPedId()
      local pedCoords = GetEntityCoords(ped)

      local closestObject = GetClosestObjectOfType(pedCoords, 10.0, GetHashKey('p_ld_am_ball_01'), false)

      if DoesEntityExist(closestObject) then
        if GetEntityLodDist(closestObject) < 100 then
          SetEntityLodDist(closestObject, 100)
        end
        sleep = 5

        local ballCoords = GetEntityCoords(closestObject)

        if GetDistanceBetweenCoords(pedCoords, ballCoords, true) <= 2.0 then
          DrawText3Ds(ballCoords, "~b~[E] ~w~Aby podnieść piłkę.", 0.4)
          DrawMarker(27,ballCoords.x,ballCoords.y,ballCoords.z-0.10, 0, 0, 0, 0, 0, 0, 0.35, 0.35, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0) 

          if IsControlJustPressed(0, 38) then
            PickUpBall(closestObject)
          end
        end
      end
    end
    Citizen.Wait(sleep)
  end
end)

PickUpBall = function(ballObject)
  NetworkRequestControlOfEntity(ballObject)

  LoadAnim("anim@sports@ballgame@handball@")

  AttachEntityToEntity(ballObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 36029), 0.03, 0.05, 0.05, 195.0, 180.0, 180.0, 0.0, false, false, true, false, 2, true)

  while IsEntityAttachedToEntity(ballObject, PlayerPedId()) do
    Citizen.Wait(5)

    if not IsEntityPlayingAnim(PlayerPedId(), 'anim@sports@ballgame@handball@', 'ball_idle', 3) then
      TaskPlayAnim(PlayerPedId(), 'anim@sports@ballgame@handball@', 'ball_idle', 8.0, 8.0, -1, 50, 0, false, false, false)
    end

    if IsPedDeadOrDying(PlayerPedId()) then
      DetachEntity(ballObject, true, true)
    end

    if IsPedInAnyVehicle(PlayerPedId(), true) then
      DetachEntity(ballObject, true, true)
    end

    if IsPedRagdoll(PlayerPedId()) then
      DetachEntity(ballObject, true, true)
    end

    if IsControlJustPressed(0, 73) then
      DetachEntity(ballObject, true, true)
    end

    if IsControlJustPressed(0, 38) then
        DetachEntity(ballObject, true, true)
        dupa = GetEntityVelocity(PlayerPedId())
        power = math.random(3,5)
        zPower = math.random(15,25) 
        SetEntityVelocity(ballObject, dupa.x*power, dupa.y*power, 0.6*zPower)
    end
  end
end

DrawText3Ds = function(coords, text, scale)
  local x,y,z = coords.x, coords.y, coords.z
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

  SetTextScale(scale, scale)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextEntry("STRING")
  SetTextCentre(1)
  SetTextColour(255, 255, 255, 215)

  AddTextComponentString(text)
  DrawText(_x, _y)

  local factor = (string.len(text)) / 370

  DrawRect(_x, _y + 0.0150, 0.030 + factor, 0.025, 41, 11, 41, 100)
end

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 0, -1)
end

LoadAnim = function(dict)
  while not HasAnimDictLoaded(dict) do
    RequestAnimDict(dict)
    
    Citizen.Wait(1)
  end
end

LoadModel = function(model)
  while not HasModelLoaded(model) do
    RequestModel(model)
    
    Citizen.Wait(1)
  end
end
