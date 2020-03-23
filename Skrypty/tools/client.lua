ESX                           = nil
local color = {r = 37, g = 175, b = 134, alpha = 255} -- Color of the text 
local font = 0 -- Font of the text
local time = 1000 -- Duration of the display of the text : 1000ms = 1sec
local timeAlways = true -- set it to true to keep display of the text forever
local nbrDisplaying = 0
local coordNumber = 0
local CoordArray = {}
CoordArray.X = {}
CoordArray.Y = {}
CoordArray.Z = {}
CoordArray.H = {}
local guns = {
  ['-1716189206'] = 'Knife',
  ['-2067956739'] = 'Crowbar',
  ['1737195953'] = 'Nightstick ',
  ['1317494643'] = 'Hammer ',
  ['-1786099057'] = 'Bat',
  ['-2067956739'] = 'Crowbar',
  ['1141786504'] = 'GolfClub',
  ['-102323637'] = 'Bottle',
  ['-1834847097'] = 'Dagger',
  ['-102973651'] = 'Hatchet',
  ['-656458692'] = 'KnuckleDuster',
  ['-581044007'] = 'Machete',
  ['-1951375401'] = 'Flashlight',
  ['-538741184'] = 'SwitchBlade',
  ['-1810795771'] = 'PoolCue',
  ['419712736'] = 'Wrench',
  ['-853065399'] = 'BattleAxe',
  ['940833800'] = 'WT_SHATCHET',
  ['453432689'] = 'Pistol',
  ['1593441988'] = 'CombatPistol',
  ['-1716589765'] = 'Pistol50',
  ['-1076751822'] = 'SNSPistol',
  ['-771403250'] = 'HeavyPistol',
  ['137902532'] = 'VintagePistol',
  ['-598887786'] = 'MarksmanPistol',
  ['-1045183535'] = 'Revolver',
  ['584646201'] = 'APPistol',
  ['911657153'] = 'StunGun',
  ['1198879012'] = 'FlareGun',
  ['-1746263880'] = 'DoubleAction',
  ['-1075685676'] = 'PistolMk2',
  ['-2009644972'] = 'SNSPistolMk2',
  ['-879347409'] = 'RevolverMk2',
  ['324215364'] = 'MicroSMG',
  ['-619010992'] = 'MachinePistol',
  ['736523883'] = 'SMG',
  ['-270015777'] = 'AssaultSMG',
  ['171789620'] = 'CombatPDW',
  ['-1660422300'] = 'MG',
  ['2144741730'] = 'CombatMG',
  ['1627465347'] = 'Gusenberg',
  ['-1121678507'] = 'MiniSMG',
  ['2024373456'] = 'SMGMk2',
  ['-608341376'] = 'CombatMGMk2',
  ['-1074790547'] = 'AssaultRifle',
  ['-2084633992'] = 'CarbineRifle',
  ['-1357824103'] = 'AdvancedRifle',
  ['-1063057011'] = 'SpecialCarbine',
  ['2132975508'] = 'BullpupRifle',
  ['1649403952'] = 'CompactRifle',
  ['961495388'] = 'AssaultRifleMk2',
  ['-86904375'] = 'CarbineRifleMk2',
  ['-1768145561'] = 'SpecialCarbineMk2',
  ['-2066285827'] = 'BullpupRifleMk2',
  ['100416529'] = 'SniperRifle',
  ['205991906'] = 'HeavySniper',
  ['-952879014'] = 'MarksmanRifle',
  ['177293209'] = 'HeavySniperMk2',
  ['1785463520'] = 'MarksmanRifleMk2',
  ['487013001'] = 'PumpShotgun',
  ['2017895192'] = 'SawnOffShotgun',
  ['-1654528753'] = 'BullpupShotgun',
  ['-494615257'] = 'AssaultShotgun',
  ['-1466123874'] = 'Musket',
  ['984333226'] = 'HeavyShotgun',
  ['-275439685'] = 'DoubleBarrelShotgun',
  ['317205821'] = 'SweeperShotgun',
  ['1432025498'] = 'PumpShotgunMk2',
  ['-1568386805'] = 'GrenadeLauncher',
  ['-1312131151'] = 'RPG',
  ['1119849093'] = 'Minigun',
  ['2138347493'] = 'Firework',
  ['1834241177'] = 'Railgun',
  ['1672152130'] = 'HomingLauncher',
  ['1305664598'] = 'GrenadeLauncherSmoke',
  ['125959754'] = 'CompactGrenadeLauncher',
  ['-1813897027'] = 'Grenade',
  ['741814745'] = 'StickyBomb',
  ['-1420407917'] = 'ProximityMine',
  ['-1600701090'] = 'BZGas',
  ['615608432'] = 'Molotov',
  ['101631238'] = 'FireExtinguisher',
  ['883325847'] = 'PetrolCan',
  ['1233104067'] = 'Flare',
  ['600439132'] = 'Ball',
  ['126349499'] = 'Snowball',
  ['-37975472'] = 'SmokeGrenade',
  ['-1169823560'] = 'PipeBomb',
  ['-72657034'] = 'Parachute',

  }
