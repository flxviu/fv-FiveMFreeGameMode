local cfg = {}

cfg.factions = {
	["Politie"] = {
		fType = "Lege",
		fSlots = 80,
		fRanks = {
			[1] = {rank = "Cadet", salary = 1500000}, 
			[2] = {rank = "Agent", salary = 2000000}, 
			[3] = {rank = "Agent Principal", salary = 600001},
			[4] = {rank = "Agent Sef", salary = 600001},  
			[5] = {rank = "Inspector", salary = 600001}, 
			[6] = {rank = "Comisar", salary = 600001}, 
			[7] = {rank = "Comisar Sef", salary = 600001}, 
			[8] = {rank = "Chestor", salary = 600001}, 
			[9] = {rank = "Chestor General", salary = 4000000}
		}
	},

	["Diicot"] = {
		fType = "Lege",
		fSlots = 80,
		fRanks = {
			[1] = {rank = "Agent Diicot", salary = 2000000}, 
			[2] = {rank = "Agent General Diicot", salary = 2000000}, 
			[3] = {rank = "Lider Diicot", salary = 2000000}
		}
	},

	["Jandarmerie"] = {
		fType = "Lege",
		fSlots = 80,
		fRanks = {
			[1] = {rank = "Plutonier ajutant", salary = 1500000}, 
			[2] = {rank = "Sergent", salary = 2000000}, 
			[3] = {rank = "Sergent Major", salary = 600001},
			[4] = {rank = "Plutonier", salary = 600001},  
			[5] = {rank = "Maior", salary = 600001}, 
			[6] = {rank = "Colonel", salary = 600001}, 
			[7] = {rank = "Sub Locotenent", salary = 600001}, 
			[8] = {rank = "Locotenent", salary = 600001}, 
			[9] = {rank = "Capitan", salary = 600001}
		}
	},
	
	["Hitman"] = {
		fType = "Lege",
		fSlots = 50,
		coords = {-429.12826538086,1110.2768554688,327.68228149414},
		fRanks = {
			[1] = {rank = "Membru Hitman", salary = 650000}, 
			[2] = {rank = "Sageata", salary = 650000}, 
			[3] = {rank = "Co-Lider Hitman", salary = 650000},  
			[4] = {rank = "Lider Hitman", salary = 650000}
		}
	},

	["Smurd"] = {
		fType = "Lege",
		fSlots = 50,
		fRanks = {
			[1] = {rank = "Asistent Medical", salary = 700001}, 
			[2] = {rank = "Medic Rezident", salary = 700001}, 
			[3] = {rank = "Medic Specialist", salary = 700001},  
			[4] = {rank = "Medic Chirurg", salary = 700001},  
			[5] = {rank = "Medic Instructor", salary = 700001},
			[6] = {rank = "Asistent General", salary = 700001},  
			[7] = {rank = "Director General", salary = 700001}
		}
	},	

	["Taxi"] = {
		fType = "Lege",
		fSlots = 50,
		fRanks = {
			[1] = {rank = "Lider Taxi", salary = 700001}, 
			[2] = {rank = "Co-Lider Taxi", salary = 700001}, 
			[3] = {rank = "Taximetrist", salary = 700001}
		}
	},		
	
	["Mecanic"] = {
		fType = "Lege",
		fSlots = 50,
		fRanks = {
			[1] = {rank = "Lider Mecanic", salary = 700001}, 
			[2] = {rank = "Co-Lider Mecanic", salary = 700001}, 
			[3] = {rank = "Mecanic", salary = 700001}
		}
	},	
	
	["Grove Street"] = {
		fType = "Mafie",
		fBlip = 2,
		fSlots = 22,
		feedColor = '#309c1a',
		fHexColor = '#309c1a',
		coords = {500.18649291992,-1812.9627685546,28.867441177368},
		fRanks = {
			[1] = {rank = "Membru Grove", salary = 650000}, 
			[2] = {rank = "Co-Lider Grove", salary = 650000}, 
			[3] = {rank = "Lider Grove", salary = 1000000}
		}
	},	

	["Garda Veche"] = {
		fType = "Mafie",
		fBlip = 25,
		fSlots = 22,
		feedColor = '#296312',
		fHexColor = '#296312',
		coords = {-818.22113037109,177.50569152832,72.222846984863},
		fRanks = {
			[1] = {rank = "Membru Grada Veche", salary = 650000}, 
			[2] = {rank = "Co-Lider Garda Veche", salary = 650000}, 
			[3] = {rank = "Lider Garda Veche", salary = 1000000}
		}
	},

	["Mafia MS-13"] = {
		fType = "Mafie",
		fBlip = 25,
		fSlots = 22,
		feedColor = '#296312',
		fHexColor = '#296312',
		coords = {-173.73017883301,-1546.8990478516,35.127510070801 },
		fRanks = {
			[1] = {rank = "Membru MS-13", salary = 650000}, 
			[2] = {rank = "Co-Lider MS-13", salary = 650000}, 
			[3] = {rank = "Lider MS-13", salary = 1000000}
		}
	},

	["Los Aztecas"] = {
		fType = "Mafie",
		fBlip = 25,
		fSlots = 22,
		feedColor = '#296312',
		fHexColor = '#296312',
		coords = {313.30764770508,-2040.4915771484,20.936386108398},
		fRanks = {
			[1] = {rank = "Membru Aztecas", salary = 650000}, 
			[2] = {rank = "Co-Lider Aztecas", salary = 650000}, 
			[3] = {rank = "Lider Aztecas", salary = 1000000}
		}
	},

	["Mafia Albaneza"] = {
		fType = "Mafie",
		fBlip = 25,
		fSlots = 22,
		feedColor = '#296312',
		fHexColor = '#296312',
		coords = {-818.22113037109,177.50569152832,72.222846984863},
		fRanks = {
			[1] = {rank = "Membru Albaneza", salary = 650000}, 
			[2] = {rank = "Co-Lider Albaneza", salary = 650000}, 
			[3] = {rank = "Lider Albaneza", salary = 1000000}
		}
	},

	["Merryweather Security"] = {
		fType = "Mafie",
		fBlip = 25,
		fSlots = 22,
		feedColor = '#296312',
		fHexColor = '#296312',
		coords = {490.0876159668,-3124.6848144531,6.0700573921204},
		fRanks = {
			[1] = {rank = "Membru MW", salary = 650000}, 
			[2] = {rank = "Co-Lider MW", salary = 650000}, 
			[3] = {rank = "Lider MW", salary = 1000000}
		}
	},

	["Cartel de Sinaloa"] = {
		fType = "Mafie",
		fBlip = 25,
		fSlots = 60,
		feedColor = '#296312',
		fHexColor = '#296312',
		coords = {-658.51593017578,886.56744384766,229.24897766113	},
		fRanks = {
			[1] = {rank = "Membru Sinaloa", salary = 650000}, 
			[2] = {rank = "Co-Lider Sinaloa", salary = 650000}, 
			[3] = {rank = "Lider Sinaloa", salary = 1000000}
		}
	},
	
	["Los Vagos"] = {
		fType = "Mafie",
		fBlip = 81,
		fSlots = 22,
		feedColor = '#ffb300',
		fHexColor = '#ffb300',
		coords = {-1024.9102783204,360.21673583984,71.361541748046},
		fRanks = {
			[1] = {rank = "Membru Vagos", salary = 650000}, 
			[2] = {rank = "Co-Lider Vagos", salary = 650000}, 
			[3] = {rank = "Lider Vagos", salary = 1000000}
		}
	},	

	["Sindicat"] = {
		fType = "Mafie",
		fBlip = 81,
		fSlots = 22,
		feedColor = '#504954',
		fHexColor = '#504954',
		coords = {-3326.1696777344,1759.685546875,34.158340454102},
		fRanks = {
			[1] = {rank = "Membru Sindicat", salary = 650000}, 
			[2] = {rank = "Co-Lider Sindicat", salary = 650000}, 
			[3] = {rank = "Lider Sindicat", salary = 1000000}
		}
	},

	["The Demons"] = {
		fType = "Mafie",
		fBlip = 40,
		fSlots = 22,
		feedColor = '#504954',
		fHexColor = '#504954',
		coords = {-877.15557861328,306.4966430664,84.15431213379},
		fRanks = {
			[1] = {rank = "Membru Demons", salary = 650000}, 
			[2] = {rank = "Co-Lider Demons", salary = 650000}, 
			[3] = {rank = "Lider Demons", salary = 1000000}
		}
	},		

	["Red Triads"] = {
		fType = "Mafie",
		fBlip = 1,
		fSlots = 22,
		feedColor = '#ff0000',
		fHexColor = '#ff0000',
		coords = {-1629.5382080078,37.111473083496,62.936126708984},
		fRanks = {
			[1] = {rank = "Membru Red Triads", salary = 5000000}, 
			[2] = {rank = "Co-Lider Red Triads", salary = 10000000}, 
			[3] = {rank = "Lider Red Triads", salary = 20000000}
		}
	},

	["Bloods"] = {
		fType = "Mafie",
		fBlip = 1,
		fSlots = 22,
		feedColor = '#ff0000',
		fHexColor = '#ff0000',
		coords = {-1536.9713134766,130.53242492676,57.371360778808},
		fRanks = {
			[1] = {rank = "Membru Bloods", salary = 650000}, 
			[2] = {rank = "Co-Lider Bloods", salary = 650000}, 
			[3] = {rank = "Lider Bloods", salary = 1000000}
		}
	},

	["Sons of Anarchy"] = {
		fType = "Mafie",
		fBlip = 40,
		fSlots = 35,
		feedColor = '#ff0000',
		fHexColor = '#ff0000',
		coords = {986.4326171875,-144.73664855958,74.27140045166},
		fRanks = {
			[1] = {rank = "Membru Sons of Anarchy", salary = 650000}, 
			[2] = {rank = "Co-Lider Sons of Anarchy", salary = 650000}, 
			[3] = {rank = "Lider Sons of Anarchy", salary = 1000000}
		}
	},

	["Mafia Corleone"] = {
		fType = "Mafie",
		fBlip = 40,
		fSlots = 35,
		feedColor = '#ff0000',
		fHexColor = '#ff0000',
		coords = {-1897.0687255859,2050.0979003906,140.7427520752},
		fRanks = {
			[1] = {rank = "Membru Corleone", salary = 650000}, 
			[2] = {rank = "Co-Lider Corleone", salary = 650000}, 
			[3] = {rank = "Lider Corleone", salary = 1000000}
		}
	},

	["La Familia"] = {
		fType = "Mafie",
		fBlip = 40,
		fSlots = 24,
		feedColor = '#ff0000',
		fHexColor = '#ff0000',
		coords = {-1501.6094970703,856.98822021484,181.59469604492},
		fRanks = {
			[1] = {rank = "Membru La Familia", salary = 650000}, 
			[2] = {rank = "Co-Lider La Familia", salary = 650000}, 
			[3] = {rank = "Lider La Familia", salary = 1000000}
		}
	}
}
	
return cfg