Config                            = {}

Config.DrawDistance               = 100.0

Config.Marker                     = { type = 27, x = 1.5, y = 1.5, z = 0.5, r = 211, g = 211, b = 211, a = 100, rotate = false }

Config.ReviveReward               = 0  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = false -- enable anti-combat logging?
Config.LoadIpl                    = false -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'pl'

local second = 1000
local minute = 60 * second

Config.EarlyRespawnTimer          = 10 * minute  -- Time til respawn is available
Config.DistressCallWait						= 40 * second
Config.BleedoutTimer              = 25 * minute -- Time til the player bleeds out

Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = true

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = true
Config.EarlyRespawnFineAmount     = 400

Config.RespawnPoint = { coords = vector3(341.0, -1397.3, 32.5), heading = 48.5 }

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(299.7, -585.4, 42.9),
			sprite = 61,
			scale  = 1.1,
			color  = 0
		},

		AmbulanceActions = {
			vector3(297.1, -596.2, 42.30),
			vector3(1838.27, 3672.39, 33.30),
			vector3(-248.43, 6331.35, 31.50)
		},

		Pharmacies = {
			vector3(299.22, -597.13, 42.30),
			vector3(1840.17, 3673.45, 33.30),
			vector3(-242.96, 6325.54, 31.45)
		},

		Vehicles = {
			{
				Spawner = vector3(324.98, -558.05, 27.8),
				InsideShop = vector3(321.7, -552.6, 27.9),
				Marker = { type = 27, x = 2.0, y = 2.0, z = 1.0, r = 211, g = 211, b = 211, a = 100, rotate = false },
				SpawnPoints = {
					{ coords = vector3(319.2, -553.5, 27.9), heading = 277.6, radius = 4.0 },
					{ coords = vector3(319.3, -549.3, 27.9), heading = 269.6, radius = 4.0 },
					{ coords = vector3(325.4, -542.5, 27.9), heading = 240.6, radius = 6.0 },
					{ coords = vector3(346.4, -541.5, 27.9), heading = 261.6, radius = 6.0 }
				}
			},
			{
				Spawner = vector3(1836.42, 3668.03, 32.78),
				InsideShop = vector3(321.7, -552.6, 27.9),
				Marker = { type = 27, x = 2.0, y = 2.0, z = 1.0, r = 211, g = 211, b = 211, a = 100, rotate = false },
				SpawnPoints = {
					{ coords = vector3(1833.26, 3663.8, 33.9), heading = 207.6, radius = 4.0 }
					
				}
			},
			{
				Spawner = vector3(-258.31, 6347.53, 31.58),
				InsideShop = vector3(321.7, -552.6, 27.9),
				Marker = { type = 27, x = 2.0, y = 2.0, z = 1.0, r = 211, g = 211, b = 211, a = 100, rotate = false },
				SpawnPoints = {
					{ coords = vector3(-241.96, 6337.8, 31.4), heading = 221.9, radius = 4.0 }
					
				}
			}
		},
		Deleters = {
			vector3(340.19, -561.45, 27.80),
			vector3(1825.05, 3659.59, 33.1),
			vector3(-260.95, 6344.29, 31.5),
			vector3(351.5, -588.1, 73.2),
			vector3(-1210.82, -1798.94, 3.0)

		},
		Helicopters = {
			{
				Spawner = vector3(338.65, -587.70, 73.20),
				InsideShop = vector3(351.5, -588.1, 74.5),
				Marker = { type = 27, x = 1.5, y = 1.5, z = 1.5, r = 211, g = 211, b = 211, a = 100, rotate = false },
				SpawnPoints = {
					{ coords = vector3(351.5, -588.1, 74.5), heading = 0.0, radius = 10.0 }
				}
			}
		},
		Boats = {
			{
				Spawner = vector3(-1161.37, -1813.49, 5.05),
				InsideShop = vector3(-1159.39, -1854.62, 0.15),
				Marker = { type = 27, x = 1.5, y = 1.5, z = 1.5, r = 211, g = 211, b = 211, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(-1158.67, -1831.75, 1.0), heading = 135.93, radius = 5.0 }
				}
			}
		},

		FastTravels = {
			{
				From = vector3(327.6, -594.4, 42.3),
				To = { coords = vector3(273.7, -1359.8, 23.7), heading = 44.25 },
				Marker = { type = 27, x = 2.0, y = 2.0, z = 0.5, r = 211, g = 211, b = 211, a = 100, rotate = false }
			},

			{
				From = vector3(275.3, -1361, 23.6),
				To = { coords = vector3(325.4, -593.6, 42.4), heading = 66.5 },
				Marker = { type = 27, x = 2.0, y = 2.0, z = 0.5, r = 211, g = 211, b = 211, a = 100, rotate = false }
			},

			{
				From = vector3(310.0, -602.9, 42.4),
				To = { coords = vector3(341.07, -584.81, 73.3), heading = 244.55 },
				Marker = { type = 27, x = 1.5, y = 1.5, z = 0.5, r = 211, g = 211, b = 211, a = 100, rotate = false }
			},

			{
				
				From = vector3(338.98, -584.21, 73.20),

				From = vector3(338.98, -584.21, 72.8),

				To = { coords = vector3(308.23, -602.42, 42.4), heading = 73.32 },
				Marker = { type = 27, x = 2.0, y = 2.0, z = 0.5, r = 211, g = 211, b = 211, a = 100, rotate = false }
			},

			{
				From = vector3(319.5, -559.7, 27.8),
				To = { coords = vector3(323.6, -597.4, 42.5), heading = 59.0 },
				Marker = { type = 27, x = 1.5, y = 1.5, z = 1.0, r = 211, g = 211, b = 211, a = 100, rotate = false }
			},

			{
				From = vector3(325.42, -598.69, 42.35),
				To = { coords = vector3(319.85, -557.65, 28.0), heading = 358.0 },
				Marker = { type = 27, x = 1.5, y = 1.5, z = 1.0, r = 211, g = 211, b = 211, a = 100, rotate = false }
			}
		},

		FastTravelsPrompt = {}

	},

	SandySzpital = {

		Blip = {
			coords = vector3(1827.193, 3671.347, 6.3),
			sprite = 61,
			scale  = 1.0,
			color  = 0
		},

		AmbulanceActions = {},

		Pharmacies = {},

		Deleters = {},

		Vehicles = {},

		Helicopters = {},

		Boats = {},

		FastTravels = {},

		FastTravelsPrompt = {}

	},

	PaletoSzpital = {

		Blip = {
			coords = vector3(-253.2843, 6322.373, 39.56),
			sprite = 61,
			scale  = 1.0,
			color  = 0
		},

		AmbulanceActions = {},

		Pharmacies = {},

		Deleters = {},

		Vehicles = {},

		Helicopters = {},

		Boats = {},

		FastTravels = {},

		FastTravelsPrompt = {}

	}
}