local known = {
    CEventNetworkEntityDamage = {[1] = 'target entity',[2] = 'source entity',[4] = 'fatal damage', [5] = 'weapon used'},
    CEventNetworkVehicleUndrivable = {},
}
AddEventHandler('gameEventTriggered', function (name, args)
    
	  --print('[DEBUG] Event: ' .. name .. ' (' .. json.encode(args) .. ')')



    local me = PlayerId()
    local myPed = PlayerPedId()
    local myVehicle = GetVehiclePedIsIn(myPed)
    if known[name] then
        local components = {}
        local unknown = {}
        for i,value in ipairs(args) do
            if known[name][i] then
                table.insert(components,string.format('%s: %s',known[name][i],value))
            else
                table.insert(components,string.format('(unknown %i): %s',i,value))
                table.insert(unknown,i..'='..value)
            end
        end
        local test = name..': '..table.concat(components,", ")
       -- print(name..': '..table.concat(components,", "))
        for i,unk in pairs(unknown) do
            TriggerEvent('chat:addMessage',{color={255,0,255},args = {name,unk}})
        end
        TriggerEvent('chat:addMessage',{color={255,0,255},args = {name,test}})
    else
        TriggerEvent('chat:addMessage',{args = {'Event',name..' '..table.concat(args, ", ")}})
    end
    print(PlayerPedId())
    if DoesEntityExist(args[1]) then
            if IsEntityAPed(args[1]) then
                print('arg1 is a ped')
            end
        end
        if DoesEntityExist(args[2]) then
            if IsEntityAPed(args[2]) then
                
                if args[2] == myPed then
                    print('arg2 is a ped (mine)'.. myPed)
                else
                    print('arg2 is a ped')
                end
            end
        end
        if GetCurrentPedWeapon(myPed,args[5]) then
            print('arg5 is my weapon ' .. args[5])
            local currentGun = nil
            for k, v in pairs( guns ) do
              if tostring(k) == tostring(args[5]) then
                currentGun = v 
                print(currentGun)
              end
            end
        end
        if args[1] == myVehicle then
            print('Vehicle!')
        end
        if args[2] == myPed then
            print('arg2 is my ped!')
        elseif args[2] == me then
            print('arg2 is my player ID')
        end


end)

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)


RegisterCommand('sg', function(source, args)
  local cNo = tonumber(args[1])
  SetEntityCoords(GetPlayerPed(-1), CoordArray.X[cNo], CoordArray.Y[cNo], CoordArray.Z[cNo])
end)

RegisterCommand('coords', function(source, args)
    local coords = GetEntityCoords(GetPlayerPed(-1))
    local heading = GetEntityHeading(GetPlayerPed(-1))
    local offset = 0
    coordNumber = coordNumber + 1

    CoordArray.X[coordNumber] = coords.x
    CoordArray.Y[coordNumber] = coords.y
    CoordArray.Z[coordNumber] = coords.z + 1
    CoordArray.H[coordNumber] = heading

    TriggerServerEvent('tools:saveCoords', coords.x, coords.y, coords.z, heading)
    DisplayMe(GetPlayerFromServerId(source), coordNumber, offset)

  
end)
RegisterCommand('malcolm', function(source, args)

 TriggerServerEvent('tools:checkMalcolm')
  
end)
function DisplayMe(mePlayer, text, offset)
    local displaying = true
    Citizen.CreateThread(function()
        Wait(time)
        if not timeAlways then
          displaying = false
        end
    end)
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        local coords = GetEntityCoords(GetPlayerPed(mePlayer), false)
        while displaying do
            Wait(0)
            
            DrawText3D(coords['x'], coords['y'], coords['z']+offset, text)
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end


function DrawText3D(x,y,z, text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())

  SetTextScale(0.40, 0.40)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
  local factor = (string.len(text)) / 370
  DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end
RegisterCommand('sethp', function(source, args)
  local ped = args[1]
  local hp = args[2]
  TriggerServerEvent('tools:setHp', ped, hp)
end)

RegisterNetEvent('tools:displayClientLog')
AddEventHandler('tools:displayClientLog', function(message)
  print(message)
end)
RegisterNetEvent('tools:setHpClient')
AddEventHandler('tools:setHpClient', function(hp)
  local _hp = hp
  SetEntityHealth(GetPlayerPed(-1), tonumber(_hp))
  Citizen.Wait(100)
end)
RegisterNetEvent('tools:setMalcolm')
AddEventHandler('tools:setMalcolm', function(id)
  print(id)
  if ( id == "steam:X") then
         local _model = GetHashKey("a_m_m_fatlatin_01")

        while not HasModelLoaded(_model) do
          RequestModel(_model)

          Citizen.Wait(0)
        end

        if HasModelLoaded(_model) then
          SetPlayerModel(PlayerId(), _model)
          SetPedComponentVariation(GetPlayerPed(-1),0, 1,0,2)
          SetPedComponentVariation(GetPlayerPed(-1),5, 1,0,2)
          SetPedComponentVariation(GetPlayerPed(-1),4, 1,0,2)
          SetPedComponentVariation(GetPlayerPed(-1),3, 1,0,2)
          SetPedComponentVariation(GetPlayerPed(-1),6, 0,0,2)
          SetPedPropIndex(GetPlayerPed(-1),0)
          print("Couldn't load skin!")
        end
  else
    print("asdasdas")
  end
end)

