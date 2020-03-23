local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

--[[ CONFIG ]]--
useCopsFiveM = true -- If you have cops FiveM you should enable this,  lets the script do cop checks
local keyToInteractWithRobbery = Keys["E"]
--[[--------]]

--[[LAYOUT

	["Name Of Store"]={name="Name Of Store",
	blip=500,  -- THE BLIP TO USE
	blipColor=6,  -- THE COLOR OF BLIP
	blipSize=0.6, -- THE SIZE OF BLIP
	x=-706.03717041016, y=-915.42755126953, z=19.215593338013, -- THE POSITION OF THE PLACE
	beingRobbed=false, -- IF IT'S BEING ROBBED
	timeToRob = 10, --HOW LONG IT TAKES TO ROB
	isSafe=false, --IF ITS A SAFE OR A REGISTER/BOOTH
	copsNeeded = 0}, -- HOW MANY COPS ARE REQUIRED TO ROB THIS ONE

]]


local robbableSpots = {

--24/7s
	["Little Seoul 24/7 Register #1"]={name="Little Seoul 24/7 Register #1",
	blip=500,
	blipColor=6,
	blipSize=0.6,
	x=-706.03717041016, y=-915.42755126953, z=19.235593338013,
	beingRobbed=false,
	timeToRob = 60,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},

--[[
	["Little Seoul 24/7 Register #2"]={name="Little Seoul 24/7 Register #2",
	blip=500,
	blipColor=6,
	blipSize=0.6,
	x=-706.0966796875, y=-913.49053955078, z=19.215593338013,
	beingRobbed=false,
	timeToRob = 60,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},
	]]

	["Little Seoul 24/7 Safe"]={name="Little Seoul 24/7 Safe",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=-709.66131591797, y=-904.18121337891, z=19.225612411499,
	beingRobbed=false,
	timeToRob = 600,
	isSafe=true,
	safeOpen=false,
	copsNeeded = 5,
	Cooldown = 1800},

	["Innocence Blvd 24/7 Register #1"]={name="Innocence Blvd 24/7 Register #1",
	blip=500,
	blipColor=6,
	blipSize=0.6,
	x=24.487377166748, y=-1347.4102783203, z=29.507039794922,
	beingRobbed=false,
	timeToRob = 60,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},
	
--[[
	["Innocence Blvd 24/7 Register #2"]={name="Innocence Blvd 24/7 Register #2",
	blip=500,
	blipColor=6,
	blipSize=0.6,
	x=24.396217346191, y=-1344.9005126953, z=29.497039794922,
	beingRobbed=false,
	timeToRob = 60,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},
	]]

	["Innocence Blvd 24/7 Safe"]={name="Innocence Blvd 24/7 Safe",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=28.154742355347, y=-1339.2623535156, z=29.527039794922,
	beingRobbed=false,
	timeToRob = 600,
	isSafe=true,
	safeOpen=false,
	copsNeeded = 5,
	Cooldown = 1800},

	["Mirror Park 24/7 Register #1"]={name="Mirror Park 24/7 Register #1",
	blip=500,
	blipColor=6,
	blipSize=0.6,
	x=1165.0561523438, y=-324.41815185547, z=69.215062866211,
	beingRobbed=false,
	timeToRob = 60,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},

--[[
	["Mirror Park 24/7 Register #2"]={name="Mirror Park 24/7 Register #2",
	blip=500,
	blipColor=6,
	blipSize=0.6,
	x=1164.6981201172, y=-322.61318969727, z=69.205062866211,
	beingRobbed=false,
	timeToRob = 60,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},
	]]

	["Mirror Park 24/7 Safe"]={name="Mirror Park 24/7 Safe",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=1159.55859375, y=-314.06265258789, z=69.215062866211,
	beingRobbed=false,
	timeToRob = 600,
	isSafe=true,
	safeOpen=false,
	copsNeeded = 5,
	Cooldown = 1800},

	["Downtown Vinewood 24/7 Register #1"]={name="Downtown Vinewood 24/7 Register #1",
	blip=500,
	blipColor=6,
	blipSize=0.6,
	x=372.47518920898, y=326.35989379883, z=103.57736810303,
	beingRobbed=false,
	timeToRob = 60,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},

--[[
	["Downtown Vinewood 24/7 Register #2"]={name="Downtown Vinewood 24/7 Register #2",
	blip=500,
	blipColor=6,
	blipSize=0.6,
	x=373.0817565918, y=328.75726318359, z=103.56636810303,
	beingRobbed=false,
	timeToRob = 60,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},
	]]

	["Downtown Vinewood 24/7 Safe"]={name="Downtown Vinewood 24/7 Safe",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=378.10330932617, y=333.29218139648, z=103.58836810303,
	beingRobbed=false,
	timeToRob = 600,
	isSafe=true,
	safeOpen=false,
	copsNeeded = 5,
	Cooldown = 1800},

	["Rockford Dr 24/7 Register #1"]={name="Rockford Dr 24/7 Register #1",
	blip=500,
	blipColor=6,
	blipSize=0.6,
	x=-1818.8961181641, y=792.91729736328, z=138.11184814453,
	beingRobbed=false,
	timeToRob = 105,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},

--[[
	["Rockford Dr 24/7 Register #2"]={name="Rockford Dr 24/7 Register #2",
	blip=500,
	blipColor=6,
	blipSize=0.6,
	x=-1820.2630615234, y=794.45971679688, z=138.0887298584,
	beingRobbed=false,
	timeToRob = 90,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},
	]]

	["Rockford Dr 24/7 Safe"]={name="Rockford Dr 24/7 Safe",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=-1829.1471191406, y=798.78505371094, z=138.20258117676,
	beingRobbed=false,
	timeToRob = 600,
	isSafe=true,
	safeOpen=false,
	copsNeeded = 5,
	Cooldown = 1800},

--[[
	["Route 68 24/7 Register #1"]={name="Route 68 24/7 Register #1",
	blip=500,
	blipColor=6,
	blipSize=0.6,
	x=549.36108398438, y=2669.0007324219, z=42.156490325928,
	beingRobbed=false,
	timeToRob = 120,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},
	]]

	["Route 68 24/7 Register #2"]={name="Route 68 24/7 Register #2",
	blip=500,
	blipColor=6,
	blipSize=0.6,
	x=549.05975341797, y=2671.443359375, z=42.167490325928,
	beingRobbed=false,
	timeToRob = 150,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},

	["Route 68 24/7 Safe"]={name="Route 68 24/7 Safe",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=546.40972900391, y=2662.9051269531, z=42.179536102295,
	beingRobbed=false,
	timeToRob = 600,
	isSafe=true,
	safeOpen=false,
	copsNeeded = 5,
	Cooldown = 1800},

	["South Senora Fwy 24/7 Register #1"]={name="South Senora Fwy 24/7 Register #1",
	blip=500,
	blipColor=6,
	blipSize=0.6,
	x=2677.9641113281, y=3279.4440917969, z=55.251130828857,
	beingRobbed=false,
	timeToRob = 150,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},

--[[
	["South Senora Fwy 24/7 Register #2"]={name="South Senora Fwy 24/7 Register #2",
	blip=500,
	blipColor=6,
	blipSize=0.6,
	x=2675.8774414063, y=3280.537109375, z=55.241130828857,
	beingRobbed=false,
	timeToRob = 120,
	isSafe=false,
	copsNeeded = 2,
	Cooldown = 300},
	]]

	["South Senora Fwy 24/7 Safe"]={name="South Senora Fwy 24/7 Safe",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=2672.8831542969, y=3286.59609375, z=55.271149902344,
	beingRobbed=false,
	timeToRob = 600,
	isSafe=true,
	safeOpen=false,
	copsNeeded = 5,
	Cooldown = 1800},

	["North Senora Fwy 24/7 Register #1"]={name="North Senora Fwy 24/7 Register #1",
	blip=500,
	blipColor=6,
	blipSize=0.6,
	x=1727.8493652344, y=6415.2983398438, z=35.047227630615,
	beingRobbed=false,
	timeToRob = 240,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},
	
--[[
	["North Senora Fwy 24/7 Register #2"]={name="North Senora Fwy 24/7 Register #2",
	blip=500,
	blipColor=6,
	blipSize=0.6,
	x=1728.8804931641, y=6417.4360351563, z=35.037227630615,
	beingRobbed=false,
	timeToRob = 200,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},
	]]

	["North Senora Fwy 24/7 Safe"]={name="North Senora Fwy 24/7 Safe",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=1734.7563232422, y=6420.7853710938, z=35.059827630615,
	beingRobbed=false,
	timeToRob = 600,
	isSafe=true,
	safeOpen=false,
	copsNeeded = 5,
	Cooldown = 1800},

	["Algonquin 24/7 Register"]={name="Algonquin 24/7 Register",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=1392.8726806641, y=3606.3913574219, z=34.99091506958,
	beingRobbed=false,
	timeToRob = 150,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},
	
	["Grapeseed 24/7 Register"]={name="Grapeseed 24/7 Register",
	blip=500,
	blipColor=6,
	blipSize=0.6,
	x=1696.6811523438, y=4923.4721679688, z=42.073690185547,
	beingRobbed=false,
	timeToRob = 180,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},

	["Grapeseed 24/7 Safe"]={name="Grapeseed 24/7 Safe",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=1707.7389550781, y=4920.13994262695, z=42.073690185547,
	beingRobbed=false,
	timeToRob =600,
	isSafe=true,
	safeOpen=false,
	copsNeeded = 5,
	Cooldown = 1800},
	
	["Niland Ave 24/7 Register"]={name="Niland Ave 24/7 Register",
	blip=500,
	blipColor=6,
	blipSize=0.6,
	x=1959.8511523438, y=3739.9121679688, z=32.353690185547,
	beingRobbed=false,
	timeToRob = 120,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},

	["Niland Ave 24/7 Safe"]={name="Niland Ave 24/7 Safe",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=1959.3789550781, y=3748.65994262695, z=32.363690185547,
	beingRobbed=false,
	timeToRob =600,
	isSafe=true,
	safeOpen=false,
	copsNeeded = 5,
	Cooldown = 1800},
	
	["Palomino Fwy 24/7 Register"]={name="Palomino Fwy 24/7 Register",
	blip=500,
	blipColor=6,
	blipSize=0.6,
	x=2557.1811523438, y=380.6721679688, z=108.633690185547,
	beingRobbed=false,
	timeToRob = 105,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},

	["Palomino Fwy 24/7 Safe"]={name="Palomino Fwy 24/7 Safe",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=2549.4089550781, y=384.88994262695, z=108.645690185547,
	beingRobbed=false,
	timeToRob =600,
	isSafe=true,
	safeOpen=false,
	copsNeeded = 5,
	Cooldown = 1800},


--LIQUIOR STORES


	["Route 68 Liquor Store Register"]={name="Route 68 Liquor Store Register",
	blip=500,
	blipColor=6,
	blipSize=0.6,
	x=1165.9134521484, y=2710.7854003906, z=38.167711029053,
	beingRobbed=false,
	timeToRob = 110,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},

	["Route 68 Liquor Store Safe"]={name="Route 68 Liquor Store Safe",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=1169.2316894531, y=2717.8447265625, z=37.167691955566,
	beingRobbed=false,
	timeToRob =600,
	isSafe=true,
	safeOpen=false,
	copsNeeded = 5,
	Cooldown = 1800},

	["El Rancho Blvd Liquor Store Register"]={name="El Rancho Blvd Liquor Store Register",
	blip=500,
	blipColor=6,
	blipSize=0.6,
	x=1134.2418212891, y=-982.54541015625, z=46.42584777832,
	beingRobbed=false,
	timeToRob = 60,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},

	["El Rancho Blvd Liquor Store Safe"]={name="El Rancho Blvd Liquor Store Safe",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=1126.8385009766, y=-980.25166503906, z=45.425802001953,
	beingRobbed=false,
	timeToRob =600,
	isSafe=true,
	safeOpen=false,
	copsNeeded = 5,
	Cooldown = 1800},

	["Prosperity Liquor Store Register"]={name="Prosperity Liquor Store Register",
	blip=500,
	blipColor=6,
	blipSize=0.6,
	x=-1486.2586669922, y=-377.96697998047, z=40.173429260254,
	beingRobbed=false,
	timeToRob = 60,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},

	["Prosperity Liquor Store Safe"]={name="Prosperity Liquor Store Safe",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=-1479.0145263672, y=-375.36979858398, z=39.1733644104,
	beingRobbed=false,
	timeToRob =600,
	isSafe=true,
	safeOpen=false,
	copsNeeded = 5,
	Cooldown = 1800},

	["Great Ocean Hwy Liquor Store Register"]={name="Great Ocean Hwy Liquor Store Register",
	blip=500,
	blipColor=6,
	blipSize=0.6,
	x=-2966.4309082031, y=390.98095703125, z=15.053313980103,
	beingRobbed=false,
	timeToRob = 110,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},

	["Great Ocean Hwy Liquor Store Safe"]={name="Great Ocean Hwy Liquor Store Safe",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=-2959.6389550781, y=387.15994262695, z=14.053292999268,
	beingRobbed=false,
	timeToRob =600,
	isSafe=true,
	safeOpen=false,
	copsNeeded = 5,
	Cooldown = 1800},

	["San Andreas Avenue Store Register"]={name="San Andreas Avenue Store Register",
	blip=500,
	blipColor=6,
	blipSize=0.6,
	x=-1221.9, y=-908.43, z=12.33,
	beingRobbed=false,
	timeToRob = 60,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},

	["San Andreas Avenue Store Safe"]={name="San Andreas Avenue Store Safe",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=-1220.77, y=-915.92, z=11.33,
	beingRobbed=false,
	timeToRob =600,
	isSafe=true,
	safeOpen=false,
	copsNeeded = 5,
	Cooldown = 1800},

	["Davis Avenue Store Register"]={name="Davis Avenue Store Register",
	blip=500,
	blipColor=6,
	blipSize=0.6,
	x=-47.71, y=-1759.34, z=29.424,
	beingRobbed=false,
	timeToRob = 60,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},

	["Davis Avenue Store Safe"]={name="Davis Avenue Store Safe",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=-43.29, y=-1748.44, z=29.424,
	beingRobbed=false,
	timeToRob =600,
	isSafe=true,
	safeOpen=false,
	copsNeeded = 5,
	Cooldown = 1800},

	["Barbareno Road Register"]={name="Barbareno Road Register",
	blip=500,
	blipColor=6,
	blipSize=0.6,
	x=-3242.27, y=999.72, z=12.835,
	beingRobbed=false,
	timeToRob = 110,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},

	["Barbareno Road Safe"]={name="Barbareno Road Safe",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=-3249.93, y=1004.43, z=12.85,
	beingRobbed=false,
	timeToRob =600,
	isSafe=true,
	safeOpen=false,
	copsNeeded = 5,
	Cooldown = 1800},

	["Ineseno Road Register"]={name="Ineseno Road Register",
	blip=500,
	blipColor=6,
	blipSize=0.6,
	x=-3038.87, y=584.32, z=7.915,
	beingRobbed=false,
	timeToRob = 110,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},

	["Ineseno Road Safe"]={name="Ineseno Road Safe",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=-3047.71, y=585.69, z=7.928,
	beingRobbed=false,
	timeToRob =600,
	isSafe=true,
	safeOpen=false,
	copsNeeded = 5,
	Cooldown = 1800},





	--CLUBS

--[[
	["Bahama Mamas Cash Register #1"]={name="Bahama Mamas Cash Register #1",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=-1380.1058349609, y=-628.9775390625, z=30.81957244873,
	beingRobbed=false,
	timeToRob = 60,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},
	]]

--[[
	["Bahama Mamas Cash Register #2"]={name="Bahama Mamas Cash Register #2",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=-1376.9339599609, y=-626.81805419922, z=30.81957244873,
	beingRobbed=false,
	timeToRob = 60,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},
	]]

--[[
	["Bahama Mamas Cash Register #3"]={name="Bahama Mamas Cash Register #3",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=-1373.8851318359, y=-624.92364501953, z=30.81957244873,
	beingRobbed=false,
	timeToRob = 60,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},
	]]
	

	--[[
	["Bahama Mamas Cash Register #4"]={name="Bahama Mamas Cash Register #4",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=-1390.2648925781, y=-600.50628662109, z=30.319549560547,
	beingRobbed=false,
	timeToRob = 10,
	isSafe=true,
	copsNeeded = 0},
	--]]

	--[[
	["Bahama Mamas Cash Register #5"]={name="Bahama Mamas Cash Register #5",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=-1391.0942382813, y=-605.47589111328, z=30.319557189941,
	beingRobbed=false,
	timeToRob = 10,
	isSafe=true,
	copsNeeded = 0},
	--]]

	--[[
	["Bahama Mamas Cash Register #6"]={name="Bahama Mamas Cash Register #6",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=-1387.6446533203, y=-607.12426757813, z=30.340551376343,
	beingRobbed=false,
	timeToRob = 10,
	isSafe=true,
	copsNeeded = 0},
	--]]

	["Tequilala Register"]={name="Tequilala Register",
	blip=500,
	blipColor=6,
	blipSize=0.6,
	x=-562.11359863281, y=287.37929443359, z=82.186669311523,
	beingRobbed=false,
	timeToRob = 70,
	isSafe=false,
	copsNeeded = 3,
	Cooldown = 300},
	

	["Tequilala Safe"]={name="Tequilala Safe",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=-576.08080566406, y=291.31901977539, z=79.186681518555,
	beingRobbed=false,
	timeToRob = 600,
	isSafe=true,
	safeOpen=false,
	copsNeeded = 5,
	Cooldown = 1800},

	-- BANK BOOTHS

	--[[
	["Pacific Standard Bank Booth #1"]={name="Pacific Standard Bank Booth #1",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=242.81385803223, y=226.59515380859, z=106.28727722168,
	beingRobbed=false,
	timeToRob = 60,
	isSafe=false,
	copsNeeded = 2,
	Cooldown = 300},
	]]

	["Pacific Standard Bank Booth #2"]={name="Pacific Standard Bank Booth #2",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=247.9873046875, y=224.75602722168, z=106.28736877441,
	beingRobbed=false,
	timeToRob = 60,
	isSafe=false,
	copsNeeded = 8,
	Cooldown = 300},

	["Pacific Standard Bank Booth #3"]={name="Pacific Standard Bank Booth #3",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=252.95489501953, y=222.85342407227, z=106.28684234619,
	beingRobbed=false,
	timeToRob = 60,
	isSafe=false,
	copsNeeded = 8,
	Cooldown = 300},

	--BANKS

	["Route 68 Flecca Bank Vault"]={name="Route 68 Flecca Bank Vault",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=1176.0001904297, y=2711.6484375, z=38.098001251221,
	beingRobbed=false,
	timeToRob = 900,
	isSafe=true,
	safeOpen=true,
	copsNeeded = 7,
	Cooldown = 5400},

	["Pacific Standard Bank Vault"]={name="Pacific Standard Bank Vault",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=254.30894470215, y=225.26997375488, z=101.8856942749,
	beingRobbed=false,
	timeToRob = 900,
	isSafe=true,
	safeOpen=true,
	copsNeeded = 8,
	Cooldown = 5400},

	["Legion Flecca Bank Vault"]={name="Legion Flecca Bank Vault",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=147.31576049805, y=-1044.9703173828, z=29.378032455444,
	beingRobbed=false,
	timeToRob = 900,
	isSafe=true,
	safeOpen=true,
	copsNeeded = 7,
	Cooldown = 5400},

	["Del Perro Flecca Bank Vault"]={name="Del Perro Flecca Bank Vault",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=-1211.2392578125, y=-335.38189697266, z=37.79101348877,
	beingRobbed=false,
	timeToRob = 900,
	isSafe=true,
	safeOpen=true,
	copsNeeded = 7,
	Cooldown = 5400},

	["Hawick Flecca Bank Vault"]={name="Hawick Flecca Bank Vault",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=311.76455688477, y=-283.31527709961, z=54.17475677490,
	beingRobbed=false,
	timeToRob = 900,
	isSafe=true,
	safeOpen=true,
	copsNeeded = 7,
	Cooldown = 5400},

	["West Hawick Flecca Bank Vault"]={name="West Hawick Flecca Bank Vault",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=-353.5, y=-54.15, z=49.04,
	beingRobbed=false,
	timeToRob = 900,
	isSafe=true,
	safeOpen=true,
	copsNeeded = 7,
	Cooldown = 5400},

	["Great Ocean Hwy Flecca Bank Vault"]={name="Great Ocean Hwy Flecca Bank Vault",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=-2957.71, y=481.75, z=15.7,
	beingRobbed=false,
	timeToRob = 900,
	isSafe=true,
	safeOpen=true,
	copsNeeded = 7,
	Cooldown = 5400},

	["Blaine County Savings Vault"]={name="Blaine County Savings Vault",
	blip=500,
	blipColor=6,
	blipSize=0.8,
	x=-106.27449371338, y=6477.8861523438, z=31.646726150513,
	beingRobbed=false,
	timeToRob = 900,
	isSafe=true,
	safeOpen=true,
	copsNeeded = 7,
	Cooldown = 5400},

}