Config.AuthorizedVehicles = {

	pielegniarz = {
		{ model = 'aems', label = 'Karetka EMS', price = 2500 },
		{ model = 'aemsscout', label = 'Landstalker EMS', price = 5000 },	
		{ model = 'aemssuv', label = 'Granger EMS', price = 10000 },
		{ model = 'aemssuv2', label = 'Cavalcade EMS', price = 13250 }	
	},

	ratmedyczny = {
		{ model = 'aems', label = 'Karetka EMS', price = 2500 },
		{ model = 'aemsscout', label = 'Landstalker EMS', price = 5000 },	
		{ model = 'aemssuv', label = 'Granger EMS', price = 10000 },
		{ model = 'aemssuv2', label = 'Cavalcade EMS', price = 13250 }			
	},

	lekarz = {
		{ model = 'aems', label = 'Karetka EMS', price = 2500 },
		{ model = 'aemsscout', label = 'Landstalker EMS', price = 5000 },	
		{ model = 'aemssuv', label = 'Granger EMS', price = 10000 },
		{ model = 'aemssuv2', label = 'Cavalcade EMS', price = 13250 }					
	},
	
	doktor = {
		{ model = 'aems', label = 'Karetka EMS', price = 2500 },
		{ model = 'aemsscout', label = 'Landstalker EMS', price = 5000 },	
		{ model = 'aemssuv', label = 'Granger EMS', price = 10000 },
		{ model = 'aemssuv2', label = 'Cavalcade EMS', price = 13250 }			
	},
	
	ordynator = {
		{ model = 'aems', label = 'Karetka EMS', price = 2500 },
		{ model = 'aemscar', label = 'Fugitive EMS', price = 4250 },
		{ model = 'aemsscout', label = 'Landstalker EMS', price = 5000 },	
		{ model = 'aemssuv', label = 'Granger EMS', price = 10000 },
		{ model = 'aemssuv2', label = 'Cavalcade EMS', price = 13250 }						
	},

	zcadyrektora = {
		{ model = 'aems', label = 'Karetka EMS', price = 2500 },
		{ model = 'aemscar', label = 'Fugitive EMS', price = 4250 },
		{ model = 'aemsscout', label = 'Landstalker EMS', price = 5000 },	
		{ model = 'aemssuv', label = 'Granger EMS', price = 10000 },
		{ model = 'aemssuv2', label = 'Cavalcade EMS', price = 13250 }						
	},
	
	boss = {
		{ model = 'aems', label = 'Karetka EMS', price = 2500 },
		{ model = 'aemscar', label = 'Fugitive EMS', price = 4250 },
		{ model = 'aemsscout', label = 'Landstalker EMS', price = 5000 },	
		{ model = 'aemssuv', label = 'Granger EMS', price = 10000 },
		{ model = 'aemssuv2', label = 'Cavalcade EMS', price = 13250 }					
	},
	
	rekrut = {
		{ model = 'blazer2', label = 'Quad LSL', price = 1750 },
		{ model = 'alsl2', label = 'Bison LSL', price = 4500 },
		{ model = 'alsl', label = 'Jeep LSL', price = 7900 },
		{ model = 'lguard', label = 'Granger LSL', price = 10000 }
	},
	
	mlodratownik = {
		{ model = 'blazer2', label = 'Quad LSL', price = 1750 },
		{ model = 'alsl2', label = 'Bison LSL', price = 4500 },
		{ model = 'alsl', label = 'Jeep LSL', price = 7900 },
		{ model = 'lguard', label = 'Granger LSL', price = 10000 }
	},

	ratownik = {
		{ model = 'blazer2', label = 'Quad LSL', price = 1750 },
		{ model = 'alsl2', label = 'Bison LSL', price = 4500 },
		{ model = 'alsl', label = 'Jeep LSL', price = 7900 },
		{ model = 'lguard', label = 'Granger LSL', price = 10000 }
	},
	
	starratownik = {
		{ model = 'blazer2', label = 'Quad LSL', price = 1750 },
		{ model = 'alsl2', label = 'Bison LSL', price = 4500 },
		{ model = 'alsl', label = 'Jeep LSL', price = 7900 },
		{ model = 'lguard', label = 'Granger LSL', price = 10000 }
	},
	
	zcakapitan = {
		{ model = 'blazer2', label = 'Quad LSL', price = 1750 },
		{ model = 'alsl2', label = 'Bison LSL', price = 4500 },
		{ model = 'alsl', label = 'Jeep LSL', price = 7900 },
		{ model = 'lguard', label = 'Granger LSL', price = 10000 }
	},
	
	kapitanlsl = {
		{ model = 'blazer2', label = 'Quad LSL', price = 1750 },
		{ model = 'alsl2', label = 'Bison LSL', price = 4500 },
		{ model = 'alsl', label = 'Jeep LSL', price = 7900 },
		{ model = 'lguard', label = 'Granger LSL', price = 10000 }
	}

}

