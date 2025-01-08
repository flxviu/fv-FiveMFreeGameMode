local cfg = {}
cfg.sell_factor = 0.5

cfg.garage_types = {
  	["Civil"] = {
		_config = {vtype="car",blipid=524,blipcolor=0,icon=0,iconColor={41,234,23},hasbuy=false,tosell=false},
		---matamare
		["mach1"] = {"Discord Booster",0, ""},
		["tw_ar3sb"] = {"Masina Finu 5 euro",0, ""},
		----matamare masini normale
		["db11"] = {"🚗Aston Martin DB11",0, ""},
	["r820"] = {"🚗Audi R8",0, ""},
	["rs7"] = {"🚗Audi RS7",0, ""},
	["audirs6tk"] = {"🚗Audi RS6",0, ""},
	["17m760i"] = {"🚗BMW M760i",0, ""},
	["745le"] = {"🚗BMW 745le",0, ""},
	["m6f13"] = {"🚗BMW M6f13",0, ""},
	["bugatti"] = {"🚗Bugatti Veyron",0, ""},
	["divo"] = {"🚗Bugatti Divo",0, ""},
	["bbentayga"] = {"🚗Bentley Bentaya",0, ""},
	["ben17"] = {"🚗Bentley SuperSport",0, ""},
	["contgt13"] = {"🚗Bentley Continental",0, ""},
	["c7"] = {"🚗Chevrolet Corvette",0, ""},
	["limoxts"] = {"🚗Cadilac XCL Limo",0, ""},
	["fct"] = {"🚗Ferrari California",0, ""},
	["gtc4"] = {"🚗Ferrari GTC Lusso",0, ""},
	["17jamb"] = {"🚗Ford Camper",0, ""},
	["gt17"] = {"🚗Ford GT",0, ""},
	["fgt"] = {"🚗Ford GT 2005",0, ""},
	["918"] = {"🚗Porsche 918 Spider",0, ""},
	["16charger"] = {"🚗Dodge Charger",0,""},
	["911t4s2"] = {"🚗Porsche 911 Targa 4S",0, ""},
	["lamboavj"] = {"🚗Lamborghini Aventador",0, ""},
	["lp610"] = {"🚗Lamborghini Huracan",0, ""},
	["rmodsian"] = {"🚗Lamborghini Sian",0, ""},
	["wmfenyr"] = {"🚗Lykan HyperSport",0, ""},
	["c63s"] = {"🚗Mercedes C63SAMG",0, ""},
	["g65amg"] = {"🚗Mercedes G65AMG",0, ""},
	["s500w222"] = {"🚗Mercedes S500",0, ""},
	["mers63c"] = {"🚗Mercedes S63C",0, ""},
	["amggtsmansory"] = {"🚗Mercedes GTS AMG",0, ""},
	["amggtrr20"] = {"🚗Mercedes GTR AMG",0, ""},
	["e63amg"] = {"🚗Mercedes E63AMG",0, ""},
	["brabus850"] = {"🚗Mercedes AMG850",0, ""},
	["19S63"] = {"🚗Mercedes Brabus 800",0, ""},
	["mp412c"] = {"🚗MClaren MP4",0, ""},
	["morgan"] = {"🚗Morgan Aero 8",0, ""},
	["tulenis"] = {"🚗Nissan Patrol Nismo",0, ""},
	["rmodpagani"] = {"🚗PaganiHuayra RoadSter",0, ""},
	["paganizonda"] = {"🚗Pagani Zonda",0, ""},
	["cullinan"] = {"🚗Rolls-Royce Cullinan",0, ""},
	["dawnonyx"] = {"🚗Rolls-Royce-Down Onyx",0, ""},
	["911turboS"] = {"🚗Porsche 911TurboS",0, ""},
	["agerars"] = {"🚗Koenigsegg Agera RS",0, ""},
	["regalia"] = {"🚗Quartz Regalia",0, ""},
---------------------CLASA B
	["a6avant"] = {"🚗Audi A6 Avant",0, ""},
	["rs318"] = {"🚗Audi RS3",0, ""},
	["rs52018"] = {"🚗Audi RS5 2018",0, ""},
	["as7"] = {"🚗Audi Q7 ABT",0, ""},
	["audiq8"] = {"🚗Audi Q8 2019",0, ""},
	["a8fsi"] = {"🚗Audi A8 FSI",0, ""},
	["ttrs"] = {"🚗Audi TTRS",0, ""},
	["m3f80"] = {"🚗BMW M3f80",0, ""},
	["f82"] = {"🚗BMW M4",0, ""},
	["m4c"] = {"🚗BMW M4 Cabrio",0, ""},
	["m516"] = {"🚗BMW M5f10",0, ""},
	["x5m13"] = {"🚗BMW X5M",0, ""},
	["48is"] = {"🚗BMW X5 Custom",0, ""},
	["tmodel"] = {"🚗Tesla Model 3",0,""},
	["440i"] = {"🚗BMW 440i xDrive",0, ""},
	["ctsv16"] = {"🚗Cadillac CTSV",0,""},
	["530d"] = {"🚗BMW 530i xDrive",0, ""},
	["m2"] = {"🚗BMW M2",0, ""},
	["m3e92"] = {"🚗BMW M3E92",0, ""},
	["z3m"] = {"🚗BMW Z3M",0, ""},
	["czr2"] = {"🚗Chevrolet Colorado",0, ""},
	["16ss"] = {"🚗Chevrolet Camaro",0, ""},
	["can"] = {"🚗Can-Am Maverick X3",0, ""},
	["16challenger"] = {"🚗Dodge Challenger SRT",0, ""},
	["nspeedo"] = {"🚗Duba Speedo",0, ""},
	["mgt"] = {"🚗Ford Mustang GT",0, ""},
	["brz13"] = {"🚗Subaru BRZ",0, ""},
	["fastback"] = {"🚗Ford Mustang 1967",0, ""},
	["f150"] = {"🚗Ford Raptor",0, ""},
	["wildtrak"] = {"🚗Ford Bronco",0, ""},
	["18macan"] = {"🚗Porsche Macan Turbo",0, ""},
	["gmc1500"] = {"🚗GMC Sierra",0, ""},
	["subisti08"] = {"🚗Subaru VRX STI",0,""},
	["brztuning"] = {"🚗Subaru BRZ",0,""},
	["denalihd"] = {"🚗GMC Denali",0, ""},
	["jeep2012"] = {"🚗Jeep Wrangler",0, ""},
	["jp12"] = {"🚗Jeep Wrangler Rubicon",0, ""},
	["jeepg"] = {"🚗Jeep Gladiator",0, ""},
	["mlbrabus"] = {"🚗Mercedes ML Brabus",0, ""},
	["xclass"] = {"🚗Mercedes XClass",0, ""},
	["e400"] = {"🚗Mercedes E400",0, ""},
	["cls2015"] = {"🚗Mercedes CLS 2015",0, ""},
	["gl63"] = {"🚗Mercedes GL63 2016",0, ""},
	["cla45"] = {"🚗Mercedes CLA45 AMG",0, ""},
	["evo10"] = {"🚗Mitsubishi Evo 10",0, ""},
	["na1"] = {"🚗Honda NSX 1990",0,""},
	["370z"] = {"🚗Nissan Nismo 370Z",0, ""},
	["rrst"] = {"🚗RangeRover SuperSport",0, ""},
	["fjcruiser"] = {"🚗Toyota Fj Cruiser",0, ""},
	["golf7gti"] = {"🚗VW Golf 7 GTI",0, ""},
	["xc60"] = {"🚗Volvo XC60",0, ""},
---------------------CLASA C
	["a8audi"] = {"🚗Audi A8 2005",0, ""},
	["c5rs6"] = {"🚗Audi A6 2003",0, ""},
	["b5s4"] = {"🚗Audi S4",0, ""},
	["e46"] = {"🚗BMW M3e46",0, ""},
	["m3e36"] = {"🚗BMW M3e36",0, ""},
	["850csi"] = {"🚗BMW 850csi",0, ""},
	["m3e30"] = {"🚗BMW M3e30",0, ""},
	["bmwe39"] = {"🚗BMW M5e39",0, ""},
	["M5E28"] = {"🚗BMW M5e28",0, ""},
	["e34"] = {"🚗BMW M5e34",0, ""},
	["m5e60"] = {"🚗BMW M5e60",0, ""},
	["bmwe90"] = {"🚗BMW E90",0, ""},
	["sobol"] = {"🚗Duba Sobol",0, ""},
	["e15082"] = {"🚗Duba Ford",0, ""},
	["speedo"] = {"🚗Duba Speedo 1500",0, ""},
	["steed2"] = {"🚗Duba Steed",0, ""},
	["1310s"] = {"🚗Dacia 1310 Sport",0, ""},
	["logan"] = {"🚗Dacia Logan",0, ""},
	["daduster"] = {"🚗Dacia Duster",0, ""},
	["sandero08"] = {"🚗Dacia Sandero",0, ""},
	["sanderos"] = {"🚗Dacia Sandero Stepway",0, ""},
	["sandero"] = {"🚗Dacia Sandero",0, ""},
	["sanderos2"] = {"🚗Dacia Sandero Stepway",0, ""},
	["festivac"] = {"🚗Ford Festiva",0, ""},
	["ap2"] = {"🚗Honda S2000",0, ""},
	["civic"] = {"🚗Honda Civic",0, ""},
	["na6"] = {"🚗Mazda MX-5 Miata",0, ""},
	["benzc32"] = {"🚗Mercedes-Benz C32",0, ""},
	["w210amg"] = {"🚗Mercedes-Benz E55",0, ""},
	["MBW124"] = {"🚗Mercedes-Benz 300D",0, ""},
	["nissunny"] = {"🚗Nissan Sunny",0, ""},
	["2dopelr3"] = {"🚗Opel Rekord",0, ""},
	["206c"] = {"🚗Peugeot 206",0, ""},
	["rrs08"] = {"🚗Range Rover",0, ""},
	["twizy"] = {"🚗Renault Twizy",0, ""},
	["r50"] = {"🚗VW Touareg R50",0, ""},
	["golf1"] = {"🚗VW Golf1",0, ""},
	["golf2"] = {"🚗VW Golf2",0, ""},
	["golfgti"] = {"🚗VW Golf5",0, ""},
	["celisupra"] = {"🚗Toyota CliSupra",0, ""},
	["yaris08hb"] = {"🚗Toyota Yaris HB",0, ""},
	["yaris08"] = {"🚗Toyota Yaris",0, ""},
	["tico"] = {"🚗Daewoo Tico",0, ""},
	["v242"] = {"🚗Volvo v242",0, ""},
	["volvo850r"] = {"🚗Volvo 850r",0, ""},
	["audquattros"] = {"🚗 Audi Quattro S",0,""},
------------------MOTOCICLETE
	["rsv4"] = {"🚗Aprilia RSV4",0, ""},
	["blazer6"] = {"🚗Atv Blazer",0, ""},
	["monsteratv"] = {"🚗ATV Monster",0, ""},
	["verus"] = {"🚗ATV Verus",0, ""},
	["bmws"] = {"🚗BMW S1000RR",0, ""},
	["diavel"] = {"🚗Ducati Diavel",0, ""},
	["cb500x"] = {"🚗Honda CB500X",0, ""},
	["bros60"] = {"🚗Honda Bros",0, ""},
	["goldwing"] = {"🚗Honda GoldWing",0, ""},
	["africat"] = {"🚗Honda Africat",0, ""},
	["hvrod"] = {"🚗Harley-Davidson Street",0, ""},
	["foxharley1"] = {"🚗Harley-Davidson SoftAil",0, ""},
	["foxharley2"] = {"🚗Harley-Davidson Touring",0, ""},
	["h2carb"] = {"🚗Kawasaki H2",0, ""},
	["z1000"] = {"🚗Kawasaki Z1000",0, ""},
	["ktmsm"] = {"🚗SXF450",0, ""},
	["models"] = {"🚗Tesla Model S",0, ""},
	["stryder"] = {"🚗Spyder",0, ""},
	["tmsm"] = {"🚗TMF450",0, ""},
	["r1"] = {"🚗Yamaha R1",0, ""},
	["20r1"] = {"🚗Yamaha R1-2020",0, ""},
	["r6"] = {"🚗Yamaha R6",0, ""},
	["tmaxDX"] = {"🚗Yamaha TMax",0, ""},
	["r25"] = {"🚗Yamaha YZF-R25",0, ""},
	["bullet"] = {"🚗Bullet",0, ""},
	["lp700r"] = {"🚗Masina ruleta",0, ""},
-------------VIP
	["rmodrs6"] = {"🚗Audi RS6",0, ""},
	["rmodjeep"] = {"🚗Jeep Hwak",0, ""},
	["taigun21"] = {"🚗Tiguan",0, ""},
	["benze55"] = {"🚗Mercedes E55",0, ""},
	["z3"] = {"🚗Bmw z3",0, ""},
	["logan21"] = {"🚗Logan 2021",0, ""},
	["rmodx6"] = {"🚘BMW X6M VIP",0, ""},
	["22m2cs"] = {"🚘BMW M2 VIP",0, ""},
	["mk8r"] = {"🚘Golf R VIP",0, ""},
	["sf90"] = {"🚘Ferrari SF90 VIP",0, ""},
	["bmci"] = {"🚘BMW M5 VIP",0, ""},
	["rmodbmwi8"] = {"🚘BMW I8 VIP",0, ""},
	["f812"] = {"🚘Ferrari F812 VIP",0, ""},
	["urus"] = {"🚘Lamborghini Urus VIP",0, ""},
	["rmodgt63"] = {"🚘Mercedes GT63S VIP",0, ""},
	["bmwm8"] = {"🚘BMW M8 VIP",0, ""},
	["bmwm4"] = {"🚘BMW M4 2021 VIP",0, ""},
	["tdf"] = {"🚘Ferrari F12 VIP",0, ""},
	["fxxk2"] = {"🚘Ferrari FXX-K VIP",0, ""},
	["rmodveneno"] = {"🚘Lamborghini Veneno VIP",0, ""},
	["rmodskyline"] = {"🚘Nissan GTR VIP",0, ""},
	["chiron17"] = {"🚘Bugatti Chiron VIP",0, ""},
	["aperta"] = {"🚘Ferrari LaFerrari VIP",0, ""},
	["apollos"] = {"🚘Gumpert Apollo s VIP",0, ""},
	["lp770r"] = {"🚘Lambo Centenario VIP",0, ""},
	["rmodlp570"] = {"🚘Lamborghini Gallardo VIP",0, ""},
	["senna"] = {"🚘MClaren Senna VIP",0, ""},
	["rmodsupra"] = {"🚘Toyota Supra VIP",0, ""},
	------ LA PLATA
	["rmodm4"] = {"PLATA LA LAZAZA 5 EURO",0, ""}

	},
	["Bicicleta"] = {
		_config = {vtype="bike",blipid=376,blipcolor=3,icon=38,iconColor={41,234,23},hasbuy=true,tosell=true},
		["bmx"] = {"Bicicleta BMX",5000,"<font color='purple'>Bicicleta BMX de dus pana la Showroom si inapoi</font>"},
		["cruiser"] = {"Bicicleta Cruiser",750,"<font color='purple'>Bicicleta Cruiser de dus pana la Showroom si inapoi</font>"},
		["fixter"] = {"Bicicleta Fixter",1500,"<font color='purple'>Bicicleta Fixter de dus pana la Showroom si inapoi</font>"},
		["scorcher"] = {"Bicicleta Scorcher",3250,"<font color='purple'>Bicicleta Scorcher de dus pana la Showroom si inapoi</font>"},
		["tribike"] = {"Bicicleta Tribike",4250,"<font color='purple'>Bicicleta Tribike de dus pana la Showroom si inapoi</font>"},
		["tribike2"] = {"Bicicleta Tribike 2",4250,"<font color='purple'>Bicicleta Tribike 2 de dus pana la Showroom si inapoi</font>"}
	},
	["Garaj Barca"] = {
		_config = {vtype="car",blipid=410,blipcolor=1,icon=35,iconColor={255,0,0},hasbuy=true,tosell=false},
		["seashark"] = {"💧Jetski",5500000, ""},
		["Dinghy"] = {"💧Dinghy",10000000, ""},
		["longfin"] = {"💧Longfin",25300000, ""},
	    ["avisa"] = {"💧Submarin Avisa",55000000, ""},
	},
	["Garaj Cayo"] = {
		_config = {vtype="car",blipid=756,blipcolor=63,icon=0,iconColor={0,71,122},hasbuy=true,tosell=false},
		["bodhi2"] = {"🚗Bodhi",7600000, ""},
		["bifta"] = {"🚗Bifta",6500000, ""},
		["Hellion"] = {"🚗Hellion",12500000, ""},
		["manchez"] = {"Manchez",10000000, ""},
		["outlaw"] = {"🚗Nagasaki Off-Road",15500000, ""},
	},
	
	["Mecanic"] = {
		_config = {vtype="car",blipid=56,blipcolor=51,icon=0,iconColor={255,140,0},faction = "Mecanic",hasbuy=true},
		["towtruck"] = {"Masina Mecanic", 0,""}
	},
	["VIP Bronze"] = {
		_config = {vtype="car",blipid=0,blipcolor=07,icon=0,iconColor={202, 143, 7},hasbuy=true,tosell=false,vip=1},
		["mk8r"] = {"🚘Golf R VIP",0, ""},
		["22m2cs"] = {"🚘BMW M2 VIP",0, ""},
		["rmodcharger"] = {"🚘Dodge Charger VIP",0, ""},
		["bmci"] = {"🚘BMW M5 VIP",0, ""},
	},
	["VIP Silver"] = {
		_config = {vtype="car",blipid=56,blipcolor=39,icon=0,iconColor={120, 120, 120},hasbuy=true,tosell=false,vip=2},
		["mk8r"] = {"🚘Golf R VIP",0, ""},
		["22m2cs"] = {"🚘BMW M2 VIP",0, ""},
		["rmodcharger"] = {"🚘Dodge Charger VIP",0, ""},
		["bmci"] = {"🚘BMW M5 VIP",0, ""},

		["bmwm8"] = {"🚘BMW M8 VIP",0, ""},
		["rmoddarki8"] = {"🚘BMW i8 Dark VIP",0, ""},
		["bmwm4"] = {"🚘BMW M4 2021 VIP",0, ""},
	},
	["VIP Gold"] = {
		_config = {vtype="car",blipid=56,blipcolor=46,icon=0,iconColor={255, 216, 0},hasbuy=true,tosell=false,vip=3},
		["mk8r"] = {"🚘Golf R VIP",0, ""},
		["22m2cs"] = {"🚘BMW M2 VIP",0, ""},
		["rmodcharger"] = {"🚘Dodge Charger VIP",0, ""},
		["bmci"] = {"🚘BMW M5 VIP",0, ""},

		["bmwm8"] = {"🚘BMW M8 VIP",0, ""},
		["rmoddarki8"] = {"🚘BMW i8 Dark VIP",0, ""},
		["bmwm4"] = {"🚘BMW M4 2021 VIP",0, ""},

		["f812"] = {"🚘Ferrari F812 VIP",0, ""},
		["x6m47"] = {"🚘BMW X6M Black",0,""}, 
		["rmodmk7"] = {"🚘GOLF 7 VIP",0, ""},
		["sf90"] = {"🚘Ferrari SF90 VIP",0, ""},
  	},
  	["VIP Diamond"] = {
		_config = {vtype="car",blipid=56,blipcolor=57,icon=0,iconColor={0, 182, 255},hasbuy=true,tosell=false,vip=4},
		["mk8r"] = {"🚘Golf R VIP",0, ""},
		["22m2cs"] = {"🚘BMW M2 VIP",0, ""},
		["rmodcharger"] = {"🚘Dodge Charger VIP",0, ""},
		["bmci"] = {"🚘BMW M5 VIP",0, ""},

		["bmwm8"] = {"🚘BMW M8 VIP",0, ""},
		["rmoddarki8"] = {"🚘BMW i8 Dark VIP",0, ""},
		["bmwm4"] = {"🚘BMW M4 2021 VIP",0, ""},
		["17onyxbtg"] = {"🚘BMW XM VIP",0, ""},

		["f812"] = {"🚘Ferrari F812 VIP",0, ""},
		["x6m47"] = {"🚘BMW X6M Black",0,""}, 
		["rmodmk7"] = {"🚘GOLF 7 VIP",0, ""},
		["sf90"] = {"🚘Ferrari SF90 VIP",0, ""},

		["wbleurion"] = {"🚘RR Mansory VIP",0, ""},
		["rmodskyline"] = {"🚘Nissan GTR VIP",0, ""},
  	},
  	["VIP Emerald"] = {
    	_config = {vtype="car",blipid=56,blipcolor=2,icon=0,iconColor={0, 204, 0},hasbuy=true,tosell=false,vip=5},
		["mk8r"] = {"🚘Golf R VIP",0, ""},
		["22m2cs"] = {"🚘BMW M2 VIP",0, ""},
		["rmodcharger"] = {"🚘Dodge Charger VIP",0, ""},
		["bmci"] = {"🚘BMW M5 VIP",0, ""},

		["bmwm8"] = {"🚘BMW M8 VIP",0, ""},
		["rmoddarki8"] = {"🚘BMW i8 Dark VIP",0, ""},
		["bmwm4"] = {"🚘BMW M4 2021 VIP",0, ""},
		["17onyxbtg"] = {"🚘BMW XM VIP",0, ""},

		["f812"] = {"🚘Ferrari F812 VIP",0, ""},
		["x6m47"] = {"🚘BMW X6M Black",0,""}, 
		["rmodmk7"] = {"🚘GOLF 7 VIP",0, ""},
		["sf90"] = {"🚘Ferrari SF90 VIP",0, ""},

		["wbleurion"] = {"🚘RR Mansory VIP",0, ""},
		["rmodskyline"] = {"🚘Nissan GTR VIP",0, ""},

		["r35kream"] = {"🚘Nissan GTR R35",0, ""},
		["rs7c8wb"] = {"🚘Audi RS7 C8",0, ""}, 
		["rmodsvj"] = {"🚘Lamborghini SVJ VIP",0, ""},
		["rmodsupra"] = {"🚘Toyota Supra VIP",0, ""},
		["rmodgt63"] = {"🚘Mercedes GT63S VIP",0, ""},
		["rmodveneno"] = {"🚘Lamborghini Veneno VIP",0, ""},
		["fxxk2"] = {"🚘Ferrari FXX-K VIP",0, ""},
		["aperta"] = {"🚘Ferrari LaFerrari VIP",0, ""},
	},

	["Politia Romana - Elicopter"] = {
		_config = {vtype="car", blipid=43, blipcolor=42, icon=34, iconColor={0,142,255}, faction = "Politie", hasbuy = true},
		["supervolito"]= {"Elicopter", 0, ""}
	},
	  
	["Taxi"] = {
		_config = {vtype="car",blipid=56,blipcolor=60,icon=0,iconColor={255,192,0},faction = "Taxi",hasbuy=true,tosell=false},
		["taxi"] = {"Masina Taxi", 0,""}
	},

	["Smurd - Elicopter"] = {
		_config = {vtype="car", blipid=43, blipcolor=47, icon=34, iconColor={255,140,0}, faction = "Smurd", hasbuy = true},
		["havok"] = {"Elicopter", 0, ""}
	},

	["Hitman - Elicopter"] = {
		_config = {vtype="car", blipid=43, blipcolor=47, icon=34, iconColor={255,140,0}, faction = "Hitman", hasbuy = true},
		["supervolito2"] = {"Elicopterul Septar", 0, ""},
		["havok"] = {"Hitman Silentios", 0, ""}
	},

	["Politia Romana"] = {
		_config = {vtype="car", blipid=56, blipcolor=42, icon=0, iconColor={0,142,255}, faction = "Politie", hasbuy = true},
		--["audis4"] = {"🚓Audi S4 Politie",0},
		["police"] = {"🚓BMW Seria 3 Politie",0},
		["dusterpn"] = {"🚓Dacia Duster Politie",0},
		["loganpolitie"] = {"🚓Dacia Logan Politie",0}, 
		["vito"] = {"🚓Mercedes-Benz Vito Politie",0},
		--["passat"] = {"🚓Volkswagen Passat Politie",0},
		["arteonpolitie"] = {"🚓Volkswagen Arteon Politie",0},
		["polchiron"] = {"🚓Bugatti Chiron Politie",0},
		["spc2"] = {"🚓Ford SPC Politie",0},
		["polopolitie"] = {"🚓Polo Politie",0},
		["polgs350"] = {"🚓Lexus Politie",0},
		["policeinsurgent"] = {"🚓Autospeciala DIICOT",0},
		--["skoda"] = {"🚓Skoda Politie",0},
		--["volvopolitie"] = {"🚓Volvo Politie",0},
		["16bugatti"] = {"🚓Bugatti Unmarked",0},
		["e63unmark"] = {"🚓Mercedes E63 Unmarked",0},
		["mercedesunmarked"] = {"🚓Mercedes Unmarked",0},
		["14ram"] = {"🚓Ram Unmarked",0},
		["pd_bmwr"] = {"🚓Bmw Unmarked",0},
	},

	  ["Garaj Jandarmerie"] = {
		_config = {vtype="car", icon=0, iconColor={0,142,255}, faction = "Jandarmerie", hasbuy = true},
		["jandarm"] = {"🚓Mustang Politie",0},
		["g63amg6x6cop"] = {"🚓Mercedes G63 AMG 6X6",0},
		["jandarm3"] = {"🚓Lamborghini Jandarmerie",0},
		["jandarm4"] = {"🚓BMW Jandarmerie",0},
		["jandarm2"] = {"🚓Wrengler Jandarmerie",0},
		["skoda"] = {"🚓Skoda Politie",0},
	  },

	["SMURD"] = {
		_config = {vtype="car",icon=0,iconColor={255,140,0},faction="Smurd", hasbuy = true, tosell = false},
		["ambulance"] = {"🚑Ambulanta Smurd",0, ""},
		["fd2"] = {"🚑Ambulanta Echipament",0, ""},
		["arteonsmurd"] = {"🚑Volkswagen Arteon Smurd",0, ""},
		["jp2"] = {"🚑Jeep Smurd",0, ""},

		["rsb_mbsprinter"] = {"🚑Ambulanta",0, ""},
		["dacia1"] = {"🚑Dacia Duster Smurd",0, ""},
		["ghispo3"] = {"🚑Maserati Smurd",0, ""},
		["cprotection"] = {"🚑Land Rover Smurd",0, ""},
	},

	["Garaj Avioane"] = {
		_config = {vtype="car",icon=0,iconColor={255,140,0}, hasbuy = true, tosell = false},
		["luxor"] = {"Luxor",300000000, ""},
		["shamal"] = {"Shamal",400000000, ""},
	},
	  
	["HITMAN"] = {
		_config = {vtype="car",icon=0,iconColor={255,139,0},faction="Hitman", hasbuy = true, tosell = false},
		["g65amg"] = {"Mercedes G Wagon", 0, ""},
		["bentayga17"] = {"Bentley Bentayga", 0, ""},
		["bmwm8"] = {"BMW M8", 0, ""},
		["divoHitman"] = {"Divo", 0, ""}
	},

	["Garaj Grove Street"] = {
        _config = {vtype="mafie",icon=0,iconColor={255,0,0},blipid=0,blipcolor=0,hasbuy=true,faction = "Grove Street"},
		["gmt900escalade"] = {"🚗Caddilac Escalade",0,""},
		["g63amg6x6"] = {"🚗Mercedes-Benz G63 6x6",0,""},
		["rmodg65"] = {"🚗Mercedes Benz G65 RMOD",0, ""}, 
		["bmwmafiam3"] = {"🚗BMW M3 Break", 0, ""}, 
		["brabus500"] = {"🚗Brabus G Class 500", 0, ""}, 
		["cls19mafia"] = {"🚗Mercedes-Benz CLS 2019", 0, ""}, 

		--["g634x4byv"] = {"🚗Mercedes Benz G63 4x4 Mafia Car 1",0, ""}, -- 10e
		--["e60"] = {"🚗BMW E60 Mafia Car 2",0, ""}, -- 10e
		--["rolls6x6"] = {"🚗Rolls Royce 6x6 Mafia Car 3",0, ""}, -- 20e
		--["rrghostbyv"] = {"🚗Rolls Royce Limo Mafia Car 4",0, ""}, 
		--["rollsmb"] = {"🚗Rolls Royce Mafia Car 5",0, ""}, -- 20e
		--["rollsmafia"] = {"🚗Rolls Royce Mafia Car 6",0, ""}, -- 30e
		--["w223s500_S900_emrEHusmen"] = {"🚗Rolls Royce Mafia Car 8",0,""} -- 40e
    },

	["Garaj Los Vagos"] = {
        _config = {vtype="mafie",icon=0,iconColor={255,0,0},blipid=0,blipcolor=0,hasbuy=true,faction = "Los Vagos"},
		["gmt900escalade"] = {"🚗Caddilac Escalade",0,""},
		["g63amg6x6"] = {"🚗Mercedes-Benz G63 6x6",0,""},
		["rmodg65"] = {"🚗Mercedes Benz G65 RMOD",0, ""}, 
		["bmwmafiam3"] = {"🚗BMW M3 Break", 0, ""}, 
		["brabus500"] = {"🚗Brabus G Class 500", 0, ""}, 
		["cls19mafia"] = {"🚗Mercedes-Benz CLS 2019", 0, ""}, 

		--["g634x4byv"] = {"🚗Mercedes Benz G63 4x4 Mafia Car 1",0, ""}, -- 10e
		--["e60"] = {"🚗BMW E60 Mafia Car 2",0, ""}, -- 10e
		--["rolls6x6"] = {"🚗Rolls Royce 6x6 Mafia Car 3",0, ""}, -- 20e
		--["rrghostbyv"] = {"🚗Rolls Royce Limo Mafia Car 4",0, ""}, 
		--["rollsmb"] = {"🚗Rolls Royce Mafia Car 5",0, ""}, -- 20e
		--["rollsmafia"] = {"🚗Rolls Royce Mafia Car 6",0, ""}, -- 30e
		--["w223s500_S900_emrEHusmen"] = {"🚗Rolls Royce Mafia Car 8",0,""} -- 40e
    },

	["Garaj Los Aztecas"] = {
        _config = {vtype="mafie",icon=0,iconColor={255,0,0},blipid=0,blipcolor=0,hasbuy=true,faction = "Los Aztecas"},
		["gmt900escalade"] = {"🚗Caddilac Escalade",0,""},
		["g63amg6x6"] = {"🚗Mercedes-Benz G63 6x6",0,""},
		["rmodg65"] = {"🚗Mercedes Benz G65 RMOD",0, ""}, 
		["bmwmafiam3"] = {"🚗BMW M3 Break", 0, ""}, 
		["brabus500"] = {"🚗Brabus G Class 500", 0, ""}, 
		["cls19mafia"] = {"🚗Mercedes-Benz CLS 2019", 0, ""}, 

		--["g634x4byv"] = {"🚗Mercedes Benz G63 4x4 Mafia Car 1",0, ""}, -- 10e
		--["e60"] = {"🚗BMW E60 Mafia Car 2",0, ""}, -- 10e
		--["rolls6x6"] = {"🚗Rolls Royce 6x6 Mafia Car 3",0, ""}, -- 20e
		--["rrghostbyv"] = {"🚗Rolls Royce Limo Mafia Car 4",0, ""}, 
		--["rollsmb"] = {"🚗Rolls Royce Mafia Car 5",0, ""}, -- 20e
		--["rollsmafia"] = {"🚗Rolls Royce Mafia Car 6",0, ""}, -- 30e
		--["w223s500_S900_emrEHusmen"] = {"🚗Rolls Royce Mafia Car 8",0,""} -- 40e
    },

	["Garaj The Demons"] = {
        _config = {vtype="mafie",icon=0,iconColor={255,0,0},blipid=0,blipcolor=0,hasbuy=true,faction = "The Demons"},
		["gmt900escalade"] = {"🚗Caddilac Escalade",0,""},
		["g63amg6x6"] = {"🚗Mercedes-Benz G63 6x6",0,""},
		["rmodg65"] = {"🚗Mercedes Benz G65 RMOD",0, ""}, 
		["bmwmafiam3"] = {"🚗BMW M3 Break", 0, ""}, 
		["brabus500"] = {"🚗Brabus G Class 500", 0, ""}, 
		["cls19mafia"] = {"🚗Mercedes-Benz CLS 2019", 0, ""}, 

		--["g634x4byv"] = {"🚗Mercedes Benz G63 4x4 Mafia Car 1",0, ""}, -- 10e
		--["e60"] = {"🚗BMW E60 Mafia Car 2",0, ""}, -- 10e
		--["rolls6x6"] = {"🚗Rolls Royce 6x6 Mafia Car 3",0, ""}, -- 20e
		--["rrghostbyv"] = {"🚗Rolls Royce Limo Mafia Car 4",0, ""}, 
		--["rollsmb"] = {"🚗Rolls Royce Mafia Car 5",0, ""}, -- 20e
		--["rollsmafia"] = {"🚗Rolls Royce Mafia Car 6",0, ""}, -- 30e
		--["w223s500_S900_emrEHusmen"] = {"🚗Rolls Royce Mafia Car 8",0,""} -- 40e
    },

	["Garaj Bloods"] = {
        _config = {vtype="mafie",icon=0,iconColor={255,0,0},blipid=0,blipcolor=0,hasbuy=true,faction = "Bloods"},
		["gmt900escalade"] = {"🚗Caddilac Escalade",0,""},
		["g63amg6x6"] = {"🚗Mercedes-Benz G63 6x6",0,""},
		["rmodg65"] = {"🚗Mercedes Benz G65 RMOD",0, ""}, 
		["bmwmafiam3"] = {"🚗BMW M3 Break", 0, ""}, 
		["brabus500"] = {"🚗Brabus G Class 500", 0, ""}, 
		["cls19mafia"] = {"🚗Mercedes-Benz CLS 2019", 0, ""}, 

		--["g634x4byv"] = {"🚗Mercedes Benz G63 4x4 Mafia Car 1",0, ""}, -- 10e
		--["e60"] = {"🚗BMW E60 Mafia Car 2",0, ""}, -- 10e
		--["rolls6x6"] = {"🚗Rolls Royce 6x6 Mafia Car 3",0, ""}, -- 20e
		--["rrghostbyv"] = {"🚗Rolls Royce Limo Mafia Car 4",0, ""}, 
		--["rollsmb"] = {"🚗Rolls Royce Mafia Car 5",0, ""}, -- 20e
		--["rollsmafia"] = {"🚗Rolls Royce Mafia Car 6",0, ""}, -- 30e
		--["w223s500_S900_emrEHusmen"] = {"🚗Rolls Royce Mafia Car 8",0,""} -- 40e
    },

	["Garaj Mafia Albaneza"] = {
        _config = {vtype="mafie",icon=0,iconColor={255,0,0},blipid=0,blipcolor=0,hasbuy=true,faction = "Mafia Albaneza"},
		["gmt900escalade"] = {"🚗Caddilac Escalade",0,""},
		["g63amg6x6"] = {"🚗Mercedes-Benz G63 6x6",0,""},
		["rmodg65"] = {"🚗Mercedes Benz G65 RMOD",0, ""}, 
		["bmwmafiam3"] = {"🚗BMW M3 Break", 0, ""}, 
		["brabus500"] = {"🚗Brabus G Class 500", 0, ""}, 
		["cls19mafia"] = {"🚗Mercedes-Benz CLS 2019", 0, ""}, 

		--["g634x4byv"] = {"🚗Mercedes Benz G63 4x4 Mafia Car 1",0, ""}, -- 10e
		--["e60"] = {"🚗BMW E60 Mafia Car 2",0, ""}, -- 10e
		--["rolls6x6"] = {"🚗Rolls Royce 6x6 Mafia Car 3",0, ""}, -- 20e
		--["rrghostbyv"] = {"🚗Rolls Royce Limo Mafia Car 4",0, ""}, 
		--["rollsmb"] = {"🚗Rolls Royce Mafia Car 5",0, ""}, -- 20e
		--["rollsmafia"] = {"🚗Rolls Royce Mafia Car 6",0, ""}, -- 30e
		--["w223s500_S900_emrEHusmen"] = {"🚗Rolls Royce Mafia Car 8",0,""} -- 40e
    },

	["Garaj Merryweather Security"] = {
        _config = {vtype="mafie",icon=0,iconColor={255,0,0},blipid=0,blipcolor=0,hasbuy=true,faction = "Merryweather Security"},
		["gmt900escalade"] = {"🚗Caddilac Escalade",0,""},
		["g63amg6x6"] = {"🚗Mercedes-Benz G63 6x6",0,""},
		["rmodg65"] = {"🚗Mercedes Benz G65 RMOD",0, ""}, 
		["bmwmafiam3"] = {"🚗BMW M3 Break", 0, ""}, 
		["brabus500"] = {"🚗Brabus G Class 500", 0, ""}, 
		["cls19mafia"] = {"🚗Mercedes-Benz CLS 2019", 0, ""}, 

		--["g634x4byv"] = {"🚗Mercedes Benz G63 4x4 Mafia Car 1",0, ""}, -- 10e
		--["e60"] = {"🚗BMW E60 Mafia Car 2",0, ""}, -- 10e
		--["rolls6x6"] = {"🚗Rolls Royce 6x6 Mafia Car 3",0, ""}, -- 20e
		--["rrghostbyv"] = {"🚗Rolls Royce Limo Mafia Car 4",0, ""}, 
		--["rollsmb"] = {"🚗Rolls Royce Mafia Car 5",0, ""}, -- 20e
		--["rollsmafia"] = {"🚗Rolls Royce Mafia Car 6",0, ""}, -- 30e
		--["w223s500_S900_emrEHusmen"] = {"🚗Rolls Royce Mafia Car 8",0,""} -- 40e
    },

	["Garaj Cartel De Sinaloa"] = {
        _config = {vtype="mafie",icon=0,iconColor={255,0,0},blipid=0,blipcolor=0,hasbuy=true,faction = "Cartel De Sinaloa"},
		["gmt900escalade"] = {"🚗Caddilac Escalade",0,""},
		["g63amg6x6"] = {"🚗Mercedes-Benz G63 6x6",0,""},
		["rmodg65"] = {"🚗Mercedes Benz G65 RMOD",0, ""}, 
		["bmwmafiam3"] = {"🚗BMW M3 Break", 0, ""}, 
		["brabus500"] = {"🚗Brabus G Class 500", 0, ""}, 
		["cls19mafia"] = {"🚗Mercedes-Benz CLS 2019", 0, ""}, 

		--["g634x4byv"] = {"🚗Mercedes Benz G63 4x4 Mafia Car 1",0, ""}, -- 10e
		--["e60"] = {"🚗BMW E60 Mafia Car 2",0, ""}, -- 10e
		--["rolls6x6"] = {"🚗Rolls Royce 6x6 Mafia Car 3",0, ""}, -- 20e
		--["rrghostbyv"] = {"🚗Rolls Royce Limo Mafia Car 4",0, ""}, 
		--["rollsmb"] = {"🚗Rolls Royce Mafia Car 5",0, ""}, -- 20e
		--["rollsmafia"] = {"🚗Rolls Royce Mafia Car 6",0, ""}, -- 30e
		--["w223s500_S900_emrEHusmen"] = {"🚗Rolls Royce Mafia Car 8",0,""} -- 40e
    },


	["Garaj Hitman"] = {
        _config = {vtype="mafie",icon=0,iconColor={255,0,0},blipid=0,blipcolor=0,hasbuy=true,faction = "Hitman"},
		["gmt900escalade"] = {"🚗Caddilac Escalade",0,""},
		["g63amg6x6"] = {"🚗Mercedes-Benz G63 6x6",0,""},
		["rmodg65"] = {"🚗Mercedes Benz G65 RMOD",0, ""}, 
		["bmwmafiam3"] = {"🚗BMW M3 Break", 0, ""}, 
		["brabus500"] = {"🚗Brabus G Class 500", 0, ""}, 
		["cls19mafia"] = {"🚗Mercedes-Benz CLS 2019", 0, ""}, 
                ["m3kean"] = {"m3", 0, ""}, 


		--["g634x4byv"] = {"🚗Mercedes Benz G63 4x4 Mafia Car 1",0, ""}, -- 10e
		--["e60"] = {"🚗BMW E60 Mafia Car 2",0, ""}, -- 10e
		--["rolls6x6"] = {"🚗Rolls Royce 6x6 Mafia Car 3",0, ""}, -- 20e
		--["rrghostbyv"] = {"🚗Rolls Royce Limo Mafia Car 4",0, ""}, 
		--["rollsmb"] = {"🚗Rolls Royce Mafia Car 5",0, ""}, -- 20e
		--["rollsmafia"] = {"🚗Rolls Royce Mafia Car 6",0, ""}, -- 30e
		--["w223s500_S900_emrEHusmen"] = {"🚗Rolls Royce Mafia Car 8",0,""} -- 40e
    },

     ["Garaj Sons of Anarchy"] = {
        _config = {vtype="mafie",icon=0,iconColor={255,0,0},blipid=0,blipcolor=0,hasbuy=true,faction = "Sons of Anarchy"},
		["gmt900escalade"] = {"🚗Caddilac Escalade",0,""},
		["g63amg6x6"] = {"🚗Mercedes-Benz G63 6x6",0,""},
		["rmodg65"] = {"🚗Mercedes Benz G65 RMOD",0, ""}, 
		["bmwmafiam3"] = {"🚗BMW M3 Break", 0, ""}, 
		["brabus500"] = {"🚗Brabus G Class 500", 0, ""}, 
		["cls19mafia"] = {"🚗Mercedes-Benz CLS 2019", 0, ""}, 
                ["m3kean"] = {"m3", 0, ""},


        --["g634x4byv"] = {"🚗Mercedes Benz G63 4x4 Mafia Car 1",0, ""}, -- 10e
		--["e60"] = {"🚗BMW E60 Mafia Car 2",0, ""}, -- 10e
		--["rolls6x6"] = {"🚗Rolls Royce 6x6 Mafia Car 3",0, ""}, -- 20e
		--["rrghostbyv"] = {"🚗Rolls Royce Limo Mafia Car 4",0, ""}, 
		--["rollsmb"] = {"🚗Rolls Royce Mafia Car 5",0, ""}, -- 20e
		--["rollsmafia"] = {"🚗Rolls Royce Mafia Car 6",0, ""}, -- 30e
		--["w223s500_S900_emrEHusmen"] = {"🚗Rolls Royce Mafia Car 8",0,""} -- 40e
	 },

	 ["Garaj Triads"] = {
        _config = {vtype="mafie",icon=0,iconColor={255,0,0},blipid=0,blipcolor=0,hasbuy=true,faction = "Red Triads"},
		["gmt900escalade"] = {"🚗Caddilac Escalade",0,""},
		["g63amg6x6"] = {"🚗Mercedes-Benz G63 6x6",0,""},
		["rmodg65"] = {"🚗Mercedes Benz G65 RMOD",0, ""}, 
		["bmwmafiam3"] = {"🚗BMW M3 Break", 0, ""}, 
		["brabus500"] = {"🚗Brabus G Class 500", 0, ""}, 
		["cls19mafia"] = {"🚗Mercedes-Benz CLS 2019", 0, ""}, 
                ["m3kean"] = {"m3", 0, ""},
	 },

	 ["Garaj La Familia"] = {
        _config = {vtype="mafie",icon=0,iconColor={255,0,0},blipid=0,blipcolor=0,hasbuy=true,faction = "La Familia"},
		["gmt900escalade"] = {"🚗Caddilac Escalade",0,""},
		["g63amg6x6"] = {"🚗Mercedes-Benz G63 6x6",0,""},
		["rmodg65"] = {"🚗Mercedes Benz G65 RMOD",0, ""}, 
		["bmwmafiam3"] = {"🚗BMW M3 Break", 0, ""}, 
		["brabus500"] = {"🚗Brabus G Class 500", 0, ""}, 
		["cls19mafia"] = {"🚗Mercedes-Benz CLS 2019", 0, ""}, 
                --["m3kean"] = {"m3", 0, ""},
	 },

	 ["Garaj Corleone"] = {
        _config = {vtype="mafie",icon=0,iconColor={255,0,0},blipid=0,blipcolor=0,hasbuy=true,faction = "Mafia Corleone"},
		["gmt900escalade"] = {"🚗Caddilac Escalade",0,""},
		["g63amg6x6"] = {"🚗Mercedes-Benz G63 6x6",0,""},
		["rmodg65"] = {"🚗Mercedes Benz G65 RMOD",0, ""}, 
		["bmwmafiam3"] = {"🚗BMW M3 Break", 0, ""}, 
		["brabus500"] = {"🚗Brabus G Class 500", 0, ""}, 
		["cls19mafia"] = {"🚗Mercedes-Benz CLS 2019", 0, ""}, 
                --["m3kean"] = {"m3", 0, ""},
	 },

	 ["Garaj Sinaloa"] = {
        _config = {vtype="mafie",icon=0,iconColor={255,0,0},blipid=0,blipcolor=0,hasbuy=true,faction = "Cartel de Sinaloa"},
		["gmt900escalade"] = {"🚗Caddilac Escalade",0,""},
		["g63amg6x6"] = {"🚗Mercedes-Benz G63 6x6",0,""},
		["rmodg65"] = {"🚗Mercedes Benz G65 RMOD",0, ""}, 
		["bmwmafiam3"] = {"🚗BMW M3 Break", 0, ""}, 
		["brabus500"] = {"🚗Brabus G Class 500", 0, ""}, 
		["cls19mafia"] = {"🚗Mercedes-Benz CLS 2019", 0, ""}, 
                --["m3kean"] = {"m3", 0, ""},
	 },

	["Garaj Sindicat"] = {
        _config = {vtype="mafie",icon=0,iconColor={255,0,0},blipid=0,blipcolor=0,hasbuy=true,faction = "Sindicat"},
		["gmt900escalade"] = {"🚗Caddilac Escalade",0,""},
		["g63amg6x6"] = {"🚗Mercedes-Benz G63 6x6",0,""},
		["rrghostbyv"] = {"🚗Rolls Royce Limo Mafia Car 4",0, ""},
		["rmodg65"] = {"🚗Mercedes Benz G65 RMOD",0, ""}, 
		["bmwmafiam3"] = {"🚗BMW M3 Break", 0, ""}, 
		["brabus500"] = {"🚗Brabus G Class 500", 0, ""}, 
		["cls19mafia"] = {"🚗Mercedes-Benz CLS 2019", 0, ""}, 
        --["m3kean"] = {"🚗M3", 0, ""},

		--["g634x4byv"] = {"🚗Mercedes Benz G63 4x4 Mafia Car 1",0, ""}, -- 10e
		--["e60"] = {"🚗BMW E60 Mafia Car 2",0, ""}, -- 10e
		--["rolls6x6"] = {"🚗Rolls Royce 6x6 Mafia Car 3",0, ""}, -- 20e
		--["rrghostbyv"] = {"🚗Rolls Royce Limo Mafia Car 4",0, ""}, 
		["rollsmb"] = {"🚗Rolls Royce Sindicat",0, ""}, -- 20e
    },

	["Garaj MS-13"] = {
        _config = {vtype="mafie",icon=0,iconColor={255,0,0},blipid=0,blipcolor=0,hasbuy=true,faction = "Mafia MS-13"},
		["gmt900escalade"] = {"🚗Caddilac Escalade",0,""},
		["g63amg6x6"] = {"🚗Mercedes-Benz G63 6x6",0,""},
		["rrghostbyv"] = {"🚗Rolls Royce Limo Mafia Car 4",0, ""},
		["rmodg65"] = {"🚗Mercedes Benz G65 RMOD",0, ""}, 
		["bmwmafiam3"] = {"🚗BMW M3 Break", 0, ""}, 
		["brabus500"] = {"🚗Brabus G Class 500", 0, ""}, 
		["cls19mafia"] = {"🚗Mercedes-Benz CLS 2019", 0, ""}, 
        --["m3kean"] = {"🚗M3", 0, ""},

		--["g634x4byv"] = {"🚗Mercedes Benz G63 4x4 Mafia Car 1",0, ""}, -- 10e
		--["e60"] = {"🚗BMW E60 Mafia Car 2",0, ""}, -- 10e
		--["rolls6x6"] = {"🚗Rolls Royce 6x6 Mafia Car 3",0, ""}, -- 20e
		--["rrghostbyv"] = {"🚗Rolls Royce Limo Mafia Car 4",0, ""}, 
		["rollsmb"] = {"🚗Rolls Royce Sindicat",0, ""}, -- 20e
    },

	["Garaj Garda Veche"] = {
        _config = {vtype="mafie",icon=0,iconColor={255,0,0},blipid=0,blipcolor=0,hasbuy=true,faction = "Mafia MS-13"},
		["gmt900escalade"] = {"🚗Caddilac Escalade",0,""},
		["g63amg6x6"] = {"🚗Mercedes-Benz G63 6x6",0,""},
		["rrghostbyv"] = {"🚗Rolls Royce Limo Mafia Car 4",0, ""},
		["rmodg65"] = {"🚗Mercedes Benz G65 RMOD",0, ""}, 
		["bmwmafiam3"] = {"🚗BMW M3 Break", 0, ""}, 
		["brabus500"] = {"🚗Brabus G Class 500", 0, ""}, 
		["cls19mafia"] = {"🚗Mercedes-Benz CLS 2019", 0, ""}, 
        --["m3kean"] = {"🚗M3", 0, ""},

		--["g634x4byv"] = {"🚗Mercedes Benz G63 4x4 Mafia Car 1",0, ""}, -- 10e
		--["e60"] = {"🚗BMW E60 Mafia Car 2",0, ""}, -- 10e
		--["rolls6x6"] = {"🚗Rolls Royce 6x6 Mafia Car 3",0, ""}, -- 20e
		--["rrghostbyv"] = {"🚗Rolls Royce Limo Mafia Car 4",0, ""}, 
		["rollsmb"] = {"🚗Rolls Royce Sindicat",0, ""}, -- 20e
    },

	["Elicopter Jandarmerie"] = {
		_config = {vtype="car",icon=64,iconColor={0,0,255},hasbuy=true,faction = "Jandarmerie"},
		["volatus"] = {"🚁Volatus",0,""},
	},

	["Elicopter Sindicat"] = {
		_config = {vtype="car", blipid=43, blipcolor=47, icon=34, iconColor={255,140,0}, faction = "Sindicat", hasbuy = true},
		["swift2"] = {"🚁 Elicopter",0,""}
	},

	["Elicopter Bloods"] = {
		_config = {vtype="car", blipid=43, blipcolor=47, icon=34, iconColor={255,140,0}, faction = "Bloods", hasbuy = true},
		["swift2"] = {"🚁 Elicopter",0,""}
	},

	["Elicopter Jandarmerie"] = {
		_config = {vtype="car",icon=34,iconColor={255,0,0},faction="Jandarmerie", hasbuy = true, tosell = false},
		["supervolito2"] = {"Elicopter", 0, ""}
	},
	["Elicopter Merryweather"] = {
		_config = {vtype="car", blipid=43, blipcolor=47, icon=34, iconColor={255,140,0}, faction = "Merryweather", hasbuy = true},
		["maverick"] = {"🚁 Elicopter",0,""}
	},

	["Garaj Fan Courier"] = {
		_config = {vtype="car", blipid=326, blipcolor=3, icon=0, iconColor={17, 154, 240}, permissions={"fancourier.vehicle"}, hasbuy=true,tosell=false},
		["mule2"] = {"Duba Mercedes Fan Courier", 0,""},
		["speedo"] = {"Sprinter Fan Courier", 0,""},
		["minivan"] = {"VW Caddy Fan Courier", 0,""},
	},

	["Garaj Pilot"] = {
		_config = {vtype="car", blipid=326, blipcolor=3, icon=0, iconColor={17, 154, 240}, permissions={"pilot.vehicle"}, hasbuy=true,tosell=false},
		["airtug"] = {"Airtug", 0,""},
	},

	["Garaj Petrolist"] = {
		_config = {vtype="car", blipid=800, blipcolor=40, icon=0, iconColor={95, 98, 102}, permissions={"petrolist.vehicle"}, hasbuy=true,tosell=false},
		["brickade"] = {"Brickade Petrol", 0,""},
		["oiltanker"] = {"Oil Tanker", 0,""},
	},

	["Garaj Curier Mancare"] = {
		_config = {vtype="car", blipid=326, blipcolor=1, icon=0, iconColor={255, 0, 0}, permissions={"delivery.vehicle"}, hasbuy=true,tosell=false},
		["faggioglovo"] = {"Scuter Glovo", 0,""},
		["faggiotazz"] = {"Scuter Tazz", 0,""},
		["faggiofoodpanda"] = {"Scuter Food Panda", 0,""},
	},

	["Garaj Pizza Boy"] = {
		_config = {vtype="car", blipid=326, blipcolor=3, icon=0, iconColor={17, 154, 240}, permissions={"pizza.vehicle"}, hasbuy=true,tosell=false},
		["foodcar4"] = {"Masina Dominos", 0,""}
	},

	["Garaj Brutar"] = {
		_config = {vtype="car", iconColor={255,192,0}, permissions={"brutar.vehicle"}, hasbuy=true,tosell=false},
		["mule3"] = {"Duba Brutar", 0,""}
	},

}

