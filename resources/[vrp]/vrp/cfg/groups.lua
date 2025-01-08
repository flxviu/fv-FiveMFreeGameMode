
local cfg = {}


cfg.firstjob = false -- set this to your first job, for example "citizen", or false to disable

cfg.groups = {
  -- the group user is auto added to all logged players
  ["user"] = {
  },
  ["WeaponDealer"] = {
		_config = {onspawn = function(player)end},
  },
  
	["youtuber"] = {
		_config = {onspawn = function(player)end},
  },
 
  ["onduty"] = {
    _config = {onspawn = function(player)end},
  },
  
  ["Mecanic"] = {
    _config = { gtype = "job",
		onspawn = function(player) end},
  },
  ["Taxi"] = {
    _config = { gtype = "job",
	onspawn = function(player) vRPclient.notify(player,{"Esti taximetrist boss! Vezi sa accepti toate cursele!"}) end
	},
    "uber.service",
	  "uber.vehicle"
  },

  ["Electrician"] = {
    _config = { gtype = "job",
  onspawn = function(player) vRPclient.notify(player,{"Succes: Te-ai logat ca Electrician"}) end},
  "electrician.haine",
  },

  ["Miner"] = {
    _config = { gtype = "job",
  onspawn = function(player) vRPclient.notify(player,{"Succes: Te-ai logat ca Miner"}) end},
  "miner.haine",
  },

  ["Gunoier"] = {
    _config = {gtype = "job", onspawn = function(player) vRPclient.notify(player,{"Esti angajat ca Gunoier"}) end},
},
["Electrician"] = {
    _config = {gtype = "job", onspawn = function(player) vRPclient.notify(player,{"Esti angajat ca Electrician"}) end},
},
["Gradinar"] = {
    _config = {gtype = "job", onspawn = function(player) vRPclient.notify(player,{"Esti angajat ca Gradinar"}) end},
},
["Curier"] = {
  _config = {gtype = "job", onspawn = function(player) vRPclient.notify(player,{"Esti angajat ca Curier"}) end},
},
["Miner"] = {
    _config = {gtype = "job", onspawn = function(player) vRPclient.notify(player,{"Esti angajat ca Miner"}) end},
},
["Pescar"] = {
    _config = {gtype = "job", onspawn = function(player) vRPclient.notify(player,{"Esti angajat ca Pescar"}) end},
},
["Santierist"] = {
    _config = {gtype = "job", onspawn = function(player) vRPclient.notify(player,{"Esti angajat ca Santierist"}) end},
},
["Sofer Autobuz"] = {
    _config = {gtype = "job", onspawn = function(player) vRPclient.notify(player,{"Esti angajat ca Sofer Autobuz"}) end},
},
["Taietor Lemne"] = {
    _config = {gtype = "job", onspawn = function(player) vRPclient.notify(player,{"Esti angajat ca Taietor Lemne"}) end},
},


  ["Pilot"] = {
    _config = { gtype = "job",
	onspawn = function(player) vRPclient.notify(player,{"Succes: Te-ai logat ca Pilot"}) end
	},
    "pilot.vehicle",
    "pilot.haine",
  },

  ["Pescar"] = {
    _config = { gtype = "job",
  onspawn = function(player) vRPclient.notify(player,{"Succes: Te-ai logat ca Pescar"}) end},
  "pescar.haine",
  },

  ["Petrolist"] = {
    _config = { gtype = "job",
	onspawn = function(player) vRPclient.notify(player,{"Succes: Te-ai logat ca Petrolist"}) end
	},
    "petrolist.vehicle",
    "petrolist.haine",
  },

  ["Marinar"] = {
    _config = { gtype = "job",
  onspawn = function(player) vRPclient.notify(player,{"Succes: Te-ai logat ca Marinar"}) end},
  "marinar.haine",
  },

  ["Sofer Autobuz"] = {
    _config = { gtype = "job",
  onspawn = function(player) vRPclient.notify(player,{"Succes: Te-ai logat ca Sofer Autobuz"}) end},
  "soferautobuz.haine",
  },

  ["Sofer Autobuz Avansat"] = {
    _config = { gtype = "job",
  onspawn = function(player) vRPclient.notify(player,{"Succes: Te-ai logat ca Sofer Autobuz Avansat"}) end},
  "soferautobuzavansat.haine",
  },

  ["Ciupercar"] = {
    _config = { gtype = "job",
  onspawn = function(player) vRPclient.notify(player,{"Succes: Te-ai logat ca si Ciupercar"}) end},
  "ciupercar.haine",
  },

  ["Constructor"] = {
    _config = { gtype = "job",
  onspawn = function(player) vRPclient.notify(player,{"Succes: Te-ai logat ca si Constructor"}) end},
  "constructor.haine",
  },

  ["Santierist"] = {
    _config = { gtype = "job",
  onspawn = function(player) vRPclient.notify(player,{"Succes: Te-ai logat ca Santierist"}) end},
  "santierist.haine",
  },

  ["Trucker"] = {
    _config = { gtype = "job",
  onspawn = function(player) vRPclient.notify(player,{"Succes: Te-ai logat ca Trucker"}) end},
  "trucker.haine",
  },


  ["Traficant de droguri"] = {
    _config = { gtype = "job",
	onspawn = function(player) vRPclient.notify(player,{"Succes: Te-ai logat ca Traficant de droguri"}) end
	},
    "mission.drugseller.weed",
    "misiune.droguri",
	  "harvest.drugs"
  },

  ["Fan Courier"] = {
    _config = { gtype = "job",
	onspawn = function(player) vRPclient.notify(player,{"Succes: Te-ai logat ca Fan Courier"}) end
	},
	  "harvest.parcels",
    "curier.haine",
	  "fancourier.vehicle",
    "mission.delivery.parcels",
    "mission.delivery.cargo"
  },

  ["Pizza Boy"] = {
    _config = { gtype = "job",
	onspawn = function(player) vRPclient.notify(player,{"Succes: Te-ai logat ca Pizza Boy"}) end
	},
	  "harvest.pizza",
	  "pizza.vehicle",
    "pizzaboy.haine",
    "mission.delivery.pizza"
  },


  ["Brutar"] = {
    _config = { gtype = "job",
	onspawn = function(player) vRPclient.notify(player,{"Succes: Te-ai logat ca Brutar"}) end
	},
	  "harvest.brutar",
	  "brutar.vehicle",
    "brutar.haine",
    "mission.delivery.brutar"
  },

  ["Somer"] = {
    _config = { gtype = "job",
	onspawn = function(player) vRPclient.notify(player,{"Succes: Te-ai logat ca Somer"}) end},
  },

  ["Curier Mancare"] = {
    _config = { gtype = "job",
	onspawn = function(player) vRPclient.notify(player,{"Succes: Te-ai logat ca Livrator de mancare"}) end
	},
    "harvest.delivery.food",
	  "mission.delivery.food",
    "curiermancare.haine",
	  "delivery.vehicle"
  },
  
}

-- group selectors
-- _config
--- x,y,z, blipid, blipcolor, permissions (optional)
cfg.selectors = {

}


return cfg