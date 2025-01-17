Config = {}
Config.DoorList = {

	-- To locker room & roof
	{
		objName = 'v_ilev_ph_gendoor004',
		objCoords  = {x = 449.698, y = -986.469, z = 30.689},
		textCoords = {x = 450.104, y = -986.388, z = 31.739},
		authorizedCodes = { '1337'},
		locked = true
	},

	-- Rooftop
	{
		objName = 'v_ilev_gtdoor02',
		objCoords  = {x = 464.361, y = -984.678, z = 43.834},
		textCoords = {x = 464.361, y = -984.050, z = 44.834},
		authorizedCodes = { '1337'},
		locked = true
	},

	-- Hallway to roof
	{
		objName = 'v_ilev_arm_secdoor',
		objCoords  = {x = 461.286, y = -985.320, z = 30.839},
		textCoords = {x = 461.50, y = -986.00, z = 31.50},
		authorizedCodes = { '1337'},
		locked = true
	},

	-- Armory
	{
		objName = 'v_ilev_arm_secdoor',
		objCoords  = {x = 452.618, y = -982.702, z = 30.689},
		textCoords = {x = 453.079, y = -982.600, z = 31.739},
		authorizedCodes = { '1337'},
		locked = true
	},

	-- Captain Office
	{
		objName = 'v_ilev_ph_gendoor002',
		objCoords  = {x = 447.238, y = -980.630, z = 30.689},
		textCoords = {x = 447.200, y = -980.010, z = 31.739},
		authorizedCodes = { '1337'},
		locked = true
	},
	-- 
	-- Mission Row Cells
	--

	-- Main Cells
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 463.815, y = -992.686, z = 24.9149},
		textCoords = {x = 463.30, y = -992.686, z = 25.10},
		authorizedCodes = { '1337'},
		locked = true
	},

	-- Cell 1
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 462.381, y = -993.651, z = 24.914},
		textCoords = {x = 461.806, y = -993.308, z = 25.064},
		authorizedCodes = { '1337'},
		locked = true
	},

	-- Cell 2
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 462.331, y = -998.152, z = 24.914},
		textCoords = {x = 461.806, y = -998.800, z = 25.064},
		authorizedCodes = { '1337'},
		locked = true
	},

	-- Cell 3
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 462.704, y = -1001.92, z = 24.9149},
		textCoords = {x = 461.806, y = -1002.450, z = 25.064},
		authorizedCodes = { '1337'},
		locked = true
	},
	
	

	-- To Back
	{
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 463.478, y = -1003.538, z = 25.005},
		textCoords = {x = 464.00, y = -1003.50, z = 25.50},
		authorizedCodes = { '1337'},
		locked = true
	},

	--
	-- Mission Row Back
	--

    -- USILE DIN FATA
		{
			objName = 'v_ilev_ph_door01',
			objCoords  = {x = 434.747, y = -980.618, z = 30.839},
			textCoords = {x = 434.747, y = -981.50, z = 31.50},
			authorizedCodes = { '1337'},
			locked = false,
			distance = 2.5
		},
	
		{
			objName = 'v_ilev_ph_door002',
			objCoords  = {x = 434.747, y = -983.215, z = 30.839},
			textCoords = {x = 434.747, y = -982.50, z = 31.50},
			authorizedCodes = { '1337'},
			locked = false,
			distance = 2.5
		},


	-- To downstairs (double doors)
	{
		objName = 'v_ilev_ph_gendoor005',
		objCoords  = {x = 443.97, y = -989.033, z = 30.6896},
		textCoords = {x = 444.020, y = -989.445, z = 31.739},
		authorizedCodes = { '1337'},
		locked = true,
		distance = 4
	},
	

	{
		objName = 'v_ilev_ph_gendoor005',
		objCoords  = {x = 445.37, y = -988.705, z = 30.6896},
		textCoords = {x = 445.350, y = -989.445, z = 31.739},
		authorizedCodes = { '1337'},
		locked = true,
		distance = 4
	},

	-- Back Gate

	--
	-- Sandy Shores
	--

	-- Entrance
	{
		objName = 'v_ilev_shrfdoor',
		objCoords  = {x = 1855.105, y = 3683.516, z = 34.266},
		textCoords = {x = 1855.105, y = 3683.516, z = 35.00},
		authorizedCodes = { '1337'},
		locked = false
	},

	--
	-- Paleto Bay
	--

	-- Entrance (double doors)
	{
		objName = 'v_ilev_shrf2door',
		objCoords  = {x = -443.14, y = 6015.685, z = 31.716},
		textCoords = {x = -443.14, y = 6015.685, z = 32.00},
		authorizedCodes = { '1337'},
		locked = false,
		distance = 2.5
	},

	{
		objName = 'v_ilev_shrf2door',
		objCoords  = {x = -443.951, y = 6016.622, z = 31.716},
		textCoords = {x = -443.951, y = 6016.622, z = 32.00},
		authorizedCodes = { '1337'},
		locked = false,
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
		authorizedCodes = { '1337'},
		locked = true,
		distance = 12,
		size = 2
	},

	{
		objName = 'prop_gate_prison_01',
		objCoords  = {x = 1818.542, y = 2604.812, z = 44.611},
		textCoords = {x = 1818.542, y = 2608.40, z = 48.00},
		authorizedCodes = { '1337'},
		locked = true,
		distance = 12,
		size = 2
	},

	{
		objName = 'v_ilev_arm_secdoor',
		objCoords  = {x = 461.286, y = -985.320, z = 30.839},
		textCoords = {x = 461.50, y = -986.00, z = 31.50},
		authorizedCodes = { '1337'},
		locked = true
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
		authorizedCodes = { 'police' },
		locked = true,
		distance = 14,
		size = 2
	}
	--]]
	
		-- Zancudo Military Base Front Entrance
	{
		objName = 'prop_gate_airport_01',
		objCoords  = {x = -1587.23, y = 2805.08, z = 15.82},
		textCoords = {x = -1587.23, y = 2805.08, z = 19.82},
		authorizedCodes = { '1337'},
		locked = true,
		distance = 12,
		size = 2
	},
	
	{
		objName = 'prop_gate_airport_01',
		objCoords  = {x = -1600.29, y = 2793.74, z = 15.74},
		textCoords = {x = -1600.29, y = 2793.74, z = 19.74},
		authorizedCodes = { '1337'},
		locked = true,
		distance = 12,
		size = 2
	},
	
	-- Zancudo Military Base Back Entrance
	{
		objName = 'prop_gate_airport_01',
		objCoords  = {x = -2296.17, y = 3393.1, z = 30.07},
		textCoords = {x = -2296.17, y = 3393.1, z = 34.07},
		authorizedCodes = { '1337'},
		locked = true,
		distance = 12,
		size = 2
	},
	
	{
		objName = 'prop_gate_airport_01',
		objCoords  = {x = -2306.13, y = 3379.3, z = 30.2},
		textCoords = {x = -2306.13, y = 3379.3, z = 34.2},
		authorizedCodes = { '1337'},
		locked = true,
		distance = 12,
		size = 2
	},
	
	-- Paleto Bay Parking Lot Gate
	{
		objName = 'prop_facgate_08',
		objCoords  = {x = -455.59, y = 6030.1, z = 30.34},
		textCoords = {x = -455.59, y = 6030.1, z = 34.34},
		authorizedCodes = { '1337'},
		locked = true,
		distance = 14,
		size = 2
	},
	

	
	-- PD Back Gate
	{
		objName = 'prop_gate_military_01',
		objCoords  = {x = 1858.11, y = 3719.22, z = 32.03},
		textCoords = {x = 1858.11, y = 3719.22, z = 34.03},
		authorizedCodes = { '1337'},
		locked = true,
		distance = 14,
		size = 2
	},
	
	-- FR Back Gate (Exit)
	{
		objName = 'prop_gate_military_01',
		objCoords  = {x = 1845.07, y = 3712.2, z = 32.17},
		textCoords = {x = 1845.07, y = 3712.2, z = 34.17},
		authorizedCodes = { '1337'},
		locked = true,
		distance = 14,
		size = 2
	},
	
	-- FR Front Gate (Entrance)
	{
		objName = 'prop_gate_military_01',
		objCoords  = {x = 1804.49, y = 3675.7, z = 33.21},
		textCoords = {x = 1804.49, y = 3675.7, z = 35.21},
		authorizedCodes = { '1337'},
		locked = true,
		distance = 14,
		size = 2
	},
	
		{
		objName = 'prop_gate_docks_ld',
		objCoords  = {x = 492.06, y = -3116.1, z = 7.07},
		textCoords = {x = 492.06, y = -3116.1, z = 7.07},
		authorizedCodes = { '1337'},
		locked = true,
		distance = 12,
		size = 2
	},
	
		{
		objName = 'prop_gate_docks_ld',
		objCoords  = {x = 476.64, y = -3115.98, z = 7.07},
		textCoords = {x = 476.64, y = -3115.98, z = 7.07},
		authorizedCodes = { '1337'},
		locked = true,
		distance = 12,
		size = 2
	},
}