local distanceForMarkerToShow = 15
local distanceToInteractWithMarker = 1.0

local inCircle=false
local isRobbing=false
local spotBeingRobbed = nil
local robbCooldown = false
local spamLock = false

Citizen.CreateThread(function()
	--Setup the blips for all the locations.
	for name,robbableSpot in pairs(robbableSpots)do
        local blip = AddBlipForCoord(robbableSpot.x,robbableSpot.y,robbableSpot.z)
        SetBlipSprite(blip, robbableSpot.blip)
        SetBlipColour(blip, robbableSpot.blipColor)
        SetBlipScale(blip, robbableSpot.blipSize)
        SetBlipAsShortRange(blip, true)
				SetBlipDisplay(blip, 0)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(name)
        EndTextCommandSetBlipName(blip)
	end

	while true do
		local x,y,z = table.unpack( GetEntityCoords( GetPlayerPed(-1), false ) )

		for name,robbableSpot in pairs(robbableSpots)do
			if(Vdist(x,y,z,robbableSpot.x,robbableSpot.y,robbableSpot.z)<distanceForMarkerToShow and isRobbing==false and robbableSpot.beingRobbed==false and spamLock==false)then
				DrawMarker(27, robbableSpot.x,robbableSpot.y,robbableSpot.z-1, 0, 0, 0, 0, 0, 0, 0.75,0.75,0.5, 255, 0, 0,255, 0, 0, 0,0)
				if(Vdist(x,y,z,robbableSpot.x,robbableSpot.y,robbableSpot.z)<distanceToInteractWithMarker)then
					spotBeingRobbed=robbableSpot
					if(robbableSpot.isSafe)then
						DisplayHelpText("Nacisnij ~INPUT_CONTEXT~ aby zaczac rabowanie sejfu.")
					else
						DisplayHelpText("Nacisnij ~INPUT_CONTEXT~ aby zaczac rabowanie kasetki.")
					end
					if(IsControlJustPressed(1, keyToInteractWithRobbery)) then
						if(robbableSpot.isSafe)then
							if IsPedArmed(PlayerPedId(), 4) then
								if bagcheck() then
									if robbableSpot.safeOpen then
										TriggerServerEvent("robberies:policeCheck", spotBeingRobbed.name, spotBeingRobbed.copsNeeded, spotBeingRobbed.x, spotBeingRobbed.y, spotBeingRobbed.z)
									else
										TriggerEvent("safecracking:start")
									end
								else
									TriggerEvent("pNotify:SendNotification", {text = "Do czego chcesz chować kase?", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
								end
							else
								TriggerEvent("pNotify:SendNotification", {text = "Rabowanie bez dobrej giwery w łapie? co ty zwariowałeś...", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
							end
						else
							if IsPedArmed(PlayerPedId(), 7) then
								TriggerServerEvent("robberies:policeCheck", spotBeingRobbed.name, spotBeingRobbed.copsNeeded, spotBeingRobbed.x, spotBeingRobbed.y, spotBeingRobbed.z)
							else
								TriggerEvent("pNotify:SendNotification", {text = "Rabowanie bez kija albo kosy w łapie? co ty zwariowałeś...", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
							end
						end
					end
				else
					if(isRobbing)then
						CancelRobbery()

					end
				end
			end
		end

		if IsControlJustPressed(0, 73) or (IsControlJustPressed(1, keyToInteractWithRobbery)) then
			if isRobbing then
				CancelRobbery()
				TriggerEvent("pNotify:SendNotification", {text = "Przerwales rabowanie...", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
				FreezeEntityPosition(GetPlayerPed(-1),false)
			end
		end

		Citizen.Wait(0)
	end
end)


RegisterNetEvent("robberies:StartRobbery")
AddEventHandler("robberies:StartRobbery", function(name, spotName, posx, posy, posz, cops)
	Citizen.CreateThread(function()
		--if(cops>=spotBeingRobbed.copsNeeded)then
			TriggerServerEvent("robberies:zawiadomkurwypolicijne", name, spotName, posx, posy, posz, cops)
			local draw3dtextpos = GetEntityCoords(PlayerPedId(), false)
			TaskPlayAnim(GetPlayerPed(-1),"mini@repair","fixing_a_player", 8.0, 8.0, -1, 1, 0, 0, 0, 0)
			isRobbing=true
			spotBeingRobbed.beingRobbed=true
			robbableSpots[spotBeingRobbed.name]=spotBeingRobbed
		--	TriggerServerEvent("robberies:syncSpots", robbableSpots)
			FreezeEntityPosition(GetPlayerPed(-1), true)
			if(spotBeingRobbed.isSafe)then
				loadAnimDict('anim@heists@ornate_bank@grab_cash')
				SetCurrentPedWeapon(PlayerPedId(), -1569615261,true)
				Citizen.Wait(1)
			    TaskPlayAnim(PlayerPedId(), 'anim@heists@ornate_bank@grab_cash', 'grab', 8.0, 3.0, -1, 1, 1, false, false, false)
				FreezeEntityPosition(GetPlayerPed(-1),true)
			else
				loadAnimDict('oddjobs@shop_robbery@rob_till')
				SetCurrentPedWeapon(PlayerPedId(), -1569615261,true)
				Citizen.Wait(1)
			    TaskPlayAnim(PlayerPedId(), 'oddjobs@shop_robbery@rob_till', 'loop', 8.0, 3.0, -1, 1, 1, false, false, false)
				FreezeEntityPosition(GetPlayerPed(-1),true)
			end
			local currentSecondCount = 0
			Citizen.CreateThread(function()
				while isRobbing do
					if(spotBeingRobbed.isSafe)then
						if bagcheck() then
							DrawText3Ds(draw3dtextpos.x, draw3dtextpos.y, draw3dtextpos.z, "Rabujesz sejf! Do konca pozostalo: ~b~"..spotBeingRobbed.timeToRob-currentSecondCount.." ~s~sekund")
							    if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@ornate_bank@grab_cash', 'grab', 3) then
      								TaskPlayAnim(PlayerPedId(), 'anim@heists@ornate_bank@grab_cash', 'grab', 8.0, 3.0, -1, 1, 1, false, false, false)
    							end
						else
							CancelRobbery()
						end
					else
						DrawText3Ds(draw3dtextpos.x, draw3dtextpos.y, draw3dtextpos.z, "Rabujesz kase! Do konca pozostalo: ~b~"..spotBeingRobbed.timeToRob-currentSecondCount.." ~s~sekund")
						    if not IsEntityPlayingAnim(PlayerPedId(), 'oddjobs@shop_robbery@rob_till', 'loop', 3) then
      							TaskPlayAnim(PlayerPedId(), 'oddjobs@shop_robbery@rob_till', 'loop', 8.0, 3.0, -1, 1, 1, false, false, false)
    						end
					end
					Citizen.Wait(0)
				end
			end)
			while isRobbing do
				currentSecondCount = currentSecondCount + 1
				if(currentSecondCount==spotBeingRobbed.timeToRob)then
					if(spotBeingRobbed.isSafe)then
						RobberyOver()
						TriggerServerEvent('atlantisStatus:remove', 1000)
					else
						RobberyOver()
						TriggerServerEvent('atlantisStatus:remove', 50)
					end
				end
				Citizen.Wait(1000)
			end
		--[[else
			niemakurwowpolicyjnych()
			TriggerEvent("pNotify:SendNotification", {text = "Brak odpowiedniej ilości LSPD na służbie.", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})

		end]]
	end)
end)

function StopRobbery()
	isRobbing=false
	spotBeingRobbed.beingRobbed=false
	robbableSpots[spotBeingRobbed.name]=spotBeingRobbed
	TriggerServerEvent("robberies:robberyOverNotification", spotBeingRobbed.name)
	spotBeingRobbed=nil
	FreezeEntityPosition(GetPlayerPed(-1), false)
	ClearPedTasksImmediately(GetPlayerPed(-1))
end

function CancelRobbery()
	robbCooldown=false
	isRobbing=false
	spotBeingRobbed.beingRobbed=false
	robbableSpots[spotBeingRobbed.name]=spotBeingRobbed
	TriggerServerEvent("robberies:robberyCancelNotification", spotBeingRobbed.name)
	spotBeingRobbed=nil
	FreezeEntityPosition(GetPlayerPed(-1), false)
	ClearPedTasksImmediately(GetPlayerPed(-1))
end

function niemakurwowpolicyjnych()
	robbCooldown=false
	isRobbing=false
	spotBeingRobbed.beingRobbed=false
	robbableSpots[spotBeingRobbed.name]=spotBeingRobbed
	TriggerServerEvent("robberies:brakujepolicyjnychkurwe", spotBeingRobbed.name)
	spotBeingRobbed=nil
	FreezeEntityPosition(GetPlayerPed(-1), false)
	ClearPedTasksImmediately(GetPlayerPed(-1))
end

function RobberyOver()
	spotBeingRobbed.safeOpen=false
	TriggerServerEvent("robberies:robberyOver", spotBeingRobbed.name, spotBeingRobbed.Cooldown)
	StopRobbery()
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 0, -1)
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end
local bag
function bagcheck()
	TriggerEvent('skinchanger:bagcheck', function(have)
		if have then
			bag = true
		else
			bag = false
		end
	end)
	if bag then
		return true
	else
		return false
	end
end

function DrawText3Ds(x,y,z, text)
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

RegisterNetEvent("safecracking:start")
AddEventHandler("safecracking:start", function()
	TriggerEvent("safecracking:loop",10)
end)

cracking = false
RegisterNetEvent("safecracking:loop")
AddEventHandler("safecracking:loop", function()
	loadSafeTexture()
	loadSafeAudio()
	difficultySetting = {}
	difficulty = 3
	for z = 1, difficulty do
		difficultySetting[z] = 1
	end
	curLock = 1
	factor = difficulty
	i = 0.0
	safelock = 0
	desirednum = math.floor(math.random(99))
	if desirednum == 0 then desirednum = 1 end
	openString = "lock_open"
	closedString = "lock_closed"
	cracking = true
	spamLock = true
	mybasepos = GetEntityCoords(GetPlayerPed(-1))
	dicks = 1
	local pinfall = false
	SetCurrentPedWeapon(PlayerPedId(), -1569615261,true)
	Citizen.Wait(1)
	FreezeEntityPosition(GetPlayerPed(-1),true)
	while cracking do

		DisplayHelpText("~INPUT_CELLPHONE_LEFT~ w lewo | ~INPUT_CELLPHONE_RIGHT~ w prawo | ~INPUT_VEH_EXIT~ otwórz") 
		DisableControlAction(38, 0, true)
		DisableControlAction(44, 0, true)
		DisableControlAction(75, 0, true)

		if IsControlPressed(1, 308) then
			if dicks > 1 then
				i = i + 1.8
				PlaySoundFrontend( 0, "TUMBLER_TURN", "SAFE_CRACK_SOUNDSET", true );

				dicks = 0
				crackingsafeanim(1)
			end
		end

		if IsControlPressed(1, 307) then

			if dicks > 1 then
				i = i - 1.8
				PlaySoundFrontend( 0, "TUMBLER_TURN", "SAFE_CRACK_SOUNDSET", true );
				dicks = 0
				crackingsafeanim(1)
			end
		end

		dicks = dicks + 0.2
		Citizen.Wait(1)

		if i < 0.0 then i = 360.0 end
		if i > 360.0 then i = 0.0 end

		safelock = math.floor(100-(i / 3.6))

		if GetDistanceBetweenCoords(mybasepos, GetEntityCoords(GetPlayerPed(-1))) > 1 or curLock > difficulty then
			spamLock = false
			FreezeEntityPosition(GetPlayerPed(-1),false)
			cracking = false
		end

		if IsControlJustPressed(0, 73) then
			spamLock = false
			FreezeEntityPosition(GetPlayerPed(-1),false)
			cracking = false
		end

		if IsDisabledControlPressed(1, 75) and safelock ~= desirednum then
			Citizen.Wait(1000)
		end

		if safelock == desirednum then

			if not pinfall then
				PlaySoundFrontend( 0, "TUMBLER_PIN_FALL", "SAFE_CRACK_SOUNDSET", true );
				pinfall = true
			end

			if IsDisabledControlPressed(1, 75) then
				pinfall = false
				PlaySoundFrontend( 0, "TUMBLER_RESET", "SAFE_CRACK_SOUNDSET", true );
				factor = factor / 2
				i = 0.0
				safelock = 0
				desirednum = math.floor(math.random(99))
				crackingsafeanim(3)
				if desirednum == 0 then desirednum = 1 end
				difficultySetting[curLock] = 0
				curLock = curLock + 1
			end

		else
			pinfall = false
		end

		DrawSprite( "MPSafeCracking", "Dial_BG", 0.65, 0.5, 0.18, 0.32, 0, 255, 255, 211, 255 )
		DrawSprite( "MPSafeCracking", "Dial", 0.65, 0.5, 0.09, 0.16, i, 255, 255, 211, 255 )



		addition = 0.45
		xaddition = 0.58
		for x = 1, difficulty do

			if difficultySetting[x] ~= 1 then
				DrawSprite( "MPSafeCracking", openString, xaddition, addition, 0.012, 0.024, 0, 255, 255, 211, 255 )
			else
				DrawSprite( "MPSafeCracking", closedString, xaddition, addition, 0.012, 0.024, 0, 255, 255, 211, 255 )
			end

			addition = addition + 0.05

			if x == 10 or x == 20 or x == 30 then
				addition = 0.25
				xaddition = xaddition + 0.05
			end

		end

		--factor = factor / factor
		-- if factor < 1 then factor = 0.5 end

	end

	if curLock > difficulty then
		spotBeingRobbed.safeOpen = true
		TriggerServerEvent("robberies:policeCheck", spotBeingRobbed.name, spotBeingRobbed.copsNeeded, spotBeingRobbed.x, spotBeingRobbed.y, spotBeingRobbed.z)
		Wait(2000)
		spamLock = false
	end
	resetAnim()

end)

animsIdle = {}
animsIdle[1] = "idle_base"
animsIdle[2] = "idle_heavy_breathe"
animsIdle[3] = "idle_look_around"

animsSucceed = {}
animsSucceed[1] = "dial_turn_succeed_1"
animsSucceed[2] = "dial_turn_succeed_2"
animsSucceed[3] = "dial_turn_succeed_3"
animsSucceed[4] = "dial_turn_succeed_4"


function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

function resetAnim()
	 local player = GetPlayerPed( -1 )
	ClearPedSecondaryTask(player)
end

function crackingsafeanim(animType)
    local player = GetPlayerPed( -1 )
  	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( "mini@safe_cracking" )


        if animType == 1 then

			if IsEntityPlayingAnim(player, "mini@safe_cracking", "dial_turn_anti_fast_1", 3) then
				--ClearPedSecondaryTask(player)
			else
				TaskPlayAnim(player, "mini@safe_cracking", "dial_turn_anti_fast_1", 8.0, -8, -1, 49, 0, 0, 0, 0)
			end	

	    end

        if animType == 2 then
	        TaskPlayAnim( player, "mini@safe_cracking", animsIdle[math.floor(math.ceil(4))], 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	    end

        if animType == 3 then
	        TaskPlayAnim( player, "mini@safe_cracking", animsSucceed[math.floor(math.ceil(4))], 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	    end	

    end
end

function loadSafeTexture()
	RequestStreamedTextureDict( "MPSafeCracking", false );
	while not HasStreamedTextureDictLoaded( "MPSafeCracking" ) do
		Citizen.Wait(0)
	end
end

function loadSafeAudio()
	RequestAmbientAudioBank( "SAFE_CRACK", false )
end

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