cfg.garages = {

	------- Civil -------
	{"Civil",vector3(-449.45260620117,6053.1401367188,31.340543746948)},
	{"Civil",vector3(-1101.2666015625,354.04693603516,68.238349914551)},
	{"Civil",vector3(135.58215332031,6580.1484375,32.026294708252)},
	{"Civil",vector3(1458.8465576172,3737.525390625,33.514545440674)},
	{"Civil",vector3(-136.96157836914,6308.568359375,31.487642288208)},
	{"Civil",vector3(20.98610496521,6662.1918945313,31.528833389282)},
	{"Civil",vector3(-1270.7098388672,510.35565185547,97.31371307373)},
	{"Civil",vector3(164.11820983887,-3046.359375,5.9204072952271)},
	{"Civil",vector3(-1921.3610839844,2052.3093261719,140.73526000977)},
	{"Civil",vector3(1834.3668212891,3665.693359375,33.707855224609)},
	{"Civil",vector3(393.33529663086,-652.29180908203,28.500341415405)},
	{"Civil",vector3(209.56245422363,-790.94165039062,30.933132171631)},
	{"Civil",vector3(-3152.224609375,1092.4527587891,20.70580291748)},
	{"Civil",vector3(2770.1940917969,2805.048828125,41.379825592041)},
	{"Civil",vector3(361.38873291016,-1705.4973144531,32.530006408691)},
	{"Civil",vector3(954.22845458984,-2111.0810546875,30.55154800415)},
	{"Civil",vector3(-741.92321777344,-1500.8233642578,5.0005159378052)},
	{"Civil",vector3(-700.41790771484,5782.3935546875,17.330944061279)},
	{"Civil",vector3(-404.26574707031,338.44787597656,108.71784210205)},
	{"Civil",vector3(-607.16900634766,-996.779296875,21.787553787231)}, 
	{"Civil",vector3(918.54986572266,-167.2536315918,74.634864807129)},
	{"Civil",vector3(-1471.1893310547,511.56100463867,117.71801757813)},
	{"Civil",vector3(-83.90665435791,1880.3087158203,197.28218078613)},
	{"Civil",vector3(446.79470825195,-3040.8395996094,6.0696358680725)},
	{"Civil",vector3(-252.09869384766,-2070.6166992188,27.620388031006)},
	{"Civil",vector3(135.05609130859,-1050.9978027344,29.153200149536)},
	{"Civil",vector3(-515.86822509766,-294.82757568359,35.226947784424)},
	{"Civil",vector3(-2785.4370117188,1431.5671386719,100.92836761475)},
	{"Civil",vector3(-461.19354248047,-271.814453125,35.778518676758)},
	{"Civil",vector3(1969.3687744141,5163.4506835938,47.577152252197)},
	{"Civil",vector3(2133.869140625,4782.142578125,40.970127105713)},
	{"Civil",vector3(3442.8139648438,4893.7954101562,36.00004196167)},
	{"Civil",vector3(-610.04382324219,201.13110351563,71.325126647949)},
	{"Civil",vector3(1784.8581542969,4585.4868164063,37.56266784668)},
	{"Civil",vector3(-673.00012207031,909.72595214844,230.38031005859)},
	{"Civil",vector3(1704.4921875,3765.2756347656,34.376136779785)},
	{"Civil",vector3(-95.720237731934, 825.31066894531, 235.72877502441)},
	{"Civil",vector3(-3350.7868652344, 1757.3057861328, 34.158344268799)},
	{"Bicicleta", vector3(-521.9150390625,-257.53881835938,35.635265350342)},
	{"Garaj Barca",vector3(4565.0014648438,-4405.3295898438,0.45356392860413)},
	{"Garaj Barca",vector3(-786.2734375,-1494.0871582031,0.28199183940887)},
	{"Garaj Cayo",vector3(4447.8076171875,-4485.0009765625,4.2264580726624)},

	------- Jobs -------
	{"Taxi",vector3(-801.74737548828,-1314.9748535156,5.0002665519714)},
	{"Garaj Avioane",vector3(-978.22369384766,-2996.4912109375,13.945068359375)},

	------- Factiuni Legale -------
	{"Elicopter Jandarmerie",vector3(450.45257568359,-981.29125976562,43.691730499268)},
	{"Jandarmerie",vector3(2543.2739257813,-391.04693603516,92.993286132813)},
	{"Garaj Jandarmerie",vector3(434.78607177734,-1026.2399902344,28.853151321412)},
	{"Politia",vector3(475.93231201172,-1021.9360351562,28.063844680786)},
	{"Politia",vector3(453.56491088867,-1014.4117431641,28.457962036133)},
	{"Politia Romana",vector3(453.67190551758,-1020.4815673828,28.340524673462)},
	{"Politia Romana - Elicopter",vector3(449.20254516602,-981.29559326172,43.691417694092)},
	{"Smurd - Elicopter",vector3(351.07766723633,-587.91668701172,74.165573120117)},
	{"SMURD",vector3(290.16790771484,-589.96691894531,43.185508728027)},

    ------- V.I.P -------
	{"VIP Bronze",vector3(26.555429458618,-1114.2176513672,29.297452926636)},
	{"VIP Silver",vector3(29.234199523926,-1108.0913085938,29.319232940674)},
	{"VIP Gold",vector3(33.465381622314,-1100.6848144531,29.386821746826)},
	{"VIP Diamond",vector3(36.222724914551,-1095.9940185547,29.45818901062)},
	{"VIP Emerald",vector3(38.300762176514,-1090.8666992188,29.555118560791)},



	------- Factiuni Ilegale -------

	{"Garaj Grove Street", vector3(499.13150024414,-1802.3767089844,28.47474861145)},
	{"Garaj Merryweather Security", vector3(489.92156982422,-3128.6333007812,6.0700573921204)},
	{"Elicopter Merryweather", vector3(478.48739624023, -3369.9680175781, 6.0699071884155)},
	{"Garaj MS-13", vector3(-194.6471862793,-1525.9484863281,33.409343719482)},
	{"Garaj Los Vagos", vector3(-1015.5098876954,356.03274536132,70.597869873046)},
	{"Garaj Los Aztecas", vector3(320.01266479492,-2027.0279541016,20.714567184448)},
	{"Garaj The Demons", vector3(-869.28942871094,320.77014160156,83.977783203125)},
	{"Garaj Peaky Blinders", vector3(-824.16979980469,181.48413085938,71.681365966797)},
	{"Garaj Bloods", vector3(-1528.4528808594,83.289054870605,56.635078430176)},
	{"Garaj Sinaloa", vector3(-656.02398681641,905.33929443359,228.12593078613)},
	{"Garaj Sindicat", vector3(-3052.7993164062,1513.5158691406,37.279712677002)},
	{"Garaj Triads",vector3(-1660.4008789062,74.774848937988,63.333850860596)},
	{"Garaj Corleone",vector3(-1923.1829833984,2040.3225097656,140.7352142334)},
    {"Garaj Mafia Albaneza", vector3(-127.91072845458,1007.7909545898,235.73211669922)},
    {"Garaj Sons of Anarchy", vector3(964.17163085938,-131.30459594726,74.353134155274)},
	{"Garaj La Familia", vector3(-1531.96875,889.7118140625,181.86093139648)},	
	{"Elicopter Sindicat", vector3(-3263.5393066406,1721.4920654297,44.724468231201)},
	{"HITMAN",vector3(-410.65133666992,1175.8936767578,325.64175415039)},
	{"Hitman - Elicopter",vector3(-448.93417358398,1105.2269287109,332.53201293945)},
	{"Garaj Garda Veche", vector3(-803.53887939453,163.44813537598,71.539207458496)}
}

return cfg
