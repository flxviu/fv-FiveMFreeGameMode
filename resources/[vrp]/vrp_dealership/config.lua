local cfg = {}

cfg.dealership = {-49.732929229736,-1094.3466796875,26.422369003296}
cfg.market = {-32.758369445801, -1111.6053466797, 26.422374725342}

cfg.vehicles = {
    ["BMW"] = {
        {"BMW X6M", "x6m21", 65000000},
        {"BMW I8", "rmodi8mlb", 410000000},
        {"BMW E46", "m3e46", 40000000},
        {"BMW M2", "m2", 70000000},
        {"BMW M6", "M6C2013", 50000000},
        {"BMW M8", "bmwm8", 350000000},
        {"BMW M760i", "17m760i", 90000000},
        {"BMW 540L", "540l", 85000000},
        {"BMW X5", "48is", 95000000},
        {"BMW M760i", "17m760i", 150000000}
    },
    ["#Masini de Inceput"] = {
        {"Alfa Romeo Giulia", "giulia", 35000000},
        {"Cadillac CTSV", "ctsv16", 25000000},
        {"Lexus GS-350", "gs350", 15000000},
        {"Volvo 850r", "v850r", 11000000},
        {"Daewoo Leganza", "leganza", 9000000},
        {"MW M3 E30", "m3e30", 20000000},
        {"Fiat Fiorino", "fiorino", 12000000},
        {"BMW E60", "m5e60", 30000000},
        {"Opel Corsa", "corsa09", 10000000},
        {"Honda Civic Si", "civic", 8000000},
        {"Volkswagen Golf MK1", "mk1rabbit", 90000000},
        {"Mitsubishi Evolution IX", "evo9mr", 40000000},
        {"Toyota Corolla AE86", "ae86", 14000000},
        {"Audi Quattro '83", "audquattros", 25000000},
        {"Audi RS2", "80B4", 20000000},
        {"Dacia Logan", "logan", 3000000},
        {"Dacia Sandero", "sanderos", 3500000}
    },
    ["Audi"] = {
        {"Audi RS6 2021", "rs6c8", 50000000},
        {"Audi RS6 Avant 2021", "rs6avant20", 130000000},
        {"Audi RS5 2011", "rs5", 155000000},
        {"Audi S5", "auds5", 130000000},
        {"Audi A8", "a8fsi", 190000000},
        {"Audi Q8", "q820", 250000000},
        {"Audi RS7 2016", "2016rs7", 280000000},
        {"Audi RS5-R ABT", "rs5r", 180000000},
        {"Audi R8 V10", "r820", 290000000}
    },
    ["Ford"] = {
        {"Ford Everest", "everest", 120000000},
        {"Ford Mustang 1969", "BOSS429", 80000000},
        {"Ford Mustang GT500", "mst", 190000000},
        {"Ford Bronco 2021", "wildtrak", 250000000}
    },
    ["Mercedesbenz"] = {
        {"Mercedes-Benz A Class", "macla", 230000000},
        {"Mercedes-Benz GL63", "gl63", 245000000},
        {"Mercedes-Benz A45 2017", "a45", 135000000},
        {"Mercedes-Benz E63 AMG", "e63amg", 280000000},
        {"Mercedes-Benz CLS 53 AMG", "cls53", 285000000},
        {"Mercedes-Benz C63S AMG", "c63s", 275000000},
        {"Mercedes-Benz S600 (Model Vechi)", "s600w220", 250000000},
        {"Mercedes-Benz Sprinter", "sprinter", 345000000},
        {"Mercedes-Benz GT-S AMG", "amggts", 360000000}
    },
    ["Volkswagen"] = {
        {"Volkswagen Passat", "vwstance", 140000000},
        {"Volkswagen Golf 7R", "golf75r", 300000000},
        {"Volkswagen Passat R-Line", "passatr", 250000000},
        {"Volkswagen Touareg", "vwtoua19cf", 150000000},
        {"Volkswagen Touran", "vwtouran", 170000000}
    },
	["Lamborghini"] = {
        {"Lamborghini Terzo", "terzo", 890000000},
        {"Lamborghini Urus", "urus", 570000000},
        {"Lamborghini Aventador SVJ", "svj63", 610000000},
        {"Lamborghini Murcielago LP670", "lp670sv", 560000000},
        {"Lamborghini Aventador", "lp700r", 495000000}
    },
    ["Nissan"] = {
        {"Nissan 180SX (Drift)", "180sx", 235000000},
        {"Nissan 370z (Drift)", "370z", 150000000},
        {"Nissan Silvia S15 (Drift)", "s15", 190000000},
        {"Nissan Skyline C110 (Drift)", "skylinec110", 170000000},
        {"Nissan Skyline GTR R32", "r32", 200000000},
        {"Nissan Skyline GTR R35", "gtr", 250000000}
    },
    ["Honda"] = {
        {"Honda Civic Type-R", "hondacivictr", 190000000},
        {"Honda S2000", "ap2", 180000000},
        {"Honda NSX 1990", "na1", 225000000},
        {"Honda NSX 2005", "nsx4", 230000000}
    },
    ["McLaren"] = {
        {"McLaren 720S", "720s", 2210000000}
    },
    ["Chevrolet"] = {
        {"Chevrolet Camaro Z28 1979", "z2879", 180000000},
        {"Chevrolet Camaro ZL1", "zl12017", 2100000000},
        {"Chevrolet Chevelle 1970", "chevelle1970", 250000000},
        {"Chevrolet Impala SS 1964", "impalass", 270000000}
    },
    ["Bugatti"] = {
        {"Bugatti Divo", "bdivo", 750000000},
        {"Bugatti Veyron", "bugatti", 550000000}
    },
    ["Rolls Royce"] = {
        {"Rolls Royce Wraith", "wraith", 370000000}
    },
    ["Porsche"] = {
        {"Porsche Cayman 718", "718caymans", 2150000000},
        {"Porsche Cayenne S", "pcs18", 290000000}
    },
    ["Motociclete"] = {
        {"Motor BMW", "bmw", 150000000},
        {"BMW S1000RR", "bmws", 550000000},
        {"Ducati Desmo", "desmo", 200000000},
        {"MV Agusta", "f4rr", 80000000},
        {"Honda CBR1000RR", "hsp217", 300000000},
        {"Suzuki Hayabusa", "hyabusadrag", 250000000},
        {"KTM 450 SX-F", "ktm450sx", 100000000},
        {"Kawasaki Ninja H2R", "nh2r", 600000000},
        {"Ducati Panigale", "panigale", 250000000},
        {"XT66 FOGUETE", "xt66", 120000000}

    },
    ["Altele"] = {
        {"Cursiera", "tribike3", 2000000},
        {"MTB", "scorcher", 1500000},
        {"BMX", "bmx", 2000000},
        {"Aston Martin Vantage", "vantage", 110000000},
        {"Tesla Model S", "models", 150000000},
        {"Tesla Model 3", "tmodel", 200000000},
        {"Range Rover Vogue", "rrst", 90000000},
        {"Cadillac CTSV", "ctsv16", 250000000},
        {"Mitsubishi GTO 1993", "gto", 105000000},
        {"Mitsubishi Evolution X", "evo10", 140000000},
        {"Dodge Challenger", "16charger", 135000000},
        {"Dodge Charger", "16challenger", 140000000},
        {"Dodge Viper 1999", "99viper", 190000000},
        {"Subaru Impreza STi 2004", "subwrx", 135000000},
        {"Subaru Impreza STi 22B", "sim22", 130000000},
        {"Subaru BRZ", "brz13", 135000000},
        {"Toyota Supra A90", "supra19", 135000000},
        {"Toyota Supra A80", "a80", 132000000},
        {"Mazda Miata (Drift)", "miata3", 130000000},
        {"Mazda RX7 VEILSIDE (Drift)", "rx7veilside", 128000000},
        {"Mazda RX7", "rx7tunable", 123000000}


    }
}

return cfg