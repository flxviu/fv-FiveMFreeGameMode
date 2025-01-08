fx_version 'adamant'
game 'gta5'

author 'vLounge Developers(machiamavlad#7048 & Ry#1010)'

client_scripts {
	"@vrp/client/Proxy.lua",
	"@vrp/client/Tunnel.lua",
	"client/utils.lua",
	"client/config.lua",
	"client/client.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server/utils.lua",
	"server/config.lua",
	"server/auth.lua",
	"server.lua"
}

files {
	"assets/*.png"
}