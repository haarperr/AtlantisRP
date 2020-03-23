Config = {}
Config.Locale = 'pl'

Config.DoorList = {

	--
	-- Mission Row First Floor
	--
  --[[{ 
	    objName = "v_ilev_ph_gendoor004",
	    objCoords = {x= 449.69815063477, y= -986.46911621094,z= 30.689594268799}, 
	    locked= true,
	    textCoords = { x=450.104,y=-986.388,z=31.739}, 
	    distance = 1.2, 
	    size = 1, 
	    authorizedJobs = { 'police' }, 
    },]]
    -- Mission Row Armory
  --  { objName = "v_ilev_arm_secdoor",objCoords = {x= 452.61877441406, y= -982.7021484375,z= 30.689598083496}, locked= true,textCoords = { x=453.079,y=-982.600,z=31.739}, distance = 1.2, size = 1, authorizedJobs = { 'police' }},
    -- Mission Row Captain Office
  --  { objName = "v_ilev_ph_gendoor002",objCoords = {x= 447.23818969727, y= -980.63006591797,z= 30.689598083496}, locked= true,textCoords = { x=447.200,y=-980.010,z=31.739}, distance = 1.2, size = 1,authorizedJobs = { 'police' }},
    -- Mission Row To downstairs right
  --  { objName = "v_ilev_ph_gendoor005",objCoords = {x= 443.97, y= -989.033,z= 30.6896}, locked= true,textCoords = { x=444.020,y=-989.445,z=31.739}, distance = 1.2, size = 1, authorizedJobs = { 'police' }},
    -- Mission Row To downstairs left
   -- { objName = "v_ilev_ph_gendoor005",objCoords = {x= 445.37, y= -988.705,z= 30.6896}, locked= true,textCoords = { x=445.350,y=-989.445,z=31.739}, distance = 1.2, size = 1, authorizedJobs = { 'police' }},
    -- Mission Row Main cells
    --{ objName = "v_ilev_ph_cellgate",objCoords = {x= 464.0, y= -992.265,z= 24.9149}, locked= true,textCoords = { x=463.465,y=-992.664,z=25.064}, distance = 1.2, size = 1, authorizedJobs = { 'police' }},
    -- Mission Row Cell 1
   -- { objName = "v_ilev_ph_cellgate",objCoords = {x= 462.381, y= -993.651,z= 24.9149}, locked= true,textCoords = { x=461.806,y=-993.308,z=25.064}, distance = 1.2, size = 1, authorizedJobs = { 'police' }},
    -- Mission Row Cell 2
  --  { objName = "v_ilev_ph_cellgate",objCoords = {x= 462.331, y= -998.152,z= 24.9149}, locked= true,textCoords = { x=461.806,y=-998.800,z=25.064}, distance = 1.2, size = 1,authorizedJobs = { 'police' }},
    -- Mission Row Cell 3
  --  { objName = "v_ilev_ph_cellgate",objCoords = {x= 462.704, y= -1001.92,z= 24.9149}, locked= true,textCoords = { x=461.806,y=-1002.450,z=25.064}, distance = 1.2, size = 1, authorizedJobs = { 'police' }},
    -- Mission Row Backdoor in
--    { objName = "v_ilev_gtdoor",objCoords = {x= 464.126, y= -1002.78,z= 24.9149}, locked= true,textCoords = { x=464.100,y=-1003.538,z=26.064}, distance = 1.2, size = 1, access="police" },
    -- Mission Row Backdoor out
 --  { objName = "v_ilev_gtdoor",objCoords = {x= 464.18, y= -1004.31,z= 24.9152}, locked= true,textCoords = { x=464.100,y=-1003.538,z=26.064}, distance = 1.2, size = 1, access="police" },
    -- Mission Row Rooftop In
   -- { objName = "v_ilev_gtdoor02",objCoords = {x= 465.467, y= -983.446,z= 43.6918}, locked= true,textCoords = { x=464.361,y=-984.050,z=44.834}, distance = 1.5, size = 1, access="police" },
    -- Mission Row Rooftop Out
   -- { objName = "v_ilev_gtdoor02",objCoords = {x= 462.979, y= -984.163,z= 43.6919}, locked= true,textCoords = { x=464.361,y=-984.050,z=44.834}, distance = 1.2, size = 1, access="police" },
    --Sandy
--    { objName = "v_ilev_shrfdoor",objCoords = {x= 1855.685, y= 3683.93,z= 34.59282}, locked= true,textCoords = { x=1855.16,y=3683.27,z=34.87}, distance = 1.2, size = 1, authorizedJobs = { 'police' }},
    -- Prison Second Gatei - enter
  --  { objName = "prop_gate_prison_01",objCoords = {x= 1818.543, y= 2604.813,z= 44.611}, locked= true,textCoords = { x=1805.96,y=2606.74,z=44.23}, distance = 13.2, size = 1, authorizedJobs = { 'police' }}, 
    -- Prison Second Gate - inside
  --  { objName = "prop_gate_prison_01",objCoords = {x= 1818.543, y= 2604.813,z= 44.611}, locked= true,textCoords = { x=1831.14,y=2608.84,z=44.25}, distance = 13.2, size = 1,authorizedJobs = { 'police' }},
    -- Paleto 1
  --  { objName = "v_ilev_shrf2door",objCoords = {x= -442.66, y= 6015.222,z= 31.86633}, locked= true,textCoords = { x= -442.86,y= 6016.1,z=31.91}, distance = 1.2, size = 1, authorizedJobs = { 'police' }},
 --   -- Paleto 2
   -- { objName = "v_ilev_shrf2door",objCoords = {x= -444.4985, y= 6017.06,z= 31.86633}, locked= true,textCoords = { x=-443.78,y=6016.99,z=31.91}, distance = 1.2, size = 1, authorizedJobs = { 'police' }},
    -- Hospital - Left 1
    { objName = "v_ilev_cor_doorglassb",objCoords = {x=252.688, y=-1361.462, z=24.68168}, locked= true,textCoords = { x= 253.288, y= -1360.662, z= 24.68168}, distance = 1.2, size = 1, authorizedJobs = { 'ambulance', 'offambulance' }},
    -- Hospital - Left 2
    { objName = "v_ilev_cor_doorglassa",objCoords = {x=254.3432, y=-1359.49, z=24.68168}, locked= true,textCoords = { x=253.9432, y=-1359.69, z= 24.68168}, distance = 1.2, size = 1, authorizedJobs = { 'ambulance', 'offambulance' }},
    -- Hospital - Right 1
    { objName = "v_ilev_cor_doorglassb",objCoords = {x=265.7706, y=-1345.871, z=24.68168}, locked= true,textCoords = { x=265.7706, y=-1345.471, z= 24.68168}, distance = 1.2, size = 1, authorizedJobs = { 'ambulance', 'offambulance' }},
    -- Hospital - Right 1
    { objName = "v_ilev_cor_doorglassa",objCoords = {x=267.4241, y=-1343.9, z=24.68168}, locked= true,textCoords = { x=267.2241, y=-1344.39, z= 24.68168}, distance = 1.2, size = 1, authorizedJobs = { 'ambulance', 'offambulance' }},
	-- Entrance Doors
 { objName = "v_ilev_bl_doorsl_l",objCoords = {x=347.469, y=-585.960, z=43.595655}, locked= true,textCoords = { x=347.469, y=-585.960, z=43.595655}, distance = 4.0, size = 1, authorizedJobs = { 'ambulance', 'offambulance' }},
	-- Drzwi operacyjna pillbox 1
 { objName = "v_ilev_bl_doorsl_r",objCoords = {x=348.588, y=-586.388, z=43.595655}, locked= true,textCoords = { x=348.588, y=-586.388, z=43.595655}, distance = 4.0, size = 1, authorizedJobs = { 'ambulance', 'offambulance' }},
	-- Drzwi operacyjna pillbox 2
 { objName = "v_ilev_bl_doorsl_l",objCoords = {x=355.952, y=-589.090, z=43.595655}, locked= true,textCoords = { x=355.952, y=-589.090, z=43.595655}, distance = 4.0, size = 1, authorizedJobs = { 'ambulance', 'offambulance' }},
	-- Drzwi operacyjna pillbox 3
 { objName = "v_ilev_bl_doorsl_r",objCoords = {x=357.169, y=-589.509, z=43.595655}, locked= true,textCoords = { x=357.169, y=-589.509, z=43.595655}, distance = 4.0, size = 1, authorizedJobs = { 'ambulance', 'offambulance' }},
	-- Drzwi operacyjna pillbox 4
 { objName = "apa_p_mp_door_apart_door_black",objCoords = {x=337.288, y=-583.780, z=43.595655}, locked= true,textCoords = { x=337.288, y=-583.780, z=43.595655}, distance = 1.5, size = 1, authorizedJobs = { 'ambulance', 'offambulance' }},
	-- Drzwi boczne operacyjna pillbox 1
 { objName = "apa_p_mp_door_apart_door_black",objCoords = {x=336.300, y=-586.440, z=43.595655}, locked= true,textCoords = { x=336.300, y=-586.440, z=43.595655}, distance = 1.5, size = 1, authorizedJobs = { 'ambulance', 'offambulance' }},
	-- Drzwi boczne operacyjna pillbox 2
 { objName = "apa_p_mp_door_apart_door_black",objCoords = {x=332.884, y=-589.399, z=43.595655}, locked= true,textCoords = { x=332.884, y=-589.399, z=43.595655}, distance = 1.5, size = 1, authorizedJobs = { 'ambulance', 'offambulance' }},
	-- Drzwi pokoj doktorka pillbox
 { objName = "v_ilev_fib_door2",objCoords = {x=138.701, y=-768.186, z=242.182}, locked= true,textCoords = { x=138.701, y=-768.186, z=242.182}, distance = 1.5, size = 1, authorizedJobs = { 'city' }},
	-- Drzwi urząd 1
 { objName = "v_ilev_fib_door2",objCoords = {x=127.482, y=-763.968, z=242.182}, locked= true,textCoords = { x=127.482, y=-763.968, z=242.182}, distance = 1.5, size = 1, authorizedJobs = { 'city' }},
	-- Drzwi urząd 2
 { objName = "v_ilev_fib_door1",objCoords = {x=127.23, y=-760.17, z=45.95}, locked= true,textCoords = { x=127.23, y=-760.17, z=45.95}, distance = 1.5, size = 1, authorizedJobs = { 'city' }},
	-- Drzwi urząd 3

	{
		objName = 'v_ilev_ph_door01',
		objCoords  = {x = 434.747, y = -980.618, z = 30.839},
		textCoords = {x = 434.747, y = -981.50, z = 31.50},
		authorizedJobs = { 'police', 'offpolice' },
		locked = false,
		distance = 2.0
	},

	{
		objName = 'v_ilev_ph_door002',
		objCoords  = {x = 434.747, y = -983.215, z = 30.839},
		textCoords = {x = 434.747, y = -982.50, z = 31.50},
		authorizedJobs = { 'police', 'offpolice' },
		locked = false,
		distance = 2.0
	},

	-- To locker room & roof
	{
		objName = 'v_ilev_ph_gendoor004',
		objCoords  = {x = 449.698, y = -986.469, z = 30.689},
		textCoords = {x = 450.104, y = -986.388, z = 31.739},
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 2.0
	},

	-- Rooftop
	{
		objName = 'v_ilev_gtdoor02',
		objCoords  = {x = 464.361, y = -984.678, z = 43.834},
		textCoords = {x = 464.361, y = -984.050, z = 44.834},
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 2.0
	},

	-- Hallway to roof
	{
		objName = 'v_ilev_arm_secdoor',
		objCoords  = {x = 461.286, y = -985.320, z = 30.839},
		textCoords = {x = 461.50, y = -986.00, z = 31.50},
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 2.0
	},

	-- Armory
	{
		objName = 'v_ilev_arm_secdoor',
		objCoords  = {x = 452.618, y = -982.702, z = 30.689},
		textCoords = {x = 453.079, y = -982.600, z = 31.739},
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 2.0
	},

	-- Captain Office
	{
		objName = 'v_ilev_ph_gendoor002',
		objCoords  = {x = 447.238, y = -980.630, z = 30.689},
		textCoords = {x = 447.200, y = -980.010, z = 31.739},
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 2.0
	},

	-- To downstairs (double doors)
	{
		objName = 'v_ilev_ph_gendoor005',
		objCoords  = {x = 443.97, y = -989.033, z = 30.6896},
		textCoords = {x = 444.020, y = -989.445, z = 31.739},
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 2.5
	},

	{
		objName = 'v_ilev_ph_gendoor005',
		objCoords  = {x = 445.37, y = -988.705, z = 30.6896},
		textCoords = {x = 445.350, y = -989.445, z = 31.739},
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 2.5
	},

	-- 
	-- Mission Row Cells
	--

	-- Main Cells
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 463.815, y = -992.686, z = 24.9149},
		textCoords = {x = 463.30, y = -992.686, z = 25.10},
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 1.0
	},

	-- Cell 1
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 462.381, y = -993.651, z = 24.914},
		textCoords = {x = 461.806, y = -993.308, z = 25.064},
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 1.0
	},

	-- Cell 2
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 462.331, y = -998.152, z = 24.914},
		textCoords = {x = 461.806, y = -998.800, z = 25.064},
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 1.0
	},

	-- Cell 3
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 462.704, y = -1001.92, z = 24.9149},
		textCoords = {x = 461.806, y = -1002.450, z = 25.064},
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 1.0
	},

	-- To Back
	{
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 463.478, y = -1003.538, z = 25.005},
		textCoords = {x = 464.00, y = -1003.50, z = 25.50},
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 1.0
	},

	-- Sala przesłuchań
	{
		objName = 'v_ilev_ph_gendoor006',
		objCoords  = {x = 470.40, y = -994.39, z = 25.30},
		textCoords = {x = 470.40, y = -994.39, z = 25.30},
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 1.2
	},

	--
	-- Mission Row Back
	--

	-- Back (double doors)
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = 467.371, y = -1014.452, z = 26.536},
		textCoords = {x = 468.09, y = -1014.452, z = 27.1362},
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 2.5
	},

	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = 469.967, y = -1014.452, z = 26.536},
		textCoords = {x = 469.35, y = -1014.452, z = 27.136},
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 2.5
	},

	-- Back Gate
	{
		objName = 'hei_prop_station_gate',
		objCoords  = {x = 488.894, y = -1017.210, z = 27.146},
		textCoords = {x = 488.894, y = -1020.210, z = 30.00},
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 14,
		size = 2
	},

	--
	-- Sandy Shores
	--

	-- Entrance
	{
		objName = 'v_ilev_shrfdoor',
		objCoords  = {x = 1855.105, y = 3683.516, z = 34.266},
		textCoords = {x = 1855.105, y = 3683.516, z = 35.00},
		authorizedJobs = { 'police', 'offpolice' },
		locked = true
	},

	--
	-- Paleto Bay
	--

	-- Entrance (double doors)
	{
		objName = 'v_ilev_shrf2door',
		objCoords  = {x = -443.14, y = 6015.685, z = 31.716},
		textCoords = {x = -443.14, y = 6015.685, z = 32.00},
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 2.5
	},

	{
		objName = 'v_ilev_shrf2door',
		objCoords  = {x = -443.951, y = 6016.622, z = 31.716},
		textCoords = {x = -443.951, y = 6016.622, z = 32.00},
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 2.5
	},

	--
	-- Bolingbroke Penitentiary
	--

	-- Entrance (Two big gates)
	{
		objName = 'prop_gate_prison_01',
		objCoords  = {x = 1844.998, y = 2604.810, z = 44.638},
		textCoords = {x = 1844.998, y = 2608.50, z = 48.00},
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 12,
		size = 2
	},

	{
		objName = 'prop_gate_prison_01',
		objCoords  = {x = 1818.542, y = 2604.812, z = 44.611},
		textCoords = {x = 1818.542, y = 2608.40, z = 48.00},
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 12,
		size = 2
	},

	--
	-- Addons
	--

	--[[
	-- Entrance Gate (Mission Row mod) https://www.gta5-mods.com/maps/mission-row-pd-ymap-fivem-v1
	{
		objName = 'prop_gate_airport_01',
		objCoords  = {x = 420.133, y = -1017.301, z = 28.086},
		textCoords = {x = 420.133, y = -1021.00, z = 32.00},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 14,
		size = 2
	}
	--]]
}