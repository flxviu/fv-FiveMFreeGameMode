Config = {}

-- Config.Doors = {
--     [7] = {locked = false, doorCoords = vector3(-1370.3862304688,-324.57662963867,39.279079437256), hash = 776184575},
-- 	[8] = {locked = false, doorCoords = vector3(1387.9222412109,3615.1059570312,38.921058654785), hash = 1804626822},
-- 	[9] = {locked = false, doorCoords = vector3(1957.4426269531,5175.0952148438,47.98376083374), hash = 776184575},
-- 	[10] = {locked = false, doorCoords = vector3(887.36151123047,-954.70111083984,39.279819488525), hash = 776184575},
-- }

-- Config.productPrices = {
-- 	["seminte"] = 50,
-- 	["diluant"] = 100,
-- 	["otrava"] = 120,
-- 	["acetona"] = 35,
-- 	["ingrasamant"] = 80,
-- 	["pliculete"] = 40,
-- 	["efedrina"] = 50, 
-- 	["metamfetamina"] = 100,
-- 	["pastacoca"] = 1000,
-- 	["folie"] = 15,
-- 	["stropitoare_apa"] = 50,
-- 	["fertilizant"] = 30,
-- }

Config.Npcs = {
    -- {
    --     coords = vector3(-1157.1854248047,-1569.6677246094,3.4282102584839),
    --     holo = {-1157.1854248047,-1569.6677246094,4.4282102584839},
	-- 	npc = 'a_m_m_salton_03',
	-- 	text = 'Cosmin Dinu',

	-- 	-- Data meniu
	-- 	meniu = 'sala',
	-- 	rolNPC = 'Vanzari Ilegale',
	-- 	descriereMeniu = '🌿 Ce doresti sa cumperi?',

	-- 	-- Camera jucator (nu modifica -> decat heading daca vrei sa intorci NPC-ul)
	-- 	heading = 300.0,
	-- 	camOffset = vector3(0.0, 0.0, 0.0),
	-- 	camRotation = vector3(0.0, 0.0, 0.0),
    -- },
	-- {
	-- 	coords = vector3(1657.4801025391,4838.958984375,41.022666931152),
	-- 	holo = {1657.4801025391,4838.958984375,42.022666931152},
	-- 	npc = 'a_m_m_salton_03',
	-- 	text = 'Robert Mocanu',

	-- 	-- Data meniu
	-- 	meniu = 'sandy',
	-- 	rolNPC = 'Vanzari Ilegale',
	-- 	descriereMeniu = '🌿 Ce doresti sa cumperi?',

	-- 	-- Camera jucator (nu modifica -> decat heading daca vrei sa intorci NPC-ul)
	-- 	heading = 280.0,
	-- 	camOffset = vector3(0.0, 0.0, 0.0),
	-- 	camRotation = vector3(0.0, 0.0, 0.0),
	-- },
	-- {
	-- 	coords = vector3(1437.2633056641,-1491.8422851563,62.622032165527),
	-- 	holo = {1437.2633056641,-1491.8422851563,63.622032165527},
	-- 	npc = 'a_m_m_salton_03',
	-- 	text = 'Ionut Pop',

	-- 	-- Data meniu
	-- 	meniu = 'ilegale',
	-- 	rolNPC = 'Vanzari Ilegale',
	-- 	descriereMeniu = '🌿 Ce doresti sa cumperi?',

	-- 	-- Camera jucator (nu modifica -> decat heading daca vrei sa intorci NPC-ul)
	-- 	heading = 160.0,
	-- 	camOffset = vector3(0.0, 0.0, 0.0),
	-- 	camRotation = vector3(0.0, 0.0, 0.0),
	-- },
	-- {
	-- 	coords = vector3(2438.3227539062,4973.3256835938,50.687717437744),
	-- 	holo = {2438.3227539062,4973.3256835938,51.687717437744},
	-- 	npc = 'a_m_m_farmer_01',
	-- 	text = 'Anton Dinescu',

	-- 	-- Data meniu
	-- 	meniu = 'fermier',
	-- 	rolNPC = 'Vanzari Ilegale',
	-- 	descriereMeniu = '🌿 Ce doresti sa cumperi?',

	-- 	-- Camera jucator (nu modifica -> decat heading daca vrei sa intorci NPC-ul)
	-- 	heading = 215.0,
	-- 	camOffset = vector3(0.0, 0.0, 0.0),
	-- 	camRotation = vector3(0.0, 0.0, 0.0),
	-- },
	-- {
	-- 	coords = vector3(-44.368301391602,-1093.1900634766,25.422353744507),
	-- 	holo = {-44.368301391602,-1093.1900634766,26.422353744507},
	-- 	npc = 'a_m_y_business_01',
	-- 	text = 'George Amandina',

	-- 	-- Data meniu
	-- 	meniu = 'showroom',
	-- 	rolNPC = 'Ala cu masinile',
	-- 	descriereMeniu = 'Cu ce te pot ajuta ?',

	-- 	-- Camera jucator (nu modifica -> decat heading daca vrei sa intorci NPC-ul)
	-- 	heading = 900.77,
	-- 	camOffset = vector3(0.0, 0.0, 0.0),
	-- 	camRotation = vector3(0.0, 0.0, 0.0),
	-- },
	-- ####### JOBS LEGALE ######
	-- -33.904907226562,-1101.7618408203,26.422369003296
	{
		coords = vector3(-1092.4847412109,-317.70965576172,36.665981292725),
		holo = {-1092.4847412109,-317.70965576172,37.665981292725},
		npc = 'a_m_y_business_01',
		text = "Domnu' cu Joburile",

		-- Data meniu
		meniu = 'jobs',
		rolNPC = 'Da Joburile',
		descriereMeniu = 'Cu ce te pot ajuta ?',

		-- Camera jucator (nu modifica -> decat heading daca vrei sa intorci NPC-ul)
		heading = 800.77,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
	},
	-- SOFER DE AUTOBUZ
	{
		coords = vector3(436.16052246094,-647.37683105468,27.741472244262),
		holo = {436.16052246094,-647.37683105468,28.741472244262},
		npc = 'a_m_y_business_02',
		text = 'Stefan Mihailescu',

		-- Data meniu
		meniu = 'soferautobuz',
		rolNPC = 'Sef U.G.T.P',
		descriereMeniu = 'Cu ce te pot ajuta ?',

		-- Camera jucator (nu modifica -> decat heading daca vrei sa intorci NPC-ul)
		heading = 75.0,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
	},
	-- PESCAR
	{
		coords = vector3(-3275.5549316406,964.97290039062,7.3471717834472),
		holo = {-3275.5549316406,964.97290039062,8.3471717834472},
		npc = 's_m_y_airworker',
		text = 'Costica Anutei',

		-- Data meniu
		meniu = 'pescar',
		rolNPC = 'Job Pescar',
		descriereMeniu = 'Cu ce te pot ajuta ?',

		-- Camera jucator (nu modifica -> decat heading daca vrei sa intorci NPC-ul)
		heading = -10.0,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
	},
	-- MINER
	{
		coords = vector3(2832.2866210938,2800.0456542968,56.500476837158),
		holo = {2832.2866210938,2800.0456542968,57.500476837158},
		npc = 'a_m_y_business_02',
		text = 'Vasile Muncitorul',

		-- Data meniu
		meniu = 'miner',
		rolNPC = 'Job: Miner',
		descriereMeniu = 'Cu ce te pot ajuta ?',

		-- Camera jucator (nu modifica -> decat heading daca vrei sa intorci NPC-ul)
		heading = 100.0,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
	},
	-- Santierist
	{
		coords = vector3(-471.21904296875,-864.64501953125,23.085807800292),
		holo = {-471.21904296875,-864.64501953125,24.085807800292},
		npc = 's_m_y_airworker',
		text = 'Florin Stanescu',

		-- Data meniu
		meniu = 'santierist',
		rolNPC = 'Job: Santierist',
		descriereMeniu = 'Cu ce te pot ajuta ?',

		-- Camera jucator (nu modifica -> decat heading daca vrei sa intorci NPC-ul)
		heading = 170.0,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
	},
		-- Gradinar
	{
		coords = vector3(2029.7451171875,4980.6293945312,41.098342895508),
		holo = {2029.7451171875,4980.6293945312,42.098342895508},
		npc = 'a_m_m_farmer_01',
		text = 'Dorin Ursu',
	
		-- Data meniu
		meniu = 'gradinar',
		rolNPC = 'Job: Gradinar',
		descriereMeniu = 'Cu ce te pot ajuta ?',
	
		-- Camera jucator (nu modifica -> decat heading daca vrei sa intorci NPC-ul)
		heading = 230.0,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
	},
		-- Taietor Lemne
	{
		coords = vector3(-567.62078857422,5253.1884765625,69.487495422363),
		holo = {-567.62078857422,5253.1884765625,70.487495422363},
		npc = 's_m_m_gaffer_01',
		text = 'Codrut Popescu',
	
		-- Data meniu
		meniu = 'taietorlemne',
		rolNPC = 'Job: Taietor Lemne',
		descriereMeniu = 'Cu ce te pot ajuta ?',
	
		-- Camera jucator (nu modifica -> decat heading daca vrei sa intorci NPC-ul)
		heading = 60.0,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
	},
		-- Electrician
	{
		coords = vector3(474.37203979492,-1951.654296875,23.634256362915),
		holo = {474.37203979492,-1951.654296875,24.634256362915},
		npc = 's_m_y_armymech_01',
		text = 'Florin Stanescu',
	
		-- Data meniu
		meniu = 'electrician',
		rolNPC = 'Job: Electrician',
		descriereMeniu = 'Cu ce te pot ajuta ?',
	
		-- Camera jucator (nu modifica -> decat heading daca vrei sa intorci NPC-ul)
		heading = 115.0,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
	},
	-- Scafandru Miner
	{
		coords = vector3(-1593.0306396484,5203.0405273438,3.3100943565369),
		holo = {-1593.0306396484,5203.0405273438,4.3100943565369},
		npc = 's_m_y_airworker',
		text = 'Lucian Marin',

		-- Data meniu
		meniu = 'scafandruminer',
		rolNPC = 'Job: Scafandru',
		descriereMeniu = 'Cu ce te pot ajuta ?',

		-- Camera jucator (nu modifica -> decat heading daca vrei sa intorci NPC-ul)
		heading = 290.0,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
	},
	-- Gunoier
	{
		coords = vector3(-621.21319580078,-1640.3040771484,25.126733779907),
		holo = {-621.21319580078,-1640.3040771484,26.126733779907},
		npc = 's_m_y_airworker',
		text = 'Lucian Dobre',

		-- Data meniu
		meniu = 'gunoier',
		rolNPC = 'Job: Gunoier',
		descriereMeniu = 'Cu ce te pot ajuta ?',

		-- Camera jucator (nu modifica -> decat heading daca vrei sa intorci NPC-ul)
		heading = 140.0,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
	},
	-- -- ============== Angajare Ilegale ==============-- 

	-- --- Dealer Cocaina
	--  {
	--  	coords = vector3(1959.5289306641,5186.9873046875,46.776798248291),
	--  	holo = {1959.5289306641,5186.9873046875,47.776798248291},
	--  	npc = 's_m_m_bouncer_01',
	--  	text = 'Adrian Popescu',
	--  	-- Data meniu
	--  	meniu = 'cocaina',
	--  	rolNPC = 'Dealer cocaina',
	--  	descriereMeniu = 'Cu ce te pot ajuta ?',
	--  	-- Camera jucator (nu modifica -> decat heading daca vrei sa intorci NPC-ul)
	--  	heading = 10.0,
	--  	camOffset = vector3(0.0, 0.0, 0.0),
	--  	camRotation = vector3(0.0, 0.0, 0.0),
	--  },
	--  -- Dealer Marijuana
	--  {
	--  	coords = vector3(1399.2386474609,3602.3986816406,37.94189453125),
	--  	holo = {1399.2386474609,3602.3986816406,38.94189453125},
	--  	npc = 's_m_m_bouncer_01',
	--  	text = 'Sergiu Ursu',
	--  	-- Data meniu
	--  	meniu = 'marijuana',
	--  	rolNPC = 'Dealer Marijuana',
	--  	descriereMeniu = 'Cu ce te pot ajuta ?',
	--  	-- Camera jucator (nu modifica -> decat heading daca vrei sa intorci NPC-ul)
	--  	heading = 10.0,
	--  	camOffset = vector3(0.0, 0.0, 0.0),
	--  	camRotation = vector3(0.0, 0.0, 0.0),
	--  },
	--  -- Dealer Ecstasy
	--  {
	--  	coords = vector3(902.13287353516,-962.81018066406,38.279815673828),
	--  	holo = {902.13287353516,-962.81018066406,39.279815673828},
	--  	npc = 'g_m_m_chiboss_01',
	--  	text = 'Horia Stan',

	--  	-- Data meniu
	--  	meniu = 'ecstasy',
	--  	rolNPC = 'Dealer Ecstasy',
	--  	descriereMeniu = 'Cu ce te pot ajuta ?',

	--  	-- Camera jucator (nu modifica -> decat heading daca vrei sa intorci NPC-ul)
	--  	heading = 80.0,
	--  	camOffset = vector3(0.0, 0.0, 0.0),
	--  	camRotation = vector3(0.0, 0.0, 0.0),
	--  },
	--  -- Dealer Etnobotanice
	--  {
	--  	coords = vector3(-1372.3359375,-308.57815551758,38.710186004639),
	--  	holo = {-1372.3359375,-308.57815551758,39.710186004639},
	--  	npc = 's_m_y_dealer_01',
	--  	text = 'Horia Stan',
	--  	-- Data meniu
	--  	meniu = 'etnobotanice',
	--  	rolNPC = 'Dealer Etnobotanice',
	--  	descriereMeniu = 'Cu ce te pot ajuta ?',

	--  	-- Camera jucator (nu modifica -> decat heading daca vrei sa intorci NPC-ul)
	--  	heading = 200.0,
	--  	camOffset = vector3(0.0, 0.0, 0.0),
	--  	camRotation = vector3(0.0, 0.0, 0.0),
	--  },
	--  	 -- Cumpara Matrite
	--  {
	-- 	coords = vector3(4922.5444335938,-5286.6772460938,-1.78113585710526),
	-- 	holo = {4922.5444335938,-5286.6772460938,-1.08113585710526},
	-- 	npc = 'g_m_m_chiboss_01',
	-- 	text = 'Horia Stan',
	-- 	-- Data meniu
	-- 	meniu = 'matrite',
	-- 	rolNPC = 'Dealer Etnobotanice',
	-- 	descriereMeniu = 'Cu ce te pot ajuta ?',

	-- 	-- Camera jucator (nu modifica -> decat heading daca vrei sa intorci NPC-ul)
	-- 	heading = 2.0,
	-- 	camOffset = vector3(0.0, 0.0, 0.0),
	-- 	camRotation = vector3(0.0, 0.0, 0.0),
	-- },
    --     -- CNN 
	-- {
	-- 	coords = vector3(-592.30859375,-929.83898925781,22.869625091553),
	-- 	holo = {-592.30859375,-929.83898925781,23.869625091553},
	-- 	npc = 'a_f_y_business_01',
	-- 	text = 'ziarista',
	-- 	-- Data meniu
	-- 	meniu = 'cnn',
	-- 	rolNPC = 'Dealer Etnobotanice',
	-- 	descriereMeniu = 'Cu ce te pot ajuta ?',

	-- 	-- Camera jucator (nu modifica -> decat heading daca vrei sa intorci NPC-ul)
	-- 	heading = 90.0,
	-- 	camOffset = vector3(0.0, 0.0, 0.0),
	-- 	camRotation = vector3(0.0, 0.0, 0.0),
	-- },
	-- -- 	-- Vanzare Perico
	-- -- {
	-- -- 	coords = vector3(135.92593383789,-1048.6955566406,28.151815414429),
	-- -- 	holo = {135.92593383789,-1048.6955566406,29.151815414429},
	-- -- 	npc = 's_m_y_dealer_01',
	-- -- 	text = 'Vanzatorul de Perico Pistol',
	-- -- 	-- Data meniu
	-- -- 	meniu = 'perico',
	-- -- 	rolNPC = 'Dealer Etnobotanice',
	-- -- 	descriereMeniu = 'Cu ce te pot ajuta ?',

	-- -- 	-- Camera jucator (nu modifica -> decat heading daca vrei sa intorci NPC-ul)
	-- -- 	heading = 150.0,
	-- -- 	camOffset = vector3(0.0, 0.0, 0.0),
	-- -- 	camRotation = vector3(0.0, 0.0, 0.0),
	-- -- },
}