Config.AuthorizedHelicopters = {

	pielegniarz = {},

	ratmedyczny = {
		{ model = 'medmav', label = 'Maverick EMS', price = 52500 },
		{ model = 'aemsheli', label = 'Swift EMS', price = 92500 },
	},
	
	lekarz = {
		{ model = 'medmav', label = 'Maverick EMS', price = 52500 },
		{ model = 'aemsheli', label = 'Swift EMS', price = 92500 },
	},
	
	doktor = {
		{ model = 'medmav', label = 'Maverick EMS', price = 52500 },
		{ model = 'aemsheli', label = 'Swift EMS', price = 92500 },
	},
	
	ordynator = {
		{ model = 'medmav', label = 'Maverick EMS', price = 52500 },
		{ model = 'aemsheli', label = 'Swift EMS', price = 92500 },
	},
	
	zcadyrektora = {
		{ model = 'medmav', label = 'Maverick EMS', price = 52500 },
		{ model = 'aemsheli', label = 'Swift EMS', price = 92500 },
	},
	
	boss = {
		{ model = 'medmav', label = 'Maverick EMS', price = 52500 },
		{ model = 'aemsheli', label = 'Swift EMS', price = 92500 },
	},
	
	rekrut = {
	},
	
	mlodratownik = {
	},
	
	ratownik = {
	},
	
	starratownik = {
	},
	
	zcakapitan = {
		{ model = 'alslheli', label = 'Swift LSL', price = 92500 },
	},
	
	kapitanlsl = {
		{ model = 'alslheli', label = 'Swift LSL', price = 92500 },
	}

}

