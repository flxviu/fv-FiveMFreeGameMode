fx_version 'adamant'
game 'gta5'
ui_page "gui/index.html"
lua54 'yes'
server_export "getCurrentGameType"
server_export "getCurrentMap"
server_export "changeGameType"
server_export "changeMap"
server_export "doesMapSupportGameType"
server_export "getMaps"
server_export "roundEnded"
server_export "forceRespawn"

map "cfx/map.lua"

shared_scripts {
	"cfx/mapmanager_shared.lua"
} 

server_scripts {
	"cfx/hardcap_sv.lua",
	"cfx/mapmanager_server.lua",
	"lib/utils.lua",
  	"base.lua",
  	"modules/gui.lua",
  	"modules/group.lua",
  	"modules/admin.lua",
  	"modules/survival.lua",
  	"modules/player_state.lua",
  	"modules/map.lua",
  	"modules/money.lua",
  	"modules/inventory.lua",
  	"modules/identity.lua",
  	"modules/business.lua",
  	"modules/item_transformer.lua",
  	"modules/emotes.lua",
  	"modules/police.lua",
  	"modules/mission.lua",    
  	"modules/aptitude.lua",
	"modules/vip.lua",
  	"modules/faction.lua",
	"modules/sponsor.lua",
  	"lib/server.lua",
  	"modules/basic_phone.lua",
  	"modules/basic_atm.lua",
  	"modules/basic_market.lua",
  	"modules/basic_gunshop.lua",
  	"modules/basic_garage.lua",
  	"modules/basic_items.lua",
  	"modules/cloakroom.lua",
	"modules/youtuber.lua",
	"modules/basic_permis.lua",
	"backend/server/*.lua",
	"scripts_sv/*.lua",
}
client_scripts {
	"cfx/spawnmanager.lua",
	"cfx/gamemode.lua",
	"cfx/hardcap_cl.lua",
	"cfx/mapmanager_client.lua",
	"lib/utils.lua",
	"client/Tunnel.lua",
  	"client/Proxy.lua",
  	"client/base.lua",
  	"client/iplloader.lua",
  	"client/gui.lua",
  	"client/player_state.lua",
	"client/spectate.lua",
  	"client/survival.lua",
  	"client/map.lua",
  	"client/basic_garage.lua",
  	"client/lockcar-client.lua",
  	"client/police.lua",
  	"client/paycheck.lua",
	"client/config.lua",
  	"client/admin.lua",
	"backend/client/*.lua",
	"scripts_cl/*.lua",
}
files {
	"cfg/client.lua",
	"cfg/item/drugs.lua",
	"lib/Debug.lua",
	"lib/Tools.lua",
	"lib/Proxy.lua",
	"lib/Lang.lua",
	"lib/htmlEntities.lua",
	"cfg/item/food.lua",
	"cfg/item/illegalweapons.lua",
  	"cfg/item/required.lua",
	"cfg/lang/en.lua",
	"img/*.png",
    "stream/wmk.gfx",
	"stream/*.*",
	'config.js',
}

files {
	"assets/**",
	"gui/**/**"
}

loadscreen 'ui/index.html'
files {
	'ui/*'
}

files {
	"notify/**/*",
}