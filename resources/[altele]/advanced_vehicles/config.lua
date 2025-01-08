Config = {}

Config.webhook = "https://discord.com/api/webhooks/1321589513625010237/Gb0VNa3HN_uBdkkFdqY5vZ56g7zKDjrzZPmOYTYusf0MQ40KwBecLTIQdi65__tZAyFx"						-- Webhook to send logs to discord
Config.lang = "en"								-- Set the file language [en/br]

Config.ESX = {									-- ESX settings, if you are using vRP just ignore
	['ESXSHAREDOBJECT'] = "esx:getSharedObject",-- Change your getshared object event here, if you are using anti-cheat
}

Config.format = {
	['currency'] = 'USD',						-- This is the currency format, so that your currency symbol appears correctly [Examples: BRL, USD]
	['location'] = 'en-US'						-- This is the location of your country, to format the decimal places according to your standard [Examples: pt-BR, en-US]
}

Config.command = "status"						-- Command to open menu (Event to open menu if you want to trigger it from somewhere: TriggerEvent('advanced_vehicles:showStatusUI'))
Config.Jobs = {'Mecanic'}			-- Job to do the actions on menu

Config.allVehicles = false						-- true: only cars will be available / false: every vehicle will be available
Config.itemToInspect = "scanner"				-- Item to inspect the vehicles

Config.NitroAmount = 100						-- Amount of nitro for each charge
Config.NitroRechargeTime = 60					-- Time to recharge nitro
Config.NitroRechargeAmount = 5					-- Charges amount
-- You can configure 2 keys to nitro
Config.NitroKey1 = 19 	-- ALT
Config.NitroKey2 = 210 	-- CTRL

