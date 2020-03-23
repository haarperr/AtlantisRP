Config                            = {}

Config.DrawDistance               = 100.0

Config.NPCJobEarnings             = {min = 300, max = 600}
Config.MinimumDistance            = 3000 -- Minimum NPC job destination distance from the pickup in GTA units, a higher number prevents nearby destionations.
Config.LeatherPrice				  = 50

Config.MaxInService               = -1
Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false

Config.Locale                     = 'pl'

Config.AuthorizedVehicles = {
		
		{
			model = 'pranger',
			label = 'Ranger',
			price = 10000
		},
		
		{
			model = 'rebel',
			label = 'Rebel',
			price = 10000
		},

		{
			model = 'ablazer',
			label = 'Blazer',
			price = 10000
		}
	}

Config.Zones = {

	VehicleSpawner = {
		Pos   = {x = 377.17, y = 789.72, z = 187.62},
		Size  = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 1, g = 204, b = 0},
		Type  = 36, Rotate = true
	},

	VehicleSpawnPoint = {
		Pos     = {x = 374.11, y = 796.09, z = 186.35},
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Type    = -1, Rotate = false,
		Heading = 172.99
	},

	VehicleDeleter = {
		Pos   = {x = 374.11, y = 796.09, z = 186.35},
		Size  = {x = 3.0, y = 3.0, z = 0.25},
		Color = {r = 255, g = 0, b = 0},
		Type  = 1, Rotate = false
	},

	WoodsmanActions = {
		Pos   = {x = 378.79, y = 791.88, z = 190.40},
		Size  = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 1, g = 204, b = 0},
		Type  = 31, Rotate = true
	},
  
	Cloakroom = {
		Pos     = {x = 387.07, y = 792.18, z = 187.69},
		Size    = {x = 1.0, y = 1.0, z = 1.0},
		Color   = {r = 1, g = 204, b = 0},
		Type    = 31, Rotate = true
	},
	
	Job1 = {
		Pos   = {x = -624.9, y = -1632.0, z = 32.1},
		Size  = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r=211, g=211, b=211},
		Type  = 27, Rotate = true
	},

	Job2 = {
		Pos   = {x = -1606.71, y = 2094.11, z = 64.84},
		Size  = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r=211, g=211, b=2110},
		Type  = 27, Rotate = true
	},

	Job3 = {
		Pos   = {x = 2938.21, y = 5326.24, z = 100.35},
		Size  = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r=211, g=211, b=211},
		Type  = 27, Rotate = true
	},

	Shop = {
		Pos   = {x = 436.3, y = 2996.5, z = 40.38},
		Size  = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r=211, g=211, b=211},
		Type  = 31, Rotate = true
	}

}