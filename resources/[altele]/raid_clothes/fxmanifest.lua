shared_script '@flv-register/ai_module_fg-obfuscated.lua'
shared_script '@flv-register/shared_fg-obfuscated.lua'
fx_version 'adamant'
game 'gta5'

server_scripts {
    '@vrp/lib/utils.lua',
    'server.lua'
}

client_scripts {
    '@vrp/client/Proxy.lua',
    'client/config.lua',
    'client/tatoos.lua',
    'client/skins.lua',
    'client/client.lua'
}

ui_page 'client/html/index.html'

files {
    'client/html/**/*'
}
