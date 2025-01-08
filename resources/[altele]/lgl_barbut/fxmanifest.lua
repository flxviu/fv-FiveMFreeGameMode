fx_version 'adamant'

game 'gta5'
lua54 'yes'

client_scripts {
	'@vrp/client/Proxy.lua',
	'@vrp/client/Tunnel.lua',

	'bb_c.lua',
}

server_scripts {
	'@vrp/lib/utils.lua',

	'bb_s.lua',
}

files {
	"index/bb_index.html",
	"index/bb_js.js",
	"index/option_1.png",
	"index/option_2.png",
	"index/option_3.png",
	"index/dice_1.png",
	"index/dice_2.png",
	"index/dice_3.png",
	"index/dice_4.png",
	"index/dice_5.png",
	"index/dice_6.png"
}

ui_page {
	'index/bb_index.html',
}