Config.inspectItem = "scanner"					-- Item you must have to inspect the vehicles (set as false to disable the item)
Config.oil = "oil"								-- Oil index configured in Config.maintenance
-- Config for car services
Config.maintenance = {
	['default'] = { -- Default means if you dont have a config for the specific vehicle, it will get the default one
		['oil'] = {								-- Index
			['lifespan'] = 1500,				-- Amount of KMs until the car requires service
			['damage'] = {
				['type'] = 'engine',			-- Type of damage: this will damage the vehicle engine
				['amount_per_km'] = 0.00001,		-- This is the base amount (in percentage) the car will take damage for each km he run [Max health in engine is 1000 so, 0.0001 of 1000 is 0.1 | Max value for handling is get from vehicle handling.meta file]
				['km_threshold'] = 99999,			-- This is the threshold to increase the multiplier, so the multiplier will be increased each time the player pass this km [Set this value as 99999 if you dont want the multiplier working]
				['multiplier'] = 1.0,			-- This is the damage multiplier, this value will make the car take even more damage after player use the car longer [This value can't be less than 1.0 | Set this value as 1.0 if you dont want the multiplier working]
				['min'] = 0,					-- This is the min value the part health can reach taking damage
				['destroy_engine'] = true		-- Will make the car stop working if engine reach the min value [Only applicable when type = engine]
			},
			['repair_item'] = {
				['name'] = 'oil',				-- Item to do the car service
				['amount'] = 2,					-- Amount of items
				['time'] = 10					-- Time to repair
			},
			['interface'] = {
				['name'] = 'Engine oil',					-- Interface name
				['icon_color'] = '#ffffff00',				-- Interface background color
				['icon'] = 'images/maintenance/oil.png',	-- Image
				['description'] = 'intotdeauna trebuie sa aveti un ulei proaspat si curat pentru a va mentine motorul in functiune',	-- Description text
				['index'] = 0								-- This index means the item orders in interface, 0 will be the first, the the 1 ...
			}
		},
		['tires'] = {
			['lifespan'] = 5000,
			['damage'] = {
				['type'] = 'CHandlingData',			-- This will damage the vehicle handling (handling.meta)
				['handId'] = 'fTractionCurveMax',	-- handling.meta entry
				['amount_per_km'] = 0.0001,			-- Setting 0.0001 (on amount_per_km), 100 (on km_threshold) and 1.2 (on multiplier) the car will run approximatelly 1.300 km before reach the min value
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 0.5
			},
			['repair_item'] = {
				['name'] = 'tires',
				['amount'] = 4,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Tires',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/tires.png',
				['description'] = 'Anvelopele sunt folosite pentru a va mentine vehiculul drept,anvelopele uzate va vor usura deraparea vehiculului',
				['index'] = 1
			}
		},
		['brake_pads'] = {
			['lifespan'] = 4000,
			['damage'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fBrakeForce',
				['amount_per_km'] = 0.0001,
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 0.1
			},
			['repair_item'] = {
				['name'] = 'brake_pads',
				['amount'] = 4,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Brake pads',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/brake_pads.png',
				['description'] = 'Placutele de frana sunt utile pentru a va opri masina in timpul decelerarii',
				['index'] = 2
			}
		},
		['transmission_oil'] = {
			['lifespan'] = 30000,
			['damage'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveMaxFlatVel',
				['amount_per_km'] = 0.0001,
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 100.0
			},
			['repair_item'] = {
				['name'] = 'transmission_oil',
				['amount'] = 2,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Transmission oil',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/transmission_oil.png',
				['description'] = 'Trebuie sa va pastrati uleiul curat pentru ca transmisia sa functioneze',
				['index'] = 3
			}
		},
		['shock_absorber'] = {
			['lifespan'] = 10000,
			['damage'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fSuspensionForce',
				['amount_per_km'] = 0.0001,
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 0.1
			},
			['repair_item'] = {
				['name'] = 'shock_absorber',
				['amount'] = 4,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Shock absorber',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/shocks.png',
				['description'] = 'Suspensia dvs depinde de un amortizor bun',
				['index'] = 4
			}
		},
		['clutch'] = {
			['lifespan'] = 35000,
			['damage'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fClutchChangeRateScaleUpShift',
				['amount_per_km'] = 0.0001,
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 0.1
			},
			['repair_item'] = {
				['name'] = 'clutch',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Clutch',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/clutch.png',
				['description'] = 'Viteza ambreiajului in schimbarea vitezelor',
				['index'] = 5
			}
		},
		['air_filter'] = {
			['lifespan'] = 10000,
			['damage'] = {
				['type'] = 'engine',
				['amount_per_km'] = 0.00005,
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 0,
				['destroy_engine'] = true
			},
			['repair_item'] = {
				['name'] = 'air_filter',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Air filter',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/air_filter.png',
				['description'] = 'Motorul dvs trebuie sa respire printr-un nou filtru de aer',
				['index'] = 6
			}
		},
		['fuel_filter'] = {
			['lifespan'] = 10000,
			['damage'] = {
				['type'] = 'engine',
				['amount_per_km'] = 0.00005,
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 0,
				['destroy_engine'] = true
			},
			['repair_item'] = {
				['name'] = 'fuel_filter',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Fuel filter',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/fuel_filter.png',
				['description'] = 'Numele spune multe pentru functia: de a preveni trecerea murdariei din rezervorul vehiculului la motor',
				['index'] = 7
			}
		},
		['spark_plugs'] = {
			['lifespan'] = 15000,
			['damage'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['amount_per_km'] = 0.0001,
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 0
			},
			['repair_item'] = {
				['name'] = 'spark_plugs',
				['amount'] = 4,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Spark plugs',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/spark_plugs.png',
				['description'] = 'Bujiile sunt necesare pentru a genera energia necesara pentru ca motorul sa functioneze corect.',
				['index'] = 8
			}
		},
		['serpentine_belt'] = {
			['lifespan'] = 20000,
			['damage'] = {
				['type'] = 'engine',
				['amount_per_km'] = 0.001,
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 0,
				['destroy_engine'] = true
			},
			['repair_item'] = {
				['name'] = 'serpentine_belt',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Serpentine belt',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/serpentine_belt.png',
				['description'] = 'Cureaua de distributie coordoneaza deschiderea si inchiderea supapelor motorului, precum si miscarea pistonilor in cilindru si arborele cotit',
				['index'] = 9
			}
		},
	},
	--[[['panto'] = {	-- If you enable this, the car panto will have those configs
		['example'] = {
			['lifespan'] = 999,
			['damage'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['amount_per_km'] = 0.0001,
				['km_threshold'] = 100,
				['multiplier'] = 1.2,
				['min'] = 0
			},
			['repair_item'] = {
				['name'] = 'example',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Example',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/maintenance/example.png',
				['description'] = 'Example',
				['index'] = 9
			}
		},
	}]]
}

-- Upgrades availables
Config.upgrades = {
	['default'] = {
		['susp'] = {	-- Index
			['improvements'] = {
				['type'] = 'CHandlingData',			-- CHandlingData: will affect the vehicle handling
				['handId'] = 'fSuspensionRaise',	-- The handling.meta entry 
				['value'] = -0.2,					-- Value to change
				['fixed_value'] = false				-- This means if the value will be relative or absolute(fixed)
			},
			['item'] = {
				['name'] = 'susp',					-- Item required to upgrade
				['amount'] = 1,						-- Amount of items
				['time'] = 10						-- Tim to upgrade
			},
			['interface'] = {
				['name'] = 'Lowered suspension',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/susp.png',
				['description'] = 'Schimbati suspendarea cu un set extrem de redus. Potrivit doar pentru camionete si vehicule inalte',
				['index'] = 0
			},
			['class'] = 'suspension'
		},
		['susp1'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fSuspensionRaise',
				['value'] = -0.1,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'susp1',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Stanced suspension',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/susp1.png',
				['description'] = 'Instaleaza un set de arcuri scurte pentru a cobori vehiculul la extrem. Va poate face vehiculul instabil. Nu este potrivit pentru vehiculele cu nivel scazut',
				['index'] = 1
			},
			['class'] = 'suspension'
		},
		['susp2'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fSuspensionRaise',
				['value'] = -0.05,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'susp2',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Sport suspension',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/susp2.png',
				['description'] = 'Instalati un arc sportiv pentru a reduce inaltimea vehiculului. Nu este potrivit pentru vehiculele care sunt deja scazute',
				['index'] = 2
			},
			['class'] = 'suspension'
		},
		['susp3'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fSuspensionRaise',
				['value'] = 0.1,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'susp3',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Confort suspension',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/susp3.png',
				['description'] = 'Cresteti usor inaltimea suspensiei pentru a oferi mai mult confort si siguranta pasagerilor',
				['index'] = 3
			},
			['class'] = 'suspension'
		},
		['susp4'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fSuspensionRaise',
				['value'] = 0.2,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'susp4',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Lifted suspension',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/susp4.png',
				['description'] = 'Mariti drastic inaltimea suspensiei pentru vehiculele care doresc o aventura offroad',
				['index'] = 4
			},
			['class'] = 'suspension'
		},

		['garett'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fInitialDriveForce',
				['value'] = 0.04,
				['turbo'] = true,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'garett',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Garett GTW Turbo',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/turbo.png',
				['description'] = 'Instalati o turbina mai mare pentru a genera mai multa presiune si a admite mai mult aer rece in admisia motorului generand mai multa putere',
				['index'] = 5
			},
			['class'] = 'turbo'
		},
		['nitrous'] = {
			['improvements'] = {
				['type'] = 'nitrous'	-- Nitro type
			},
			['item'] = {
				['name'] = 'nitrous',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Nitro',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/nitrous.png',
				['description'] = 'Nitro creste cantitatea de oxigen care intra in cilindrii motoarelor. Este ca si cum, pentru cateva secunde, el extinde volumul motorului pentru a genera energie',
				['index'] = 6
			},
			['class'] = 'nitro'
		},
		['AWD'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fDriveBiasFront',
				['value'] = 0.5,
				['powered_wheels'] = {0,1,2,3},	-- If the upgrade changes the drive bias, the vehicle powered wheels must be changed too
				['fixed_value'] = true
			},
			['item'] = {
				['name'] = 'AWD',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'AWD swap',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/awd.png',
				['description'] = 'O transmisie AWD inseamna ca motorul roteste toate cele 4 roti ale vehiculului dumneavoastra',
				['index'] = 7
			},
			['class'] = 'differential'
		},
		['RWD'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fDriveBiasFront',
				['value'] = 0.0,
				['powered_wheels'] = {2,3},
				['fixed_value'] = true
			},
			['item'] = {
				['name'] = 'RWD',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'RWD swap',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/rwd.png',
				['description'] = 'O transmisie RWD inseamna ca motorul roteste cele 2 roti din spate ale vehiculului dumneavoastra',
				['index'] = 8
			},
			['class'] = 'differential'
		},
		['FWD'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fDriveBiasFront',
				['value'] = 1.0,
				['powered_wheels'] = {0,1},
				['fixed_value'] = true
			},
			['item'] = {
				['name'] = 'FWD',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'FWD swap',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/fwd.png',
				['description'] = 'O transmisie FWD inseamna ca motorul roteste cele 2 rosi din fata ale vehiculului dumneavoastra',
				['index'] = 9
			},
			['class'] = 'differential'
		},

		['semislick'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fTractionCurveMax',
				['value'] = 0.4,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'semislick',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Semi Slick tires',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/semislick.png',
				['description'] = 'Anvelopa semi-slick este o anvelopa omologata pe strada utilizata pentru a exploata pe deplin performanta vehiculelor',
				['index'] = 10
			},
			['class'] = 'tires'
		},
		['slick'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fTractionCurveMax',
				['value'] = 0.8,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'slick',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Slick tires',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/slick.png',
				['description'] = 'Anvelopele slick deoarece sunt netede au o zona mai mare de contact cu solul asigurand astfel performante mai bune',
				['index'] = 11
			},
			['class'] = 'tires'
		},

		['race_brakes'] = {
			['improvements'] = {
				['type'] = 'CHandlingData',
				['handId'] = 'fBrakeForce',
				['value'] = 2.0,
				['fixed_value'] = false
			},
			['item'] = {
				['name'] = 'race_brakes',
				['amount'] = 1,
				['time'] = 10
			},
			['interface'] = {
				['name'] = 'Brembo brakes',
				['icon_color'] = '#ffffff00',
				['icon'] = 'images/upgrades/race_brakes.png',
				['description'] = 'Franele de curse au o putere de franare mult mai mare si nu se supraincalzesc ca franele obisnuite',
				['index'] = 12
			},
			['class'] = 'brakes'
		},
	}
}

