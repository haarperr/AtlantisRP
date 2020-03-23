Config                            = {}

Config.DrawDistance               = 25.0

Config.NPCJobEarnings             = {min = 300, max = 600}
Config.MinimumDistance            = 3000 -- Minimum NPC job destination distance from the pickup in GTA units, a higher number prevents nearby destionations.
Config.JobPay					  = {min = 1825, max = 2025}

Config.MaxInService               = -1
Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false

Config.Locale                     = 'pl'

Config.AuthorizedVehicles = {
		
		{
			model = 'phantom',
			label = 'Phantom',
			price = 10000
		},

	}

Config.Zones = {

	VehicleSpawner = {
		Pos   = {x = 157.15, y = -3102.65, z = 7.03},
		Size  = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 1, g = 204, b = 0},
		Type  = 39, Rotate = true
	},

	VehicleSpawnPoint = {
		Pos     = {x = 166.2, y = -3085.45, z = 5.88},
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Type    = -1, Rotate = false,
		Heading = 269.48
	},
  
	VehicleDeleter = {
		Pos   = {x = 165.39, y = -3078.52, z = 4.90},
		Size  = {x = 3.0, y = 3.0, z = 0.25},
		Color = {r = 255, g = 0, b = 0},
		Type  = 1, Rotate = false
	},
  
	TruckerActions = {
		Pos   = {x = 143.86, y = -3111.27, z = 5.89},
		Size  = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 1, g = 204, b = 0},
		Type  = 20, Rotate = true
	},

	Cloakroom = {
		Pos     = {x = 152.92, y = -3113.09, z = 5.9},
		Size    = {x = 1.0, y = 1.0, z = 1.0},
		Color   = {r = 1, g = 204, b = 0},
		Type    = 21, Rotate = true
	},
	
	Job1 = {
		Pos   = {x = 167.39, y = -3109.42, z = 4.90},
		Size  = {x = 5.0, y = 5.0, z = 5.0},
		Color = {r=211, g=211, b=211},
		Type  = 27, Rotate = true
	},
 
	Job2 = {
		Pos   = {x = 153.61, y = -3080.16, z = 5.25},
		Size  = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r=211, g=211, b=2110},
		Type  = 29, Rotate = true
	},
	  
	Job3 = {
		Pos   = {x = -411.92, y = -2752.41, z = 5.6},
		Size  = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r=211, g=211, b=211},
		Type  = 39, Rotate = true
	}

}
 