Config.AuthorizedBoats = {

	pielegniarz = {
	},

	ratmedyczny = {
	},
	
	lekarz = {
	},
	
	doktor = {
	},
	
	ordynator = {
	},
	
	zcadyrektora = {
	},
	
	boss = {
	},
	
	rekrut = {
		{ model = 'seashark2', label = 'Seashark LSL', price = 1500 },
	},
	
	mlodratownik = {
		{ model = 'seashark2', label = 'Seashark LSL', price = 1500 },
		{ model = 'alsldinghy', label = 'Dinghy LSL', price = 5000 },
		{ model = 'predator2', label = 'Predator LSL', price = 12500 },
	},
	
	ratownik = {
		{ model = 'seashark2', label = 'Seashark LSL', price = 1500 },
		{ model = 'alsldinghy', label = 'Dinghy LSL', price = 5000 },
		{ model = 'predator2', label = 'Predator LSL', price = 12500 },
	},
	
	starratownik = {
		{ model = 'seashark2', label = 'Seashark LSL', price = 1500 },
		{ model = 'alsldinghy', label = 'Dinghy LSL', price = 5000 },
		{ model = 'predator2', label = 'Predator LSL', price = 12500 },
	},
	
	zcakapitan = {
		{ model = 'seashark2', label = 'Seashark LSL', price = 1500 },
		{ model = 'alsldinghy', label = 'Dinghy LSL', price = 5000 },
		{ model = 'predator2', label = 'Predator LSL', price = 12500 },
	},
	
	kapitanlsl = {
		{ model = 'seashark2', label = 'Seashark LSL', price = 1500 },
		{ model = 'alsldinghy', label = 'Dinghy LSL', price = 5000 },
		{ model = 'predator2', label = 'Predator LSL', price = 12500 },
	}

}

Config.UniformsEMS = {
	scuba_wear = {
		male = {
			['tshirt_1'] = 123,  ['tshirt_2'] = 0,
			['torso_1'] = 243,   ['torso_2'] = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 33,
			['pants_1'] = 94,   ['pants_2'] = 3,
			['shoes_1'] = 67,   ['shoes_2'] = 3,
			['glasses_1'] = 26,   ['glasses_2'] = 3,
			['chain_1'] = 0,    ['chain_2'] = 0
		},
		female = {
			['tshirt_1'] = 153,  ['tshirt_2'] = 20,
			['torso_1'] = 251,   ['torso_2'] = 20,
			['decals_1'] = 64,   ['decals_2'] = 4,
			['arms'] = 7,
			['pants_1'] = 97,   ['pants_2'] = 20,
			['shoes_1'] = 70,   ['shoes_2'] = 20,
			['glasses_1'] = 28,   ['glasses_2'] = 4,
			['chain_1'] = 0,    ['chain_2'] = 0
		}
	}

}