-- Repair config
Config.repair = {
	['engine'] = {			-- Part index (dont change)
		['items'] = {		-- Items required to repair the part
			['piston'] = 4,
			['rod'] = 4,
			['oil'] = 3
		},
		['time'] = 10,		-- Time to repair
		['repair'] = {		-- The handling entries that will go back to default
			"engine",		-- engine: will fix the engine health
			"fInitialDriveForce",
		}
	},
	['transmission'] = {
		['items'] = {
			['gear'] = 5,
			['transmission_oil'] = 2
		},
		['time'] = 10,
		['repair'] = {
			"fClutchChangeRateScaleUpShift"
		}
	},
	['chassis'] = {
		['items'] = {
			['iron'] = 10,
			['aluminum'] = 2
		},
		['time'] = 10,
		['repair'] = {
			"body"		-- body: will fix the body health
		}
	},
	['brakes'] = {
		['items'] = {
			['brake_discs'] = 4,
			['brake_pads'] = 4,
			['brake_caliper'] = 2
		},
		['time'] = 10,
		['repair'] = {
			"fBrakeForce"
		}
	},
	['suspension'] = {
		['items'] = {
			['shock_absorber'] = 4,
			['springs'] = 4
		},
		['time'] = 10,
		['repair'] = {
			"fTractionCurveMax",
			"fSuspensionForce"
		}
	}
}

