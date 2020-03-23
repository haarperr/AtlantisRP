K9Config = {}
K9Config = setmetatable(K9Config, {})

K9Config.OpenMenuIdentifierRestriction = true
K9Config.OpenMenuPedRestriction = true
K9Config.LicenseIdentifiers = {
	"license:x"
}
K9Config.SteamIdentifiers = {
	"steam:x"
}
K9Config.PedsList = {
	"mp_m_freemode_01",
	"mp_f_freemode_01"
}

-- Restricts the dog to getting into certain vehicles
K9Config.VehicleRestriction = false
K9Config.VehiclesList = {
	
}

-- Searching Type ( RANDOM [AVAILABLE] | VRP [NOT AVAILABLE] | ESX [NOT AVAILABLE] )
K9Config.SearchType = "Random"
K9Config.OpenDoorsOnSearch = false

-- Used for Random Search Type --
K9Config.Items = {
	{item = "Cocaine", illegal = true},
	{item = "Marijuana", illegal = true},
	{item = "Blunt Spray", illegal = false},
	{item = "Crowbar", illegal = false},
	{item = "Lockpicks", illegal = false},
	{item = "Baggies", illegal = false},
	{item = "Used Needle", illegal = false},
	{item = "Open Container", illegal = false},
}

-- Language -- --DUMMY
K9Config.LanguageChoice = "English"
K9Config.Languages = {
	["English"] = {
		follow = "Chodź",
		stop = "Stój",
		attack = "Bierz go",
		enter = "In",
		exit = "Out"
	}
}