-- Config.tables = {
-- 	-- Etnobotanice
-- 	{coords = vector3(-1369.142578125,-316.32019042969,39.5539894104), process = "pulse", radius = 20, job = "Dealer Etnobotanice", ore = 100},
-- 	{coords = vector3(-1367.8391113281,-318.58303833008,39.513072967529), process = "pulse", radius = 20,job = "Dealer Etnobotanice", ore = 100},
-- 	{coords = vector3(-1366.6040039063,-320.79598999023,39.473392486572), process = "pulse", radius = 20,job = "Dealer Etnobotanice", ore = 100},

-- 	{coords = vector3(-1366.3560791016,-317.48767089844,39.56128692627), process = "specialgold", radius = 20,job = "Dealer Etnobotanice", ore = 100},
-- 	{coords = vector3(-1364.9664306641,-319.96420288086,39.516227722168), process = "specialgold", radius = 20,job = "Dealer Etnobotanice", ore = 100},
-- 	{coords = vector3(-1367.5758056641,-315.44107055664,39.597553253174), process = "specialgold", radius = 20,job = "Dealer Etnobotanice", ore = 100},

-- 	-- Marijuana
-- 	{coords = vector3(1391.8005371094,3606.0241699219,38.941963195801), process = "maruntire_marijuana", radius = 20,job = "Dealer Marijuana", ore = 25},
-- 	{coords = vector3(1394.5075683594,3601.8359375,38.941944122314), process = "maruntire_marijuana", radius = 20,job = "Dealer Marijuana", ore = 25},
-- 	{coords = vector3(1388.998046875,3605.5876464844,38.941955566406), process = "marijuana", radius = 20,job = "Dealer Marijuana", ore = 25},
-- 	{coords = vector3(1389.7291259766,3603.3862304688,38.941875457764), process = "marijuana", radius = 20,job = "Dealer Marijuana", ore = 25},

-- 	-- Ecstasy
-- 	{coords = vector3(892.94152832031,-960.79693603516,39.27982711792), process = "ecstasy", radius = 20,job = "Dealer Ecstasy", ore = 75},
-- 	{coords = vector3(890.97564697266,-958.99163818359,39.27986907959), process = "ecstasy", radius = 20,job = "Dealer Ecstasy", ore = 75},
-- 	{coords = vector3(889.01263427734,-960.68414306641,39.279876708984), process = "ecstasy", radius = 20,job = "Dealer Ecstasy", ore = 75},

-- 	-- Cocaina
-- 	{coords = vector3(1955.5075683594,5180.8002929688,47.983757019043), process = "cocaina", radius = 20, job = "Dealer Cocaina", ore = 50},
-- 	{coords = vector3(1950.9990234375,5180.8452148438,47.983772277832), process = "cocaina", radius = 20, job = "Dealer Cocaina", ore = 50},
-- 	{coords = vector3(1955.5079345703,5179.1352539062,47.983776092529), process = "cocaina", radius = 20, job = "Dealer Cocaina", ore = 50},
-- 	{coords = vector3(1951.2451171875,5179.1318359375,47.983776092529), process = "cocaina", radius = 20, job = "Dealer Cocaina", ore = 50},
-- }

