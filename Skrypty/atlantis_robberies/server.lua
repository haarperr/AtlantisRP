--[[ Layout
	["Name"]={name="Name",
	currentMoney=500, -- starting money
	maxMoney=5000, -- maximum money the store can hold
	moneyRengerationRate=100, -- how much money is gained Per Minute
	takesMoneyToBankOnMax=true, -- If the place transfers money to bank every 30 minutes
	isBank=false, -- is the place a bank
	bankToDeliverToo="Legion Flecca Bank Vault", -- what bank to deliver to if the takesMoenyToBank is true
	},
]]

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

robbableSpots = {
	["Little Seoul 24/7 Register #1"]={name="Little Seoul 24/7 Register #1",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Legion Flecca Bank Vault",
	},

	--[[
	["Little Seoul 24/7 Register #2"]={name="Little Seoul 24/7 Register #2",
	currentMoney=2250,
	maxMoney=7500,
	moneyRengerationRate=53, -- Per Minute
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Legion Flecca Bank Vault",
	},
	]]

	["Little Seoul 24/7 Safe"]={name="Little Seoul 24/7 Safe",
	currentMoney=6000,
	maxMoney=25000,
	moneyRengerationRate=140, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Legion Flecca Bank Vault",
	},

	["Algonquin 24/7 Register"]={name="Algonquin 24/7 Register",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Route 68 Flecca Bank Vault",
	},

	["Mirror Park 24/7 Register #1"]={name="Mirror Park 24/7 Register #1",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Hawick Flecca Bank Vault",
	},
	
	--[[
	["Mirror Park 24/7 Register #2"]={name="Mirror Park 24/7 Register #2",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Hawick Flecca Bank Vault",
	},
	]]
	
	["Mirror Park 24/7 Safe"]={name="Mirror Park 24/7 Safe",
	currentMoney=6000,
	maxMoney=25000,
	moneyRengerationRate=140, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Hawick Flecca Bank Vault",
	},

	["Downtown Vinewood 24/7 Register #1"]={name="Downtown Vinewood 24/7 Register #1",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Pacific Standard Bank Vault",
	},
	
	--[[
	["Downtown Vinewood 24/7 Register #2"]={name="Downtown Vinewood 24/7 Register #2",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Pacific Standard Bank Vault",
	},
	]]
	
	["Downtown Vinewood 24/7 Safe"]={name="Downtown Vinewood 24/7 Safe",
	currentMoney=6000,
	maxMoney=25000,
	moneyRengerationRate=140, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Pacific Standard Bank Vault",
	},

	["Rockford Dr 24/7 Register #1"]={name="Rockford Dr 24/7 Register #1",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Pacific Standard Bank Vault",
	},
	
	--[[
	["Rockford Dr 24/7 Register #2"]={name="Rockford Dr 24/7 Register #2",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Grean Ocean Hwy Flecca Bank Vault",
	},
	]]
	
	["Rockford Dr 24/7 Safe"]={name="Rockford Dr 24/7 Safe",
	currentMoney=6000,
	maxMoney=25000,
	moneyRengerationRate=140, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Pacific Standard Bank Vault",
	},

	["South Senora Fwy 24/7 Register #1"]={name="South Senora Fwy 24/7 Register #1",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Route 68 Flecca Bank Vault",
	},
	
	--[[
	["South Senora Fwy 24/7 Register #2"]={name="South Senora Fwy 24/7 Register #2",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Route 68 Flecca Bank Vault",
	},
	]]
	
	["South Senora Fwy 24/7 Safe"]={name="South Senora Fwy 24/7 Safe",
	currentMoney=6000,
	maxMoney=25000,
	moneyRengerationRate=140, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Route 68 Flecca Bank Vault",
	},

	["North Senora Fwy 24/7 Register #1"]={name="North Senora Fwy 24/7 Register #1",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Blaine County Savings Vault",
	},
	
	--[[
	["North Senora Fwy 24/7 Register #2"]={name="North Senora Fwy 24/7 Register #2",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Blaine County Savings Vault",
	},
	]]
	
	["North Senora Fwy 24/7 Safe"]={name="North Senora Fwy 24/7 Safe",
	currentMoney=6000,
	maxMoney=25000,
	moneyRengerationRate=140, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Blaine County Savings Vault",
	},

	--[[
	["Route 68 24/7 Register #1"]={name="Route 68 24/7 Register #1",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Grean Ocean Hwy Flecca Bank Vault",
	},
	]]
	
	["Route 68 24/7 Register #2"]={name="Route 68 24/7 Register #2",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Pacific Standard Bank Vault",
	},
	["Route 68 24/7 Safe"]={name="Route 68 24/7 Safe",
	currentMoney=6000,
	maxMoney=25000,
	moneyRengerationRate=140, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Pacific Standard Bank Vault",
	},

	["Innocence Blvd 24/7 Register #1"]={name="Innocence Blvd 24/7 Register #1",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Legion Flecca Bank Vault",
	},
	--[[["Innocence Blvd 24/7 Register #2"]={name="Innocence Blvd 24/7 Register #2",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Legion Flecca Bank Vault",
	},]]
	["Innocence Blvd 24/7 Safe"]={name="Innocence Blvd 24/7 Safe",
	currentMoney=6000,
	maxMoney=25000,
	moneyRengerationRate=140, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Legion Flecca Bank Vault",
	},
	["Grapeseed 24/7 Register"]={name="Grapeseed 24/7 Register",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Blaine County Savings Vault",
	},
	["Grapeseed 24/7 Safe"]={name="Grapeseed 24/7 Safe",
	currentMoney=6000,
	maxMoney=25000,
	moneyRengerationRate=140, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Blaine County Savings Vault",
	},
	["Niland Ave 24/7 Register"]={name="Niland Ave 24/7 Register",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Route 68 Flecca Bank Vault",
	},
	["Niland Ave 24/7 Safe"]={name="Niland Ave 24/7 Safe",
	currentMoney=6000,
	maxMoney=25000,
	moneyRengerationRate=140, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Route 68 Flecca Bank Vault",
	},
	["Palomino Fwy 24/7 Register"]={name="Palomino Fwy 24/7 Register",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Hawick Flecca Bank Vault",
	},
	["Palomino Fwy 24/7 Safe"]={name="Palomino Fwy 24/7 Safe",
	currentMoney=6000,
	maxMoney=25000,
	moneyRengerationRate=140, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Hawick Flecca Bank Vault",
	},



	--CLUBS

	--[[
	["Bahama Mamas Cash Register #1"]={name="Bahama Mamas Cash Register #1",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Del Perro Flecca Bank Vault",
	},
	["Bahama Mamas Cash Register #2"]={name="Bahama Mamas Cash Register #2",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Del Perro Flecca Bank Vault",
	},
	["Bahama Mamas Cash Register #3"]={name="Bahama Mamas Cash Register #3",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Del Perro Flecca Bank Vault",
	},
	["Bahama Mamas Cash Register #4"]={name="Bahama Mamas Cash Register #4",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Del Perro Flecca Bank Vault",
	},
	["Bahama Mamas Cash Register #5"]={name="Bahama Mamas Cash Register #5",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Del Perro Flecca Bank Vault",
	},
	["Bahama Mamas Cash Register #6"]={name="Bahama Mamas Cash Register #6",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Del Perro Flecca Bank Vault",
	},]]

	["Tequilala Register"]={name="Tequilala Register",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Pacific Standard Bank Vault",
	},
	["Tequilala Safe"]={name="Tequilala Safe",
	currentMoney=6000,
	maxMoney=30000,
	moneyRengerationRate=140, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Pacific Standard Bank Vault",
	},









--- LIQUIOR STORES



	["Prosperity Liquor Store Register"]={name="Prosperity Liquor Store Register",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Del Perro Flecca Bank Vault",
	},
	["Prosperity Liquor Store Safe"]={name="Prosperity Liquor Store Safe",
	currentMoney=6000,
	maxMoney=25000,
	moneyRengerationRate=140, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Del Perro Flecca Bank Vault",
	},

	["El Rancho Blvd Liquor Store Register"]={name="El Rancho Blvd Liquor Store Register",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Legion Flecca Bank Vault",
	},
	["El Rancho Blvd Liquor Store Safe"]={name="El Rancho Blvd Liquor Store Safe",
	currentMoney=6000,
	maxMoney=25000,
	moneyRengerationRate=140, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Legion Flecca Bank Vault",
	},

	["Great Ocean Hwy Liquor Store Register"]={name="Great Ocean Hwy Liquor Store Register",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Legion Flecca Bank Vault",
	},
	["Great Ocean Hwy Liquor Store Safe"]={name="Great Ocean Hwy Liquor Store Safe",
	currentMoney=6000,
	maxMoney=25000,
	moneyRengerationRate=140, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Legion Flecca Bank Vault",
	},

	["Route 68 Liquor Store Register"]={name="Route 68 Liquor Store Register",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Route 68 Flecca Bank Vault",
	},
	["Route 68 Liquor Store Safe"]={name="Route 68 Liquor Store Safe",
	currentMoney=6000,
	maxMoney=25000,
	moneyRengerationRate=140, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Route 68 Flecca Bank Vault",
	},

	["San Andreas Avenue Store Register"]={name="San Andreas Avenue Store Register",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Del Perro Flecca Bank Vault",
	},
	["San Andreas Avenue Store Safe"]={name="San Andreas Avenue Store Safe",
	currentMoney=6000,
	maxMoney=25000,
	moneyRengerationRate=140, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Del Perro Flecca Bank Vault",
	},

	["Davis Avenue Store Register"]={name="Davis Avenue Store Register",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Legion Flecca Bank Vault",
	},
	["Davis Avenue Store Safe"]={name="Davis Avenue Store Safe",
	currentMoney=6000,
	maxMoney=25000,
	moneyRengerationRate=140, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Legion Flecca Bank Vault",
	},

	["Barbareno Road Register"]={name="Barbareno Road Register",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Great Ocean Hwy Flecca Bank Vault",
	},
	["Barbareno Road Safe"]={name="Barbareno Road Safe",
	currentMoney=6000,
	maxMoney=25000,
	moneyRengerationRate=140, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Great Ocean Hwy Flecca Bank Vault",
	},

	["Ineseno Road Register"]={name="Ineseno Road Register",
	currentMoney=2250,
	maxMoney=5000,
	moneyRengerationRate=53, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Great Ocean Hwy Flecca Bank Vault",
	},
	["Ineseno Road Safe"]={name="Ineseno Road Safe",
	currentMoney=6000,
	maxMoney=25000,
	moneyRengerationRate=140, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Great Ocean Hwy Flecca Bank Vault",
	},





-- bank booths

	--[[
	["Pacific Standard Bank Booth #1"]={name="Pacific Standard Bank Booth #1",
	currentMoney=9000,
	maxMoney=30000,
	moneyRengerationRate=140, -- Per Minute
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Pacific Standard Bank Vault",

	},
	]]

	["Pacific Standard Bank Booth #2"]={name="Pacific Standard Bank Booth #2",
	currentMoney=9000,
	maxMoney=30000,
	moneyRengerationRate=140, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Pacific Standard Bank Vault",
	},

	["Pacific Standard Bank Booth #3"]={name="Pacific Standard Bank Booth #3",
	currentMoney=9000,
	maxMoney=30000,
	moneyRengerationRate=140, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=true,
	isBank=false,
	bankToDeliverToo="Pacific Standard Bank Vault",
	},






	-- BANKS


	["Route 68 Flecca Bank Vault"]={name="Route 68 Flecca Bank Vault",
	currentMoney=30000,
	maxMoney=100000,
	moneyRengerationRate=280, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=false,
	isBank=true,
	bankToDeliverToo="None",
	},

	["Hawick Flecca Bank Vault"]={name="Hawick Flecca Bank Vault",
	currentMoney=30000,
	maxMoney=100000,
	moneyRengerationRate=280, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=false,
	isBank=true,
	bankToDeliverToo="None",
	},

	["West Hawick Flecca Bank Vault"]={name="West Hawick Flecca Bank Vault",
	currentMoney=30000,
	maxMoney=100000,
	moneyRengerationRate=280, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=false,
	isBank=true,
	bankToDeliverToo="None",
	},

	["Del Perro Flecca Bank Vault"]={name="Del Perro Flecca Bank Vault",
	currentMoney=30000,
	maxMoney=100000,
	moneyRengerationRate=280, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=false,
	isBank=true,
	bankToDeliverToo="None",
	},

	["Great Ocean Hwy Flecca Bank Vault"]={name="Great Ocean Hwy Flecca Bank Vault",
	currentMoney=30000,
	maxMoney=100000,
	moneyRengerationRate=280, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=false,
	isBank=true,
	bankToDeliverToo="None",
	},

	["Legion Flecca Bank Vault"]={name="Legion Flecca Bank Vault",
	currentMoney=30000,
	maxMoney=100000,
	moneyRengerationRate=280, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=false,
	isBank=true,
	bankToDeliverToo="None",
	},

	["Pacific Standard Bank Vault"]={name="Pacific Standard Bank Vault",
	currentMoney=51000,
	maxMoney=140000,
	moneyRengerationRate=370, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=false,
	isBank=true,
	bankToDeliverToo="None",
	},

	["Blaine County Savings Vault"]={name="Blaine County Savings Vault",
	currentMoney=30000,
	maxMoney=100000,
	moneyRengerationRate=280, -- Per Minute
	transferMoney=0,
	takesMoneyToBankOnMax=false,
	isBank=true,
	bankToDeliverToo="None",
	},
}


