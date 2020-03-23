Config              = {}
Config.DrawDistance = 100
Config.Size         = {x = 1.5, y = 1.5, z = 1.5}
Config.Color        = {r = 211, g = 211, b = 211}
Config.MarkerColor  = {r = 211, g = 211, b = 211}
Config.Type         = 27
Config.Locale       = 'pl'

Config.Zones = {

	TwentyFourSeven = {
		Name = "Sklep 24/7",
		ShowBlip = true,
		ShowMarker = true,
		BlipId = 52,
		BlipColor = 2,
		Items = {},
		Pos = {
			{x = 373.875,   y = 325.896,  z = 102.596},
			{x = 2557.458,  y = 382.282,  z = 107.652},
			{x = -3038.939, y = 585.954,  z = 6.927},
			{x = -3241.927, y = 1001.462, z = 11.85},
			{x = 547.431,   y = 2671.710, z = 41.206},
			{x = 1961.464,  y = 3740.672, z = 31.363},
			{x = 2678.916,  y = 3280.671, z = 54.261},
			{x = 1730.108,  y = 6416.145, z = 34.067},
			{x = 26.00,	y = -1347.86, z = 28.55}
		}
	},

	RobsLiquor = {
		Name = "Monopolowy",
		ShowBlip = true,
		ShowMarker = true,
		BlipId = 52,
		BlipColor = 2,
		Items = {},
		Pos = {
			{x = 1135.808,  y = -982.281,  z = 45.423},
			{x = -1222.915, y = -906.983,  z = 11.330},
			{x = -1487.553, y = -379.107,  z = 39.173},
			{x = -2968.243, y = 390.910,   z = 14.053},
			{x = 1166.024,  y = 2708.930,  z = 37.167},
			{x = 1392.562,  y = 3604.684,  z = 34.01}

		}
	},

	LTDgasoline = {
		Name = "Stacja paliw",
		ShowBlip = true,
		ShowMarker = true,
		BlipId = 52,
		BlipColor = 2,
		Items = {},
		Pos = {
			{x = -48.519,   y = -1757.514, z = 28.44},
			{x = 1163.373,  y = -323.801,  z = 68.225},
			{x = -707.501,  y = -914.260,  z = 18.235},
			{x = -1820.523, y = 792.518,   z = 137.144},
			{x = 1698.388,  y = 4924.404,  z = 41.083},
			{x = -48.519,   y = -1757.514, z = 28.421}
		}
	},

	Kluby = {
		Name = "Klub",
		ShowBlip = true,
		ShowMarker = true,
		BlipId = 93,
		BlipColor = 4,
		Items = {},
		Pos = {
			{x = 128.415,   y = -1286.022, z = 28.280}, --StripClub
			{x = -1393.409, y = -606.624,  z = 29.325}, --Tequila la
			{x = -559.906,  y = 287.093,   z = 81.182},  --Bahamamas
			{x = 1985.836,  y = 3053.816,   z = 46.315}, -- Klub w Sandy
			{x = -451.91,  y = 283.24,   z = 77.6} -- Klub komediowy
		}
	},

	--[[Wedkarski = {
		Name = "Sklep wedkarski",
		ShowBlip = false,
		ShowMarker = false,
		BlipId = 356,
		BlipColor = 15,
		Items = {},
		Pos = {
			{x = -1218.08,   y = -1516.09, z = 3.48},
			{x = -276.06,   y = 6239.34, z = 30.49}
		}
	},]]

	Woda = {
		Name = "Dystrybutor wody",
		ShowBlip = false,
		ShowMarker = false,
		BlipId = 0,
		BlipColor = 0,
		Items = {},
		Pos = {
			{x = 460.010,   y = -989.26, z = 29.8},
			{x = 439.9,   y = -990.45, z = 29.8},
			{x = 469.9,   y = -991.85, z = 24.0},
			{x = 436.02,   y = -978.85, z = 29.8},
			{x = 348.803,   y = -581.91, z = 42.4},
			{x = 112.72,   y = -1296.66, z = 28.3},
			{x = 248.03,   y = 230.94, z = 105.4},
			{x = 262.6,   y = 221.26, z = 100.8},
			{x = 251.07,   y = 207.54, z = 105.4},
			{x = 297.9,   y = -593.0, z = 42.4},
			{x = 1850.55,   y = 3685.06, z = 33.4},
			{x = -444.09,   y = 6011.08, z = 30.8},
			{x = 97.41,   y = 6620.05, z = 31.5},
			{x = 728.07,   y = -1072.65, z = 27.4}, --Warsztat
			{x = 336.94,   y = -582.31, z = 42.51}
		}
	},

	Maszyny = {
		Name = "Maszyny",
		ShowBlip = false,
		ShowMarker = false,
		BlipId = 0,
		BlipColor = 0,
		Items = {},
		Pos = {
			{x = 1641.79, y = 2520.7, z = 44.66}, -- wiezienie
			{x = 1587.741, y = 6449.793,   z = 24.414}, -- diner niedaleko sklepu paleto
			{x = -2550.062, y = 2316.532,   z = 32.315}, -- stacja pod fortem zancudo
			{x = 436.18, y = -986.532,   z = 29.8}, -- komenda
			{x = 323.1,   y = -598.83, z = 42.3}, -- szpital
			{x = -294.7,   y = -302.76, z = 9.2}, -- metro
			{x = -294.54,   y = -354.08, z = 9.2}, -- metro
			{x = -892.1,   y = -2343.24, z = -12.7}, -- metro
			{x = -874.6,   y = -2294.83, z = -12.7}, -- metro
			{x = -1066.99,   y = -2696.26, z = -8.35}, -- metro
			{x = -1100.05,   y = -2735.53, z = -8.35}, -- metro
			{x = -524.76,   y = -673.09, z = 10.9}, -- metro
			{x = -473.38,   y = -673.17, z = 10.9}, -- metro
			{x = -1337.96,   y = -488.76, z = 14.2}, -- podziemy cord
			{x = -1363.39,   y = -444.14, z = 14.1}, -- metro
			{x = -839.81,   y = -151.71, z = 19.05}, -- metro
			{x = -795.35,   y = -126.04, z = 19.05}, -- metro
			{x = 1193.39,   y = 2701.73, z = 37.25}, -- sklep z ciuchami przy komendzie
			{x = -1063.6,   y = -244.48, z = 38.8}, -- lifeinvader
			{x = 1699.51,   y = 4791.42, z = 41.02}, -- sandy obok sklepu z ubraniami
			{x = 2753.38,   y = 3478.18, z = 54.73}, -- od tego miejsca dodaje
			{x = 2558.84,   y = 2601.73, z = 37.15}, -- pod gornikiem
			{x = -1269.66,   y = -1427.62, z = 3.45}, -- obok pizzeri
			{x = -1230.99,   y = -1447.96, z = 3.35}, -- obok pizzeri
			{x = -1170.89,   y = -1574.52, z = 3.75}, -- obok pizzeri
			{x = -2074.21,   y = -330.62, z = 12.39}, -- stacja obok tarasu widokowego
			{x = 438.95,   y = -602.62, z = 27.89}, -- zajezdnia autobusów niedaleko komendy
			{x = 449.7,   y = -656.51, z = 27.49}, -- zajezdnia autobusów niedaleko komendy
			{x = 451.8,   y = -633.16, z = 27.6}, -- zajezdnia autobusów niedaleko komendy
			{x = -325.51,   y = -738.52, z = 32.99}, -- czerwony parking
			{x = -334.9,   y = -784.99, z = 37.81}, -- czerwony parking
			{x = -335.01,   y = -784.86, z = 47.51}, -- czerwony parking
			{x = -310.11,   y = -739.53, z = 33.01}, -- czerwony parking
			{x = -333.36,   y = -783.06, z = 42.65}, -- czerwony parking
			{x = -333.27,   y = -783.5, z = 33.05}, -- czerwony parking
			{x = -328.18,   y = -737.56, z = 37.85}, -- czerwony parking
			{x = -325.51,   y = -738.51, z = 42.65}, -- czerwony parking
			{x = -328.14,   y = -737.52, z = 47.45}, -- czerwony parking
			{x = 461.06,   y = -705.36, z = 26.37}, -- alejka za sklepem z ciuchami obok komendy
			{x = 286.11,   y = 195.26, z = 103.47}, -- aleja gwiazd powiedzy pacific a tatuazysta
			{x = 309.37,   y = 186.98, z = 103.01}, -- aleja gwiazd powiedzy pacific a tatuazysta
			{x = 285.11,   y = 80.66, z = 93.36}, -- parking pomiedzy pacific a sklepem z bronia
			{x = 282.27,   y = 66.19, z = 93.46}, -- parking pomiedzy pacific a sklepem z bronia
			{x = 472.69,   y = -105.48, z = 62.16}, -- parking pomiedzy tatu shopem a bankiem niedaleko pacific
			{x = 485.97,   y = -78.6, z = 76.66}, -- parking pomiedzy tatu shopem a bankiem niedaleko pacific
			{x = 1084.31,   y = -775.71, z = 57.36}, -- obok jeziorka niedaleko fryzjera pod kasynem
			{x = 800.19,   y = -3262.29, z = 5.21}, -- doki
			{x = 815.92,   y = -2971.29, z = 5.07}, -- doki
			{x = 821.25,   y = -2988.77, z = 5.07}, -- doki
			{x = -341.61,   y = -1481.14, z = 29.77}, -- nad stadionem
			{x = -244.71,   y = -1541.02, z = 30.69}, -- nad stadionem
			{x = 62.57,   y = -1576.29, z = 28.69}, -- apteka obok grovestreet
			{x = 171.58,   y = -1724.61, z = 28.49}, -- myjnia groovestreet
			{x = 566.05,   y = -1750.16, z = 28.29}, -- motelik na prawo od myjni groovestreet
			{x = -522.71,   y = 159.23, z = 70.15}, -- parking pod requilala
			{x = -692.18,   y = -730.69, z = 32.75}, -- parking nad myjnia niedaleko sklepu z lodziami
			{x = -692.16,   y = -730.67, z = 28.45}, -- parking nad myjnia niedaleko sklepu z lodziami
			{x = -692.14,   y = -749.66, z = 24.25}, -- parking nad myjnia niedaleko sklepu z lodziami
			{x = -694.38,   y = -763.41, z = 32.77}, -- parking nad myjnia niedaleko sklepu z lodziami
			{x = -533.96,   y = -1301.98, z = 25.15}, -- peron niedaleko sklepu z lodziami
			{x = -1546.91,   y = -442.31, z = 34.99}, -- obok sklepu niedaleko tarasu widokowego
			{x = -1475.35,   y = -672.05, z = 28.15}, -- motel pod bahama mama
			{x = -1710.48,   y = -1133.66, z = 12.24}, -- molo
			{x = -1692.32,   y = -1087.84, z = 12.25}, -- molo
			{x = -1695.59,   y = -1126.64, z = 12.25}, -- molo
			{x = -1655.33,   y = -1096.69, z = 12.25}, -- molo
			{x = -2956.53,   y = 446.26, z = 14.37}, -- niedaleko flecca bank z heista online
			{x = -2282.93,   y = 363.09, z = 173.67}, -- centrum handlowe niedaleko tarasu widokowego
			{x = -484.43,   y = 1104.99, z = 319.17}, -- obserwatorium
			{x = 1486.25,   y = 1134.92, z = 113.37}, -- la fuenta blanca
			{x = 644.26,   y = 265.79, z = 102.37}, -- obok parkingu pod amfiteatrem przy kasynie
			{x = 745.36,   y = 226.21, z = 86.45}, -- obok parkingu pod amfiteatrem przy kasynie
			{x = 2344.49,   y = 3127.42, z = 47.31}, -- baza zlomiarza
			{x = 913.39,   y = 3643.72, z = 31.75}, -- sandy shore kolo niczego
			{x = 1999.57,   y = 3777.77, z = 31.23}, -- automacik z jedzeniem i piciem
			{x = 107.74,   y = -737.16, z = 45.76} -- automacik z jedzeniem i piciem urzad miasta
		}
	},

	Apteka = {
		Name = "Apteka",
		ShowBlip = true,
		ShowMarker = true,
		BlipId = 51,
		BlipColor = 0,
		Items = {},
		Pos = {
			{x = -1156.69,  y = -1569.09,  z = 3.5},
			{x = 591.45,  y = 2743.9,  z = 41.2},
			{x = 69.03,  y = -1570.02,  z = 28.7},
			{x = -57.75,  y = 6523.05,  z = 30.5}
		}
	},


}
