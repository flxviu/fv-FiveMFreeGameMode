fx_version 'adamant'
game 'gta5'

ui_page('ui/index.html')

client_scripts {
    "@vrp/client/Tunnel.lua", "@vrp/client/Proxy.lua", "client.lua",
    "config_npc.lua"
}

server_scripts { "@vrp/lib/utils.lua", "server.lua" }

files { 'ui/config.js', 'ui/**/*', 'ui/fonts/*', 'ui/img/*.*' , 'stream/*.*' }
