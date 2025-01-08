-- local cfg = {}

-- cfg.gunshop_types = {
--   ["Normal"] = {
--     _config = {blipcolor = 1,blipid = 110,armor = false},
--     ["WEAPON_BAT"] = {"Bata",50000,0,""},
--     ["WEAPON_KNUCKLE"] = {"Pumnal",70000,0,""},
--     ["WEAPON_KNIFE"] = {"Cutit",90000,0,""},
--     ["WEAPON_HATCHET"] = {"Topor",100000,0,""},
--     ["WEAPON_MACHETE"] = {"Maceta",110000,0,""},
--   },

--   ["Politie"] = {
--     _config = {faction = "Politie"},
--     ["weapon_nightstick"] = {"Bulan",0,0,""},
--     ["weapon_stungun"] = {"Tazer",0,0,""},
--     ["weapon_pistol50"] = {"Pistol",0,0,""},
--     ["weapon_combatpdw"] = {"Combat PDW",0,0,""},
--     ["weapon_pumpshotgun"] = {"Pump Shotgun",0,0,""},
--     ["weapon_carbinerifle"] = {"Carbine Rifle",0,0,""},
--     ["weapon_sniperrifle"] = {"Sniper",0,0,""},
--     ["weapon_revolvemk2"] = {"Revolver MK2",0,0,""},
--   },

--   ["Smurd"] = {
--     _config = {faction = "Smurd",armor = false},
--     ["WEAPON_FLASHLIGHT"] = {"Lanterna",0,0,""},
--     ["WEAPON_NIGHTSTICK"] = {"Nightstick",0,0,""},
--     ["WEAPON_STUNGUN"] = {"Tazer",0,0,""},
--   },

--   ["Guvern"] = {
--     _config = {faction = "Guvern",armor = true},
--     ["WEAPON_REVOLVER"] = {"Revolver",0,0,""},
--     ["body_armor"] = {"Armura", 0,0,""},
--   },
  
--   ["Hitman"] = {
--     _config = {faction = "Hitman"},
--     ["WEAPON_FLASHLIGHT"] = {"Lanterna",1000000,0,""},
--     ["WEAPON_NIGHTSTICK"] = {"Baston",1000000,0,""},
--     ["WEAPON_PISTOL_MK2"] = {"Pistol",10000000,75000,""},
--     ["WEAPON_PUMPSHOTGUN"] = {"Shothgun",15000000,90000,""},
--     ["WEAPON_CARBINERIFLE_MK2"] = {"Carabina MK2",8500000,100000,""},
--     ["WEAPON_SMG"] = {"SMG",3000000,50000,""},
--     ["WEAPON_HEAVYSNIPER"] = {"Sniper",15000000,200000,""}
--   },

--   ["Sindicat"] = {
--     _config = {blipid=110, blipcolor=1, faction = "Sindicat"},
--     ["WEAPON_PUMPSHOTGUN"] = {"Pump Shotgun",3000000,60000,""},
--     ["body_armor"] = {"Armura", 1,0,""},
--     ["WEAPON_ASSAULTSMG"] = {"Assault SMG",4250000,60000,""},
--     ["WEAPON_SPECIALCARBINE"] = {"Carabina MK2",5000000,75000,""},
--     ["WEAPON_COMBATMG"] = {"Combat MG",4000000,75000,""},
--     ["WEAPON_DOUBLEACTION"] = {"Double Action Revolver",5000000,150000,""},
--   },

--   --- MAFIII -------
--   ["Los Vagos"] = {
--     _config = {blipid=110, blipcolor=74, faction = "Los Vagos", pesosi = true},
--     ["WEAPON_PUMPSHOTGUN"] = {"Pump Shotgun",3000000,60000,""},
--     ["WEAPON_ASSAULTSMG"] = {"Assault SMG",4250000,60000,""},
--     ["WEAPON_SPECIALCARBINE"] = {"Carabina MK2",5000000,75000,""},
--     ["WEAPON_COMBATMG"] = {"Combat MG",4000000,75000,""},
--     ["WEAPON_DOUBLEACTION"] = {"Double Action Revolver",5000000,150000,""},
--   },

--   ["Los Aztecas"] = {
--     _config = {blipid=110, blipcolor=74, faction = "Los Aztecas", pesosi = true},
--     ["WEAPON_PUMPSHOTGUN"] = {"Pump Shotgun",3000000,60000,""},
--     ["WEAPON_ASSAULTSMG"] = {"Assault SMG",4250000,60000,""},
--     ["WEAPON_SPECIALCARBINE"] = {"Carabina MK2",5000000,75000,""},
--     ["WEAPON_COMBATMG"] = {"Combat MG",4000000,75000,""},
--     ["WEAPON_DOUBLEACTION"] = {"Double Action Revolver",5000000,150000,""},
--   },


--   ["Sons of Anarchy"] = {
--     _config = {blipid=110, blipcolor=74, faction = "Sons of Anarchy", pesosi = true},
--     ["WEAPON_PUMPSHOTGUN"] = {"Pump Shotgun",3000000,60000,""},
--     ["WEAPON_ASSAULTSMG"] = {"Assault SMG",4250000,60000,""},
--     ["WEAPON_SPECIALCARBINE"] = {"Carabina MK2",5000000,75000,""},
--     ["WEAPON_COMBATMG"] = {"Combat MG",4000000,75000,""},
--     ["WEAPON_DOUBLEACTION"] = {"Double Action Revolver",5000000,150000,""},
--   },

--   ["Mafia Corleone"] = {
--     _config = {blipid=110, blipcolor=74, faction = "Mafia Corleone", pesosi = true},
--     ["WEAPON_PUMPSHOTGUN"] = {"Pump Shotgun",3000000,60000,""},
--     ["WEAPON_ASSAULTSMG"] = {"Assault SMG",4250000,60000,""},
--     ["WEAPON_SPECIALCARBINE"] = {"Carabina MK2",5000000,75000,""},
--     ["WEAPON_COMBATMG"] = {"Combat MG",4000000,75000,""},
--     ["WEAPON_DOUBLEACTION"] = {"Double Action Revolver",5000000,150000,""},
--   },

--   ["The Demons"] = {
--     _config = {blipid=110, blipcolor=74, faction = "The Demons", pesosi = true},
--     ["WEAPON_PUMPSHOTGUN"] = {"Pump Shotgun",3000000,60000,""},
--     ["WEAPON_ASSAULTSMG"] = {"Assault SMG",4250000,60000,""},
--     ["WEAPON_SPECIALCARBINE"] = {"Carabina MK2",5000000,75000,""},
--     ["WEAPON_COMBATMG"] = {"Combat MG",4000000,75000,""},
--     ["WEAPON_DOUBLEACTION"] = {"Double Action Revolver",5000000,150000,""},
--   },

--   ["Bloods"] = {
--     _config = {blipid=110, blipcolor=74, faction = "Bloods", pesosi = true},
--     ["WEAPON_PUMPSHOTGUN"] = {"Pump Shotgun",3000000,60000,""},
--     ["WEAPON_ASSAULTSMG"] = {"Assault SMG",4250000,60000,""},
--     ["WEAPON_SPECIALCARBINE"] = {"Carabina MK2",5000000,75000,""},
--     ["WEAPON_COMBATMG"] = {"Combat MG",4000000,75000,""},
--     ["WEAPON_DOUBLEACTION"] = {"Double Action Revolver",5000000,150000,""},
--   },

--   ["Grove Street"] = {
--     _config = {blipid=110, blipcolor=74, faction = "Grove Street", pesosi = true},
--     ["WEAPON_PUMPSHOTGUN"] = {"Pump Shotgun",3000000,60000,""},
--     ["WEAPON_ASSAULTSMG"] = {"Assault SMG",4250000,60000,""},
--     ["WEAPON_SPECIALCARBINE"] = {"Carabina MK2",5000000,75000,""},
--     ["WEAPON_COMBATMG"] = {"Combat MG",4000000,75000,""},
--     ["WEAPON_DOUBLEACTION"] = {"Double Action Revolver",5000000,150000,""},
--   },

--   ["Mafia Albaneza"] = {
--     _config = {blipid=110, blipcolor=74, faction = "Mafia Albaneza", pesosi = true},
--     ["WEAPON_PUMPSHOTGUN"] = {"Pump Shotgun",3000000,60000,""},
--     ["WEAPON_ASSAULTSMG"] = {"Assault SMG",4250000,60000,""},
--     ["WEAPON_SPECIALCARBINE"] = {"Carabina MK2",5000000,75000,""},
--     ["WEAPON_COMBATMG"] = {"Combat MG",4000000,75000,""},
--     ["WEAPON_DOUBLEACTION"] = {"Double Action Revolver",5000000,150000,""},
--   },

--   ["Red Triads"] = {
--     _config = {blipid=110, blipcolor=74, faction = "Red Triads", pesosi = true},
--     ["WEAPON_PUMPSHOTGUN"] = {"Pump Shotgun",3000000,60000,""},
--     ["WEAPON_ASSAULTSMG"] = {"Assault SMG",4250000,60000,""},
--     ["WEAPON_SPECIALCARBINE"] = {"Carabina MK2",5000000,75000,""},
--     ["WEAPON_COMBATMG"] = {"Combat MG",4000000,75000,""},
--     ["WEAPON_DOUBLEACTION"] = {"Double Action Revolver",5000000,150000,""},
--   },

--   ["Merryweather Security"] = {
--     _config = {blipid=110, blipcolor=74, faction = "Merryweather Security", pesosi = true},
--     ["WEAPON_PUMPSHOTGUN"] = {"Pump Shotgun",3000000,60000,""},
--     ["WEAPON_ASSAULTSMG"] = {"Assault SMG",4250000,60000,""},
--     ["WEAPON_SPECIALCARBINE"] = {"Carabina MK2",5000000,75000,""},
--     ["WEAPON_COMBATMG"] = {"Combat MG",4000000,75000,""},
--     ["WEAPON_DOUBLEACTION"] = {"Double Action Revolver",5000000,150000,""},
--   },

--   ["Garda Veche"] = {
--     _config = {blipid=110, blipcolor=74, faction = "Merryweather Security", pesosi = true},
--     ["WEAPON_PUMPSHOTGUN"] = {"Pump Shotgun",3000000,60000,""},
--     ["WEAPON_ASSAULTSMG"] = {"Assault SMG",4250000,60000,""},
--     ["WEAPON_SPECIALCARBINE"] = {"Carabina MK2",5000000,75000,""},
--     ["WEAPON_COMBATMG"] = {"Combat MG",4000000,75000,""},
--     ["WEAPON_DOUBLEACTION"] = {"Double Action Revolver",5000000,150000,""},
--   },
-- }

