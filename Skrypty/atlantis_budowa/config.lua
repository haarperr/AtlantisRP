Config                            = {}

Config.DrawDistance               = 100.0

Config.czek												= 750
Config.NPCJobEarnings             = {min = 300, max = 600}
Config.MinimumDistance            = 3000 -- Minimum NPC job destination distance from the pickup in GTA units, a higher number prevents nearby destionations.

Config.MaxInService               = -1
Config.EnablePlayerManagement     = false
Config.EnableSocietyOwnedVehicles = false

Config.Locale                     = 'pl'

Config.AuthorizedVehicles = {

		{
			model = 'mixer2',
			label = 'Betoniarka',
			price = 5000
		}
	}

Config.Zones = {

	VehicleSpawner = {
		Pos   = {x = -169.17, y = -1027.17, z = 27.5},
		Size  = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 1, g = 204, b = 0},
		Type  = 36, Rotate = true
	},

	VehicleSpawnPoint = {
		Pos     = {x = -198.67, y = -1079.26, z = 21.68},
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Type    = -1, Rotate = false,
		Heading = 155.80
	},

	VehicleDeleter = {
		Pos   = {x = -113.63, y = -1014.62, z = 25.0},
		Size  = {x = 7.0, y = 7.0, z = 0.85},
		Color = {r = 255, g = 0, b = 0},
		Type  = 1, Rotate = false
	},

	BuilderActions = {
		Pos   = {x = -228.59, y = -1118.19, z = 22.52},
		Size  = {x = 1.4, y = 1.4, z = 2.0},
		Color = {r = 1, g = 204, b = 0},
		Type  = 27, Rotate = true
	},

	Cloakroom = {
		Pos     = {x = -97.01, y = -1013.98, z = 27.28},
		Size    = {x = 1.0, y = 1.0, z = 1.0},
		Color   = {r = 1, g = 204, b = 0},
		Type    = 21, Rotate = true
	},

	--BuyVehicle = {
	--	Pos   = {x = 2364.68, y = 3123.0, z = 47.41},
	--	Size    = {x = 1.0, y = 1.0, z = 1.0},
	--	Color = {r = 1, g = 5, b = 250},
	--	Type  = 36, Rotate = true
	--},
	--
	Job1xd = {
		Pos   = {x = 1266.79, y = 1908.6, z = 77.7},
		Size  = {x = 15.0, y = 15.0, z = 5.0},
		Color = {r=211, g=211, b=211},
		Type  = 1, Rotate = true
	},

	Job1 = {
		Pos   = {x = 82.77, y = -349.79, z = 41.5},  
		Size  = {x = 13.0, y = 13.0, z = 5.0},
		Color = {r=211, g=211, b=211},
		Type  = 27, Rotate = true
	},

	Job2 = {
		Pos   = {x = -143.28, y = -1032.30, z = 26.50},
		Size  = {x = 3.0, y = .0, z = 3.0},
		Color = {r=211, g=211, b=211},
		Type  = 27, Rotate = true
	},

	Job2a = {
		Pos   = {x = -147.73, y = -1034.65, z = 26.50},
		Size  = {x = 1.0, y = .0, z = 1.0},
		Color = {r=211, g=211, b=211},
		Type  = 27, Rotate = true
	},

	Job2b = {
		Pos   = {x = -174.94, y = -1029.74, z = 26.50},
		Size  = {x = 3.0, y = .0, z = 1.0},
		Color = {r=211, g=211, b=211},
		Type  = 27, Rotate = true
	}

}

Config.Blips = {
	Job1xd = {Sprite = 475},
	Job1 = {Sprite = 475},
	Job2 = {Sprite = 475},
	Job2a = {Sprite = 475},
	Job2b = {Sprite = 475}
}
