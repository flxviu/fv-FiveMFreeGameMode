fx_version 'adamant'
game 'gta5'

description "UG Jobs - Robert.#3454"

dependency "vrp"

ui_page 'web/index.html'

files{
    "web/**/*",
    -- vehicle
    "data/**/**/carcols.meta",
    "data/**/**/gtxd.meta",
    "data/**/**/handling.meta",
    "data/**/**/vehicles.meta",
    "data/**/**/vehiclelayouts.meta",
    "data/**/**/carvariations.meta"
}

client_scripts { 
	"@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"client/*.lua"
}

shared_script 'config.lua'

server_scripts { 
  "@vrp/lib/utils.lua",
  "server/*.lua"
}

data_file "GTXD_PARENTING_DATA" "data/**/**/gtxd.meta"
data_file "VEHICLE_LAYOUTS_FILE" "data/**/**/vehiclelayouts.meta"
data_file "HANDLING_FILE" "data/**/**/handling.meta"
data_file "CARCOLS_FILE" "data/**/**/carcols.meta"
data_file "CARCOLS_FILE" "data/dataRims/carcols.meta"
data_file "VEHICLE_METADATA_FILE" "data/**/**/vehicles.meta"
data_file "VEHICLE_VARIATION_FILE" "data/**/**/carvariations.meta"
