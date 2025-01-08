fx_version 'adamant'
game 'gta5'

description "Underground Ilegale - Robert.#3454"

dependency "vrp"

ui_page 'web/index.html'

files{
    "web/**/*",
}

client_scripts { 
	"@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"client.lua"
}

shared_script 'config.lua'

server_scripts { 
  "@vrp/lib/utils.lua",
  "server.lua"
}