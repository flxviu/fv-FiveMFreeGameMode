fx_version 'adamant'

game 'gta5'

client_script { 
    "@vrp/client/Tunnel.lua",
    "@vrp/client/Proxy.lua",
    "config.lua",
    "main/client.lua",
    "main/notify.lua"
}

server_script {
    "@vrp/lib/utils.lua",
    "main/server.lua",
    "config.lua"
} 

ui_page "html/index.html"

files {
    'html/index.html',
    'html/main.js',

    'html/assets/akrobat/*.eot',
    'html/assets/akrobat/*.ttf',
    'html/assets/akrobat/*.woff',
    
    'html/assets/akrobat/font.css',

    'html/assets/druk/*.eot',
    'html/assets/druk/*.ttf',
    'html/assets/druk/*.woff',
    'html/assets/druk/*.woff2',
    'html/assets/druk/stylesheet.css',

    'html/assets/Gilroy/*.eot',
    'html/assets/Gilroy/*.ttf',
    'html/assets/Gilroy/*.woff',
    'html/assets/Gilroy/*.woff2',

    'html/assets/Gilroy/font.css',

    'html/assets/img/*.png',
    'html/assets/img/*.svg',
    'html/assets/img/*.jpg',


    'html/assets/css/style.css',

}

lua54 'yes'