-- Config.procesItems = {
-- 	-- Marijuana
-- 	['maruntire_marijuana'] = {
-- 		NumeMasa = 'Maruntire Marijuana',
-- 		Produs = 'marijuanaprocesata', -- Itemul care rezulta in final
-- 		NumarIteme = 10,
-- 		TimpDeProducere = 10000, -- in secunde
-- 		nrItemeNecesare = 1,
-- 		Necesare = {
-- 			['frunzamarijuana'] = 1
-- 		},
-- 	},
-- 	['marijuana'] = {
-- 		NumeMasa = 'Marijuana',
-- 		Produs = 'marijuana', -- Itemul care rezulta in final
-- 		NumarIteme = 1,
-- 		TimpDeProducere = 10000, -- in secunde
-- 		nrItemeNecesare = 2,
-- 		Necesare = {
-- 			['marijuanaprocesata'] = 10,
-- 			['folie'] = 1,
-- 		},
-- 	},
-- 	-- Etnobotanice
-- 	['pulse'] = {
-- 		NumeMasa = 'Pulse',
-- 		Produs = 'pulse', -- Itemul care rezulta in final
-- 		NumarIteme = 1,
-- 		TimpDeProducere = 10000, -- in secunde
-- 		nrItemeNecesare = 2,
-- 		Necesare = {
-- 			['ingrasamant'] = 25,
-- 			['acetona'] = 25,
-- 		},
-- 	},
-- 	['specialgold'] = {
-- 		NumeMasa = 'Special Gold',
-- 		Produs = 'specialgold', -- Itemul care rezulta in final
-- 		NumarIteme = 1,
-- 		TimpDeProducere = 10000, -- in secunde
-- 		nrItemeNecesare = 2,
-- 		Necesare = {
-- 			['ingrasamant'] = 25,
-- 			['otrava'] = 25,
-- 		},
-- 	},
-- 	-- Cocaina
-- 	['cocaina'] = {
-- 		NumeMasa = 'Cocaina',
-- 		Produs = 'cocainah', -- Itemul care rezulta in final
-- 		NumarIteme = 1,
-- 		TimpDeProducere = 10000, -- in secunde
-- 		nrItemeNecesare = 2,
-- 		Necesare = {
-- 			['pastacoca'] = 1,
-- 			['diluant'] = 3,
-- 		},
-- 	},

-- 	-- Ecstasy
-- 	['ecstasy'] = {
-- 		NumeMasa = 'Ecstasy',
-- 		Produs = 'ecstasy', -- Itemul care rezulta in final
-- 		NumarIteme = 1,
-- 		TimpDeProducere = 10000, -- in secunde
-- 		nrItemeNecesare = 3,
-- 		Necesare = {
-- 			['metamfetamina'] = 20,
-- 			['pliculet'] = 1,
-- 			['efedrina'] = 5,
-- 		},
-- 	},
-- }

-- Config.PlantTypes = {
--     ["plant1"] = {
--         small = {"bkr_prop_weed_01_small_01a", -1.65},
--         medium = {"bkr_prop_weed_med_01a", -4.2},
--         large = {"bkr_prop_weed_lrg_01a", -4.0}
--     }
-- }

-- Config.PlantLocations = {
-- 	[1] = {coords = vector3(2535.7790527344,4819.404296875,34.044075012207), radius = 30}
-- }

-- Config.OreIlegale = {
--   ['Dealer Cocaina'] = 600,
--   ['Dealer Marijuana'] = 800,
--   ['Dealer Ecstasy'] = 500,
--   ['Dealer Etnobotanice'] = 400,
-- }