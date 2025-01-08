local cfg = {}

cfg.market_types = {
    ["Magazin Set Chimie"] = {
        _config = {},
        ["chem_set"] = 1000000,
    },

    ["Magazin Bar"] = {
        _config = {faction = "Mafia Rusa"},
        ["water"] = 0,
        ["coffe"] = 0,
        ["redbull"] = 0,
        ["vodka"] = 0,
        ["milk"] = 0,
        ["ciorbadevaca"] = 0,
        ["lighter"] = 0,
    },

    ["Alimentara"] = {
        _config = {blipid=52, blipcolor=2},
       
        -- list itemid => price
        -- Drinks
        ["aphone"] = 1000000,
        ["milk"] = 20,
        ["lighter"] = 20,
        ["water"] = 10,
        ["coffe"] = 40,
        
        ["tea"] = 40,
        ['radio'] = 2000000,
        ["icetea"] = 25,
        ["orangejuice"] = 25,
        ["cocacola"] = 50,
        ["redbull"] = 70,
        ["lemonade"] = 5,
        ["vodka"] = 300,
        ['bread'] = 1,
        ['food_1'] = 1,
        ['food_3'] = 1,
        ['food_4'] = 1,
        ['food_11'] = 1,
        ["donut"] = 5,
        ["tacos"] = 10,
        ["sandwich"] = 5,
        ["ciorbadevaca"] = 45,
        ["pdonut"] = 650,

                -- altele
                ["acetona"] = 10,  
                ["faina"] = 10,  
                ["foita"] = 10,  
                ["filtru"] = 10,  
                ["prafdecopt"] = 10,  
                -- drugs
                ["afine"] = 10,  
                ["lamaie"] = 10,  
                ["marauriu"] = 10, 
                ["capsuni"] = 10, 
                ["zmeura"] = 10,  
                ["ciocolata"] = 10,  
                ["coacaze"] = 10,  
                ["pachetcocaina"] = 10,  
    },

    ["Unelte"] = {
        _config = {},
        ["momealapeste"] = 10,
        ["undita"] = 500,
    },

    ["Magazin de Tigari"] = {
        _config = {permissions={"contrabanda.tigari"}},
        ["foita"] = 1000000,
        ["tutun"] = 500000,
    },

    ["Echipament Mecanic"] = {
        _config = {blipid = 446, blipcolor=47, faction = "Mecanic"},
        ["repairkit"] = 5000,
        ["scanner"] = 100000,
        ["mecanic_licenta"] = 50000,
        
        ["oil"] = 30000,
        ["tires"] = 45000,
        ["brake_pads"] = 50000,
        ["transmission_oil"] = 40000,
        ["shock_absorber"] = 75000,
        ["clutch"] = 90000,
        ["air_filter"] = 50000,
        ["fuel_filter"] = 30000,
        ["spark_plugs"] = 200000,
        ["serpentine_belt"] = 60000,
        ["susp"] = 40000,
        ["susp1"] = 40000,
        ["susp2"] = 40000,
        ["susp3"] = 40000,
        ["susp4"] = 40000,
        
        ["garett"] = 170000,
        ["nitrous"] = 150000,
        ["AWD"] = 160000,
        ["RWD"] = 100000,
        ["FWD"] = 100000,
        ["semislick"] = 150000,
        ["slick"] = 140000,
        ["race_brakes"] = 40000,
        ["piston"] = 40000,
        ["rod"] = 40000,
        ["gear"] = 4000000,
        ["brake_discs"] = 85000,
        ["brake_caliper"] = 85000,
        ["springs"] = 60000,
        ["iron"] = 92000,
        ["aluminum"] = 90000
    },
 
    
    ["Magazin Carduri"] = {
        _config = {},
        ["secure_card"] = 1000000
    },

    ["Atasamente Arma"] = {
        _config = {},
        ["lanterna"] = 70000,
        ["surpresor"] = 100000,
        ["grip"] = 150000,
        ["skin"] = 70000
    },

    ["Farmacie"] = {
        _config = {},
        ["bandaj"] = 50000,
        ["adrenalina"] = 300000
    },

    ["Echipament Politie"] = {
        _config = {blipcolor=68, faction = "Politie"},
        ["medkit"] = 0,
        ["radarpd"] = 0,
        ["body_armor"] = 0
    },

        ["Electronice"] = {
            _config = {blipid=52, blipcolor=2},
        ["aphone"] = 1000000,
    },
    
 
    ["Echipament Medical"] = {
        _config = {blipcolor=68, faction = "Smurd"},
        ["medkit"] = 0,
        ["repairkit"] = 5000,
        ["body_armor"] = 0
    },
    ["Echipament Sindicat"] = {
        _config = {blipcolor=68, faction = "Sindicat"},
        ["medkit"] = 0,
        ["body_armor"] = 0
    }
}

cfg.markets = {
    {"Magazin Set Chimie",vector3(-264.13201904297,2196.4829101563,130.39877319336)},
    --{"Magazin Bar",vector3(417.31256103516,-1497.390625,30.155347824096)},
    {"Magazin de Tigari",vector3(-332.96264648438,57.060924530029,54.429843902588)},
    {"Licenta Taxi",vector3(-34.422885894775,-1676.6795654297,29.491256713867)},
    {"Echipament Mecanic",vector3(-345.14892578125,-131.1128692627,39.009620666504)},
    --{"Atasamente Arma",vector3(-169.8249206543,285.20291137695,93.763916015625)},
    {"Farmacie",vector3(312.35784912109,-592.95141601563,43.283981323242)},
    {"Echipament Politie",vector3(486.76940917968,-1001.814880371,25.73466873169)},
    {"Echipament Medical",vector3(306.10531616211,-597.52618408203,43.284030914307)},
    {"Magazin Piese Auto", vector3(-593.75079345703,-926.85174560547,28.143978118896)},
    {"Magazin Carduri", vector3(414.01257324219, -1508.6011962891, 29.291595458984)},

    {"Unelte",vector3(726.8037109375,4169.4116210938,40.709232330322)},
}

return cfg