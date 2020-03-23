Config                            = {}

Config.DrawDistance               = 100.0

Config.NPCJobEarnings             = {min = 300, max = 600}
Config.MinimumDistance            = 3000 -- Minimum NPC job destination distance from the pickup in GTA units, a higher number prevents nearby destionations.

Config.MaxInService               = -1
Config.EnablePlayerManagement     = false
Config.EnableSocietyOwnedVehicles = false

Config.Locale                     = 'pl'

Config.AuthorizedVehicles = {
		
		{
			model = 'yankee3',
			label = 'Vapid Yankee',
			price = 10000
		},
		{
			model = 'boxville6',
			label = 'Brute Boxville',
			price = 5000
		},
		{
			model = 'apolice3',
			label = 'Police Obey Rocoto',
			price = 5000
		},
		{
			model = 'apolice5',
			label = 'Police Lampadati Felon',
			price = 50000
		}


	}

Config.Zones = {

	VehicleSpawner = {
		Pos   = {x = -63.34, y = -2517.15, z = 6.5},
		Size  = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 1, g = 204, b = 0},
		Type  = 27, Rotate = true
	},

	VehicleSpawnPoint = {
		Pos     = {x = -64.96, y = -2500.43, z = 5.2},
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Type    = -1, Rotate = false,
		Heading = 334.67
	},

	VehicleDeleter = {
		Pos   = {x = -124.52, y = -2538.07, z = 5.1},
		Size  = {x = 3.0, y = 3.0, z = 0.25},
		Color = {r = 255, g = 0, b = 0},
		Type  = 27, Rotate = false
	},

	CurierActions = {
		Pos   = {x = -56.75, y = -2519.84, z = 6.5},
		Size  = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 1, g = 204, b = 0},
		Type  = 27, Rotate = true
	},

	Cloakroom = {
		Pos     = {x = -53.12, y = -2522.69, z = 6.5},
		Size    = {x = 1.0, y = 1.0, z = 1.0},
		Color   = {r = 1, g = 204, b = 0},
		Type    = 27, Rotate = true
	},	
	BuyVehicle = {
		Pos   = {x = -59.51, y = -2518.4, z = 6.5},
		Size  = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 1, g = 5, b = 250},
		Type  = 27, Rotate = true
	},
	TakeBoxes = {
		Pos   = {x = -107.15, y = -2510.444, z = 4.3},
		Size  = {x = 4.0, y = 4.0, z = 1.0},
		Color = {r = 255, g = 255, b = 0},
		Type  = 27, Rotate = true
	},
	
		Job1 = {
		Pos   = {x = 102.65, y = -1822.27, z = 25.41},
		Size  = {x = 4.0, y = 4.0, z = 1.0},
		Color = {r=211, g=211, b=211},
		Type  = 27, Rotate = true
	},
	
		Job2 = {
		Pos   = {x = 2673.14, y = 3514.99, z = 52.71},
		Size  = {x = 4.0, y = 4.0, z = 1.0},
		Color = {r=211, g=211, b=211},
		Type  = 27, Rotate = true
	},
	
		Job3 = {
		Pos   = {x = 1733.06, y = -1537.06, z = 112.72},
		Size  = {x = 4.0, y = 4.0, z = 1.0},
		Color = {r=211, g=211, b=211},
		Type  = 27, Rotate = true
	},
	
		Job4 = {
		Pos   = {x = -72.7, y = 6269.44, z = 30.40},
		Size  = {x = 4.0, y = 4.0, z = 1.0},
		Color = {r=211, g=211, b=211},
		Type  = 27, Rotate = true
	},
	
		Job5 = {
		Pos   = {x = -580.4, y = 5311.62, z = 69.25},
		Size  = {x = 4.0, y = 4.0, z = 1.0},
		Color = {r=211, g=211, b=211},
		Type  = 27, Rotate = true
	},
	
		Job6 = {
		Pos   = {x = 1735.29, y = 3304.34, z = 40.25},
		Size  = {x = 4.0, y = 4.0, z = 1.0},
		Color = {r=211, g=211, b=211},
		Type  = 27, Rotate = true
	},
	
		Job7 = {
		Pos   = {x = 2969.93, y = 2753.85, z = 43.15},
		Size  = {x = 4.0, y = 4.0, z = 1.0},
		Color = {r=211, g=211, b=211},
		Type  = 27, Rotate = true
	}

}


Config.JobLocations = {
	{x = 102.65, y = -1822.27, z = 25.41},
	{x = 2673.14, y = 3514.99, z = 52.71},
	{x = 1733.06, y = -1537.06, z = 112.72},
	{x = -72.7, y = 6269.44, z = 31.37},
	{x = -580.4, y = 5311.62, z = 69.25},
	{x = 1735.29, y = 3304.34, z = 41.21},
	{x = 2969.93, y = 2753.85, z = 43.15},

}
for i=1, #Config.JobLocations, 1 do
	Config.Zones['JobLocation' .. i] = {
		Pos   = Config.JobLocations[i],
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = -1
	}
end