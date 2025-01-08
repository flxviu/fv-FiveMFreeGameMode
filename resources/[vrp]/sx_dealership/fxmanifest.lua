shared_script '@flv-register/ai_module_fg-obfuscated.lua'
shared_script '@flv-register/shared_fg-obfuscated.lua'


version '1.0.0'
author 'master'
decription 'sx_dealership'

ui_page "nui/index.html"
files {
	'nui/index.html',
	'nui/style.css',
    'nui/scripts.js',
}

client_scripts {
    "@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
    'config.lua',
    'client.lua',

}

server_scripts {
    "@vrp/lib/utils.lua",
    'config.lua',
    'server.lua',
}


game 'gta5'
fx_version 'adamant'
