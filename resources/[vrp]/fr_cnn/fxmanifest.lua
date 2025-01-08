shared_script '@flv-register/ai_module_fg-obfuscated.lua'
shared_script '@flv-register/shared_fg-obfuscated.lua'




fx_version 'cerulean'
game 'gta5'
version 'v1.0'
description '1TAP Romania - CNN System'
ui_page "nui/index.html"
dependency "vrp"

client_scripts{ 
  '@vrp/client/tunnel.lua',
  '@vrp/client/Proxy.lua',
  "client.lua",
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua",
}

files {
  'nui/**/*',
}