Config.infoTextsPage = {
	[1] = {
		['icon'] = "images/info.png",
		['title'] = "Informatii Utile",
		['text'] = "Acesta este panoul de Intretinere a vehiculului. Trebuie sa aveti grija de vehicul pentru a-l pastra in stare buna de utilizare.Exista mai multe lucruri de intretinere la fiecare X KM, de exemplu, uleiul de motor trebuie schimbat la fiecare 1500 KM sau motorul dvs va incepe sa se deterioreze. Celelalte revizuiri trebuie facute la un KM mai mare, duceti vehiculul la un mecanic, astfel incat acesta sa va poata informa cu privire la durata de viata utila a pieselor vehiculului dvs."
	},
	[2] = {
		['icon'] = "images/services.png",
		['title'] = "Cum sa duci masina la Service",
		['text'] = "Trebuie sa efectuati intretinerea preventiva la momentul corect, pentru aceasta,purtati vehiculul la un mecanic de incredere. El va putea sa scaneze partile masinii dvs. si dupa ce a trecut de scaner va avea informatiile actualizate ale fiecarei piese care trebuie inlocuite."
	},
	[3] = {
		['icon'] = "images/repair.png",
		['title'] = "Reparatii",
		['text'] = "Fila de reparatii este utilizata atunci cand orice parte a vehiculului dvs. isi pierde performanta,acest lucru se intampla atunci cand intretinerea nu este efectuata la data preconizata. Reparatiile sunt costisitoare si trebuie facute, deoarece piesele deteriorate afecteaza grav performanta vehiculului dvs deci asigurati-va ca efectuati orice intretinere."
	},
	[4] = {
		['icon'] = "images/performance.png",
		['title'] = "Imbunatatiri",
		['text'] = "Daca doriti sa condimentati experienta cu vehiculul dvs puteti instala cateva piese de performanta pe acesta,dar <b>PRUDENTA!!</b> Piesele de performanta sunt extrem de puternice si afecteaza direct fizica vehiculului dvs deci trebuie sa alegeti cu intelepciune ce piesa sa instalati sau vehiculul dvs poate deveni instabil sau chiar rasturnat,Mecanicul nu este responsabil pentru actualizari necorespunzatoare."
	}
}
Config.createTable = true