local robberystarted = false
local Cooldown = 0 
local cops = 0
local checkinglspd = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		for name,spot in pairs(robbableSpots) do
			if(spot.currentMoney<spot.maxMoney)then
				spot.currentMoney = spot.currentMoney + spot.moneyRengerationRate
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1800000)
		for name,spot in pairs(robbableSpots)do
			if(spot.isBank==false)then
				local aFourth = ESX.Math.Round(spot.currentMoney/4)
				spot.currentMoney = spot.currentMoney-aFourth
				robbableSpots[spot.bankToDeliverToo].currentMoney=robbableSpots[spot.bankToDeliverToo].currentMoney+aFourth
				if(robbableSpots[spot.bankToDeliverToo].currentMoney>robbableSpots[spot.bankToDeliverToo].maxMoney)then
					robbableSpots[spot.bankToDeliverToo].currentMoney=robbableSpots[spot.bankToDeliverToo].maxMoney
				end
			end
		end
	end
end)

RegisterServerEvent("robberies:robberyOver")
AddEventHandler("robberies:robberyOver", function(name, cooldown)
  local source = source
  local _cooldown = cooldown
  local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer ~= nil then
		TriggerClientEvent("pNotify:SendNotification", source, {text = "Łup z napadu: "..robbableSpots[name].currentMoney.."$", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
  		xPlayer.addAccountMoney('black_money', robbableSpots[name].currentMoney)
		TriggerEvent("kakozord:donies", xPlayer.name, " EVENT NAME: robberies:robberyOver , zarobek "..robbableSpots[name].currentMoney)
		robbableSpots[name].currentMoney = 0
		cops = 0
		RobberyCooldownTimer(_cooldown)
	end
end)

RegisterServerEvent("robberies:robberyOverNotification")
AddEventHandler("robberies:robberyOverNotification", function(name)
	--TriggerEvent('robberyInProgress', "^7Właśnie zakończył się napad na ^1"..name.."")
	cops = 0
end)

RegisterServerEvent("robberies:robberyCancelNotification")
AddEventHandler("robberies:robberyCancelNotification", function(name)
	robberystarted = false
	cops = 0
	--TriggerEvent('robberyInProgress', "^7Właśnie przerwano napad na ^1"..name.."")
end)

RegisterServerEvent("robberies:brakujepolicyjnychkurwe")
AddEventHandler("robberies:brakujepolicyjnychkurwe", function(name)
	cops = 0
	robberystarted = false
end)

RegisterServerEvent("robberies:zawiadomkurwypolicijne")
AddEventHandler("robberies:zawiadomkurwypolicijne", function(name, spotname, posx, posy, posz, xcops)
	local _xcops = xcops
	TriggerEvent("esx:robberystartalert", name, spotname.." ilość LSPD: ".._xcops)
	TriggerEvent('robberyInProgress', "^7[^310-90^7] W okolicach ^1"..spotname.." ^7uruchomił się cichy alarm.")
	TriggerEvent('robberyInProgressPos', posx, posy, posz)
	cops = 0
end)

RegisterServerEvent("robberies:policeCheck")
AddEventHandler("robberies:policeCheck", function(spotName, spotCops, posx, posy, posz)
local source = source
local xPlayers = ESX.GetPlayers()
local xPlayer = ESX.GetPlayerFromId(source)
local _spotCops = spotCops
local h = tonumber(os.date('%H', timestamp))
	if checkinglspd == false then
		checkinglspd = true
		print(spotName)
		if h ~= 4 or h ~= 5 or h ~= 6 or h ~= 7 or h ~= 8 or h ~= 9 then
			for i=1, #xPlayers, 1 do
		 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		 		if xPlayer.job.name == "police" then
					if xPlayer.job.grade > 0 then
						cops = cops + 1
						print(xPlayer.name)
					end
				end
			end
			Wait(1000)
			checkinglspd = false
		 	if robberystarted and Cooldown == 0 then
		 		lockedinfo()
		 		cops = 0
		 	elseif robberystarted and Cooldown > 0 then
		 		cooldowninfo()
		 		cops = 0
			elseif cops >= _spotCops then
				TriggerClientEvent("robberies:StartRobbery", source, xPlayer.name, spotName, posx, posy, posz, cops)
				cops = 0
				robberystarted = true
			elseif cops < _spotCops then
				TriggerClientEvent("pNotify:SendNotification", source, {text = "Brak odpowiedniej ilości LSPD na służbie.", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
				cops = 0
			end
		else
			TriggerClientEvent("pNotify:SendNotification", source, {text = "W tych godzinach wszystkie pieniądze są przetransportowane oraz przeliczane w Banku Rezerw Federalnych.", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
			checkinglspd = false
			cops = 0
		end
	end
end)

function cooldowninfo()	
		TriggerClientEvent("pNotify:SendNotification", source, {text = "Po ostatnich napadach w okolicy wzmociono ochronę, następny napad będzie możliwy za "..Cooldown.." Sekund", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
end

function lockedinfo()	
		TriggerClientEvent("pNotify:SendNotification", source, {text = "W tym miejscu wzmocniono ochronę ponieważ w okolicy jest już prowadzony napad.", type = "atlantis", queue = "global", timeout = 5000, layout = "atlantis"})
end

function RobberyCooldownTimer(timer)
  Cooldown = timer
  repeat
  Cooldown = Cooldown - 1
  Citizen.Wait(1000)
  until(Cooldown == 0)
  robberystarted = false
  cops = 0
end