-- cfg.gunshops = {
--    ----Civil----
--   --{"Normal", 843.41326904296,-1033.5826416016,28.194860458374,false},
--   --{"Normal", 252.50219726562,-49.00774383545,69.941078186036,false},
--   --{"Normal", 811.21942138672,-2157.1469726562,29.619012832642,false},
--   --{"Normal", -663.18841552734,-935.29486083984,21.829221725464,false},
--   --{"Normal", -1305.599975586,-393.20083618164,36.69577407837,false},
--   --{"Normal", 21.147958755493,-1106.3408203125,29.797012329102,false},
--   --{"Normal", -331.6579284668,6082.392578125,31.454763412476,false},
--   --{"Normal", -3172.6442871094,1085.9375,20.838750839233,false},
--   --{"Normal", -1119.3117675781,2697.291015625,18.554153442383,false},
--   --{"Normal", 1692.2591552734,3758.3828125,34.705341339111,false},
--   --{"Normal", 2569.7927246094,294.38684082031,108.73487091064,false},

--   ----FACTIUNI ILEGALE----
--   --{"Smurd", 309.60491943359,-561.39703369141,43.284027099609,false},
--   --{"Politie", 484.25704956054,-1002.0671386718,25.734649658204,false},

--   ----FACTIUNI ILEGALE----
--   --{"Grove Street", 500.18649291992,-1812.9627685546,28.867441177368,false},
--   --{"Los Vagos", -1024.9102783204,360.21673583984,71.361541748046,false},
--   --{"The Demons", -876.57525634766,306.07983398438,84.149307250976,false},
--   --{"Bloods", -101.98550415039,824.07733154297,227.59614562988,false},
--   --{"Sindicat", -3357.837890625, 1787.6290283203, 26.140260696411,false},
--   --{"Mafia Albaneza", -113.50871276856,985.79870605468,235.75395202636,false},
--   --{"Sons of Anarchy", 987.88708496094,-95.124992370606,74.845527648926,false},
--   --{"Red Triads",-1629.6324462891,36.774253845215,62.936130523682,false},
--   --{"Merryweather Security", 566.47082519531,-3124.6936035156,18.768619537354,false},
--   --{"Hitman", -467.98645019531,1128.9805908203,325.85549926758,false},
--   --{"Grada Veche", -799.16064453125,177.14372253418,72.834777832031,false},
-- }

-- return cfg

-- -799.16064453125,177.14372253418,72.834777832031