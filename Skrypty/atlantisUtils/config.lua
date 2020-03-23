
Config                            = {}
Config.DrawDistance               = 5.0


Config.Marker = {
	
	{
		-- szpital
		text = '~b~[E] ~w~Aby skorzystać z usług szpitala',
		Pos   = {x = 305.97, y = -594.61, z = 43.29},
		event = 'hospital:mario'
	},

	--[[{
		-- resthouse1
		text = '~b~[E] ~w~Aby skorzystać z usług weterynarza',
		Pos   = {x = 1974.2, y = 3819.85, z = 33.43},
		event = 'resthouse:start'
	},
  
	{
		-- zlomiarka 
		text = '~b~[E] ~w~Aby zezłomować pojazd',
		Pos   = {x = -521.50, y = -1721.35, z = 19.23},
		event = 'recycling:start'
	},]]

	{
		-- coke shop
		text = '~b~[E] ~w~Aby porozmawiać',
		Pos   = {x = -1873.58, y = 2140.44, z = 125.6},
		event = 'coke:seller'
	},


	{
		-- lombard
		text = '~b~[E] ~w~Aby zagadać',
		Pos   = {x = -62.48, y = -1290.84, z = 30.89},
		event = 'lombard:open'
	},

	{
		-- drugtest
		text = '~b~[E] ~w~Aby pobrać tester do narkotyków',
		Pos   = {x = 475.95, y = -987.90, z = 24.91},
		event = 'drugtest:givetester'
	},
  
	{
		-- drugtest2
		text = '~b~[E] ~w~Aby wysłać wyniki do analizy/Sprawdzić czy są wyniki',
		Pos   = {x = 472.03, y = -983.45, z = 24.91},
		event = 'drugtest:usetester'
	},

	{
		-- resthouse3
		text = '~b~[E] ~w~Aby skorzystać z usług weterynarza',
		Pos   = {x = 2670.55, y =  1612.76, z = 24.5},
		event = 'resthouse:start'
	},


	--[[{
		-- resthouse2
		text = '~b~[E] ~w~Aby skorzystać z usług weterynarza',
		Pos   = {x = -1108.43, y = -1643.35, z = 4.64},
		event = 'resthouse:start'
	},]]
--------------------------------MAGAZYN------------------------------------

	{
		-- magazynier
		text = '~b~[E] ~w~Aby podnieść paczkę',
		Pos   = {x = -123.4133, y = 6174.798, z = 31.00},
		event = 'storekeeper:start'
	},

	{
		
		text = '~b~[E] ~w~Aby podnieść paczkę',
		Pos   = {x = -117.1198, y = 6175.103, z = 31.00},
		event = 'storekeeper:start'
	},

	{
		
		text = '~b~[E] ~w~Aby podnieść paczkę',
		Pos   = {x = -128.89, y = 6167.78, z = 31.00},
		event = 'storekeeper:start'
	},

---------------------------------------------------------------------------------

--------------------------------kurier------------------------------------

	{
		-- kurier zacznij prace
		text = '~b~[E] ~w~Aby rozpocząć pracę',
		Pos   = {x = -63.34, y = -2517.15, z = 7.5},
		event = 'dpd:start'
	},

	{
		-- kurier oddaj pojazd
		text = '~b~[E] ~w~Aby oddać pojazd i zakończyć pracę',
		Pos   = {x = -64.96, y = -2500.43, z = 5.2},
		event = 'dpd:end'
	},
---------------------------------------------------------------------------------

--------------------------------barman------------------------------------

	{
		-- barman
		text = '~b~[E] ~w~Aby pobrać zamówienie',
		Pos   = {x = 127.1870, y = -1282.301, z = 29.50},
		event = 'barman:start'
	},

---------------------------------------------------------------------------------


--------------------------------CLOTHESSHOP------------------------------------
--[[ {
		--clothes shop
		text = '~b~[E] ~w~Aby skorzystać ze sklepu.',
		Pos   = {x = 1322.6, y = -1651.9, z = 52.2},
		event = 'tattoo:menu'
	},




---------------------------------------------------------------------------------

--------------------------------TATTOOSHOPS------------------------------------
	{
		--tattoo shop
		text = '~b~[E] ~w~Aby skorzystać ze sklepu.',
		Pos   = {x = 1322.6, y = -1651.9, z = 52.2},
		event = 'tattoo:menu'
	},

	{
		--tattoo shop2
		text = '~b~[E] ~w~Aby skorzystać ze sklepu.',
		Pos   = {x = -1153.6, y = -1425.6, z = 4.9},
		event = 'tattoo:menu'
	},

	{
		--tattoo shop3
		text = '~b~[E] ~w~Aby skorzystać ze sklepu.',
		Pos   = {x = 322.1, y = 180.4, z = 103.5},
		event = 'tattoo:menu'
	},

	{
		--tattoo shop4
		text = '~b~[E] ~w~Aby skorzystać ze sklepu.',
		Pos   = {x = -3170.0, y = 1075.0, z = 20.8},
		event = 'tattoo:menu'
	},

	{
		--tattoo shop5
		text = '~b~[E] ~w~Aby skorzystać ze sklepu.',
		Pos   = {x = 1864.6, y = 3747.7, z = 33.0},
		event = 'tattoo:menu'
	},

	{
		--tattoo shop6
		text = '~b~[E] ~w~Aby skorzystać ze sklepu.',
		Pos   = {x = -293.7, y = 6200.0, z = 31.4},
		event = 'tattoo:menu',
		exitevent = 'esx_tattooshop:hasExitedMarker'
	}]]
---------------------------------------------------------------------------------

}




--[[Config.JobMarker = {

	{
		-- test pracy
		text = '~b~[E] ~w~Aby zaczac prace.',
		Pos   = {x = 319.3362, y = -559.2805, z = 28.74343},
		event = 'zacznij:prace'
	}

}]]